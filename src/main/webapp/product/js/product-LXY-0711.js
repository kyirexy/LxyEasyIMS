// 全局变量
let currentPage = 1;
const pageSize = 10;

// 页面加载完成后执行
$(document).ready(function() {
    console.log('Document ready');
    loadProducts();
    initializeEventListeners();
    initializeModals();

    // 测试模态框是否正确初始化
    const productModal = document.getElementById('productModal');
    if (productModal) {
        console.log('Product modal found');
        const modal = new bootstrap.Modal(productModal);
        console.log('Modal initialized:', modal);
    }
});

// 初始化事件监听器
function initializeEventListeners() {
    console.log('Initializing event listeners');

    // 直接为新增产品链接添加点击事件
    $('#addProductLink').click(function(e) {
        console.log('Add product link clicked');
        e.preventDefault();
        showAddModal();
    });

    // 添加侧边栏导航事件处理
    $('.nav-link').click(function(e) {
        console.log('Nav link clicked:', $(this).data('page'));
        e.preventDefault();
        const page = $(this).data('page');

        // 移除所有活动状态
        $('.nav-link').removeClass('active');
        // 添加当前选中项的活动状态
        $(this).addClass('active');

        // 根据不同的页面执行相应的操作
        switch(page) {
            case 'add-product':
                console.log('Showing add modal');
                showAddModal();
                break;
            case 'product-list':
                loadProducts();
                break;
            case 'category-management':
                // 处理分类管理
                break;
            case 'import-products':
                // 处理产品导入
                break;
            case 'export-products':
                // 处理产品导出
                break;
        }
    });

    // 全选/取消全选
    $('#selectAll').change(function() {
        $('.product-checkbox').prop('checked', $(this).prop('checked'));
        updateBatchButtons();
    });

    // 搜索功能
    $('#searchBtn').click(function() {
        const searchText = $('#searchInput').val().trim();
        if (searchText) {
            searchProducts(searchText);
        } else {
            loadProducts();
        }
    });

    // 搜索框回车事件
    $('#searchInput').keypress(function(e) {
        if (e.which === 13) {
            $('#searchBtn').click();
        }
    });

    // 状态筛选
    $('.dropdown-item').click(function(e) {
        e.preventDefault();
        const status = $(this).text().trim();
        filterByStatus(status);
    });

    // 批量删除
    $('#batchDeleteBtn').click(function() {
        const selectedIds = getSelectedProductIds();
        if (selectedIds.length === 0) {
            showAlert('请选择要删除的商品', 'warning');
            return;
        }
        if (confirm('确定要删除选中的商品吗？')) {
            batchDeleteProducts(selectedIds);
        }
    });

    // 监听产品复选框变化
    $(document).on('change', '.product-checkbox', function() {
        updateBatchButtons();
    });
}

// 初始化模态框
function initializeModals() {
    console.log('Initializing modals');
    const productModal = document.getElementById('productModal');
    if (productModal) {
        console.log('Found product modal, initializing...');
        // 监听模态框关闭事件
        $('#productModal').on('hidden.bs.modal', function () {
            console.log('Modal hidden event triggered');
            $('#productForm')[0].reset();
            $('#productForm').removeClass('was-validated');
        });
    } else {
        console.error('Product modal not found in DOM');
    }
}

// 加载产品列表
function loadProducts() {
    console.log('Loading products...');
    $.ajax({
        url: 'products',
        method: 'GET',
        success: function(response) {
            console.log('Products loaded successfully');
            const products = JSON.parse(response);
            renderProductTable(products);
        },
        error: function(xhr) {
            console.error('Failed to load products:', xhr);
            showAlert('加载产品列表失败', 'danger');
        }
    });
}

// 渲染产品表格
function renderProductTable(products) {
    console.log('Rendering product table');
    const tbody = $('#productTableBody');
    tbody.empty();

    products.forEach(product => {
        tbody.append(`
            <tr>
                <td><input type="checkbox" class="product-checkbox" value="${product.id}"></td>
                <td>${product.imageUrl ? `<img src="${product.imageUrl}" class="product-image">` : '-'}</td>
                <td>${product.sku}</td>
                <td>${product.name}</td>
                <td>${product.brand || '-'}</td>
                <td>${product.categoryName}</td>
                <td>${product.supplier || '-'}</td>
                <td>￥${product.price.toFixed(2)}</td>
                <td><span class="badge ${getStatusClass(product.status)}">${getStatusText(product.status)}</span></td>
                <td>${formatDateTime(product.createdAt)}</td>
                <td>
                    <button class="btn btn-sm btn-primary" onclick="editProduct(${product.id})">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn btn-sm btn-danger" onclick="deleteProduct(${product.id})">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            </tr>
        `);
    });

    updateBatchButtons();
}

// 显示新增产品模态框
function showAddModal() {
    console.log('Showing add modal');
    const productModal = document.getElementById('productModal');
    if (productModal) {
        $('#productForm')[0].reset();
        $('#productModalTitle').text('新增产品');
        const modal = new bootstrap.Modal(productModal);
        modal.show();
        $('#productForm').removeClass('was-validated');
        $('#productModal .btn-primary').attr('onclick', 'saveProduct()');
    } else {
        console.error('Product modal element not found');
        showAlert('系统错误：模态框未找到', 'danger');
    }
}

// 保存产品（新增或更新）
function saveProduct() {
    console.log('Saving product...');
    const form = $('#productForm')[0];
    if (!form.checkValidity()) {
        console.log('Form validation failed');
        form.classList.add('was-validated');
        return;
    }

    const productData = getFormData('#productForm');
    const isEdit = productData.id ? true : false;
    console.log('Product data:', productData);

    $.ajax({
        url: isEdit ? `products?id=${productData.id}` : 'products',
        method: isEdit ? 'PUT' : 'POST',
        contentType: 'application/json',
        data: JSON.stringify(productData),
        success: function(response) {
            console.log('Product saved successfully');
            $('#productModal').modal('hide');
            showAlert(isEdit ? '更新成功' : '添加成功', 'success');
            loadProducts();
        },
        error: function(xhr) {
            console.error('Failed to save product:', xhr);
            showAlert((isEdit ? '更新' : '添加') + '失败：' + xhr.responseText, 'danger');
        }
    });
}
// 编辑产品
function editProduct(id) {
    $.ajax({
        url: `products?id=${id}`,
        method: 'GET',
        success: function(response) {
            const product = JSON.parse(response);
            fillProductForm(product);
            $('#productModalTitle').text('编辑产品');
            $('#productModal').modal('show');
            $('#productModal .btn-primary').attr('onclick', 'saveProduct()');
        },
        error: function(xhr) {
            showAlert('加载产品信息失败', 'danger');
        }
    });
}

// 删除产品
function deleteProduct(id) {
    if (confirm('确定要删除该商品吗？')) {
        $.ajax({
            url: `products?id=${id}`,
            method: 'DELETE',
            success: function() {
                showAlert('删除成功', 'success');
                loadProducts();
            },
            error: function(xhr) {
                showAlert('删除失败', 'danger');
            }
        });
    }
}

// 批量删除产品
function batchDeleteProducts(ids) {
    $.ajax({
        url: 'products/batch',
        method: 'DELETE',
        contentType: 'application/json',
        data: JSON.stringify(ids),
        success: function() {
            showAlert('批量删除成功', 'success');
            loadProducts();
        },
        error: function(xhr) {
            showAlert('批量删除失败', 'danger');
        }
    });
}

// 工具函数
function getFormData(formSelector) {
    const formData = {};
    const form = $(formSelector);

    form.find('input, select, textarea').each(function() {
        const input = $(this);
        const name = input.attr('name');
        if (name) {
            let value = input.val();
            if (input.attr('type') === 'number') {
                value = parseFloat(value);
            }
            formData[name] = value;
        }
    });

    return formData;
}

function fillProductForm(product) {
    const form = $('#productForm');
    Object.keys(product).forEach(key => {
        form.find(`[name="${key}"]`).val(product[key]);
    });
}

function getStatusClass(status) {
    switch (status) {
        case 'normal': return 'bg-success';
        case 'low': return 'bg-warning';
        case 'out': return 'bg-danger';
        default: return 'bg-secondary';
    }
}

function getStatusText(status) {
    switch (status) {
        case 'normal': return '正常';
        case 'low': return '库存紧张';
        case 'out': return '缺货';
        default: return status;
    }
}

function formatDateTime(timestamp) {
    if (!timestamp) return '-';
    const date = new Date(timestamp);
    return date.toLocaleString('zh-CN');
}

function showAlert(message, type) {
    const alertDiv = $(`
        <div class="alert alert-${type} alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    `);

    $('.main-content').prepend(alertDiv);
    setTimeout(() => alertDiv.alert('close'), 3000);
}

function getSelectedProductIds() {
    return $('.product-checkbox:checked').map(function() {
        return $(this).val();
    }).get();
}

function updateBatchButtons() {
    const selectedCount = $('.product-checkbox:checked').length;
    $('#batchDeleteBtn').prop('disabled', selectedCount === 0);
    $('#batchEditBtn').prop('disabled', selectedCount === 0);
}
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>产品管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/product/css/product-LXY-0711.css">
    <link href="https://cdn.bootcdn.net/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/product-management.css" rel="stylesheet">
    <style>
        .header {
            background-color: #343a40;
            color: white;
            padding: 1rem;
        }
        .sidebar {
            height: calc(100vh - 56px);
            background-color: #f8f9fa;
        }
        .sidebar a.nav-link {
            color: #343a40;
        }
        .sidebar a.nav-link.active {
            background-color: #e9ecef;
        }
        .table-responsive {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<!-- 标题栏 -->
<header class="header">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col">
                <i class="fas fa-boxes me-2"></i>产品管理系统
            </div>
            <div class="col-auto">
                <div class="dropdown">
                    <button class="btn btn-link text-white dropdown-toggle" type="button" data-bs-toggle="dropdown">
                        <i class="fas fa-user me-2"></i>管理员
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#"><i class="fas fa-user-cog me-2"></i>个人设置</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-sign-out-alt me-2"></i>退出登录</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="container-fluid">
    <div class="row">
        <!-- 侧边导航栏 -->
        <nav class="col-md-2 sidebar">
            <div class="position-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="#" data-page="product-list">
                            <i class="fas fa-list me-2"></i>产品列表
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-page="add-product">
                            <i class="fas fa-plus me-2"></i>新增产品
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-page="category-management">
                            <i class="fas fa-tags me-2"></i>产品分类
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-page="import-export">
                            <i class="fas fa-file-import me-2"></i>产品导入
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-page="import-export">
                            <i class="fas fa-file-export me-2"></i>产品导出
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- 主要内容区域 -->
        <main class="col-md-10 ms-sm-auto px-md-4">
            <!-- 工具栏 -->
            <div class="toolbar mb-4">
                <div class="row g-3 align-items-center">
                    <div class="col-auto">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary" onclick="showAddModal()">
                                <i class="fas fa-plus me-2"></i>新增产品
                            </button>
                            <button type="button" class="btn btn-success" onclick="importProducts()">
                                <i class="fas fa-file-import me-2"></i>导入
                            </button>
                            <button type="button" class="btn btn-info" onclick="exportProducts()">
                                <i class="fas fa-file-export me-2"></i>导出
                            </button>
                        </div>
                    </div>
                    <div class="col-auto">
                        <div class="btn-group">
                            <button type="button" class="btn btn-warning" id="batchEditBtn">
                                <i class="fas fa-edit me-2"></i>批量编辑
                            </button>
                            <button type="button" class="btn btn-danger" id="batchDeleteBtn">
                                <i class="fas fa-trash me-2"></i>批量删除
                            </button>
                        </div>
                    </div>
                    <div class="col">
                        <div class="input-group">
                            <input type="text" class="form-control" id="searchInput" placeholder="搜索产品...">
                            <button class="btn btn-outline-secondary" type="button" id="searchBtn">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-auto">
                        <div class="btn-group">
                            <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-bs-toggle="dropdown">
                                筛选
                            </button>
                            <ul class="dropdown-menu">
                                <li><h6 class="dropdown-header">库存状态</h6></li>
                                <li><a class="dropdown-item" href="#">充足</a></li>
                                <li><a class="dropdown-item" href="#">紧缺</a></li>
                                <li><a class="dropdown-item" href="#">缺货</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><h6 class="dropdown-header">销售状态</h6></li>
                                <li><a class="dropdown-item" href="#">上架</a></li>
                                <li><a class="dropdown-item" href="#">下架</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 产品表格 -->
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th><input type="checkbox" id="selectAll"></th>
                        <th>产品图片</th>
                        <th>SKU</th>
                        <th>产品名称</th>
                        <th>品牌</th>
                        <th>分类</th>
                        <th>供应商</th>
                        <th>价格</th>
                        <th>库存状态</th>
                        <th>销售状态</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="productTableBody">
                    <!-- 数据将通过JavaScript动态加载 -->
                    </tbody>
                </table>
            </div>

            <!-- 分页控件 -->
            <nav aria-label="Page navigation" class="d-flex justify-content-center">
                <ul class="pagination" id="pagination">
                    <!-- 分页将通过JavaScript动态加载 -->
                </ul>
            </nav>
        </main>
    </div>
</div>

<!-- 产品编辑模态框 -->
<div class="modal fade" id="productModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="productModalTitle">新增产品</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="productForm" class="needs-validation" novalidate>
                    <input type="hidden" name="id">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">产品名称</label>
                            <input type="text" class="form-control" name="name" required>
                            <div class="invalid-feedback">请输入产品名称</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">SKU</label>
                            <input type="text" class="form-control" name="sku" required>
                            <div class="invalid-feedback">请输入SKU</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">品牌</label>
                            <input type="text" class="form-control" name="brand">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">分类</label>
                            <div id="categorySelection">
                                <select class="form-select" name="categoryName" id="categorySelect" required>
                                    <option value="" disabled selected>请选择分类</option>
                                    <option value="1">电子产品</option>
                                    <option value="2">家居用品</option>
                                    <option value="3">服装服饰</option>
                                    <option value="4">食品饮料</option>
                                    <option value="5">书籍文具</option>
                                    <option value="6">运动户外</option>
                                    <option value="7">美妆护肤</option>
                                    <option value="other">其他（请填写）</option>
                                </select>
                            </div>
                            <div id="customCategoryInput" style="display: none; margin-top: 5px;">
                                <input type="text" class="form-control" name="customCategory" placeholder="请输入自定义分类">
                            </div>
                        </div>

                        <script>
                            document.addEventListener('DOMContentLoaded', function() {
                                const categorySelect = document.getElementById('categorySelect');
                                const customCategoryInputDiv = document.getElementById('customCategoryInput');

                                categorySelect.addEventListener('change', function() {
                                    if (this.value === 'other') {
                                        customCategoryInputDiv.style.display = 'block';
                                        this.required = false; // 允许不选择预定义分类
                                    } else {
                                        customCategoryInputDiv.style.display = 'none';
                                        this.required = true; // 确保选择了预定义分类
                                    }
                                });
                            });
                        </script>
                        <div class="col-md-6">
                            <label class="form-label">供应商</label>
                            <input type="text" class="form-control" name="supplier">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">价格</label>
                            <input type="number" class="form-control" name="price" step="0.01" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">描述</label>
                            <textarea class="form-control" name="description" rows="3"></textarea>
                        </div>

                        <!-- 图片上传 -->
                        <div class="col-12">
                            <label class="form-label">产品图片</label>
                            <div class="input-group">
                                <input type="file" class="form-control" name="image" accept="image/*">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="saveProduct()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 引入jQuery, Popper.js 和 Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>

<script>
    let currentPage = 1;
    const pageSize = 10;

    function loadProducts(page = 1) {
        currentPage = page;
        $.ajax({
            url: '${pageContext.request.contextPath}/product/products',
            method: 'GET',
            data: { 
                action: 'page', 
                page: page, 
                pageSize: pageSize 
            },
            success: function(response) {
                renderProductTable(response.data);
                updatePagination(response.totalPages, response.currentPage);
            },
            error: function(xhr) {
                alert('加载产品失败: ' + xhr.responseText);
            }
        });
    }

    function searchProducts() {
        const keyword = $('#searchInput').val();
        $.ajax({
            url: 'product/products',
            method: 'GET',
            data: { action: 'search', keyword: keyword },
            success: function(data) {
                $('#productTableBody').empty();
                data.forEach(function(product) {
                    let row = `<tr>
                                   <td><input type="checkbox" class="product-checkbox" data-id="${product.id}"></td>
                                   <td><img src="${product.image}" alt="${product.name}" width="50"></td>
                                   <td>${product.sku}</td>
                                   <td>${product.name}</td>
                                   <td>${product.brand}</td>
                                   <td>${product.categoryName}</td>
                                   <td>${product.supplier}</td>
                                   <td>${product.price}</td>
                                   <td>${product.stockStatus}</td>
                                   <td>${product.salesStatus}</td>
                                   <td>${product.createdAt}</td>
                                   <td>
                                       <button class="btn btn-info btn-sm" onclick="editProduct(${product.id})">编辑</button>
                                       <button class="btn btn-danger btn-sm" onclick="deleteProduct(${product.id})">删除</button>
                                   </td>
                               </tr>`;
                    $('#productTableBody').append(row);
                });
                $('#pagination').empty(); // Clear pagination on search
            },
            error: function(xhr) {
                alert('搜索产品失败: ' + xhr.responseText);
            }
        });
    }

    function updatePagination(totalPages, currentPage) {
        $('#pagination').empty();
        if (currentPage > 1) {
            let prevItem = `<li class="page-item"><a class="page-link" href="#" onclick="loadProducts(${currentPage - 1})">Previous</a></li>`;
            $('#pagination').append(prevItem);
        }
        if (currentPage < totalPages) {
            let nextItem = `<li class="page-item"><a class="page-link" href="#" onclick="loadProducts(${currentPage + 1})">Next</a></li>`;
            $('#pagination').append(nextItem);
        }
    }

    function editProduct(id) {
        $.ajax({
            url: 'product/products',
            method: 'GET',
            data: { action: 'getById', id: id },
            success: function(product) {
                $('#productModalTitle').text('编辑产品');
                $('#productForm input[name="name"]').val(product.name);
                $('#productForm input[name="sku"]').val(product.sku);
                $('#productForm input[name="brand"]').val(product.brand);
                $('#productForm select[name="categoryName"]').val(product.categoryName);
                $('#productForm input[name="supplier"]').val(product.supplier);
                $('#productForm input[name="price"]').val(product.price);
                $('#productForm textarea[name="description"]').val(product.description);
                $('#productForm input[name="id"]').val(product.id); // Assuming there's an ID field in the form
                $('#productModal').modal('show');
            },
            error: function(xhr) {
                alert('获取产品详情失败: ' + xhr.responseText);
            }
        });
    }

    function deleteProduct(id) {
        if (confirm('确定要删除此产品吗？')) {
            $.ajax({
                url: 'product/products?id=' + id,
                method: 'DELETE',
                success: function() {
                    alert('产品已成功删除');
                    loadProducts(currentPage);
                },
                error: function(xhr) {
                    alert('删除产品失败: ' + xhr.responseText);
                }
            });
        }
    }

    function showAddModal() {
        $('#productModalTitle').text('新增产品');
        $('#productForm')[0].reset();
        $('#productModal').modal('show');
    }

    function saveProduct() {
        const productData = {
            name: $('#productForm input[name="name"]').val(),
            sku: $('#productForm input[name="sku"]').val(),
            categoryName: $('#productForm select[name="categoryName"]').val(),
            brand: $('#productForm input[name="brand"]').val(),
            supplier: $('#productForm input[name="supplier"]').val(),
            price: parseFloat($('#productForm input[name="price"]').val()),
            description: $('#productForm textarea[name="description"]').val(),
            imageUrl: $('#productForm input[name="imageUrl"]').val() || null,
            status: 'active'
        };

        // 如果是编辑模式，添加ID
        const productId = $('#productForm input[name="id"]').val();
        if (productId) {
            productData.id = parseInt(productId);
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/product/products',
            method: productId ? 'PUT' : 'POST',
            contentType: 'application/json',
            data: JSON.stringify(productData),
            success: function(response) {
                alert('产品保存成功！');
                switchToProductList();
                loadProducts(currentPage);
            },
            error: function(xhr) {
                alert('保存失败：' + (xhr.responseJSON?.error || '未知错误'));
            }
        });
    }

    $(document).ready(function() {
        loadProducts();

        $('#selectAll').click(function() {
            $('.product-checkbox').prop('checked', this.checked);
        });

        $('#searchBtn').click(function() {
            searchProducts();
        });

        $('#batchDeleteBtn').click(function() {
            const selectedIds = [];
            $('.product-checkbox:checked').each(function() {
                selectedIds.push($(this).data('id'));
            });

            if (selectedIds.length === 0) {
                alert('请选择要删除的产品');
                return;
            }

            if (confirm('确定要删除这些产品吗？')) {
                $.ajax({
                    url: 'product/products?ids=' + selectedIds.join(','),
                    method: 'DELETE',
                    success: function() {
                        alert('产品已成功删除');
                        loadProducts(currentPage);
                    },
                    error: function(xhr) {
                        alert('删除产品失败: ' + xhr.responseText);
                    }
                });
            }
        });

        $('#productForm').on('submit', function(e) {
            e.preventDefault();
            if (this.checkValidity()) {
                saveProduct();
            }
            $(this).addClass('was-validated');
        });

        $('#saveProductBtn').on('click', function() {
            $('#productForm').submit();
        });
    });
</script>
</body>
</html>




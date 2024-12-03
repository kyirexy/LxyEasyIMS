<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2024/11/18
  Time: 10:46
  To change this template use File | Settings | File Templates.
--%>
<<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>库存管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.bootcdn.net/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* 标题栏样式 */
        .header {
            background-color: #1a237e;
            color: white;
            padding: 15px;
            font-size: 24px;
        }

        /* 侧边导航栏样式 */
        .sidebar {
            background-color: #f5f5f5;
            min-height: calc(100vh - 60px);
            padding: 20px 0;
        }

        .sidebar .nav-link {
            color: #333;
            padding: 10px 20px;
        }

        .sidebar .nav-link:hover {
            background-color: #ddd;
        }

        /* 主内容区域样式 */
        .main-content {
            padding: 20px;
        }

        /* 按钮样式 */
        .action-btn {
            margin-right: 10px;
        }

        /* 表格样式 */
        .table-responsive {
            margin-top: 20px;
        }

        /* 库存状态标签样式 */
        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
        }

        .status-low {
            background-color: #ff5252;
            color: white;
        }

        .status-normal {
            background-color: #4caf50;
            color: white;
        }
    </style>
</head>
<body>
<!-- 标题栏 -->
<div class="header">
    <i class="fas fa-warehouse me-2"></i>库存管理系统
</div>

<div class="container-fluid">
    <div class="row">
        <!-- 侧边导航栏 -->
        <div class="col-md-2 sidebar">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link active" href="#"><i class="fas fa-list me-2"></i>库存列表</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-plus me-2"></i>新增库存</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-search me-2"></i>库存查询</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-chart-bar me-2"></i>库存统计</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-clipboard-check me-2"></i>库存盘点</a>
                </li>
            </ul>
        </div>

        <!-- 主要内容区域 -->
        <div class="col-md-10 main-content">
            <!-- 操作按钮和搜索框 -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <button class="btn btn-primary action-btn" onclick="showAddModal()">
                        <i class="fas fa-plus"></i> 新增库存
                    </button>
                    <button class="btn btn-warning action-btn" id="batchEditBtn">
                        <i class="fas fa-edit"></i> 批量编辑
                    </button>
                    <button class="btn btn-danger action-btn" id="batchDeleteBtn">
                        <i class="fas fa-trash"></i> 批量删除
                    </button>
                </div>
                <div class="col-md-6">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="搜索库存...">
                        <button class="btn btn-outline-secondary" type="button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- 库存表格 -->
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th><input type="checkbox" id="selectAll"></th>
                        <th>SKU</th>
                        <th>商品名称</th>
                        <th>品牌</th>
                        <th>供应商</th>
                        <th>价格</th>
                        <th>状态</th>
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
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<!-- 新增/编辑商品模态框 -->
<div class="modal fade" id="productModal" tabindex="-1">
    <!-- 模态框内容将在需要时动态加载 -->
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<script>
    // JavaScript代码将在下一部分提供
</script>
</body>
</html>

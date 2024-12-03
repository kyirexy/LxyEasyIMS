<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2024/11/13
  Time: 23:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2ecc71;
            --background-color: #ecf0f1;
            --text-color: #34495e;
            --card-bg-color: #ffffff;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
        }

        .dashboard {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 250px;
            background-color: var(--primary-color);
            color: white;
            padding: 20px;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 30px;
            text-align: center;
        }

        .nav-menu {
            list-style-type: none;
        }

        .nav-item {
            margin-bottom: 15px;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .nav-link i {
            margin-right: 10px;
        }

        .main-content {
            flex-grow: 1;
            padding: 20px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .welcome-text {
            font-size: 24px;
            font-weight: 500;
        }

        .search-bar {
            display: flex;
            align-items: center;
            background-color: white;
            border-radius: 20px;
            padding: 5px 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .search-bar input {
            border: none;
            outline: none;
            padding: 5px;
            font-size: 16px;
        }

        .search-bar i {
            color: var(--text-color);
        }

        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background-color: var(--card-bg-color);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 500;
        }

        .card-icon {
            font-size: 24px;
            color: var(--primary-color);
        }

        .card-value {
            font-size: 28px;
            font-weight: bold;
        }

        .charts-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .chart-card {
            background-color: var(--card-bg-color);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .chart-title {
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 15px;
        }

        @media (max-width: 768px) {
            .dashboard {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                padding: 10px;
            }

            .charts-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="dashboard">
    <aside class="sidebar">
        <div class="logo">EasyIMS Admin</div>
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <i class="fas fa-home"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <i class="fas fa-users"></i>
                    Manage Users
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <i class="fas fa-user-tag"></i>
                    Manage Roles
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <i class="fas fa-box"></i>
                    Inventory
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <i class="fas fa-chart-bar"></i>
                    Reports
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <i class="fas fa-cog"></i>
                    Settings
                </a>
            </li>
        </ul>
    </aside>
    <main class="main-content">
        <header class="header">
            <h1 class="welcome-text">Welcome, Admin</h1>
            <div class="search-bar">
                <input type="text" placeholder="Search...">
                <i class="fas fa-search"></i>
            </div>
        </header>
        <section class="dashboard-cards">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Total Users</h2>
                    <i class="fas fa-users card-icon"></i>
                </div>
                <div class="card-value">1,234</div>
            </div>
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Active Products</h2>
                    <i class="fas fa-box card-icon"></i>
                </div>
                <div class="card-value">567</div>
            </div>
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Total Orders</h2>
                    <i class="fas fa-shopping-cart card-icon"></i>
                </div>
                <div class="card-value">890</div>
            </div>
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Revenue</h2>
                    <i class="fas fa-dollar-sign card-icon"></i>
                </div>
                <div class="card-value">$12,345</div>
            </div>
        </section>
        <section class="charts-container">
            <div class="chart-card">
                <h3 class="chart-title">User Growth</h3>
                <canvas id="userGrowthChart"></canvas>
            </div>
            <div class="chart-card">
                <h3 class="chart-title">Sales Overview</h3>
                <canvas id="salesOverviewChart"></canvas>
            </div>
        </section>
    </main>
</div>

<script>
    // User Growth Chart
    const userGrowthCtx = document.getElementById('userGrowthChart').getContext('2d');
    new Chart(userGrowthCtx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'New Users',
                data: [65, 59, 80, 81, 56, 55],
                borderColor: '#3498db',
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Sales Overview Chart
    const salesOverviewCtx = document.getElementById('salesOverviewChart').getContext('2d');
    new Chart(salesOverviewCtx, {
        type: 'bar',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'Sales',
                data: [12, 19, 3, 5, 2, 3],
                backgroundColor: '#2ecc71'
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
</body>
</html>
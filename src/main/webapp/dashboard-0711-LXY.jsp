<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2024/11/16
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>进销存管理系统 - 仪表板</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <link rel="stylesheet" href="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body, html {
      font-family: 'Arial', sans-serif;
      background: #f4f7fc;
      height: 100%;
      overflow-x: hidden;
    }
    .dashboard {
      display: flex;
      height: 100%;
    }
    .sidebar {
      width: 240px;
      background: #001529;
      color: #fff;
      padding: 20px;
      transition: all 0.3s;
    }
    .sidebar-header {
      font-size: 26px;
      font-weight: bold;
      margin-bottom: 40px;
      text-align: center;
      color: #1890ff;
    }
    .sidebar-menu {
      list-style-type: none;
    }
    .sidebar-menu li {
      margin-bottom: 18px;
    }
    .sidebar-menu a {
      color: #fff;
      text-decoration: none;
      display: flex;
      align-items: center;
      padding: 12px 15px;
      border-radius: 8px;
      transition: background 0.3s ease;
    }
    .sidebar-menu a:hover {
      background: #1890ff;
    }
    .sidebar-menu i {
      margin-right: 12px;
      font-size: 20px;
    }
    .main-content {
      flex: 1;
      padding: 30px;
      background: #fff;
      overflow-y: auto;
    }
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
    }
    .welcome-text {
      font-size: 28px;
      font-weight: bold;
    }
    .search-bar {
      display: flex;
      align-items: center;
      background: #fff;
      border-radius: 25px;
      padding: 8px 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .search-bar input {
      border: none;
      outline: none;
      padding: 8px;
      font-size: 16px;
      width: 200px;
    }
    .search-bar i {
      color: #999;
    }
    .dashboard-cards {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 30px;
      margin-bottom: 40px;
    }
    .card {
      background: #fff;
      border-radius: 12px;
      padding: 25px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      transition: transform 0.3s, box-shadow 0.3s;
    }
    .card:hover {
      transform: translateY(-8px);
      box-shadow: 0 6px 15px rgba(0,0,0,0.15);
    }
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }
    .card-title {
      font-size: 20px;
      font-weight: 500;
    }
    .card-icon {
      font-size: 28px;
      color: #1890ff;
    }
    .card-value {
      font-size: 32px;
      font-weight: bold;
      color: #333;
    }
    .charts-container {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 30px;
    }
    .chart-card {
      background: #fff;
      border-radius: 12px;
      padding: 25px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    .chart-title {
      font-size: 20px;
      font-weight: 500;
      margin-bottom: 20px;
    }
    #particles-js {
      position: fixed;
      width: 100%;
      height: 100%;
      z-index: -1;
    }
    @media (max-width: 768px) {
      .dashboard {
        flex-direction: column;
      }
      .sidebar {
        width: 100%;
        padding: 15px;
      }
      .charts-container {
        grid-template-columns: 1fr;
      }
      .main-content {
        padding: 20px;
      }
    }
  </style>
</head>
<body>
<div id="particles-js"></div>
<div class="dashboard">
  <aside class="sidebar">
    <div class="sidebar-header">进销存管理系统</div>
    <ul class="sidebar-menu">
      <li><a href="#"><i class="fas fa-tachometer-alt"></i>仪表板</a></li>
      <li><a href="inventory/inventory-LXY-0711.jsp"><i class="fas fa-box"></i>库存管理</a></li>
      <li><a href="product/product-LXY-0711.jsp"><i class="fas fa-box"></i>产品管理</a></li>
      <li><a href="#"><i class="fas fa-shopping-cart"></i>销售管理</a></li>
      <li><a href="#"><i class="fas fa-truck"></i>采购管理</a></li>
      <li><a href="#"><i class="fas fa-chart-bar"></i>报表分析</a></li>
      <li><a href="#"><i class="fas fa-cog"></i>系统设置</a></li>
    </ul>
  </aside>
  <main class="main-content">
    <header class="header">
      <h1 class="welcome-text">欢迎回来，管理员</h1>
      <div class="search-bar">
        <input type="text" placeholder="搜索...">
        <i class="fas fa-search"></i>
      </div>
    </header>
    <section class="dashboard-cards">
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">总库存</h2>
          <i class="fas fa-box card-icon"></i>
        </div>
        <div class="card-value">5,678</div>
      </div>
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">本月销售额</h2>
          <i class="fas fa-chart-line card-icon"></i>
        </div>
        <div class="card-value">¥89,456</div>
      </div>
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">待处理订单</h2>
          <i class="fas fa-clipboard-list card-icon"></i>
        </div>
        <div class="card-value">23</div>
      </div>
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">低库存警告</h2>
          <i class="fas fa-exclamation-triangle card-icon"></i>
        </div>
        <div class="card-value">7</div>
      </div>
    </section>
    <section class="charts-container">
      <div class="chart-card">
        <h3 class="chart-title">月度销售趋势</h3>
        <canvas id="salesChart"></canvas>
      </div>
      <div class="chart-card">
        <h3 class="chart-title">库存分类占比</h3>
        <canvas id="inventoryChart"></canvas>
      </div>
    </section>
  </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
<script>
  // 粒子背景配置
  particlesJS('particles-js', {
    particles: {
      number: { value: 80, density: { enable: true, value_area: 800 } },
      color: { value: "#1890ff" },
      shape: { type: "circle" },
      opacity: { value: 0.5, random: true },
      size: { value: 3, random: true },
      line_linked: { enable: true, distance: 150, color: "#1890ff", opacity: 0.4, width: 1 }
    },
    interactivity: {
      detect_on: "canvas",
      events: {
        onhover: { enable: true, mode: "repulse" },
        onclick: { enable: true, mode: "push" }
      }
    }
  });

  // 图表配置
  const salesChartCtx = document.getElementById('salesChart').getContext('2d');
  const salesChart = new Chart(salesChartCtx, {
    type: 'line',
    data: {
      labels: ['1月', '2月', '3月', '4月', '5月', '6月'],
      datasets: [{
        label: '销售额',
        data: [12000, 15000, 17000, 20000, 25000, 30000],
        borderColor: '#1890ff',
        backgroundColor: 'rgba(24, 144, 255, 0.1)',
        fill: true,
        tension: 0.4
      }]
    },
    options: {
      responsive: true,
      scales: { y: { beginAtZero: true } },
      plugins: { legend: { position: 'top' } }
    }
  });

  const inventoryChartCtx = document.getElementById('inventoryChart').getContext('2d');
  const inventoryChart = new Chart(inventoryChartCtx, {
    type: 'pie',
    data: {
      labels: ['电子产品', '家具', '日用百货', '食品'],
      datasets: [{
        data: [300, 50, 100, 80],
        backgroundColor: ['#1890ff', '#ff5733', '#33c4ff', '#c3e6ff']
      }]
    }
  });
</script>
</body>
</html>

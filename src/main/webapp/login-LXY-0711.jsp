<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EasyIMS 登录</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            height: 100%;
            overflow: hidden;
        }
        #particles-js {
            position: absolute;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, #1a1a2e, #16213e, #0f3460);
            z-index: -1;
        }
        .navbar {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 15px 20px;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .navbar h1 {
            margin: 0;
            color: #333;
            font-size: 1.5em;
            display: flex;
            align-items: center;
        }
        .navbar h1 i {
            margin-right: 10px;
            font-size: 1.8em;
        }
        .navbar ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
        }
        .navbar li {
            margin-left: 20px;
        }
        .navbar a {
            color: #333;
            text-decoration: none;
            font-size: 1em;
            transition: color 0.3s ease, background-color 0.3s ease;
            padding: 8px 12px;
            border-radius: 4px;
        }
        .navbar a:hover {
            background-color: rgba(0, 0, 0, 0.1);
        }
        .navbar a:focus {
            outline: 2px solid #007BFF;
            outline-offset: 2px;
        }
        .navbar .menu-toggle {
            display: none;
            cursor: pointer;
        }
        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
            color: white;
            padding: 0 20px;
        }
        h1 {
            font-size: 3em;
            margin-bottom: 20px;
            animation: fadeInDown 1s ease-out;
        }
        p {
            font-size: 1.2em;
            margin-bottom: 30px;
            animation: fadeIn 1s ease-out 0.5s both;
        }
        .cta-buttons {
            animation: fadeIn 1s ease-out 1s both;
        }
        .cta-buttons button {
            padding: 12px 24px;
            margin: 0 10px;
            font-size: 1em;
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .cta-buttons button:first-child {
            background-color: #007BFF;
        }
        .cta-buttons button:last-child {
            background-color: #28a745;
        }
        .cta-buttons button:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: rgba(255, 255, 255, 0.9);
            color: #333;
            text-align: center;
            padding: 10px 0;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
        }
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .login-form {
            background: rgba(0, 0, 0, 0.6);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.18);
            width: 100%;
            max-width: 400px;
            transform: translateY(20px);
            opacity: 0;
            animation: fadeIn 0.8s ease-out forwards;
        }
        .login-form h1 {
            margin-bottom: 30px;
            font-size: 2.5rem;
            color: #fff;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }
        .login-form input {
            width: 100%;
            padding: 15px;
            margin-bottom: 20px;
            border: none;
            border-radius: 50px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        .login-form input:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.2);
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
        }
        .login-form button {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 50px;
            background: linear-gradient(45deg, #00a1ff, #00ff8f);
            color: white;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            font-weight: bold;
            letter-spacing: 1px;
        }
        .login-form button:hover {
            background: linear-gradient(45deg, #00ff8f, #00a1ff);
            box-shadow: 0 5px 15px rgba(0, 255, 143, 0.4);
            transform: translateY(-2px);
        }
        .login-form .error-message {
            color: #ff6b6b;
            font-size: 0.9rem;
            margin-bottom: 15px;
            text-align: center;
        }
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1001;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        /* Responsive design */
        @media (max-width: 768px) {
            .navbar ul {
                display: none;
                flex-direction: column;
                width: 100%;
                background-color: rgba(255, 255, 255, 0.9);
                position: absolute;
                top: 60px;
                left: 0;
                padding: 10px 0;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .navbar ul.show {
                display: flex;
            }
            .navbar li {
                margin: 10px 0;
                text-align: center;
            }
            .navbar .menu-toggle {
                display: block;
            }
        }
    </style>
</head>
<body>
<div id="particles-js"></div>
<div class="navbar">
    <h1><i class="fas fa-building"></i>EasyIMS</h1>
    <div class="menu-toggle" id="mobile-menu">
        <span class="bar"></span>
        <span class="bar"></span>
        <span class="bar"></span>
    </div>
    <ul id="nav-list">
        <li><a href="home-LXY-0711.jsp"><i class="fas fa-home"></i> 首页</a></li>
        <li><a href="#" id="aboutUsLink"><i class="fas fa-info-circle"></i> 关于我们</a></li>
    </ul>
</div>
<div class="container">
    <div class="login-form">
        <h1>欢迎使用</h1>
        <div id="errorMessage" class="error-message"></div>
        <form id="loginForm">
            <input type="text" id="username" name="username" placeholder="用户名" required>
            <input type="password" id="password" name="password" placeholder="密码" required>
            <button type="submit">登录</button>
        </form>
        <p><a href="register-LXY-0711.jsp">还没有账户？立即注册</a></p>
    </div>
</div>
<footer>
    © 2024 EasyIMS. 317版权所有。
</footer>

<!-- The Modal -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>关于我们</h2>
        <p>EasyIMS 是一个致力于提供高效管理解决方案的平台。我们的团队由经验丰富的开发者组成，专注于创建用户友好的界面和稳健的系统。</p>
        <!-- 添加更多信息 -->
    </div>
</div>

<script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
<script>
    // Function to initialize particles.js
    function initParticlesJS() {
        if (typeof(particlesJS) !== 'undefined') {
            particlesJS.load('particles-js', 'https://cdn.jsdelivr.net/npm/particles.js@2.0.0/demo/particles.json', function() {
                console.log('callback - particles.js config loaded');
            });
        } else {
            console.error('particlesJS is not defined');
        }
    }

    // Form submission
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        // Here you would typically send a request to your server for authentication
        // For demonstration purposes, we assume the login is successful and redirect
        if (username && password) { // Simple check for non-empty fields
            window.location.href = 'dashboard-0711-LXY.jsp'; // Redirect to dashboard page
        } else {
            document.getElementById('errorMessage').textContent = '请输入用户名和密码。';
            document.getElementById('errorMessage').style.color = '#ff6b6b';
        }
    });

    // Get the modal
    var modal = document.getElementById("myModal");

    // Get the button that opens the modal
    var btn = document.getElementById("aboutUsLink");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    // Open the modal when "About Us" is clicked
    btn.onclick = function(e) {
        e.preventDefault();
        modal.style.display = "block";
    }

    // Initialize particles.js after the script has loaded
    document.addEventListener('DOMContentLoaded', function() {
        initParticlesJS();
    });

    // Toggle mobile menu
    const mobileMenu = document.getElementById('mobile-menu');
    const navList = document.getElementById('nav-list');

    mobileMenu.addEventListener('click', function() {
        navList.classList.toggle('show');
    });
</script>
</body>
</html>




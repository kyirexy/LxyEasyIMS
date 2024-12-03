<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2024/11/13
  Time: 23:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/styles-LXY-0711.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1a1a2e;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            justify-content: center;
            align-items: center;
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
            list-style-type: none;
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

        .container {
            background: rgba(0, 0, 0, 0.6);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.18);
            max-width: 350px;
            width: 100%;
            text-align: center;
            transform: translateY(20px);
            opacity: 0;
            animation: fadeIn 0.8s ease-out forwards;
        }

        h1 {
            color: #fff;
            margin-bottom: 30px;
            font-size: 2.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #ddd;
            font-weight: bold;
        }

        .form-group input {
            width: calc(100% - 40px); /* Adjusted for icons */
            padding: 15px 20px;
            margin-bottom: 10px;
            border: none;
            border-radius: 50px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            font-size: 1rem;
            transition: all 0.3s ease;
            position: relative;
            padding-left: 45px;
        }

        .form-group input:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.2);
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
        }

        .form-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #ccc;
        }

        button {
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

        button:hover {
            background: linear-gradient(45deg, #00ff8f, #00a1ff);
            box-shadow: 0 5px 15px rgba(0, 255, 143, 0.4);
            transform: translateY(-2px);
        }

        .alert {
            margin-top: 20px;
            padding: 15px;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            border-radius: 20px;
            text-align: center;
            animation: fadeIn 1s ease-out 0.5s both;
        }

        footer {
            background-color: rgba(255, 255, 255, 0.9);
            color: #333;
            text-align: center;
            padding: 10px 0;
            position: relative;
            bottom: 0;
            width: 100%;
            margin-top: 20px;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>
<div class="navbar">
    <h1><i class="fas fa-building"></i>EasyIMS</h1>
    <ul>
        <li><a href="home-LXY-0711.jsp"><i class="fas fa-home"></i> 首页</a></li>
        <li><a href="login-LXY-0711.jsp"><i class="fas fa-sign-in-alt"></i> 登录</a></li>
        <li><a href="register-LXY-0711.jsp"><i class="fas fa-user-plus"></i> 注册</a></li>
    </ul>
</div>

<div class="container">
    <h1>注册</h1>

    <form id="register-form" action="/register" method="post" onsubmit="return validateRegisterForm()">
        <div class="form-group">
            <label for="username">用户名:</label>
            <i class="fas fa-user"></i>
            <input type="text" id="username" name="username" placeholder="用户名" required>
        </div>
        <div class="form-group">
            <label for="email">邮箱:</label>
            <i class="fas fa-envelope"></i>
            <input type="email" id="email" name="email" placeholder="邮箱" required>
        </div>
        <div class="form-group">
            <label for="password">密码:</label>
            <i class="fas fa-lock"></i>
            <input type="password" id="password" name="password" placeholder="密码" required>
        </div>
        <button type="submit">注册</button>
    </form>
</div>

<footer>
    &copy; 2024 EasyIMS. 317版权所有。
</footer>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/script-LXY-0711.js"></script>
<script>
    function validateRegisterForm() {
        const username = document.getElementById('username').value;
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        if (!username || !email || !password) {
            alert('请填写所有字段。');
            return false;
        }

        // Additional validation can be added here

        return true;
    }
</script>
</body>
</html>




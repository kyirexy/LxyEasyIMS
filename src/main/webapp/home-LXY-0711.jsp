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
    <title>EasyIMS System - Home</title>
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
            background-color: rgba(0, 0, 0, 0.5);
            padding: 15px 0;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }
        .navbar ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .navbar li {
            display: inline;
            margin: 0 15px;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            transition: color 0.3s ease;
        }
        .navbar a:hover {
            color: #007BFF;
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
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            text-align: center;
            padding: 10px 0;
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
    </style>
</head>
<body>
<div id="particles-js"></div>

<%--<nav class="navbar">
    <ul>
        <li><a href="home-LXY-0711.jsp">Home</a></li>
        <li><a href="login-LXY-0711.jsp">Login</a></li>
        <li><a href="register-LXY-0711.jsp">Register</a></li>
    </ul>
</nav>--%>

<div class="container">
    <h1>欢迎使用EasyIMS系统</h1>
    <p>用我们的直观解决方案简化您的库存管理。</p>
    <div class="cta-buttons">
        <button style="background-color: #4CAF50; color: white; padding: 10px 20px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; margin: 4px 2px; cursor: pointer; border-radius: 8px;" onclick="window.location.href='login-LXY-0711.jsp'">登录</button>
        <button style="background-color: #555555; color: white; padding: 10px 20px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; margin: 4px 2px; cursor: pointer; border-radius: 8px;" onclick="window.location.href='register-LXY-0711.jsp'">注册</button>
    </div>
</div>

<footer>
    &copy; 2024 进销存管理系统317. All rights reserved(版权所有).
</footer>

<script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
<script>
    particlesJS('particles-js', {
        particles: {
            number: { value: 80, density: { enable: true, value_area: 800 } },
            color: { value: "#ffffff" },
            shape: { type: "circle" },
            opacity: { value: 0.5, random: true },
            size: { value: 3, random: true },
            line_linked: { enable: true, distance: 150, color: "#ffffff", opacity: 0.4, width: 1 },
            move: { enable: true, speed: 2, direction: "none", random: true, straight: false, out_mode: "out" }
        },
        interactivity: {
            detect_on: "canvas",
            events: { onhover: { enable: true, mode: "repulse" }, onclick: { enable: true, mode: "push" } },
            modes: { repulse: { distance: 100, duration: 0.4 }, push: { particles_nb: 4 } }
        },
        retina_detect: true
    });
</script>
</body>
</html>
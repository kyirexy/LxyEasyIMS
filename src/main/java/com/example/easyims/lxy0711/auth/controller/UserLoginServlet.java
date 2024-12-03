package com.example.easyims.lxy0711.auth.controller;

import com.example.easyims.lxy0711.auth.dao.UserDAO;
import com.example.easyims.lxy0711.auth.domain.po.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class UserLoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 表单验证：检查是否为空
        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            response.getWriter().write("Username and password are required!");
            return;
        }

        // 验证用户名和密码
        boolean isPasswordValid = userDAO.validateUserPassword(username, password);
        if (!isPasswordValid) {
            response.getWriter().write("Invalid username or password!");
            return;
        }

        // 查找用户信息
        User user = userDAO.findUserByUsername(username);

        if (user != null) {
            // 将用户信息存储到 session 中
            HttpSession session = request.getSession();
            session.setAttribute("user", user);  // 存储用户信息到 session

            // 登录成功后跳转到管理员控制面板页面
            response.sendRedirect("admin-dashboard-LXY-0711.jsp"); // 登录成功后重定向到管理员控制面板
        } else {
            response.getWriter().write("User not found!");
        }
    }
}

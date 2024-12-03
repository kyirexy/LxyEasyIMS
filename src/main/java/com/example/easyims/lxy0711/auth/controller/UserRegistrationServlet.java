package com.example.easyims.lxy0711.auth.controller;

import com.example.easyims.lxy0711.auth.dao.UserDAO;
import com.example.easyims.lxy0711.auth.dao.RoleDAO;
import com.example.easyims.lxy0711.auth.domain.po.User;
import com.example.easyims.lxy0711.auth.domain.po.Role;
import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;

@WebServlet("/register")
public class UserRegistrationServlet extends HttpServlet {

    private UserDAO userDAO;
    private RoleDAO roleDAO;
    private Argon2 argon2;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
        roleDAO = new RoleDAO();
        argon2 = Argon2Factory.create(); // 初始化 Argon2 实例
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        // 表单验证：检查是否为空
        if (username == null || password == null || email == null || username.isEmpty() || password.isEmpty() || email.isEmpty()) {
            response.getWriter().write("All fields are required!");
            return;
        }

        // 检查用户名是否已经存在
        if (userDAO.findUserByUsername(username) != null) {
            response.getWriter().write("Username already exists!");
            return;
        }

        // 创建用户对象
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);  // 密码将在 DAO 中加密
        user.setEmail(email);

        // 选择角色（比如设置为“普通用户”角色）
        Role userRole = roleDAO.findRoleByName("user"); // 默认角色为 "user"
        if (userRole == null) {
            response.getWriter().write("Role not found!");
            return;
        }
        user.setRoles(Arrays.asList(userRole));  // 设置用户角色

        // 添加用户到数据库
        boolean isUserAdded = userDAO.addUser(user);
        if (isUserAdded) {
            response.sendRedirect("login-LXY-0711.jsp");  // 注册成功后重定向到登录页面
        } else {
            response.getWriter().write("User registration failed!");
        }
    }
}

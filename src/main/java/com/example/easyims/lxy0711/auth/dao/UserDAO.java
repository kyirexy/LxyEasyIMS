package com.example.easyims.lxy0711.auth.dao;

import com.example.easyims.lxy0711.auth.domain.po.User;
import com.example.easyims.lxy0711.auth.domain.po.Role;
import com.example.easyims.lxy0711.auth.util.DatabaseConnectionPool;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private DatabaseConnectionPool connectionPool;

    public UserDAO() {
        connectionPool = DatabaseConnectionPool.getInstance();
    }

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据用户名查找用户
     * @param username 用户名
     * @return User 对象，如果找不到用户返回 null
     */
    public User findUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection connection = connectionPool.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet resultSet = stmt.executeQuery();

            if (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getLong("id"));
                user.setUsername(resultSet.getString("username"));
                user.setPassword(resultSet.getString("password"));
                user.setEmail(resultSet.getString("email"));
                user.setCreatedAt(resultSet.getTimestamp("created_at"));
                user.setRoles(findRolesByUserId(user.getId())); // 查找该用户的角色
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据用户ID查找该用户的角色
     * @param userId 用户ID
     * @return List<Role> 该用户的角色列表
     */
    private List<Role> findRolesByUserId(Long userId) {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT r.id, r.role_name FROM roles r " +
                "JOIN user_roles ur ON r.id = ur.role_id WHERE ur.user_id = ?";
        try (Connection connection = connectionPool.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setLong(1, userId);
            ResultSet resultSet = stmt.executeQuery();

            while (resultSet.next()) {
                Role role = new Role();
                role.setId(resultSet.getLong("id"));
                role.setRoleName(resultSet.getString("role_name"));
                roles.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }

    /**
     * 根据用户名验证密码是否正确
     * @param username 用户名
     * @param rawPassword 用户输入的原始密码
     * @return boolean，验证结果
     */
    public boolean validateUserPassword(String username, String rawPassword) {
        User user = findUserByUsername(username);
        if (user != null) {
            String storedPassword = user.getPassword();
            System.out.println("Stored Password: " + storedPassword);
            System.out.println("Raw Password: " + rawPassword);

            // 使用 bcrypt 验证密码
            boolean isValid = BCrypt.checkpw(rawPassword, storedPassword);
            System.out.println("Password Valid: " + isValid);
            return isValid;
        } else {
            System.out.println("User not found: " + username);
        }

        return false;
    }

    /**
     * 添加新用户（包括密码加密）
     * @param user 要添加的用户对象
     * @return boolean，true表示成功，false表示失败
     */
    public boolean addUser(User user) {
        String sql = "INSERT INTO users (username, password, email) VALUES (?, ?, ?)";
        try (Connection connection = connectionPool.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // 使用 bcrypt 对密码进行加密
            String encryptedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

            stmt.setString(1, user.getUsername());
            stmt.setString(2, encryptedPassword);
            stmt.setString(3, user.getEmail());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        long userId = generatedKeys.getLong(1);
                        user.setId(userId);
                        // 添加用户角色（默认角色）
                        addUserRoles(userId, user.getRoles());
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 为用户添加角色
     * @param userId 用户ID
     * @param roles 用户的角色列表
     */
    private void addUserRoles(Long userId, List<Role> roles) {
        String sql = "INSERT INTO user_roles (user_id, role_id) VALUES (?, ?)";
        try (Connection connection = connectionPool.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            for (Role role : roles) {
                stmt.setLong(1, userId);
                stmt.setLong(2, role.getId());
                stmt.addBatch();
            }
            stmt.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
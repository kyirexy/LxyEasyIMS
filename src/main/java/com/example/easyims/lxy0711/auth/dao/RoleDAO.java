package com.example.easyims.lxy0711.auth.dao;

import com.example.easyims.lxy0711.auth.domain.po.Role;
import com.example.easyims.lxy0711.auth.util.DatabaseConnectionPool;

import java.sql.*;

public class RoleDAO {

    private DatabaseConnectionPool connectionPool;

    public RoleDAO() {
        connectionPool = DatabaseConnectionPool.getInstance();
    }
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            //System.out.println("MySQL JDBC Driver Registered!");
        } catch (ClassNotFoundException e) {
            //System.out.println("Where is your MySQL JDBC Driver?");
            e.printStackTrace();
        }
    }
    /**
     * 根据角色名称查找角色
     * @param roleName 角色名称
     * @return Role 对象，如果找不到角色返回 null
     */
    public Role findRoleByName(String roleName) {
        String sql = "SELECT * FROM roles WHERE role_name = ?";
        try (Connection connection = connectionPool.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, roleName);
            ResultSet resultSet = stmt.executeQuery();

            if (resultSet.next()) {
                Role role = new Role();
                role.setId(resultSet.getLong("id"));
                role.setRoleName(resultSet.getString("role_name"));
                return role;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据角色ID查找角色
     * @param roleId 角色ID
     * @return Role 对象，如果找不到角色返回 null
     */
    public Role findRoleById(Long roleId) {
        String sql = "SELECT * FROM roles WHERE id = ?";
        try (Connection connection = connectionPool.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setLong(1, roleId);
            ResultSet resultSet = stmt.executeQuery();

            if (resultSet.next()) {
                Role role = new Role();
                role.setId(resultSet.getLong("id"));
                role.setRoleName(resultSet.getString("role_name"));
                return role;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 添加新角色
     * @param role 角色对象
     * @return boolean，true表示成功，false表示失败
     */
    public boolean addRole(Role role) {
        String sql = "INSERT INTO roles (role_name) VALUES (?)";
        try (Connection connection = connectionPool.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, role.getRoleName());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0; // 如果插入成功，返回 true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // 如果插入失败，返回 false
    }
}

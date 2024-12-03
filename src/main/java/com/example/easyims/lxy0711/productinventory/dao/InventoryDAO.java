package com.example.easyims.lxy0711.productinventory.dao;

import com.example.easyims.lxy0711.productinventory.model.Inventory;
import com.example.easyims.lxy0711.productinventory.util.DatabaseConnectionPool;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InventoryDAO {

    private final DatabaseConnectionPool connectionPool;

    public InventoryDAO() {
        this.connectionPool = DatabaseConnectionPool.getInstance();
    }

    // 获取所有库存记录
    public List<Inventory> getAllInventories() throws SQLException {
        List<Inventory> inventories = new ArrayList<>();
        String query = "SELECT * FROM inventory";
        try (Connection conn = connectionPool.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Inventory inventory = mapResultSetToInventory(rs);
                inventories.add(inventory);
            }
        }
        return inventories;
    }

    // 根据ID获取单个库存记录
    public Inventory getInventoryById(int id) throws SQLException {
        String query = "SELECT * FROM inventory WHERE id = ?";
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToInventory(rs);
                }
            }
        }
        return null;
    }

    // 插入新的库存记录
    public int insertInventory(Inventory inventory) throws SQLException {
        String query = "INSERT INTO inventory (product_id, quantity, warehouse, threshold, created_at, updated_at) VALUES (?, ?, ?, ?, NOW(), NOW())";
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setInt(1, inventory.getProductId());
            pstmt.setInt(2, inventory.getQuantity());
            pstmt.setString(3, inventory.getWarehouse());
            pstmt.setInt(4, inventory.getThreshold());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Inserting inventory failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Inserting inventory failed, no ID obtained.");
                }
            }
        }
    }

    // 更新库存记录
    public boolean updateInventory(Inventory inventory) throws SQLException {
        String query = "UPDATE inventory SET product_id = ?, quantity = ?, warehouse = ?, threshold = ?, updated_at = NOW() WHERE id = ?";
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, inventory.getProductId());
            pstmt.setInt(2, inventory.getQuantity());
            pstmt.setString(3, inventory.getWarehouse());
            pstmt.setInt(4, inventory.getThreshold());
            pstmt.setInt(5, inventory.getId());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    // 删除库存记录
    public boolean deleteInventory(int id) throws SQLException {
        String query = "DELETE FROM inventory WHERE id = ?";
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    // 辅助方法：将ResultSet映射到Inventory对象
    private Inventory mapResultSetToInventory(ResultSet rs) throws SQLException {
        Inventory inventory = new Inventory();
        inventory.setId(rs.getInt("id"));
        inventory.setProductId(rs.getInt("product_id"));
        inventory.setQuantity(rs.getInt("quantity"));
        inventory.setWarehouse(rs.getString("warehouse"));
        inventory.setThreshold(rs.getInt("threshold"));
        inventory.setCreatedAt(rs.getTimestamp("created_at"));
        inventory.setUpdatedAt(rs.getTimestamp("updated_at"));
        return inventory;
    }
}







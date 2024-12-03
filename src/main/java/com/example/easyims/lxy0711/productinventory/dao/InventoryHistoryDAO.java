package com.example.easyims.lxy0711.productinventory.dao;

import com.example.easyims.lxy0711.productinventory.model.InventoryHistory;
import com.example.easyims.lxy0711.productinventory.util.DatabaseConnectionPool;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InventoryHistoryDAO {

    private final DatabaseConnectionPool connectionPool;

    public InventoryHistoryDAO() {
        this.connectionPool = DatabaseConnectionPool.getInstance();
    }

    // 获取所有库存变动历史记录
    public List<InventoryHistory> getAllInventoryHistories() throws SQLException {
        List<InventoryHistory> histories = new ArrayList<>();
        String query = "SELECT * FROM inventory_history";
        try (Connection conn = connectionPool.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                InventoryHistory history = mapResultSetToInventoryHistory(rs);
                histories.add(history);
            }
        }
        return histories;
    }

    // 根据ID获取单个库存变动历史记录
    public InventoryHistory getInventoryHistoryById(int id) throws SQLException {
        String query = "SELECT * FROM inventory_history WHERE id = ?";
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToInventoryHistory(rs);
                }
            }
        }
        return null;
    }

    // 插入新的库存变动历史记录
    public int insertInventoryHistory(InventoryHistory history) throws SQLException {
        String query = "INSERT INTO inventory_history (inventory_id, change_type, quantity, reason, user_id, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setInt(1, history.getInventoryId());
            pstmt.setString(2, history.getChangeType());
            pstmt.setInt(3, history.getQuantity());
            pstmt.setString(4, history.getReason());
            pstmt.setLong(5, history.getUserId());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Inserting inventory history failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Inserting inventory history failed, no ID obtained.");
                }
            }
        }
    }

    // 更新库存变动历史记录
    public boolean updateInventoryHistory(InventoryHistory history) throws SQLException {
        String query = "UPDATE inventory_history SET inventory_id = ?, change_type = ?, quantity = ?, reason = ?, user_id = ? WHERE id = ?";
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, history.getInventoryId());
            pstmt.setString(2, history.getChangeType());
            pstmt.setInt(3, history.getQuantity());
            pstmt.setString(4, history.getReason());
            pstmt.setLong(5, history.getUserId());
            pstmt.setInt(6, history.getId());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    // 删除库存变动历史记录
    public boolean deleteInventoryHistory(int id) throws SQLException {
        String query = "DELETE FROM inventory_history WHERE id = ?";
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    // 辅助方法：将ResultSet映射到InventoryHistory对象
    private InventoryHistory mapResultSetToInventoryHistory(ResultSet rs) throws SQLException {
        InventoryHistory history = new InventoryHistory();
        history.setId(rs.getInt("id"));
        history.setInventoryId(rs.getInt("inventory_id"));
        history.setChangeType(rs.getString("change_type"));
        history.setQuantity(rs.getInt("quantity"));
        history.setReason(rs.getString("reason"));
        history.setUserId(rs.getLong("user_id"));
        history.setCreatedAt(rs.getTimestamp("created_at"));
        return history;
    }
}







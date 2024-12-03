package com.example.easyims.lxy0711.productinventory.dao;

import com.example.easyims.lxy0711.productinventory.model.Product;
import com.example.easyims.lxy0711.productinventory.util.DatabaseConnectionPool;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private final DatabaseConnectionPool connectionPool;

    public ProductDAO() {
        this.connectionPool = DatabaseConnectionPool.getInstance();
    }

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // 获取所有产品记录
    public List<Product> getAllProducts() throws SQLException {
        return getProductsByConditions(null, null, null, null, null, 0, Integer.MAX_VALUE);
    }

    // 根据ID获取单个产品记录
    public Product getProductById(int id) throws SQLException {
        String query = "SELECT * FROM products WHERE id = ?";
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProduct(rs);
                }
            }
        }
        return null;
    }

    // 插入新的产品记录
    public int insertProduct(Product product) throws SQLException {
        String query = "INSERT INTO products (name, sku, category_name, brand, supplier, price, description, image_url, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getSku());
            pstmt.setString(3, product.getCategoryName());
            pstmt.setString(4, product.getBrand());
            pstmt.setString(5, product.getSupplier());
            pstmt.setBigDecimal(6, BigDecimal.valueOf(product.getPrice()));
            pstmt.setString(7, product.getDescription());
            pstmt.setString(8, product.getImageUrl());
            pstmt.setString(9, product.getStatus());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Inserting product failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Inserting product failed, no ID obtained.");
                }
            }
        }
    }

    // 更新产品记录
    public boolean updateProduct(Product product) throws SQLException {
        String query = "UPDATE products SET name = ?, sku = ?, category_name = ?, brand = ?, supplier = ?, price = ?, description = ?, image_url = ?, status = ?, updated_at = NOW() WHERE id = ?";
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getSku());
            pstmt.setString(3, product.getCategoryName());
            pstmt.setString(4, product.getBrand());
            pstmt.setString(5, product.getSupplier());
            pstmt.setBigDecimal(6, BigDecimal.valueOf(product.getPrice()));
            pstmt.setString(7, product.getDescription());
            pstmt.setString(8, product.getImageUrl());
            pstmt.setString(9, product.getStatus());
            pstmt.setInt(10, product.getId());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    // 删除产品记录
    public boolean deleteProduct(int id) throws SQLException {
        String query = "DELETE FROM products WHERE id = ?";
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    // 根据名称模糊搜索产品
    public List<Product> searchProductsByName(String name) throws SQLException {
        return getProductsByConditions(name, null, null, null, null, 0, Integer.MAX_VALUE);
    }

    // 根据SKU编号查找产品
    public Product getProductBySku(String sku) throws SQLException {
        String query = "SELECT * FROM products WHERE sku = ?";
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, sku);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProduct(rs);
                }
            }
        }
        return null;
    }

    // 根据价格范围查找产品
    public List<Product> getProductsByPriceRange(double minPrice, double maxPrice) throws SQLException {
        return getProductsByConditions(null, BigDecimal.valueOf(minPrice), BigDecimal.valueOf(maxPrice), null, null, 0, Integer.MAX_VALUE);
    }

    // 根据状态（active、inactive）查找产品
    public List<Product> getProductsByStatus(String status) throws SQLException {
        return getProductsByConditions(null, null, null, status, null, 0, Integer.MAX_VALUE);
    }

    // 分页查询产品
    public List<Product> getProductsByPage(int offset, int limit) throws SQLException {
        return getProductsByConditions(null, null, null, null, null, offset, limit);
    }

    // 组合条件搜索产品
    public List<Product> getProductsByConditions(String name, BigDecimal minPrice, BigDecimal maxPrice, String status, String categoryName, int offset, int limit) throws SQLException {
        List<Product> products = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM products WHERE 1=1");

        List<Object> params = new ArrayList<>();

        if (name != null && !name.isEmpty()) {
            queryBuilder.append(" AND name LIKE ?");
            params.add("%" + name + "%");
        }

        if (categoryName != null && !categoryName.isEmpty()) {
            queryBuilder.append(" AND category_name = ?");
            params.add(categoryName);
        }

        if (minPrice != null) {
            queryBuilder.append(" AND price >= ?");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            queryBuilder.append(" AND price <= ?");
            params.add(maxPrice);
        }

        if (status != null && !status.isEmpty()) {
            queryBuilder.append(" AND status = ?");
            params.add(status);
        }

       /* if (sortBy != null && !sortBy.isEmpty()) {
            queryBuilder.append(" ORDER BY ").append(sortBy);
        }
       */
        queryBuilder.append(" LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        String query = queryBuilder.toString();
        try (Connection conn = connectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof String) {
                    pstmt.setString(i + 1, (String) param);
                } else if (param instanceof BigDecimal) {
                    pstmt.setBigDecimal(i + 1, (BigDecimal) param);
                } else if (param instanceof Integer) {
                    pstmt.setInt(i + 1, (Integer) param);
                }
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Product product = mapResultSetToProduct(rs);
                    products.add(product);
                }
            }
        }
        return products;
    }

    // 辅助方法：将ResultSet映射到Product对象
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setSku(rs.getString("sku"));
        product.setCategoryName(rs.getString("category_name"));
        product.setBrand(rs.getString("brand"));
        product.setSupplier(rs.getString("supplier"));
        product.setPrice(rs.getDouble("price"));
        product.setDescription(rs.getString("description"));
        product.setImageUrl(rs.getString("image_url"));
        product.setStatus(rs.getString("status"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        product.setUpdatedAt(rs.getTimestamp("updated_at"));
        return product;
    }
}
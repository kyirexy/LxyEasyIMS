package com.example.easyims.lxy0711.productinventory.service;

import com.example.easyims.lxy0711.productinventory.dao.ProductDAO;
import com.example.easyims.lxy0711.productinventory.model.Product;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductService {

    private final ProductDAO productDAO;
    private static final int LOW_STOCK_THRESHOLD = 10;

    public ProductService() {
        this.productDAO = new ProductDAO();
    }

    // 获取总产品数量
    public long getTotalProductCount() {
        try {
            return productDAO.getAllProducts().size();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // 获取库存不足的产品数量
    public long getLowStockProductCount() {
        try {
            List<Product> products = productDAO.getAllProducts();
            long count = 0;
            for (Product product : products) {
                if ("low".equals(product.getStatus())) {
                    count++;
                }
            }
            return count;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // 获取总库存价值
    public double getTotalInventoryValue() {
        try {
            List<Product> products = productDAO.getAllProducts();
            double totalValue = 0;
            for (Product product : products) {
                totalValue += product.getPrice();
            }
            return totalValue;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0.0;
        }
    }

    // 获取各类别产品统计
    public Map<String, Integer> getCategoryStatistics() {
        try {
            List<Product> products = productDAO.getAllProducts();
            Map<String, Integer> categoryStats = new HashMap<>();

            for (Product product : products) {
                String categoryName = product.getCategoryName();
                categoryStats.put(categoryName,
                        categoryStats.getOrDefault(categoryName, 0) + 1);
            }
            return categoryStats;
        } catch (SQLException e) {
            e.printStackTrace();
            return new HashMap<>();
        }
    }

    // 添加产品
    public int addProduct(Product product) throws SQLException {
        return productDAO.insertProduct(product);
    }

    // 更新产品
    public boolean updateProduct(Product product) throws SQLException {
        return productDAO.updateProduct(product);
    }

    // 删除产品
    public boolean deleteProduct(int id) throws SQLException {
        return productDAO.deleteProduct(id);
    }

    // 根据ID获取产品
    public Product getProductById(int id) throws SQLException {
        return productDAO.getProductById(id);
    }

    // 获取所有产品
    public List<Product> getAllProducts() throws SQLException {
        return productDAO.getAllProducts();
    }

    // 根据名称搜索产品
    public List<Product> searchProductsByName(String name) throws SQLException {
        return productDAO.searchProductsByName(name);
    }

    // 根据SKU获取产品
    public Product getProductBySku(String sku) throws SQLException {
        return productDAO.getProductBySku(sku);
    }

    // 分页获取产品列表
    public List<Product> getProductsByPage(int page, int pageSize) throws SQLException {
        int offset = (page - 1) * pageSize;
        return productDAO.getProductsByPage(offset, pageSize);
    }

    // 根据状态获取产品
    public List<Product> getProductsByStatus(String status) throws SQLException {
        return productDAO.getProductsByStatus(status);
    }
}

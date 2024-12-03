package com.example.easyims.lxy0711.productinventory.servlet;

import com.example.easyims.lxy0711.productinventory.model.Product;
import com.example.easyims.lxy0711.productinventory.service.ProductService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/product/products")
public class ProductServlet extends HttpServlet {
    
    private final ProductService productService;
    private final Gson gson;

    public ProductServlet() {
        this.productService = new ProductService();
        // 配置Gson以处理时间戳
        this.gson = new GsonBuilder()
            .setDateFormat("yyyy-MM-dd'T'HH:mm:ss")
            .create();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        try {
            String action = request.getParameter("action");
            if (action == null) {
                // 默认获取所有产品
                List<Product> products = productService.getAllProducts();
                Map<String, Object> result = new HashMap<>();
                result.put("data", products);
                result.put("totalPages", 1);
                result.put("currentPage", 1);
                response.getWriter().write(gson.toJson(result));
                return;
            }

            switch (action) {
                case "page":
                    int page = Integer.parseInt(request.getParameter("page"));
                    int pageSize = Integer.parseInt(request.getParameter("pageSize"));
                    List<Product> products = productService.getProductsByPage(page, pageSize);
                    Map<String, Object> result = new HashMap<>();
                    result.put("data", products);
                    result.put("totalPages", Math.ceil(productService.getTotalProductCount() / (double) pageSize));
                    result.put("currentPage", page);
                    response.getWriter().write(gson.toJson(result));
                    break;
                case "getById":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Product product = productService.getProductById(id);
                    response.getWriter().write(gson.toJson(product));
                    break;
                    
                case "search":
                    String keyword = request.getParameter("keyword");
                    List<Product> searchResults = productService.searchProductsByName(keyword);
                    response.getWriter().write(gson.toJson(searchResults));
                    break;
                    
                case "filter":
                    String status = request.getParameter("status");
                    List<Product> filteredProducts = productService.getProductsByStatus(status);
                    response.getWriter().write(gson.toJson(filteredProducts));
                    break;
                    
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
            }
        } catch (SQLException e) {
            handleError(response, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        try {
            BufferedReader reader = request.getReader();
            Product product = gson.fromJson(reader, Product.class);
            
            int newId = productService.addProduct(product);
            product.setId(newId);
            
            response.getWriter().write(gson.toJson(product));
            response.setStatus(HttpServletResponse.SC_CREATED);
        } catch (Exception e) {
            handleError(response, e);
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        try {
            BufferedReader reader = request.getReader();
            Product product = gson.fromJson(reader, Product.class);
            
            boolean updated = productService.updateProduct(product);
            if (updated) {
                response.getWriter().write(gson.toJson(product));
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            }
        } catch (Exception e) {
            handleError(response, e);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String ids = request.getParameter("ids");
            if (ids != null && ids.contains(",")) {
                // 批量删除
                String[] idArray = ids.split(",");
                for (String id : idArray) {
                    productService.deleteProduct(Integer.parseInt(id));
                }
                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
            } else {
                // 单个删除
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = productService.deleteProduct(id);
                if (deleted) {
                    response.setStatus(HttpServletResponse.SC_NO_CONTENT);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                }
            }
        } catch (Exception e) {
            handleError(response, e);
        }
    }

    private void handleError(HttpServletResponse response, Exception e) throws IOException {
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write(gson.toJson(new ErrorResponse(e.getMessage())));
    }

    // 错误响应的内部类
    private static class ErrorResponse {
        private final String error;
        
        public ErrorResponse(String error) {
            this.error = error;
        }
    }
}
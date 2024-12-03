package com.example.easyims.lxy0711.auth.util;

import org.apache.commons.dbcp.BasicDataSource;
import java.sql.Connection;
import java.sql.SQLException;
import javax.sql.DataSource;


public class DatabaseConnectionPool {

    private static DatabaseConnectionPool instance;
    private final DataSource dataSource;

    private DatabaseConnectionPool() {
        BasicDataSource ds = new BasicDataSource();
        ds.setUrl("jdbc:mysql://localhost:3306/easyims?useSSL=false&serverTimezone=UTC");
        ds.setUsername("root");
        ds.setPassword("123456");
        ds.setInitialSize(5); // 初始连接数
        ds.setMaxWait(10); // 最大连接数
        ds.setMaxIdle(5); // 最大空闲连接数
        ds.setMinIdle(2); // 最小空闲连接数
        this.dataSource = ds;
    }

    public static synchronized DatabaseConnectionPool getInstance() {
        if (instance == null) {
            instance = new DatabaseConnectionPool();
        }
        return instance;
    }

    public Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
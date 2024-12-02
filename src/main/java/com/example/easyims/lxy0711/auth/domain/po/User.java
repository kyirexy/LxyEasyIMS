package com.example.easyims.lxy0711.auth.domain.po;

import java.sql.Timestamp;
import java.util.List;

/**
 * 用户类，表示数据库中的用户表 (users)
 */
public class User {

    private Long id;          // 用户ID
    private String username;  // 用户名
    private String password;  // 密码
    private String email;     // 邮箱
    private Timestamp createdAt; // 创建时间
    private List<Role> roles; // 用户拥有的角色，使用 List 来存储多个角色

    // 无参构造器
    public User() {}

    // 全参构造器
    public User(Long id, String username, String password, String email, Timestamp createdAt, List<Role> roles) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.createdAt = createdAt;
        this.roles = roles;
    }

    // Getter 和 Setter 方法
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    // toString 方法，方便打印和调试
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", createdAt=" + createdAt +
                ", roles=" + roles +
                '}';
    }

}

package com.example.easyims.lxy0711.auth.domain.dto;

import java.sql.Timestamp;
import java.util.List;

/**
 * 用户 DTO，用于前端与后端之间的数据传输
 */
public class UserDTO {

    private Long id;           // 用户ID
    private String username;   // 用户名
    private String email;      // 邮箱
    private Timestamp createdAt; // 创建时间
    private List<String> roles; // 用户角色列表，存储角色名称（如 "admin", "user" 等）

    // 无参构造器
    public UserDTO() {}

    // 全参构造器
    public UserDTO(Long id, String username, String email, Timestamp createdAt, List<String> roles) {
        this.id = id;
        this.username = username;
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

    public List<String> getRoles() {
        return roles;
    }

    public void setRoles(List<String> roles) {
        this.roles = roles;
    }

    // toString 方法，方便打印和调试
    @Override
    public String toString() {
        return "UserDTO{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", createdAt=" + createdAt +
                ", roles=" + roles +
                '}';
    }
}

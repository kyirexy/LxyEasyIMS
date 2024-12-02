package com.example.easyims.lxy0711.auth.domain.dto;

/**
 * 角色 DTO，用于前端与后端之间的数据传输
 */
public class RoleDTO {

    private Long id;         // 角色ID
    private String roleName; // 角色名称

    // 无参构造器
    public RoleDTO() {}

    // 全参构造器
    public RoleDTO(Long id, String roleName) {
        this.id = id;
        this.roleName = roleName;
    }

    // Getter 和 Setter 方法
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    // toString 方法，方便打印和调试
    @Override
    public String toString() {
        return "RoleDTO{" +
                "id=" + id +
                ", roleName='" + roleName + '\'' +
                '}';
    }
}

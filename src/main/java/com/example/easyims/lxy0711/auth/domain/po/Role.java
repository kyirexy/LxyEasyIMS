package com.example.easyims.lxy0711.auth.domain.po;

/**
 * 角色类，表示数据库中的角色表 (roles)
 */
public class Role {

    private Long id;        // 角色ID
    private String roleName; // 角色名称

    // 无参构造器
    public Role() {}

    // 全参构造器
    public Role(Long id, String roleName) {
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
        return "Role{" +
                "id=" + id +
                ", roleName='" + roleName + '\'' +
                '}';
    }
}

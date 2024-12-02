package com.example.easyims.lxy0711.auth.domain.vo;

public class RoleVO {
    private int id;                // 角色ID
    private String roleName;       // 角色名称
    private String description;    // 角色描述

    // 无参构造方法
    public RoleVO() {}

    // 有参构造方法
    public RoleVO(int id, String roleName, String description) {
        this.id = id;
        this.roleName = roleName;
        this.description = description;
    }

    // Getter 和 Setter 方法
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // 重写toString()方法，便于打印或调试
    @Override
    public String toString() {
        return "RoleVO{" +
                "id=" + id +
                ", roleName='" + roleName + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}

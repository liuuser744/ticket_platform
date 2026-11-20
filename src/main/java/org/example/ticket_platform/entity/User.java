package org.example.ticket_platform.entity;

import lombok.Data;
import lombok.ToString;

import java.time.LocalDateTime;

/**
 * 系统用户表
 */
@Data
public class User {
    private Long id;
    private String username;
    @ToString.Exclude
    private String password;
    private String realName;    //真实姓名
    private String phone;
    private String email;
    private String avatar;
    private String roleCode;      //角色：ADMIN/MANAGER/ENGINEER/CUSTOMER
    private Long customerId;    //客户账号绑定客户ID
    private Integer status;
    private LocalDateTime lastLoginTime;
    private Integer version;    //乐观锁版本
    private Integer deleted;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}

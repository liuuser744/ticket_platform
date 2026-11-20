package org.example.ticket_platform.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 客户联系人表
 */
@Data
public class Contact {
    private Long id;
    private Long customerId;  //所属客户ID
    private String name;
    private String phone;
    private String email;
    private String position;    //职位
    private Integer deleted;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}

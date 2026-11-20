package org.example.ticket_platform.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 客户档案表
 */
@Data
public class Customer {
    private Long id;
    private String customerCode;    //客户编码
    private String customerName;    //客户名称
    private String level;
    private String industry;    //所属行业
    private String address;
    private String contactPhone;
    private Long ownerUserId;   //负责的工程师ID
    private Integer status;     //1合作 0停用
    private String remark;
    private Integer deleted;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}

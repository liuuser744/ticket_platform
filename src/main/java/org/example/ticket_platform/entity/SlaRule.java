package org.example.ticket_platform.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * SLA规则表
 */
@Data
public class SlaRule {
    private Long id;
    private String customerLevel;   //客户等级
    private Integer priority;       //优先级 1低 2中 3高 4紧急
    private Integer responseHours;  //响应时限
    private Integer resolveHours;   //解决时限
    private Integer enabled;    //是否启用
    private String remark;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}

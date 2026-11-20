package org.example.ticket_platform.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * SLA超时升级记录表
 */
@Data
public class SlaUpgrade {
    private Long id;
    private Long ticketId;  //工单id
    private String slaType;     //超时类型RESPONSE响应超时 / RESOLVE解决超时
    private Integer oldPriority;    //升级前优先级
    private Integer newPriority;    //升级后优先级
    private LocalDateTime triggerTime;  //触发时间
    private String remark;      //说明
    private LocalDateTime createTime;
}

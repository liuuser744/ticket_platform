package org.example.ticket_platform.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 工单流转日志表
 */
@Data
public class TicketLog {
    private Long id;
    private Long ticketId;  //工单ID
    private String action;  //动作 CREATE/ASSIGN/ACCEPT/COMMENT/SUBMIT/CONFIRM/REJECT/CANCEL/UPGRADE/SLA_CHECK/ATTACHMENT
    private String fromStatus;  //变更前状态 ；CREATE为空，COMMENT为当前状态
    private String toStatus;    //变更后状态
    private Long operatorId;     //操作人ID。系统为0
    private String operatorName;    //操作人姓名冗余
    private String content;         //备注
    private LocalDateTime createTime;
}

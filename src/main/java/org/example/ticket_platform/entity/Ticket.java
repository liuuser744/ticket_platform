package org.example.ticket_platform.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 工单主表
 */
@Data
public class Ticket {
    private Long id;
    private String ticketNo;    //编号TK+yyyyMMddHHmmss+12位UUID十六进制
    private Long customerId;    //客户ID
    private Long contactId;     //提单联系人ID
    private String title;
    private String content;     //问题描述
    private String category;    //问题分类，如 打印/数据/登录/操作咨询
    private Integer priority;   //优先级 1低 2中 3高 4紧急
    private String status;      //状态 PENDING_ASSIGN/PENDING_ACCEPT/PROCESSING/PENDING_CONFIRM/CLOSED/CANCELLED
    private String source;      //来源 WEB客户提单/INTERNAL内部代提/PHONE电话
    private Long assigneeId;    //当前处理人ID
    private Long creatorId;     //创建人ID
    private LocalDateTime expectTime;   //客户期望完工时间
    private Long slaRuleId;     //提单命中的SLA规则ID
    private LocalDateTime slaResponseDeadline;  //响应截止时间
    private LocalDateTime slaResolveDeadline;   //解决截止时间
    private LocalDateTime firstResponseTime;    //首次接单时间
    private LocalDateTime resolveTime;      //当前有效提交验收时间
    private Long resolverId;            //当前有效解决人
    private LocalDateTime closedTime;   //确认关闭时间
    private LocalDateTime cancelledTime;    //取消时间
    private Integer isOverdueResponse;  //历史响应是否违约 0否 1是
    private Integer isOverdueResolve;   //历史解决是否违约 0否 1是
    private Integer reopenCount;      //待验证被驳回次数
    private Integer version;    //乐观锁
    private Integer deleted;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}

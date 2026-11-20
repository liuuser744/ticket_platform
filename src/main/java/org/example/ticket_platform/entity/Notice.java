package org.example.ticket_platform.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 站内通知表
 */
@Data
public class Notice {
    private Long id;
    private Long receiverId; //接收人ID
    private String title;
    private String content; //通知内容
    private String type;    //类型：ASSIGN/UPGRADE/REJECT/CLOSE
    private Long bizId;  //业务ID
    private Long upgradeId;  //关联升级记录
    private Integer isRead;
    private LocalDateTime readTime;
    private LocalDateTime createTime;
}

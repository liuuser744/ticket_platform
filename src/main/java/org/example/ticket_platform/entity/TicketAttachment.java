package org.example.ticket_platform.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 工单附件表
 */
@Data
public class TicketAttachment {
    private Long id;
    private Long ticketId;    //工单ID
    private String fileName;    //文件名
    private String filePath;    //文件路径
    private Long fileSize;      //文件大小
    private String fileType;    //文件扩展名
    private Long uploaderId;    //上传人ID
    private Integer deleted;
    private LocalDateTime createTime;

}

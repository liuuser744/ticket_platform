-- MySQL dump 10.13  Distrib 8.4.9, for Win64 (x86_64)
--
-- Host: localhost    Database: ticket_platform_simple
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `ticket_platform_simple`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ticket_platform_simple` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ticket_platform_simple`;

--
-- Table structure for table `cus_contact`
--

DROP TABLE IF EXISTS `cus_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cus_contact` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_id` bigint NOT NULL COMMENT '所属客户ID',
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系人姓名',
  `phone` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系电话',
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `position` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '职位',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_contact_customer` (`customer_id`) COMMENT '按客户查联系人，不设主联系人'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='客户联系人表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cus_contact`
--

LOCK TABLES `cus_contact` WRITE;
/*!40000 ALTER TABLE `cus_contact` DISABLE KEYS */;
INSERT INTO `cus_contact` VALUES (1,1,'刘建国','13800000001','liujg@haichen.example.com','信息部经理',0,'2026-11-20 09:17:02','2026-11-20 09:17:02'),(2,1,'孙倩','13800000002','sunq@haichen.example.com','信息部专员',0,'2026-11-20 09:17:02','2026-11-20 09:17:02'),(3,2,'王磊','13800000003','wanglei@runtong.example.com','运营主管',0,'2026-11-20 09:17:02','2026-11-20 09:17:02'),(4,3,'陈静','13800000004','chenjing@xinyuan.example.com','IT 负责人',0,'2026-11-20 09:17:02','2026-11-20 09:17:02');
/*!40000 ALTER TABLE `cus_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cus_customer`
--

DROP TABLE IF EXISTS `cus_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cus_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户编码，业务唯一标识',
  `customer_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `level` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NORMAL' COMMENT '客户等级 VIP/NORMAL，决定 SLA 时限',
  `industry` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '所属行业',
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地址',
  `contact_phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '总机/公共联系电话',
  `owner_user_id` bigint DEFAULT NULL COMMENT '负责工程师ID，工程师数据范围按此字段过滤',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1合作中 0已停用',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除；已被工单引用的客户不允许物理删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_customer_code` (`customer_code`),
  KEY `idx_owner` (`owner_user_id`) COMMENT '工程师登录后查自己负责的客户',
  KEY `idx_name` (`customer_name`) COMMENT '客户名称前缀搜索',
  KEY `idx_level_status` (`level`,`status`) COMMENT '按等级+状态筛选及 SLA 匹配'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='客户档案表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cus_customer`
--

LOCK TABLES `cus_customer` WRITE;
/*!40000 ALTER TABLE `cus_customer` DISABLE KEYS */;
INSERT INTO `cus_customer` VALUES (1,'KH2026001','青岛海辰机械制造有限公司','VIP','装备制造','青岛市黄岛区海辰工业园 3 号','0532-8888****',3,1,'年度服务合同客户，响应时限按 VIP',0,'2026-08-22 09:17:02','2026-11-20 09:17:02'),(2,'KH2026002','青岛润通国际贸易有限公司','NORMAL','外贸','青岛市市南区香港中路 66 号','0532-6666****',4,1,'使用外贸 ERP 模块',0,'2026-09-21 09:17:02','2026-11-20 09:17:02'),(3,'KH2026003','潍坊鑫源电子科技有限公司','NORMAL','电子制造','潍坊市高新区东方路 12 号','0536-5555****',3,1,'新签客户，处于上线初期',0,'2026-10-31 09:17:02','2026-11-20 09:17:02');
/*!40000 ALTER TABLE `cus_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录账号，不可重复',
  `password` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'BCrypt 加密后密码，长度固定 60',
  `real_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '头像相对路径',
  `role_code` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '单一固定角色 ADMIN/MANAGER/ENGINEER/CUSTOMER；开户选择，创建后不变',
  `customer_id` bigint DEFAULT NULL COMMENT '客户账号绑定的客户ID；内部人员为 NULL',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1启用 0禁用',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `version` int NOT NULL DEFAULT '0' COMMENT '乐观锁版本号',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除 0正常 1已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`) COMMENT '账号唯一；账号不回收复用，删除后也不允许他人注册同名',
  KEY `idx_customer` (`customer_id`) COMMENT '客户账号查询其绑定客户',
  KEY `idx_status_deleted` (`status`,`deleted`) COMMENT '登录校验与用户列表过滤',
  KEY `idx_real_name` (`real_name`) COMMENT '按姓名模糊搜索前缀匹配',
  CONSTRAINT `chk_user_identity` CHECK ((((`role_code` = _utf8mb4'CUSTOMER') and (`customer_id` is not null)) or ((`role_code` <> _utf8mb4'CUSTOMER') and (`customer_id` is null)))),
  CONSTRAINT `chk_user_role` CHECK ((`role_code` in (_utf8mb4'ADMIN',_utf8mb4'MANAGER',_utf8mb4'ENGINEER',_utf8mb4'CUSTOMER')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'admin','$2a$10$O7H53P97lvvDiXC5k.EaHuRv1c0osM91458YmvJlq3mypbGtxvfwC','系统管理员','13900000001','admin@example.com',NULL,'ADMIN',NULL,1,NULL,0,0,'2026-11-20 09:17:02','2026-11-20 09:17:02'),(2,'manager01','$2a$10$O7H53P97lvvDiXC5k.EaHuRv1c0osM91458YmvJlq3mypbGtxvfwC','张主管','13900000002','manager01@example.com',NULL,'MANAGER',NULL,1,NULL,0,0,'2026-11-20 09:17:02','2026-11-20 09:17:02'),(3,'engineer01','$2a$10$O7H53P97lvvDiXC5k.EaHuRv1c0osM91458YmvJlq3mypbGtxvfwC','赵工','13900000003','engineer01@example.com',NULL,'ENGINEER',NULL,1,NULL,0,0,'2026-11-20 09:17:02','2026-11-20 09:17:02'),(4,'engineer02','$2a$10$O7H53P97lvvDiXC5k.EaHuRv1c0osM91458YmvJlq3mypbGtxvfwC','钱工','13900000004','engineer02@example.com',NULL,'ENGINEER',NULL,1,NULL,0,0,'2026-11-20 09:17:02','2026-11-20 09:17:02'),(5,'customer01','$2a$10$O7H53P97lvvDiXC5k.EaHuRv1c0osM91458YmvJlq3mypbGtxvfwC','刘建国','13800000001','liujg@haichen.example.com',NULL,'CUSTOMER',1,1,NULL,0,0,'2026-11-20 09:17:02','2026-11-20 09:17:02');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_notice`
--

DROP TABLE IF EXISTS `t_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_notice` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `receiver_id` bigint NOT NULL COMMENT '接收人ID',
  `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知标题',
  `content` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知内容',
  `type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型 ASSIGN/UPGRADE/REJECT/CLOSE',
  `biz_id` bigint DEFAULT NULL COMMENT '业务ID，如工单ID，前端据此跳详情',
  `upgrade_id` bigint DEFAULT NULL COMMENT '关联升级记录；非升级NULL，每接收人一条通知',
  `is_read` tinyint NOT NULL DEFAULT '0' COMMENT '是否已读',
  `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_upgrade_receiver` (`upgrade_id`,`receiver_id`) COMMENT '同升级每人唯一；非升级NULL可多条',
  KEY `idx_receiver_read` (`receiver_id`,`is_read`,`create_time`) COMMENT '未读数统计 + 通知列表，三列顺序不可换'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='站内通知表（本地同步与业务同事务）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_notice`
--

LOCK TABLES `t_notice` WRITE;
/*!40000 ALTER TABLE `t_notice` DISABLE KEYS */;
INSERT INTO `t_notice` VALUES (1,3,'新工单已分派给你','工单2标签尺寸问题，请接单','ASSIGN',2,NULL,0,NULL,'2026-11-20 08:27:02'),(2,4,'新工单已分派给你','工单3汇率问题，请接单','ASSIGN',3,NULL,1,'2026-11-20 04:22:02','2026-11-20 04:17:02'),(3,3,'新工单已分派给你','工单4登录问题，请接单','ASSIGN',4,NULL,1,'2026-11-18 09:32:02','2026-11-18 09:27:02'),(4,3,'工单确认关闭','工单4客户已电话确认，管理员登记关闭','CLOSE',4,NULL,0,NULL,'2026-11-18 14:17:02');
/*!40000 ALTER TABLE `t_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sla_rule`
--

DROP TABLE IF EXISTS `t_sla_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_sla_rule` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_level` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户等级 VIP/NORMAL',
  `priority` tinyint NOT NULL COMMENT '优先级 1低 2中 3高 4紧急',
  `response_hours` int NOT NULL COMMENT '响应时限（小时）',
  `resolve_hours` int NOT NULL COMMENT '解决时限（小时）',
  `enabled` tinyint NOT NULL DEFAULT '1' COMMENT '是否启用',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_level_priority` (`customer_level`,`priority`) COMMENT '同一等级+优先级仅一条，含禁用；原地修改/启停',
  CONSTRAINT `chk_sla_rule_hours` CHECK (((`response_hours` > 0) and (`resolve_hours` >= `response_hours`))),
  CONSTRAINT `chk_sla_rule_level` CHECK ((`customer_level` in (_utf8mb4'VIP',_utf8mb4'NORMAL'))),
  CONSTRAINT `chk_sla_rule_priority` CHECK ((`priority` between 1 and 4))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='SLA 规则表（固定8条规则，仅只读查询，不提供后台修改）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_sla_rule`
--

LOCK TABLES `t_sla_rule` WRITE;
/*!40000 ALTER TABLE `t_sla_rule` DISABLE KEYS */;
INSERT INTO `t_sla_rule` VALUES (1,'VIP',1,4,48,1,'VIP 低优先级：4 小时响应 / 48 小时解决','2026-11-20 09:17:02','2026-11-20 09:17:02'),(2,'VIP',2,2,24,1,'VIP 中优先级：2 小时响应 / 24 小时解决','2026-11-20 09:17:02','2026-11-20 09:17:02'),(3,'VIP',3,1,8,1,'VIP 高优先级：1 小时响应 / 8 小时解决','2026-11-20 09:17:02','2026-11-20 09:17:02'),(4,'VIP',4,1,4,1,'VIP 紧急：1 小时响应 / 4 小时解决','2026-11-20 09:17:02','2026-11-20 09:17:02'),(5,'NORMAL',1,24,72,1,'普通低优先级：24 小时响应 / 72 小时解决','2026-11-20 09:17:02','2026-11-20 09:17:02'),(6,'NORMAL',2,8,48,1,'普通中优先级：8 小时响应 / 48 小时解决','2026-11-20 09:17:02','2026-11-20 09:17:02'),(7,'NORMAL',3,4,24,1,'普通高优先级：4 小时响应 / 24 小时解决','2026-11-20 09:17:02','2026-11-20 09:17:02'),(8,'NORMAL',4,2,12,1,'普通紧急：2 小时响应 / 12 小时解决','2026-11-20 09:17:02','2026-11-20 09:17:02');
/*!40000 ALTER TABLE `t_sla_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sla_upgrade`
--

DROP TABLE IF EXISTS `t_sla_upgrade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_sla_upgrade` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_id` bigint NOT NULL COMMENT '工单ID',
  `sla_type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '超时类型 RESPONSE响应超时 / RESOLVE解决超时',
  `old_priority` tinyint DEFAULT NULL COMMENT '升级前优先级',
  `new_priority` tinyint DEFAULT NULL COMMENT '升级后优先级',
  `trigger_time` datetime NOT NULL COMMENT '触发时间',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '说明，如"响应超时 2.5 小时，自动升级为高"',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ticket_sla_type` (`ticket_id`,`sla_type`) COMMENT '同工单同类型生命周期一次',
  KEY `idx_ticket` (`ticket_id`),
  KEY `idx_trigger_time` (`trigger_time`) COMMENT '按时间统计每日升级量',
  CONSTRAINT `chk_upgrade_type` CHECK ((`sla_type` in (_utf8mb4'RESPONSE',_utf8mb4'RESOLVE')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='SLA 超时升级记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_sla_upgrade`
--

LOCK TABLES `t_sla_upgrade` WRITE;
/*!40000 ALTER TABLE `t_sla_upgrade` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_sla_upgrade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ticket`
--

DROP TABLE IF EXISTS `t_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_ticket` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '编号TK+yyyyMMddHHmmss+12位UUID十六进制片段；DB唯一兜底',
  `customer_id` bigint NOT NULL COMMENT '客户ID',
  `contact_id` bigint DEFAULT NULL COMMENT '提单联系人ID',
  `title` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '问题标题',
  `content` text COLLATE utf8mb4_general_ci COMMENT '问题描述',
  `category` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '问题分类，如 打印/数据/登录/操作咨询',
  `priority` tinyint NOT NULL DEFAULT '2' COMMENT '优先级 1低 2中 3高 4紧急',
  `status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'PENDING_ASSIGN' COMMENT '状态 PENDING_ASSIGN/PENDING_ACCEPT/PROCESSING/PENDING_CONFIRM/CLOSED/CANCELLED',
  `source` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'WEB' COMMENT '来源 WEB客户提单/INTERNAL内部代提/PHONE电话',
  `assignee_id` bigint DEFAULT NULL COMMENT '当前处理人ID',
  `creator_id` bigint NOT NULL COMMENT '创建人ID',
  `expect_time` datetime DEFAULT NULL COMMENT '客户期望完成时间',
  `sla_rule_id` bigint DEFAULT NULL COMMENT '提单时命中的 SLA 规则ID，规则变更不影响历史工单',
  `sla_response_deadline` datetime DEFAULT NULL COMMENT '响应截止时间 = 创建时间 + 规则响应时限',
  `sla_resolve_deadline` datetime DEFAULT NULL COMMENT '解决截止时间 = 创建时间 + 规则解决时限',
  `first_response_time` datetime DEFAULT NULL COMMENT '首次接单时间；只写一次，晚接单当场结算违约',
  `resolve_time` datetime DEFAULT NULL COMMENT '当前有效提交验收时间；驳回清空，截止不变',
  `resolver_id` bigint DEFAULT NULL COMMENT '当前有效解决人；提交时写，驳回清空',
  `closed_time` datetime DEFAULT NULL COMMENT '确认关闭时间',
  `cancelled_time` datetime DEFAULT NULL COMMENT '取消时间，停止未完成SLA计时',
  `is_overdue_response` tinyint NOT NULL DEFAULT '0' COMMENT '历史响应违约0否1是，业务结算和扫描维护，只能0到1',
  `is_overdue_resolve` tinyint NOT NULL DEFAULT '0' COMMENT '历史解决违约0否1是，驳回保留，只能0到1',
  `reopen_count` int NOT NULL DEFAULT '0' COMMENT '待验收被驳回次数',
  `version` int NOT NULL DEFAULT '0' COMMENT '乐观锁，工单业务写入成功加1',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ticket_no` (`ticket_no`),
  KEY `idx_status_deadline` (`status`,`sla_response_deadline`) COMMENT 'SLA 定时任务扫描：按状态+截止时间过滤，避免全表扫',
  KEY `idx_resolve_deadline` (`status`,`sla_resolve_deadline`) COMMENT '未解决扫描，执行计划另验',
  KEY `idx_resolve_time` (`resolve_time`,`resolver_id`) COMMENT '有效解决趋势与解决人统计',
  KEY `idx_assignee_status` (`assignee_id`,`status`) COMMENT '工程师"我的待办"列表 + 数据权限过滤',
  KEY `idx_customer_create` (`customer_id`,`create_time`) COMMENT '客户门户工单列表、客户详情统计',
  KEY `idx_create_time` (`create_time`) COMMENT '看板按时间范围统计',
  KEY `idx_overdue` (`is_overdue_resolve`,`status`) COMMENT '超时未处理工单统计',
  CONSTRAINT `chk_ticket_deadline` CHECK (((`sla_response_deadline` is not null) and (`sla_resolve_deadline` is not null) and (`sla_resolve_deadline` >= `sla_response_deadline`))),
  CONSTRAINT `chk_ticket_overdue` CHECK (((`is_overdue_response` in (0,1)) and (`is_overdue_resolve` in (0,1)))),
  CONSTRAINT `chk_ticket_priority` CHECK ((`priority` between 1 and 4)),
  CONSTRAINT `chk_ticket_status` CHECK ((`status` in (_utf8mb4'PENDING_ASSIGN',_utf8mb4'PENDING_ACCEPT',_utf8mb4'PROCESSING',_utf8mb4'PENDING_CONFIRM',_utf8mb4'CLOSED',_utf8mb4'CANCELLED')))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工单主表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ticket`
--

LOCK TABLES `t_ticket` WRITE;
/*!40000 ALTER TABLE `t_ticket` DISABLE KEYS */;
INSERT INTO `t_ticket` VALUES (1,'TK20261120061702000000000001',1,1,'生产报表金额对不上','导出合计比台账少1.2万，请排查精度。','数据问题',3,'PENDING_ASSIGN','WEB',NULL,5,NULL,3,'2026-11-20 07:17:02','2026-11-20 14:17:02',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,'2026-11-20 06:17:02','2026-11-20 06:17:02'),(2,'TK20261120081702000000000002',1,2,'条码标签尺寸偏小','100x80标签实际打印92x74，请协助排查。','打印问题',2,'PENDING_ACCEPT','WEB',3,5,NULL,2,'2026-11-20 10:17:02','2026-11-21 08:17:02',NULL,NULL,NULL,NULL,NULL,0,0,0,1,0,'2026-11-20 08:17:02','2026-11-20 08:27:02'),(3,'TK20261120031702000000000003',2,3,'订单汇率取值日期不对','需确认按下单前一天中间价取值能否配置。','业务咨询',2,'PROCESSING','PHONE',4,2,NULL,6,'2026-11-20 11:17:02','2026-11-22 03:17:02','2026-11-20 06:17:02',NULL,NULL,NULL,NULL,0,0,0,3,0,'2026-11-20 03:17:02','2026-11-20 07:17:02'),(4,'TK20261118091702000000000004',3,4,'新员工账号无法登录','三名新员工提示账号不存在，请检查权限同步。','登录问题',1,'CLOSED','INTERNAL',3,1,NULL,5,'2026-11-19 09:17:02','2026-11-21 09:17:02','2026-11-18 10:17:02','2026-11-18 13:17:02',3,'2026-11-18 14:17:02',NULL,0,0,0,5,0,'2026-11-18 09:17:02','2026-11-18 14:17:02');
/*!40000 ALTER TABLE `t_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ticket_attachment`
--

DROP TABLE IF EXISTS `t_ticket_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_ticket_attachment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_id` bigint NOT NULL COMMENT '工单ID',
  `file_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '原始文件名',
  `file_path` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '磁盘相对路径，不对外暴露绝对路径',
  `file_size` bigint NOT NULL DEFAULT '0' COMMENT '文件大小，单位字节',
  `file_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '扩展名或 MIME',
  `uploader_id` bigint NOT NULL COMMENT '上传人ID',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  PRIMARY KEY (`id`),
  KEY `idx_ticket` (`ticket_id`) COMMENT '按工单查附件'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工单附件表（下载必须走鉴权接口，校验归属）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ticket_attachment`
--

LOCK TABLES `t_ticket_attachment` WRITE;
/*!40000 ALTER TABLE `t_ticket_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_ticket_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ticket_log`
--

DROP TABLE IF EXISTS `t_ticket_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_ticket_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_id` bigint NOT NULL COMMENT '工单ID',
  `action` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '动作 CREATE/ASSIGN/ACCEPT/COMMENT/SUBMIT/CONFIRM/REJECT/CANCEL/UPGRADE/SLA_CHECK/ATTACHMENT',
  `from_status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '变更前状态；CREATE为空，COMMENT为当前状态',
  `to_status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '变更后状态',
  `operator_id` bigint NOT NULL COMMENT '操作人ID；系统自动动作填 0',
  `operator_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作人姓名冗余，避免时间线查询关联 sys_user',
  `content` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注、处理内容、退回原因等',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `idx_ticket_time` (`ticket_id`,`create_time`) COMMENT '按工单查时间线，按时间正序',
  KEY `idx_action` (`action`) COMMENT '按动作类型统计'
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工单流转日志表（只增不改，是状态变更的唯一可信来源）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ticket_log`
--

LOCK TABLES `t_ticket_log` WRITE;
/*!40000 ALTER TABLE `t_ticket_log` DISABLE KEYS */;
INSERT INTO `t_ticket_log` VALUES (1,1,'CREATE',NULL,'PENDING_ASSIGN',5,'刘建国','提交：报表金额问题','2026-11-20 06:17:02'),(2,2,'CREATE',NULL,'PENDING_ASSIGN',5,'刘建国','提交：标签尺寸问题','2026-11-20 08:17:02'),(3,2,'ASSIGN','PENDING_ASSIGN','PENDING_ACCEPT',2,'张主管','处理人从空改为赵工(id=3)','2026-11-20 08:27:02'),(4,3,'CREATE',NULL,'PENDING_ASSIGN',2,'张主管','电话受理代客户提单','2026-11-20 03:17:02'),(5,3,'ASSIGN','PENDING_ASSIGN','PENDING_ACCEPT',2,'张主管','处理人从空改为钱工(id=4)','2026-11-20 04:17:02'),(6,3,'ACCEPT','PENDING_ACCEPT','PROCESSING',4,'钱工','已接单核对汇率','2026-11-20 06:17:02'),(7,3,'COMMENT','PROCESSING','PROCESSING',4,'钱工','定位汇率配置，正在验证','2026-11-20 07:17:02'),(8,4,'CREATE',NULL,'PENDING_ASSIGN',1,'系统管理员','内部代提账号问题','2026-11-18 09:17:02'),(9,4,'ASSIGN','PENDING_ASSIGN','PENDING_ACCEPT',1,'系统管理员','处理人从空改为赵工(id=3)','2026-11-18 09:27:02'),(10,4,'ACCEPT','PENDING_ACCEPT','PROCESSING',3,'赵工','已接单检查权限同步','2026-11-18 10:17:02'),(11,4,'COMMENT','PROCESSING','PROCESSING',3,'赵工','已触发同步，三个账号均测试通过','2026-11-18 12:17:02'),(12,4,'SUBMIT','PROCESSING','PENDING_CONFIRM',3,'赵工','提交账号登录结果供验收','2026-11-18 13:17:02'),(13,4,'CONFIRM','PENDING_CONFIRM','CLOSED',1,'系统管理员','客户电话确认，管理员登记关闭','2026-11-18 14:17:02');
/*!40000 ALTER TABLE `t_ticket_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ticket_platform_simple'
--

--
-- Dumping routines for database 'ticket_platform_simple'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-26 10:32:58

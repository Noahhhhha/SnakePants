/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50721
Source Host           : localhost:3306
Source Database       : pybbs

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2021-04-15 14:19:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `admin_user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES ('1', 'admin', '$2a$10$0F6RXnrQDF8SsOudYk7uhuWlqq3kjPuPm4UGeDCj0gvO8xj2pbZ4y', '2018-11-11 11:11:11', '1');
INSERT INTO `admin_user` VALUES ('2', 'liuxing', '$2a$10$BRP1boYZxOSiBLBJ0gIVf.aqGS2cyh0ufFPex7HHH0jVWBA4CPCmC', '2021-03-24 19:17:37', '3');
INSERT INTO `admin_user` VALUES ('4', 'xiaoming', '$2a$10$Wntd/RztGE94tocd4/AzB.Z8YrIHCBBP0F.e/VWDQKW/RUMtfxNfC', '2021-04-05 15:13:09', '3');

-- ----------------------------
-- Table structure for admin_user_tag
-- ----------------------------
DROP TABLE IF EXISTS `admin_user_tag`;
CREATE TABLE `admin_user_tag` (
  `admin_user_id` int(11) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  KEY `admin_user_tag_ibfk_1` (`admin_user_id`),
  KEY `admin_user_tag_ibfk_2` (`tag_id`),
  CONSTRAINT `admin_user_tag_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `admin_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `admin_user_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_user_tag
-- ----------------------------
INSERT INTO `admin_user_tag` VALUES ('2', '10');
INSERT INTO `admin_user_tag` VALUES ('4', '10');
INSERT INTO `admin_user_tag` VALUES ('4', '11');
INSERT INTO `admin_user_tag` VALUES ('4', '12');
INSERT INTO `admin_user_tag` VALUES ('4', '13');

-- ----------------------------
-- Table structure for code
-- ----------------------------
DROP TABLE IF EXISTS `code`;
CREATE TABLE `code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `code` varchar(255) NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `expire_time` datetime NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `used` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `code_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of code
-- ----------------------------
INSERT INTO `code` VALUES ('41', '12', '501546', '2021-03-21 17:20:12', '2021-03-21 17:50:12', '895206853@qq.com', null, '');
INSERT INTO `code` VALUES ('42', '13', '527410', '2021-03-22 19:04:30', '2021-03-22 19:34:30', '492333711@qq.com', null, '\0');
INSERT INTO `code` VALUES ('43', '14', '682866', '2021-04-15 10:02:08', '2021-04-15 10:32:08', '1059344604@qq.com', null, '\0');
INSERT INTO `code` VALUES ('44', '15', '210768', '2021-04-15 11:44:04', '2021-04-15 12:14:04', 'qwer@qq.com', null, '\0');
INSERT INTO `code` VALUES ('45', '16', '767450', '2021-04-15 11:47:48', '2021-04-15 12:17:48', 'qwert@qq.com', null, '\0');
INSERT INTO `code` VALUES ('46', '17', '848868', '2021-04-15 11:49:37', '2021-04-15 12:19:37', 'asdfg@qq.com', null, '\0');
INSERT INTO `code` VALUES ('47', '18', '048271', '2021-04-15 11:50:31', '2021-04-15 12:20:31', 'zxcv@qq.com', null, '\0');
INSERT INTO `code` VALUES ('48', '19', '983163', '2021-04-15 11:50:57', '2021-04-15 12:20:57', 'fdgdfg@qq.com', null, '\0');
INSERT INTO `code` VALUES ('49', '20', '447964', '2021-04-15 11:51:30', '2021-04-15 12:21:30', 'dfgdfg@qq.com', null, '\0');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect` (
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `in_time` datetime NOT NULL,
  KEY `topic_id` (`topic_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `collect_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`),
  CONSTRAINT `collect_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of collect
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `in_time` datetime NOT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `up_ids` text,
  PRIMARY KEY (`id`),
  KEY `topic_id` (`topic_id`),
  KEY `user_id` (`user_id`),
  KEY `comment_in_time` (`in_time`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', '真挺不错的都', '24', '12', '2021-03-25 09:08:29', null, null);
INSERT INTO `comment` VALUES ('2', '哈哈哈', '22', '12', '2021-03-25 09:08:37', null, null);

-- ----------------------------
-- Table structure for flyway_schema_history
-- ----------------------------
DROP TABLE IF EXISTS `flyway_schema_history`;
CREATE TABLE `flyway_schema_history` (
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int(11) DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`),
  KEY `flyway_schema_history_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of flyway_schema_history
-- ----------------------------

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `target_user_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `read` bit(1) NOT NULL DEFAULT b'0',
  `content` longtext,
  PRIMARY KEY (`id`),
  KEY `topic_id` (`topic_id`),
  KEY `user_id` (`user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`),
  CONSTRAINT `notification_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `notification_ibfk_3` FOREIGN KEY (`target_user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notification
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_user
-- ----------------------------
DROP TABLE IF EXISTS `oauth_user`;
CREATE TABLE `oauth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_id` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT '',
  `login` varchar(255) NOT NULL DEFAULT '',
  `access_token` varchar(255) NOT NULL DEFAULT '',
  `in_time` datetime NOT NULL,
  `bio` text,
  `email` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  `union_id` varchar(255) DEFAULT NULL,
  `expires_in` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `oauth_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth_user
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  `pid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `value` (`value`),
  KEY `permission_pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', '首页', 'index', '0');
INSERT INTO `permission` VALUES ('2', '话题', 'topic', '0');
INSERT INTO `permission` VALUES ('3', '评论', 'comment', '0');
INSERT INTO `permission` VALUES ('4', '通知', 'notification', '0');
INSERT INTO `permission` VALUES ('5', '用户', 'user', '0');
INSERT INTO `permission` VALUES ('6', '验证码', 'code', '0');
INSERT INTO `permission` VALUES ('7', '标签', 'tag', '0');
INSERT INTO `permission` VALUES ('8', '权限', 'permission', '0');
INSERT INTO `permission` VALUES ('9', '系统', 'system', '0');
INSERT INTO `permission` VALUES ('10', '后台用户', 'admin_user', '0');
INSERT INTO `permission` VALUES ('11', '仪表盘', 'index:index', '1');
INSERT INTO `permission` VALUES ('12', '话题列表', 'topic:list', '2');
INSERT INTO `permission` VALUES ('13', '话题编辑', 'topic:edit', '2');
INSERT INTO `permission` VALUES ('14', '话题删除', 'topic:delete', '2');
INSERT INTO `permission` VALUES ('15', '话题加精', 'topic:good', '2');
INSERT INTO `permission` VALUES ('16', '话题置顶', 'topic:top', '2');
INSERT INTO `permission` VALUES ('17', '评论列表', 'comment:list', '3');
INSERT INTO `permission` VALUES ('18', '评论编辑', 'comment:edit', '3');
INSERT INTO `permission` VALUES ('19', '评论删除', 'comment:delete', '3');
INSERT INTO `permission` VALUES ('20', '通知列表', 'notification:list', '4');
INSERT INTO `permission` VALUES ('21', '通知删除', 'notification:delete', '4');
INSERT INTO `permission` VALUES ('22', '用户列表', 'user:list', '5');
INSERT INTO `permission` VALUES ('23', '用户编辑', 'user:edit', '5');
INSERT INTO `permission` VALUES ('24', '用户删除', 'user:delete', '5');
INSERT INTO `permission` VALUES ('25', '验证码列表', 'code:list', '6');
INSERT INTO `permission` VALUES ('26', '标签列表', 'tag:list', '7');
INSERT INTO `permission` VALUES ('27', '标签编辑', 'tag:edit', '7');
INSERT INTO `permission` VALUES ('28', '标签删除', 'tag:delete', '7');
INSERT INTO `permission` VALUES ('29', '标签同步', 'tag:async', '7');
INSERT INTO `permission` VALUES ('30', '权限列表', 'permission:list', '8');
INSERT INTO `permission` VALUES ('31', '权限编辑', 'permission:edit', '8');
INSERT INTO `permission` VALUES ('32', '权限删除', 'permission:delete', '8');
INSERT INTO `permission` VALUES ('33', '角色', 'role', '0');
INSERT INTO `permission` VALUES ('34', '日志', 'log', '0');
INSERT INTO `permission` VALUES ('35', '角色列表', 'role:list', '33');
INSERT INTO `permission` VALUES ('36', '角色编辑', 'role:edit', '33');
INSERT INTO `permission` VALUES ('37', '角色删除', 'role:delete', '33');
INSERT INTO `permission` VALUES ('38', '系统设置', 'system:edit', '9');
INSERT INTO `permission` VALUES ('39', '后台用户列表', 'admin_user:list', '10');
INSERT INTO `permission` VALUES ('40', '后台用户编辑', 'admin_user:edit', '10');
INSERT INTO `permission` VALUES ('41', '后台用户创建', 'admin_user:add', '10');
INSERT INTO `permission` VALUES ('42', '日志列表', 'log:list', '34');
INSERT INTO `permission` VALUES ('43', '用户刷新Token', 'user:refresh_token', '5');
INSERT INTO `permission` VALUES ('44', '权限添加', 'permission:add', '8');
INSERT INTO `permission` VALUES ('45', '索引单个话题', 'topic:index', '2');
INSERT INTO `permission` VALUES ('46', '索引全部话题', 'topic:index_all', '2');
INSERT INTO `permission` VALUES ('48', '删除索引', 'topic:delete_index', '2');
INSERT INTO `permission` VALUES ('49', '删除所有话题索引', 'topic:delete_all_index', '2');
INSERT INTO `permission` VALUES ('56', '敏感词', 'sensitive_word', '0');
INSERT INTO `permission` VALUES ('58', '敏感词列表', 'sensitive_word:list', '56');
INSERT INTO `permission` VALUES ('59', '敏感词添加', 'sensitive_word:add', '56');
INSERT INTO `permission` VALUES ('60', '敏感词编辑', 'sensitive_word:edit', '56');
INSERT INTO `permission` VALUES ('61', '敏感词删除', 'sensitive_word:delete', '56');
INSERT INTO `permission` VALUES ('62', '敏感词导入', 'sensitive_word:import', '56');
INSERT INTO `permission` VALUES ('64', '后台用户删除', 'admin_user:delete', '10');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('2', '全区管理员');
INSERT INTO `role` VALUES ('3', '分区管理员');
INSERT INTO `role` VALUES ('1', '超级管理员');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  KEY `role_id` (`role_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('2', '11');
INSERT INTO `role_permission` VALUES ('2', '12');
INSERT INTO `role_permission` VALUES ('2', '13');
INSERT INTO `role_permission` VALUES ('2', '14');
INSERT INTO `role_permission` VALUES ('2', '15');
INSERT INTO `role_permission` VALUES ('2', '16');
INSERT INTO `role_permission` VALUES ('2', '17');
INSERT INTO `role_permission` VALUES ('2', '18');
INSERT INTO `role_permission` VALUES ('2', '19');
INSERT INTO `role_permission` VALUES ('2', '26');
INSERT INTO `role_permission` VALUES ('2', '27');
INSERT INTO `role_permission` VALUES ('2', '28');
INSERT INTO `role_permission` VALUES ('2', '29');
INSERT INTO `role_permission` VALUES ('3', '11');
INSERT INTO `role_permission` VALUES ('3', '12');
INSERT INTO `role_permission` VALUES ('3', '13');
INSERT INTO `role_permission` VALUES ('3', '14');
INSERT INTO `role_permission` VALUES ('3', '15');
INSERT INTO `role_permission` VALUES ('3', '16');
INSERT INTO `role_permission` VALUES ('3', '17');
INSERT INTO `role_permission` VALUES ('3', '18');
INSERT INTO `role_permission` VALUES ('3', '19');
INSERT INTO `role_permission` VALUES ('1', '11');
INSERT INTO `role_permission` VALUES ('1', '12');
INSERT INTO `role_permission` VALUES ('1', '13');
INSERT INTO `role_permission` VALUES ('1', '14');
INSERT INTO `role_permission` VALUES ('1', '15');
INSERT INTO `role_permission` VALUES ('1', '16');
INSERT INTO `role_permission` VALUES ('1', '45');
INSERT INTO `role_permission` VALUES ('1', '46');
INSERT INTO `role_permission` VALUES ('1', '48');
INSERT INTO `role_permission` VALUES ('1', '49');
INSERT INTO `role_permission` VALUES ('1', '17');
INSERT INTO `role_permission` VALUES ('1', '18');
INSERT INTO `role_permission` VALUES ('1', '19');
INSERT INTO `role_permission` VALUES ('1', '20');
INSERT INTO `role_permission` VALUES ('1', '21');
INSERT INTO `role_permission` VALUES ('1', '22');
INSERT INTO `role_permission` VALUES ('1', '23');
INSERT INTO `role_permission` VALUES ('1', '24');
INSERT INTO `role_permission` VALUES ('1', '43');
INSERT INTO `role_permission` VALUES ('1', '25');
INSERT INTO `role_permission` VALUES ('1', '26');
INSERT INTO `role_permission` VALUES ('1', '27');
INSERT INTO `role_permission` VALUES ('1', '28');
INSERT INTO `role_permission` VALUES ('1', '29');
INSERT INTO `role_permission` VALUES ('1', '30');
INSERT INTO `role_permission` VALUES ('1', '31');
INSERT INTO `role_permission` VALUES ('1', '32');
INSERT INTO `role_permission` VALUES ('1', '44');
INSERT INTO `role_permission` VALUES ('1', '38');
INSERT INTO `role_permission` VALUES ('1', '39');
INSERT INTO `role_permission` VALUES ('1', '40');
INSERT INTO `role_permission` VALUES ('1', '41');
INSERT INTO `role_permission` VALUES ('1', '35');
INSERT INTO `role_permission` VALUES ('1', '36');
INSERT INTO `role_permission` VALUES ('1', '37');
INSERT INTO `role_permission` VALUES ('1', '42');
INSERT INTO `role_permission` VALUES ('1', '58');
INSERT INTO `role_permission` VALUES ('1', '59');
INSERT INTO `role_permission` VALUES ('1', '60');
INSERT INTO `role_permission` VALUES ('1', '61');
INSERT INTO `role_permission` VALUES ('1', '62');

-- ----------------------------
-- Table structure for sensitive_word
-- ----------------------------
DROP TABLE IF EXISTS `sensitive_word`;
CREATE TABLE `sensitive_word` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(255) NOT NULL COMMENT '敏感词',
  PRIMARY KEY (`id`),
  KEY `sensitive_word` (`word`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sensitive_word
-- ----------------------------

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT '',
  `description` varchar(1000) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `type` varchar(255) DEFAULT NULL,
  `option` varchar(255) DEFAULT NULL,
  `reboot` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `system_config_key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES ('1', 'admin_remember_me_max_age', '30', '登录后台记住我功能记住时间，单位：天', '23', 'number', null, '1');
INSERT INTO `system_config` VALUES ('2', 'base_url', 'http://localhost:8091', '网站部署后访问的域名，注意这个后面没有 \"/\"', '23', 'url', null, '0');
INSERT INTO `system_config` VALUES ('3', 'comment_layer', '1', '评论盖楼形式显示', '23', 'radio', null, '0');
INSERT INTO `system_config` VALUES ('4', 'cookie_domain', 'localhost', '存cookie时用到的域名，要与网站部署后访问的域名一致', '23', 'text', null, '0');
INSERT INTO `system_config` VALUES ('5', 'cookie_max_age', '604800', 'cookie有效期，单位秒，默认1周', '23', 'number', null, '0');
INSERT INTO `system_config` VALUES ('6', 'cookie_name', 'user_token', '存cookie时用到的名称', '23', 'text', null, '0');
INSERT INTO `system_config` VALUES ('7', 'create_comment_score', '5', '发布评论奖励的积分', '26', 'number', null, '0');
INSERT INTO `system_config` VALUES ('8', 'create_topic_score', '10', '创建话题奖励的积分', '26', 'number', null, '0');
INSERT INTO `system_config` VALUES ('9', 'delete_comment_score', '5', '删除评论要被扣除的积分', '26', 'number', null, '0');
INSERT INTO `system_config` VALUES ('10', 'delete_topic_score', '10', '删除话题要被扣除的积分', '26', 'number', null, '0');
INSERT INTO `system_config` VALUES ('11', 'intro', '<h5>SnakePants技术论坛</h5><p>在这里，您可以提问，回答，分享，诉说，这是个属于程序员的社区，欢迎您的加入！</p>', '站点介绍', '23', 'text', null, '0');
INSERT INTO `system_config` VALUES ('12', 'mail_host', 'smtp.qq.com', '邮箱的smtp服务器地址', '24', 'text', null, '0');
INSERT INTO `system_config` VALUES ('13', 'mail_password', 'mytgfetibpaxcagb', '发送邮件的邮箱密码', '24', 'password', null, '0');
INSERT INTO `system_config` VALUES ('14', 'mail_username', '213602723@qq.com', '发送邮件的邮箱地址', '24', 'email', null, '0');
INSERT INTO `system_config` VALUES ('15', 'name', 'SnakePants', '站点名称', '23', 'text', null, '0');
INSERT INTO `system_config` VALUES ('16', 'page_size', '20', '分页每页条数', '23', 'number', null, '0');
INSERT INTO `system_config` VALUES ('17', 'websocket', '0', '是否开启websocket功能', '45', 'radio', null, '1');
INSERT INTO `system_config` VALUES ('18', 'static_url', 'http://localhost:8091/data/upload/', '静态文件访问地址，主要用于上传图片的访问，注意最后有个\"/\"', '25', 'url', null, '0');
INSERT INTO `system_config` VALUES ('19', 'up_comment_score', '3', '点赞评论奖励评论作者的积分', '26', 'number', null, '0');
INSERT INTO `system_config` VALUES ('20', 'upload_image_size_limit', '2000', '上传头像文件大小，单位MB，默认2MB', '25', 'number', null, '0');
INSERT INTO `system_config` VALUES ('21', 'upload_path', 'data/upload/', '上传文件的路径，注意最后有个\"/\"', '25', 'text', null, '0');
INSERT INTO `system_config` VALUES ('22', 'up_topic_score', '3', '点赞话题奖励话题作者的积分', '26', 'number', null, '0');
INSERT INTO `system_config` VALUES ('23', null, null, '基础配置', '0', null, null, '0');
INSERT INTO `system_config` VALUES ('24', null, null, '邮箱配置', '0', null, null, '0');
INSERT INTO `system_config` VALUES ('25', null, null, '上传配置', '0', null, null, '0');
INSERT INTO `system_config` VALUES ('26', null, null, '积分配置', '0', null, null, '0');
INSERT INTO `system_config` VALUES ('27', null, null, 'Redis配置', '0', null, null, '0');
INSERT INTO `system_config` VALUES ('29', 'redis_host', '', 'redis服务host地址', '27', 'text', null, '0');
INSERT INTO `system_config` VALUES ('30', 'redis_port', '', 'redis服务端口（默认: 6379）', '27', 'number', null, '0');
INSERT INTO `system_config` VALUES ('31', 'redis_password', '', 'redis服务密码', '27', 'password', null, '0');
INSERT INTO `system_config` VALUES ('32', 'redis_timeout', '2000', '网站连接redis服务超时时间，单位毫秒', '27', 'number', null, '0');
INSERT INTO `system_config` VALUES ('33', 'redis_database', '0', '网站连接redis服务的哪个数据库，默认0号数据库，取值范围0-15', '27', 'number', null, '0');
INSERT INTO `system_config` VALUES ('35', null, null, 'Elasticsearch配置', '0', null, null, '0');
INSERT INTO `system_config` VALUES ('36', 'elasticsearch_host', '', 'elasticsearch服务的地址', '35', 'text', null, '0');
INSERT INTO `system_config` VALUES ('37', 'elasticsearch_port', '', 'elasticsearch服务的http端口', '35', 'number', null, '0');
INSERT INTO `system_config` VALUES ('38', 'elasticsearch_index', '', '索引的名字', '35', 'text', null, '0');
INSERT INTO `system_config` VALUES ('40', null, null, 'Github配置', '0', '', null, '0');
INSERT INTO `system_config` VALUES ('41', 'oauth_github_client_id', '', 'Github登录配置项ClientId', '40', 'text', null, '0');
INSERT INTO `system_config` VALUES ('42', 'oauth_github_client_secret', '', 'Github登录配置项ClientSecret', '40', 'password', null, '0');
INSERT INTO `system_config` VALUES ('43', 'oauth_github_callback_url', '', 'Github登录配置项回调地址', '40', 'url', null, '0');
INSERT INTO `system_config` VALUES ('44', 'topic_view_increase_interval', '600', '同一个用户浏览同一个话题多长时间算一次浏览量，默认10分钟，单位秒（只有当配置了redis才会生效）', '23', 'number', null, '0');
INSERT INTO `system_config` VALUES ('45', null, null, 'WebSocket', '0', '', null, '0');
INSERT INTO `system_config` VALUES ('46', 'websocket_url', '', 'websocket服务的连接地址', '45', 'text', null, '1');
INSERT INTO `system_config` VALUES ('48', 'theme', 'default', '系统主题', '23', 'select', 'default', '0');
INSERT INTO `system_config` VALUES ('49', null, null, '短信配置', '0', null, null, '0');
INSERT INTO `system_config` VALUES ('50', 'sms_access_key_id', '', '创建短信连接的key', '49', 'text', null, '0');
INSERT INTO `system_config` VALUES ('51', 'sms_secret', '', '创建短信连接的密钥', '49', 'password', null, '0');
INSERT INTO `system_config` VALUES ('52', 'sms_sign_name', '', '短信签名，在阿里云申请的签名', '49', 'text', null, '0');
INSERT INTO `system_config` VALUES ('53', 'sms_template_code', '', '短信模板Code，在阿里云申请的模板Code', '49', 'text', null, '0');
INSERT INTO `system_config` VALUES ('54', null, null, 'WeChat配置', '0', '', null, '0');
INSERT INTO `system_config` VALUES ('55', 'oauth_wechat_client_id', '', 'WeChat登录配置项AppId', '54', 'text', null, '0');
INSERT INTO `system_config` VALUES ('56', 'oauth_wechat_client_secret', '', 'WeChat登录配置项AppSecret', '54', 'password', null, '0');
INSERT INTO `system_config` VALUES ('57', 'oauth_wechat_callback_url', '', 'WeChat登录配置项回调地址', '54', 'url', null, '0');
INSERT INTO `system_config` VALUES ('58', 'sms_region_id', '', '短信服务所在区域 例如: cn-hangzhou', '49', 'text', null, '0');
INSERT INTO `system_config` VALUES ('59', 'upload_video_size_limit', '2000', '上传视频文件大小，单位MB，默认20MB', '25', 'number', null, '0');
INSERT INTO `system_config` VALUES ('60', null, null, 'Gitee配置', '0', '', null, '0');
INSERT INTO `system_config` VALUES ('61', 'oauth_gitee_client_id', '', 'Gitee登录配置项AppId', '60', 'text', null, '0');
INSERT INTO `system_config` VALUES ('62', 'oauth_gitee_client_secret', '', 'Gitee登录配置项AppSecret', '60', 'password', null, '0');
INSERT INTO `system_config` VALUES ('63', 'oauth_gitee_callback_url', '', 'Gitee登录配置项回调地址', '60', 'url', null, '0');
INSERT INTO `system_config` VALUES ('64', null, null, '新浪微博配置', '0', '', null, '0');
INSERT INTO `system_config` VALUES ('65', 'oauth_weibo_client_id', '', '新浪微博登录配置项AppId', '64', 'text', null, '0');
INSERT INTO `system_config` VALUES ('66', 'oauth_weibo_client_secret', '', '新浪微博登录配置项AppSecret', '64', 'password', null, '0');
INSERT INTO `system_config` VALUES ('67', 'oauth_weibo_callback_url', '', '新浪微博登录配置项回调地址', '64', 'url', null, '0');
INSERT INTO `system_config` VALUES ('68', null, null, '开源中国配置', '0', '', null, '0');
INSERT INTO `system_config` VALUES ('69', 'oauth_oschina_client_id', '', '开源中国登录配置项AppId', '68', 'text', null, '0');
INSERT INTO `system_config` VALUES ('70', 'oauth_oschina_client_secret', '', '开源中国登录配置项AppSecret', '68', 'password', null, '0');
INSERT INTO `system_config` VALUES ('71', 'oauth_oschina_callback_url', '', '开源中国登录配置项回调地址', '68', 'url', null, '0');

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(1000) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `topic_count` int(11) NOT NULL DEFAULT '0',
  `in_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `tag_in_time` (`in_time`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES ('8', '大众', null, null, '2', '2021-03-21 17:21:56');
INSERT INTO `tag` VALUES ('10', 'html', null, null, '11', '2021-03-24 19:17:37');
INSERT INTO `tag` VALUES ('11', 'java', null, null, '10', '2021-04-05 15:13:09');
INSERT INTO `tag` VALUES ('12', 'css', null, null, '5', '2021-04-05 15:13:09');
INSERT INTO `tag` VALUES ('13', 'python', null, null, '8', '2021-04-05 15:13:09');

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` longtext,
  `in_time` datetime NOT NULL,
  `modify_time` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `comment_count` int(11) NOT NULL DEFAULT '0',
  `collect_count` int(11) NOT NULL DEFAULT '0',
  `view` int(11) NOT NULL DEFAULT '0',
  `top` bit(1) NOT NULL DEFAULT b'0' COMMENT '置顶',
  `good` bit(1) NOT NULL DEFAULT b'0' COMMENT '精华',
  `up_ids` text,
  `costpoints` int(11) unsigned zerofill DEFAULT '00000000000',
  `category` int(11) DEFAULT '1' COMMENT '1-代表普通帖子，2-代表资源贴',
  `is_jubao` int(11) unsigned zerofill DEFAULT '00000000000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `user_id` (`user_id`),
  KEY `topic_in_time` (`in_time`),
  CONSTRAINT `topic_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topic
-- ----------------------------
INSERT INTO `topic` VALUES ('22', '欢迎加入', '可以多发点话题，会有加分的！', '2021-03-21 17:21:56', null, '12', '1', '0', '12', '\0', '\0', null, '00000000000', '1', '00000000000');
INSERT INTO `topic` VALUES ('24', '管理员测试1', '', '2021-03-24 20:52:29', null, '12', '1', '0', '5', '\0', '\0', null, '00000000000', '1', '00000000001');
INSERT INTO `topic` VALUES ('25', 'pdf测试', 'http://localhost:8091/data/upload/file/Wang/79f785f1-4b6c-4ebb-8ec1-37a3701528c2.pdf?v=9\n\n', '2021-04-05 19:00:09', null, '12', '0', '0', '4', '\0', '\0', null, '00000000005', '2', '00000000000');
INSERT INTO `topic` VALUES ('26', '近期新手任务', '', '2021-04-15 10:09:29', null, '14', '0', '0', '3', '', '\0', null, '00000000000', '3', '00000000000');
INSERT INTO `topic` VALUES ('27', 'python经典语法', '', '2021-04-15 11:01:03', null, '12', '0', '0', '1', '\0', '\0', null, '00000000000', '1', '00000000000');
INSERT INTO `topic` VALUES ('28', '敏感词测试', '好好学习，天天向上', '2021-04-15 11:20:10', null, '12', '0', '0', '2', '\0', '\0', null, '00000000000', '1', '00000000000');
INSERT INTO `topic` VALUES ('29', 'java中的引用', '![image](http://localhost:8091/data/upload/topic/Wang/761af72b-2d9c-4547-908e-2206caec4a1a.jpeg?v=6)\n\n', '2021-04-15 11:34:14', null, '12', '0', '0', '1', '\0', '', null, '00000000010', '1', '00000000000');
INSERT INTO `topic` VALUES ('30', '我上传了一些学习文件', 'http://localhost:8091/data/upload/file/Wang/ae642258-360d-4c29-8926-a9694c4d6539.pdf?v=0\n\n', '2021-04-15 11:38:08', null, '12', '0', '0', '1', '\0', '\0', null, '00000000005', '2', '00000000000');
INSERT INTO `topic` VALUES ('31', 'Java中的算法题', '![image](http://localhost:8091/data/upload/topic/gou/a8714c30-600c-448b-8f3a-ffefe663fc0a.png?v=8)\n\n', '2021-04-15 11:46:05', null, '15', '0', '0', '1', '\0', '\0', null, '00000000000', '1', '00000000000');
INSERT INTO `topic` VALUES ('32', '3分钟学会python之中的语法糖', '', '2021-04-15 11:48:57', null, '16', '0', '0', '1', '\0', '\0', null, '00000000003', '2', '00000000000');
INSERT INTO `topic` VALUES ('33', 'github中的fork', '', '2021-04-15 11:52:16', null, '20', '0', '0', '2', '\0', '\0', null, '00000000000', '1', '00000000000');
INSERT INTO `topic` VALUES ('35', '刚注册的小白', '', '2021-04-15 12:05:27', null, '17', '0', '0', '1', '\0', '\0', null, '00000000009', '2', '00000000000');

-- ----------------------------
-- Table structure for topic_tag
-- ----------------------------
DROP TABLE IF EXISTS `topic_tag`;
CREATE TABLE `topic_tag` (
  `tag_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  KEY `tag_id` (`tag_id`),
  KEY `topic_id` (`topic_id`),
  CONSTRAINT `topic_tag_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`),
  CONSTRAINT `topic_tag_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topic_tag
-- ----------------------------
INSERT INTO `topic_tag` VALUES ('8', '22');
INSERT INTO `topic_tag` VALUES ('10', '24');
INSERT INTO `topic_tag` VALUES ('10', '25');
INSERT INTO `topic_tag` VALUES ('10', '26');
INSERT INTO `topic_tag` VALUES ('13', '27');
INSERT INTO `topic_tag` VALUES ('8', '28');
INSERT INTO `topic_tag` VALUES ('11', '29');
INSERT INTO `topic_tag` VALUES ('13', '30');
INSERT INTO `topic_tag` VALUES ('11', '30');
INSERT INTO `topic_tag` VALUES ('10', '30');
INSERT INTO `topic_tag` VALUES ('11', '31');
INSERT INTO `topic_tag` VALUES ('10', '31');
INSERT INTO `topic_tag` VALUES ('13', '32');
INSERT INTO `topic_tag` VALUES ('11', '33');
INSERT INTO `topic_tag` VALUES ('11', '35');
INSERT INTO `topic_tag` VALUES ('10', '35');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) DEFAULT '',
  `avatar` varchar(1000) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `bio` varchar(1000) DEFAULT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  `in_time` datetime NOT NULL,
  `token` varchar(255) NOT NULL DEFAULT '',
  `telegram_name` varchar(255) DEFAULT NULL,
  `email_notification` bit(1) NOT NULL DEFAULT b'0',
  `active` bit(1) NOT NULL DEFAULT b'0',
  `is_jubao` int(11) unsigned zerofill DEFAULT '00000000000',
  `is_jinyan` int(11) unsigned zerofill DEFAULT '00000000000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `token` (`token`),
  KEY `user_email` (`email`),
  KEY `user_in_time` (`in_time`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('12', 'Wang', '$2a$10$rdW8m1YRkt39I.Hz6PeIG.dJCtLnFVTTds5lU.y22i2abK0/7m9qC', 'http://localhost:8091/data/upload/avatar/Wang/avatar.jpeg?v=2', '895206853@qq.com', null, null, null, '80', '2021-03-21 17:20:12', '959d5284-67b4-45dd-a3c0-4a378efaf956', null, '\0', '', '00000000001', '00000000000');
INSERT INTO `user` VALUES ('13', 'zhiwen', '$2a$10$ANJbBBP40z.C0SCOIqweO.Bj8cdmQhHDVdG7CWByVmL4X6MjgWX5e', 'http://localhost:8091/data/upload/avatar/zhiwen/avatar.png', '492333711@qq.com', null, null, null, '4345', '2021-03-22 19:04:30', '58f9a2e3-ee0b-4856-b68a-0e58d08e565c', null, '\0', '\0', '00000000000', '00000000000');
INSERT INTO `user` VALUES ('14', '管理员', '$2a$10$RDoZml62u0f4AOaKbRzYwuBqrD6fjMCpyRb8jsfIhYlXfVux85Ni6', 'http://localhost:8091/data/upload/avatar/admin/avatar.jpeg?v=1', '1059344604@qq.com', null, null, null, '10', '2021-04-15 10:02:08', '4fe10c03-9274-40d2-8f9c-e8fd43f0f46b', null, '\0', '', '00000000000', '00000000000');
INSERT INTO `user` VALUES ('15', 'gou', '$2a$10$Iakdp4c.kQOsZJIgbHjbI.CUQnG5HyqNr8A4.1Mj9FspJF/fhGCDi', 'http://localhost:8091/data/upload/avatar/gou/avatar.jpeg?v=2', 'qwer@qq.com', null, null, null, '10345', '2021-04-15 11:44:04', '92ac503b-838b-48a4-a4b4-3660e02b683c', null, '\0', '', '00000000000', '00000000000');
INSERT INTO `user` VALUES ('16', 'zhu', '$2a$10$KhuIGy1lUQG0QTJ.97fNHuhRXb3tepNOfuSKNvILVC.4ix3Sz8j2C', 'http://localhost:8091/data/upload/avatar/zhu/avatar.jpeg?v=2', 'qwert@qq.com', null, null, null, '10345', '2021-04-15 11:47:48', '241dafb8-2d2f-4758-811d-114908163ce5', null, '\0', '', '00000000000', '00000000000');
INSERT INTO `user` VALUES ('17', 's1mple', '$2a$10$CPXikDQOVCn6uZ64LYQX5.IlnJew4Za5NoLYM3TrXpwZRZQWphnhu', 'http://localhost:8091/data/upload/avatar/s1mple/avatar.png', 'asdfg@qq.com', null, null, null, '355', '2021-04-15 11:49:37', 'dd889b6f-761d-4f80-8da9-aeb10e8893b1', null, '\0', '', '00000000000', '00000000000');
INSERT INTO `user` VALUES ('18', 'zzff', '$2a$10$1F4HU6HkRd99dEN69jDw9uMMXW4dv5ahXIWsWAJCj0jNMOOAwdnW6', 'http://localhost:8091/data/upload/avatar/zzff/avatar.png', 'zxcv@qq.com', null, null, null, '23423', '2021-04-15 11:50:31', '8683f428-1ef8-4838-b3d6-c28cd5cfda81', null, '\0', '', '00000000000', '00000000000');
INSERT INTO `user` VALUES ('19', 'zhizz', '$2a$10$oHTK1c2gc02Q.YZqeKPa6e5RgM.C9aVE/.R.BHRqLhan3ap3XlSei', 'http://localhost:8091/data/upload/avatar/zhizz/avatar.png', 'fdgdfg@qq.com', null, null, null, '66', '2021-04-15 11:50:57', 'de43631b-966b-4e27-8650-f2032bda29c6', null, '\0', '', '00000000000', '00000000000');
INSERT INTO `user` VALUES ('20', 'qingss', '$2a$10$jw2r4lZpaStYqH6vjr8JRuXZraZQXYjeT/EIYZxnz8IO5NdmR.FzK', 'http://localhost:8091/data/upload/avatar/qingss/avatar.jpeg?v=1', 'dfgdfg@qq.com', null, null, null, '23423', '2021-04-15 11:51:30', 'c049f687-e652-4f06-9336-0f6d7588a3b8', null, '\0', '', '00000000000', '00000000000');

-- ----------------------------
-- Table structure for user_topic_cost
-- ----------------------------
DROP TABLE IF EXISTS `user_topic_cost`;
CREATE TABLE `user_topic_cost` (
  `user_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL,
  KEY `user_tag_ibfk_1` (`user_id`),
  KEY `user_tag_ibfk_2` (`topic_id`),
  CONSTRAINT `user_tag_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_tag_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_topic_cost
-- ----------------------------
INSERT INTO `user_topic_cost` VALUES ('12', '22');
INSERT INTO `user_topic_cost` VALUES ('12', '24');
INSERT INTO `user_topic_cost` VALUES ('12', '25');
INSERT INTO `user_topic_cost` VALUES ('12', '27');
INSERT INTO `user_topic_cost` VALUES ('12', '28');
INSERT INTO `user_topic_cost` VALUES ('12', '29');
INSERT INTO `user_topic_cost` VALUES ('12', '30');
INSERT INTO `user_topic_cost` VALUES ('15', '31');
INSERT INTO `user_topic_cost` VALUES ('16', '32');
INSERT INTO `user_topic_cost` VALUES ('20', '33');
INSERT INTO `user_topic_cost` VALUES ('17', '35');

-- ----------------------------
-- Table structure for voter_vote
-- ----------------------------
DROP TABLE IF EXISTS `voter_vote`;
CREATE TABLE `voter_vote` (
  `vId` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `describe` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `selection` varchar(10000) CHARACTER SET utf8mb4 DEFAULT NULL,
  `type` int(11) DEFAULT '0',
  `limit` int(11) DEFAULT '-1',
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`vId`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of voter_vote
-- ----------------------------
INSERT INTO `voter_vote` VALUES ('1', 'This is a vote title :)', 'And here is a describe of the vote XD', '<%1<%92<%Vote for Xiaoli<%2<%42<%Vote for Zhanghua<%3<%41<%Vote for Ergou<%4<%37<%Vote for Guawazi<%5<%48<%Vote for Benwei<%6<%50<%Vote for Adler', '0', '2', null);
INSERT INTO `voter_vote` VALUES ('4', '刘家良的是不是龟', '关于刘家良是不是龟', '<%1<%0<%是<%2<%0<%不是', '1', '-1', null);
INSERT INTO `voter_vote` VALUES ('5', '刘家良的是不是龟', '关于刘家良是不是龟', '<%1<%0<%是<%2<%0<%不是', '1', '-1', null);
INSERT INTO `voter_vote` VALUES ('6', '天气好不好', '天气好不好', '<%1<%0<%好<%2<%0<%不好<%3<%0<%还行', '1', '-1', null);
INSERT INTO `voter_vote` VALUES ('7', '天气好不阿红', '好', '<%1<%0<%好<%2<%0<%不好 <%3<%0<%还行', '1', '-1', null);
INSERT INTO `voter_vote` VALUES ('8', '天气好不阿红', '好', '<%1<%0<%好<%2<%0<%不好 <%3<%0<%还行', '0', '-1', null);
INSERT INTO `voter_vote` VALUES ('9', '天气好不好', '好', '<%1<%0<%好<%2<%0<%不好<%3<%0<%还行', '1', '-1', null);
INSERT INTO `voter_vote` VALUES ('10', '天气好不好', '挺好', '<%1<%0<%好<%2<%0<%不好 <%3<%0<%还行', '1', '-1', null);
INSERT INTO `voter_vote` VALUES ('11', '天气好不好', '好', '<%1<%0<%好<%2<%0<%不好<%3<%0<%还行', '1', '-1', null);
INSERT INTO `voter_vote` VALUES ('12', '天气好不好大解开了解开了', '好', '<%1<%0<%好<%2<%0<%不好<%3<%0<%还行', '0', '-1', null);
INSERT INTO `voter_vote` VALUES ('13', '天气好不好大解开了解开了', '好', '<%1<%0<%好<%2<%0<%不好<%3<%0<%还行', '0', '-1', null);
INSERT INTO `voter_vote` VALUES ('14', '天气好不好大解开了解开了', '好', '<%1<%4<%好<%2<%0<%不好<%3<%0<%还行', '1', '-1', null);
INSERT INTO `voter_vote` VALUES ('15', '今天天气好不好', '天气好吗', '<%1<%2<%好<%2<%2<%不好<%3<%1<%还行', '1', '-1', null);
INSERT INTO `voter_vote` VALUES ('16', '今天天气好不好', '关于天气', '<%1<%1<%好<%2<%0<%不好<%3<%0<%还行', '1', '-1', null);
INSERT INTO `voter_vote` VALUES ('17', '今天天气好不好', '天气', '<%1<%0<%好<%2<%0<%不好<%3<%0<%还行', '1', '-1', null);
INSERT INTO `voter_vote` VALUES ('18', '今天天气好不好', '关于天气', '<%1<%1<%好<%2<%0<%不好<%3<%0<%还行', '1', '-1', null);
INSERT INTO `voter_vote` VALUES ('19', '世界上最好的语言是什么', 'balabala', '<%1<%1<%java<%2<%0<%c<%3<%0<%php<%4<%0<%python', '1', '-1', null);

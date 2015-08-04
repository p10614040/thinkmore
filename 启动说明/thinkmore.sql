# Host: 192.168.80.233  (Version: 5.6.17-enterprise-commercial-advanced)
# Date: 2015-06-11 15:43:53
# Generator: MySQL-Front 5.3  (Build 4.214)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "blog"
#

CREATE TABLE `blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Data for table "blog"
#

INSERT INTO `blog` VALUES (1,'JFinal Demo Title here1','JFinal Demo Content here'),(2,'test 1','test 1'),(3,'test 2','test 2'),(4,'test 3','test 3');

#
# Structure for table "category"
#

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_name` varchar(255) DEFAULT NULL COMMENT '类别名称',
  `parent_category_id` int(11) DEFAULT NULL COMMENT '父类别,父类别为0表示为第一大类',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='产品分类';

#
# Data for table "category"
#

INSERT INTO `category` VALUES (1,'技术',0),(2,'产品',0),(3,'模块',0),(4,'解决方案',0),(5,'JAVA',1),(6,'javascript',1),(7,'ORALCE',1),(8,'网管产品',2);

#
# Structure for table "product"
#

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL COMMENT '大类',
  `subtype` varchar(255) DEFAULT NULL COMMENT '子类',
  `dept` varchar(255) DEFAULT NULL COMMENT '所属部门',
  `name` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `desc` mediumtext COMMENT '描述',
  `status` varchar(255) DEFAULT NULL COMMENT '产品状态',
  `cTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `mTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "product"
#


#
# Structure for table "product_collect"
#

CREATE TABLE `product_collect` (
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  PRIMARY KEY (`product_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品收藏表';

#
# Data for table "product_collect"
#


#
# Structure for table "product_comment"
#

CREATE TABLE `product_comment` (
  `pc_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `product_id` int(11) DEFAULT NULL COMMENT '产品ID',
  `create_time` datetime DEFAULT NULL COMMENT '评论时间',
  `title` varchar(255) DEFAULT NULL COMMENT '评论标题',
  `content` text COMMENT '评论内容',
  `version_id` varchar(255) DEFAULT NULL COMMENT '版本ID',
  PRIMARY KEY (`pc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品评论表';

#
# Data for table "product_comment"
#


#
# Structure for table "product_tag"
#

CREATE TABLE `product_tag` (
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `tag_name` varchar(255) NOT NULL DEFAULT '' COMMENT '标签ID',
  PRIMARY KEY (`product_id`,`tag_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品标签表';

#
# Data for table "product_tag"
#


#
# Structure for table "product_version"
#

CREATE TABLE `product_version` (
  `ver_Id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL DEFAULT '0',
  `ver_code` varchar(255) DEFAULT NULL COMMENT '版本号',
  `desc` text COMMENT '版本说明',
  `document` varchar(255) DEFAULT NULL COMMENT '文档地址',
  `download` varchar(255) DEFAULT NULL COMMENT '下载地址',
  `cTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `mTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ver_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "product_version"
#


#
# Structure for table "role"
#

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(255) NOT NULL DEFAULT '' COMMENT '角色表',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

#
# Data for table "role"
#


#
# Structure for table "user"
#

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户姓名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

#
# Data for table "user"
#


#
# Structure for table "user_role"
#

CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `role_id` varchar(255) NOT NULL DEFAULT '' COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色';

#
# Data for table "user_role"
#


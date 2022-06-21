



# admin表
CREATE TABLE `admin` (
          `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
          `admin_name` VARCHAR(255) NOT NULL COMMENT '管理员名称',
          `admin_password` VARCHAR(255) NOT NULL COMMENT '管理员密码',
          PRIMARY KEY (`id`)
        ) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4



INSERT INTO `admin` VALUES (NULL, 'syning', 'syning')


# 创建ad表
CREATE TABLE `t_ad` (
          `ad_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '广告id',
          `ad_title` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '广告标题',
          `ad_type` INT(11) NOT NULL COMMENT '广告类型id',
          `ad_url` VARCHAR(500) DEFAULT NULL COMMENT '广告的url地址',
          `ad_sort` VARCHAR(255) DEFAULT NULL COMMENT 'sort修改为跳转的地址',
          `ad_begin_time` DATETIME DEFAULT NULL COMMENT '广告开始时间',
          `ad_end_time` DATETIME DEFAULT NULL COMMENT '广告结束时间',
          `ad_add_time` DATETIME DEFAULT NULL COMMENT '广告添加时间',
          PRIMARY KEY (`ad_id`)
        ) ENGINE=INNODB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4


# 创建ad_type表
CREATE TABLE `t_ad_type` (
             `ad_type_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '广告类型id',
             `ad_type_title` VARCHAR(45) DEFAULT NULL COMMENT '广告类型名称',
             `ad_type_tag` VARCHAR(45) DEFAULT NULL COMMENT '广告类型标识(首页顶部广告、轮播图广告、文章详情广告)',
             `ad_type_sort` INT(11) DEFAULT '10' COMMENT '广告类型排序，越小排在前面',
             `ad_type_add_time` DATETIME DEFAULT NULL COMMENT '广告添加时间',
             PRIMARY KEY (`ad_type_id`)
           ) ENGINE=INNODB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4



# 创建article表
CREATE TABLE `t_article` (
             `article_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '文章id',
             `user_id` INT(11) NOT NULL COMMENT '发布用户id',
             `article_title` VARCHAR(500) NOT NULL COMMENT '文章标题',
             `article_add_time` DATETIME DEFAULT NULL COMMENT '创建时间',
             `article_centext` TEXT NOT NULL COMMENT '文章内容',
             `article_good_number` INT(11) NOT NULL DEFAULT '0' COMMENT '点赞次数',
             `article_look_number` INT(11) NOT NULL DEFAULT '0' COMMENT '观看次数',
             `article_collection_number` INT(11) NOT NULL DEFAULT '0' COMMENT '收藏次数',
             `article_type_id` INT(11) DEFAULT NULL COMMENT '文章类型id',
             PRIMARY KEY (`article_id`)
           ) ENGINE=INNODB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4


# 创建article_tag表
CREATE TABLE `t_article_tag` (
                 `article_tag_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '文章标签id',
                 `article_tag_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '标签名称',
                 `article_tag_add_time` DATETIME DEFAULT NULL COMMENT '添加时间',
                 PRIMARY KEY (`article_tag_id`)
               ) ENGINE=INNODB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4



# 文章和标签的关联中间表
CREATE TABLE `t_article_tag_list` (
                      `article_tag_list_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '文章对应标签id',
                      `article_id` INT(11) DEFAULT NULL COMMENT '文章id',
                      `article_tag_id` INT(11) DEFAULT NULL COMMENT '文章标签id',
                      PRIMARY KEY (`article_tag_list_id`)
                    ) ENGINE=INNODB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4


# 文章类型
CREATE TABLE `t_article_type` (
                  `article_type_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '文章分类id',
                  `article_type_parent_id` INT(11) DEFAULT NULL COMMENT '文章分类父id',
                  `article_type_name` VARCHAR(45) NOT NULL DEFAULT 'default' COMMENT '文章分类名称',
                  `article_type_sort` INT(11) NOT NULL DEFAULT '0' COMMENT '分类排序，越小排前面',
                  `article_type_add_time` DATETIME DEFAULT NULL COMMENT '添加时间',
                  PRIMARY KEY (`article_type_id`)
                ) ENGINE=INNODB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4



# 评论表
CREATE TABLE `t_comment` (
                             `comment_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '文章评论id',
                             `article_id` INT(11) NOT NULL COMMENT '文章id',
                             `user_id` INT(11) NOT NULL COMMENT '评论人(用户id)',
                             `content` TEXT NOT NULL COMMENT '评论的内容',
                             `comment_time` DATETIME DEFAULT NULL COMMENT '评论时间',
                             `comment_good_number` INT(11) NOT NULL DEFAULT '0' COMMENT '点赞次数',
                             PRIMARY KEY (`comment_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4



# 回复评论的表
CREATE TABLE `t_comment_reply` (
                                   `comment_reply_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '评论回复id',
                                   `comment_id` INT(11) NOT NULL COMMENT '针对评论的id',
                                   `comment_user_id` INT(11) NOT NULL COMMENT '被评论的人的id',
                                   `reply_user_id` INT(11) NOT NULL COMMENT '评论用户的id',
                                   `reply_content` TEXT NOT NULL COMMENT '回复评论的评论',
                                   `comment_reply_add_time` DATETIME DEFAULT NULL COMMENT '回复的时间',
                                   PRIMARY KEY (`comment_reply_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4





# 链接表
CREATE TABLE `t_link` (
          `link_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '友情链接id',
          `link_title` VARCHAR(50) NOT NULL DEFAULT 'link' COMMENT '友情链接标题',
          `link_url` VARCHAR(500) NOT NULL DEFAULT '#' COMMENT '友情链接地址',
          `link_logo_url` VARCHAR(500) DEFAULT NULL COMMENT '友情链接logo',
          `link_add_time` DATETIME DEFAULT NULL COMMENT '添加链接的时间',
          PRIMARY KEY (`link_id`)
        ) ENGINE=INNODB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4



# user表
 CREATE TABLE `t_user` (
          `user_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
          `user_name` VARCHAR(50) NOT NULL COMMENT '用户名',
          `user_password` VARCHAR(50) NOT NULL COMMENT '密码',
          `user_register_time` DATETIME DEFAULT NULL COMMENT '创建时间',
          PRIMARY KEY (`user_id`)
        ) ENGINE=INNODB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4





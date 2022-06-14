
# 用户表
CREATE TABLE t_user (
	user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT'用户id',
	user_name VARCHAR(50) NOT NULL COMMENT'用户名',
	user_password VARCHAR(50) NOT NULL COMMENT'密码',
	user_register_time DATETIME COMMENT'创建时间');



# 文章表
CREATE TABLE t_article (
	article_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT'文章id',
	user_id INT NOT NULL COMMENT'发布用户id',
	article_title VARCHAR(500) NOT NULL COMMENT'文章标题',
	article_add_time DATETIME COMMENT'创建时间',
	article_centext TEXT NOT NULL COMMENT'文章内容',
	article_good_number INT NOT NULL DEFAULT 0 COMMENT'点赞次数',
	article_look_number INT NOT NULL DEFAULT 0 COMMENT'观看次数',
	article_collection_number INT NOT NULL DEFAULT 0 COMMENT'收藏次数');



# 文章标签
CREATE TABLE t_article_tag (
	article_tag_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT'文章标签id',
	article_tag_name VARCHAR(32) NOT NULL DEFAULT'' COMMENT'标签名称',
	article_tag_add_time DATETIME COMMENT'添加时间');




# 文章与标签的中间表
CREATE TABLE t_article_tag_list (
	article_tag_list_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT'文章对应标签id',
	article_id INT NOT NULL COMMENT'文章id',
	article_tag_id INT NOT NULL COMMENT'文章标签id');




# 对文章的评论
CREATE TABLE t_comment (
	comment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT'文章评论id',
	article_id INT NOT NULL COMMENT'文章id',
	user_id INT NOT NULL COMMENT'评论人(用户id)',
	comment_time DATETIME COMMENT'评论时间',
	comment_good_number INT NOT NULL  DEFAULT 0 COMMENT'点赞次数');



# 对评论的回复
CREATE TABLE t_comment_reply (
	comment_reply_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT'评论回复id',
	comment_id INT NOT NULL COMMENT'针对评论的id',
	comment_user_id INT NOT NULL COMMENT'被评论的人的id',
	reply_user_id INT NOT NULL COMMENT'评论用户的id',
	comment_reply_add_time DATETIME COMMENT'回复的时间');




# 链接
CREATE TABLE t_link(
	link_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT'友情链接id',
	link_title VARCHAR(50) NOT NULL DEFAULT'link' COMMENT'友情链接标题',
	link_url VARCHAR(500) NOT NULL DEFAULT'#' COMMENT'友情链接地址',
	link_logo_url VARCHAR(500) COMMENT'友情链接logo',
	link_add_time DATETIME COMMENT'添加链接的时间');




# 广告

CREATE TABLE t_ad (
	ad_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT'广告id',
	ad_title VARCHAR(255) NOT NULL DEFAULT'' COMMENT'广告标题',
	ad_type INT NOT NULL COMMENT'广告类型id',
	ad_url VARCHAR(500) COMMENT'广告的url地址',
	ad_sort INT COMMENT'广告排序，越小排在前面',
	ad_begin_time DATETIME COMMENT'广告开始时间',
	ad_end_time DATETIME COMMENT'广告结束时间',
	ad_add_time DATETIME COMMENT'广告添加时间');
	
	


# 广告类型
CREATE TABLE t_ad_type (
	ad_type_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT'广告类型id',
	ad_type_title VARCHAR(45) COMMENT'广告类型名称',
	ad_type_tag VARCHAR(45) COMMENT'广告标识(首页顶部广告、轮播图广告、文章详情广告)',
	ad_type_sort INT DEFAULT 10 COMMENT'广告类型排序，越小排在前面',
	ad_type_add_time DATETIME COMMENT'广告添加时间');













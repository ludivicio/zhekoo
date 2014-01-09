



/* 管理员表 */
CREATE TABLE `zhe_admin` (
  `id` mediumint(6) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(32) NOT NULL,
  `role_id` smallint(5) NOT NULL,
  `last_ip` varchar(15) NOT NULL,
  `last_time` int(10) NOT NULL DEFAULT '0',
  `email` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/* 管理员角色表 */
CREATE TABLE `zhe_admin_role` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `remark` text NOT NULL,
  `ordid` tinyint(3) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/* 文章表 */
CREATE TABLE `zhe_article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` smallint(4) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `colors` varchar(10) NOT NULL,
  `author` varchar(100) NOT NULL,
  `tags` varchar(100) NOT NULL,
  `img` varchar(255) NOT NULL,
  `intro` varchar(255) NOT NULL,
  `info` text NOT NULL,
  `comments` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `hits` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览数',
  `ordid` tinyint(3) unsigned NOT NULL DEFAULT '255' COMMENT '排序值',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0',
  `last_time` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `seo_title` varchar(255) NOT NULL,
  `seo_keys` varchar(255) NOT NULL,
  `seo_desc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


/* 文章分类表 */
CREATE TABLE `zhe_article_cate` (
  `id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL,
  `alias` varchar(50) NOT NULL,
  `img` varchar(255) NOT NULL,
  `pid` smallint(4) unsigned NOT NULL DEFAULT '0',
  `spid` varchar(50) NOT NULL,
  `ordid` smallint(4) unsigned NOT NULL DEFAULT '255',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `seo_title` varchar(255) NOT NULL,
  `seo_keys` varchar(255) NOT NULL,
  `seo_desc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/* 随机用户表（系统自动生成的用户） */
CREATE TABLE `zhe_auto_user` (
  `id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `users` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/* 敏感字过滤表 */
CREATE TABLE `zhe_badword` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `word_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1：禁用；2：替换；3：审核',
  `badword` varchar(100) NOT NULL,
  `replaceword` varchar(100) NOT NULL,
  `add_time` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/* 禁止IP表 */
CREATE TABLE `zhe_ipban` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `type` varchar(30) NOT NULL,
  `expires_time` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


/* 商品表 */
CREATE TABLE `zhe_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `key_id` varchar(50) NOT NULL,
  `tcolor` varchar(10) DEFAULT NULL,
  `goods_key` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL COMMENT '转换过的链接',
  `prices` varchar(50) DEFAULT NULL,
  `info` text,
  `img` varchar(255) DEFAULT NULL,
  `uname` varchar(20) DEFAULT NULL,
  `uid` int(10) DEFAULT NULL,
  `mall_id` int(10) unsigned DEFAULT NULL,
  `add_time` int(10) unsigned DEFAULT NULL,
  `post_time` int(10) unsigned DEFAULT NULL,
  `rate_best` int(10) DEFAULT NULL,
  `rate_good` int(10) DEFAULT NULL,
  `rate_bad` int(10) DEFAULT NULL,
  `favs` int(10) DEFAULT NULL,
  `hits` int(11) DEFAULT NULL,
  `ordid` tinyint(3) unsigned DEFAULT '255',
  `is_hot` tinyint(1) unsigned DEFAULT '0',
  `is_recommend` tinyint(1) unsigned DEFAULT '0',
  `is_localimg` tinyint(1) DEFAULT '0',
  `status` tinyint(1) unsigned DEFAULT '0',
  `collect_flag` tinyint(1) unsigned DEFAULT '1' COMMENT '0:采集未处理，1：已处理',
  `seo_title` varchar(255) DEFAULT NULL,
  `comments` int(10) DEFAULT NULL,
  `seo_keys` varchar(255) DEFAULT NULL,
  `seo_desc` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


/* 商品爆料表 */
CREATE TABLE `zhe_baoliao` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `orig` int(11) DEFAULT '0',
  `web` varchar(255) DEFAULT NULL,
  `info` text,
  `email` varchar(255) DEFAULT NULL,
  `add_time` int(10) DEFAULT '0',
  `type` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/* 商品分类表 */
CREATE TABLE `zhe_goods_cate` (
  `id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `alias` varchar(50) NOT NULL,
  `pid` smallint(4) unsigned NOT NULL DEFAULT '0',
  `spid` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `ordid` tinyint(3) unsigned NOT NULL DEFAULT '255',
  `seo_title` varchar(255) NOT NULL,
  `seo_keys` varchar(255) NOT NULL,
  `seo_desc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/* 商品评论表 */
CREATE TABLE `zhe_goods_comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `pid` int(10) DEFAULT '0',
  `uid` int(10) unsigned NOT NULL,
  `uname` varchar(20) DEFAULT NULL,
  `info` text,
  `digg` int(10) NOT NULL,
  `burn` int(10) NOT NULL,
  `add_time` int(10) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `client` varchar(20) DEFAULT 'pc',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/* 商城表 */
CREATE TABLE `zhe_mall` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aid` varchar(50) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `domain` varchar(255) NOT NULL,
  `abst` varchar(255) NOT NULL,
  `info` text,
  `url_dm` varchar(255) NOT NULL,
  `url_yqf` varchar(255) NOT NULL,
  `url_other` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `cps` varchar(255) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `cid` int(11) DEFAULT '0',
  `rebates` varchar(20) NOT NULL,
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `status` int(11) DEFAULT '1',
  `ordid` int(11) DEFAULT '0',
  `add_time` int(11) DEFAULT '0',
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_keys` varchar(255) DEFAULT NULL,
  `seo_desc` text,
  `index` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


/* 商城分类表 */
CREATE TABLE `zhe_mall_cate` (
  `id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `alias` varchar(50) NOT NULL,
  `pid` smallint(4) unsigned NOT NULL DEFAULT '0',
  `spid` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `ordid` tinyint(3) unsigned NOT NULL DEFAULT '255',
  `seo_title` varchar(255) NOT NULL,
  `seo_keys` varchar(255) NOT NULL,
  `seo_desc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/* 商城评论表 */
CREATE TABLE `zhe_mall_comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mall_id` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `uname` varchar(20) NOT NULL,
  `info` text NOT NULL,
  `add_time` int(10) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;




















































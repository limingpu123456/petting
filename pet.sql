/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3306
 Source Schema         : pet

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 02/06/2022 11:02:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `aid` bigint(20) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `uid` bigint(20) NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`aid`) USING BTREE,
  INDEX `FKt6huoueh6c1v1sjyi1n5qcn8o`(`uid`) USING BTREE,
  INDEX `FK5iqlpltdqtym3rd0wu1rv2qxj`(`address`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, '东莞理工学院', '11111111114', 16, '张三');
INSERT INTO `address` VALUES (3, '东莞理工学院', '11111111111', 3, '张三');
INSERT INTO `address` VALUES (4, '东莞理工学院', '11111111112', 4, '张三');
INSERT INTO `address` VALUES (5, '东莞理工学院1', '11111111112', 4, '张三');
INSERT INTO `address` VALUES (6, 'dgut', '11111111111', 3, '李四');
INSERT INTO `address` VALUES (7, '11', '15755581410', 1, '张三');

-- ----------------------------
-- Table structure for bkind
-- ----------------------------
DROP TABLE IF EXISTS `bkind`;
CREATE TABLE `bkind`  (
  `bkid` bigint(20) NOT NULL AUTO_INCREMENT,
  `bavatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bkindname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`bkid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bkind
-- ----------------------------
INSERT INTO `bkind` VALUES (1, NULL, '其他');
INSERT INTO `bkind` VALUES (2, NULL, '狗');
INSERT INTO `bkind` VALUES (3, NULL, '猫');
INSERT INTO `bkind` VALUES (4, NULL, '鼠');

-- ----------------------------
-- Table structure for contact
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact`  (
  `cid` bigint(20) NOT NULL AUTO_INCREMENT,
  `fromuid` bigint(20) NULL DEFAULT NULL,
  `touid` bigint(20) NULL DEFAULT NULL,
  `noread` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of contact
-- ----------------------------
INSERT INTO `contact` VALUES (25, 2, 1, 3);
INSERT INTO `contact` VALUES (26, 1, 2, 0);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime(0) NULL DEFAULT NULL,
  `fromavatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `fromuid` bigint(20) NULL DEFAULT NULL,
  `fromusername` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `isread` int(11) NULL DEFAULT NULL,
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `pid` bigint(20) NULL DEFAULT NULL,
  `touid` bigint(20) NULL DEFAULT NULL,
  `tousername` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`nid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 84 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (81, '2022-05-26 21:52:04', 'defaultavatar/avatar1.jpeg', 1, NULL, 0, '我购买了你的宠物，点击前往查看', 2, 2, NULL, 1);
INSERT INTO `notice` VALUES (82, '2022-05-26 21:52:24', 'defaultavatar/avatar1.jpeg', 1, NULL, 0, '111', NULL, 2, NULL, 0);
INSERT INTO `notice` VALUES (83, '2022-05-26 21:52:38', 'defaultavatar/avatar1.jpeg', 1, NULL, 0, '订单已成功，点击前往查看', 2, 2, NULL, 4);

-- ----------------------------
-- Table structure for pet
-- ----------------------------
DROP TABLE IF EXISTS `pet`;
CREATE TABLE `pet`  (
  `pid` bigint(20) NOT NULL AUTO_INCREMENT,
  `petname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uid` bigint(20) NULL DEFAULT NULL,
  `age` int(11) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bkid` bigint(20) NULL DEFAULT NULL,
  `skid` bigint(20) NULL DEFAULT NULL,
  `pk` int(11) NULL DEFAULT NULL,
  `price` double NULL DEFAULT NULL,
  `date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`pid`) USING BTREE,
  INDEX `FKlo4y9rjiy8vi8nqwlfy2etqc2`(`bkid`) USING BTREE,
  INDEX `FKh8jp99159p7hg4a5qgl1n9jt8`(`skid`) USING BTREE,
  INDEX `FKmhyngo1n0y99d024j39medxii`(`uid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 56 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pet
-- ----------------------------
INSERT INTO `pet` VALUES (5, '哈士奇', '男', 2, 5, '暂无', 2, 2, 0, 8000, '2020-03-12 07:07:23');
INSERT INTO `pet` VALUES (4, '博美', '女', 2, 12, '暂无', 2, 5, 3, 1000, '2020-03-12 07:07:23');
INSERT INTO `pet` VALUES (6, '狸花猫', '男', 3, 3, '暂无', 3, 16, 3, 2000, '2020-03-12 07:07:23');
INSERT INTO `pet` VALUES (50, '兔子1', '男', 4, 1, '暂无', 1, 21, 0, 120, '2020-05-10 00:25:19');
INSERT INTO `pet` VALUES (1, '金毛犬', '男', 1, 1, '暂无', 2, 3, 0, 8000, '2020-03-12 07:07:23');
INSERT INTO `pet` VALUES (2, '贵宾犬', '女', 2, 2, '暂无', 2, 4, 2, 7000, '2020-03-12 07:07:23');
INSERT INTO `pet` VALUES (3, '雪纳瑞', '男', 3, 1, '暂无', 2, 6, 0, 5000, '2020-03-12 07:07:23');
INSERT INTO `pet` VALUES (13, '二哈', '女', 3, 1, '暂无', 2, 2, 3, 0, '2020-03-12 07:07:23');
INSERT INTO `pet` VALUES (23, '二哈', '不限', 2, -1, '暂无', 2, 2, 3, -1, '2020-04-04 20:31:32');
INSERT INTO `pet` VALUES (36, '布偶猫', '女', 4, 3, '诚意出售布偶猫\n价格好商量', 3, 14, 0, 8000, '2020-04-20 15:42:11');
INSERT INTO `pet` VALUES (37, '仓鼠', '男', 4, 1, '暂无', 4, 17, 0, 500, '2020-04-20 16:34:30');
INSERT INTO `pet` VALUES (38, '中国狸花猫', '男', 4, 2, '暂无', 3, 16, 0, 1000, '2020-04-20 16:39:02');
INSERT INTO `pet` VALUES (39, '龙猫', '男', 4, 1, '低价出售', 4, 18, 0, 100, '2020-04-20 16:40:56');
INSERT INTO `pet` VALUES (40, '柴犬', '男', 4, 12, '免费出售', 2, 23, 0, 0, '2020-04-20 16:47:14');
INSERT INTO `pet` VALUES (41, '英国短毛猫', '男', 3, 2, '暂无', 3, 11, 0, 1000, '2020-04-20 23:51:07');
INSERT INTO `pet` VALUES (46, '兔子', '不限', 1, -1, '暂无', 1, 21, 3, -1, '2020-05-09 12:44:34');

-- ----------------------------
-- Table structure for petorder
-- ----------------------------
DROP TABLE IF EXISTS `petorder`;
CREATE TABLE `petorder`  (
  `poid` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime(0) NULL DEFAULT NULL,
  `pid` bigint(20) NULL DEFAULT NULL,
  `uid` bigint(20) NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `recipientname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `postatu` int(11) NULL DEFAULT NULL,
  `puid` bigint(20) NULL DEFAULT NULL,
  `price` double NULL DEFAULT NULL,
  `newphone` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `newaddress` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `newrecipientname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`poid`) USING BTREE,
  INDEX `FKcvs0y4lmusnvlglnbkyr9d9ej`(`uid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of petorder
-- ----------------------------
INSERT INTO `petorder` VALUES (15, '2022-05-26 21:52:38', 2, 1, '11', '15755581410', '张三', 1, 2, 7000, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for photo
-- ----------------------------
DROP TABLE IF EXISTS `photo`;
CREATE TABLE `photo`  (
  `ppid` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pid` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`ppid`) USING BTREE,
  INDEX `FK9i1q5mqg8yel0917jkdnb2g3t`(`pid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 83 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of photo
-- ----------------------------
INSERT INTO `photo` VALUES (1, 'petimg/1.jpg', 5);
INSERT INTO `photo` VALUES (2, 'petimg/2.jpeg', 5);
INSERT INTO `photo` VALUES (3, 'petimg/3.jpg', 5);
INSERT INTO `photo` VALUES (4, 'petimg/4.jpg', 5);
INSERT INTO `photo` VALUES (5, 'petimg/5.jpg', 5);
INSERT INTO `photo` VALUES (6, 'petimg/13.jpg', 4);
INSERT INTO `photo` VALUES (7, 'petimg/14.jpg', 4);
INSERT INTO `photo` VALUES (8, 'defaultpetimg/nodata.jpg', 6);
INSERT INTO `photo` VALUES (75, 'petimg/2b6cb7f59e0f46ac810736a98409379e.jpg', 50);
INSERT INTO `photo` VALUES (10, 'petimg/6.jpg', 1);
INSERT INTO `photo` VALUES (11, 'petimg/7.jpg', 1);
INSERT INTO `photo` VALUES (12, 'petimg/8.jpg', 2);
INSERT INTO `photo` VALUES (13, 'petimg/9.jpg', 2);
INSERT INTO `photo` VALUES (14, 'petimg/10.jpeg', 2);
INSERT INTO `photo` VALUES (15, 'petimg/11.jpg', 3);
INSERT INTO `photo` VALUES (16, 'petimg/12.jpg', 3);
INSERT INTO `photo` VALUES (17, 'defaultpetimg/nodata.jpg', 13);
INSERT INTO `photo` VALUES (20, 'defaultpetimg/nodata.jpg', 20);
INSERT INTO `photo` VALUES (22, 'defaultpetimg/nodata.jpg', 21);
INSERT INTO `photo` VALUES (23, 'defaultpetimg/nodata.jpg', 22);
INSERT INTO `photo` VALUES (24, 'defaultpetimg/nodata.jpg', 23);
INSERT INTO `photo` VALUES (31, 'petimg/af650dcce9684daca55fd1eb0c96d4e31.jpg', 24);
INSERT INTO `photo` VALUES (33, 'defaultpetimg/nodata.jpg', 26);
INSERT INTO `photo` VALUES (32, 'defaultpetimg/nodata.jpg', 25);
INSERT INTO `photo` VALUES (34, 'defaultpetimg/nodata.jpg', 27);
INSERT INTO `photo` VALUES (35, 'defaultpetimg/nodata.jpg', 28);
INSERT INTO `photo` VALUES (36, 'defaultpetimg/nodata.jpg', 29);
INSERT INTO `photo` VALUES (46, 'petimg/d9d2cc0f02434fa1bac25312cc55b5b8u=2614637423,3136057852&fm=26&gp=0.jpg', 36);
INSERT INTO `photo` VALUES (74, 'petimg/0fc8a562ca6446ec89de4b32d7d6e5ce.jpg', 49);
INSERT INTO `photo` VALUES (73, 'petimg/b71945fe7e5f49018b558eb7be497f59.jpg', 49);
INSERT INTO `photo` VALUES (47, 'petimg/26257fac337c421bac55baecc2dbc373timg.jpg', 36);
INSERT INTO `photo` VALUES (48, 'petimg/4f2349771da5422999894d138c1c7309timg猫.jpg', 36);
INSERT INTO `photo` VALUES (49, 'petimg/4bef858f98314f8aa5ca13b45d1f00d8timg.jpg', 36);
INSERT INTO `photo` VALUES (50, 'petimg/1b531cb29d454b5eb7d18e37342a2f90.jpg', 37);
INSERT INTO `photo` VALUES (51, 'petimg/63a084a04f454ed0a6d3008948b348e0.jpg', 37);
INSERT INTO `photo` VALUES (52, 'petimg/36c7c7b4b04947f7a2aced41820038cc.jpg', 38);
INSERT INTO `photo` VALUES (53, 'petimg/2914d08c200c43dbb94375a4d23f217f.jpg', 38);
INSERT INTO `photo` VALUES (54, 'petimg/cfe759921c054c23a287b1ac49163be1.jpg', 38);
INSERT INTO `photo` VALUES (55, 'petimg/29870cd789c0495cb0b7a909f366ecdb.jpg', 39);
INSERT INTO `photo` VALUES (56, 'petimg/191a81eb625245e0bb6b10e75024e97e.jpg', 40);
INSERT INTO `photo` VALUES (57, 'petimg/b92d1d3a89894850b082fe16d53c28ce.jpg', 40);
INSERT INTO `photo` VALUES (58, 'petimg/de6633bce1ea4cd2a7c4c0c7acba28e8.jpg', 40);
INSERT INTO `photo` VALUES (59, 'petimg/62234edd420a404199ae69af5c8544b3.jpg', 41);
INSERT INTO `photo` VALUES (60, 'petimg/b6516dae930c4610b81c6a5faf28ed1e.jpg', 41);
INSERT INTO `photo` VALUES (61, 'petimg/082f3534b9f54105933d24e4084e318f.jpg', 42);
INSERT INTO `photo` VALUES (62, 'petimg/72b3237393e240bbb0e92a838810c3cf.jpg', 42);
INSERT INTO `photo` VALUES (63, 'petimg/764b30377e53457ea8a9730c9d706e0d.jpg', 43);
INSERT INTO `photo` VALUES (64, 'petimg/7cd3b5c5fff5439c8dc6c3b90b85f545.jpg', 43);
INSERT INTO `photo` VALUES (65, 'defaultpetimg/nodata.jpg', 44);
INSERT INTO `photo` VALUES (68, 'defaultpetimg/nodata.jpg', 46);
INSERT INTO `photo` VALUES (76, 'petimg/f1f57a3796e747feaacaeac93b22c323.jpg', 50);

-- ----------------------------
-- Table structure for skind
-- ----------------------------
DROP TABLE IF EXISTS `skind`;
CREATE TABLE `skind`  (
  `skid` bigint(20) NOT NULL AUTO_INCREMENT,
  `savatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `skindname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bkid` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`skid`) USING BTREE,
  INDEX `FK1uyynijhcss2rtpyqs4hfpq7u`(`bkid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of skind
-- ----------------------------
INSERT INTO `skind` VALUES (1, NULL, '其他', 2);
INSERT INTO `skind` VALUES (2, NULL, '哈士奇', 2);
INSERT INTO `skind` VALUES (3, NULL, '金毛犬', 2);
INSERT INTO `skind` VALUES (4, NULL, '贵宾犬', 2);
INSERT INTO `skind` VALUES (5, NULL, '博美犬', 2);
INSERT INTO `skind` VALUES (6, NULL, '雪纳瑞犬', 2);
INSERT INTO `skind` VALUES (7, NULL, '其他', 3);
INSERT INTO `skind` VALUES (8, NULL, '俄罗斯蓝猫', 3);
INSERT INTO `skind` VALUES (9, NULL, '英国长毛猫', 3);
INSERT INTO `skind` VALUES (10, NULL, '美国短毛猫', 3);
INSERT INTO `skind` VALUES (11, NULL, '英国短毛猫', 3);
INSERT INTO `skind` VALUES (12, NULL, '加拿大无毛猫', 3);
INSERT INTO `skind` VALUES (13, NULL, '伯曼猫', 3);
INSERT INTO `skind` VALUES (14, NULL, '布偶猫', 3);
INSERT INTO `skind` VALUES (15, NULL, '苏格兰折耳猫', 3);
INSERT INTO `skind` VALUES (16, NULL, '狸花猫', 3);
INSERT INTO `skind` VALUES (17, NULL, '仓鼠', 4);
INSERT INTO `skind` VALUES (18, NULL, '龙猫', 4);
INSERT INTO `skind` VALUES (19, NULL, '四川简州猫', 3);
INSERT INTO `skind` VALUES (20, NULL, '其他', 4);
INSERT INTO `skind` VALUES (21, NULL, '其他', 1);
INSERT INTO `skind` VALUES (23, NULL, '柴犬', 2);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `realname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `telphone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `wechat` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `idcard` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (2, 'avatar/5c8d649def7e48ce96be98e974791adb1.jpg', NULL, '123456', '李四', '男', '12345678911', '李四1', NULL, '440202184511103041', 1);
INSERT INTO `user` VALUES (3, 'avatar/8118456fd0db48129e05eb8a35b490ccfooter1.jpg', NULL, '123456', '王五', '男', '11111111115', '王五2', NULL, '440202184511103040', 1);
INSERT INTO `user` VALUES (4, 'defaultavatar/avatar1.jpeg', NULL, '123456', '张三', '保密', '11111111112', '新用户', NULL, '440202184511103042', 1);
INSERT INTO `user` VALUES (1, 'defaultavatar/avatar1.jpeg', NULL, '123456', '狄仁杰', '保密', '11111111113', '狄仁杰', NULL, '440202184511103043', 1);
INSERT INTO `user` VALUES (6, 'avatar/28d4efeb50ee4a3984506518e807d5b01.jpg', NULL, '123456', NULL, NULL, NULL, '管理员', NULL, NULL, 0);
INSERT INTO `user` VALUES (16, 'defaultavatar/avatar1.jpeg', NULL, '123', '张三1', '男', '11111111114', '张三1', NULL, '112345200101011230', 1);

SET FOREIGN_KEY_CHECKS = 1;

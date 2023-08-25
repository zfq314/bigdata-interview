/*
 Navicat Premium Data Transfer

 Source Server         : 名城10.10.80.140
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : 10.10.80.140:3306
 Source Schema         : decent_cloud

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 16/05/2023 15:18:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Procedure structure for coursr_ub
-- ----------------------------
DROP PROCEDURE IF EXISTS `coursr_ub`;
delimiter ;;
CREATE PROCEDURE `coursr_ub`(in v_total_gold DOUBLE,v_date date,out v_cnt int)
BEGIN
	#Routine body goes here...
	
	DECLARE count_ts int default 0; -- 条数
	DECLARE sum_jz DOUBLE default 0; -- 总金重
	DECLARE one_jz DOUBLE default 0; -- 单条金重
	
	
  -- 声明游标
	
	DECLARE jz_cur cursor for  select jz from t_ka_splsz where rq=v_date ORDER BY id desc;
-- 	打开游标
	open jz_cur;
	
	REPEAT
	 FETCH jz_cur into one_jz;
	 set sum_jz=sum_jz+one_jz;
	 set count_ts=count_ts+1;
UNTIL sum_jz>=v_total_gold END REPEAT;

-- 关闭游标
CLOSE jz_cur;

-- 返回结果集

select count_ts into v_cnt;

	
	
	

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;

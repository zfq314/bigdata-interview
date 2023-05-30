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

 Date: 23/02/2023 10:29:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Procedure structure for gn_zt_kcrzzjz_fjz
-- ----------------------------
DROP PROCEDURE IF EXISTS `gn_zt_kcrzzjz_fjz`;
delimiter ;;
CREATE PROCEDURE `gn_zt_kcrzzjz_fjz`(IN V_WDMC VARCHAR(60), IN V_RQ DATE)
A:BEGIN
#######################################################################
## 描    述：库存日总账_反向结转
## 创 建 人：赵富强
## 创建时间：2023-02-22
## 参    数：V_WDMC 网点名称
##           V_RQ 日期，例如传入日期为T,则数据恢复至T日的期初数据
########################################################################
DECLARE V_JZRQ VARCHAR(20); 
DECLARE V_JZRQ1 VARCHAR(20);
DECLARE V_NIAN1 INT; 
DECLARE V_YUE1 INT; 
DECLARE V_RI1 INT; 
DECLARE V_RQ1 DATE;

DECLARE V_UUID VARCHAR(36); -- 记录日志时保证当前存储过程的ID一致

/*声明一个变量，标识是否有sql异常*/
DECLARE hasSqlError int DEFAULT FALSE;
DECLARE ERR_CODE VARCHAR(20);
DECLARE ERR_MSG TEXT;
/*在执行过程中出任何异常设置hasSqlError为TRUE*/
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
   GET CURRENT DIAGNOSTICS CONDITION 1
   ERR_CODE = MYSQL_ERRNO, ERR_MSG = MESSAGE_TEXT;
   SET hasSqlError = TRUE;
  END;
	
	
SET V_JZRQ = CAST(V_RQ AS CHAR(20));
SET V_JZRQ1 = CAST(DATE_ADD(V_RQ, INTERVAL 1 DAY) AS CHAR(20));

SET V_UUID = (SELECT UUID());


-- 先检验结转日期当天是否有期末金重，大于0才能反结转
IF EXISTS(SELECT SUM(IFNULL(QMJZ, 0)) FROM T_KA_ZTKCRZZ WHERE RQ = V_RQ AND WDMC = V_WDMC HAVING SUM(IFNULL(QMJZ, 0)) = 0) THEN
  SELECT '还没有进行过结转，不能反结转该天' as MSG_INFO;
  INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz_fjz', v_user_name, '执行失败，还没有进行过结转，不能反结转该天');
  UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz_fjz';
  LEAVE A;
END IF;

-- 再检验结转日期下一天是否有期末金重，等于0才能反结转
IF EXISTS(SELECT SUM(IFNULL(QMJZ, 0)) FROM T_KA_ZTKCRZZ WHERE RQ = DATE_ADD(V_RQ, INTERVAL 1 DAY) AND WDMC = V_WDMC HAVING SUM(IFNULL(QMJZ, 0)) <> 0) THEN
  SELECT CONCAT('下一天 ',V_jzrq1, ' 已经进行过结转，不能反结转 ', V_jzrq) as MSG_INFO;
  INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) 
       VALUES (v_uuid, 'gn_szzt_kcrzzjz_fjz', v_user_name, CONCAT('执行失败，下一天', V_jzrq1, ' 已经进行过结转，不能反结转 ', V_jzrq));
  UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz_fjz';
  LEAVE A;
END IF;

-- 再检验结转日期必须大于(服务器日期日时-3), 即只能反结转昨天和前天
IF (V_RQ < DATE_SUB(DATE(NOW()), INTERVAL 3 DAY) and (v_wdmc<>'浙江德鑫') and (v_wdmc<>'沈阳展厅')) THEN
  SELECT '只能反结转昨天或前天' as MSG_INFO;
  UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz_fjz';
  LEAVE A;
END IF;	
	

IF (V_RQ < DATE_SUB(DATE(NOW()), INTERVAL 7 DAY) and (v_wdmc='浙江德鑫') ) THEN
  SELECT '只能反结7天以内的数据' as MSG_INFO;
  UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz_fjz';
  LEAVE A;
END IF;		


IF (V_RQ < DATE_SUB(DATE(NOW()), INTERVAL 40 DAY) and (v_wdmc='沈阳展厅') ) THEN
  SELECT '只能暂时反结40天以内的数据' as MSG_INFO;
  UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz_fjz';
  LEAVE A;
END IF;		


-- 删除结转网点下一天的数据
DELETE FROM T_KA_ZTKCRZZ WHERE RQ = DATE_ADD(V_RQ, INTERVAL 1 DAY) AND WDMC = V_WDMC;
DELETE FROM T_KA_YSRZZH WHERE RQ = DATE_ADD(V_RQ, INTERVAL 1 DAY) AND WDMC = V_WDMC;
DELETE FROM T_KA_LLRZZH WHERE RQ = DATE_ADD(V_RQ, INTERVAL 1 DAY) AND WDMC = V_WDMC;



-- 清除结转网点反结转日期当天的入库、出库、期末数据、盈亏数据
UPDATE T_KA_ZTKCRZZ SET RKJS=0,RKJZ=0,RKJE=0,CKJS=0,CKJZ=0,CKJE=0,QMJS=0,QMJZ=0,QMJE=0,YKJS=0,YKJZ=0,YKJE=0
WHERE RQ=V_RQ AND WDMC=V_WDMC ;
UPDATE T_KA_YSRZZH SET ZJJE=0,JSJE=0,JCJE=0
WHERE RQ=V_RQ AND WDMC=V_WDMC ;
UPDATE T_KA_LLRZZH SET ZJJZ=0,JSJZ=0,JCJZ=0
WHERE RQ=V_RQ AND WDMC=V_WDMC; 

SET V_RQ1 = DATE_ADD(V_RQ, INTERVAL 1 DAY);
SET V_NIAN1 = YEAR(V_RQ1);
SET V_YUE1 = MONTH(V_RQ1);
SET V_RI1 = DAY(V_RQ1);


-- 当反结转日期的下一天是下个月1号时，删除展厅库存总帐中下一天的期初数据
IF V_RI1 = 1 THEN
  DELETE FROM T_KA_ZTKCZZ WHERE NIAN = V_NIAN1 AND YUE = V_YUE1 AND WDMC = V_WDMC;
END IF;

-- 异常处理
IF hasSqlError THEN 
  ROLLBACK;
  SELECT CONCAT('gn_zt_kcrzzjz_fjz:', ERR_CODE, ' ', ERR_MSG) AS MSG_INFO;
  INSERT INTO T_DAILY_INTERREST_ERR_LOG SELECT NOW(), 'gn_zt_kcrzzjz_fjz', CONCAT(ERR_CODE, ' ', ERR_MSG);
   
ELSE
  COMMIT;
  INSERT INTO T_DAILY_INTERREST_LOG(RUN_TIME, LOG_INFO) 
  SELECT NOW(), 'gn_zt_kcrzzjz_fjz执行成功';
END IF;	
	
	
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;

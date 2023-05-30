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

 Date: 23/02/2023 10:29:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Procedure structure for gn_zt_kcrzzjz
-- ----------------------------
DROP PROCEDURE IF EXISTS `gn_zt_kcrzzjz`;
delimiter ;;
CREATE PROCEDURE `gn_zt_kcrzzjz`(IN V_WDMC varchar(60), v_rq date, v_user_name varchar(60))
A:BEGIN
/*************************************************
    描    述：库存日结-名城
    创 建 人：赵富强
    创建时间：2022-02-21
**************************************************/	
	DECLARE V_CKMC VARCHAR(200);
  DECLARE V_LSH INT; -- 单据流水号
  DECLARE V_ICOUNT INT; -- 计数  
  DECLARE V_RQ1 DATETIME; -- 参数日期 + 1
  DECLARE V_NIAN1 INT; -- 参数日期+1的年
  DECLARE V_YUE1 INT; -- 参数日期+1的月
  DECLARE V_RI1 INT; -- 参数日期+1的日
	DECLARE V_UUID VARCHAR(36);
	
 /*声明一个变量，标识是否有SQL异常*/
DECLARE hasSqlError INT DEFAULT FALSE;
DECLARE ERR_CODE VARCHAR(20);
DECLARE ERR_MSG TEXT;

/*在执行过程中出任何异常设置hasSqlError为TRUE*/
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
   BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1
    ERR_CODE = MYSQL_ERRNO, ERR_MSG = MESSAGE_TEXT;
    SET hasSqlError = TRUE;
   END;	

set v_uuid = (select uuid()); 


INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '开始执行储存过程');

IF ((SELECT EXECUTE_STATUS FROM T_STORED_PROCEDURE_STATUS WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz') = 1) THEN 
 SELECT '存储过程正在执行中！' as MSG_INFO;
 INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，存储过程正在执行中！');
 LEAVE A;
 ELSE 
 UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 1 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
END IF;

  -- 检验网点名称是否为空
  IF IFNULL(V_WDMC,'') = '' THEN 
    SELECT '网点不能为空' AS MSG_INFO;
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，网点不能为空');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
    -- 如果为空，退出存储过程
    LEAVE A;
  END IF;
	
	  IF (V_RQ IS NULL) OR (V_RQ <= DATE('2000-1-1')) THEN
    SELECT '日期不能为空' AS MSG_INFO;
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，日期不能为空');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
    -- 如果为空，退出存储过程
    LEAVE A;
  END IF;
	
	-- 判断中间是否有漏执行
	IF V_RQ > (select max(rq) from t_ka_ztkcrzz where wdmc = v_wdmc) THEN 

  SELECT '前面有库存日结未执行，需手动处理!!!' AS MSG_INFO;	
	 INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，前面有日结未执行，需手动处理!!!');
	 UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
	 LEAVE A;
END IF;	

  -- 判断单据审核状态 开始 --------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	-- 产品包审核 检查
  IF EXISTS(SELECT 1 FROM T_FAST_PACKAGE T1 
                    INNER JOIN T_SHOWROOM T2 
                       ON T1.SHOWROOM_IDENTITY = T2.SHOWROOM_IDENTITY 
                      AND T2.IS_DELETE = 0
                    WHERE T1.SALES_STATUS_ID <> 2 AND DATE(T1.gzrq) = V_RQ AND T2.SHOWROOM_NAME = V_WDMC AND T1.IS_DELETE = 0
           ) THEN
					 
      SELECT '"产品包"中还有单据业务未确认，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"产品包"中还有单据业务未确认，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF;


  IF EXISTS(SELECT 1 FROM t_from_customer_decommissioning WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ /*审核时间*/AND SHOWROOM_NAME = V_WDMC AND STATUS = 0) THEN
      SELECT '"客户退饰单"中还有单据没有审核，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"客户退饰单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
      END IF;	
			
#  没有单据  称重入库单
-- 			begin raiserror('"称重入库单"中还有单据没有审核，不能结转该日期',16,1) return end--后台成品入库单
-- if exists(select djlsh from sjdcdh where ifnull(djstate,'')='' and rq=@rq and dcwdmc=v_wdmc)

  IF EXISTS(SELECT 1 FROM t_from_allocation_out_warehouse WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND call_out_showroom_name = V_WDMC AND STATUS = 0) THEN
      /* 
			-- 调拨单不再因为审核拦截库存日结转，改为系统为这些日期自动延期一天， modify by 胡巍
			SELECT '"调拨出库单"中还有单据没有审核，不能结转该日期' AS MSG_INFO;  -- 在EOS叫做调拨出库单
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_szzt_kcrzzjz', v_user_name, '执行失败，"调拨出库单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_szzt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
			*/
			update t_from_allocation_out_warehouse set rq = DATE_ADD(V_RQ,interval 1 day) , create_time = date_add(create_time, interval 1 day)
			where APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND call_out_showroom_name = V_WDMC AND STATUS = 0;
  END IF; -- 后台调拨出库单
	
	
	# 调出打印单当天未审核处理
	if exists(select 1 from t_bf_gold_transfer_out_print where approve_status = 0 and date(rq) = v_rq and transfer_out_showroom = v_wdmc and status = 0) then
  update t_bf_gold_transfer_out_print 
		   set rq = date_add(v_rq, interval 1 day),
					    create_time = date_add(create_time, interval 1 day) 
			where approve_status = 0 
			  and date(rq) = v_rq 
					and transfer_out_showroom = v_wdmc 
					and status = 0;
  end if;
	
	  IF EXISTS(SELECT 1 FROM t_from_warehouse_transfer WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0) THEN
      SELECT '"转仓单"中还有单据没有审核，不能结转该日期' AS MSG_INFO;
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"转仓单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
      END IF;
      
  IF EXISTS(SELECT 1 FROM t_from_warehouse_transfer WHERE verification_status = 0 AND DATE(verification_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0) THEN
      SELECT '"转仓单"中还有单据没有记帐，不能结转该日期' AS MSG_INFO;
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"转仓单"中还有单据没有记帐，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
      END IF;
			
	-- 购客户成品 来源于客户退饰单 t_from_customer_decommissioning 且retract_type='购成品'
	  IF EXISTS(SELECT 1 FROM t_from_customer_decommissioning WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0 and retract_type='购成品') THEN
      SELECT '"购客户成品"中还有单据没有审核，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"购客户成品"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF; 
	
-- 产品方杰 确认，购客户成品不需要判断记账状态	
-- 	begin raiserror('"购客户成品"中还有单据没有记帐，不能结转该日期',16,1) return end 
-- if exists(select djlsh from dbckdh where ifnull(djstate,'')='' and dcrq=@rq and dcwdmc=v_wdmc)


 IF EXISTS(SELECT 1 FROM t_from_singleton_allocation_out_warehouse WHERE approve_status = 0 AND DATE(approve_time) = V_RQ AND call_out_showroom_name = V_WDMC AND STATUS = 0) THEN -- 调出网点名称
      SELECT '"单件调拨出库单"中还有单据没有审核，不能结转该日期' AS MSG_INFO;
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"单件调拨出库单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
	  END IF; 

-- 入库单
-- 这块逻辑修改 RECEIVE_STATUS >20 未从 这个表里面 判断 T_RECEIVE_STREAM_TYPE
  IF EXISTS(SELECT 1 FROM T_RECEIVE WHERE SUPPLIER_TYPE = 1 and RECEIVE_STATUS >20 /*NOT IN(SELECT TYPE FROM T_RECEIVE_STREAM_TYPE A WHERE A.NAME ='委外收货流水' )*/ AND DATE(create_time) = V_RQ AND showroom_name = V_WDMC AND STATUS = 0) THEN -- 33 入库完成 36  结束 39  已退货,这三个状态值表示单据完成
      SELECT '"入库单"中还有单据没有完成，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"入库单"中还有单据没有完成，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF;  -- 后台委外入库单

-- 退货单
  IF EXISTS(SELECT 1 FROM t_receive_return WHERE return_status <> 20/* 已完成*/ AND DATE(create_time) = V_RQ AND showroom_name = V_WDMC AND STATUS = 0) THEN
      SELECT '"退货单"中还有单据没有完成，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"退货单"中还有单据没有完成，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF; 
	

-- 产品方杰确认	退客户金料单    就是委外付料单	
  IF EXISTS(SELECT 1 FROM t_from_retreat_customer_gold_materials WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0) THEN
      SELECT '"退客户金料单"中还有单据没有审核，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_szzt_kcrzzjz', v_user_name, '执行失败，"退客户金料单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_szzt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF; 		
		

  IF EXISTS(SELECT 1 FROM t_from_weighing WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0) THEN
      SET V_CKMC = (SELECT GROUP_CONCAT(DISTINCT warehouse_name) FROM t_from_weighing WHERE APPROVE_STATUS = 0 AND DATE(CREATE_TIME) = V_RQ AND SHOWROOM_NAME = V_WDMC);
      SELECT CONCAT('"盘点称重单"中还有单据没有审核，不能结转该日期 ','未审核的柜台有：',V_CKMC) AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, CONCAT('执行失败，"盘点称重单"中还有单据没有审核，不能结转该日期 ','未审核的柜台有：',V_CKMC));
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF;  -- 后台称重单		
		
		-- 产品方杰确认 名城暂时没有过账的功能    先取审核日期
  IF EXISTS(SELECT 1 FROM T_SALE_FROM WHERE APPROVE_STATUS = 0 AND DATE(approve_status) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0) THEN
      SELECT '"销售单"中还有单据没有审核，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"销售单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF; 		
		
-- 		目前没有结欠单
-- 		begin raiserror('"结欠单"中还有单据没有审核，不能结转该日期',16,1) return end 
-- if exists(select djlsh from lldh where ifnull(djstate,'')='' and rq=@rq and wdmc=v_wdmc)

	IF EXISTS(SELECT 1 FROM t_from_receive_material WHERE APPROVE_STATUS = 0 AND DATE(RQ) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0) THEN
      SELECT '"来料单"中还有单据没有审核，不能结转该日期' AS MSG_INFO; -- 来料单
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"来料单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF; 	
	
	IF EXISTS(SELECT 1 FROM t_from_buy_material WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0) THEN
      SELECT '"购料单"中还有单据没有审核，不能结转该日期' AS MSG_INFO; -- eos 名叫 金料采购单 深圳名叫 购客户金料
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"购料单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF; 	-- 后台 购料单	

-- 付客户金料 名叫 退客户金料表
  IF EXISTS(SELECT 1 FROM t_from_retreat_customer_gold_materials WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0) THEN
      SELECT '"退客户金料"中还有单据没有审核，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"退客户金料"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF;  -- 后台退客户金料
		
-- eos 期初盘点单 -- 名城 -- 素金盈亏单 

  IF EXISTS(SELECT 1 FROM t_from_sujin_profit_loss WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0) THEN
      SELECT '"素金盈亏单"中还有单据没有审核，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"素金盈亏单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF; 

-- 		现场收款单   客户汇款确认单 当日汇款确认单 匿名收款单 		
		
  IF EXISTS(SELECT 1 FROM t_from_scene_receipt WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0) THEN
      SELECT '"现场收款单"中还有单据没有审核，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"现场收款单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF;   -- 现场收款单  		
	
	
  IF EXISTS(SELECT 1 FROM t_from_remittance_confirmation_sheet WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0 and type=1) THEN
      SELECT '"客户汇款确认单"中还有单据没有审核，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"客户汇款确认单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF;   -- 客户汇款确认单  		
	
	  IF EXISTS(SELECT 1 FROM t_from_remittance_confirmation_sheet WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0 and type=2) THEN
      SELECT '"当日汇款确认单"中还有单据没有审核，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"当日汇款确认单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF;   -- 当日汇款确认单  
	
		  IF EXISTS(SELECT 1 FROM t_from_remittance_confirmation_sheet WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0 and type=3) THEN
      SELECT '"匿名收款单"中还有单据没有审核，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"匿名收款单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF;   -- 匿名收款单 	
	

-- eos 存款单 
			  IF EXISTS(SELECT 1 FROM t_from_deposit WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0 ) THEN
      SELECT '"现金存取单"中还有单据没有审核，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"现金存取单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF;   -- 现金存取单 	
	
	
		IF EXISTS(SELECT 1 FROM t_from_account_adjustment WHERE APPROVE_STATUS = 0 AND DATE(approve_time) = V_RQ AND SHOWROOM_NAME = V_WDMC AND STATUS = 0 ) THEN
      SELECT '"调账单"中还有单据没有审核，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"调账单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 退出存储过程
      LEAVE A;
  END IF;   -- 调账单 	

-- 没有记账 不用此判断
-- 	if exists(select djlsh from tzdh where ifnull(djstate,'')='审核' and rq=@rq and drwdmc=v_wdmc)---调账单
-- begin raiserror('"调账单"中还有单据没有记帐，不能结转该日期',16,1) return end  

-- 深圳 settlement_date 时间 
IF EXISTS(SELECT 1 FROM t_from_customer_settlement_price WHERE DATE(approve_time) = V_RQ and showroom_name = v_wdmc and IFNULL(approve_status, 0) =  0) THEN 
    SELECT '"客户结价单"中还有单据没有审核，不能结转该日期' AS MSG_INFO; 
    INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行失败，"客户结价单"中还有单据没有审核，不能结转该日期');
    UPDATE T_STORED_PROCEDURE_STATUS SET EXECUTE_STATUS = 0 WHERE STORED_PROCEDURE_NAME = 'gn_zt_kcrzzjz';
      -- 
      LEAVE A;
  END IF; -- 客户结价单
		
  -- 判断单据审核状态 结束 --------------------------------------------------------------------------------------------------------------------------------------------------------------

  -- 变量赋值
  SET V_RQ1 = DATE_ADD(V_RQ, INTERVAL 1 DAY);
  SET V_NIAN1 = YEAR(V_RQ1);
  SET V_YUE1 = MONTH(V_RQ1);
  SET V_RI1 = DAY(V_RQ1);

  -- 开始事务
  START TRANSACTION;
	
-- -------------------------------------------开始 处理展厅库存日总帐结转

-- 在商品流水帐中取出期间发的数据
drop temporary table if exists temp1;
create temporary table temp1 as
select wdmc,ckmc,jsmc,plmc,
0 as qcjs,
0 as qcjz,
0 as qcje,
0 as rkjs,
sum(case when  swlx<>'客户出货' and  sffx='发' then round(js,0) else 0 end) as ckjs,
0 as rkjz,
sum(case when  swlx<>'客户出货' and  sffx='发' then round(jz,3) else 0 end)as ckjz,
0 as rkje,
sum(case when  swlx<>'客户出货' and  sffx='发' then round(bqjg,0) else 0 end) as ckje,
0 as qmjs,
0 as qmjz,
0 as qmje
from t_ka_splsz 
where DATE(rq)=v_rq and sffx='发' and wdmc=v_wdmc 
group by wdmc,ckmc,jsmc,plmc;

-- 在商品流水帐中取出期间收的数据
drop temporary table if exists temp2;
create temporary table temp2 as
select wdmc,ckmc,jsmc,plmc,
0 as qcjs,
0 as qcjz,
0 as qcje,
sum(case when  swlx<>'称重入库' and sffx='收' and (((ifnull(CHF,'') like '深圳展厅%' and djm<>'单件调拨入库单') or ifnull(CHF,'') not like '深圳展厅%') OR v_wdmc<>'深圳展厅')then round(js,3) else 0 end) as rkjs,
0 as ckjs,
sum(case when  swlx<>'称重入库' and sffx='收' and (((ifnull(CHF,'') like '深圳展厅%' and djm<>'单件调拨入库单') or ifnull(CHF,'') not like '深圳展厅%')OR v_wdmc<>'深圳展厅')  then round(jz,3) else 0 end) as rkjz,
0 as ckjz,
sum(case when  swlx<>'称重入库' and sffx='收' and (((ifnull(CHF,'') like '深圳展厅%' and djm<>'单件调拨入库单') or ifnull(CHF,'') not like '深圳展厅%')OR v_wdmc<>'深圳展厅') then round(bqjg,3) else 0 end) as rkje,
0 as ckje,
0 as qmjs,
0 as qmjz,
0 as qmje 
from t_ka_splsz
where rq=v_rq and sffx='收' and wdmc=v_wdmc 
group by wdmc,ckmc,jsmc,plmc;

-- 合并收和发的数据
drop temporary table if exists temp3;
create temporary table temp3 as   
select wdmc,ckmc,jsmc,plmc,
sum(qcjs) as qcjs,
sum(qcjz) as qcjz,
sum(qcje) as qcje,
sum(rkjs) as rkjs,
sum(rkjz) as rkjz,
sum(rkje) as rkje,
sum(ckjs) as ckjs,
sum(ckjz) as ckjz,
sum(ckje) as ckje,
sum(qmjs) as qmjs,
sum(qmjz) as qmjz,
sum(qmje) as qmje
 from
(
select wdmc,ckmc,jsmc,plmc,
qcjs,qcjz,qcje,rkjs,rkjz,rkje,ckjs,ckjz,ckje,qmjs,qmjz,qmje from temp1
union all
select wdmc,ckmc,jsmc,plmc,
qcjs,qcjz,qcje,rkjs,rkjz,rkje,ckjs,ckjz,ckje,qmjs,qmjz,qmje from temp2
) a
group by wdmc,ckmc,jsmc,plmc;

-- 根据上一步取出的本月收发数据更新总帐的本月进出数据  
update t_ka_ztkcrzz t1,temp3 s 
set t1.rkjs=s.rkjs,t1.rkjz=s.rkjz,t1.rkje=s.rkje,
    t1.ckjs=s.ckjs,t1.ckjz=s.ckjz,t1.ckje=s.ckje
where t1.rq=v_rq and t1.wdmc=s.wdmc and t1.ckmc=s.ckmc and t1.jsmc=s.jsmc and t1.plmc=s.plmc;

-- 删除 temp3中上一步已更新过的行 
delete s from t_ka_ztkcrzz t1, temp3 s
where t1.rq = v_rq and t1.wdmc = s.wdmc and t1.ckmc = s.ckmc and t1.jsmc = s.jsmc and t1.plmc = s.plmc;


 select count(wdmc) into v_icount from temp3;
  
  if v_icount > 0 then  
   
 insert into t_ka_ztkcrzz(ztkcrzz_identity, nian, yue, ri, rq, wdmc, ckmc, jsmc, plmc, rkjs, rkjz, rkje, ckjs, ckjz, ckje)
 select uuid(), year( v_rq), month(v_rq), day( v_rq), v_rq,wdmc, ckmc, jsmc, plmc, rkjs, rkjz, rkje, ckjs, ckjz, ckje
 from temp3 ;
      
  end if;

  -- 更新当前月份余额  
  update t_ka_ztkcrzz
     set qmjs = ifnull(qcjs,0) + ifnull(rkjs,0) - ifnull(ckjs,0),
         qmjz = ifnull(qcjz,0) + ifnull(rkjz,0) - ifnull(ckjz,0),
         qmje = ifnull(qcje,0) + ifnull(rkje,0) - ifnull(ckje,0)
   where rq = v_rq and wdmc = v_wdmc; 	
	
  -- 假如日结转当天进行月总盘，那么将盘点的盈亏情况记入日总帐 
  if exists(select 1 from t_from_sujin_profit_loss where showroom_name = v_wdmc and date(weighing_date) = v_rq and showroom_name = v_wdmc)
  then
    update t_ka_ztkcrzz t1, t_from_sujin_profit_loss t2,t_from_sujin_profit_loss_detail t3 
       set t1.ykjs = 0,
           t1.ykjz = ifnull(t2.total_profit_loss_gold_weight, 0),
           t1.ykje = 0
     where t2.showroom_name = t1.wdmc 
        and t3.warehouse_name = t1.ckmc 
        and date(t2.inventory_date) = t1.rq 
        and t3.purity_name = t1.jsmc 
        and '品类' = t1.plmc 
				and t2.sujin_profit_loss_identity=t3.sujin_profit_loss_identity
       and t2.showroom_name = v_wdmc;
  end if; 	
	
	
  -- 在展厅库存日总帐中更新下日期初
  insert into t_ka_ztkcrzz(ztkcrzz_identity,nian,yue,ri,rq,wdmc,ckmc,jsmc,plmc,qcjs,qcjz,qcje,ykjs,ykjz,ykje)
  select uuid() as ztkcrzz_identity,
         v_nian1 as nian,
         v_yue1 as yue,
         v_ri1 as ri,
         v_rq1 as rq,
         wdmc as wdmc,
         ckmc as ckmc,
         jsmc as jsmc,
         plmc as plmc,
         ifnull(qmjs, 0)+ifnull(ykjs, 0) as qcjs,
         ifnull(qmjz, 0)+ifnull(ykjz, 0) as qcjz,
         ifnull(qmje, 0)+ifnull(ykje, 0)  as qcje,
				 ykjs,ykjz,ykje
    from t_ka_ztkcrzz
   where rq = v_rq 
     and wdmc = v_wdmc;	
		 
  -- 当结转日期的下一天是下个月1号时，将下一天的期初数据记入应收总帐中
  IF V_RI1 = 1 THEN 

   insert into t_ka_ztkczz(ztkczz_identity,nian,yue,wdmc,ckmc,jsmc,plmc,qcjs,qcjz,qcje)
   select uuid() as ztkczz_identity, 
          v_nian1 as nian, 
          v_yue1 as yue, 
          wdmc as wdmc, 
          ckmc as ckmc, 
          jsmc as jsmc, 
          plmc as plmc,
          ifnull(qmjs, 0)+ifnull(ykjs, 0) as qcjs,
          ifnull(qmjz, 0)+ifnull(ykjz, 0) as qcjz,
          ifnull(qmje, 0)+ifnull(ykje, 0)  as qcje
   from t_ka_ztkcrzz
  where rq = v_rq 
    and wdmc = v_wdmc;
    
  END IF;	 
-- -------------------------------------------结束 处理展厅库存日总帐结转


-- ------------------------------------------ 开始 结转应收日总帐
-- 在应收流水帐中取出期间发的数据

drop temporary table if exists temp11;
create temporary table temp11 as   
select 
	wdmc,
	customer_identity,
	0 as qcje,
	0 as rkje,
	sum(je) as ckje,
	0 as qmje
 from t_ka_yslsz
where rq=v_rq and sffx='发' and wdmc=v_wdmc 
group by wdmc,customer_identity;

-- 在应收流水帐中取出期间发的数据
drop temporary table if exists temp12;
create temporary table temp12 as   
select 
	wdmc,
	customer_identity,
	0 as qcje,
	sum(je) as rkje,
	0 as ckje,
	0 as qmje
from t_ka_yslsz
where rq=v_rq and sffx='收' and wdmc=v_wdmc 
group by wdmc,customer_identity;

-- 合并收和发的数据 
drop temporary table if exists temp13;
create temporary table temp13 as    
select wdmc,customer_identity,
sum(qcje) as qcje,sum(rkje) as rkje,sum(ckje) as ckje,sum(qmje) as qmje
from 
(
select wdmc,customer_identity,
qcje,rkje,ckje,qmje
from temp11
union all
select wdmc,customer_identity,
qcje,rkje,ckje,qmje
from temp12
) a
group by wdmc,customer_identity;

-- 根据上一步取出的本月收发数据更新日总帐的本日进出数据    
update t_ka_ysrzzh a ,temp13 s 
set a.zjje=s.rkje,
		a.jsje=s.ckje
where a.rq=v_rq and a.wdmc=s.wdmc and a.customer_identity=s.customer_identity; 

-- 删除#temp3中上一步已更新过的行  
delete s from t_ka_ysrzzh t1, temp13 s
where t1.rq=v_rq and t1.wdmc=s.wdmc and t1.customer_identity=s.customer_identity; 

select count(wdmc) into v_icount from temp13;

if v_icount > 0 then 

-- 把#temp13中未更新ysrzzh的行插入到ysrzzh中  
insert into t_ka_ysrzzh(ysrzz_identity,nian,yue,ri,rq,wdmc,customer_identity,zjje,jsje,bb)
select uuid(),year(v_rq),month(v_rq),day(v_rq),v_rq,wdmc,customer_identity,zjje,jsje,'人民币'
from temp13;

end if;

-- 更新当前月份余额
update t_ka_ysrzzh set jcje=ifnull(qcje,0)+ifnull(zjje,0)-ifnull(jsje,0)
where rq=v_rq and wdmc=v_wdmc;


if v_icount > 0 then 

-- 把#temp13中未更新ysrzzh的行插入到ysrzzh中  
insert into t_ka_ysrzzh(ysrzz_identity,nian,yue,ri,rq,wdmc,customer_identity,qcjc,bb)
select uuid(),year(v_rq),month(v_rq),day(v_rq),v_rq,wdmc,customer_identity,qcjc,'人民币'
from t_ka_ysrzzh where rq=v_rq and wdmc=v_wdmc and ifnull(qcje,0)<>0;
end if;


-- ------------------------------------------ 结束 结转应收日总帐



-- -------------------------------开始 结转来料日总帐和来料总帐
-- 在来料流水帐中取出本月进的数据 
drop temporary table if exists temp21;
create temporary table temp21 as    
select wdmc,
			csmc,
			plmc,
			customer_identity,
			sum(jz) as zjjz
  from t_ka_lllsz
where rq=v_rq and sffx='收' and wdmc=v_wdmc
group by wdmc,csmc,plmc,customer_identity;

-- 在来料流水帐中取出本月出的数据
drop temporary table if exists temp22;
create temporary table temp22 as   
select 
			wdmc,
			csmc,
			plmc,
		  customer_identity,
			sum(jz) as jsjz
 from t_ka_lllsz
where rq=v_rq and sffx='发' and wdmc=v_wdmc 
group by wdmc,csmc,plmc,customer_identity;


-- 合并收和发的数据  
drop temporary table if exists temp23;
create temporary table temp23 as   
select wdmc,csmc,plmc,customer_identity,sum(zjjz) as zjjz,sum(jsjz) as jsjz
from
(
select wdmc,csmc,plmc,customer_identity,zjjz,0 as jsjz
from temp21
union all
select wdmc,csmc,plmc,customer_identity,0 as zjjz,jsjz
from temp22
) a
group by wdmc,csmc,plmc,customer_identity;
   
-- 根据上一步取出的本月收发数据更新历史库存总帐的本月进出数据   
update t_ka_llrzzh a ,temp23 s 
set a.zjjz=s.zjjz,a.jsjz=s.jsjz
where a.rq=v_rq and a.wdmc=s.wdmc and a.csmc=s.csmc and a.customer_identity=s.customer_identity and a.plmc=s.plmc;
-- 删除#temp3中上一步已更新过的行   
delete s from t_ka_llrzzh t1, temp23 s
where t1.rq=v_rq and t1.wdmc=s.wdmc and t1.customer_identity=s.customer_identity; 

select count(wdmc) into v_icount from temp23;

if(v_icount)>0 then 
insert into t_ka_llrzzh(llrzz_identity,nian,yue,ri,rq,wdmc,csmc,plmc,customer_identity,zjjz,jsjz)
select uuid(),year(v_rq),month(v_rq),day(v_rq),v_rq,wdmc,csmc,plmc,customer_identity,zjjz,jsjz
from temp23;

update t_ka_llrzzh set qcjz=ifnull(qcjz,0)+ifnull(zjjz,0)-ifnull(jsjz,0) where rq=v_rq and wdmc=v_wdmc;

insert into t_ka_llrzzh(llrzz_identity,nian,yue,ri,rq,wdmc,csmc,plmc,customer_identity,qcjz)
select uuid(),year(v_rq),month(v_rq),day(v_rq),v_rq,wdmc,csmc,plmc,customer_identity,qcjz
from t_ka_llrzzh;

end if;

-- -------------------------------结束 结转来料日总帐和来料总帐


-- ---------------更新中金邮票库存 产品确认 中金邮票日库存帐没有这个单据，暂时不做
-- 	SELECT WDMC = @WDMC ,  RQ , PLMC , SUM (JS ) AS  QC , SUM (RKJS)  AS RK , SUM (CKJS) AS CK ,  
-- 	QMJS =  SUM (JS )+ SUM (RKJS)  - SUM (CKJS) ,ID=IDENTITY (INT ,1 , 1)
-- 	INTO #ZJYP
-- 	FROM (
-- 	SELECT  rq , plmc ,  js , RKJS=0 , CKJS=0      
-- 	FROM zjyprkczh
-- 	WHERE   RQ  = @rq AND  WDMC = @WDMC 
-- 	UNION ALL 
-- 	SELECT   RQ , plmc , 0 ,  0 , JS    
-- 	FROM  cpbh a ,  cpbb b  
-- 	WHERE  a.djlsh = b.djlsh  AND  ckmc = '中金邮票'  AND  RQ = @RQ AND  WDMC= @WDMC 
-- 	UNION  ALL 
-- 	SELECT  RQ , PLMC,   0 ,  JS , 0                  
-- 	FROM ZJYPRKDH  
-- 	WHERE  RQ = @RQ AND  WDMC= @WDMC 
-- 	UNION ALL
-- 	SELECT  YWSJ RQ , PLMC,   0 ,  JS , 0                  
-- 	FROM dbo.ZJYPJYDBCKDH  
-- 	WHERE  YWSJ = @RQ 
-- 	) A
-- 	GROUP  BY RQ , PLMC 
-- 
-- 	UPDATE  A  SET CKJS = CK , RKJS = RK , QMJS = B.QMJS 
-- 	FROM zjyprkczh A  ,  #ZJYP B 
-- 	WHERE  A.WDMC = B.WDMC  AND  A.PLMC = B.PLMC   AND  A.RQ = B.RQ 
-- 	
-- 	DECLARE @YPLSH  INT 
-- 	
-- 	SELECT @YPLSH =  MAX (DJLSH)  FROM zjyprkczh 
-- 	--SELECT  *  FROM zjyprkczh
-- 	INSERT INTO zjyprkczh ( DJLSH , RQ , PLMC , JS , RKJS , CKJS , QMJS , WDMC )
-- 	SELECT  @YPLSH+ID  ,dateadd(DAY  , 1 ,@RQ ) , PLMC , QMJS , 0 , 0 , 0 ,WDMC FROM #ZJYP

 -- 异常判断
 IF not hasSqlError THEN
 /*提交事务*/
COMMIT;
SELECT '执行成功!' AS MSG_INFO;
INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行成功');
UPDATE t_stored_procedure_status set execute_status = 0 WHERE stored_procedure_name = 'gn_zt_kcrzzjz'; -- 更新库存结转存储过程执行状态

ELSE
  /*回滚事务*/
  ROLLBACK;
  SELECT '执行失败！' AS MSG_INFO;
  SELECT CONCAT('gn_zt_kcrzzjz', ERR_CODE,' ',ERR_MSG) AS MSG_INFO;
  INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, CONCAT('执行失败，',ERR_CODE,' ',ERR_MSG));
END IF;
	 
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;

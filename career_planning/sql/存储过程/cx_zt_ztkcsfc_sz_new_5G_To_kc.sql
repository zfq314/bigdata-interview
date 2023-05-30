/*
 Navicat Premium Data Transfer

 Source Server         : 10.10.80.22-test
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : 10.10.80.22:3206
 Source Schema         : decent_cloud

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 22/02/2023 14:23:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Procedure structure for cx_zt_ztkcsfc_sz_new_5G_To_kc
-- ----------------------------
DROP PROCEDURE IF EXISTS `cx_zt_ztkcsfc_sz_new_5G_To_kc`;
delimiter ;;
CREATE PROCEDURE `cx_zt_ztkcsfc_sz_new_5G_To_kc`(IN V_QSRQ DATE, 
IN V_JSRQ DATE, 
IN V_SHOWROOM_IDENTITY VARCHAR(36), 
IN V_PL VARCHAR(30))
BEGIN
DECLARE V_WDMC VARCHAR(60);
SET V_WDMC = (SELECT SHOWROOM_NAME FROM T_SHOWROOM WHERE SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY);
 

DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP1;
CREATE TEMPORARY TABLE TEMP_TEMP1 AS
SELECT CASE WHEN CKMC = '镶嵌Q柜' OR CKMC = '镶嵌硬金柜'OR CKMC = '镶嵌柜-德钰东方' or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓' 
      THEN '千足嵌'
#modify by huwei 20220823 of 1
      WHEN (JSMC = '千足硬金') AND CKMC <> '镶嵌Q柜' 
       AND CKMC <> '镶嵌硬金柜'AND CKMC <> '镶嵌柜-德钰东方' 
      AND ckmc <> '客单组镶嵌德钰东方' AND ckmc <> '客单组镶嵌柜' 
      AND CKMC <> '维修仓' AND CKMC <> '古法金柜'
      AND CKMC <> '精品G柜' AND CKMC <> '硬金古法金柜'  
      and ckmc not in ('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','千足结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','物流部','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')
       and ckmc <> '无字印柜'
       and ckmc <> '客单组'
       and ckmc <> '客单组(5G)'
       and ckmc <> '配货中心'
       THEN '千足金'
      when ckmc in ('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')OR (ckmc='千足结算' and jsmc='千足硬金') OR (ckmc='广西-千足结算' and jsmc='千足硬金') or (ckmc='物流部' and jsmc='千足硬金')
      then '千足硬金'
#end modify by huwei 20220823 of 1
            WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY)  
      THEN ''
            WHEN CKMC = '精品G柜' OR JSMC = '足金(5G)' 
      THEN '足金(5G)'
            WHEN JSMC = '古法金' OR CKMC = '古法金柜' OR CKMC = '硬金古法金柜' 
      THEN '古法金' 
      when ckmc = '普货A柜'
      then '千足金'
      ELSE JSMC 
    END AS CSMC, 
      CASE 
    WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) 
    THEN CONCAT('料仓-', JSMC) 
    ELSE CKMC 
   END AS CKMC, 
       QCJZ AS QC, 
       0 AS RKZL, 
       0 AS CKZL, 
       0 AS A1, 
       0 AS A2, 
       0 AS A3, 
       0 AS A4, 
       0 AS A5, 
       0 AS A6, 
       0 AS A7, 
       0 AS RKHJ, 
       0 AS B1, 
       0 AS B2, 
       0 AS B3, 
       0 AS B4, 
       0 AS B5, 
       0 AS B6, 
       0 AS CKHJ, 
       0 AS YK, 
       0 AS YC, 
       0 AS SC, 
       0 AS CD
-- INTO TEMP_TEMP1
  FROM T_KA_ZTKCRZZ
 WHERE WDMC = V_WDMC 
    AND RQ = V_QSRQ 
   AND (JSMC NOT LIKE '虚拟金料%');
 

DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP2;
CREATE TEMPORARY TABLE TEMP_TEMP2 AS
SELECT CASE WHEN CKMC = '镶嵌Q柜' OR CKMC = '镶嵌硬金柜' OR CKMC = '镶嵌柜-德钰东方' or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓' THEN '千足嵌'
#modify by huwei 20220823 of 2
      WHEN (JSMC = '千足硬金') AND CKMC <> '镶嵌Q柜' 
       AND CKMC <> '镶嵌硬金柜'AND CKMC <> '镶嵌柜-德钰东方' 
      AND ckmc <> '客单组镶嵌德钰东方' AND ckmc <> '客单组镶嵌柜' 
      AND CKMC <> '维修仓' AND CKMC <> '古法金柜'
      AND CKMC <> '精品G柜' AND CKMC <> '硬金古法金柜'  
      and ckmc not in('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','千足结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','物流部','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')
       and ckmc <> '无字印柜'
       and ckmc <> '客单组'
       and ckmc <> '客单组(5G)'
       and ckmc <> '配货中心'
       THEN '千足金'
      when ckmc in ('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算') OR (ckmc='千足结算' and jsmc='千足硬金')OR (ckmc='广西-千足结算' and jsmc='千足硬金') or (ckmc='物流部' and jsmc='千足硬金') 
      then '千足硬金'
#end modify by huwei 20220823 of 2
       when ckmc = '普货A柜'
      then '千足金'
            WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN ''
            WHEN CKMC = '精品G柜' AND JSMC = '足金(5G)' THEN '足金(5G)'
            WHEN JSMC = '古法金' OR CKMC = '古法金柜' OR CKMC = '硬金古法金柜' THEN '古法金' 
      ELSE JSMC END AS CSMC, 
       CASE WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN CONCAT('料仓-', JSMC) ELSE CKMC END AS CKMC, 
       0 AS QC, 
       SUM(CASE WHEN SWLX IN ('调拨入库', '维修') AND SFFX = '收' AND DJM <> '单件调拨入库单' THEN ROUND(JZ, 3) ELSE 0 END) AS A1, 
       SUM(CASE WHEN ((SWLX = '委外入库') OR (SWLX = '换料入库')) AND SFFX = '收' THEN ROUND(JZ, 3) ELSE 0 END) AS A2, 
       SUM(CASE WHEN (SWLX = '采购入库' OR SWLX = '购客户成品') AND SFFX = '收' THEN ROUND(JZ, 3) ELSE 0 END) AS A3, 
       SUM(CASE WHEN SWLX = '客户来料' THEN ROUND(JZ, 3) ELSE 0 END) AS A4, 
       SUM(CASE WHEN SWLX = '客户退饰' AND SFFX = '收' THEN ROUND(JZ, 3) ELSE 0 END) AS A5, 
       SUM(CASE WHEN swlx in ('转仓入库', '维修调入')  AND SFFX = '收' THEN ROUND(JZ, 3) ELSE 0 END) AS A6,  -- modify by hyj 2022-12-12 增加维修调入的事务类型
       SUM(CASE WHEN SWLX = '成色转换' AND SFFX = '收' THEN IFNULL(JZ, 0)
                WHEN SWLX = '成色转换' AND SFFX = '发' THEN 0-IFNULL(JZ, 0) ELSE 0 END) AS A7, -- 其他入库（成色转换单）
       SUM(CASE WHEN SWLX <> '称重入库'  AND (DJM <> '单件调拨入库单') AND SFFX = '收' THEN ROUND(JZ, 3) ELSE 0 END) AS RKHJ, 
       SUM(CASE WHEN SWLX = '销售出库' AND SFFX = '发' THEN ROUND(JZ, 3) ELSE 0 END) AS B1, 
       SUM(CASE WHEN (SWLX ='调拨出库' OR SWLX='五九换料' ) AND SFFX = '发'AND DJM <> '单件调拨出库单' THEN ROUND(JZ, 3) ELSE 0 END) AS B2, 
       SUM(CASE WHEN SWLX = '熔料' AND SFFX = '发' THEN ROUND(JZ, 3) ELSE 0 END) AS B3, 
       SUM(CASE WHEN (SWLX = '维修' OR SWLX = '清洗' OR SWLX = '质量问题') AND SFFX = '发' THEN ROUND(JZ, 3) ELSE 0 END) AS B4, 
       SUM(CASE WHEN (SWLX = '委外付料' OR SWLX = '委外退货' OR SWLX = '付料' OR SWLX = '付客户料') AND SFFX = '发' THEN ROUND(JZ, 3) ELSE 0 END) AS B5, 
       SUM(CASE WHEN swlx in ('转仓出库', '维修调出') AND SFFX = '发' THEN ROUND(JZ, 3) ELSE 0 END) AS B6,   -- modify by hyj 2022-12-12 增加维修调出的事务类型
       SUM(CASE WHEN SWLX <> '客户出货'  AND (DJM <> '单件调拨出库单') AND SFFX = '发' THEN ROUND(JZ, 3) ELSE 0 END) AS CKHJ, 
       SUM(CASE WHEN SWLX = '盈亏调整' THEN ROUND(JZ, 3) ELSE 0 END) AS YK, 
       0 AS YC, 0 AS SC, 0 AS CD
-- INTO TEMP_TEMP2
  FROM  t_ka_splsz
 WHERE WDMC = V_WDMC 
--    AND (CKMC = V_CKMC OR IFNULL(V_CKMC, '') = '')
 --  and ((IFNULL(V_CKMC, '') <> '' and jsmc = v_csmc) or  IFNULL(V_CKMC, '') = '')
   AND RQ >= V_QSRQ 
   AND RQ <= V_JSRQ 
   AND (JSMC NOT LIKE '虚拟金料%')
   and djh not like 'zj20%' -- add by huwei ,质检的流水不计算，因为调拨里面已经计算过了
 GROUP BY 
    CASE WHEN CKMC = '镶嵌Q柜' OR CKMC = '镶嵌硬金柜' OR CKMC = '镶嵌柜-德钰东方' 
       or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓' 
       THEN '千足嵌'
#modify by huwei 20220823 of 3
      WHEN (JSMC = '千足硬金') AND CKMC <> '镶嵌Q柜' 
       AND CKMC <> '镶嵌硬金柜'AND CKMC <> '镶嵌柜-德钰东方' 
      AND ckmc <> '客单组镶嵌德钰东方' AND ckmc <> '客单组镶嵌柜' 
      AND CKMC <> '维修仓' AND CKMC <> '古法金柜'
      AND CKMC <> '精品G柜' AND CKMC <> '硬金古法金柜'  
      and ckmc not in ('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','千足结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','物流部','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')
       and ckmc <> '无字印柜'
       and ckmc <> '客单组'
       and ckmc <> '客单组(5G)'
       and ckmc <> '配货中心'
       THEN '千足金'
      when ckmc in ('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')OR (ckmc='千足结算' and jsmc='千足硬金') OR (ckmc='广西-千足结算' and jsmc='千足硬金') or(ckmc='物流部' and jsmc='千足硬金')
      then '千足硬金'
#end modify by huwei 20220823 of 3
      when ckmc = '普货A柜'
      then '千足金'
            WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) 
      THEN ''
            WHEN CKMC = '精品G柜' AND JSMC = '足金(5G)' THEN '足金(5G)'
            WHEN JSMC = '古法金' OR CKMC = '古法金柜' OR CKMC = '硬金古法金柜' THEN '古法金' 
      ELSE JSMC 
     END
      , 
    CASE WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) 
      THEN CONCAT('料仓-', JSMC) 
      ELSE CKMC 
    END;
		
-- -取得盘点单中的实物库存
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP3;
CREATE TEMPORARY TABLE TEMP_TEMP3 AS
SELECT CASE WHEN COUNTER_NAME = '镶嵌Q柜' OR COUNTER_NAME = '镶嵌硬金柜' 
              OR COUNTER_NAME = '镶嵌柜-德钰东方' or COUNTER_NAME = '客单组镶嵌德钰东方' 
       or COUNTER_NAME = '客单组镶嵌柜' OR COUNTER_NAME = '维修仓' THEN '千足嵌'
#modify by huwei 20220823 of 4
             WHEN (PURITY_NAME = '千足硬金') 
       AND COUNTER_NAME <> '镶嵌Q柜'
       AND COUNTER_NAME <> '镶嵌柜-德钰东方' 
       AND COUNTER_NAME <> '镶嵌硬金柜' 
       AND COUNTER_NAME <> '客单组镶嵌德钰东方' 
       AND COUNTER_NAME <> '客单组镶嵌柜' 
       AND COUNTER_NAME <> '维修仓' 
       AND COUNTER_NAME <> '古法金柜'
       and counter_name <> '客单组'
       and counter_name <> '客单组(5G)'
      and counter_name not in ('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','千足结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','物流部','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')
       and COUNTER_NAME <> '无字印柜'
       and COUNTER_NAME <> '配货中心'
       AND COUNTER_NAME <> '硬金古法金柜' 
       AND COUNTER_NAME <> '精品G柜' THEN '千足金'
      when COUNTER_NAME = '普货A柜'
      then '千足金'
      when COUNTER_NAME in ('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')OR (counter_name='千足结算' and PURITY_NAME='千足硬金') OR (counter_name='广西-千足结算' and PURITY_NAME='千足硬金') or(counter_name='物流部' and PURITY_NAME='千足硬金')
      then '千足硬金'
#end modify by huwei 20220823 of 4
            WHEN COUNTER_NAME IN (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN ''
            WHEN COUNTER_NAME = '精品G柜' OR PURITY_NAME = '足金(5G)' THEN '足金(5G)'
            WHEN PURITY_NAME = '古法金' OR COUNTER_NAME = '古法金柜' OR COUNTER_NAME = '硬金古法金柜' THEN '古法金' 
      
      ELSE PURITY_NAME 
    END AS CSMC, 
       CASE WHEN COUNTER_NAME in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) 
      THEN CONCAT('料仓-', PURITY_NAME)       
      ELSE COUNTER_NAME 
    END AS CKMC, 
       0 AS QC, 
       0 AS A1, 0 AS A2, 0 AS A3, 0 AS A4, 0 AS A5, 0 AS A6, 0 AS A7, 0 AS RKHJ, 0 AS B1, 0 AS B2, 0 AS B3, 0 AS B4, 0 AS B5, 0 AS B6, 0 AS CKHJ, 0 AS YK, 0 AS YC, 
       T_BF_WEIGHING_FORM_CHECK.tray_gold_weight AS SC, 0 AS CD
-- INTO TEMP_TEMP3
  FROM T_BF_WEIGHING_FORM_CHECK 
 WHERE SHOWROOM_NAME = V_WDMC 
   -- AND (COUNTER_NAME = V_CKMC OR IFNULL(V_CKMC, '') = '')
  --  and ((IFNULL(V_CKMC, '') <> '' and purity_name = v_csmc) or  IFNULL(V_CKMC, '') = '')

   AND RQ = V_JSRQ;		
      
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP4;
CREATE TEMPORARY TABLE TEMP_TEMP4 AS
SELECT CKMC, CSMC, SUM(QC) AS QC, 
SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
SUM(QC) + SUM(RKHJ) - SUM(CKHJ) AS YC, 
SUM(YK) AS YK, 
SUM(SC) AS SC, 
SUM(SC ) - (SUM(QC) + SUM(RKHJ) - SUM(CKHJ)) + SUM(YK) AS CD
  FROM (
SELECT CSMC, CKMC, QC, A1, A2, A3, A4, A5, A6, A7, RKHJ, B1, B2, B3, B4, B5, B6, CKHJ, YK, YC, SC, CD
  FROM TEMP_TEMP1 
  UNION ALL
SELECT *
  FROM TEMP_TEMP2 
	 UNION ALL
SELECT *
  FROM TEMP_TEMP3
)S
GROUP BY CSMC;		

delete from t_showroom_storage_data_copy1 where data_date = V_QSRQ;
insert into t_showroom_storage_data_copy1
select v_wdmc as wdmc,V_QSRQ as data_date,csmc as purity_name,qc as yesterday_weight,rkhj-ckhj as in_storage_weight,yc  as remain_weight
from TEMP_TEMP4;
-- where csmc in('千足金','金9999','金99999','千足硬金','足金(5G)','古法金','古法万足金');
			
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;

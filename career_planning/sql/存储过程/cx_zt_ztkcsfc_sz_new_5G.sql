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

 Date: 22/02/2023 14:23:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Procedure structure for cx_zt_ztkcsfc_sz_new_5G
-- ----------------------------
DROP PROCEDURE IF EXISTS `cx_zt_ztkcsfc_sz_new_5G`;
delimiter ;;
CREATE PROCEDURE `cx_zt_ztkcsfc_sz_new_5G`(IN V_QSRQ DATE, 
IN V_JSRQ DATE, 
IN V_SHOWROOM_IDENTITY VARCHAR(36), 
IN V_PL VARCHAR(30), 
IN V_COUNTER_IDENTITY VARCHAR(36),
IN V_KCLX VARCHAR(20),
IN V_START INT, 
IN V_LEN INT)
BEGIN
########################################################################################################################
#创 建 人：胡亚娟
#描    述：报表：1.展厅库存收发存
#修改记录：2022-11-22 由于商品流水表中产生柜台为客单组(5g)柜台（该柜台是错误的，已被反审，但产生了流水）成色为千足硬金的数据，在划分成色时，算在了千足成色，相应调整 hyj
#          2022-11-29 '广西-硬金柜','昆明-硬金柜','昆明-硬金结算' 三个柜台的千足硬金成色计算到千足硬金统计 添加柜台限制条件 相应调整 zfq
#          2022-12-12 取当天流水部分，swlx = '转仓入库' => swlx in ('转仓入库', '维修调入') 
#                                    swlx = '转仓出库' => swlx in ('转仓出库', '维修调出')
#          2022-12-13 '湖北-硬金柜','湖北-硬金结算'千足硬金成色计算到千足硬金统计 添加柜台限制条件 相应调整 zfq
#          2022-12-15 '广西-硬金结算','深圳-单件化硬金柜台' 产品方杰 成色统计到千足硬金 添加柜台限制条件 相应调整 zfq
#          2022-12-20 '福州-单件化硬金柜台' 产品方杰 成色统计到千足硬金 添加柜台限制条件 相应调整 zfq
#          2023-01-11 期初数据将河南-硬金结算柜台的取值成色归属于硬金 zfq
#          2023-01-12 期初数据将河南-硬金柜柜台的取值成色归属于硬金 zfq
#          2023-02-17 temp5 关联柜台的时候，分货组做特殊处理，如果是多成色柜台关联时候不加成色显示条件，否则加成色限制 zfq
#          2023-02-20 物流部 新增限制条件 千足硬金 统计到 硬金成色里面 zfq
#          2023-02-22 硬金成色统计新增柜台 zfq
########################################################################################################################
# modify by huwei at 20220823 ,total 8 
DECLARE V_WDMC VARCHAR(60);
DECLARE V_CKMC VARCHAR(50);
DECLARE V_CSMC VARCHAR(50);
DECLARE V_DCS INT;
declare v_purity_identity varchar(50);

SET V_WDMC = (SELECT SHOWROOM_NAME FROM T_SHOWROOM WHERE SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY);
SET V_CKMC = (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE COUNTER_IDENTITY = ifnull(V_COUNTER_IDENTITY, ''));
SET V_DCS = (SELECT is_many_purity FROM T_SHOWROOM_COUNTER WHERE COUNTER_IDENTITY = ifnull(V_COUNTER_IDENTITY, ''));
SET v_purity_identity = (SELECT purity_identity FROM T_SHOWROOM_COUNTER WHERE COUNTER_IDENTITY = ifnull(V_COUNTER_IDENTITY, ''));

SET V_CSMC = (select purity_name from t_purity where purity_identity = v_purity_identity);

-- -- -- -- -- -- -- -- 取得当日期初（展厅库存日总帐）
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
      when ckmc in ('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')OR (ckmc='千足结算' and jsmc='千足硬金') OR (ckmc='广西-千足结算' and jsmc='千足硬金')or(ckmc='物流部' and jsmc='千足硬金')
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
   AND (CKMC = V_CKMC OR IFNULL(V_CKMC, '') = '')
   AND RQ = V_QSRQ 
   AND (JSMC NOT LIKE '虚拟金料%');
   

-- -- -- -- -- -- -取得商品流水帐里的入出记录（商品流水帐）
-- select * from TEMP_TEMP1;
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
      when ckmc in ('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算') OR (ckmc='千足结算' and jsmc='千足硬金')OR (ckmc='广西-千足结算' and jsmc='千足硬金')or(ckmc='物流部' and jsmc='千足硬金')
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
   AND (CKMC = V_CKMC OR IFNULL(V_CKMC, '') = '')
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
      when ckmc in ('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')OR (ckmc='千足结算' and jsmc='千足硬金') OR (ckmc='广西-千足结算' and jsmc='千足硬金')or(ckmc='物流部' and jsmc='千足硬金')
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
      
       
     /*
     # 过账数据不再处理
    -- 柜台当天过账数计为出库，累计到出库合计和转仓数上 
    update TEMP_TEMP2 a
    inner join $gz_temp b 
    on a.ckmc = b.ckmc
    and a.csmc = b.jsmc
    set a.b6 = a.b6 + b.ckjz
    , a.ckhj = a.ckhj + b.ckjz
    ;


    -- 柜台过账到当日的数据，计入结算中心收货同时增加收货合计
    update TEMP_TEMP2 a
    inner join $gz_temp2 b 
    on a.ckmc = b.ckmc
    and a.csmc = b.jsmc
    set a.a6 = ifnull(a.a6,0) + ifnull(b.ckjz,0)
    , a.rkhj = ifnull(a.rkhj,0) + ifnull(b.ckjz,0)
;
*/

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
      when COUNTER_NAME in ('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')OR (counter_name='千足结算' and PURITY_NAME='千足硬金') OR (counter_name='广西-千足结算' and PURITY_NAME='千足硬金')or(counter_name='物流部' and PURITY_NAME='千足硬金')
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
   AND (COUNTER_NAME = V_CKMC OR IFNULL(V_CKMC, '') = '')
   and ((IFNULL(V_CKMC, '') <> '' and purity_name = v_csmc) or  IFNULL(V_CKMC, '') = '')

   AND RQ = V_JSRQ;
-- -合并展厅盘点单的期初数据、商品流水帐的入出库数据、展厅盘点单的实物库存数据
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP4;
CREATE TEMPORARY TABLE TEMP_TEMP4 AS
SELECT CKMC, CSMC, SUM(QC) AS QC, 
SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
SUM(QC) + SUM(RKHJ) - SUM(CKHJ) AS YC, 
SUM(YK) AS YK, 
SUM(SC) AS SC, 
SUM(SC ) - (SUM(QC) + SUM(RKHJ) - SUM(CKHJ)) + SUM(YK) AS CD
-- INTO TEMP_TEMP4
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
GROUP BY CSMC, CKMC;

IF(V_DCS=1) THEN 
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP5;
CREATE TEMPORARY TABLE TEMP_TEMP5 AS
SELECT  999 AS XH, CONCAT(CSMC, (CASE WHEN TEMP_TEMP4.CKMC LIKE '料仓%' THEN '金料' ELSE '饰品' END)) AS KCLX, 
        C.COUNTER_CODE AS CKBM, TEMP_TEMP4.CKMC, TEMP_TEMP4.QC, 
        A1, A2, A3, A4, A5, A6, A7, RKHJ, 
        B1, B2, B3, B4, B5, B6, CKHJ, 
        YK, 
        YC, SC, CD
        -- INTO TEMP_TEMP5
  FROM TEMP_TEMP4 
  LEFT JOIN T_SHOWROOM_COUNTER C 
    ON ((CASE WHEN TEMP_TEMP4.CKMC LIKE '镶嵌Q%' THEN '镶嵌Q柜'
              WHEN TEMP_TEMP4.CKMC LIKE '镶嵌柜-德钰东方%' THEN '镶嵌柜-德钰东方'
              WHEN TEMP_TEMP4.CKMC LIKE '镶嵌硬金%' THEN '镶嵌硬金柜' ELSE TEMP_TEMP4.CKMC END) = C.COUNTER_NAME 
   AND C.SHOWROOM_NAME = V_WDMC) 
 group by xh,kclx,ckmc;
 
ELSEIF(V_DCS=0 OR V_DCS IS NULL)THEN 
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP5;
CREATE TEMPORARY TABLE TEMP_TEMP5 AS
SELECT  999 AS XH, CONCAT(CSMC, (CASE WHEN TEMP_TEMP4.CKMC LIKE '料仓%' THEN '金料' ELSE '饰品' END)) AS KCLX, 
        C.COUNTER_CODE AS CKBM, TEMP_TEMP4.CKMC, TEMP_TEMP4.QC, 
        A1, A2, A3, A4, A5, A6, A7, RKHJ, 
        B1, B2, B3, B4, B5, B6, CKHJ, 
        YK, 
        YC, SC, CD
        -- INTO TEMP_TEMP5
  FROM TEMP_TEMP4 
  LEFT JOIN T_SHOWROOM_COUNTER C 
	LEFT JOIN T_PURITY D ON C.PURITY_IDENTITY=D.PURITY_IDENTITY
    ON ((CASE WHEN TEMP_TEMP4.CKMC LIKE '镶嵌Q%' THEN '镶嵌Q柜'
              WHEN TEMP_TEMP4.CKMC LIKE '镶嵌柜-德钰东方%' THEN '镶嵌柜-德钰东方'
              WHEN TEMP_TEMP4.CKMC LIKE '镶嵌硬金%' THEN '镶嵌硬金柜' ELSE TEMP_TEMP4.CKMC END) = C.COUNTER_NAME AND CSMC=D.PURITY_NAME
   AND C.SHOWROOM_NAME = V_WDMC) 
 group by xh,kclx,ckmc;
END IF;

-- -- -- -- -- 重量结束
-- -- -- -件数开始-- -- -- -- -取得当日期初（展厅库存日总帐）
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP11;
CREATE TEMPORARY TABLE TEMP_TEMP11 AS
SELECT CASE WHEN CKMC = '镶嵌Q柜' OR CKMC = '镶嵌硬金柜'OR CKMC = '镶嵌柜-德钰东方' or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓' THEN '千足嵌'
#modify by huwei 20220823 of 5
      WHEN JSMC = '千足硬金' and ckmc NOT IN  ('客单组','硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','千足结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','物流部','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')
       THEN '千足金'
      when ckmc in ('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')OR (ckmc='千足结算' and jsmc='千足硬金')OR (ckmc='广西-千足结算' and jsmc='千足硬金')or(ckmc='物流部' and jsmc='千足硬金')
      then '千足硬金'
#modify by huwei 20220823 of 5
            WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN ''
            WHEN CKMC = '精品G柜' OR JSMC = '足金(5G)' THEN '足金(5G)'
       ELSE JSMC END AS CSMC, 
       CASE WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN CONCAT('料仓-', JSMC) ELSE CKMC END AS CKMC, 
       CAST(QCJS AS DECIMAL(18, 3)) AS QC, 0 AS RKZL, 0 AS CKZL, 0 AS A1, 0 AS A2, 0 AS A3, 0 AS A4, 0 AS A5, 0 AS A6, 0 AS A7, 0 AS RKHJ, 0 AS B1, 0 AS B2, 0 AS B3, 0 AS B4, 0 AS B5, 0 AS B6, 0 AS CKHJ, 0 AS YK, 0 AS YC, 0 AS SC, 0 AS CD
-- INTO TEMP_TEMP11
  FROM T_KA_ZTKCRZZ
 WHERE WDMC = V_WDMC
   AND (CKMC = V_CKMC OR IFNULL(V_CKMC, '') = '')
   AND RQ = V_QSRQ
--   and ((IFNULL(V_CKMC, '') <> '' and jsmc = v_csmc) or  IFNULL(V_CKMC, '') = '')
   AND (CKMC = '镶嵌Q柜' OR CKMC = '镶嵌硬金柜' OR CKMC = '镶嵌柜-德钰东方' OR CKMC = '维修仓');

-- -- -- -- -- -- -取得商品流水帐里的入出记录（商品流水帐）
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP12;
CREATE TEMPORARY TABLE TEMP_TEMP12 AS
SELECT CASE WHEN CKMC = '镶嵌Q柜' OR CKMC = '镶嵌硬金柜' OR CKMC = '镶嵌柜-德钰东方' or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓' THEN '千足嵌'
#modify by huwei 20220823 of 6       
      WHEN JSMC = '千足硬金' 
      and ckmc <> '客单组' 
       and ckmc <> '客单组(5G)'
       and ckmc <> '配货中心'
      and ckmc not in ('客单组', '硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','千足结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','物流部','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')
       THEN '千足金'
      when ckmc in ( '硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算') OR (ckmc='千足结算' and jsmc='千足硬金') OR (ckmc='广西-千足结算' and jsmc='千足硬金')or(ckmc='物流部' and jsmc='千足硬金')
      then '千足硬金'
#modify by huwei 20220823 of 6      
            WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN ''
            WHEN CKMC = '精品G柜' OR JSMC = '足金(5G)' THEN '足金(5G)'
            ELSE JSMC END AS CSMC, 
       CASE WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN CONCAT('料仓-', JSMC) 
            ELSE CKMC END AS CKMC, 
       0 AS QC, 
       SUM(CASE WHEN SWLX IN ('调拨入库', '维修') AND SFFX = '收' AND DJM <> '单件调拨入库单' THEN ROUND(JS, 3) ELSE 0 END) AS A1, 
       SUM(CASE WHEN ((SWLX = '委外入库') OR (SWLX = '换料入库') ) AND SFFX = '收' THEN ROUND(JS, 3) ELSE 0 END) AS A2, 
       SUM(CASE WHEN (SWLX = '采购入库' OR SWLX = '购客户成品') AND SFFX = '收' THEN ROUND(JS, 3) ELSE 0 END) AS A3, 
       SUM(CASE WHEN SWLX = '客户来料' THEN ROUND(JS, 3) ELSE 0 END) AS A4, 
       SUM(CASE WHEN SWLX = '客户退饰' AND SFFX = '收' THEN ROUND(JS, 3) ELSE 0 END) AS A5, 
       SUM(CASE WHEN swlx in ('转仓入库', '维修调入') AND SFFX = '收' THEN ROUND(JS, 3) ELSE 0 END) AS A6,   -- modify by hyj 2022-12-12 增加维修调入的事务类型
       SUM(CASE WHEN (SWLX = '熔料' OR SWLX = '维修' OR SWLX = '清洗' OR SWLX = '质量问题') AND SFFX = '收' THEN ROUND(JS, 3) ELSE 0 END) AS A7, -- -- -- 料仓熔料入库
       SUM(CASE WHEN  SWLX <> '称重入库'  AND (DJM <> '单件调拨入库单') AND SFFX = '收' THEN ROUND(JS, 3) ELSE 0 END) AS RKHJ, 
       SUM(CASE WHEN SWLX = '销售出库' AND SFFX = '发' THEN ROUND(JS, 3) ELSE 0 END) AS B1, 
       SUM(CASE WHEN (SWLX ='调拨出库' OR SWLX='五九换料' ) AND SFFX = '发' AND DJM <> '单件调拨出库单' THEN ROUND(JS, 3) ELSE 0 END) AS B2, 
       SUM(CASE WHEN SWLX = '熔料' AND SFFX = '发' THEN ROUND(JS, 3) ELSE 0 END) AS B3, 
       SUM(CASE WHEN (SWLX = '维修' OR SWLX = '清洗' OR SWLX = '质量问题') AND SFFX = '发' THEN ROUND(JS, 3) ELSE 0 END) AS B4, 
       SUM(CASE WHEN (SWLX = '委外付料' OR SWLX = '委外退货' OR SWLX = '付料' OR SWLX = '付客户料') AND SFFX = '发' THEN ROUND(JS, 3) ELSE 0 END) AS B5, 
       SUM(CASE WHEN swlx in ('转仓出库', '维修调出') AND SFFX = '发' THEN ROUND(JS, 3) ELSE 0 END) AS B6,   -- modify by hyj 2022-12-12 增加维修调出的事务类型
       SUM(CASE WHEN  SWLX <> '客户出货'  AND (DJM <> '单件调拨出库单') AND SFFX = '发' THEN ROUND(JS, 3) ELSE 0 END) AS CKHJ, 
       SUM(CASE WHEN SWLX = '盈亏调整' THEN ROUND(JS, 3) ELSE 0 END) AS YK, 
       0 AS YC, 0 AS SC, 0 AS CD
-- INTO TEMP_TEMP12
  FROM T_KA_SPLSZ 
 WHERE WDMC = V_WDMC 
   AND (CKMC = V_CKMC OR IFNULL(V_CKMC, '') = '')
   AND RQ >= V_QSRQ 
   AND RQ <= V_JSRQ 
   and djh not like 'zj20%' -- add by huwei ,质检的流水不计算，因为调拨里面已经计算过了
 --  and ((IFNULL(V_CKMC, '') <> '' and jsmc = v_csmc) or  IFNULL(V_CKMC, '') = '')
   AND (CKMC = '镶嵌Q柜'OR CKMC = '镶嵌柜-德钰东方' OR CKMC = '镶嵌硬金柜' or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓')
GROUP BY  CASE WHEN CKMC = '镶嵌Q柜' OR CKMC = '镶嵌硬金柜' OR CKMC = '镶嵌柜-德钰东方' or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓' THEN '千足嵌'
#modify by huwei 20220823 of 7    
      WHEN JSMC = '千足硬金' 
      and ckmc <> '客单组' 
       and ckmc <> '客单组(5G)'
       and ckmc <> '配货中心'
      and ckmc not in ('客单组', '硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','千足结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','物流部','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')
       THEN '千足金'
      when ckmc in ( '硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')OR (ckmc='千足结算' and jsmc='千足硬金') OR (ckmc='广西-千足结算' and jsmc='千足硬金')or(ckmc='物流部' and jsmc='千足硬金')
      then '千足硬金'
#modify by huwei 20220823 of 7 
            WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN ''
            WHEN CKMC = '精品G柜' OR JSMC = '足金(5G)' THEN '足金(5G)'
            ELSE JSMC END , 
       CASE WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN CONCAT('料仓-', JSMC) 
            ELSE CKMC END;

-- -取得盘点单中的实物库存
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP13;
CREATE TEMPORARY TABLE TEMP_TEMP13 AS
SELECT CASE WHEN COUNTER_NAME = '镶嵌Q柜' OR COUNTER_NAME = '镶嵌硬金柜'OR COUNTER_NAME = '镶嵌柜-德钰东方' OR COUNTER_NAME = '维修仓' THEN '千足嵌'
            WHEN PURITY_NAME = '千足硬金' 
#modify by huwei 20220823 of 8
      and counter_name not in ( '客单组 ' ,'硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','千足结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','物流部','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')
      THEN '千足金'
      when counter_name in ('硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算') OR (COUNTER_NAME='千足结算' and PURITY_NAME='千足硬金') OR (COUNTER_NAME='广西-千足结算' and PURITY_NAME='千足硬金')or(counter_name='物流部' and PURITY_NAME='千足硬金')
      then '千足硬金'
#modify by huwei 20220823 of 8      
            WHEN COUNTER_NAME in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN ''
            WHEN COUNTER_NAME = '精品G柜' OR PURITY_NAME = '足金(5G)' THEN '足金(5G)'
            ELSE PURITY_NAME END AS CSMC, 
       CASE WHEN COUNTER_NAME in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN CONCAT('料仓-', PURITY_NAME)            ELSE COUNTER_NAME END AS CKMC, 
       0 AS QC, 
       0 AS A1, 0 AS A2, 0 AS A3, 0 AS A4, 0 AS A5, 0 AS A6, 0 AS A7, 0 AS RKHJ, 0 AS B1, 0 AS B2, 0 AS B3, 0 AS B4, 0 AS B5, 0 AS B6, 0 AS CKHJ, 0 AS YK, 0 AS YC, 
       CAST(T_BF_WEIGHING_FORM_CHECK.NUMBER AS DECIMAL(18, 3)) AS SC, 0 AS CD
-- INTO TEMP_TEMP13
  FROM T_BF_WEIGHING_FORM_CHECK 
 WHERE SHOWROOM_NAME = V_WDMC
   AND (COUNTER_NAME = V_CKMC OR IFNULL(V_CKMC, '') = '')
  and ((IFNULL(V_CKMC, '') <> '' and purity_name = v_csmc) or  IFNULL(V_CKMC, '') = '')
   AND RQ = V_JSRQ 
   AND (COUNTER_NAME = '镶嵌Q柜'OR COUNTER_NAME = '镶嵌柜-德钰东方' 
        OR COUNTER_NAME = '镶嵌硬金柜' or COUNTER_NAME = '客单组镶嵌德钰东方' 
        or COUNTER_NAME = '客单组镶嵌柜' OR COUNTER_NAME = '维修仓');

-- -合并展厅盘点单的期初数据、商品流水帐的入出库数据、展厅盘点单的实物库存数据
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP14;
CREATE TEMPORARY TABLE TEMP_TEMP14 AS
SELECT CKMC, CSMC, SUM(QC) AS QC, 
       SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
       SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
       SUM(QC) + SUM(RKHJ) - SUM(CKHJ) AS YC, 
       SUM(YK) AS YK, 
       SUM(SC) AS SC, 
       SUM(SC ) - (SUM(QC) + SUM(RKHJ) - SUM(CKHJ)) + SUM(YK) AS CD
-- INTO TEMP_TEMP14
  FROM (
        SELECT CSMC, CKMC, QC, A1, A2, A3, A4, A5, A6, A7, RKHJ, B1, B2, B3, B4, B5, B6, CKHJ, YK, YC, SC, CD
          FROM TEMP_TEMP11 UNION ALL
        SELECT *
          FROM TEMP_TEMP12 UNION ALL
        SELECT *
          FROM TEMP_TEMP13
       ) S
 GROUP BY CSMC, CKMC;

DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP15;
CREATE TEMPORARY TABLE TEMP_TEMP15 AS
SELECT 11 AS XH, CONCAT(CSMC, (CASE WHEN TEMP_TEMP14.CKMC LIKE '料仓%' THEN '金料' ELSE '饰品' END)) AS KCLX, 
C.COUNTER_CODE AS CKBM, TEMP_TEMP14.CKMC, TEMP_TEMP14.QC, 
A1, A2, A3, A4, A5, A6, A7, RKHJ, 
B1, B2, B3, B4, B5, B6, CKHJ, 
YK, 
YC, SC, CD
-- INTO TEMP_TEMP15
  FROM TEMP_TEMP14 LEFT JOIN T_SHOWROOM_COUNTER C ON
((CASE WHEN TEMP_TEMP14.CKMC LIKE '镶嵌Q%' THEN '镶嵌Q柜'
WHEN TEMP_TEMP14.CKMC LIKE '镶嵌硬金%' THEN '镶嵌硬金柜' ELSE TEMP_TEMP14.CKMC END) = C.COUNTER_NAME AND C.SHOWROOM_NAME = V_WDMC);
-- -- -- -- -- -- -- -- -- -- -- -- -- 件数结束

-- -- -- -标签价格开始-- -- -- -- -取得当日期初（展厅库存日总帐）
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP21;
CREATE TEMPORARY TABLE TEMP_TEMP21 AS
SELECT CASE WHEN CKMC = '镶嵌Q柜' OR CKMC = '镶嵌硬金柜'OR CKMC = '镶嵌柜-德钰东方' or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓' THEN '千足嵌'

      WHEN JSMC = '千足硬金' and ckmc <> '配货中心' THEN '千足金'

            WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN ''
            WHEN CKMC = '精品G柜' OR JSMC = '足金(5G)' THEN '足金(5G)'
            ELSE JSMC END AS CSMC, 
       CASE WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN CONCAT('料仓-', JSMC) 
            ELSE CKMC END AS CKMC, 
       CAST(QCJE AS DECIMAL(18, 3)) AS QC, 0 AS RKZL, 0 AS CKZL, 0 AS A1, 0 AS A2, 0 AS A3, 0 AS A4, 0 AS A5, 0 AS A6, 
       0 AS A7, 0 AS RKHJ, 0 AS B1, 0 AS B2, 0 AS B3, 0 AS B4, 0 AS B5, 0 AS B6, 0 AS CKHJ, 0 AS YK, 0 AS YC, 0 AS SC, 0 AS CD
-- INTO TEMP_TEMP21
  FROM T_KA_ZTKCRZZ
 WHERE WDMC = V_WDMC
   AND (CKMC = V_CKMC OR IFNULL(V_CKMC, '') = '')
  --  and ((IFNULL(V_CKMC, '') <> '' and jsmc = v_csmc) or  IFNULL(V_CKMC, '') = '')
   AND RQ = V_QSRQ 
   AND (CKMC = '镶嵌Q柜'OR CKMC = '镶嵌柜-德钰东方' OR CKMC = '镶嵌硬金柜' or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓');

-- -- -- -- -- -- -取得商品流水帐里的入出记录（商品流水帐）
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP22;
CREATE TEMPORARY TABLE TEMP_TEMP22 AS
SELECT CASE 
--        WHEN (JSMC = '千足硬金') AND CKMC <> '镶嵌Q柜' 
--                  AND CKMC <> '镶嵌硬金柜'AND CKMC <> '镶嵌柜-德钰东方' 
--                  AND ckmc <> '客单组镶嵌德钰东方' AND ckmc <> '客单组镶嵌柜' 
--                  AND CKMC <> '维修仓' AND CKMC <> '古法金柜'
--                  AND CKMC <> '精品G柜' AND CKMC <> '硬金古法金柜' 
--                  and ckmc <> '客单组'
--                  and ckmc <> '配货中心'
--                  THEN '千足金' 
            WHEN CKMC IN (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN '' 
            WHEN CKMC = '镶嵌Q柜'OR CKMC = '镶嵌柜-德钰东方' OR CKMC = '镶嵌硬金柜' or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓' THEN '千足嵌' 
            ELSE JSMC END AS CSMC, 
       CASE WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN CONCAT('料仓-', JSMC) 
            ELSE CKMC END AS CKMC, 
       0 AS QC, 
       SUM(CASE WHEN SWLX = '调拨入库' AND SFFX = '收' AND DJM <> '单件调拨入库单' THEN ROUND(BQJG, 3) ELSE 0 END) AS A1, 
       SUM(CASE WHEN SWLX = '委外入库' AND SFFX = '收' THEN ROUND(BQJG, 3) ELSE 0 END) AS A2, 
       SUM(CASE WHEN (SWLX = '采购入库' OR SWLX = '购客户成品') AND SFFX = '收' THEN ROUND(BQJG, 3) ELSE 0 END) AS A3, 
       SUM(CASE WHEN SWLX = '客户来料' THEN ROUND(BQJG, 3) ELSE 0 END) AS A4, 
       SUM(CASE WHEN SWLX = '客户退饰' AND SFFX = '收' THEN ROUND(BQJG, 3) ELSE 0 END) AS A5, 
       SUM(CASE WHEN swlx in ('转仓入库', '维修调入') AND SFFX = '收' THEN ROUND(BQJG, 3) ELSE 0 END) AS A6,   -- modify by hyj 2022-12-12 增加维修调入的事务类型
       SUM(CASE WHEN (SWLX = '熔料' OR SWLX = '维修' OR SWLX = '清洗' OR SWLX = '质量问题') AND SFFX = '收' THEN ROUND(BQJG, 3) ELSE 0 END) AS A7, -- -- -- 料仓熔料入库
       SUM(CASE WHEN  SWLX <> '称重入库'  AND (DJM <> '单件调拨入库单') AND SFFX = '收' THEN ROUND(BQJG, 3) ELSE 0 END) AS RKHJ, 
       SUM(CASE WHEN SWLX = '销售出库' AND SFFX = '发' THEN ROUND(BQJG, 3) ELSE 0 END) AS B1, 
       SUM(CASE WHEN (SWLX ='调拨出库' OR SWLX='五九换料' ) AND SFFX = '发' AND DJM <> '单件调拨出库单' THEN ROUND(BQJG, 3) ELSE 0 END) AS B2, 
       SUM(CASE WHEN SWLX = '熔料' AND SFFX = '发' THEN ROUND(JS, BQJG) ELSE 0 END) AS B3, 
       SUM(CASE WHEN (SWLX = '维修' OR SWLX = '清洗' OR SWLX = '质量问题') AND SFFX = '发' THEN ROUND(BQJG, 3) ELSE 0 END) AS B4, 
       SUM(CASE WHEN (SWLX = '委外付料' OR SWLX = '委外退货' OR SWLX = '付料' OR SWLX = '付客户料') AND SFFX = '发' THEN ROUND(BQJG, 3) ELSE 0 END) AS B5, 
       SUM(CASE WHEN swlx in ('转仓出库', '维修调出') AND SFFX = '发' THEN ROUND(BQJG, 3) ELSE 0 END) AS B6,   -- modify by hyj 2022-12-12 增加维修调出的事务类型
       SUM(CASE WHEN  SWLX <> '客户出货'   AND  (DJM <> '单件调拨出库单') AND SFFX = '发' THEN ROUND(BQJG, 3) ELSE 0 END) AS CKHJ, 
       SUM(CASE WHEN SWLX = '盈亏调整' THEN ROUND(BQJG, 3) ELSE 0 END) AS YK, 
       0 AS YC, 0 AS SC, 0 AS CD
-- INTO TEMP_TEMP22
  FROM T_KA_SPLSZ 
 WHERE WDMC = V_WDMC 
   AND (CKMC = V_CKMC OR IFNULL(V_CKMC, '') = '')
 --  and ((IFNULL(V_CKMC, '') <> '' and jsmc = v_csmc) or  IFNULL(V_CKMC, '') = '')
   AND RQ >= V_QSRQ 
   AND RQ <= V_JSRQ 
   and djh not like 'zj20%' -- add by huwei ,质检的流水不计算，因为调拨里面已经计算过了
   AND (CKMC = '镶嵌Q柜'OR CKMC = '镶嵌柜-德钰东方' OR CKMC = '镶嵌硬金柜' or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓')
 GROUP BY  CASE 
--     WHEN (JSMC = '千足硬金') AND CKMC <> '镶嵌Q柜' 
--                  AND CKMC <> '镶嵌硬金柜'AND CKMC <> '镶嵌柜-德钰东方' 
--                  AND ckmc <> '客单组镶嵌德钰东方' AND ckmc <> '客单组镶嵌柜' 
--                  AND CKMC <> '维修仓' AND CKMC <> '古法金柜'
--                  AND CKMC <> '精品G柜' AND CKMC <> '硬金古法金柜' 
--                  and ckmc <> '客单组'
--                  and ckmc <> '配货中心'
--                  THEN '千足金' 
            WHEN CKMC IN (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN '' 
            WHEN CKMC = '镶嵌Q柜'OR CKMC = '镶嵌柜-德钰东方' OR CKMC = '镶嵌硬金柜' or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓' THEN '千足嵌' 
            ELSE JSMC END  , 
       CASE WHEN CKMC in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN CONCAT('料仓-', JSMC) 
            ELSE CKMC END;

#-- -- 委外打标入库标签金额处理（其他宝石入库单新系统没有了）
#DROP TEMPORARY TABLE IF EXISTS TEMP_BQJECL;
#CREATE TEMPORARY TABLE TEMP_BQJECL AS
#SELECT SUM (JGFHJ ) AS BQJE, CKMC
#-- INTO TEMP_BQJECL
#  FROM QTBSRKDH
#WHERE WDMC = V_WDMC AND RKRQ >= V_QSRQ AND RKRQ <= V_JSRQ AND IFNULL(WWRK, 0) = 1
#GROUP BY CKMC;

#UPDATE TEMP_TEMP22 A, TEMP_BQJECL B SET A.A2 = A2 + BQJE, A.RKHJ = RKHJ + BQJE
# WHERE A.CKMC = B.CKMC;

-- -取得盘点单中的实物库存
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP23;
CREATE TEMPORARY TABLE TEMP_TEMP23 AS
SELECT CASE -- WHEN PURITY_NAME = '千足硬金' THEN '千足金'
            WHEN COUNTER_NAME in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY) THEN ''
            WHEN COUNTER_NAME = '镶嵌Q柜' OR COUNTER_NAME = '镶嵌柜-德钰东方' 
                 OR COUNTER_NAME = '镶嵌硬金柜' or COUNTER_NAME = '客单组镶嵌德钰东方' 
                 or COUNTER_NAME = '客单组镶嵌柜' OR COUNTER_NAME = '维修仓' THEN '千足嵌'
            WHEN COUNTER_NAME = '精品G柜' OR PURITY_NAME = '足金(5G)' THEN '足金(5G)'
            ELSE PURITY_NAME END AS CSMC, 
       CASE WHEN COUNTER_NAME in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY)THEN CONCAT('料仓-', PURITY_NAME)            ELSE COUNTER_NAME END AS CKMC, 
       0 AS QC, 
       0 AS A1, 0 AS A2, 0 AS A3, 0 AS A4, 0 AS A5, 0 AS A6, 0 AS A7, 0 AS RKHJ, 0 AS B1, 0 AS B2, 0 AS B3, 0 AS B4, 0 AS B5, 0 AS B6, 0 AS CKHJ, 0 AS YK, 0 AS YC, 
       CAST(T_BF_WEIGHING_FORM_CHECK.total_label AS DECIMAL(18, 3)) AS SC, 0 AS CD
-- INTO TEMP_TEMP23
  FROM T_BF_WEIGHING_FORM_CHECK 
 WHERE SHOWROOM_NAME = V_WDMC
   AND (COUNTER_NAME = V_CKMC OR IFNULL(V_CKMC, '') = '')
  and ((IFNULL(V_CKMC, '') <> '' and purity_name = v_csmc) or  IFNULL(V_CKMC, '') = '')
   AND RQ = V_JSRQ 
   AND (COUNTER_NAME = '镶嵌Q柜' OR COUNTER_NAME = '镶嵌柜-德钰东方' 
        OR COUNTER_NAME = '镶嵌硬金柜' or COUNTER_NAME = '客单组镶嵌德钰东方' 
        or COUNTER_NAME = '客单组镶嵌柜' OR COUNTER_NAME = '维修仓');

-- -合并展厅盘点单的期初数据、商品流水帐的入出库数据、展厅盘点单的实物库存数据
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP24;
CREATE TEMPORARY TABLE TEMP_TEMP24 AS
SELECT CKMC, CSMC, SUM(QC) AS QC, 
       SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
       SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
       SUM(QC) + SUM(RKHJ) - SUM(CKHJ) AS YC, 
       SUM(YK) AS YK, 
       SUM(SC) AS SC, 
       SUM(SC ) - (SUM(QC) + SUM(RKHJ) - SUM(CKHJ)) + SUM(YK) AS CD
-- INTO TEMP_TEMP24
  FROM (
        SELECT CSMC, CKMC, QC, A1, A2, A3, A4, A5, A6, A7, RKHJ, B1, B2, B3, B4, B5, B6, CKHJ, YK, YC, SC, CD
          FROM TEMP_TEMP21 UNION ALL
        SELECT *
          FROM TEMP_TEMP22 UNION ALL
        SELECT *
          FROM TEMP_TEMP23
        ) S
  GROUP BY CSMC, CKMC;

DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP25;
CREATE TEMPORARY TABLE TEMP_TEMP25 AS
SELECT 21 AS XH, CONCAT(CSMC, (CASE WHEN TEMP_TEMP24.CKMC LIKE '料仓%' THEN '金料' ELSE '饰品' END)) AS KCLX, 
       C.COUNTER_CODE AS CKBM, TEMP_TEMP24.CKMC, TEMP_TEMP24.QC, 
       A1, A2, A3, A4, A5, A6, A7, RKHJ, 
       B1, B2, B3, B4, B5, B6, CKHJ, 
       YK, 
       YC, SC, CD
-- INTO TEMP_TEMP25
  FROM TEMP_TEMP24 
  LEFT JOIN T_SHOWROOM_COUNTER C 
    ON ((CASE WHEN TEMP_TEMP24.CKMC LIKE '镶嵌Q%' THEN '镶嵌Q柜'
              WHEN TEMP_TEMP24.CKMC LIKE '镶嵌硬金%' THEN '镶嵌硬金柜' 
              ELSE TEMP_TEMP24.CKMC END) = C.COUNTER_NAME 
   AND C.SHOWROOM_NAME = V_WDMC);
-- -- -- -- -- -- -- -- -- -- -- -- -标签价格结束

-- 返回报表数据
IF V_PL = '金料' THEN
    
    DROP TEMPORARY TABLE IF EXISTS TEMP_RESAULT_1;
    CREATE TEMPORARY TABLE TEMP_RESAULT_1 AS
    SELECT *
      FROM TEMP_TEMP5 WHERE CKMC LIKE '料仓%';
      
    DROP TEMPORARY TABLE IF EXISTS TEMP_RESAULT;
    CREATE TEMPORARY TABLE TEMP_RESAULT
    SELECT * FROM TEMP_RESAULT_1 WHERE (KCLX = V_KCLX OR IFNULL(V_KCLX, '') = '');
    
    -- 统计条数 
    SELECT COUNT(*) AS COUNT FROM TEMP_RESAULT;
    
    -- 分页处理
    IF V_START = -1 THEN 
      SELECT * FROM TEMP_RESAULT ORDER BY KCLX, CKBM, CKMC;
    ELSE 
      SELECT * FROM TEMP_RESAULT ORDER BY KCLX, CKBM, CKMC LIMIT V_START, V_LEN;
    END IF;

END IF;

if V_START = -99 then
 select xh,case when ckmc in ( '硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','物流部','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算') then '千足硬金饰品' else kclx end as kclx ,ckbm,ckmc,SUM(QC) AS QC, 
   SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
   SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
   SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD 
 from TEMP_TEMP5
 group by xh,case when ckmc in ( '硬金B柜', '硬金A柜', '硬金结算', '硬金精品D柜', '无字印柜', '单件化硬金柜台', '硬金精品C柜', '荟萃楼-硬金', '文创园-硬金结算', '文创园-千足硬金柜', '吉林-硬金', '吉林-硬金结算','广西-硬金柜','昆明-硬金柜','昆明-硬金结算','湖北-硬金柜','湖北-硬金结算','广西-硬金结算','深圳-单件化硬金柜台','福州-单件化硬金柜台','河南-硬金结算','河南-硬金柜','物流部','安徽-硬金柜', '安徽-硬金结算', '文创园-硬金A柜', '文创园-硬金B柜', '文创园-硬金C柜','江苏国中展销-硬金柜', '江苏国中展销-硬金结算', '湖南-硬金柜', '湖南-硬金结算', '硬金无氢柜', '硬金柜', '陕西-硬金柜', '陕西-硬金结算')  then '千足硬金饰品' else kclx end,ckbm,ckmc;
 
else
   IF V_PL = '饰品' THEN

     UPDATE TEMP_TEMP5 SET XH = 1 WHERE KCLX = '金9999饰品';
     UPDATE TEMP_TEMP5 SET XH = 3 WHERE KCLX = '千足金饰品';
     UPDATE TEMP_TEMP5 SET XH = 5 WHERE KCLX = '千足嵌饰品';
     UPDATE TEMP_TEMP5 SET XH = 7 WHERE KCLX = '古法金饰品';
     UPDATE TEMP_TEMP5 SET XH = 9 WHERE KCLX = '足金(5G)饰品';
     UPDATE TEMP_TEMP5 SET XH = 10 WHERE KCLX = '足金(无氰)饰品';
     UPDATE TEMP_TEMP5 SET XH = 12 WHERE KCLX = '足金饰品';
     UPDATE TEMP_TEMP5 SET XH = 31 WHERE KCLX = '千足硬金饰品';-- 千足硬金和古法万足加个小计 modify zhaofuqiang 20221010
     UPDATE TEMP_TEMP5 SET XH = 33 WHERE KCLX = '古法万足金饰品';

     DROP TEMPORARY TABLE IF EXISTS TEMP_RESAULT_1;
     CREATE TEMPORARY TABLE TEMP_RESAULT_1 AS
     SELECT *
      FROM TEMP_TEMP5 WHERE CKMC NOT LIKE '料仓%';
           
     INSERT INTO TEMP_RESAULT_1     
     SELECT 110 AS XH, NULL AS KCLX, NULL AS CKBM, NULL AS CKMC, NULL AS QC, 
     NULL AS A1, NULL AS A2, NULL AS A3, NULL AS A4,  NULL AS A5, NULL AS A6, NULL AS A7, NULL AS RKHJ, 
     NULL AS B1, NULL AS B2, NULL AS B3, NULL AS B4, NULL AS B5, NULL AS B6, NULL AS CKHJ, 
     NULL AS YK, NULL AS YC, NULL AS SC, NULL AS CD;
     --  维修仓 - 德钰东方 不取数据
     INSERT INTO TEMP_RESAULT_1 
     SELECT 2 AS XH, '金9999小计' AS KCLX, '' AS CKBM, '' AS CKMC, SUM(QC) AS QC, 
     SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
     SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
     SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD
     FROM TEMP_TEMP5 WHERE CKMC NOT LIKE '料仓%' AND KCLX = '金9999饰品';
     
     INSERT INTO TEMP_RESAULT_1 
     SELECT 4 AS XH, '千足金小计' AS KCLX, '' AS CKBM, '' AS CKMC, SUM(QC) AS QC, 
     SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
     SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
     SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD
     FROM TEMP_TEMP5 WHERE CKMC NOT LIKE '料仓%' AND KCLX = '千足金饰品' and  ckmc <>'镶嵌柜-德钰东方' and ckmc <>'维修仓' and ckmc <> '镶嵌柜德钰东方';
     
     INSERT INTO TEMP_RESAULT_1 
     SELECT 6 AS XH, '千足嵌小计' AS KCLX, '' AS CKBM, '' AS CKMC, SUM(QC) AS QC, 
     SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
     SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
     SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD
     FROM TEMP_TEMP5 WHERE CKMC NOT LIKE '料仓%' AND KCLX = '千足嵌饰品' and  ckmc <>'镶嵌柜-德钰东方' and ckmc <>'维修仓' and ckmc <> '镶嵌柜德钰东方';
     
     INSERT INTO TEMP_RESAULT_1 
     SELECT 7 AS XH, '古法金小计' AS KCLX, '' AS CKBM, '' AS CKMC, SUM(QC) AS QC, 
     SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
     SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
     SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD
     FROM TEMP_TEMP5 WHERE CKMC NOT LIKE '料仓%' AND KCLX = '古法金饰品';
     
     INSERT INTO TEMP_RESAULT_1 
     SELECT 9 AS XH, '足金(5G)小计' AS KCLX, '' AS CKBM, '' AS CKMC, SUM(QC) AS QC, 
     SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
     SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
     SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD
     FROM TEMP_TEMP5 WHERE CKMC NOT LIKE '料仓%' AND KCLX = '足金(5G)饰品';
     
     INSERT INTO TEMP_RESAULT_1 
     SELECT 11 AS XH, '足金(无氰)小计' AS KCLX, '' AS CKBM, '' AS CKMC, SUM(QC) AS QC, 
     SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
     SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
     SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD
     FROM TEMP_TEMP5 WHERE CKMC NOT LIKE '料仓%' AND KCLX = '足金(无氰)饰品' and  ckmc <>'镶嵌柜-德钰东方' and ckmc <>'维修仓' and ckmc <> '镶嵌柜德钰东方';
     
     INSERT INTO TEMP_RESAULT_1 
     SELECT 13 AS XH, '足金小计' AS KCLX, '' AS CKBM, '' AS CKMC, SUM(QC) AS QC, 
     SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
     SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
     SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD
     FROM TEMP_TEMP5 WHERE CKMC NOT LIKE '料仓%' AND KCLX = '足金饰品' and  ckmc <>'镶嵌柜-德钰东方' and ckmc <>'维修仓' and ckmc <> '镶嵌柜德钰东方';
     
     INSERT INTO TEMP_RESAULT_1 
     SELECT 121 AS XH, '重量总计' AS KCLX, '' AS CKBM, '' AS CKMC, SUM(QC) AS QC, 
     SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
     SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
     SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD
     FROM TEMP_TEMP5 WHERE CKMC NOT LIKE '料仓%' and ckmc <>'维修仓'  ;-- and ckmc <>'镶嵌柜-德钰东方'  and ckmc <> '镶嵌柜德钰东方';
     
     INSERT INTO TEMP_RESAULT_1 
     SELECT *
      FROM TEMP_TEMP15;
     
     INSERT INTO TEMP_RESAULT_1 
     SELECT 112 AS XH, '件数总计' AS KCLX, '' AS CKBM, '' AS CKMC, SUM(QC) AS QC, 
     SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
     SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
     SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD
     FROM TEMP_TEMP15 where  ckmc <>'维修仓'  ;-- and ckmc <>'镶嵌柜-德钰东方'  and ckmc <> '镶嵌柜德钰东方';
     
     INSERT INTO TEMP_RESAULT_1 
     SELECT *
      FROM TEMP_TEMP25;
     
     INSERT INTO TEMP_RESAULT_1 
     SELECT 122 AS XH, '金额总计' AS KCLX, '' AS CKBM, '' AS CKMC, SUM(QC) AS QC, 
     SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
     SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
     SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD
     FROM TEMP_TEMP25 where  ckmc <>'维修仓'  ;-- and ckmc <>'镶嵌柜-德钰东方'  and ckmc <> '镶嵌柜德钰东方';
     
     INSERT INTO TEMP_RESAULT_1 
     SELECT 9991 AS XH, '金99999小计' AS KCLX, '' AS CKBM, '' AS CKMC, SUM(QC) AS QC, 
     SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
     SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
     SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD
     FROM TEMP_TEMP5 WHERE CKMC NOT LIKE '料仓%' AND KCLX = '金99999饰品';
     
     -- 千足硬金和古法万足加个小计 modify zhaofuqiang 20221010
     INSERT INTO TEMP_RESAULT_1 
     SELECT 31 AS XH, '千足硬金小计' AS KCLX, '' AS CKBM, '' AS CKMC, SUM(QC) AS QC, 
     SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
     SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
     SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD
     FROM TEMP_TEMP5 WHERE CKMC NOT LIKE '料仓%' AND KCLX = '千足硬金饰品';
     
     INSERT INTO TEMP_RESAULT_1 
     SELECT 33 AS XH, '古法万足金小计' AS KCLX, '' AS CKBM, '' AS CKMC, SUM(QC) AS QC, 
     SUM(A1) AS A1, SUM(A2) AS A2, SUM(A3) AS A3, SUM(A4) AS A4, SUM(A5) AS A5, SUM(A6) AS A6, SUM(A7) AS A7, SUM(RKHJ) AS RKHJ, 
     SUM(B1) AS B1, SUM(B2) AS B2, SUM(B3) AS B3, SUM(B4) AS B4, SUM(B5) AS B5, SUM(B6) AS B6, SUM(CKHJ) AS CKHJ, 
     SUM(YK) AS YK, SUM(YC) AS YC, SUM(SC) AS SC, SUM(CD) AS CD
     FROM TEMP_TEMP5 WHERE CKMC NOT LIKE '料仓%' AND KCLX = '古法万足金饰品';

   -- 筛选库存类型，生成最终结果集
--      DROP TEMPORARY TABLE IF EXISTS TEMP_RESAULT;
--      CREATE TEMPORARY TABLE TEMP_RESAULT
--        SELECT * 
--         FROM TEMP_RESAULT_1 
--         WHERE IFNULL(CKBM, '') <> 05 
--          AND IFNULL(CKBM, '') <> 07 
--          AND (KCLX = V_KCLX OR IFNULL(V_KCLX, '') = '');


-- 2022年11月之前不取镶嵌柜-德钰东方的数据20221101开始取这块的数据,维修仓这块的数据还是保持置成0 
     DROP TEMPORARY TABLE IF EXISTS TEMP_RESAULT;
     CREATE TEMPORARY TABLE TEMP_RESAULT
       SELECT XH ,KCLX ,CKBM ,CKMC,CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END QC, 
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE A1 END A1,
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE A2 END A2 ,
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE A3 END A3 ,
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE A4 END A4, 
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE A5 END A5, 
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE A6 END A6 ,
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE A7 END A7, 
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE RKHJ END RKHJ, 
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE B1 END B1, 
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE B2 END B2 ,
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE B3 END B3 ,
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE B4 END B4 ,
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE B5 END B5, 
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE B6 END B6, 
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE CKHJ END CKHJ ,
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE YK END YK ,
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE YC END YC, 
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE SC END SC, 
       CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE CD END CD 
        FROM TEMP_RESAULT_1 
        WHERE IFNULL(CKBM, '') <> 05 
         AND IFNULL(CKBM, '') <> 07 
         AND (KCLX = V_KCLX OR IFNULL(V_KCLX, '') = '')
         ;
   -- 特殊处理
   IF EXISTS(SELECT 1 FROM TEMP_EOS_SALES_DATA WHERE RQ >= V_QSRQ AND RQ <= V_JSRQ) THEN

   WITH TEMP_EOS_DATA AS(
   SELECT XH,
       KCLX,
       CKMC,
       SUM(B1) AS B1
    FROM TEMP_EOS_SALES_DATA
    WHERE RQ >= V_QSRQ 
     AND RQ <= V_JSRQ
   GROUP BY XH, KCLX, CKMC)
   UPDATE TEMP_RESAULT T1
    INNER JOIN TEMP_EOS_DATA T2
     ON T1.XH = T2.XH
     AND T1.KCLX = T2.KCLX
     AND T1.CKMC = T2.CKMC
     SET T1.B1 = T1.B1 + T2.B1,
         T1.CKHJ = T1.CKHJ + T2.B1,
          T1.YC = T1.YC - T2.B1, -- 余存减去eos中2022-07-05过账数据
          T1.CD = T1.CD + T2.B1; -- 长短值，出库未算上，减多了，加上
   END IF;

     -- 统计条数 
     SELECT COUNT(*) AS COUNT FROM TEMP_RESAULT;
       
     -- 分页处理
     IF V_START = -1 THEN 
      SELECT * 
          FROM TEMP_RESAULT
          ORDER BY XH, KCLX, CKBM, CKMC;
     ELSE 
      SELECT * 
          FROM TEMP_RESAULT
          ORDER BY XH, KCLX, CKBM, CKMC LIMIT V_START, V_LEN;
     END IF; -- AND CKBM <> 03
   END IF;
end if ;

DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP1;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP2;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP3;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP4;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP5;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP11;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP12;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP13;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP14;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP15;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP21;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP22;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP23;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP24;
DROP TEMPORARY TABLE IF EXISTS TEMP_TEMP25;
DROP TEMPORARY TABLE IF EXISTS TEMP_RESAULT;

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;

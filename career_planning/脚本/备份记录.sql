
-- 深圳客户存欠明细取数逻辑:

select 
      a.khbm 客户编码,
      SUM(case when ifnull(b.ts,0)<=15 then ifnull(b.ze,0) end) 总额1, 
      SUM(case when ifnull(b.ts,0)>=16 and ifnull(b.ts,0)<=30 then ifnull(b.ze,0) end) 总额2,
      SUM(case when ifnull(b.ts,0)>=31 and ifnull(b.ts,0)<60 then ifnull(b.ze,0) end) 总额3,
      SUM(case when ifnull(b.ts,0)>=61 then ifnull(b.ze,0) end) 总额4
from t_ka_szkhcqmx_h a
left join t_ka_szkhcqmx_b b on a.szkhcqmx_h_identity=b.szkhcqmx_h_identity
where a.ycbs=0 
GROUP BY  khbml;
-- -----------------------------------------------------------------------------------------------------------
explain select 客户名称,客户编码,子客户,ifnull(最长欠款天数,0) 客户账龄,sum(应收欠料) 应收欠料,sum(应收欠款) 应收欠款,sum(利息) 利息,固定授信额度金重,固定授信额度,临时额度,min(最近购买时间) 最近购买时间,min(还料还款天数) 还料还款天数 from (
select 
      case when b.KHBM is not null then b.KHBM else a.KHBM end as 客户编码 ,
      case when b.khmc is not null then b.khmc else a.khmc end as 客户名称,
      case when b.ZKH is not null then b.ZKH else a.ZKH end as  子客户,
      ifnull(a.khzl,0) as 客户账龄,
      a.qlzl+a.wdqqlzl as 应收欠料,
      a.ydqje+a.wdqje+a.SYGFH+a.DYGFH as 应收欠款,
      a.lx as 利息,
      ifnull(c.jz,0) 固定授信额度金重,
      ifnull(c.kxed,0) 固定授信额度,
      ifnull(d.lsed,0) 临时额度,
      DATEDIFF(DATE(NOW()),g.rq) as 最近购买时间,
      case when datediff(g.rq,f.rq)>=0 then datediff(date(NOW()),g.rq) else datediff(date(NOW()),f.rq) end  还料还款天数    
  from t_ka_szkhcqlxzz_h a
left join (
          SELECT
                  b.customer_code as khbm,
                  b.customer_name as khmc,
                  b.child_customer_name as zkh,
                  c.customer_code as khbm1,
                  c.customer_name as khmc1,
                  c.child_customer_name as zkh1 
                FROM
                  t_finance_customer_info a
                  inner join t_finance_customer_relation b on a.finance_customer_info_identity=b.finance_customer_info_identity and b.is_main_customer=1
                  inner join t_finance_customer_relation c on a.finance_customer_info_identity=c.finance_customer_info_identity and c.showroom_name='深圳展厅'
                  where a.showroom_name='深圳展厅'
          )b on a.khbm=b.khbm1
        left join t_ka_kxjczb c on  a.customer_identity=c.customer_identity
        left join t_ka_lsedzb d on  a.customer_identity=d.customer_identity
        left join (
                          SELECT
                                b.customer_code AS jskhbm,
                                max(date( bill_date )) AS rq 
                          FROM
                            t_sale_from a
                            LEFT JOIN t_fast_customer b ON a.settle_accounts_identity = b.customer_identity 
                          WHERE `status` = 0 AND approve_status = 1 
                          UNION ALL
                          SELECT 
                                customer_code as jskhbm,
                                max(jsrq) as jsrq
                          FROM
                            xsdszh_history_eos where tabName='t_sale_from'
                                  ) e on a.khbm=e.jskhbm
       left join (
                    SELECT
                          b.customer_code AS khbm,
                          max(date(rq)) AS rq 
                        FROM
                          t_bf_receive_meterial a
                          LEFT JOIN t_fast_customer b ON a.customer_identity = b.customer_identity 
                        WHERE `status` = 0 AND approve_status = 1  and showroom_name='深圳展厅'
                        UNION ALL
                        SELECT 
                              customer_code as jskhbm,
                              max(jsrq) as jsrq
                        FROM
                          xsdszh_history_eos where tabName='t_bf_receive_meterial'
                )f on a.khbm=f.khbm                                           
       left join (
                                            SELECT
                          b.customer_code AS jskhbm,
                          max(date(rq)) AS rq 
                        FROM
                          t_bf_cus_debit_receipt a
                          LEFT JOIN t_fast_customer b ON a.customer_identity = b.customer_identity 
                        WHERE `status` = 0 AND approve_status = 1  and showroom_name='深圳展厅'
                        UNION ALL
                        SELECT 
                              customer_code as khbm,
                              max(jsrq) as jsrq
                        FROM
                          xsdszh_history_eos where tabName='t_bf_cus_debit_receipt'
                    )g on a.khbm=b.khbm
)a 
inner join (select khbm ,khmc,zkhmc as ZKH ,ifnull(zcqkts,0) as 最长欠款天数 ,ycbs from t_ka_szkhcqmx_h )  b on a.客户编码=b.khbm
where ifnull(b.ycbs,'')=0
group by 客户名称,客户编码,子客户,客户账龄 ,固定授信额度金重,固定授信额度,临时额度 ,最长欠款天数
order by 子客户,客户名称
---------------------------------------------------------------------------------------------------------------------------

-- 中文排序的时候需要转换下编码格式解决问题
order by xh, convert(plm using GBK); -- 按照中文字母排序

--  临时表存储过程创建索引
DROP TEMPORARY TABLE IF EXISTS $GN_LXJZ_SZLXCL_9_TXT1;
CREATE TEMPORARY TABLE $GN_LXJZ_SZLXCL_9_TXT1 (INDEX INDEX1(CUSTOMER_IDENTITY)) AS
INDEX INDEX1(CUSTOMER_IDENTITY) 临时表存储过程创建索引



select 't_sale_from' tabName,rq,jskhbm,csmch from xsdszh where wdmc='深圳展厅' and djstate='审核'
select 't_bf_receive_meterial' tabName,rq,khbm,csmc  from lldszh a left join lldszb b  on a.DjLsh=b.DjLsh where wdmc='深圳展厅' and a.djstate='审核'

select 't_bf_cus_debit_receipt' tabName,rq,khbm, null csmch   from skd2h where wdmc='深圳展厅' and djstate='审核'


-------------------------------------------------------------------------------------------------------------------






#! /bin/bash

do_date=`date -d "-1 day" +%F`
db=eos_sqlserver_delete_table
hive=/data/program/hive-1.2.1/bin/hive
sql="
set hive.exec.dynamic.partition.mode=nonstrict;
load data inpath '/new_test/emp.txt' into table wrok_test.emp;
"

$hive -e "$sql"




-----------------------------------------------------------------------------------------------------------------     
根据表注释获取表名
SELECT
table_name 表名,
table_comment 表说明
FROM
information_schema.TABLES
WHERE
table_schema = 'decent_cloud' and table_comment like '%来料单%'
ORDER BY
table_name
-----------------------------------------------------------------------------------------------------------------
select 
'合计'as plm,
cast($temp3.qc+$tempgf3.qc+$temp6.qc+$temp15.qc+$temp36.qc+$YJ.qc+$temp1588.qc+$temp1888.qc+$tempwq1888.qc+$tempgfwz3.qc+$tempgfwj3.qc+$tempzj3.qc+$tempqzccj3.qc+$tempwzccj3.qc+$ZJZ.qc as char(20))as qc,
cast($temp3.krtcp+$tempgf3.krtcp+$temp6.krtcp+$temp15.krtcp+$temp36.krtcp+$YJ.krtcp+$temp1588.krtcp+$temp1888.krtcp+$tempwq1888.krtcp+$tempgfwz3.krtcp+$tempgfwj3.krtcp+$tempzj3.krtcp+$tempqzccj3.krtcp+$tempwzccj3.krtcp +$ZJZ.krtcp as char(20))as krtcp,
cast($temp3.fzgcrk+$tempgf3.fzgcrk+$temp6.fzgcrk+$temp15.fzgcrk+$temp36.fzgcrk +$YJ.fzgcrk +$temp1588.fzgcrk+$temp1888.fzgcrk+$tempwq1888.fzgcrk+$tempgfwz3.fzgcrk+$tempgfwj3.fzgcrk+$tempzj3.fzgcrk+$tempqzccj3.fzgcrk+$tempwzccj3.fzgcrk +$ZJZ.fzgcrk as char(20))as fzgcrk,
cast($temp3.fzztrk+$tempgf3.fzztrk+$temp6.fzztrk+$temp15.fzztrk+$temp36.fzztrk+$YJ.fzztrk+$temp1588.fzztrk+$temp1888.fzztrk+$tempwq1888.fzztrk+$tempgfwz3.fzztrk+$tempgfwj3.fzztrk+$tempzj3.fzztrk+$tempqzccj3.fzztrk+$tempwzccj3.fzztrk +$ZJZ.fzztrk as char(20))as fzztrk,
cast($temp3.B2BRK+$tempgf3.B2BRK+$temp6.B2BRK+$temp15.B2BRK+$temp36.B2BRK+$YJ.B2BRK+$temp1588.B2BRK+$temp1888.B2BRK+$tempwq1888.B2BRK+$tempgfwz3.B2BRK+$tempgfwj3.B2BRK+$tempzj3.B2BRK+$tempqzccj3.B2BRK+$tempwzccj3.B2BRK +$ZJZ.B2BRK as char(20))as B2BRK,
cast($temp3.szgcrk+$tempgf3.szgcrk+$temp6.szgcrk+$temp15.szgcrk+$temp36.szgcrk+$YJ.szgcrk+$temp1588.szgcrk+$temp1888.szgcrk+$tempwq1888.szgcrk+$tempgfwz3.szgcrk+$tempgfwj3.szgcrk+$tempzj3.szgcrk+$tempqzccj3.szgcrk+$tempwzccj3.szgcrk+$ZJZ.szgcrk as char(20))as szgcrk,
cast($temp3.szztrk+$tempgf3.szztrk+$temp6.szztrk+$temp15.szztrk+$temp36.szztrk +$YJ.szztrk +$temp1588.szztrk +$temp1888.szztrk+$tempwq1888.szztrk+$tempgfwz3.szztrk+$tempgfwj3.szztrk+$tempzj3.szztrk+$tempqzccj3.szztrk+$tempwzccj3.szztrk+$ZJZ.szztrk as char(20))as szztrk,
cast($temp3.bjztrk+$tempgf3.bjztrk+$temp6.bjztrk+$temp15.bjztrk+$temp36.bjztrk+$YJ.bjztrk+$temp1588.bjztrk+$temp1888.bjztrk+$tempwq1888.bjztrk+$tempgfwz3.bjztrk+$tempgfwj3.bjztrk+$tempzj3.bjztrk+$tempqzccj3.bjztrk+$tempwzccj3.bjztrk+$ZJZ.bjztrk  as char(20))as bjztrk,
cast($temp3.bjrkje+$tempgf3.bjrkje+$temp6.bjrkje+$temp15.bjrkje+$temp36.bjrkje+$YJ.bjrkje+$temp1588.bjrkje+$temp1888.bjrkje+$tempwq1888.bjrkje+$tempgfwz3.bjrkje+$tempgfwj3.bjrkje+$tempzj3.bjrkje+$tempqzccj3.bjrkje+$tempwzccj3.bjrkje+$ZJZ.bjrkje  as char(20))as bjrkje,
cast($temp3.bjJDSztrk+$tempgf3.bjJDSztrk+$temp6.bjJDSztrk+$temp15.bjJDSztrk+$temp36.bjJDSztrk+$YJ.bjJDSztrk+$temp1588.bjJDSztrk+$temp1888.bjJDSztrk+$tempwq1888.bjJDSztrk+$tempgfwz3.bjJDSztrk+$tempgfwj3.bjJDSztrk+$tempzj3.bjJDSztrk+$tempqzccj3.bjJDSztrk+$tempwzccj3.bjJDSztrk+$ZJZ.bjJDSztrk as char(20))as bjJDSztrk,
cast($temp3.bjJDSrkje+$tempgf3.bjJDSrkje+$temp6.bjJDSrkje+$temp15.bjJDSrkje+$temp36.bjJDSrkje+$YJ.bjJDSrkje+$temp1588.bjJDSrkje+$temp1888.bjJDSrkje+$tempwq1888.bjJDSrkje+$tempgfwz3.bjJDSrkje+$tempgfwj3.bjJDSrkje+$tempzj3.bjJDSrkje+$tempqzccj3.bjJDSrkje+$tempwzccj3.bjJDSrkje+$ZJZ.bjJDSrkje  as char(20))as bjJDSrkje,
cast($temp3.zbztrk+$tempgf3.zbztrk+$temp6.zbztrk+$temp15.zbztrk+$temp36.zbztrk+$YJ.zbztrk+$temp1588.zbztrk+$temp1888.zbztrk+$tempwq1888.zbztrk+$tempgfwz3.zbztrk+$tempgfwj3.zbztrk+$tempzj3.zbztrk+$tempqzccj3.zbztrk+$tempwzccj3.zbztrk+$ZJZ.zbztrk  as char(20))as zbztrk,
cast($temp3.sdztrk+$tempgf3.sdztrk+$temp6.sdztrk+$temp15.sdztrk+$temp36.sdztrk+$YJ.sdztrk+$temp1588.sdztrk+$temp1888.sdztrk+$tempwq1888.sdztrk+$tempgfwz3.sdztrk+$tempgfwj3.sdztrk+$tempzj3.sdztrk+$tempqzccj3.sdztrk+$tempwzccj3.sdztrk+$ZJZ.sdztrk   as char(20))as sdztrk,
cast($temp3.sdxxyztrk+$tempgf3.sdxxyztrk+$temp6.sdxxyztrk+$temp15.sdxxyztrk+$temp36.sdxxyztrk+$YJ.sdxxyztrk+$temp1588.sdxxyztrk+$temp1888.sdxxyztrk+$tempwq1888.sdxxyztrk+$tempgfwz3.sdxxyztrk+$tempgfwj3.sdxxyztrk+$tempzj3.sdxxyztrk+$tempqzccj3.sdxxyztrk+$tempwzccj3.sdxxyztrk+$ZJZ.sdxxyztrk as char(20))as sdxxyztrk,
cast($temp3.KJztrk+$tempgf3.KJztrk+$temp6.KJztrk+$temp15.KJztrk+$temp36.KJztrk +$YJ.KJztrk +$temp1588.KJztrk+$temp1888.KJztrk+$tempwq1888.KJztrk+$tempgfwz3.KJztrk+$tempgfwj3.KJztrk+$tempzj3.KJztrk+$tempqzccj3.KJztrk+$tempwzccj3.KJztrk+$ZJZ.KJztrk as char(20))as KJztrk,
cast($temp3.wwrk+$tempgf3.wwrk+$temp6.wwrk+$temp15.wwrk+$temp36.wwrk+$YJ.wwrk+$temp1588.wwrk+$temp1888.wwrk+$tempwq1888.wwrk+$tempgfwz3.wwrk+$tempgfwj3.wwrk+$tempzj3.wwrk+$tempqzccj3.wwrk+$tempwzccj3.wwrk+$ZJZ.wwrk as char(20))as wwrk,
cast($temp3.cgrk+$tempgf3.cgrk+$temp6.cgrk+$temp15.cgrk+$temp36.cgrk+$YJ.cgrk+$temp1588.cgrk+$temp1888.cgrk+$tempwq1888.cgrk+$tempgfwz3.cgrk+$tempgfwj3.cgrk+$tempzj3.cgrk+$tempqzccj3.cgrk+$tempwzccj3.cgrk+$ZJZ.cgrk as char(20))as cgrk,
cast($temp3.qtrk+$tempgf3.qtrk+$temp6.qtrk+$temp15.qtrk+$temp36.qtrk+$YJ.qtrk+$temp1588.qtrk+$temp1888.qtrk+$tempwq1888.qtrk+$tempgfwz3.qtrk+$tempgfwj3.qtrk+$tempzj3.qtrk+$tempqzccj3.qtrk+$tempwzccj3.qtrk+$ZJZ.qtrk   as char(20))as qtrk,
cast($temp3.rkxj+$tempgf3.rkxj+$temp6.rkxj+$temp15.rkxj+$temp36.rkxj+$YJ.rkxj+$temp1588.rkxj+$temp1888.rkxj+$tempwq1888.rkxj+$tempgfwz3.rkxj+$tempgfwj3.rkxj+$tempzj3.rkxj+$tempqzccj3.rkxj+$tempwzccj3.rkxj+$ZJZ.rkxj as char(20))as rkxj,
cast($temp3.xsck+$tempgf3.xsck+$temp6.xsck+$temp15.xsck+$temp36.xsck+$YJ.xsck+$temp1588.xsck+$temp1888.xsck+$tempwq1888.xsck+$tempgfwz3.xsck+$tempgfwj3.xsck+$tempzj3.xsck+$tempqzccj3.xsck+$tempwzccj3.xsck+$ZJZ.xsck   as char(20))as xsck,
cast($temp3.szztck+$tempgf3.szztck+$temp6.szztck+$temp15.szztck+$temp36.szztck+$YJ.szztck+$temp1588.szztck+$temp1888.szztck+$tempwq1888.szztck+$tempgfwz3.szztck+$tempgfwj3.szztck+$tempzj3.szztck+$tempqzccj3.szztck+$tempwzccj3.szztck+$ZJZ.szztck as char(20))as szztck,
cast($temp3.szgcck+$tempgf3.szgcck+$temp6.szgcck+$temp15.szgcck+$temp36.szgcck+$YJ.szgcck+$temp1588.szgcck+$temp1888.szgcck+$tempwq1888.szgcck+$tempgfwz3.szgcck+$tempgfwj3.szgcck+$tempzj3.szgcck+$tempqzccj3.szgcck+$tempwzccj3.szgcck+$ZJZ.szgcck  as char(20))as szgcck,
cast($temp3.szgcrlck+$tempgf3.szgcrlck+$temp6.szgcrlck+$temp15.szgcrlck+$temp36.szgcrlck+$YJ.szgcrlck+$temp1588.szgcrlck+$temp1888.szgcrlck+$tempwq1888.szgcrlck+$tempgfwz3.szgcrlck+$tempgfwj3.szgcrlck+$tempzj3.szgcrlck+$tempqzccj3.szgcrlck+$tempwzccj3.szgcrlck+$ZJZ.szgcrlck as char(20))as szgcrlck,
cast($temp3.bjztck+$tempgf3.bjztck+$temp6.bjztck+$temp15.bjztck+$temp36.bjztck+$YJ.bjztck+$temp1588.bjztck+$temp1888.bjztck+$tempwq1888.bjztck+$tempgfwz3.bjztck+$tempgfwj3.bjztck+$tempzj3.bjztck+$tempqzccj3.bjztck+$tempwzccj3.bjztck+$ZJZ.bjztck  as char(20))as bjztck,
cast($temp3.bjckje+$tempgf3.bjckje+$temp6.bjckje+$temp15.bjckje+$temp36.bjckje+$YJ.bjckje+$temp1588.bjckje+$temp1888.bjckje+$tempwq1888.bjckje+$tempgfwz3.bjckje+$tempgfwj3.bjckje+$tempzj3.bjckje+$tempqzccj3.bjckje+$tempwzccj3.bjckje+$ZJZ.bjckje  as char(20))as bjckje,
cast($temp3.bjJDSztck+$tempgf3.bjJDSztck+$temp6.bjJDSztck+$temp15.bjJDSztck+$temp36.bjJDSztck +$YJ.bjJDSztck +$temp1588.bjJDSztck+$temp1888.bjJDSztck+$tempwq1888.bjJDSztck+$tempgfwz3.bjJDSztck+$tempgfwj3.bjJDSztck+$tempzj3.bjJDSztck+$tempqzccj3.bjJDSztck+$tempwzccj3.bjJDSztck+$ZJZ.bjJDSztck  as char(20))as bjJDSztck,
cast($temp3.bjJDSckje+$tempgf3.bjJDSckje+$temp6.bjJDSckje+$temp15.bjJDSckje+$temp36.bjJDSckje+$YJ.bjJDSckje+$temp1588.bjJDSckje+$temp1888.bjJDSckje+$tempwq1888.bjJDSckje+$tempgfwz3.bjJDSckje+$tempgfwj3.bjJDSckje+$tempzj3.bjJDSckje+$tempqzccj3.bjJDSckje+$tempwzccj3.bjJDSckje+$ZJZ.bjJDSckje  as char(20))as bjJDSckje,
cast($temp3.fzztck+$tempgf3.fzztck+$temp6.fzztck+$temp15.fzztck+$temp36.fzztck +$YJ.fzztck +$temp1588.fzztck+$temp1888.fzztck+$tempwq1888.fzztck+$tempgfwz3.fzztck+$tempgfwj3.fzztck+$tempzj3.fzztck+$tempqzccj3.fzztck+$tempwzccj3.fzztck+$ZJZ.fzztck  as char(20))as fzztck,
cast($temp3.B2BCK+$tempgf3.B2BCK+$temp6.B2BCK+$temp15.B2BCK+$temp36.B2BCK +$YJ.B2BCK +$temp1588.B2BCK+$temp1888.B2BCK+$tempwq1888.B2BCK+$tempgfwz3.B2BCK+$tempgfwj3.B2BCK+$tempzj3.B2BCK+$tempqzccj3.B2BCK+$tempwzccj3.B2BCK+$ZJZ.B2BCK  as char(20))as B2Bck,
cast($temp3.zbztck+$tempgf3.zbztck+$temp6.zbztck+$temp15.zbztck+$temp36.zbztck +$YJ.zbztck +$temp1588.zbztck+$temp1888.zbztck+$tempwq1888.zbztck+$tempgfwz3.zbztck+$tempgfwj3.zbztck+$tempzj3.zbztck+$tempqzccj3.zbztck+$tempwzccj3.zbztck+$ZJZ.zbztck  as char(20))as zbztck,
cast($temp3.sdztck+$tempgf3.sdztck+$temp6.sdztck+$temp15.sdztck+$temp36.sdztck+$YJ.sdztck+$temp1588.sdztck+$temp1888.sdztck+$tempwq1888.sdztck+$tempgfwz3.sdztck+$tempgfwj3.sdztck+$tempzj3.sdztck+$tempqzccj3.sdztck+$tempwzccj3.sdztck+$ZJZ.sdztck   as char(20))as sdztck,
cast($temp3.sdxxyztck+$tempgf3.sdxxyztck+$temp6.sdxxyztck+$temp15.sdxxyztck+$temp36.sdxxyztck+$YJ.sdxxyztck+$temp1588.sdxxyztck+$temp1888.sdxxyztck+$tempwq1888.sdxxyztck+$tempgfwz3.sdxxyztck+$tempgfwj3.sdxxyztck+$tempzj3.sdxxyztck+$tempqzccj3.sdxxyztck+$tempwzccj3.sdxxyztck+$ZJZ.sdxxyztck as char(20))as sdxxyztck,
cast($temp3.kjztck+$tempgf3.kjztck+$temp6.kjztck+$temp15.kjztck+$temp36.kjztck+$YJ.kjztck+$temp1588.kjztck+$temp1888.kjztck+$tempwq1888.kjztck+$tempgfwz3.kjztck+$tempgfwj3.kjztck+$tempzj3.kjztck+$tempqzccj3.kjztck+$tempwzccj3.kjztck+$ZJZ.kjztck   as char(20))as kjztck,
cast($temp3.wwth+$tempgf3.wwth+$temp6.wwth+$temp15.wwth+$temp36.wwth+$YJ.wwth+$temp1588.wwth+$temp1888.wwth+$tempwq1888.wwth+$tempgfwz3.wwth+$tempgfwj3.wwth+$tempzj3.wwth+$tempqzccj3.wwth+$tempwzccj3.wwth+$ZJZ.wwth  as char(20))as wwth,
cast($temp3.rlzl+$tempgf3.rlzl+$temp6.rlzl+$temp15.rlzl+$temp36.rlzl+$YJ.rlzl+$temp1588.rlzl+$temp1888.rlzl+$tempwq1888.rlzl+$tempgfwz3.rlzl+$tempgfwj3.rlzl+$tempzj3.rlzl+$tempqzccj3.rlzl+$tempwzccj3.rlzl+$ZJZ.rlzl  as char(20))as rlzl,
cast($temp3.wxzl+$tempgf3.wxzl+$temp6.wxzl+$temp15.wxzl+$temp36.wxzl+$YJ.wxzl+$temp1588.wxzl+$temp1888.wxzl+$tempwq1888.wxzl+$tempgfwz3.wxzl+$tempgfwj3.wxzl+$tempzj3.wxzl+$tempqzccj3.wxzl+$tempwzccj3.wxzl+$ZJZ.wxzl  as char(20))as wxzl,
cast($temp3.qxzl+$tempgf3.qxzl+$temp6.qxzl+$temp15.qxzl+$temp36.qxzl+$YJ.qxzl+$temp1588.qxzl+$temp1888.qxzl+$tempwq1888.qxzl+$tempgfwz3.qxzl+$tempgfwj3.qxzl+$tempzj3.qxzl+$tempqzccj3.qxzl+$tempwzccj3.qxzl+$ZJZ.qxzl   as char(20))as qxzl,
cast($temp3.wtzl+$tempgf3.wtzl+$temp6.wtzl+$temp15.wtzl+$temp36.wtzl+$YJ.wtzl+$temp1588.wtzl+$temp1888.wtzl+$tempwq1888.wtzl+$tempgfwz3.wtzl+$tempgfwj3.wtzl+$tempzj3.wtzl+$tempqzccj3.wtzl+$tempwzccj3.wtzl+$ZJZ.wtzl  as char(20))as wtzl,
cast($temp3.ckxj+$tempgf3.ckxj+$temp6.ckxj+$temp15.ckxj+$temp36.ckxj+$YJ.ckxj+$temp1588.ckxj+$temp1888.ckxj+$tempwq1888.ckxj+$tempgfwz3.ckxj+$tempgfwj3.ckxj+$tempzj3.ckxj+$tempqzccj3.ckxj+$tempwzccj3.ckxj+$ZJZ.ckxj  as char(20))as ckxj,
cast($temp3.dqjc+$tempgf3.dqjc+$temp6.dqjc+$temp15.dqjc+$temp36.dqjc+$YJ.dqjc+$temp1588.dqjc+$temp1888.dqjc+$tempwq1888.dqjc+$tempgfwz3.dqjc+$tempgfwj3.dqjc+$tempzj3.dqjc+$tempqzccj3.dqjc+$tempwzccj3.dqjc+$ZJZ.dqjc  as char(20))as dqjc,
cast($temp3.yk+$tempgf3.yk+$temp6.yk+$temp15.yk+$temp36.yk+$YJ.yk+$temp1588.yk+$temp1888.yk+$tempwq1888.yk+$tempgfwz3.yk+$tempgfwj3.yk+$tempzj3.yk+$tempqzccj3.yk+$tempwzccj3.yk+$ZJZ.yk  as char(20))as yk,
cast($temp3.jxjdsyyzxck+$tempgf3.jxjdsyyzxck+$temp6.jxjdsyyzxck+$temp15.jxjdsyyzxck+$temp36.jxjdsyyzxck+$YJ.jxjdsyyzxck+$temp1588.jxjdsyyzxck+$temp1888.jxjdsyyzxck+$tempwq1888.jxjdsyyzxck+$tempgfwz3.jxjdsyyzxck+$tempgfwj3.jxjdsyyzxck+$tempzj3.jxjdsyyzxck+$tempqzccj3.jxjdsyyzxck+$tempwzccj3.jxjdsyyzxck+$ZJZ.jxjdsyyzxck as char(20))as jxjdsyyzxck,
cast($temp3.jxxxyztck+$tempgf3.jxxxyztck+$temp6.jxxxyztck+$temp15.jxxxyztck+$temp36.jxxxyztck+$YJ.jxxxyztck+$temp1588.jxxxyztck+$temp1888.jxxxyztck+$tempwq1888.jxxxyztck+$tempgfwz3.jxxxyztck+$tempgfwj3.jxxxyztck+$tempzj3.jxxxyztck+$tempqzccj3.jxxxyztck+$tempwzccj3.jxxxyztck+$ZJZ.jxxxyztck  as char(20))as jxxxyztck,
cast($temp3.jxjdsyyzxrk+$tempgf3.jxjdsyyzxrk+$temp6.jxjdsyyzxrk+$temp15.jxjdsyyzxrk+$temp36.jxjdsyyzxrk+$YJ.jxjdsyyzxrk+$temp1588.jxjdsyyzxrk+$temp1888.jxjdsyyzxrk+$tempwq1888.jxjdsyyzxrk+$tempgfwz3.jxjdsyyzxrk+$tempgfwj3.jxjdsyyzxrk+$tempzj3.jxjdsyyzxrk+$tempqzccj3.jxjdsyyzxrk+$tempwzccj3.jxjdsyyzxrk+$ZJZ.jxjdsyyzxrk  as char(20))as jxjdsyyzxrk,
cast($temp3.jxxxyztrk+$tempgf3.jxxxyztrk+$temp6.jxxxyztrk+$temp15.jxxxyztrk+$temp36.jxxxyztrk+$YJ.jxxxyztrk+$temp1588.jxxxyztrk+$temp1888.jxxxyztrk+$tempwq1888.jxxxyztrk+$tempgfwz3.jxxxyztrk+$tempgfwj3.jxxxyztrk+$tempzj3.jxxxyztrk+$tempqzccj3.jxxxyztrk+$tempwzccj3.jxxxyztrk+$ZJZ.jxxxyztrk as char(20))as jxxxyztrk,
cast($temp3.ymyprk+$tempgf3.ymyprk+$temp6.ymyprk+$temp15.ymyprk+$temp36.ymyprk+$YJ.ymyprk+$temp1588.ymyprk+$temp1888.ymyprk+$tempwq1888.ymyprk+$tempgfwz3.ymyprk+$tempgfwj3.ymyprk+$tempzj3.ymyprk+$tempqzccj3.ymyprk+$tempwzccj3.ymyprk+$ZJZ.ymyprk as char(20))as ymyprk,
cast($temp3.ymypck+$tempgf3.ymypck+$temp6.ymypck+$temp15.ymypck+$temp36.ymypck+$YJ.ymypck+$temp1588.ymypck+$temp1888.ymypck+$tempwq1888.ymypck+$tempgfwz3.ymypck+$tempgfwj3.ymypck+$tempzj3.ymypck+$tempqzccj3.ymypck+$tempwzccj3.ymypck+$ZJZ.ymypck  as char(20))as ymypck,
cast($temp3.zjdxrk+$tempgf3.zjdxrk+$temp6.zjdxrk+$temp15.zjdxrk+$temp36.zjdxrk+$YJ.zjdxrk+$temp1588.zjdxrk+$temp1888.zjdxrk+$tempwq1888.zjdxrk+$tempgfwz3.zjdxrk+$tempgfwj3.zjdxrk+$tempzj3.zjdxrk+$tempqzccj3.zjdxrk+$tempwzccj3.zjdxrk+$ZJZ.zjdxrk  as char(20))as zjdxrk,
cast($temp3.zjdxck+$tempgf3.zjdxck+$temp6.zjdxck+$temp15.zjdxck+$temp36.zjdxck+$YJ.zjdxck+$temp1588.zjdxck+$temp1888.zjdxck+$tempwq1888.zjdxck+$tempgfwz3.zjdxck+$tempgfwj3.zjdxck+$tempzj3.zjdxck+$tempqzccj3.zjdxck+$tempwzccj3.zjdxck+$ZJZ.zjdxck  as char(20))as zjdxck,
cast($temp3.fjzjrk+$tempgf3.fjzjrk+$temp6.fjzjrk+$temp15.fjzjrk+$temp36.fjzjrk+$YJ.fjzjrk+$temp1588.fjzjrk+$temp1888.fjzjrk+$tempwq1888.fjzjrk+$tempgfwz3.fjzjrk+$tempgfwj3.fjzjrk+$tempzj3.fjzjrk+$tempqzccj3.fjzjrk+$tempwzccj3.fjzjrk+$ZJZ.fjzjrk  as char(20))as fjzjrk,
cast($temp3.fjzjck+$tempgf3.fjzjck+$temp6.fjzjck+$temp15.fjzjck+$temp36.fjzjck+$YJ.fjzjck+$temp1588.fjzjck+$temp1888.fjzjck+$tempwq1888.fjzjck+$tempgfwz3.fjzjck+$tempgfwj3.fjzjck+$tempzj3.fjzjck+$tempqzccj3.fjzjck+$tempwzccj3.fjzjck+$ZJZ.fjzjck  as char(20))as fjzjck,
cast($temp3.mxhrk+$tempgf3.mxhrk+$temp6.mxhrk+$temp15.mxhrk+$temp36.mxhrk+$YJ.mxhrk+$temp1588.mxhrk+$temp1888.mxhrk+$tempwq1888.mxhrk+$tempgfwz3.mxhrk+$tempgfwj3.mxhrk+$tempzj3.mxhrk+$tempqzccj3.mxhrk+$tempwzccj3.mxhrk +$ZJZ.mxhrk as char(20)) as mxhrk,
cast($temp3.mxhck+$tempgf3.mxhck+$temp6.mxhck+$temp15.mxhck+$temp36.mxhck+$YJ.mxhck+$temp1588.mxhck+$temp1888.mxhck+$tempwq1888.mxhck+$tempgfwz3.mxhck+$tempgfwj3.mxhck+$tempzj3.mxhck+$tempqzccj3.mxhck+$tempwzccj3.mxhck+$ZJZ.mxhck as char(20)) as mxhck
from $temp3,$tempgf3,$temp6,$temp15 ,$temp1588 ,$temp36 ,$YJ ,$temp1888,$tempwq1888 ,$tempgfwz3,$tempgfwj3,$tempzj3,$tempqzccj3,$tempwzccj3,$ZJZ;

-----------------------------------------------------------------------------------------------------------------

#!/bin/bash

HOSTNAME="10.2.12.46" #数据库信息

PORT="3306"

USERNAME="dba"

PASSWORD="dba@2022app"

DBNAME="decent_cloud"

#TABLENAME="t_eos_szlxjsrqh"

mysql="/data/program/mysql-8.0.22/bin/mysql"

wdmc='439228e3-1bfe-11eb-952f-beb5915aa4c3'

do_date=`date -d "-1 day" +%F`

echo "Begin execute GenSzztxsrb()"

execSql="call GenSzztxsrb('$do_date','$wdmc')"

echo $execSql

$mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -D${DBNAME} -e "${execSql}"



-----------------------------------------------------------------------------------------------------------------
ifnull(xsck,0)+ifnull(szztck,0)+ifnull(szgcck,0)+ifnull(bjztck,0)+ifnull(fzztck,0)+ifnull(B2Bck,0)+ifnull(zbztck,0)+ifnull(sdztck,0)+ifnull(wwth,0)+ifnull(rlzl,0)+ifnull(wxzl,0)+ifnull(qxzl,0)+ifnull(wtzl,0)+ifnull(ymypck,0)

小计是出库合计：
                售料+深圳展厅+深圳工厂+北京展厅+福州展厅+B2B云展厅+总部5楼+山东展厅+委外付料+福州工厂+其他+0+0+因美优品

入库
'客户来料' as krtcp,'福州工厂' as fzgcrk,'福州展厅' as fzztrk ,'B2B云展厅' as B2Brk,'深圳工厂' as szgcrk,'深圳展厅' as szztrk,'北京展厅' as bjztrk,'北京金德尚' as bjztrk,'总部5楼' as zbztrk,'山东展厅' as sdztrk,'德诚珠宝' as sdztrk,'K金展厅' as sdztrk,'' as wwrk,'其他' as qtrk,'购料重量' as cgrk,'因美优品' as ymyprk ,'浙江德鑫' as zjdxrk,'福建中金' as fjzjrk,'梦享会' as mxhrk,'江西金德尚运营中心' as jxjdsyyzxrk,'江西南昌展厅' as jxxxyztrk,'浙江德鑫' as zjdxrk,

ifnull(krtcp,0)+ifnull(fzgcrk,0)+ifnull(fzztrk,0)+ifnull(B2Brk,0)+ifnull(szgcrk,0)+ifnull(szztrk,0)+ifnull(bjztrk,0)+ifnull(zbztrk,0)+ifnull(sdztrk,0)+ifnull(wwrk,0)+ifnull(qtrk,0)+ifnull(cgrk,0)+ifnull(ymyprk,0)+ifnull(zjdxrk,0)+ifnull(fjzjrk,0)++ifnull(mxhrk,0)+ifnull(jxjdsyyzxrk,0)+ifnull(jxxxyztrk,0)+ifnull(bjJDSztrk,0)+ifnull(sdXXYztrk,0)+ifnull(KJztrk,0);


出库

'售料' as xsck,'深圳展厅' as szztck ,'深圳工厂' as szgcck,'北京展厅' as bjztck,'福州展厅' as fzztck,'B2B云展厅' as B2Bck,'总部5楼'as zbztck,'山东展厅' as sdztck,'委外付料' as wwth,'福州工厂' as rlzl,'其他' as wxzl,'' as qxzl,'' as wtzl,'因美优品' as  ymypck,'福建中金' as fjzjck,'梦享会' as mxhck ,'深圳工厂' as szgcrlck,
'江西金德尚运营中心' as jxjdsyyzxck,'江西南昌展厅' as jxxxyztck,'K金展厅' as kjztck,'浙江德鑫' as zjdxck,

ifnull(xsck,0)+ifnull(szztck,0)+ifnull(szgcck,0)+ifnull(bjztck,0)+ifnull(fzztck,0)+ifnull(B2Bck,0)+ifnull(zbztck,0)+ifnull(sdztck,0)+ifnull(wwth,0)+ifnull(rlzl,0)+ifnull(wxzl,0)+ifnull(qxzl,0)+ifnull(wtzl,0)+ifnull(ymypck,0)+ifnull(zjdxck,0)+ifnull(fjzjck,0)+ifnull(mxhck,0)+ifnull(szgcrlck,0)+ifnull(jxjdsyyzxck,0)+ifnull(jxxxyztck,0)++ifnull(kjztck,0)+ifnull(sdxxyztck,0)+ifnull(bjJDSztck,0)

-----------------------------------------------------------------------------------------------------------------
数据库连接信息

黄金备份
10.10.80.38
1433
sa
decent123

k金备份
10.10.80.37
1433
sa
Decent123

eos生产 端口逗号连接
10.2.1.202
1455
sa
dcdata
Dc*2014#05#13.

msyql 生产
10.2.12.46
3306
dba
dba@2022app
decent_cloud


开发测试

10.10.80.22
3206
app_test
app_test01
decent_cloud

eos测试备用
10.2.6.76 
1433
edate 
sa
2018@dc.com

eos生产从库
10.2.12.31
1433
ztdata_sync
sa
2015@dc.com

开发uat

10.10.80.64
3306
huyajuan
juan@#app2022




-----------------------------------------------------------------------------------------------------------------
原来合计：
sum(krtcp)+sum(fzgcrk)+SUM(fzztrk)+SUM(B2Brk)+SUM(szgcrk)+sum(szztrk)+SUM(bjztrk)+SUM(zbztrk)+SUM(sdztrk)+sum(qtrk)+SUM(wwrk)+SUM(cgrk)+SUM(bjJDSztrk)+SUM(bjJDSrkje)+SUM(jxjdsyyzxrk)+SUM(jxxxyztrk)+SUM(ymyprk)+SUM(zjdxrk)+SUM(fjzjrk)




sum(xsck)+sum(szztck)+SUM(szgcck)+SUM(szgcRLck)+SUM(bjztck)+SUM(fzztck)+SUM(B2Bck)+SUM(zbztck)+SUM(sdztck)+SUM(sdXXYztck)+SUM(KJztck)+sum(wwth)+sum(rlzl)+sum(wxzl)+SUM(bjJDSztck)+SUM(bjJDSckje)+SUM(jxjdsyyzxck)+SUM(jxxxyztck)+SUM(ymypck)+SUM(zjdxck)+SUM(fjzjck) as ckxj,

修改合计：

sum(krtcp)+sum(fzgcrk)+sum(fzztrk)+sum(B2Brk)+sum(szgcrk)+sum(szztrk)+sum(bjztrk)+sum(zbztrk)+sum(sdztrk)+sum(wwrk)+sum(qtrk)+sum(cgrk)+sum(ymyprk)+sum(zjdxrk)+sum(fjzjrk)++sum(mxhrk)+sum(jxjdsyyzxrk)+sum(jxxxyztrk)+sum(bjJDSztrk)+sum(sdXXYztrk)+sum(KJztrk)


sum(xsck)+sum(szztck)+sum(szgcck)+sum(bjztck)+sum(fzztck)+sum(B2Bck)+sum(zbztck)+sum(sdztck)+sum(wwth)+sum(rlzl)+sum(wxzl)+sum(qxzl)+sum(wtzl)+sum(ymypck)+sum(zjdxck)+sum(fjzjck)+sum(mxhck)+sum(szgcrlck)+sum(jxjdsyyzxck)+sum(jxxxyztck)++sum(kjztck)+sum(sdxxyztck)+sum(bjJDSztck)

-----------------------------------------------------------------------------------------------------------------


select * from t_bf_cust_return_jewelry where purity_identity='e5277a1c-1bfe-11eb-952f-beb5915aa4c3' and date(rq)='2022-07-02'
select * from t_ka_splsz where DATE(rq)='2022-07-02' and jsmc='千足硬金' and swlx='客户退饰';


select * from t_bf_cust_return_jewelry_detail where return_identity in("181bd32f-8e70-01df-9353-8477e0a5fcc8",
"181bd421-bf30-0225-84c6-c10548125a09",
"181bd48a-b4b0-0212-995f-6100a2889be3",
"181bd808-7f70-02d5-a1b1-32e86be733f0",
"181bdc34-e070-03cf-95a7-e90205da8b56",
"181bde0e-c280-0454-abb1-191167f0f3ea",
"181bdf03-2e70-04a1-b84b-29bbee857c18",
"181bdfbe-0560-04d9-8eea-32348413d6ee",
"181be0fd-fe20-052a-95a7-4c91519889fe")

select * from t_bf_cust_return_jewelry WHERE return_identity='181bd48a-b4b0-0212-995f-6100a2889be3'




select * from t_ka_splsz where DATE(rq)='2022-07-02' and jsmc='古法万足金' and swlx='客户退饰';

select * from t_bf_cust_return_jewelry where return_code in ('KHTSD202207020002',
'KHTSD202207020006','KHTSD202207020023') 


select * from t_bf_cust_return_jewelry_detail where return_identity in('181bcaf6-ebc0-0070-959d-084cef327e6e',
'181bd190-2f20-015e-b84d-3336d2bc9bdf',
'181bdd97-7f70-042b-ada2-3d2217b5d454')



select * from t_bf_cust_return_jewelry where return_identity='181bcaf6-ebc0-0070-959d-084cef327e6e'





-----------------------------------------------------------------------------------------------------------------


库存日报表_财务

      1、原料行：
      客户来料取值：取折色金重 目前来料单有相关字段（收料单里面有这个字段 剩余金重合计 remaining_gold_weight_total）（ 收料单明细里面有 剩余金重 remaining_gold_weight这个字段）
      现在报表逻辑取值是去商品流水账t_ka_splsz的金重字段
      业务方的需求是要：要取剩余金重即折色金重，目前t_ka_splsz没有这个字段

      2、深圳展厅
          客户退饰 成色工费取值,有误
          
                    成色工费取值公式： jcgfje（基础工费金额）+ FJGFJE(附加工费金额)+BQJG（标签价格 --一直是零 ） 

          目前有问题的是：
          
          古法万足工费 ： 1799（错误数据） 2329（业务根据退饰单明细查询出来的数据，取值是 工费金额合计） -- 主要差距 550的件工费
                       
                       反查单据的结果：

                    select * from t_bf_cust_return_jewelry where return_code in ('KHTSD202207020002')

                    select * from t_bf_cust_return_jewelry_detail where return_identity= '181bcaf6-ebc0-0070-959d-084cef327e6e' 

                    select * from t_ka_splsz where djh='KHTSD202207020002'

                     FJGFJE   JCGFJE
                    729.000       224.000   953

          硬金工费： 7069（错误数据） 7099（业务根据退饰单明细查询出来的数据 取值是 工费金额合计）  -- 主要差距 30 的件工费
                       
                       反查单据的结果：

                      select * from t_bf_cust_return_jewelry_detail where return_identity='181bd48a-b4b0-0212-995f-6100a2889be3'

                      select * from t_ka_splsz where djh='KHTSD202207020014'
                      JCGFJE    FJGFJE
                      17.000    18.000     35

          3、 委外加工数据不正确 正确的数据来源是委外入库报表

            千足金工费不对，主要问题是，WWRK2022070200832 单据号
            根据单据号和反查单据是2号的数据

            在记录商品流水账的时候，rq字段变成 2022-07-03 3号数据

            所以在2号查不到数据


            足金(5G)工费不对 主要是有两个单据是作废的单据，但是记录的时候进入了商品流水账，作废单据没有抵消,导致数据减少
            主要是下面的单据
            WWRK2022070200584  WWRK2022070200658 这两个是作废单据
            select * from t_receive where date(create_time)='2022-07-02' and PURITY_NAME='足金(5G)' and receive_code like 'WWRK%'
            select * from t_ka_splsz  where djh in ('WWRK2022070200584','WWRK2022070200658') 


-----------------------------------------------------------------------------------------------------------------


select * from  t_ka_splsz where  wdmc='深圳展厅' and DATE(rq)='2022-07-03' and swlx='委外入库'   and jsmc='千足金'
select * from t_receive where date(create_time)='2022-07-02' and PURITY_NAME='足金(5G)' and receive_code like 'WWRK%'
select * from t_ka_splsz  where djh in (
'WWRK2022070200584',
'WWRK2022070200658')
  
  select * from  t_ka_splsz where  wdmc='深圳展厅' and DATE(rq)='2022-07-02' and swlx='委外入库' and jsmc='足金(5G)'
  
  select a.* from  t_ka_splsz a left join t_fast_customer b on a.customer_identity=b.customer_identity where swlx='客户来料' and sffx='收' and b.customer_name<>'今日多料' and b.customer_name<>'深圳工厂'  and DATE(rq)='2022-07-02' and jsmc not like '%虚拟金料%';

select * from t_bf_raw_material

select distinct djm from t_ka_splsz

 
select *   from  t_bf_receive_meterial   where date(rq)='2022-07-02'

select * from t_ka_splsz where djh='SLD202207020002'

select a.* from t_bf_receive_meterial_detail a left join t_bf_receive_meterial b on a.receive_meterial_identity=b.receive_meterial_identity where date(rq)='2022-07-02' and  `status`=0 and approve_status=1


-----------------------------------------------------------------------------------------------------------------
select * from t_ka_splsz where DATE(rq)='2022-07-15' and swlx='转仓入库'

select * from T_BF_STOCK_TRANSFER_BILL   where DATE(rq)='2022-07-15' and transfer_type='普通转仓'

select * from t_ka_splsz where djh='ZCD202207150004'


深圳展厅当日付款报表，供应商的清洗费用，未计入。需调查程序和流水，确保和原来的报表取数保持口径，流水清查是否由swlx的问题。
付款报表 -- 库存流水明细  -     库存日报-财务  三个报表退福州工厂数据，不能保持一致性
深圳库存日报表，委外退货列，有工费，无克重体现，数据有问题。


领导反馈：

工作内容写的详细一点

-----------------------------------------------------------------------------------------------------------------

select * from t_ka_splsz where date(rq)='2022-07-03' and jsmc='千足金' and swlx='调拨入库';



select * from t_ka_splsz where   swlx='调拨入库' and chf is    null or rhf is not null 

select * from t_ka_splsz where   swlx='调拨入库' and rhf is not null 

select * from t_ka_splsz where   swlx='清洗' and sffx='发' and DATE(rq)='2022-07-13'
 and customer_identity in(select customer_identity from t_gf_area_customer)


select distinct swlx from t_ka_splsz

select * from t_ka_splsz where DATE(rq)='2022-07-15' and swlx='转仓入库'


select * from t_bf_gold_transfer_out where transfer_out_code='SJDCD07130019'



SELECT '余料' AS MC, 0.00 AS JZF, SUM(JZ) AS SL, NULL AS GF, '' AS GFS FROM T_KA_SPLSZ
WHERE WDMC = '深圳展厅'
   AND CKMC IN (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = '439228e3-1bfe-11eb-952f-beb5915aa4c3')
   AND SFFX = '收'
   AND RQ = '2022-07-02'
UNION ALL
SELECT '余料' AS MC, 0.00 AS JZF, 0-SUM(JZ) AS SL, NULL AS GF, '' AS GFS FROM T_KA_SPLSZ 
WHERE WDMC = '深圳展厅'
   AND CKMC IN (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = '439228e3-1bfe-11eb-952f-beb5915aa4c3')
   AND SFFX = '发'
   AND RQ = '2022-07-02'
   
   
  select * from t_ka_splsz where swlx='委外退货' 
   
   
   select * from t_ka_splsz where djh in('WWTH2022070500712','WWTH2022070600903'); --  WWTH2022070500712 异常单据  WWTH2022070600903 正常单据 
select * from t_sales_return where return_code in('WWTH2022070500712','WWTH2022070600903'); --  WWTH2022070500712 异常单据  WWTH2022070600903 正常单据 

-----------------------------------------------------------------------------------------------------------------


 FROM T_SALES_RETURN -- 退货单
 WHERE SHOWROOM_NAME = V_WDMC 
   AND RETURN_STATUS <> '已作废' -- 不看status状态 


   退货单 不看status的状态
   主要看RETURN_STATUS这个状态

WWRK2022070801355


-----------------------------------------------------------------------------------------------------------------



select * from t_ka_ysmxz_b where djh='KHTSD202207020002';

 select * from t_bf_cust_return_jewelry where return_code in ('KHTSD202207020002');
select * from t_bf_cust_return_jewelry_detail where return_identity= '181bcaf6-ebc0-0070-959d-084cef327e6e' ;
select * from t_ka_splsz where djh='KHTSD202207020002'    ;





select * from  t_ka_splsz where  djh='WWRK2022070200832'


select * from t_bf_cust_return_jewelry_detail  where unit_price is not null 








select  * from t_ka_splsz
where wdmc='深圳展厅' 
  and CKMC<>'镶嵌Q柜' 
    AND CKMC <>'镶嵌柜-德钰东方' 
    and CKMC<>'客单组镶嵌德钰东方' 
    and CKMC<>'客单组镶嵌柜'
    AND CKMC <>'德钰东方K金柜'
    and ckmc<>'镶嵌硬金柜'
    and ckmc<>'古法金柜'
    and ckmc<>'古法硬金柜'
    and ckmc<>'精品G柜'
    and ckmc<>'千足赤辰金'
  and ckmc<>'维修仓' 
-- and NOT EXISTS(SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = V_SHOWROOM_IDENTITY AND CKMC = COUNTER_NAME) 
  and ckmc not in (SELECT COUNTER_NAME FROM T_SHOWROOM_COUNTER WHERE TYPE = 2 AND IS_DELETE = 0 AND SHOWROOM_IDENTITY = '439228e3-1bfe-11eb-952f-beb5915aa4c3' ) 
  and '2022-07-03'=DATE(rq) and swlx='委外入库'
    and (jsmc='千足金');
    
    
    select left(RIGHT(djh,13),8),DATE_FORMAT(rq,'%Y%m%d') from t_ka_splsz where  left(RIGHT(djh,13),8)<>DATE_FORMAT(rq,'%Y%m%d')
    
    
    
    
    
    
     select * from t_receive where receive_code='WWRK2022070200832'
      date(create_time)='2022-07-02' and PURITY_NAME='足金(5G)' and receive_code like 'WWRK%';
     
     select * from t_receive_detial where receive_identity='181BE8B9-CC80-00A4-B2D6-2F461158261A'
            select * from t_ka_splsz  where djh in ('WWRK2022070200584','WWRK2022070200658');
            
            
            
          select * from t_receive where  receive_code ='WWRK2022070200832'
            

select * from t_ka_splsz where DATE(rq)='2022-07-13' and swlx like '%委外退货%' and customer_identity='0fc9371f-1bfd-11eb-952f-beb5915aa4c3' ORDER BY djh asc 
select * from T_FAST_CUSTOMER where customer_name like '%牧笛%'

select * from T_SALES_RETURN where DATE(rq)='2022-07-13' and supplier_name='深圳牧笛珠宝有限公司（5G）'


select * from T_SALES_RETURN where DATE(rq)='2022-07-13' and supplier_name like'%国君珠宝(机织链厂)%'



SELECT * from  t_ka_splsz s
inner join t_sales_return r on s.djh = r.return_code;


select * from t_receive   where  receive_code in ('WWRK2022070200584',
'WWRK2022070200658',
'WWRK2022070200843',
'WWRK2022070400658',
'WWRK2022070801350',
'WWRK2022070900581',
'WWRK2022071001156',
'WWRK2022071300784',
'WWRK2022071401391',
'WWRK2022071501261');
select * from t_ka_yfllsz where djh in ('WWRK2022070200584',
'WWRK2022070200658',
'WWRK2022070200843',
'WWRK2022070400658',
'WWRK2022070801350',
'WWRK2022070900581',
'WWRK2022071001156',
'WWRK2022071300784',
'WWRK2022071401391',
'WWRK2022071501261');


SELECT * FROM t_ka_splsz WHERE DJH='WWRK2022070801355'
select * from t_receive   where  receive_code in ('WWRK2022070801350',
'WWRK2022070801355',
'WWRK2022070801404');


select * from t_ka_splsz where djh in('WWTH2022070500712','WWTH2022070600903'); --  WWTH2022070500712 异常单据  WWTH2022070600903 正常单据 
select * from t_sales_return where return_code in('WWTH2022070500712','WWTH2022070600903'); --  WWTH2022070500712 异常单据  WWTH2022070600903 正常单据 


select * from t_ka_yfllsz where customer_identity='0fc4ac23-1bfd-11eb-952f-beb5915aa4c3' and date(rq)='2022-07-08' and djm='委外入库单'
select * from  t_ka_yfllsz where  djh='WWRK2022070700758'


select a.customer_identity, b.customer_name  from t_gf_area_customer a left join t_fast_customer b on  a.customer_identity=b.customer_identity where    b.customer_name is not null and b.customer_name='深圳市金柏珠宝首饰有限公司' 


select * from t_receive where supplier_identity ='0fc4ac23-1bfd-11eb-952f-beb5915aa4c3' and status =0 and date(create_time)<='2022-07-18'



-----------------------------------------------------------------------------------------------------------------
陈方放和梦醒的问题记录 ： 还是应付流水账账记录导致的 

select * from t_receive where DATE(create_time)='2022-07-18' and receive_code like 'WWRK%' and supplier_identity='0fd28d58-1bfd-11eb-952f-beb5915aa4c3';


select * from t_fast_customer where customer_name like '深圳市亿斯%';

select * from t_ka_yflsz where DATE(rq)='2022-07-18' and djh in ('WWRK2022071800897',
'WWRK2022071800900',
'WWRK2022071800904',
'WWRK2022071800910')



select * from t_ka_splsz 


SELECT
 sum(jz)
FROM
 t_ka_splsz t1
 where date(rq)='2022-07-02' 
 and wdmc='深圳展厅'
 and djm='调拨入库单'
 
 select * from t_ka_splsz where djm='委外入库单' and date(rq)='2022-07-17' and jz<0
 select * from t_ka_splsz where djm='委外入库单' and date(rq)='2022-07-18' and jz<0
 select * from t_ka_splsz where djm='委外入库单' and date(rq)='2022-07-15' and jz<0


胡凌的问题：

SELECT 9 AS XH, '退5G金成品' AS MC, SUM(IFNULL(T2.WEIGHT, 0))AS JZF, SUM(IFNULL(T2.WEIGHT, 0)) AS SL, NULL AS GF, '' AS GFS, '' AS BZ 
 
FROM T_BF_GOLD_TRANSFER_OUT T1 -- 素金调出单
 INNER JOIN T_BF_GOLD_TRANSFER_OUT_DETAIL T2 -- 素金调出单明细
        ON T1.TRANSFER_OUT_IDENTITY = T2.TRANSFER_OUT_IDENTITY
 WHERE T1.TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND T1.TRANSFER_IN_SHOWROOM = '福州工厂'
   AND DATE(T1.CREATE_TIME) = '2022-07-03'
   AND T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   AND T1.GENUS_NAME <> '金料'
   AND T1.PURITY_NAME = '足金(5G)';
   

 
FROM T_BF_GOLD_TRANSFER_OUT T1 -- 素金调出单
 INNER JOIN T_BF_GOLD_TRANSFER_OUT_DETAIL T2 -- 素金调出单明细
        ON T1.TRANSFER_OUT_IDENTITY = T2.TRANSFER_OUT_IDENTITY
 WHERE T1.TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND T1.TRANSFER_IN_SHOWROOM = '福州工厂'
   AND DATE(T1.CREATE_TIME) = '2022-07-03'
   AND T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   AND T1.GENUS_NAME <> '金料'
   AND T1.PURITY_NAME = '足金(5G)'
   select * from T_BF_GOLD_TRANSFER_OUT where transfer_out_code='SJDCD07030053'
   
   select * from t_ka_splsz where djh='SJDCD07030053' 
   
   select * from t_receive where receive_code='SJDCD07030053'
   
   select a.*,b.customer_name from t_ka_splsz a left join t_fast_customer b on a.customer_identity=b.customer_identity where DATE(rq)='2022-07-16' and  swlx='调拨入库' and CHF like '福州工厂%' and sffx='收'  and jsmc not like '%虚拟金料%';


胡总的问题：


-----------------------------------------------------------------------------------------------------------------
管梦丹问题 ：7月20问题排查

select sum(ifnull(jcgfje,0) + ifnull(FJGFJE,0)) from t_ka_splsz where DATE(rq)='2022-07-13' and djm='调拨出库单' and rhf like '深圳工厂%' and sffx='发' 


select * from T_BF_GOLD_TRANSFER_OUT where transfer_out_code='SJDCD07130097' 


select * from T_BF_GOLD_TRANSFER_OUT_PRINT where DATE(rq)='2022-07-13' and transfer_in_showroom='深圳工厂' and purity_name='千足硬金' and `status`=0

select CAST(SUM(561.200) AS CHAR(50))

SELECT '深圳工厂' AS MC, SUM(IFNULL(TOTAL_WEIGHT, 0))AS JZF, 0.00 AS SL, SUM(TOTAL_PRICE) AS GF, CAST(SUM(TOTAL_PRICE) AS CHAR(50)) AS GFS /*INTO TEMP19 */
FROM T_BF_GOLD_TRANSFER_OUT_PRINT -- 调出打印单
 WHERE TRANSFER_IN_SHOWROOM = '深圳工厂'
   AND DATE(DELIVER_GOODS_TIME) = '2022-07-13'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';
   
   SELECT '深圳工厂' AS MC, 0.00 AS JZF, -SUM(IFNULL(TOTAL_WEIGHT, 0)) AS SL, SUM(TOTAL_PRICE) AS GF, CAST(SUM(TOTAL_PRICE) AS CHAR(50)) AS GFS /*INTO TEMP20*/
FROM T_BF_GOLD_TRANSFER_OUT_PRINT -- 调出打印单
 WHERE TRANSFER_IN_SHOWROOM = '深圳工厂'
   AND DATE(DELIVER_GOODS_TIME) = '2022-07-13'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';
   
  select  CAST(IFNULL(76419.571,0)AS DECIMAL(20,0))
  
  76419.660
  
  
  select * from t_bf_gold_transfer_out_print_detail where transfer_out_code='SJDCD07130097'


管梦丹第九个问题


 select jsmc,sum(jz) from t_ka_splsz where DATE(rq)='2022-07-15' and swlx='委外入库' and sffx='收'
group by jsmc order by CONVERT(jsmc USING GBK);

select purity_name,sum(total_gold_weight) from t_receive where DATE(create_time)='2022-07-15' and receive_code like 'WWRK%' and `status`=0 GROUP BY purity_name order by CONVERT(purity_name USING GBK);
 
 
 
 
 select jsmc,sum(jz) from t_ka_splsz where DATE(rq)='2022-07-17' and swlx='委外入库' and sffx='收'
group by jsmc order by CONVERT(jsmc USING GBK);

select purity_name,sum(total_gold_weight) from t_receive where DATE(create_time)='2022-07-17' and receive_code like 'WWRK%' and `status`=0 GROUP BY purity_name order by CONVERT(purity_name USING GBK);

 select jsmc,sum(jz) from t_ka_splsz where DATE(rq)='2022-07-18' and swlx='委外入库' and sffx='收'
group by jsmc order by CONVERT(jsmc USING GBK);

select purity_name,sum(total_gold_weight) from t_receive where DATE(create_time)='2022-07-18' and receive_code like 'WWRK%' and `status`=0 GROUP BY purity_name order by CONVERT(purity_name USING GBK);





select * from  t_receive  where receive_code='WWRK2022071501482' 
select * from t_ka_splsz  where djh='WWRK2022071501482'








业务管梦丹反馈，委外入库没有跨天的操作，但是会出现这些跨天的数据 

我：委外入库没有跨天的操作，但是会出现这些跨天的数据  （业务是可能没有跨天的审核还是一定没有跨天的审核，这点很重要，帮我确认下，便于我向领导反馈）

管梦丹： 不可能跨天审核，这个当时有当着胡总的面打电话给商品部泽敏确认的，她们只要开了单，一保存就立即审核，开单时间与审核时间 一致，不需要做审核的动作


 select jsmc,sum(jz),djh from t_ka_splsz where DATE(rq)='2022-07-18' and swlx='委外入库' and sffx='收' and jsmc='金9999' group by djh
  order by CONVERT(djh USING GBK);

  
select purity_name,receive_code,total_gold_weight from t_receive where DATE(create_time)='2022-07-18' and receive_code like 'WWRK%' and `status`=0 and purity_name='金9999' order by CONVERT(receive_code USING GBK);






-- 2号单据 rq 记录到3号 上面
select * from t_ka_splsz where  djh='WWRK2022070200832';
select * from t_receive where receive_code='WWRK2022070200832';



-- 12号单据 rq 记录到13号 上面
select * from t_ka_splsz where  djh='WWRK2022071201216';
select * from t_receive where receive_code='WWRK2022071201216';



 -- 15号的单据 rq 记录到16号 上面 
select * from  t_receive  where receive_code='WWRK2022071501482' 
select * from t_ka_splsz  where djh='WWRK2022071501482'



成色是千足金

select * from t_ka_splsz where  djh='WWRK2022071801017'; -- 没有进入商品流水账 
select * from t_receive where receive_code='WWRK2022071801017'; -- 确实有数据的 


成色是千足硬金 -- 没有进入商品流水账  -- 确实有数据的 由于镶嵌的数据导致的

select * from t_ka_splsz where djh in ('WWRK2022071801013',  
'WWRK2022071801015',
'WWRK2022071801019',
'WWRK2022071801021',
'WWRK2022071801017'
)

select * from t_receive where receive_code in ('WWRK2022071801013',
'WWRK2022071801015',
'WWRK2022071801019',
'WWRK2022071801021',
'WWRK2022071801017')

select * from t_ka_splsz where  djh='QXRK2022070900880';
select * from t_receive where receive_code='QXRK2022070900880';


根据单据号汇总

 select jsmc,sum(jz),djh from t_ka_splsz where DATE(rq)='2022-07-18' and swlx='委外入库' and sffx='收' and jsmc='千足硬金' group by djh
  order by CONVERT(djh USING GBK);

  
select purity_name,receive_code,total_gold_weight from t_receive where DATE(create_time)='2022-07-18' and receive_code like 'WWRK%' and `status`=0 and purity_name='千足硬金' order by CONVERT(receive_code USING GBK);



-----------------------------------------------------------------------------------------------------------------


问题排查清楚： 管梦丹第九个问题

 select jsmc,sum(jz),djh from t_ka_splsz where DATE(rq)='2022-07-18' and swlx='委外入库' and sffx='收' and jsmc='千足硬金' group by djh
  order by CONVERT(djh USING GBK);

  
select purity_name,receive_code,total_gold_weight from t_receive where DATE(create_time)='2022-07-18' and receive_code like 'WWRK%' and `status`=0 and purity_name='千足硬金' order by CONVERT(receive_code USING GBK);

select * from  t_receive  where receive_code='WWRK2022071501482' 
select * from t_ka_splsz  where djh='WWRK2022071501482';


 select jsmc,sum(jz) from t_ka_splsz where DATE(rq)='2022-07-15' and swlx='委外入库' and sffx='收'
group by jsmc order by CONVERT(jsmc USING GBK);

select purity_name,sum(total_gold_weight) from t_receive where DATE(create_time)='2022-07-15' and receive_code like 'WWRK%' and `status`=0 GROUP BY purity_name order by CONVERT(purity_name USING GBK);


select * from t_ka_splsz where DATE(rq)='2022-07-09' and swlx='委外入库' and sffx='收'  and jsmc='金9999'
  order by CONVERT(jsmc USING GBK);

select purity_name,sum(total_gold_weight) from t_receive where DATE(create_time)='2022-07-09' and receive_code like 'WWRK%' and `status`=0 GROUP BY purity_name order by CONVERT(purity_name USING GBK);


select * from t_ka_splsz where  djh='QXRK2022070900880';
select * from t_receive where receive_code='QXRK2022070900880';



select * from  t_receive  where  DATE(create_time)='2022-07-09' and purity_name='金9999' and receive_code like 'WWRK%';
select * from t_ka_splsz where   DATE(rq)='2022-07-09'  and jsmc='金9999' and djh like 'WWRK%';

select * from t_receive where receive_code='WWRK2022071801017'; 




select * from t_receive where receive_code in   ('WWRK2022071801013',  
'WWRK2022071801015',
'WWRK2022071801019',
'WWRK2022071801021',
'WWRK2022071801017'
)




 
 select jsmc,sum(jz) ,djh from t_ka_splsz where DATE(rq)='2022-07-18' and swlx='委外入库' and sffx='收'   and jsmc='金9999'
group by djh order by CONVERT(jsmc USING GBK); -- 少 

select * from t_receive where DATE(create_time)='2022-07-18' and receive_code like 'WWRK%' and `status`=0  and purity_name = '金9999' order by CONVERT(purity_name USING GBK);

-----------------------------------------------------------------------------------------------------------------
本周剩余任务

账龄报表：
        内部能用
        借助计算账龄的存储过程


陈丽娟：
       客户销售汇总查询
       销售单

       只有表格样式
       无取数逻辑
       无需求说明


深圳应收账款余额表

  主要涉及2个存储过程

  gn_zljs_szzt

  T_KA_SZKHCQMX_H -- 账龄信息从这个表里面去取

  主要涉及
  -- 当日金价取数逻辑: 
  -- 深圳客户存欠明细取数逻辑:
  -- 客户存欠利息总账取数逻辑: 
  gn_cwkq_zl_02
  这个存储过程主要是更新客户账龄信息
  EOS这边前端有个用户手动执行的入口， 点击以后会执行这个存储
  更新客户的账龄信息
  一般是做完日结以后接着马上操作这个更新账龄
  1.理论上日结存储过程语句最后直接嵌套调用账龄更新的存储过程就可以， 具体的你们需要跟现场操作日结那边确认下；
  2.旧系统账龄信息在这两个表 SZKHCQMXh， SZKHCQMXB,  目前数据量主表大概45w， 跟客户信息数据基本一致；





-----------------------------------------------------------------------------------------------------------------
亚娟-梦醒作废单据异常处理

-- 已处理 
select * from t_ka_yfllsz where djh in ('WWRK2022070200584',
'WWRK2022070200658',
'WWRK2022070200843',
'WWRK2022070400658',
'WWRK2022070801350',
'WWRK2022070900581',
'WWRK2022071001156',
'WWRK2022071300784',
'WWRK2022071401391',
'WWRK2022071501261',

);

select * from t_receive   where  receive_code in ('WWRK2022070200584',
'WWRK2022070200658',
'WWRK2022070200843',
'WWRK2022070400658',
'WWRK2022070801350',
'WWRK2022070900581',
'WWRK2022071001156',
'WWRK2022071300784',
'WWRK2022071401391',
'WWRK2022071501261');


-- 未处理 
select * from t_ka_yfllsz where djh in (
'WWRK2022071700236',
'WWRK2022071800900',
'WWRK2022071800965',
'WWRK2022071800994',
'WWRK2022072000844',
'WWRK2022072001023',
'WWRK2022072001027'
);
select * from t_receive   where  receive_code in  (
'WWRK2022071700236',
'WWRK2022071800900',
'WWRK2022071800965',
'WWRK2022071800994',
'WWRK2022072000844',
'WWRK2022072001023',
'WWRK2022072001027'
);


-----------------------------------------------------------------------------------------------------------------

select return_code ,b.purity_name ,gold_weight_sum,sum(work_fee_amount_sum) from t_bf_cust_return_jewelry a left join t_purity b  on a.purity_identity=b.purity_identity  where  DATE(rq)='2022-07-06' and purity_name = '千足古法金' group by purity_name,return_code;

select djh,jsmc, sum(jz),sum(ifnull(jcgfje,0)+ ifnull(FJGFJE,0)+ifnull(BQJG,0)) from t_ka_splsz where DATE(rq)='2022-07-06' and swlx='客户退饰' and jsmc='千足古法金'  group by jsmc,djh ;
 




4号千足金 多的数据

select * from t_ka_splsz where djh in('KHTSD202207040054','KHTSD202207040052');
 select  * from t_bf_cust_return_jewelry where return_code in('KHTSD202207040054','KHTSD202207040052');

   select * from t_ka_splsz where djh in('KHTSD202207040020');
 select  * from t_bf_cust_return_jewelry where return_code in('KHTSD202207040020');

硬金 少的数据

   select * from t_ka_splsz where djh in('KHTSD202207040020');
 select  * from t_bf_cust_return_jewelry where return_code in('KHTSD202207040020');



 6号 金9999多的数据

select * from t_ka_splsz where djh in('KHTSD202207060032','KHTSD202207060039');
 select  * from t_bf_cust_return_jewelry where return_code in('KHTSD202207060032','KHTSD202207060039');

   古法金少的数据 

  select * from t_ka_splsz where djh in('KHTSD202207060016');
 select  * from t_bf_cust_return_jewelry where return_code in('KHTSD202207060016');


7号 金9999 少的数据

select * from t_ka_splsz where djh in('KHTSD202207070018');
 select  * from t_bf_cust_return_jewelry where return_code in('KHTSD202207070018');


 千足硬金少的数据 

   select * from t_ka_splsz where djh in('KHTSD202207070026');
 select  * from t_bf_cust_return_jewelry where return_code in('KHTSD202207070026');
 



9号古法金 少的数据

select * from t_ka_splsz where djh in('KHTSD202207090002','KHTSD202207090001');
 select  * from t_bf_cust_return_jewelry where return_code in('KHTSD202207090002','KHTSD202207090001');

























-----------------------------------------------------------------------------------------------------------------


 select t.*,
substring_index(substring_index(technology_purity_identity,',',b.help_topic_id+1),',',-1) as purity_jq from (
select 
      a.*, -- 1,2,3 technology_purity_identity 值
      b.showroom_name 
  from t_fast_customer a left join t_showroom b on a.showroom_identity=b.showroom_identity
  where a.customer_code='KH003975' and b.showroom_identity='ba4ead54-decc-11ea-9cfd-aecc6b4ae066'
)t
join
  mysql.help_topic b
  on b.help_topic_id < (length(t.technology_purity_identity) - length(replace(t.technology_purity_identity,',',''))+1) 






 select t.*,
substring_index(substring_index(can_produce_color,',',b.help_topic_id+1),',',-1) as purity_jq from (select can_produce_color from t_attribute_product)t
join
  mysql.help_topic b
  on b.help_topic_id < (length(t.can_produce_color) - length(replace(t.can_produce_color,',',''))+1) 











调拨出库单19号山东运营中心调出网点 ，页面显示未审核

select * from t_ka_splsz where djh='SJDRD608916'  --有数据


select * from t_bf_gold_transfer_in  where transfer_out_code='SJDRD608916' -- 没有数据


select * from t_bf_gold_transfer_in  where transfer_out_code='SJDCD608916' -- 能查到数据















-----------------------------------------------------------------------------------------------------------------


问题统计：



-- 问题18 
select * from T_BF_GOLD_TRANSFER_IN  where DATE(rq)='2022-07-15' and transfer_out_showroom like '浙江德鑫%' and status=0 -- 收 out

select * from T_BF_GOLD_TRANSFER_IN  where DATE(rq)='2022-07-15' and transfer_in_showroom like '梦享会%' and status=0  -- 售 in  

-- 问题24 

select * from T_BF_GOLD_TRANSFER_IN  where DATE(rq)='2022-07-19' and transfer_in_showroom like '浙江德鑫%' and status=0


-- 问题25  -- 梦享会

select * from T_BF_GOLD_TRANSFER_IN  where DATE(rq)='2022-07-19' and transfer_out_showroom like '梦享会%' and status=0

select * from T_BF_GOLD_TRANSFER_IN  where DATE(rq)='2022-07-19' and transfer_in_showroom like '梦享会%' and status=0

-- 问题 29

select * from T_BF_GOLD_TRANSFER_IN  where DATE(rq)='2022-07-19' and transfer_out_showroom like '山东运营%' and status=0;

select * from T_BF_GOLD_TRANSFER_IN  where DATE(rq)='2022-07-19' and transfer_in_showroom like '山东运营%' and status=0;





select return_code ,b.purity_name ,sum(gold_weight_sum),sum(work_fee_amount_sum) from t_bf_cust_return_jewelry a left join t_purity b  on a.purity_identity=b.purity_identity  where  DATE(rq)='2022-07-18' and purity_name = '千足金' group by purity_name,return_code order by return_code;

select djh,jsmc, sum(jz),sum(ifnull(jcgfje,0)+ ifnull(FJGFJE,0)+ifnull(BQJG,0)) from t_ka_splsz where DATE(rq)='2022-07-18' and swlx='客户退饰' and jsmc='千足金'  group by jsmc,djh  order by djh ;

   select * from t_ka_splsz where djh in('KHTSD202207200066','KHTSD202207200054','KHTSD202207200050','KHTSD202207200029');
 select  * from t_bf_cust_return_jewelry where return_code in('KHTSD202207200066','KHTSD202207200054','KHTSD202207200050','KHTSD202207200029');
 
 
 
 
 
    select * from t_ka_splsz where djh in('KHTSD202207180001','KHTSD202207180004' );
 select  * from t_bf_cust_return_jewelry where return_code in('KHTSD202207180001','KHTSD202207180004'  );
 
 
 
 
select * from t_bf_gold_transfer_in  where transfer_in_code='SJDRD608916' 
 
 
SELECT *
FROM T_BF_GOLD_TRANSFER_OUT_PRINT -- 调出打印单
 WHERE TRANSFER_IN_SHOWROOM = '山东运营中心'
   AND DATE(DELIVER_GOODS_TIME) = '2022-07-20'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';


select * from t_ka_splsz where djh='SJDCD608916'

select * from t_bf_gold_transfer_in  where transfer_out_code='SJDCD608916'


select * from T_BF_GOLD_TRANSFER_OUT_PRINT where transfer_in_showroom='山东运营中心' and date(rq)='2022-07-19'
select  * from t_bf_cust_return_jewelry where return_code in('KHTSD202207180001','KHTSD202207180004'  );






select purity_name,return_code,form_total_amount from t_bf_cust_return_jewelry a inner join t_purity b on a.purity_identity=b.purity_identity  where DATE(rq)='2022-07-20' and a.`status`=0 
and purity_name='千足金' order by return_code ;

select return_code,work_fee_amount_sum  from t_bf_cust_return_jewelry a inner join t_purity b on a.purity_identity=b.purity_identity  where DATE(rq)='2022-07-20' and a.`status`=0 
and purity_name='千足金' order by return_code ;

select  djh,sum( ifnull(jcgfje,0)+ifnull(FJGFJE,0)+ifnull(BQJG,0)) from t_ka_splsz where date(rq)='2022-07-20' and swlx='客户退饰' and jsmc='千足金' AND CKMC<>'镶嵌Q柜' AND CKMC <>'镶嵌柜-德钰东方' AND CKMC <>'德钰东方K金柜'  and CKMC<>'客单组镶嵌德钰东方' and CKMC<>'客单组镶嵌柜' and ckmc<>'镶嵌硬金柜' 
and ckmc<>'古法金柜' and ckmc<>'古法硬金柜' and ckmc<>'精品G柜'  and ckmc<>'千足赤辰金' GROUP BY djh ;

 select * from t_ka_splsz where djh='KHTSD202207200029';
 select *  from t_bf_cust_return_jewelry where return_code='KHTSD202207200029';
 
 
 

select  sum(work_fee_amount_sum)  from t_bf_cust_return_jewelry a inner join t_purity b on a.purity_identity=b.purity_identity  where DATE(rq)='2022-07-20' and a.`status`=0 
and purity_name='千足金' order by return_code ;
 
 select  sum( ifnull(jcgfje,0)+ifnull(FJGFJE,0)+ifnull(BQJG,0)) from t_ka_splsz where date(rq)='2022-07-20' and swlx='客户退饰' and jsmc='千足金' ;


select purity_name,SUM(total_fee) from t_receive  where DATE(create_time)='2022-07-20' and receive_code like 'WWRK%'  group by purity_name  order by purity_name;

select jsmc,sum(IFNULL(FJGFJE,0)+IFNULL(JCGFJE,0)) from t_ka_splsz where DATE(rq)='2022-07-20' and swlx='委外入库' GROUP BY jsmc ORDER BY jsmc;


-----------------------------------------------------------------------------------------------------------------


select purity_name,SUM(total_fee) from t_receive  where DATE(create_time)='2022-07-20' and receive_code like 'WWRK%'  group by purity_name  order by purity_name;

select jsmc,sum(IFNULL(FJGFJE,0)+IFNULL(JCGFJE,0)) from t_ka_splsz where DATE(rq)='2022-07-20' and swlx='委外入库' GROUP BY jsmc ORDER BY jsmc;



 







-- 千足金没有计入工费
select * from t_ka_splsz where djh in('WWRK2022072000888','WWRK2022072000890','WWRK2022072001043','WWRK2022072001051');
;
select * from t_receive  where receive_code in('WWRK2022072000888','WWRK2022072000890','WWRK2022072001043','WWRK2022072001051'); 















-----------------------------------------------------------------------------------------------------------------

t_bf_gold_transfer_in 素金调入单  -- 调拨出库单  3965.38
T_BF_GOLD_TRANSFER_OUT 素金调出单  -- 退福州工厂  深圳当天付款报表 3965.38 
T_BF_GOLD_TRANSFER_OUT_PRINT 调出打印单 -- 3581.99


付款报表  有克重没有金额 ，因为金额取的是null值

439228e3-1bfe-11eb-952f-beb5915aa4c3  -- 深圳展厅 


 
问题 29 T_BF_GOLD_TRANSFER_OUT_PRINT 没有 SJDRD608916  调拨入库单这个单据，调拨入库单这个单据梦醒修改过数据状态，导致现在是有问题的  T_BF_GOLD_TRANSFER_OUT_PRINT 没有对应的那个值 








DROP TEMPORARY TABLE IF EXISTS TEMP4417;
DROP TEMPORARY TABLE IF EXISTS TEMP4427;
DROP TEMPORARY TABLE IF EXISTS TEMP447;
DROP TEMPORARY TABLE IF EXISTS TEMP5517;
DROP TEMPORARY TABLE IF EXISTS TEMP5527;
DROP TEMPORARY TABLE IF EXISTS TEMP557;


-- 付梦享会成品 素金调出单 
-- 成品
DROP TEMPORARY TABLE IF EXISTS TEMP4417;
CREATE TEMPORARY TABLE TEMP4417 AS
SELECT '梦享会' AS MC, SUM(IFNULL(TOTAL_WEIGHT, 0))AS JZF, 0.00 AS SL, SUM(IFNULL(TOTAL_PRICE, 0)) AS GF, CAST(SUM(TOTAL_PRICE) AS CHAR(50)) AS GFS /*INTO TEMP117*/
FROM T_BF_GOLD_TRANSFER_OUT_PRINT -- 调出打印单
 WHERE TRANSFER_IN_SHOWROOM = '梦享会'
   AND DATE(DELIVER_GOODS_TIME) = V_RQ
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_OUT_SHOWROOM = V_WDMC
   AND GENUS_NAME <> '金料';
-- 金料
DROP TEMPORARY TABLE IF EXISTS TEMP4427;
CREATE TEMPORARY TABLE TEMP4427 AS
SELECT '梦享会' AS MC, 0.00 AS JZF, -SUM(IFNULL(TOTAL_WEIGHT, 0)) AS SL, SUM(IFNULL(TOTAL_PRICE, 0)) AS GF, CAST(SUM(TOTAL_PRICE) AS CHAR(50)) AS GFS /*INTO TEMP217*/
FROM T_BF_GOLD_TRANSFER_OUT_PRINT -- 调出打印单
 WHERE TRANSFER_IN_SHOWROOM = '梦享会'
   AND DATE(DELIVER_GOODS_TIME) = V_RQ
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_OUT_SHOWROOM = V_WDMC
   AND GENUS_NAME = '金料';
-- 合计
DROP TEMPORARY TABLE IF EXISTS TEMP447;
CREATE TEMPORARY TABLE TEMP447 AS
SELECT 12 AS XH, MC, SUM(IFNULL(JZF, 0)) AS JZF, SUM(IFNULL(SL, 0)) AS SL, 
SUM(IFNULL(GF, 0)) AS GF, 
 CASE WHEN SUM(IFNULL(GF, 0)) = 0 THEN '' ELSE CAST(CAST(SUM(IFNULL(GF, 0)) AS DECIMAL(20, 0)) AS CHAR(50)) END AS GFS, 
 '' AS BZ /*INTO TEMP17 */FROM 
(SELECT * FROM TEMP4417
UNION ALL
SELECT * FROM TEMP4427
) A GROUP BY MC;




-- 付浙江德鑫成品 素金调出单 
-- 成品
DROP TEMPORARY TABLE IF EXISTS TEMP5517;
CREATE TEMPORARY TABLE TEMP5517 AS
SELECT '浙江德鑫' AS MC, SUM(IFNULL(TOTAL_WEIGHT, 0))AS JZF, 0.00 AS SL, SUM(IFNULL(TOTAL_PRICE, 0)) AS GF, CAST(SUM(TOTAL_PRICE) AS CHAR(50)) AS GFS /*INTO TEMP117*/
FROM T_BF_GOLD_TRANSFER_OUT_PRINT -- 调出打印单
 WHERE TRANSFER_IN_SHOWROOM = '浙江德鑫'
   AND DATE(DELIVER_GOODS_TIME) = V_RQ
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_OUT_SHOWROOM = V_WDMC
   AND GENUS_NAME <> '金料';
-- 金料
DROP TEMPORARY TABLE IF EXISTS TEMP5527;
CREATE TEMPORARY TABLE TEMP5527 AS
SELECT '浙江德鑫' AS MC, 0.00 AS JZF, -SUM(IFNULL(TOTAL_WEIGHT, 0)) AS SL, SUM(IFNULL(TOTAL_PRICE, 0)) AS GF, CAST(SUM(TOTAL_PRICE) AS CHAR(50)) AS GFS /*INTO TEMP217*/
FROM T_BF_GOLD_TRANSFER_OUT_PRINT -- 调出打印单
 WHERE TRANSFER_IN_SHOWROOM = '浙江德鑫'
   AND DATE(DELIVER_GOODS_TIME) = V_RQ
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_OUT_SHOWROOM = V_WDMC
   AND GENUS_NAME = '金料';
-- 合计
DROP TEMPORARY TABLE IF EXISTS TEMP557;
CREATE TEMPORARY TABLE TEMP557 AS
SELECT 12 AS XH, MC, SUM(IFNULL(JZF, 0)) AS JZF, SUM(IFNULL(SL, 0)) AS SL, 
SUM(IFNULL(GF, 0)) AS GF, 
 CASE WHEN SUM(IFNULL(GF, 0)) = 0 THEN '' ELSE CAST(CAST(SUM(IFNULL(GF, 0)) AS DECIMAL(20, 0)) AS CHAR(50)) END AS GFS, 
 '' AS BZ /*INTO TEMP17 */FROM 
(SELECT * FROM TEMP5517
UNION ALL
SELECT * FROM TEMP5527
) A GROUP BY MC;









-- --------------------------------------------------------------------------------------------------------------新加
-- 收梦享会
-- 金料
DROP TEMPORARY TABLE IF EXISTS TEMP690;
CREATE TEMPORARY TABLE TEMP690 AS
SELECT 13 AS XH, '梦享会' AS MC, 0.00 AS JZF, SUM(IFNULL(TOTAL_WEIGHT, 0)) AS SL, 0-SUM(IFNULL(TOTAL_PRICE, 0)) AS GF, 
 CASE WHEN SUM(IFNULL(TOTAL_PRICE, 0)) = 0 THEN '' ELSE CAST(CAST(0-SUM(IFNULL(TOTAL_PRICE, 0)) AS DECIMAL(20, 0)) AS CHAR(50)) END AS GFS, 
 '' AS BZ  
FROM T_BF_GOLD_TRANSFER_IN -- 素金调入单
 WHERE TRANSFER_OUT_SHOWROOM = '梦享会'
   AND APPROVE_TIME >= V_RQ
   AND APPROVE_TIME <= DATE_ADD(V_RQ, INTERVAL 1 DAY)
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_IN_SHOWROOM = V_WDMC
   AND GENUS_NAME = '金料';

-- 收浙江德鑫
-- 金料
DROP TEMPORARY TABLE IF EXISTS TEMP790;
CREATE TEMPORARY TABLE TEMP790 AS
SELECT 13 AS XH, '浙江德鑫' AS MC, 0.00 AS JZF, SUM(IFNULL(TOTAL_WEIGHT, 0)) AS SL, 0-SUM(IFNULL(TOTAL_PRICE, 0)) AS GF, 
 CASE WHEN SUM(IFNULL(TOTAL_PRICE, 0)) = 0 THEN '' ELSE CAST(CAST(0-SUM(IFNULL(TOTAL_PRICE, 0)) AS DECIMAL(20, 0)) AS CHAR(50)) END AS GFS, 
 '' AS BZ  
FROM T_BF_GOLD_TRANSFER_IN -- 素金调入单
 WHERE TRANSFER_OUT_SHOWROOM = '浙江德鑫'
   AND APPROVE_TIME >= V_RQ
   AND APPROVE_TIME <= DATE_ADD(V_RQ, INTERVAL 1 DAY)
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_IN_SHOWROOM = V_WDMC
   AND GENUS_NAME = '金料';

-- --------------------------------------------------------------------------------------------------------------- 新加

15号数据不对的问题 主要是确少委外的数据

select * from t_ka_splsz where djh='WWTH2022071501336';
select * from t_sales_return where return_code='WWTH2022071501336';





select djh,sum( ROUND(ifnull(jcgfje,0),0) + ROUND(ifnull(FJGFJE,0),0)) from t_ka_splsz where DATE(rq)='2022-07-24' and swlx='委外退货' and (jsmc='千足硬金') group by djh order by djh

select * from t_sales_return where return_code in('WWTH2022072400007',
'WWTH2022072400199',
'WWTH2022072400417',
'WWTH2022072400476',
'WWTH2022072400766',
'WWTH2022072401290') ORDER BY return_code;




24 号也是缺少委外的数据
select djh,sum( ROUND(ifnull(jcgfje,0),0) + ROUND(ifnull(FJGFJE,0),0)) from t_ka_splsz where DATE(rq)='2022-07-24' and swlx='委外退货' and (jsmc='千足硬金') and djh  in (
'WWTH2022072400417',
'WWTH2022072400476',
'WWTH2022072400766',
'WWTH2022072401290') group by djh order by djh;


select return_code,sum(return_total_price) from t_sales_return where return_code in (
'WWTH2022072400417',
'WWTH2022072400476',
'WWTH2022072400766',
'WWTH2022072401290') GROUP BY return_code order by return_code ;


select * from t_ka_splsz where djh  in (
'WWTH2022072400417',
'WWTH2022072400476',
'WWTH2022072400766',
'WWTH2022072401290')

select * from t_sales_return where return_code in (
'WWTH2022072400417',
'WWTH2022072400476',
'WWTH2022072400766',
'WWTH2022072401290')


18号数据问题  -- 显示没有问题,数据数据有问题


select * from t_sales_return where return_code ='WWTH2022071800834'; 
select * from t_ka_splsz where DATE(rq)='2022-07-18' and djh='WWTH2022071800834';





























-----------------------------------------------------------------------------------------------------------------


大佬们，请问下现在有张hive表，是外部表，parquet存储格式，然后我通过java代码把数据用parquet-hadoop包的api生成文件到hive表指定分区条件目录里，再用msck命令修复分区，但是用hive查询这个分区的数据时查不出数据，count的时候总量是对的，而且不指定这个分区的全量查询时也能正常查出这个分区里的数据（同样的逻辑生成orc格式的文件查询都是正常的）
-----------------------------------------------------------------------------------------------------
计划安排
        库存日报表财务 小计工费
        当期结存
        账龄报表联调
        和黄丽娟沟通销售报表































-----------------------------------------------------------------------------------------------------------------

select customerName,childCustomerName, purity_name, B2BNetWeight from (
select customerName,childCustomerName, purity_name, B2BNetWeight from (
SELECT
 CASE 
  WHEN t5.customer_name is not null THEN
   t5.customer_name
  ELSE
   t4.customer_name
 END AS customerName,
 CASE 
  WHEN t5.customer_name is not null THEN
   t4.customer_name
  ELSE
   null
 END AS childCustomerName,
 t3.purity_name,
 sum(t1.net_weight) AS B2BNetWeight
FROM
 t_fast_package t1
 LEFT JOIN t_showroom_counter t2 ON t1.showroom_counter_identity = t2.counter_identity
 LEFT JOIN t_purity t3 ON t1.purity_identity = t3.purity_identity
 LEFT JOIN t_fast_customer t4 ON t1.customer_identity = t4.customer_identity
 LEFT JOIN t_fast_customer t5 ON t4.parent_customer_identity = t5.customer_identity
 WHERE 
 t1.is_delete = 0
 and t1.is_b2b = 1
 and kdsj >= '2022-07-01'
 and kdsj <= '2022-07-27'
 AND t2.showroom_name like '%深圳展厅%'
 GROUP BY t1.customer_identity,t2.purity_identity
 ORDER BY t4.customer_identity
)m

 
 union all 

select customerName,childCustomerName,null as purity_name, sum(B2BNetWeight) over (partition by customerName order by customerName,childCustomerName )   B2BNetWeight from (
SELECT
 CASE 
  WHEN t5.customer_name is not null THEN
   t5.customer_name
  ELSE
   t4.customer_name
 END AS customerName,
 CASE 
  WHEN t5.customer_name is not null THEN
   t4.customer_name
  ELSE
   null
 END AS childCustomerName,
 t3.purity_name,
 sum(t1.net_weight) AS B2BNetWeight
FROM
 t_fast_package t1
 LEFT JOIN t_showroom_counter t2 ON t1.showroom_counter_identity = t2.counter_identity
 LEFT JOIN t_purity t3 ON t1.purity_identity = t3.purity_identity
 LEFT JOIN t_fast_customer t4 ON t1.customer_identity = t4.customer_identity
 LEFT JOIN t_fast_customer t5 ON t4.parent_customer_identity = t5.customer_identity
 WHERE 
 t1.is_delete = 0
 and t1.is_b2b = 1
 and kdsj >= '2022-07-01'
 and kdsj <= '2022-07-27'
 AND t2.showroom_name like '%深圳展厅%'
 GROUP BY t1.customer_identity,t2.purity_identity
 ORDER BY t4.customer_identity
)t 
GROUP BY  customerName,childCustomerName
)n
 order by customerName,childCustomerName






T_BF_GOLD_TRANSFER_OUT
























-----------------------------------------------------------------------------------------------------------------

模板sql 
select return_code ,b.purity_name ,gold_weight_sum,sum(work_fee_amount_sum) from t_bf_cust_return_jewelry a left join t_purity b  on a.purity_identity=b.purity_identity  where  DATE(rq)='2022-07-23' and (purity_name='古法金' )  group by purity_name,return_code;

select djh,jsmc, sum(jz),sum(ifnull(jcgfje,0)+ ifnull(FJGFJE,0)+ifnull(BQJG,0)) from t_ka_splsz where DATE(rq)='2022-07-23' and swlx='客户退饰' and (jsmc='古法金' ) group by jsmc,djh ;





问题43

25 号
       多10元  千足金
select * from t_bf_cust_return_jewelry where return_code='KHTSD202207250075';
select * from t_ka_splsz where djh='KHTSD202207250075';

 
    多46859元 第二个单据没有记账 千足硬金
  
select * from t_bf_cust_return_jewelry where return_code='KHTSD202207250119' or return_code='KHTSD202207250062' ;
select * from t_ka_splsz where djh='KHTSD202207250119' or djh='KHTSD202207250062';


问题42
23 号 
 千足硬金 少 20元
 select * from t_bf_cust_return_jewelry where return_code='KHTSD202207230040';
select * from t_ka_splsz where djh='KHTSD202207230040';


 古法万足金 少40 元
select * from t_bf_cust_return_jewelry where return_code='KHTSD202207230076';
select * from t_ka_splsz where djh='KHTSD202207230076';


 古法金 少30元
 select * from t_bf_cust_return_jewelry where return_code='KHTSD202207230070';
select * from t_ka_splsz where djh='KHTSD202207230070';



问题44-45：

      取的是素金调出单
      T_BF_GOLD_TRANSFER_OUT 目前工费取的是null，但是应该取的total_price 
      但是和库存日报表财务的还对不上的,金额有差值,考虑小数点精确的问题
      精度不一致的问题

      select * from t_ka_splsz
      where  wdmc='深圳展厅' and DATE(rq)='2022-07-24'  and ( jsmc='古法万足金')   and rhf like '特艺城展厅%'   and sffx='发' ;


      select * from T_BF_GOLD_TRANSFER_OUT_PRINT where DATE(rq)='2022-07-24' and transfer_in_showroom like '特艺城展厅%' and PURITY_NAME='古法万足金';


  



问题38 明细和调出打印单基本相等



SELECT  gold_transfer_out_print_identity, SUM(TOTAL_PRICE) AS GF 
FROM T_BF_GOLD_TRANSFER_OUT_PRINT -- 调出打印单
 WHERE TRANSFER_IN_SHOWROOM = '深圳工厂'
   AND DATE(DELIVER_GOODS_TIME) = '2022-07-22'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'  GROUP BY gold_transfer_out_print_identity;
   

   select  transfer_out_print_identity,sum(price) from t_bf_gold_transfer_out_print_detail  where transfer_out_print_identity in (
 '18223d55-a530-0ce7-a650-759b67d8e80a',
'18223d89-0cd0-0cda-9266-9c927e655f60',
'18223dcf-2f60-0cff-8b82-1937f0ca9065',
'18223dde-41b0-0cea-9652-376fdcafdd2e',
'18223de3-68c0-0ceb-bd3e-02a693dc96bb',
'18224729-4360-0ed9-8e36-fcebe11f75eb',
'18224794-b420-0eee-94a7-131187f01b62',
'182247a7-ec20-0ea5-879d-59f9ca87062b',
'182247be-f0b0-0ef7-aeaa-10036f33ba22',
'182247ec-d010-0ecd-8c33-ff053527da09',
'18224adb-ba40-0fbc-ad54-6ca6be17ed98',
'18224ae1-cfd0-0fbd-8f8d-a064fcfd4cc2',
'18224c42-1000-0fe3-874a-404584f6210e',
'18224c74-c260-0fed-9640-f2ce9c38eddb',
'18224c85-97a0-0fe7-8c0f-b0a211556c5c',
'182254f6-b310-11e9-b587-cdd8bead287f',
'182255f3-0760-1230-b0f1-ddc7aad63d42',
'1822560d-b480-1236-a3e7-28638dd84dff',
'1822564a-75e0-1241-af5c-648c4085ab19',
'182259fc-b030-0033-b2d7-f7ce683ad828')GROUP BY transfer_out_print_identity



问题38：

       select  * from t_bf_gold_transfer_out_print_detail  where transfer_out_code in ('SJDCD07200011',
'SJDCD07200012',
'SJDCD07200109',
'SJDCD07210024',
'SJDCD07210057',
'SJDCD07210064',
'SJDCD07210071',
'SJDCD07210072',
'SJDCD07210077',
'SJDCD07220001',
'SJDCD07220003',
'SJDCD07220004',
'SJDCD07220005',
'SJDCD07220006',
'SJDCD07220008',
'SJDCD07220017',
'SJDCD07220018',
'SJDCD07220026',
'SJDCD07220034',
'SJDCD07220036',
'SJDCD07220040',
'SJDCD07220044',
'SJDCD07220046',
'SJDCD07220054',
'SJDCD07220055',
'SJDCD07220056',
'SJDCD07220057',
'SJDCD07220076',
'SJDCD07220077',
'SJDCD07220084',
'SJDCD07220085',
'SJDCD07220086',
'SJDCD07220087',
'SJDCD07220088',
'SJDCD07220089',
'SJDCD07220090')GROUP BY transfer_out_code order by transfer_out_code;

   select  gold_transfer_out_print_code,sum(total_price) from t_bf_gold_transfer_out_print  where gold_transfer_out_print_identity in (
 '18223d55-a530-0ce7-a650-759b67d8e80a',
'18223d55-a530-0ce7-a650-759b67d8e80a',
'18223de3-68c0-0ceb-bd3e-02a693dc96bb',
'18223d55-a530-0ce7-a650-759b67d8e80a',
'18224729-4360-0ed9-8e36-fcebe11f75eb',
'18224c74-c260-0fed-9640-f2ce9c38eddb',
'18223dcf-2f60-0cff-8b82-1937f0ca9065',
'18223dcf-2f60-0cff-8b82-1937f0ca9065',
'18223de3-68c0-0ceb-bd3e-02a693dc96bb',
'18224c74-c260-0fed-9640-f2ce9c38eddb',
'18224c85-97a0-0fe7-8c0f-b0a211556c5c',
'18224c74-c260-0fed-9640-f2ce9c38eddb',
'18223d89-0cd0-0cda-9266-9c927e655f60',
'18223d55-a530-0ce7-a650-759b67d8e80a',
'18223d55-a530-0ce7-a650-759b67d8e80a',
'18223db1-2590-0ce4-9108-37553f60b640',
'18223dde-41b0-0cea-9652-376fdcafdd2e',
'18224c42-1000-0fe3-874a-404584f6210e',
'18224adb-ba40-0fbc-ad54-6ca6be17ed98',
'18224adb-ba40-0fbc-ad54-6ca6be17ed98',
'18224ae1-cfd0-0fbd-8f8d-a064fcfd4cc2',
'18224ae1-cfd0-0fbd-8f8d-a064fcfd4cc2',
'18224ae1-cfd0-0fbd-8f8d-a064fcfd4cc2',
'18224794-b420-0eee-94a7-131187f01b62',
'182247a7-ec20-0ea5-879d-59f9ca87062b',
'182247be-f0b0-0ef7-aeaa-10036f33ba22',
'182247ec-d010-0ecd-8c33-ff053527da09',
'182254f6-b310-11e9-b587-cdd8bead287f',
'182259fc-b030-0033-b2d7-f7ce683ad828',
'182255f3-0760-1230-b0f1-ddc7aad63d42',
'1822560d-b480-1236-a3e7-28638dd84dff',
'1822564a-75e0-1241-af5c-648c4085ab19',
'182256dc-8790-0005-8872-52709ff5c1d2',
'182259e5-5340-0031-87dc-adb31c6f5c41',
'18225a61-5cf0-0096-9483-9e85623fbf19',
'18225b2f-1fa0-001e-b502-4aa884626089')GROUP BY gold_transfer_out_print_identity ORDER BY gold_transfer_out_print_code;





select djh,sum(ifnull(fjgfje,0)+ifnull(jcgfje,0)) from t_ka_splsz where DATE(rq)='2022-07-22' and rhf like '深圳工厂%' and djm='调拨出库单' and sffx='发' GROUP BY djh  order by djh




问题37：
      古法金成色是对上的

      硬金多13.08 克

      主要这条单据影响
       WWTH2022071700680 这个单据是17号的单据
      委外入库报表没有这个单据  ,退货时间 没有更新

      但是商品流水账有记录这条数据 

      select * from t_sales_return where  return_code in ('WWTH2022071700680','WWTH2022072001074'); -- 这两天数据没有记录 委外退货报表

      select * from t_ka_splsz where djh in ('WWTH2022071700680','WWTH2022072001074'); 




问题32 
21号数据
select * from  t_ka_splsz where djh='WWRK2022072100926' 这个单据 ，千足金工费没有计算在内

select djh,rq,sum(jz),sum(IFNULL(jcgfje,0)+IFNULL(fjgfje,0)) from t_ka_splsz where djh in(
 'WWRK2022072100757', -- 没有记录工费 3531.6
 'WWRK2022072100889', -- 没有记录工费  214
 'WWRK2022072100862',-- 没有记录工费   90
 'WWRK2022072100830', -- 没有记录工费   1028
 'WWRK2022072100788' -- 这笔工费计算到22号 4806 rq是22号
)
GROUP BY djh



问题33：
    22号数据

    千足多 33.18 克 18号号的数据在22号计算了，所以多了

      select * from t_receive where receive_code='WWRK2022071801017'

      select * from t_ka_splsz where djh='WWRK2022071801017'

  这两条数据是18号和21号的数据
                             流水记录了这样的数据，但是委外入库没有这样的记录    33.870+228.860
  select * from t_receive where  receive_code in ('WWRK2022071801015',
'WWRK2022072100788')



这两条数据记录到23号（委外入库报表记录了这样的数据）但是流水没有记录   33.87+33.18

select * from t_ka_splsz where djh in ('WWRK2022072201405',
'WWRK2022072201408')




问题34 硬金多67.05克 主要是22号入库 23号审核 ，进流水账是23号 ,主要是这两条单据影响导致的 
这两条数据记录到23号（委外入库报表记录了这样的数据）但是流水没有记录   33.87+33.18

select * from t_ka_splsz where djh in ('WWRK2022072201405',
'WWRK2022072201408') 



select * from t_ka_splsz where djh in ('WWRK2022072201405',
'WWRK2022072201408',
'WWRK2022072300691',
'WWRK2022072300863',
'WWRK2022072300897',
'WWRK2022072300940',
'WWRK2022072300959',
'WWRK2022072300979',
'WWRK2022072300982',
'WWRK2022072300994',
'WWRK2022072301031',
'WWRK2022072301046',
'WWRK2022072301077',
'WWRK2022072301107',
'WWRK2022072301124',
'WWRK2022072301129',
'WWRK2022072301143',
'WWRK2022072301146',
'WWRK2022072301150',
'WWRK2022072301153',
'WWRK2022072301157',
'WWRK2022072301158',
'WWRK2022072301160',
'WWRK2022072301161',
'WWRK2022072301162',
'WWRK2022072301163',
'WWRK2022072301168',
'WWRK2022072301180',
'WWRK2022072301185',
'WWRK2022072301198',
'WWRK2022072301203',
'WWRK2022072301208',
'WWRK2022072301217',
'WWRK2022072301230',
'WWRK2022072301234');



问题35：

select  receive_code,sum(total_fee) from t_receive where receive_code in (
'WWRK2022072401249',
'WWRK2022072401312')GROUP BY receive_code;
select * from t_ka_splsz where djh in ('WWRK2022072401249',
'WWRK2022072401312');

问题47：  QXRK2022072600652 -- 镶嵌入库的不错，委外入库的全错


select djh ,sum(IFNULL(FJGFJE,0)+IFNULL(JCGFJE,0)) from t_ka_splsz where date(rq)='2022-07-26' and swlx='委外入库' GROUP BY djh;





select  receive_code,sum(total_fee) from t_receive where receive_code in ('QXRK2022072600652',
'WWRK2022072500759',
'WWRK2022072600312',
'WWRK2022072600325',
'WWRK2022072600347',
'WWRK2022072600381',
'WWRK2022072600454',
'WWRK2022072600475',
'WWRK2022072600541',
'WWRK2022072600623',
'WWRK2022072600630',
'WWRK2022072600643',
'WWRK2022072600649',
'WWRK2022072600668',
'WWRK2022072600679',
'WWRK2022072600680',
'WWRK2022072600681',
'WWRK2022072600682',
'WWRK2022072600683',
'WWRK2022072600684',
'WWRK2022072600685',
'WWRK2022072600689',
'WWRK2022072600690',
'WWRK2022072600691',
'WWRK2022072600699',
'WWRK2022072600702',
'WWRK2022072600705',
'WWRK2022072600708',
'WWRK2022072600711',
'WWRK2022072600712',
'WWRK2022072600715',
'WWRK2022072600716',
'WWRK2022072600717',
'WWRK2022072600718',
'WWRK2022072600719',
'WWRK2022072600725',
'WWRK2022072600728',
'WWRK2022072600729',
'WWRK2022072600736',
'WWRK2022072600739',
'WWRK2022072600741',
'WWRK2022072600743',
'WWRK2022072600746',
'WWRK2022072600747',
'WWRK2022072600750',
'WWRK2022072600754',
'WWRK2022072600810')GROUP BY receive_code;



select djh ,sum(IFNULL(FJGFJE,0)+IFNULL(JCGFJE,0)) from t_ka_splsz where date(rq)='2022-07-25' and swlx='委外入库' GROUP BY djh;




 

select  receive_code,sum(total_fee) from t_receive where receive_code in (
'QXRK2022072500762',
'WWRK2022072500271',
'WWRK2022072500574',
'WWRK2022072500587',
'WWRK2022072500617',
'WWRK2022072500620',
'WWRK2022072500621',
'WWRK2022072500622',
'WWRK2022072500625',
'WWRK2022072500627',
'WWRK2022072500628',
'WWRK2022072500629',
'WWRK2022072500630',
'WWRK2022072500632',
'WWRK2022072500637',
'WWRK2022072500638',
'WWRK2022072500642',
'WWRK2022072500648',
'WWRK2022072500656',
'WWRK2022072500661',
'WWRK2022072500662',
'WWRK2022072500663',
'WWRK2022072500664',
'WWRK2022072500666',
'WWRK2022072500670',
'WWRK2022072500671',
'WWRK2022072500682',
'WWRK2022072500697',
'WWRK2022072500704',
'WWRK2022072500705',
'WWRK2022072500707',
'WWRK2022072500710',
'WWRK2022072500711',
'WWRK2022072500716',
'WWRK2022072500728',
'WWRK2022072500733',
'WWRK2022072500734',
'WWRK2022072500736',
'WWRK2022072500753',
'WWRK2022072500757')GROUP BY receive_code;




问题21：
出现了一笔流水金额为负，金重是正常的，需要梦醒查明原因

Select * from t_receive where receive_code='WWRK2022070801292';

select * from t_ka_splsz where djh='WWRK2022070801292';



问题26：
      26：
   
-- 千足金没有计入工费
select * from t_ka_splsz where djh in('WWRK2022072000888','WWRK2022072000890','WWRK2022072001043','WWRK2022072001051');
;
select * from t_receive  where receive_code in('WWRK2022072000888','WWRK2022072000890','WWRK2022072001043','WWRK2022072001051'); 

 
 -- 千足硬金的工费都没有取值
 select * from t_ka_splsz where  djh='WWRK2022072000895';
  
 select * from t_receive where receive_code ='WWRK2022072000895';








问题46：
      select * from t_bf_gold_transfer_out_detail where transfer_out_identity in(
'181fa89e-cbe0-00b4-9627-4b71c9279320',
'181fb7e5-0e50-03f9-8c50-6b7a5f26986b'
);

select * from t_ka_splsz where id in(207573,
207574);





-----------------------------------------------------------------------------------------------------------------

2022-08-01



select * from t_sales_return where DATE(rq)='2022-07-09' and return_total_weight='12.32';
select * from   t_ka_splsz where djh='WWTH2022070900928';



select djh,sum(ifnull(jcgfje,0) + ifnull(FJGFJE,0))  from t_ka_splsz  
where  wdmc='深圳展厅' and DATE(rq)='2022-07-28'  and ( jsmc='千足金')  AND CKMC<>'镶嵌Q柜' AND CKMC <>'镶嵌柜-德钰东方' AND CKMC <>'德钰东方K金柜'  and CKMC<>'客单组镶嵌德钰东方' and CKMC<>'客单组镶嵌柜' and ckmc<>'镶嵌硬金柜' 
and ckmc<>'古法金柜' and ckmc<>'古法硬金柜' and ckmc<>'精品G柜'  and ckmc<>'千足赤辰金'  and swlx='委外入库'  and sffx='收' GROUP BY djh ORDER BY djh;

select * from t_ka_splsz where djh='WWRK2022072801205';

select * from t_receive WHERE receive_code='WWRK2022072801205';

select * from t_receive_detial where receive_identity='18243DA6-9BD0-09FD-B053-AECFCBFA4C28';

-----------------------------------------------------------------------------------------------------------------




#!/bin/sh
ps -ef |grep DFSZKFailoverController|grep -v grep|awk -F " " '{print$2}'
if [ $? -ne 0 ]
then
echo "ZKFC进程在运行中....."
else
/data/program/hadoop-2.7.2/sbin/hadoop-daemon.sh zkfc start
fi



*/60  * * * * /bin/sh /data/program/hadoop-2.7.2/bin/process.sh































-----------------------------------------------------------------------------------------------------------------

问题50：万足金的问题  -26 +4   -22 元 

SELECT   *
FROM T_BF_GOLD_TRANSFER_OUT_PRINT -- 调出打印单
 WHERE TRANSFER_IN_SHOWROOM = '深圳工厂'
   AND DATE(DELIVER_GOODS_TIME) = '2022-07-29'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料' and purity_name='金9999' ;
   
   SELECT   *
FROM t_bf_gold_transfer_out_print_detail where transfer_out_code='SJDCD07290149';

select * from T_BF_GOLD_TRANSFER_OUT_PRINT where gold_transfer_out_print_identity='18248f12-0ff0-048e-b97c-0c2f6ef38782';
   
   select djh,sum(IFNULL(FJGFJE,0)+IFNULL(JCGFJE,0)) from t_ka_splsz where DATE(rq)='2022-07-29' and swlx<>'熔料'     and  djm = '调拨出库单' and rhf like '深圳工厂%' and sffx='发'  and jsmc  = '金9999'  and ckmc<>'万足赤辰金'  group by djh ;
   
   select * from t_bf_gold_transfer_out where transfer_out_code='SJDCD07290149'; -- 调拨出库单
   
   select * from t_bf_gold_transfer_out_detail where  transfer_out_identity='18248c06-0ad0-03dc-b19f-e21ef9d10335' -- 调出打印单明细


   足金5G主要是精度的差异



问题49：硬金工费的问题  5元 流水账,多出来 也属于精度的问题




SELECT   purity_name ,SUM(total_price)
FROM T_BF_GOLD_TRANSFER_OUT_PRINT -- 调出打印单
 WHERE TRANSFER_IN_SHOWROOM = '深圳工厂'
   AND DATE(DELIVER_GOODS_TIME) = '2022-07-26'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'  GROUP BY purity_name ;
   
   SELECT   *
FROM t_bf_gold_transfer_out_print_detail where transfer_out_code='SJDCD07290149';

select * from T_BF_GOLD_TRANSFER_OUT_PRINT where gold_transfer_out_print_identity='18248f12-0ff0-048e-b97c-0c2f6ef38782';
   
   select djh,sum(IFNULL(FJGFJE,0)+IFNULL(JCGFJE,0)) from t_ka_splsz where DATE(rq)='2022-07-26' and swlx<>'熔料'     and  djm = '调拨出库单' and rhf like '深圳工厂%' and sffx='发'   and (  jsmc='千足硬金' )  AND CKMC<>'镶嵌Q柜' AND CKMC <>'镶嵌柜-德钰东方' AND CKMC <>'德钰东方K金柜'  and ckmc<>'镶嵌硬金柜' and CKMC<>'客单组镶嵌德钰东方' and CKMC<>'客单组镶嵌柜' and ckmc<>'古法金柜' and ckmc<>'古法硬金柜'   group by djh  order by djh ;
   
   select * from t_bf_gold_transfer_out where transfer_out_code='SJDCD07290149';
   
   select * from t_bf_gold_transfer_out_detail where  transfer_out_identity='18248c06-0ad0-03dc-b19f-e21ef9d10335';
   
   SELECT   a.transfer_out_code,  sum(a.price),b.total_price
FROM t_bf_gold_transfer_out_print_detail a left join t_bf_gold_transfer_out_print b on a.transfer_out_print_identity=b.gold_transfer_out_print_identity where transfer_out_code in('SJDCD07250093',
'SJDCD07250112',
'SJDCD07250113',
'SJDCD07250118',
'SJDCD07250121',
'SJDCD07250136',
'SJDCD07250137',
'SJDCD07260004',
'SJDCD07260015',
'SJDCD07260016',
'SJDCD07260017',
'SJDCD07260021',
'SJDCD07260057',
'SJDCD07260066',
'SJDCD07260075',
'SJDCD07260079',
'SJDCD07260080',
'SJDCD07260085',
'SJDCD07260129')GROUP BY a.transfer_out_code order by a.transfer_out_code;






问题46：

      select * from t_ka_splsz where DATE(rq)='2022-07-14' and djm='调拨出库单' and rhf like '北京金德尚运营中心%' and sffx='发' and djh='SJDCD07140028'

   select * from t_bf_gold_transfer_out where transfer_out_code='SJDCD07140028';
   
      select * from t_bf_gold_transfer_out_detail where transfer_out_identity='181fa89e-cbe0-00b4-9627-4b71c9279320';

      流水记错了，jcgfje和fjgfje出现了一正一负,刚好抵消了



问题51梦醒处理需要，手动刷数据,业务的意思是三位小数的问题
select 
* 
from t_ka_splsz
where  wdmc='深圳展厅' and DATE(rq)='2022-07-28'  and (jsmc='古法万足金' or jsmc='万足古法') and djm='调拨出库单' and rhf like '特艺城展厅%'   and sffx='发'  ;

select * from t_bf_gold_transfer_out where transfer_out_code='SJDCD07280008'; fjgfje是不应该有值的，手动刷数据导致的。





问题43：
      select 
sum(IFNULL(JCGFJE,0)+IFNULL(FJGFJE,0))
from t_ka_splsz
where  wdmc='深圳展厅' and DATE(rq)='2022-07-25'  and (  jsmc='千足硬金' )  AND CKMC<>'镶嵌Q柜' AND CKMC <>'镶嵌柜-德钰东方' AND CKMC <>'德钰东方K金柜'  and ckmc<>'镶嵌硬金柜' and CKMC<>'客单组镶嵌德钰东方' and CKMC<>'客单组镶嵌柜' and ckmc<>'古法金柜' and ckmc<>'古法硬金柜' AND swlx='客户退饰'  ;

 select SUM(a.work_fee_amount_sum) from t_bf_cust_return_jewelry a left join t_purity b on a.purity_identity=b.purity_identity where DATE(rq)='2022-07-25' and purity_name='千足硬金' ;


退饰单少记一笔,退饰单明细 193520 - 146661 46859

select * from t_bf_cust_return_jewelry where return_code='KHTSD202207250119'
;

select * from t_bf_cust_return_jewelry_detail where return_identity=
'1823483d-7d00-0fac-8260-b79179e0f2e6'; 




问题41 少记东西 调出打印单有问题，明细的工费没有计算到表头里面去 调出打印单明细 18235799-89e0-10da-b9c9-2629dceb2f22 没有记录

select * from t_bf_gold_transfer_out_print_detail where transfer_out_print_identity='18235799-89e0-10da-b9c9-2629dceb2f22';

select * from t_bf_gold_transfer_out_print where gold_transfer_out_print_identity='18235799-89e0-10da-b9c9-2629dceb2f22';



  问题40 明细里面有负值，但是调出打印单里面没有负值
          SELECT  gold_transfer_out_print_identity, SUM(TOTAL_PRICE) AS GF 
FROM T_BF_GOLD_TRANSFER_OUT_PRINT -- 调出打印单
 WHERE TRANSFER_IN_SHOWROOM = '深圳工厂'
   AND DATE(DELIVER_GOODS_TIME) = '2022-07-24'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'  GROUP BY gold_transfer_out_print_identity;
   
        -- 第一笔有问题
       select  transfer_out_print_identity,sum(price) from t_bf_gold_transfer_out_print_detail  where transfer_out_print_identity in ('1822df4f-4b00-076b-b962-8287f9fa33fd',
    '1822e3c5-5af0-07b7-b696-f32129a2d43b',
    '1822e630-c000-086b-b1b0-19089510299c',
    '1822e644-4ee0-086e-b5c1-27b46423bb88',
    '1822e655-f550-0872-8ed6-9944e6233b2d',
    '1822eda5-2690-08a0-9485-2ac659e96924',
    '1822eed2-df50-08c4-b2b4-d4af729494c9',
    '1822eedd-2880-0964-9f82-4f73eef1165f',
    '1822ef12-1480-08cc-99f6-66d07a75e0de')GROUP BY transfer_out_print_identity



        主表有问题，明细表是有负值的

          select * from t_bf_gold_transfer_out_print where gold_transfer_out_print_identity='1822df4f-4b00-076b-b962-8287f9fa33fd';
       select  transfer_out_print_identity,sum(price) from t_bf_gold_transfer_out_print_detail  where transfer_out_print_identity in ('1822df4f-4b00-076b-b962-8287f9fa33fd')GROUP BY transfer_out_print_identity 




  问题39：

      SELECT  gold_transfer_out_print_identity, SUM(TOTAL_PRICE) AS GF 
FROM T_BF_GOLD_TRANSFER_OUT_PRINT -- 调出打印单
 WHERE TRANSFER_IN_SHOWROOM = '深圳工厂'
   AND DATE(DELIVER_GOODS_TIME) = '2022-07-23'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'  GROUP BY gold_transfer_out_print_identity;
   
 
   select  transfer_out_print_identity,sum(price) from t_bf_gold_transfer_out_print_detail  where transfer_out_print_identity in ('18228c0f-30d0-018c-85c1-69f23c0f3a86',
'18228e07-4040-021d-981d-e1e6404abc48',
'1822904f-19d0-0285-8db7-4bed98c5fac3',
'18229053-af90-020c-a3a7-e8c96cc6548a',
'1822905b-4ad0-0287-9c59-b4f8046ef23f',
'1822907b-bc70-0247-9bbc-4b0ecad216d6',
'1822964c-83b0-0379-9efe-c130af413cf9',
'182296ed-7640-033d-8af2-6a57cbb51523',
'182297a1-f880-031f-b436-804a63900256',
'182299af-8020-03ae-b223-b6c6ba7a9704',
'18229f64-5080-04ef-91ee-d54d29209b5f',
'18229f6d-21b0-04f2-af36-cb829e5fd0c0',
'1822a4f0-4310-0577-b49f-01894c5b2279',
'1822a4f9-2b20-0638-a6c0-710ee781fbd5',
'1822aa1c-d030-06a2-9c5e-1f3fac1e977f',
'1822aa3c-dbc0-06a9-b566-2c045dbc94d0',
'1822aa40-12b0-071e-bdbb-f1b283c5f2bb',
'1822aa50-d450-068b-83ff-de7b726337c4',
'1822aa53-1900-068e-bf4d-625d429d5f0e',
'1822aa56-ce80-0690-8adc-3ef8f89a3f9d',
'1822ab96-1d50-076d-aa46-320e1e36e82e',
'1822b3dd-5e90-0710-9c93-6fa02955865f')GROUP BY transfer_out_print_identity; -- 最后一笔有问题，明细记录，打印单没有记录 


      主表有问题，明细表是有负值的
          select * from t_bf_gold_transfer_out_print where gold_transfer_out_print_identity='1822b3dd-5e90-0710-9c93-6fa02955865f';
       select  transfer_out_print_identity,sum(price) from t_bf_gold_transfer_out_print_detail  where transfer_out_print_identity in ('1822b3dd-5e90-0710-9c93-6fa02955865f')GROUP BY transfer_out_print_identity




问题38 明细和调出打印单基本相等



SELECT  gold_transfer_out_print_identity, SUM(TOTAL_PRICE) AS GF 
FROM T_BF_GOLD_TRANSFER_OUT_PRINT -- 调出打印单
 WHERE TRANSFER_IN_SHOWROOM = '深圳工厂'
   AND DATE(DELIVER_GOODS_TIME) = '2022-07-22'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'  GROUP BY gold_transfer_out_print_identity;
   

   select  transfer_out_print_identity,sum(price) from t_bf_gold_transfer_out_print_detail  where transfer_out_print_identity in (
 '18223d55-a530-0ce7-a650-759b67d8e80a',
'18223d89-0cd0-0cda-9266-9c927e655f60',
'18223dcf-2f60-0cff-8b82-1937f0ca9065',
'18223dde-41b0-0cea-9652-376fdcafdd2e',
'18223de3-68c0-0ceb-bd3e-02a693dc96bb',
'18224729-4360-0ed9-8e36-fcebe11f75eb',
'18224794-b420-0eee-94a7-131187f01b62',
'182247a7-ec20-0ea5-879d-59f9ca87062b',
'182247be-f0b0-0ef7-aeaa-10036f33ba22',
'182247ec-d010-0ecd-8c33-ff053527da09',
'18224adb-ba40-0fbc-ad54-6ca6be17ed98',
'18224ae1-cfd0-0fbd-8f8d-a064fcfd4cc2',
'18224c42-1000-0fe3-874a-404584f6210e',
'18224c74-c260-0fed-9640-f2ce9c38eddb',
'18224c85-97a0-0fe7-8c0f-b0a211556c5c',
'182254f6-b310-11e9-b587-cdd8bead287f',
'182255f3-0760-1230-b0f1-ddc7aad63d42',
'1822560d-b480-1236-a3e7-28638dd84dff',
'1822564a-75e0-1241-af5c-648c4085ab19',
'182259fc-b030-0033-b2d7-f7ce683ad828')GROUP BY transfer_out_print_identity



问题38：

       select  * from t_bf_gold_transfer_out_print_detail  where transfer_out_code in ('SJDCD07200011',
'SJDCD07200012',
'SJDCD07200109',
'SJDCD07210024',
'SJDCD07210057',
'SJDCD07210064',
'SJDCD07210071',
'SJDCD07210072',
'SJDCD07210077',
'SJDCD07220001',
'SJDCD07220003',
'SJDCD07220004',
'SJDCD07220005',
'SJDCD07220006',
'SJDCD07220008',
'SJDCD07220017',
'SJDCD07220018',
'SJDCD07220026',
'SJDCD07220034',
'SJDCD07220036',
'SJDCD07220040',
'SJDCD07220044',
'SJDCD07220046',
'SJDCD07220054',
'SJDCD07220055',
'SJDCD07220056',
'SJDCD07220057',
'SJDCD07220076',
'SJDCD07220077',
'SJDCD07220084',
'SJDCD07220085',
'SJDCD07220086',
'SJDCD07220087',
'SJDCD07220088',
'SJDCD07220089',
'SJDCD07220090')GROUP BY transfer_out_code order by transfer_out_code;

   select  gold_transfer_out_print_code,sum(total_price) from t_bf_gold_transfer_out_print  where gold_transfer_out_print_identity in (
 '18223d55-a530-0ce7-a650-759b67d8e80a',
'18223d55-a530-0ce7-a650-759b67d8e80a',
'18223de3-68c0-0ceb-bd3e-02a693dc96bb',
'18223d55-a530-0ce7-a650-759b67d8e80a',
'18224729-4360-0ed9-8e36-fcebe11f75eb',
'18224c74-c260-0fed-9640-f2ce9c38eddb',
'18223dcf-2f60-0cff-8b82-1937f0ca9065',
'18223dcf-2f60-0cff-8b82-1937f0ca9065',
'18223de3-68c0-0ceb-bd3e-02a693dc96bb',
'18224c74-c260-0fed-9640-f2ce9c38eddb',
'18224c85-97a0-0fe7-8c0f-b0a211556c5c',
'18224c74-c260-0fed-9640-f2ce9c38eddb',
'18223d89-0cd0-0cda-9266-9c927e655f60',
'18223d55-a530-0ce7-a650-759b67d8e80a',
'18223d55-a530-0ce7-a650-759b67d8e80a',
'18223db1-2590-0ce4-9108-37553f60b640',
'18223dde-41b0-0cea-9652-376fdcafdd2e',
'18224c42-1000-0fe3-874a-404584f6210e',
'18224adb-ba40-0fbc-ad54-6ca6be17ed98',
'18224adb-ba40-0fbc-ad54-6ca6be17ed98',
'18224ae1-cfd0-0fbd-8f8d-a064fcfd4cc2',
'18224ae1-cfd0-0fbd-8f8d-a064fcfd4cc2',
'18224ae1-cfd0-0fbd-8f8d-a064fcfd4cc2',
'18224794-b420-0eee-94a7-131187f01b62',
'182247a7-ec20-0ea5-879d-59f9ca87062b',
'182247be-f0b0-0ef7-aeaa-10036f33ba22',
'182247ec-d010-0ecd-8c33-ff053527da09',
'182254f6-b310-11e9-b587-cdd8bead287f',
'182259fc-b030-0033-b2d7-f7ce683ad828',
'182255f3-0760-1230-b0f1-ddc7aad63d42',
'1822560d-b480-1236-a3e7-28638dd84dff',
'1822564a-75e0-1241-af5c-648c4085ab19',
'182256dc-8790-0005-8872-52709ff5c1d2',
'182259e5-5340-0031-87dc-adb31c6f5c41',
'18225a61-5cf0-0096-9483-9e85623fbf19',
'18225b2f-1fa0-001e-b502-4aa884626089')GROUP BY gold_transfer_out_print_identity ORDER BY gold_transfer_out_print_code;



问题35：

千足金

select * from t_ka_splsz where DATE(rq)='2022-07-24' and swlx='委外入库' and jsmc='千足金';  -- 需要取整的操作


古法金属于精度问题

select * from t_ka_splsz where DATE(rq)='2022-07-24' and swlx='委外入库' and jsmc='古法金';
select * from t_receive where receive_code='QXRK2022072401313';
select * from t_receive_detial where receive_identity='1822EEA8-72C0-02A3-BCA1-35CE962F6914'; -- 合起来3583.34 取整 3583 ,
单个取整 合起来就是3584
454.00
3127.50
271.84


千足硬金的问题 --流水账没有取整的操作

select * from t_ka_splsz where DATE(rq)='2022-07-24' and swlx='委外入库' and jsmc='千足硬金';

select * from t_receive where receive_code='WWRK2022072401249';


select total_work_fee  from t_receive_detial where receive_identity='1824D815-5D80-0A2A-BC18-327642450282' order by total_work_fee asc  ;
select JCGFJE from t_ka_splsz where djh='WWRK2022073000974' order by JCGFJE;




付玉的问题，需要调整
select * from t_bf_cust_return_jewelry where return_code='KHTSD202207250119'
;

select * from t_bf_cust_return_jewelry_detail where return_identity=
'1823483d-7d00-0fac-8260-b79179e0f2e6'; 

select * from t_ka_lllsz where djh='KHTSD202207250119'; 


-----------------------------------------------------------------------------------------------------------------














      select 
sum(IFNULL(JCGFJE,0)+IFNULL(FJGFJE,0))
from t_ka_splsz
where  wdmc='深圳展厅' and DATE(rq)='2022-07-25'  and (  jsmc='千足硬金' )  AND CKMC<>'镶嵌Q柜' AND CKMC <>'镶嵌柜-德钰东方' AND CKMC <>'德钰东方K金柜'  and ckmc<>'镶嵌硬金柜' and CKMC<>'客单组镶嵌德钰东方' and CKMC<>'客单组镶嵌柜' and ckmc<>'古法金柜' and ckmc<>'古法硬金柜' AND swlx='客户退饰'  ;

 select SUM(a.work_fee_amount_sum) from t_bf_cust_return_jewelry a left join t_purity b on a.purity_identity=b.purity_identity where DATE(rq)='2022-07-25' and purity_name='千足硬金' ;
 
 
 
 
  select * from t_bf_cust_return_jewelry a left join t_purity b on a.purity_identity=b.purity_identity where DATE(rq)='2022-07-25' and purity_name='千足硬金' ;
  
  select a.return_work_fee_sub_total,b.return_code,b.work_fee_amount_sum from t_bf_cust_return_jewelry_detail a INNER join t_bf_cust_return_jewelry b on a.return_identity=b.return_identity where a.return_identity in ('182333c6-3680-0b93-8caf-cd8b851cfd80',
'18233595-7870-0b43-9f1a-1254a34006d8',
'182335f1-0ee0-0b57-98e1-5310df529926',
'18233625-f900-0b89-92a9-d0f7ea399a26',
'18233726-b850-0c47-a735-0d0308a5f821',
'18233751-55f0-0c4c-8bc1-b06ae35cec58',
'1823375b-0010-0bbc-a927-e85188cc8e33',
'18233766-ac00-0c50-a8dc-51d0e09407d8',
'18233774-9740-0bc2-aa84-e59071e58cf6',
'182338a9-4840-0c13-bb13-f2d7cefe6c09',
'182338d2-c250-0c1d-82ba-4dbd65b7fe42',
'18233aa7-9b20-0d12-9b7b-c17cd4371db8',
'18233b53-7ac0-0c64-af9c-9327f337d0f2',
'18234230-86f0-0df0-817d-87f4d042e8c5',
'18234309-6210-0edc-b110-4e9dfb5ea42d',
'18234400-76c0-0e6d-9d75-8e53326f7d2a',
'1823442e-6190-0e7c-9068-6775d74de00c',
'1823482b-6790-1010-a7dc-abaf1aa753cc',
'1823483d-7d00-0fac-8260-b79179e0f2e6',
'18234b8c-18b0-10a9-9817-2f7ac2611aee',
'18234e3c-8670-10a1-869f-de8481a9497d',
'1823520b-c320-1181-be6e-ee7fa56d3c55',
'1823529f-70e0-1108-a252-6fb330adf550',
'18235684-1a30-1122-aa95-48dacad9df6d');


select * from t_bf_cust_return_jewelry where return_code='KHTSD202207250119'
;

select * from t_bf_cust_return_jewelry_detail where return_identity=
'1823483d-7d00-0fac-8260-b79179e0f2e6';



















-----------------------------------------------------------------------------------------------------------------
账龄报表逻辑分析处理

gn_zljs_szzt 取账龄信息和其他数据展示
gn_cwkq_zl_02 这个是计算账龄的存储过程






























-----------------------------------------------------------------------------------------------------------------
存储过程异常信息

CREATE DEFINER=`app_test`@`%` PROCEDURE `cx_zt_sz_tj_khxshzcx_hqz_1`(in 
v_showroom_identity varchar(36), -- 展厅
v_purity_identity VARCHAR(36), -- 成色
v_ksrq date, -- 开始日期
v_jzrq date, -- 截至日期
v_khlx VARCHAR(36), -- 客户类型
v_new_customer_date date, -- 新客户时间
v_czid VARCHAR (36) -- 操作人id 
)
A:begin
####################################################
-- 报表  客户销售汇总查询-业务
####################################################


DECLARE v_wdmc VARCHAR (36);
DECLARE v_csmc VARCHAR (36);

DECLARE v_qsny int; -- 起始年月
DECLARE v_jzny int; -- 截至年月

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

set v_qsny =(select YEAR(v_ksrq)*100+MONTH(v_ksrq));
set v_jzny =(select YEAR(v_jzrq)*100+MONTH(v_jzrq));

if v_csmc='' then 
set v_csmc='千足金,金9999,金99999,足金,千足硬金,足金(无氰),足金(5G),古法金,古法万足金,古法999.99';
end if;

IF EXISTS(SELECT 1 WHERE v_qsny<> v_jzny) THEN 
  SELECT '只能查询本月的数据!!!' AS MSG_INFO;
  LEAVE A;
END IF;


set v_wdmc= (select showroom_name from t_showroom where showroom_identity=v_showroom_identity);

set v_csmc= (select purity_name from t_purity where purity_identity=v_purity_identity);



end;











江西金德尚运营中心  浙江德鑫  梦享会  成都展厅 福建中金  江西鑫囍缘
  


















-----------------------------------------------------------------------------------------------------------------

select * from t_ka_splsz where djh='WWRK2022080100688';
select * from t_receive where receive_code='WWRK2022080100688';



select * from t_ka_splsz where djh='WWRK2022080100655'; -- 金重为42.67的这个明细的数据的金额不对 流水里面金额为 354
select * from t_receive where receive_code='WWRK2022080100655';
select * from t_receive_detial where receive_identity='18258329-C6A0-0D91-AF72-AE88DA85D279'; -- 金重为42.67的这个明细的数据的金额不对 明细里面金额为310元 


select * from t_ka_splsz where djh='WWRK2022080100626' and js=3 and jz=108; -- 金额 302
select * from t_receive where receive_code='WWRK2022080100626';
select * from t_receive_detial where receive_identity='18257EB6-83E0-0ACA-B988-65D111F418E5' and id= 92562; -- 金额221.5



select * from t_ka_splsz where djh='WWRK2022080100599'  and id =541567; -- 金额   2482.000 
select * from t_receive where receive_code='WWRK2022080100599';
select * from t_receive_detial where receive_identity='18257B20-1FA0-07C2-B034-D4EDC0D71898'  and id =92539; -- 2444.96



select * from t_ka_splsz where djh='WWRK2022080100552';
select * from t_receive where receive_code='WWRK2022080100552';
select * from t_receive_detial where receive_identity='1825759E-F4C0-0430-AB74-3D9667293338';


select * from t_ka_splsz where djh='WWRK2022080100356'  and id=536027; -- 金额 446.000
select * from t_receive where receive_code='WWRK2022080100356';
select * from t_receive_detial where receive_identity='1825710A-8A90-0138-AC6F-4EF1FFAACB08' and id=92495; -- 435.93




case when 涉及范围取值的时候 
sum if  这样取值
 
























-----------------------------------------------------------------------------------------------------------------

select sum(jz) from (select sum(total_gold_weight) as jz from t_receive where supplier_type=0  and examine_time='2022-07-20' and supplier_source like '福州%' 
and `status`=0  
union all 
select sum(total_weight)  as jz from t_bf_gold_transfer_in where DATE(approve_time)='2022-07-20' and transfer_out_showroom like '福州%')t;
select sum(jz) from (
select sum(total_gold_weight) as jz from t_receive where supplier_type=0  and examine_time='2022-07-20' and supplier_source='深圳工厂' and `status`=0 
union all 
select sum(total_weight)  as jz from t_bf_gold_transfer_in where DATE(approve_time)='2022-07-20' and transfer_out_showroom='深圳工厂'
)t;











8月15号曾维琴发的问题表

问题3 ，万足古法

select * from t_ka_splsz where djh='WWRK2022080200733'; -- 流水里面多了，质检的东西
select * from t_receive where receive_code='WWRK2022080200733';
select * from t_receive_detial where receive_identity='1825CC65-6D50-047F-8A80-5473651F1030';


千足硬金多的

-- 第一笔
select * from t_ka_splsz where djh='WWRK2022080200028'; -- 流水里面多了，质检的东西
select * from t_receive where receive_code='WWRK2022080200028';
select * from t_receive_detial where receive_identity='1825C016-6F20-000A-9E64-DC1B6ACFF44B'; 

-- 第二笔
select * from t_ka_splsz where djh='WWRK2022080200722';
select * from t_receive where receive_code='WWRK2022080200722';
select * from t_receive_detial where receive_identity='1825CBD3-BF00-0460-9849-EEB921BD0BC2';

-- 第三笔
select * from t_ka_splsz where djh='WWRK2022080200736';
select * from t_receive where receive_code='WWRK2022080200736';
select * from t_receive_detial where receive_identity='1825CC8B-9420-0525-B4F1-C20D21AA07CA';


-- 第四笔
select * from t_ka_splsz where djh='WWRK2022080200745';
select * from t_receive where receive_code='WWRK2022080200745';
select * from t_receive_detial where receive_identity='1825CDB2-69E0-04FA-81F1-95CF1D8AA702';


-- 第五笔


select * from t_ka_splsz where djh='WWRK2022080200757';
select * from t_receive where receive_code='WWRK2022080200757';
select * from t_receive_detial where receive_identity='1825CF68-1630-0042-B994-6871E5A5CAF7';


问题 5 


-- 万足古法 多
select * from t_ka_splsz where djh='WWRK2022080301173';
select * from t_receive where receive_code in ('WWRK2022080301173');
select * from t_receive_detial where receive_identity in ('18262C67-82D0-0732-B58F-0882657AF66F')and is_check=1;


-- 万足金 多

select * from t_ka_splsz where djh='WWRK2022080301055';
select * from t_receive where receive_code in (
'WWRK2022080301055'
);
select * from t_receive_detial where receive_identity in ( 
'18261DC8-59C0-0085-9549-8EE11DC77D40'
)
 and is_check=1; 



-- 千足金少的值 
select * from t_ka_splsz where djh  in ('WWRK2022080301179'
);
select * from t_receive where receive_code in ('WWRK2022080301179'

);
select * from t_receive_detial where receive_identity in ('18262CAC-A330-0806-89A3-8EAAFDA0445C'
)
;




-- 千足硬金多的 值



select * from t_ka_splsz where djh  in ('WWRK2022080301015',
'WWRK2022080301039',
'WWRK2022080301058',
'WWRK2022080301060',
'WWRK2022080301079',
'WWRK2022080301110',
'WWRK2022080301148'
);
select * from t_receive where receive_code in ('WWRK2022080301015',
'WWRK2022080301039',
'WWRK2022080301058',
'WWRK2022080301060',
'WWRK2022080301079',
'WWRK2022080301110',
'WWRK2022080301148'

);
select * from t_receive_detial where receive_identity in ('182618E4-45B0-02E0-B072-414D43F604D1',
'18261BA3-DB70-003C-83AF-CAA3D5C44FF9',
'18261E35-F030-00A4-9B2B-CA02499509F7',
'18261E4A-A6B0-015A-8BD4-9988814D73A2',
'18262231-0D70-02EF-8EC0-9473ED5AEC9B',
'182624F3-EBD0-035D-A478-5640D1DA6B29',
'182628FF-D070-05D9-9366-4A10B4A64E4D'
)
 and is_check=1;


-----------------------------------------------------------------------------------------------------------------

问题 7  都属于质检的问题

 -- 古法万足金
select * from t_ka_splsz where djh='WWRK2022080401345';
select * from t_receive where receive_code in ('WWRK2022080401345');
select * from t_receive_detial where receive_identity in ('18267771-2670-03B0-A6BC-E86777DCBAB6') and is_check=1;




万足金工费

select * from t_ka_splsz where djh='WWRK2022080401321';
select * from t_receive where receive_code in ('WWRK2022080401321');
select * from t_receive_detial where receive_identity in ('182675D9-CC90-03D6-A645-DF2E7783EA1E') and is_check=1;


千足硬金

select * from t_ka_splsz where djh='WWRK2022080401208';
select * from t_receive where receive_code in ('WWRK2022080401208');
select * from t_receive_detial where receive_identity in ('18266D83-E580-012A-B196-F446A1F5025B') and is_check=1;



select * from t_ka_splsz where djh='WWRK2022080401256';
select * from t_receive where receive_code in ('WWRK2022080401256');
select * from t_receive_detial where receive_identity in ('182670BD-E9C0-0269-A411-4D491B3FFF55') and is_check=1;



select * from t_ka_splsz where djh='WWRK2022080401289';
select * from t_receive where receive_code in ('WWRK2022080401289');
select * from t_receive_detial where receive_identity in ('18267483-8EB0-0305-8E12-990B9CE2ADAE') and is_check=1;























-----------------------------------------------------------------------------------------------------------------







1、新系统镶嵌Q柜账面库存少200.51克、85件、19364元（标签价），原因如下：
 7月26日将福州工厂出的货品208.79克、88件、19364元（标签价）入在了老系统（EOS系统），已与展厅及物流部确认，附上老系统入库凭据(附件中克重为209.72克，其中0.93为维修仓数据，209.72克-0.93克=208.79克）；
 另外7月23日8.28克、3件、0元维修仓入库数据在老系统入库后，在新系统又操作了一遍，且库存计算在了镶嵌Q柜（有信息部确认的附图）；
因此新系统镶嵌Q柜账面少208.79克-8.28克=200.51克、88件-3件=85件、19364元-0元=19364元
与信息部胡巍总沟通后由信息部将此笔数据调整加在镶嵌Q柜库存中（调整时直接修改7月31日镶嵌Q柜账面）；

2、因维修仓、德钰东方的进销存都在老系统操作，因此新系统这两个仓位的库存请信息部清零；

3、新系统报表<深圳展厅库存日报表-财务>有足金嵌库存，请信息部将此合并在千足嵌库存中，再将千足嵌的库存按第4点操作区分；

4、新系统报表<深圳展厅库存日报表-财务>千足嵌重量包含了德钰东方库存，请信息部将两个产品区分，具体参照<展厅库存收发>，将千足嵌分为镶嵌Q柜和德钰东方呈现库存；

5、德钰东方7月3日销售2.81克、2件、1068元（标签价），7月4日销售73.62克、40件、43600元（标签价），7月6日销售9.93克、7件、8683元(标签价）是在新系统进行开单销售的（经了解是因为新系统未做限制，导致可以开具德钰东方的销售单据），因此老系统德钰东方的库存未计算到，库存不正确。经沟通，由结算用盘盈亏方式进行库存调整，备注详细原因。 







          SELECT 6 AS XH, '千足嵌小计' AS KCLX, '' AS CKBM, '' AS CKMC, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(QC) AS QC, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(A1) AS A1, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(A2) AS A2,
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(A3) AS A3, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(A4) AS A4, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(A5) AS A5, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(A6) AS A6,
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(A7) AS A7, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(RKHJ) AS RKHJ, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(B1) AS B1, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(B2) AS B2, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(B3) AS B3, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(B4) AS B4, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(B5) AS B5, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(B6) AS B6, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(CKHJ) AS CKHJ, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(YK) AS YK, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(YC) AS YC, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(SC) AS SC, 
          CASE WHEN CKMC IN ('维修仓') THEN 0 ELSE QC END SUM(CD) AS CD
          FROM TEMP_TEMP5 WHERE CKMC NOT LIKE '料仓%' AND KCLX = '千足嵌饰品';

















-----------------------------------------------------------------------------------------------------------------



-- 展厅库存
update t_ka_ztkczz set qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  yue=8  and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';

 
update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364 
where  rq='2022-07-31' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';


update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-01' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';
 
 
 update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-02' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';

update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-03' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';



update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-04' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';



update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-05' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';



update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-06' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';



update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-07' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';


update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-08' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';


update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-09' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';



update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-10' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';


update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-11' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';

update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-12' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';

update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-13' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';



update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-14' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';


update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-15' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';


update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-16' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';



update T_KA_ZTKCRZZ set qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-17' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';

























-----------------------------------------------------------------------------------------------------------------


select * from T_KA_ZTKCRZZ where rq='2022-08-31' and ckmc like '镶嵌Q柜%' and plmc='饰品';
select * from t_ka_ztkczz where nian='2022' and yue='08' and plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅';

select * from t_ka_ztkczz where  yue=8 and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';

select * from  T_KA_ZTKCRZZ where     rq='2022-07-31' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';




-- 展厅库存
update t_ka_ztkczz set qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  yue=8  and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';

-- 
update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364 
where  rq='2022-07-31' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';


update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-01' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';
 
 
 update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-02' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';

update T_KA_ZTKCRZZ set qmjs=qmjs+85,qmjz=qmjz+200.51,qmje=qmje+19364, qcjs=qcjs+85,qcjz=qcjz+200.51,qcje=qcje+19364
where  rq='2022-08-03' and  plmc='饰品' and ckmc='镶嵌Q柜' and wdmc='深圳展厅' and jsmc='千足金';


-----------------------------------------------------------------------------------------------------------------
insert INTO t_showroom (showroom_identity,showroom_code,showroom_name,`status`,final_time,create_user_id,create_date,modify_user_id,modify_date,longitude,dimension,showroom_type,is_delete)
VALUES(UUID(),186,'海南展厅',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'展厅',0);















INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',001,'结算中心',186,'海南展厅',001,'结算中心',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);

INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',002,'料仓',186,'海南展厅',002,'料仓',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);

INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',003,'退饰仓',186,'海南展厅',003,'退饰仓',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);

INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',004,'配货中心',186,'海南展厅',004,'配货中心',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);

INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',004,'配货中心',186,'海南展厅',004,'配货中心',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);



INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',005,'硬金无氰柜',186,'海南展厅',005,'硬金无氰柜',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);

INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',006,'5G999柜',186,'海南展厅',006,'5G999柜',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);


INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',007,'硬金柜',186,'海南展厅',007,'硬金柜',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);


INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',008,'普货柜',186,'海南展厅',008,'普货柜',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);

INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',009,'镶嵌Q柜',186,'海南展厅',009,'镶嵌Q柜',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);


INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',010,'金条柜',186,'海南展厅',010,'金条柜',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);

INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',011,'镶嵌柜（德钰东方）',186,'海南展厅',011,'镶嵌柜（德钰东方）',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);

INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',012,'足金999.99柜',186,'海南展厅',012,'足金999.99柜',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);


INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',013,'足金9999柜',186,'海南展厅',013,'足金9999柜',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);



INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',014,'古法金万足柜',186,'海南展厅',014,'古法金万足柜',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);

INSERT INTO t_showroom_counter (counter_identity,showroom_id,showroom_identity,counter_code,counter_name,showroom_code,showroom_name,stock_code,stock_name,modify_user_code,modify_user_name,modify_date,last_user_name,last_date,purity_id,purity_identity,is_delete,genus_id,genus_identity,code_seq,create_time,eos_zdrid,eos_zdr,type,sort,physical_identity,physical_name,is_single_piece,is_metal_working,is_default,variety,max_additional_labour,max_technology_unit_price,technology_purity_identity)
VALUES(UUID(),NULL,'c8aafe71-228d-11ed-945e-aecc6b4ae066',015,'古法金柜',186,'海南展厅',015,'古法金柜',NULL,NULL,NULL,NULL,NULL,1,UUID(),0,9,UUID(),NULL,NOW(),NULL,NULL,0,0,NULL,NULL,0,0,0,'hs',NULL,NULL,NULL);















-----------------------------------------------------------------------------------------------------------------


insert INTO t_showroom (showroom_identity,showroom_code,showroom_name,`status`,final_time,create_user_id,create_date,modify_user_id,modify_date,longitude,dimension,showroom_type,is_delete)
VALUES(UUID(),186,'海南展厅',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'展厅',0);


INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('2b6c5257-2291-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '001', '结算中心', '186', '海南展厅', '001', '结算中心', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:10:41', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('4a87c95c-2291-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '002', '料仓', '186', '海南展厅', '002', '料仓', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:11:33', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('5acd193e-2291-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '003', '退饰仓', '186', '海南展厅', '003', '退饰仓', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:12:00', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('8549e48f-2291-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '004', '配货中心', '186', '海南展厅', '004', '配货中心', NULL, NULL, NULL, NULL, NULL, NULL, '', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:13:12', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('b8022ab7-2291-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '005', '硬金无氰柜', '186', '海南展厅', '005', '硬金无氰柜', NULL, NULL, NULL, NULL, NULL, 17, 'e52c8663-1bfe-11eb-952f-beb5915aa4c3', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:14:37', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('143afe13-2292-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '006', '5G999柜', '186', '海南展厅', '006', '5G999柜', NULL, NULL, NULL, NULL, NULL, 16, 'e52b61ae-1bfe-11eb-952f-beb5915aa4c3', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:17:11', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('24984ccd-2292-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '007', '硬金柜', '186', '海南展厅', '007', '硬金柜', NULL, NULL, NULL, NULL, NULL, 12, 'e5277a1c-1bfe-11eb-952f-beb5915aa4c3', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:17:39', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('33cf24aa-2292-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '008', '普货柜', '186', '海南展厅', '008', '普货柜', NULL, NULL, NULL, NULL, NULL, 10, 'e5252124-1bfe-11eb-952f-beb5915aa4c3', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:18:04', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('4e4d578f-2292-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '009', '镶嵌Q柜', '186', '海南展厅', '009', '镶嵌Q柜', NULL, NULL, NULL, NULL, NULL, 10, 'e5252124-1bfe-11eb-952f-beb5915aa4c3', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:18:49', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('69d9696d-2292-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '010', '金条柜', '186', '海南展厅', '010', '金条柜', NULL, NULL, NULL, NULL, NULL, 10, 'e5252124-1bfe-11eb-952f-beb5915aa4c3', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:19:35', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('7fc3f4e2-2292-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '011', '镶嵌柜（德钰东方）', '186', '海南展厅', '011', '镶嵌柜（德钰东方）', NULL, NULL, NULL, NULL, NULL, 10, 'e5252124-1bfe-11eb-952f-beb5915aa4c3', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:20:12', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('9c1dec28-2292-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '012', '足金999.99柜', '186', '海南展厅', '012', '足金999.99柜', NULL, NULL, NULL, NULL, NULL, 14, 'e5297832-1bfe-11eb-952f-beb5915aa4c3', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:20:59', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('af0c9e6d-2292-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '013', '足金9999柜', '186', '海南展厅', '013', '足金9999柜', NULL, NULL, NULL, NULL, NULL, 11, 'e526402e-1bfe-11eb-952f-beb5915aa4c3', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:21:31', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('d50023f7-2292-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '014', '古法金万足柜', '186', '海南展厅', '014', '古法金万足柜', NULL, NULL, NULL, NULL, NULL, 22, '3e2a11ad-e1ec-11eb-a586-beb5915aa4c3', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:22:35', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);
INSERT INTO `` (`counter_identity`, `showroom_id`, `showroom_identity`, `counter_code`, `counter_name`, `showroom_code`, `showroom_name`, `stock_code`, `stock_name`, `modify_user_code`, `modify_user_name`, `modify_date`, `last_user_name`, `last_date`, `purity_id`, `purity_identity`, `is_delete`, `genus_id`, `genus_identity`, `code_seq`, `create_time`, `eos_zdrid`, `eos_zdr`, `type`, `sort`, `physical_identity`, `physical_name`, `is_single_piece`, `is_metal_working`, `is_default`, `variety`, `max_additional_labour`, `max_technology_unit_price`, `technology_purity_identity`) VALUES ('e2d94a01-2292-11ed-945e-aecc6b4ae066', NULL, 'd52e489f-2297-11ed-81a1-beb5915aa4c3', '015', '古法金万足柜', '186', '海南展厅', '015', '古法金柜', NULL, NULL, NULL, NULL, NULL, 13, 'e52a7228-1bfe-11eb-952f-beb5915aa4c3', 0, 6, 'eba088cd-1bfe-11eb-952f-beb5915aa4c3', NULL, '2022-08-23 11:22:58', NULL, NULL, 0, 0, NULL, NULL, 0, 0, 0, 'hs', NULL, NULL, NULL);






























-----------------------------------------------------------------------------------------------------------------


UNION ALL
select 
plm as plm,
0 as qc,
0 as krtcp,
0 as fzgcrk,
0 as fzztrk,
0 as B2Brk,
0 as szgcrk,
0 as szztrk,
0 as bjztrk,
0 as bjrkje,
0 as bjJDSztrk,
0 as bjJDSrkje,
0 as zbztrk,
0 as sdztrk,
0 as sdXXYztrk,
0 as KJztrk,
0 as wwrk,
0 as cgrk,
0 as qtrk,
0 as rkxj,
0 as xsck,
0 as szztck,
0 as szgcck,
0 as szgcRLck,
0 as bjztck,
0 as bjckje,
0 as bjJDSztck,
0 as bjJDSckje,
0 as fzztck,
0 as B2Bck,
0 as zbztck,
0 as sdztck,
0 as sdXXYztck,
0 as KJztck,
0 as wwth,
0 as rlzl,
0 as wxzl,
0 as qxzl,
0 as wtzl,
0 as ckxj,
0 as dqjc,
0 as yk,
0 as jxjdsyyzxck,
0 as jxxxyztck,
0 as jxjdsyyzxrk,
0 as jxxxyztrk,
0  as ymyprk,
0 as ymypck,
0 as zjdxrk,
0 as zjdxck,
0 as fjzjrk,
0 as fjzjck,
0 as mxhrk,
0 as mxhck,
0 as cdztrk,
0 as cdztck
from $temp36
union ALL
select plm,
0 as qc,
0 as krtcp,
0 as fzgcrk,
0 as fzztrk,
0 as B2Brk,
0 as szgcrk,
0 as szztrk,
0 as bjztrk,
0 as bjrkje,
0 as bjJDSztrk,
0 as bjJDSrkje,
0 as zbztrk,
0 as sdztrk,
0 as sdXXYztrk,
0 as KJztrk,
0 as wwrk,
0 as cgrk,
0 as qtrk,
0 as rkxj,
0 as xsck,
0 as szztck,
0 as szgcck,
0 as szgcRLck,
0 as bjztck,
0 as bjckje,
0 as bjJDSztck,
0 as bjJDSckje,
0 as fzztck,
0 as B2Bck,
0 as zbztck,
0 as sdztck,
0 as sdXXYztck,
0 as KJztck,
0 as wwth,
0 as rlzl,
0 as wxzl,
0 as qxzl,
0 as wtzl,
0 as ckxj,
0 as dqjc,
0 as yk,
0 as jxjdsyyzxck,
0 as jxxxyztck,
0 as jxjdsyyzxrk,
0 as jxxxyztrk,
0  as ymyprk,
0 as ymypck,
0 as zjdxrk,
0 as zjdxck,
0 as fjzjrk,
0 as fjzjck,
0 as mxhrk,
0 as mxhck,
0 as cdztrk,
0 as cdztck
from $temp33


-----------------------------------------------------------------------------------------------------------------

UNION ALL
select 
plm as plm,
0 as qc,
0 as krtcp,
0 as fzgcrk,
0 as fzztrk,
0 as B2Brk,
0 as szgcrk,
0 as szztrk,
0 as bjztrk,
0 as bjrkje,
0 as bjJDSztrk,
0 as bjJDSrkje,
0 as zbztrk,
0 as sdztrk,
0 as sdXXYztrk,
0 as KJztrk,
0 as wwrk,
0 as cgrk,
0 as qtrk,
0 as rkxj,
0 as xsck,
0 as szztck,
0 as szgcck,
0 as szgcRLck,
0 as bjztck,
0 as bjckje,
0 as bjJDSztck,
0 as bjJDSckje,
0 as fzztck,
0 as B2Bck,
0 as zbztck,
0 as sdztck,
0 as sdXXYztck,
0 as KJztck,
0 as wwth,
0 as rlzl,
0 as wxzl,
0 as qxzl,
0 as wtzl,
0 as ckxj,
0 as dqjc,
0 as yk,
0 as jxjdsyyzxck,
0 as jxxxyztck,
0 as jxjdsyyzxrk,
0 as jxxxyztrk,
0  as ymyprk,
0 as ymypck,
0 as zjdxrk,
0 as zjdxck,
0 as fjzjrk,
0 as fjzjck,
0 as mxhrk,
0 as mxhck,
0 as cdztrk,
0 as cdztck
from $temp6_new
union ALL
select plm,
0 as qc,
0 as krtcp,
0 as fzgcrk,
0 as fzztrk,
0 as B2Brk,
0 as szgcrk,
0 as szztrk,
0 as bjztrk,
0 as bjrkje,
0 as bjJDSztrk,
0 as bjJDSrkje,
0 as zbztrk,
0 as sdztrk,
0 as sdXXYztrk,
0 as KJztrk,
0 as wwrk,
0 as cgrk,
0 as qtrk,
0 as rkxj,
0 as xsck,
0 as szztck,
0 as szgcck,
0 as szgcRLck,
0 as bjztck,
0 as bjckje,
0 as bjJDSztck,
0 as bjJDSckje,
0 as fzztck,
0 as B2Bck,
0 as zbztck,
0 as sdztck,
0 as sdXXYztck,
0 as KJztck,
0 as wwth,
0 as rlzl,
0 as wxzl,
0 as qxzl,
0 as wtzl,
0 as ckxj,
0 as dqjc,
0 as yk,
0 as jxjdsyyzxck,
0 as jxxxyztck,
0 as jxjdsyyzxrk,
0 as jxxxyztrk,
0  as ymyprk,
0 as ymypck,
0 as zjdxrk,
0 as zjdxck,
0 as fjzjrk,
0 as fjzjck,
0 as mxhrk,
0 as mxhck,
0 as cdztrk,
0 as cdztck
from $temp9_new
union all 
select plm,
0 as qc,
0 as krtcp,
0 as fzgcrk,
0 as fzztrk,
0 as B2Brk,
0 as szgcrk,
0 as szztrk,
0 as bjztrk,
0 as bjrkje,
0 as bjJDSztrk,
0 as bjJDSrkje,
0 as zbztrk,
0 as sdztrk,
0 as sdXXYztrk,
0 as KJztrk,
0 as wwrk,
0 as cgrk,
0 as qtrk,
0 as rkxj,
0 as xsck,
0 as szztck,
0 as szgcck,
0 as szgcRLck,
0 as bjztck,
0 as bjckje,
0 as bjJDSztck,
0 as bjJDSckje,
0 as fzztck,
0 as B2Bck,
0 as zbztck,
0 as sdztck,
0 as sdXXYztck,
0 as KJztck,
0 as wwth,
0 as rlzl,
0 as wxzl,
0 as qxzl,
0 as wtzl,
0 as ckxj,
0 as dqjc,
0 as yk,
0 as jxjdsyyzxck,
0 as jxxxyztck,
0 as jxjdsyyzxrk,
0 as jxxxyztrk,
0  as ymyprk,
0 as ymypck,
0 as zjdxrk,
0 as zjdxck,
0 as fjzjrk,
0 as fjzjck,
0 as mxhrk,
0 as mxhck,
0 as cdztrk,
0 as cdztck
from $temp12_new






























-----------------------------------------------------------------------------------------------------------------
select 
'合计'as plm,
cast($temp3.qc+$tempgf3.qc+$temp6.qc/*+$temp6_new.qc*/+$temp15.qc+/*$temp36.qc+*/$YJ.qc+$temp1588.qc+$temp1888.qc+$tempwq1888.qc+$tempgfwz3.qc+$tempgfwj3.qc+$tempzj3.qc+$tempqzccj3.qc+$tempwzccj3.qc/*+$ZJZ.qc*/ as char(20))as qc,
cast($temp3.krtcp+$tempgf3.krtcp+$temp6.krtcp/*+$temp6_new.krtcp*/+$temp15.krtcp+/*$temp36.krtcp+*/$YJ.krtcp+$temp1588.krtcp+$temp1888.krtcp+$tempwq1888.krtcp+$tempgfwz3.krtcp+$tempgfwj3.krtcp+$tempzj3.krtcp+$tempqzccj3.krtcp+$tempwzccj3.krtcp /*+$ZJZ.krtcp*/ as char(20))as krtcp,
cast($temp3.fzgcrk+$tempgf3.fzgcrk+$temp6.fzgcrk/*+$temp6_new.fzgcrk*/+$temp15.fzgcrk+/*$temp36.fzgcrk +*/$YJ.fzgcrk +$temp1588.fzgcrk+$temp1888.fzgcrk+$tempwq1888.fzgcrk+$tempgfwz3.fzgcrk+$tempgfwj3.fzgcrk+$tempzj3.fzgcrk+$tempqzccj3.fzgcrk+$tempwzccj3.fzgcrk /*+$ZJZ.fzgcrk*/ as char(20))as fzgcrk,
cast($temp3.fzztrk+$tempgf3.fzztrk+$temp6.fzztrk/*+$temp6_new.fzztrk*/+$temp15.fzztrk+/*$temp36.fzztrk+*/$YJ.fzztrk+$temp1588.fzztrk+$temp1888.fzztrk+$tempwq1888.fzztrk+$tempgfwz3.fzztrk+$tempgfwj3.fzztrk+$tempzj3.fzztrk+$tempqzccj3.fzztrk+$tempwzccj3.fzztrk /*+$ZJZ.fzztrk*/ as char(20))as fzztrk,
cast($temp3.B2BRK+$tempgf3.B2BRK+$temp6.B2BRK/*+$temp6_new.B2BRK*/+$temp15.B2BRK+/*$temp36.B2BRK+*/$YJ.B2BRK+$temp1588.B2BRK+$temp1888.B2BRK+$tempwq1888.B2BRK+$tempgfwz3.B2BRK+$tempgfwj3.B2BRK+$tempzj3.B2BRK+$tempqzccj3.B2BRK+$tempwzccj3.B2BRK /*+$ZJZ.B2BRK*/ as char(20))as B2BRK,
cast($temp3.szgcrk+$tempgf3.szgcrk+$temp6.szgcrk/*+$temp6_new.szgcrk*/+$temp15.szgcrk+/*$temp36.szgcrk+*/$YJ.szgcrk+$temp1588.szgcrk+$temp1888.szgcrk+$tempwq1888.szgcrk+$tempgfwz3.szgcrk+$tempgfwj3.szgcrk+$tempzj3.szgcrk+$tempqzccj3.szgcrk+$tempwzccj3.szgcrk/*+$ZJZ.szgcrk*/ as char(20))as szgcrk,
cast($temp3.szztrk+$tempgf3.szztrk+$temp6.szztrk/*+$temp6_new.szztrk*/+$temp15.szztrk+/*$temp36.szztrk +*/$YJ.szztrk +$temp1588.szztrk +$temp1888.szztrk+$tempwq1888.szztrk+$tempgfwz3.szztrk+$tempgfwj3.szztrk+$tempzj3.szztrk+$tempqzccj3.szztrk+$tempwzccj3.szztrk/*+$ZJZ.szztrk*/ as char(20))as szztrk,
cast($temp3.bjztrk+$tempgf3.bjztrk+$temp6.bjztrk/*+$temp6_new.bjztrk*/+$temp15.bjztrk+/*$temp36.bjztrk+*/$YJ.bjztrk+$temp1588.bjztrk+$temp1888.bjztrk+$tempwq1888.bjztrk+$tempgfwz3.bjztrk+$tempgfwj3.bjztrk+$tempzj3.bjztrk+$tempqzccj3.bjztrk+$tempwzccj3.bjztrk/*+$ZJZ.bjztrk*/  as char(20))as bjztrk,
cast($temp3.bjrkje+$tempgf3.bjrkje+$temp6.bjrkje/*+$temp6_new.bjrkje*/+$temp15.bjrkje+/*$temp36.bjrkje+*/$YJ.bjrkje+$temp1588.bjrkje+$temp1888.bjrkje+$tempwq1888.bjrkje+$tempgfwz3.bjrkje+$tempgfwj3.bjrkje+$tempzj3.bjrkje+$tempqzccj3.bjrkje+$tempwzccj3.bjrkje/*+$ZJZ.bjrkje*/  as char(20))as bjrkje,
cast($temp3.bjJDSztrk+$tempgf3.bjJDSztrk+$temp6.bjJDSztrk/*+$temp6_new.bjJDSztrk*/+$temp15.bjJDSztrk+/*$temp36.bjJDSztrk+*/$YJ.bjJDSztrk+$temp1588.bjJDSztrk+$temp1888.bjJDSztrk+$tempwq1888.bjJDSztrk+$tempgfwz3.bjJDSztrk+$tempgfwj3.bjJDSztrk+$tempzj3.bjJDSztrk+$tempqzccj3.bjJDSztrk+$tempwzccj3.bjJDSztrk/*+$ZJZ.bjJDSztrk*/ as char(20))as bjJDSztrk,
cast($temp3.bjJDSrkje+$tempgf3.bjJDSrkje+$temp6.bjJDSrkje/*+$temp6_new.bjJDSrkje*/+$temp15.bjJDSrkje+/*$temp36.bjJDSrkje+*/$YJ.bjJDSrkje+$temp1588.bjJDSrkje+$temp1888.bjJDSrkje+$tempwq1888.bjJDSrkje+$tempgfwz3.bjJDSrkje+$tempgfwj3.bjJDSrkje+$tempzj3.bjJDSrkje+$tempqzccj3.bjJDSrkje+$tempwzccj3.bjJDSrkje/*+$ZJZ.bjJDSrkje*/  as char(20))as bjJDSrkje,
cast($temp3.zbztrk+$tempgf3.zbztrk+$temp6.zbztrk/*+$temp6_new.zbztrk*/+$temp15.zbztrk+/*$temp36.zbztrk+*/$YJ.zbztrk+$temp1588.zbztrk+$temp1888.zbztrk+$tempwq1888.zbztrk+$tempgfwz3.zbztrk+$tempgfwj3.zbztrk+$tempzj3.zbztrk+$tempqzccj3.zbztrk+$tempwzccj3.zbztrk/*+$ZJZ.zbztrk*/  as char(20))as zbztrk,
cast($temp3.sdztrk+$tempgf3.sdztrk+$temp6.sdztrk/*+$temp6_new.sdztrk*/+$temp15.sdztrk+/*$temp36.sdztrk*/+$YJ.sdztrk+$temp1588.sdztrk+$temp1888.sdztrk+$tempwq1888.sdztrk+$tempgfwz3.sdztrk+$tempgfwj3.sdztrk+$tempzj3.sdztrk+$tempqzccj3.sdztrk+$tempwzccj3.sdztrk/*+$ZJZ.sdztrk*/   as char(20))as sdztrk,
cast($temp3.sdxxyztrk+$tempgf3.sdxxyztrk+$temp6.sdxxyztrk/*+$temp6_new.sdxxyztrk*/+$temp15.sdxxyztrk+/*$temp36.sdxxyztrk+*/$YJ.sdxxyztrk+$temp1588.sdxxyztrk+$temp1888.sdxxyztrk+$tempwq1888.sdxxyztrk+$tempgfwz3.sdxxyztrk+$tempgfwj3.sdxxyztrk+$tempzj3.sdxxyztrk+$tempqzccj3.sdxxyztrk+$tempwzccj3.sdxxyztrk/*+$ZJZ.sdxxyztrk*/ as char(20))as sdxxyztrk,
cast($temp3.KJztrk+$tempgf3.KJztrk+$temp6.KJztrk/*+$temp6_new.KJztrk*/+$temp15.KJztrk+/*$temp36.KJztrk +*/$YJ.KJztrk +$temp1588.KJztrk+$temp1888.KJztrk+$tempwq1888.KJztrk+$tempgfwz3.KJztrk+$tempgfwj3.KJztrk+$tempzj3.KJztrk+$tempqzccj3.KJztrk+$tempwzccj3.KJztrk/*+$ZJZ.KJztrk*/ as char(20))as KJztrk,
cast($temp3.wwrk+$tempgf3.wwrk+$temp6.wwrk/*+$temp6_new.wwrk*/+$temp15.wwrk+/*$temp36.wwrk+*/$YJ.wwrk+$temp1588.wwrk+$temp1888.wwrk+$tempwq1888.wwrk+$tempgfwz3.wwrk+$tempgfwj3.wwrk+$tempzj3.wwrk+$tempqzccj3.wwrk+$tempwzccj3.wwrk/*+$ZJZ.wwrk */as char(20))as wwrk,
cast($temp3.cgrk+$tempgf3.cgrk+$temp6.cgrk/*+$temp6_new.cgrk*/+$temp15.cgrk+/*$temp36.cgrk+*/$YJ.cgrk+$temp1588.cgrk+$temp1888.cgrk+$tempwq1888.cgrk+$tempgfwz3.cgrk+$tempgfwj3.cgrk+$tempzj3.cgrk+$tempqzccj3.cgrk+$tempwzccj3.cgrk/*+$ZJZ.cgrk*/ as char(20))as cgrk,
cast($temp3.qtrk+$tempgf3.qtrk+$temp6.qtrk/*+$temp6_new.qtrk*/+$temp15.qtrk+/*$temp36.qtrk+*/$YJ.qtrk+$temp1588.qtrk+$temp1888.qtrk+$tempwq1888.qtrk+$tempgfwz3.qtrk+$tempgfwj3.qtrk+$tempzj3.qtrk+$tempqzccj3.qtrk+$tempwzccj3.qtrk/*+$ZJZ.qtrk*/   as char(20))as qtrk,
cast($temp3.rkxj+$tempgf3.rkxj+$temp6.rkxj+$temp15.rkxj/*+$temp6_new.rkxj*/+/*$temp36.rkxj+*/$YJ.rkxj+$temp1588.rkxj+$temp1888.rkxj+$tempwq1888.rkxj+$tempgfwz3.rkxj+$tempgfwj3.rkxj+$tempzj3.rkxj+$tempqzccj3.rkxj+$tempwzccj3.rkxj/*+$ZJZ.rkxj*/ as char(20))as rkxj,
cast($temp3.xsck+$tempgf3.xsck+$temp6.xsck/*+$temp6_new.xsck*/+$temp15.xsck+/*$temp36.xsck+*/$YJ.xsck+$temp1588.xsck+$temp1888.xsck+$tempwq1888.xsck+$tempgfwz3.xsck+$tempgfwj3.xsck+$tempzj3.xsck+$tempqzccj3.xsck+$tempwzccj3.xsck/*+$ZJZ.xsck*/   as char(20))as xsck,
cast($temp3.szztck+$tempgf3.szztck+$temp6.szztck/*+$temp6_new.szztck*/+$temp15.szztck+/*$temp36.szztck+*/$YJ.szztck+$temp1588.szztck+$temp1888.szztck+$tempwq1888.szztck+$tempgfwz3.szztck+$tempgfwj3.szztck+$tempzj3.szztck+$tempqzccj3.szztck+$tempwzccj3.szztck/*+$ZJZ.szztck*/ as char(20))as szztck,
cast($temp3.szgcck+$tempgf3.szgcck+$temp6.szgcck/*+$temp6_new.szgcck*/+$temp15.szgcck+/*$temp36.szgcck+*/$YJ.szgcck+$temp1588.szgcck+$temp1888.szgcck+$tempwq1888.szgcck+$tempgfwz3.szgcck+$tempgfwj3.szgcck+$tempzj3.szgcck+$tempqzccj3.szgcck+$tempwzccj3.szgcck/*+$ZJZ.szgcck*/  as char(20))as szgcck,
cast($temp3.szgcrlck+$tempgf3.szgcrlck+$temp6.szgcrlck/*+$temp6_new.szgcrlck*/+$temp15.szgcrlck+/*$temp36.szgcrlck+*/$YJ.szgcrlck+$temp1588.szgcrlck+$temp1888.szgcrlck+$tempwq1888.szgcrlck+$tempgfwz3.szgcrlck+$tempgfwj3.szgcrlck+$tempzj3.szgcrlck+$tempqzccj3.szgcrlck+$tempwzccj3.szgcrlck/*+$ZJZ.szgcrlck*/ as char(20))as szgcrlck,
cast($temp3.bjztck+$tempgf3.bjztck+$temp6.bjztck/*+$temp6_new.bjztck*/+$temp15.bjztck+/*$temp36.bjztck+*/$YJ.bjztck+$temp1588.bjztck+$temp1888.bjztck+$tempwq1888.bjztck+$tempgfwz3.bjztck+$tempgfwj3.bjztck+$tempzj3.bjztck+$tempqzccj3.bjztck+$tempwzccj3.bjztck/*+$ZJZ.bjztck*/  as char(20))as bjztck,
cast($temp3.bjckje+$tempgf3.bjckje+$temp6.bjckje/*+$temp6_new.bjckje*/+$temp15.bjckje+/*$temp36.bjckje+*/$YJ.bjckje+$temp1588.bjckje+$temp1888.bjckje+$tempwq1888.bjckje+$tempgfwz3.bjckje+$tempgfwj3.bjckje+$tempzj3.bjckje+$tempqzccj3.bjckje+$tempwzccj3.bjckje/*+$ZJZ.bjckje*/  as char(20))as bjckje,
cast($temp3.bjJDSztck+$tempgf3.bjJDSztck+$temp6.bjJDSztck/*+$temp6_new.bjJDSztck*/+$temp15.bjJDSztck+/*$temp36.bjJDSztck +*/$YJ.bjJDSztck +$temp1588.bjJDSztck+$temp1888.bjJDSztck+$tempwq1888.bjJDSztck+$tempgfwz3.bjJDSztck+$tempgfwj3.bjJDSztck+$tempzj3.bjJDSztck+$tempqzccj3.bjJDSztck+$tempwzccj3.bjJDSztck/*+$ZJZ.bjJDSztck*/  as char(20))as bjJDSztck,
cast($temp3.bjJDSckje+$tempgf3.bjJDSckje+$temp6.bjJDSckje/*+$temp6_new.bjJDSckje*/+$temp15.bjJDSckje+/*$temp36.bjJDSckje+*/$YJ.bjJDSckje+$temp1588.bjJDSckje+$temp1888.bjJDSckje+$tempwq1888.bjJDSckje+$tempgfwz3.bjJDSckje+$tempgfwj3.bjJDSckje+$tempzj3.bjJDSckje+$tempqzccj3.bjJDSckje+$tempwzccj3.bjJDSckje/*+$ZJZ.bjJDSckje*/  as char(20))as bjJDSckje,
cast($temp3.fzztck+$tempgf3.fzztck+$temp6.fzztck/*+$temp6_new.fzztck*/+$temp15.fzztck+/*$temp36.fzztck +*/$YJ.fzztck +$temp1588.fzztck+$temp1888.fzztck+$tempwq1888.fzztck+$tempgfwz3.fzztck+$tempgfwj3.fzztck+$tempzj3.fzztck+$tempqzccj3.fzztck+$tempwzccj3.fzztck/*+$ZJZ.fzztck*/  as char(20))as fzztck,
cast($temp3.B2BCK+$tempgf3.B2BCK+$temp6.B2BCK/*+$temp6_new.B2BCK*/+$temp15.B2BCK+/*$temp36.B2BCK +*/$YJ.B2BCK +$temp1588.B2BCK+$temp1888.B2BCK+$tempwq1888.B2BCK+$tempgfwz3.B2BCK+$tempgfwj3.B2BCK+$tempzj3.B2BCK+$tempqzccj3.B2BCK+$tempwzccj3.B2BCK/*+$ZJZ.B2BCK*/  as char(20))as B2Bck,
cast($temp3.zbztck+$tempgf3.zbztck+$temp6.zbztck/*+$temp6_new.zbztck*/+$temp15.zbztck+/*$temp36.zbztck +*/$YJ.zbztck +$temp1588.zbztck+$temp1888.zbztck+$tempwq1888.zbztck+$tempgfwz3.zbztck+$tempgfwj3.zbztck+$tempzj3.zbztck+$tempqzccj3.zbztck+$tempwzccj3.zbztck/*+$ZJZ.zbztck*/  as char(20))as zbztck,
cast($temp3.sdztck+$tempgf3.sdztck+$temp6.sdztck/*+$temp6_new.sdztck*/+$temp15.sdztck+/*$temp36.sdztck+*/$YJ.sdztck+$temp1588.sdztck+$temp1888.sdztck+$tempwq1888.sdztck+$tempgfwz3.sdztck+$tempgfwj3.sdztck+$tempzj3.sdztck+$tempqzccj3.sdztck+$tempwzccj3.sdztck/*+$ZJZ.sdztck*/   as char(20))as sdztck,
cast($temp3.sdxxyztck+$tempgf3.sdxxyztck+$temp6.sdxxyztck/*+$temp6_new.sdxxyztck*/+$temp15.sdxxyztck+/*$temp36.sdxxyztck+*/$YJ.sdxxyztck+$temp1588.sdxxyztck+$temp1888.sdxxyztck+$tempwq1888.sdxxyztck+$tempgfwz3.sdxxyztck+$tempgfwj3.sdxxyztck+$tempzj3.sdxxyztck+$tempqzccj3.sdxxyztck+$tempwzccj3.sdxxyztck/*+$ZJZ.sdxxyztck*/ as char(20))as sdxxyztck,
cast($temp3.kjztck+$tempgf3.kjztck+$temp6.kjztck/*+$temp6_new.kjztck*/+$temp15.kjztck+/*$temp36.kjztck+*/$YJ.kjztck+$temp1588.kjztck+$temp1888.kjztck+$tempwq1888.kjztck+$tempgfwz3.kjztck+$tempgfwj3.kjztck+$tempzj3.kjztck+$tempqzccj3.kjztck+$tempwzccj3.kjztck/*+$ZJZ.kjztck*/   as char(20))as kjztck,
cast($temp3.wwth+$tempgf3.wwth+$temp6.wwth/*+$temp6_new.wwth*/+$temp15.wwth+/*$temp36.wwth+*/$YJ.wwth+$temp1588.wwth+$temp1888.wwth+$tempwq1888.wwth+$tempgfwz3.wwth+$tempgfwj3.wwth+$tempzj3.wwth+$tempqzccj3.wwth+$tempwzccj3.wwth/*+$ZJZ.wwth*/  as char(20))as wwth,
cast($temp3.rlzl+$tempgf3.rlzl+$temp6.rlzl/*+$temp6_new.rlzl*/+$temp15.rlzl+/*$temp36.rlzl+*/$YJ.rlzl+$temp1588.rlzl+$temp1888.rlzl+$tempwq1888.rlzl+$tempgfwz3.rlzl+$tempgfwj3.rlzl+$tempzj3.rlzl+$tempqzccj3.rlzl+$tempwzccj3.rlzl/*+$ZJZ.rlzl*/  as char(20))as rlzl,
cast($temp3.wxzl+$tempgf3.wxzl+$temp6.wxzl/*+$temp6_new.wxzl*/+$temp15.wxzl+/*$temp36.wxzl+*/$YJ.wxzl+$temp1588.wxzl+$temp1888.wxzl+$tempwq1888.wxzl+$tempgfwz3.wxzl+$tempgfwj3.wxzl+$tempzj3.wxzl+$tempqzccj3.wxzl+$tempwzccj3.wxzl/*+$ZJZ.wxzl*/  as char(20))as wxzl,
cast($temp3.qxzl+$tempgf3.qxzl+$temp6.qxzl/*+$temp6_new.qxzl*/+$temp15.qxzl+/*$temp36.qxzl+*/$YJ.qxzl+$temp1588.qxzl+$temp1888.qxzl+$tempwq1888.qxzl+$tempgfwz3.qxzl+$tempgfwj3.qxzl+$tempzj3.qxzl+$tempqzccj3.qxzl+$tempwzccj3.qxzl/*+$ZJZ.qxzl*/   as char(20))as qxzl,
cast($temp3.wtzl+$tempgf3.wtzl+$temp6.wtzl/*$temp6_new.wtzl+*/+$temp15.wtzl+/*$temp36.wtzl+*/$YJ.wtzl+$temp1588.wtzl+$temp1888.wtzl+$tempwq1888.wtzl+$tempgfwz3.wtzl+$tempgfwj3.wtzl+$tempzj3.wtzl+$tempqzccj3.wtzl+$tempwzccj3.wtzl/*+$ZJZ.wtzl*/  as char(20))as wtzl,
cast($temp3.ckxj+$tempgf3.ckxj+$temp6.ckxj/*+$temp6_new.ckxj*/+$temp15.ckxj+/*$temp36.ckxj+*/$YJ.ckxj+$temp1588.ckxj+$temp1888.ckxj+$tempwq1888.ckxj+$tempgfwz3.ckxj+$tempgfwj3.ckxj+$tempzj3.ckxj+$tempqzccj3.ckxj+$tempwzccj3.ckxj/*+$ZJZ.ckxj*/  as char(20))as ckxj,
cast($temp3.dqjc+$tempgf3.dqjc+$temp6.dqjc/*+$temp6_new.dqjc*/+$temp15.dqjc+/*$temp36.dqjc+*/$YJ.dqjc+$temp1588.dqjc+$temp1888.dqjc+$tempwq1888.dqjc+$tempgfwz3.dqjc+$tempgfwj3.dqjc+$tempzj3.dqjc+$tempqzccj3.dqjc+$tempwzccj3.dqjc/*+$ZJZ.dqjc*/  as char(20))as dqjc,
cast($temp3.yk+$tempgf3.yk+$temp6.yk/*+$temp6_new.yk*/+$temp15.yk+/*$temp36.yk+*/$YJ.yk+$temp1588.yk+$temp1888.yk+$tempwq1888.yk+$tempgfwz3.yk+$tempgfwj3.yk+$tempzj3.yk+$tempqzccj3.yk+$tempwzccj3.yk/*+$ZJZ.yk*/  as char(20))as yk,
cast($temp3.jxjdsyyzxck+$tempgf3.jxjdsyyzxck+$temp6.jxjdsyyzxck/*+$temp6_new.jxjdsyyzxck*/+$temp15.jxjdsyyzxck+/*$temp36.jxjdsyyzxck+*/$YJ.jxjdsyyzxck+$temp1588.jxjdsyyzxck+$temp1888.jxjdsyyzxck+$tempwq1888.jxjdsyyzxck+$tempgfwz3.jxjdsyyzxck+$tempgfwj3.jxjdsyyzxck+$tempzj3.jxjdsyyzxck+$tempqzccj3.jxjdsyyzxck+$tempwzccj3.jxjdsyyzxck/*+$ZJZ.jxjdsyyzxck*/ as char(20))as jxjdsyyzxck,
cast($temp3.jxxxyztck+$tempgf3.jxxxyztck+$temp6.jxxxyztck/*+$temp6_new.jxxxyztck*/+$temp15.jxxxyztck+/*$temp36.jxxxyztck+*/$YJ.jxxxyztck+$temp1588.jxxxyztck+$temp1888.jxxxyztck+$tempwq1888.jxxxyztck+$tempgfwz3.jxxxyztck+$tempgfwj3.jxxxyztck+$tempzj3.jxxxyztck+$tempqzccj3.jxxxyztck+$tempwzccj3.jxxxyztck/*+$ZJZ.jxxxyztck*/  as char(20))as jxxxyztck,
cast($temp3.jxjdsyyzxrk+$tempgf3.jxjdsyyzxrk+$temp6.jxjdsyyzxrk/*+$temp6_new.jxjdsyyzxrk*/+$temp15.jxjdsyyzxrk+/*$temp36.jxjdsyyzxrk+*/$YJ.jxjdsyyzxrk+$temp1588.jxjdsyyzxrk+$temp1888.jxjdsyyzxrk+$tempwq1888.jxjdsyyzxrk+$tempgfwz3.jxjdsyyzxrk+$tempgfwj3.jxjdsyyzxrk+$tempzj3.jxjdsyyzxrk+$tempqzccj3.jxjdsyyzxrk+$tempwzccj3.jxjdsyyzxrk/*+$ZJZ.jxjdsyyzxrk*/  as char(20))as jxjdsyyzxrk,
cast($temp3.jxxxyztrk+$tempgf3.jxxxyztrk+$temp6.jxxxyztrk/*+$temp6_new.jxxxyztrk*/+$temp15.jxxxyztrk+/*$temp36.jxxxyztrk+*/$YJ.jxxxyztrk+$temp1588.jxxxyztrk+$temp1888.jxxxyztrk+$tempwq1888.jxxxyztrk+$tempgfwz3.jxxxyztrk+$tempgfwj3.jxxxyztrk+$tempzj3.jxxxyztrk+$tempqzccj3.jxxxyztrk+$tempwzccj3.jxxxyztrk/*+$ZJZ.jxxxyztrk*/ as char(20))as jxxxyztrk,
cast($temp3.ymyprk+$tempgf3.ymyprk+$temp6.ymyprk/*+$temp6_new.ymyprk*/+$temp15.ymyprk+/*$temp36.ymyprk+*/$YJ.ymyprk+$temp1588.ymyprk+$temp1888.ymyprk+$tempwq1888.ymyprk+$tempgfwz3.ymyprk+$tempgfwj3.ymyprk+$tempzj3.ymyprk+$tempqzccj3.ymyprk+$tempwzccj3.ymyprk/*+$ZJZ.ymyprk*/ as char(20))as ymyprk,
cast($temp3.ymypck+$tempgf3.ymypck+$temp6.ymypck/*+$temp6_new.ymypck*/+$temp15.ymypck+/*$temp36.ymypck+*/$YJ.ymypck+$temp1588.ymypck+$temp1888.ymypck+$tempwq1888.ymypck+$tempgfwz3.ymypck+$tempgfwj3.ymypck+$tempzj3.ymypck+$tempqzccj3.ymypck+$tempwzccj3.ymypck/*+$ZJZ.ymypck*/  as char(20))as ymypck,
cast($temp3.zjdxrk+$tempgf3.zjdxrk+$temp6.zjdxrk/*+$temp6_new.zjdxrk*/+$temp15.zjdxrk+/*$temp36.zjdxrk+*/$YJ.zjdxrk+$temp1588.zjdxrk+$temp1888.zjdxrk+$tempwq1888.zjdxrk+$tempgfwz3.zjdxrk+$tempgfwj3.zjdxrk+$tempzj3.zjdxrk+$tempqzccj3.zjdxrk+$tempwzccj3.zjdxrk/*+$ZJZ.zjdxrk */ as char(20))as zjdxrk,
cast($temp3.zjdxck+$tempgf3.zjdxck+$temp6.zjdxck/*+$temp6_new.zjdxck*/+$temp15.zjdxck+/*$temp36.zjdxck+*/$YJ.zjdxck+$temp1588.zjdxck+$temp1888.zjdxck+$tempwq1888.zjdxck+$tempgfwz3.zjdxck+$tempgfwj3.zjdxck+$tempzj3.zjdxck+$tempqzccj3.zjdxck+$tempwzccj3.zjdxck/*+$ZJZ.zjdxck*/  as char(20))as zjdxck,
cast($temp3.fjzjrk+$tempgf3.fjzjrk+$temp6.fjzjrk/*+$temp6_new.fjzjrk*/+$temp15.fjzjrk+/*$temp36.fjzjrk+*/$YJ.fjzjrk+$temp1588.fjzjrk+$temp1888.fjzjrk+$tempwq1888.fjzjrk+$tempgfwz3.fjzjrk+$tempgfwj3.fjzjrk+$tempzj3.fjzjrk+$tempqzccj3.fjzjrk+$tempwzccj3.fjzjrk/*+$ZJZ.fjzjrk*/  as char(20))as fjzjrk,
cast($temp3.fjzjck+$tempgf3.fjzjck+$temp6.fjzjck/*+$temp6_new.fjzjck*/+$temp15.fjzjck+/*$temp36.fjzjck+*/$YJ.fjzjck+$temp1588.fjzjck+$temp1888.fjzjck+$tempwq1888.fjzjck+$tempgfwz3.fjzjck+$tempgfwj3.fjzjck+$tempzj3.fjzjck+$tempqzccj3.fjzjck+$tempwzccj3.fjzjck/*+$ZJZ.fjzjck*/  as char(20))as fjzjck,
cast($temp3.mxhrk+$tempgf3.mxhrk+$temp6.mxhrk/*+$temp6_new.mxhrk*/+$temp15.mxhrk+/*$temp36.mxhrk+*/$YJ.mxhrk+$temp1588.mxhrk+$temp1888.mxhrk+$tempwq1888.mxhrk+$tempgfwz3.mxhrk+$tempgfwj3.mxhrk+$tempzj3.mxhrk+$tempqzccj3.mxhrk+$tempwzccj3.mxhrk /*+$ZJZ.mxhrk*/ as char(20)) as mxhrk,
cast($temp3.mxhck+$tempgf3.mxhck+$temp6.mxhck/*+$temp6_new.mxhck*/+$temp15.mxhck+/*$temp36.mxhck+*/$YJ.mxhck+$temp1588.mxhck+$temp1888.mxhck+$tempwq1888.mxhck+$tempgfwz3.mxhck+$tempgfwj3.mxhck+$tempzj3.mxhck+$tempqzccj3.mxhck+$tempwzccj3.mxhck/*+$ZJZ.mxhck*/ as char(20)) as mxhck,
cast($temp3.cdztrk+$tempgf3.cdztrk+$temp6.cdztrk/*+$temp6_new.cdztrk*/+$temp15.cdztrk+/*$temp36.cdztrk+*/$YJ.cdztrk+$temp1588.cdztrk+$temp1888.cdztrk+$tempwq1888.cdztrk+$tempgfwz3.cdztrk+$tempgfwj3.cdztrk+$tempzj3.cdztrk+$tempqzccj3.cdztrk+$tempwzccj3.cdztrk /*+$ZJZ.mxhrk*/ as char(20)) as cdztrk,
cast($temp3.cdztck+$tempgf3.cdztck+$temp6.cdztck/*+$temp6_new.cdztck*/+$temp15.cdztck+/*$temp36.cdztck+*/$YJ.cdztck+$temp1588.cdztck+$temp1888.cdztck+$tempwq1888.cdztck+$tempgfwz3.cdztck+$tempgfwj3.cdztck+$tempzj3.cdztck+$tempqzccj3.cdztck+$tempwzccj3.cdztck/*+$ZJZ.mxhck*/ as char(20)) as cdztck
from $temp3,$tempgf3,$temp6,/*$temp6_new,*/$temp15 ,$temp1588 ,/*$temp36 ,*/$YJ ,$temp1888,$tempwq1888 ,$tempgfwz3,$tempgfwj3,$tempzj3,$tempqzccj3,$tempwzccj3/*,$ZJZ*/;





























-----------------------------------------------------------------------------------------------------------------




          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(QC) END   AS QC, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(A1) END  AS A1, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(A2) END  AS A2,
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(A3) END AS A3, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(A4)  END  AS A4, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(A5)  END AS A5, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(A6)  END AS A6,
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(A7) END  AS A7, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(RKHJ) END  AS RKHJ, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(B1) END  AS B1, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(B2)  END AS B2, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(B3) END  AS B3, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(B4) END  AS B4, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(B5) END  AS B5, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(B6) END  AS B6, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(CKHJ)  END AS CKHJ, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(YK) END  AS YK, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(YC) END  AS YC, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(SC) END  AS SC, 
          CASE WHEN CKMC IN ('维修仓','镶嵌柜-德钰东方','镶嵌柜德钰东方') THEN 0 ELSE SUM(CD) END  AS CD



























-----------------------------------------------------------------------------------------------------------------

转仓单数据差额问题排查：

  select rq, max(收) as 收, max(发) as 发, max(发) - max(收) as 差额 from(
  select rq, 
         case when sffx='收' then sum(jz) else 0 end as "收", 
         case when sffx='发' then sum(jz) else 0 end as "发" 
    from t_ka_splsz 
   where djh like 'zcd%'
   group by rq,sffx) t group by rq





























-----------------------------------------------------------------------------------------------------------------
成品报表问题
select com,sum(jz) from (select '福州' as com,sum(total_gold_weight) as jz from t_receive where supplier_type=0  and examine_time='2022-07-28' and supplier_source like '福州%' 
and `status`=0  
union all 
select '福州' com,sum(total_weight)  as jz from t_bf_gold_transfer_in where DATE(approve_time)='2022-07-28' and transfer_out_showroom like '福州%' and approve_status=1
and STATUS=0 GROUP BY com)t  GROUP BY com
union all 
select com,sum(jz)  from (
select '深圳' com,sum(total_gold_weight) as jz from t_receive where supplier_type=0  and examine_time='2022-07-28' and supplier_source='深圳工厂' and `status`=0 
union all 
select '深圳' com ,sum(total_weight)  as jz from t_bf_gold_transfer_in where DATE(approve_time)='2022-07-28' and transfer_out_showroom='深圳工厂'
and approve_status=1 and STATUS=0 GROUP BY com )t GROUP BY com;





select 
sum(case when swlx='调拨入库' and  sffx='收' and (chf like '福州工厂%' or chf like '福州K金工厂%' or chf like '福州镶嵌工厂%')  and djm<>'单件调拨入库单'  then ifnull(jz,0) else 0 end) AS fzgcrk,
sum(case when swlx='调拨入库' and  sffx='收' and chf like '深圳工厂%' and djm<>'单件调拨入库单'   then ifnull(jz,0) else 0 end) AS szgcrk

from t_ka_splsz where DATE(rq)='2022-7-28';

select * from t_ka_splsz where  swlx='调拨入库' and  sffx='收' and (chf like '福州工厂%' or chf like '福州K金工厂%' or chf like '福州镶嵌工厂%')  and djm<>'单件调拨入库单' and DATE(rq)='2022-7-28'

  select rq, max(收) as 收, max(发) as 发, max(发) - max(收) as 差额 from(
  select rq, 
         case when sffx='收' then sum(jz) else 0 end as "收", 
         case when sffx='发' then sum(jz) else 0 end as "发" 
    from t_ka_splsz 
   where djh like 'zcd%'
   group by rq,sffx) t group by rq



























-----------------------------------------------------------------------------------------------------------------


select mc,
rq,
sum(jz),
SUM(je)
from(
SELECT
'深圳工厂' as mc,
sum(IFNULL(total_gold_weight,0)) as jz,
sum(IFNULL(total_fee,0)) as je,
'' as bz ,
 date(examine_time) rq
FROM
 t_receive r 
WHERE
 r.supplier_type = 0
 and r.supplier_source = '深圳工厂' 
 AND r.STATUS = 0 
 and showroom_name='深圳展厅' 
 GROUP BY DATE(examine_time)
)t
GROUP BY rq
ORDER BY rq
 
 

 





























-----------------------------------------------------------------------------------------------------------------

select -- djh,sum(jz),sum(IFNULL(jcgfje,0)+IFNULL(FJGFJE,0)) 
*
FROM t_ka_splsz where djh in (
'WWRK2022082400957',
'WWRK2022082400963',
'WWRK2022082400966',
'WWRK2022082400967',
'WWRK2022082400971',
'WWRK2022082400978',
'WWRK2022082400979',
'QXRK2022082400980',
'WWRK2022082400983',
'WWRK2022082400984',
'WWRK2022082400992',
'WWRK2022082400995',
'QXRK2022082401011',
'WWRK2022082401027',
'WWRK2022082401029',
'WWRK2022082401034',
'WWRK2022082401077',
'WWRK2022082401085',
'WWRK2022082401097',
'WWRK2022082401098'
)
and DATE(rq)='2022-08-26'
ORDER BY djh 






















select 
* FROM t_ka_splsz where djh in ( 
'WWRK2022082500279',
'WWRK2022082500501',
'QXRK2022082500547',
'QXRK2022082500550',
'WWRK2022082500680',
'WWRK2022082500934',
'WWRK2022082500959',
'WWRK2022082500980',
'WWRK2022082501007',
'WWRK2022082501008',
'WWRK2022082501016',
'WWRK2022082501018',
'WWRK2022082501019',
'WWRK2022082501026',
'WWRK2022082501032',
'WWRK2022082501038',
'WWRK2022082501041',
'WWRK2022082501042',
'WWRK2022082501072',
'WWRK2022082501076',
'WWRK2022082501077',
'WWRK2022082501080',
'WWRK2022082501081',
'WWRK2022082501083',
'WWRK2022082501085',
'WWRK2022082501087',
'WWRK2022082501091',
'WWRK2022082501093',
'WWRK2022082501097',
'WWRK2022082501099',
'WWRK2022082501101',
'WWRK2022082501103',
'WWRK2022082501106',
'WWRK2022082501107',
'WWRK2022082501108',
'WWRK2022082501109',
'WWRK2022082501111',
'WWRK2022082501113',
'WWRK2022082501115',
'WWRK2022082501117',
'WWRK2022082501119',
'WWRK2022082501120',
'WWRK2022082501122',
'WWRK2022082501124',
'WWRK2022082501126',
'QXRK2022082501127',
'WWRK2022082501130',
'WWRK2022082501137',
'WWRK2022082501139',
'WWRK2022082501140',
'WWRK2022082501141',
'WWRK2022082501143',
'WWRK2022082501144',
'WWRK2022082501145',
'WWRK2022082501149',
'WWRK2022082501152',
'WWRK2022082501156',
'QXRK2022082501160',
'WWRK2022082501170',
'WWRK2022082501171',
'WWRK2022082501180',
'WWRK2022082501183',
'WWRK2022082501186',
'WWRK2022082501192',
'WWRK2022082501194',
'WWRK2022082501197',
'WWRK2022082501200',
'WWRK2022082501201',
'WWRK2022082501206',
'WWRK2022082501207',
'WWRK2022082501213',
'WWRK2022082501214',
'WWRK2022082501217',
'WWRK2022082501219',
'WWRK2022082501226',
'WWRK2022082501227')
and DATE(rq)='2022-08-26'
































-----------------------------------------------------------------------------------------------------------------

CREATE DEFINER=`app_test`@`%` PROCEDURE `cx_xf_new`(in v_area_name VARCHAR(60),v_rq date)
BEGIN
###################################################################
-- To->刘啸飞  计算来料差异 存储过程
###################################################################
drop temporary table if exists temp_resault1;
create temporary table temp_resault1 (
      approveStatus varchar(20),
      areaName  varchar(18),
      planIncoming  decimal(18,3),
      actualIncoming  decimal(18,3),
      difference  decimal(18,3),
      isEdit  int) ;
insert into temp_resault1 
SELECT
      '已审核' AS approveStatus,
      t.area_name AS areaName,
      IFNULL( sum( t.neight ), 0.000 ) AS planIncoming,
      IFNULL( sum( t.receive_gold_weight ), 0.000 ) AS actualIncoming,
      IFNULL( sum( t.receive_gold_weight ), 0.000 ) - IFNULL( sum( t.neight ), 0.000 ) AS difference,
      0 AS isEdit 
      from (
    select bb.area_name,neight,receive_gold_weight
    FROM
      ( SELECT area_name FROM t_bf_area WHERE area_name IN ( SELECT `name` FROM t_incoming_maintain WHERE type = 1 ) ) bb
      LEFT JOIN (
      SELECT
        sum( t1.neight ) AS neight,
        '' as receive_gold_weight,
        IFNULL( t4.area_name, t3.area_name ) AS area_name 
      FROM
        t_bf_raw_material t1
        INNER JOIN t_fast_customer t2 ON t1.customer_identity = t2.customer_identity
        LEFT JOIN t_bf_area t4 ON t2.area_identity = t4.area_identity
        INNER JOIN view_customer t3 ON t1.customer_identity = t3.customer_identity 
      WHERE
        t1.approve_status = 1 
        AND DATE_FORMAT( t1.approve_time, '%y-%m-%d' ) = DATE_FORMAT( v_rq, '%y-%m-%d' ) 
      GROUP BY
        area_name 
      ) a ON bb.area_name = a.area_name
      union all
      select  bb.area_name,neight,receive_gold_weight 
    FROM
      ( SELECT area_name FROM t_bf_area WHERE area_name IN ( SELECT `name` FROM t_incoming_maintain WHERE type = 1 ) ) bb
      LEFT JOIN (
      SELECT
      '' as neight,
        sum( t1.receive_gold_weight ) AS receive_gold_weight,
        IFNULL( t4.area_name, t3.area_name ) AS area_name 
      FROM
        t_bf_receive_meterial t1
        INNER JOIN t_fast_customer t2 ON t1.customer_identity = t2.customer_identity
        LEFT JOIN t_bf_area t4 ON t2.area_identity = t4.area_identity
        INNER JOIN view_customer t3 ON t1.customer_identity = t3.customer_identity 
      WHERE
        t1.approve_status = 1 
        AND DATE_FORMAT( t1.approve_time, '%y-%m-%d' ) = DATE_FORMAT( v_rq, '%y-%m-%d' ) 
      GROUP BY
        area_name 
      ) AS c ON bb.area_name = c.area_name )as t
    GROUP BY
      areaName 
      union all 
      
      SELECT
      '已审核' AS approveStatus,
      t.customer_name AS areaName,
      IFNULL( sum( t.neight ), 0.000 ) AS planIncoming,
      IFNULL( sum( t.receive_gold_weight ), 0.000 ) AS actualIncoming,
      IFNULL( sum( t.receive_gold_weight ), 0.000 ) - IFNULL( sum( t.neight ), 0.000 ) AS difference,
      0 AS isEdit 
      from (
      select customer_name,neight,receive_gold_weight
    FROM
      ( SELECT customer_name, customer_identity FROM t_fast_customer WHERE customer_identity IN ( SELECT identity FROM t_incoming_maintain WHERE type = 2 ) ) AS t
      LEFT JOIN (
      SELECT
        sum( t1.neight ) AS neight,
        t1.parent_customer_identity,
        '' as receive_gold_weight
      FROM
        t_bf_raw_material t1
        LEFT JOIN t_fast_customer t2 ON t1.customer_identity = t2.customer_identity 
      WHERE
        t1.approve_status = 1 
        AND DATE_FORMAT( t1.approve_time, '%y-%m-%d' ) = DATE_FORMAT( v_rq, '%y-%m-%d' ) 
      GROUP BY
        t1.customer_identity 
      ) AS a ON t.customer_identity = a.parent_customer_identity
      UNION ALL
      select customer_name,neight,receive_gold_weight
    FROM
      ( SELECT customer_name, customer_identity FROM t_fast_customer WHERE customer_identity IN ( SELECT identity FROM t_incoming_maintain WHERE type = 2 ) ) AS t
      LEFT JOIN (
      SELECT
      '' as neight,
        t1.parent_customer_identity,
        sum( t1.receive_gold_weight ) AS receive_gold_weight
      FROM
        t_bf_receive_meterial t1 
      WHERE
        t1.approve_status = 1 
        AND DATE_FORMAT( t1.approve_time, '%y-%m-%d' ) = DATE_FORMAT( v_rq, '%y-%m-%d' ) 
      GROUP BY
        t1.customer_identity 
      ) AS c ON t.customer_identity = c.parent_customer_identity ) as t
    GROUP BY
      areaName;
      
 drop temporary table if exists temp_resault2;
create temporary table temp_resault2 (
      approveStatus varchar(20),
      areaName  varchar(18),
      planIncoming  decimal(18,3),
      actualIncoming  decimal(18,3),
      difference  decimal(18,3),
      isEdit  int) ;
insert into temp_resault2       
      SELECT
      '已审核' AS approveStatus,
      b.NAME AS areaName,
      b.planIncoming AS planIncoming,
      b.actualIncoming AS actualIncoming,
      b.actualIncoming - b.planIncoming AS difference,
      isEdit 
    FROM
      (
      SELECT
        '名城展厅' AS `name`,
        (
        SELECT
          IFNULL( sum( plan_incoming ), 0.000 ) 
        FROM
          t_incoming_difference 
        WHERE
          `area_name` = '名城展厅' 
          AND DATE_FORMAT( create_time, '%y-%m-%d' )= DATE_FORMAT( v_rq, '%y-%m-%d' ) 
        ) AS planIncoming,
        IFNULL( sum( t.weight ), 0.000 ) AS actualIncoming,
        1 AS isEdit 
      FROM
        (
        SELECT
          sum( total_weight ) AS weight 
        FROM
          t_bf_gold_transfer_in 
        WHERE
          transfer_out_showroom LIKE '%特艺城展厅%' 
          AND DATE_FORMAT( approve_time, '%y-%m-%d' ) = DATE_FORMAT( v_rq, '%y-%m-%d' ) UNION
        SELECT
          sum( t1.receive_gold_weight ) AS weight 
        FROM
          t_bf_receive_meterial t1
          LEFT JOIN t_fast_customer t2 ON t1.customer_identity = t2.customer_identity 
        WHERE
          t1.approve_status = 1 
          AND t2.customer_name LIKE '%特艺城%' 
          AND DATE_FORMAT( t1.approve_time, '%y-%m-%d' ) = DATE_FORMAT( v_rq, '%y-%m-%d' ) 
        ) AS t 
      ) AS b
      
      union all 
      
      SELECT
      '已审核' AS approveStatus,
      t.NAME AS areaName,
      IFNULL( sum( b.planIncoming ), 0.000 ) AS planIncoming,
      IFNULL( sum( a.weight ), 0.000 ) AS actualIncoming,
      IFNULL( sum( a.weight ), 0.000 ) - IFNULL( sum( b.planIncoming ), 0.000 ) AS difference,
      1 as isEdit
    FROM
      (
      SELECT
        `name`,
        `sub_name` 
      FROM
        t_incoming_maintain 
      WHERE
        type = 3 
      AND `name` NOT IN ( '名城展厅', '鑫囍缘展厅' )) AS t
      LEFT JOIN (
      SELECT
        transfer_out_showroom,
        sum( total_weight ) AS weight 
      FROM
        t_bf_gold_transfer_in 
      WHERE
        approve_status = 1 
        AND DATE_FORMAT( approve_time, '%y-%m-%d' ) = DATE_FORMAT( v_rq, '%y-%m-%d' ) 
      GROUP BY
        transfer_out_showroom 
      ) AS a ON t.sub_name = a.transfer_out_showroom
      LEFT JOIN (
      SELECT
        sum( plan_incoming ) AS planIncoming,
        area_name 
      FROM
        t_incoming_difference 
      WHERE
        DATE_FORMAT( create_time, '%y-%m-%d' )= DATE_FORMAT( v_rq, '%y-%m-%d' ) 
      GROUP BY
        area_name 
      ) AS b ON b.area_name = t.sub_name group by areaName  
      union all
      SELECT
      '已审核' AS approveStatus,
      b.`name` AS areaName,
      b.planIncoming AS planIncoming,
      b.actualIncoming AS actualIncoming,
      b.actualIncoming - b.planIncoming AS difference,
      1 AS isEdit 
    FROM
      (
      SELECT
        '鑫囍缘展厅' AS `name`,
        (
        SELECT
          IFNULL( sum( plan_incoming ), 0.000 ) 
        FROM
          t_incoming_difference 
        WHERE
          `area_name` = '鑫囍缘展厅' 
          AND DATE_FORMAT( create_time, '%y-%m-%d' )= DATE_FORMAT( v_rq, '%y-%m-%d' ) 
        ) AS planIncoming,
        IFNULL( sum( t.weight ), 0.000 ) AS actualIncoming 
      FROM
        (
        SELECT
          sum( total_weight ) AS weight 
        FROM
          t_bf_gold_transfer_in 
        WHERE
          transfer_out_showroom = '总部万足展厅' 
          AND DATE_FORMAT( approve_time, '%y-%m-%d' ) = DATE_FORMAT( v_rq, '%y-%m-%d' ) UNION
        SELECT
          sum( t1.receive_gold_weight ) AS weight 
        FROM
          t_bf_receive_meterial t1
          LEFT JOIN t_fast_customer t2 ON t1.customer_identity = t2.customer_identity 
        WHERE
          t1.approve_status = 1 
          AND t2.customer_name LIKE '%鑫囍缘%' 
          AND DATE_FORMAT( t1.approve_time, '%y-%m-%d' ) = DATE_FORMAT( v_rq, '%y-%m-%d' ) 
        ) AS t 
      ) AS b;
      
 drop temporary table if exists temp_resault3;
 create temporary table temp_resault3 (
      approveStatus varchar(20),
      areaName  varchar(18),
      planIncoming  decimal(18,3),
      actualIncoming  decimal(18,3),
      difference  decimal(18,3),
      isEdit  int) ;
insert into temp_resault3 
      SELECT
      '汇总' AS approveStatus,
      '' AS areaName,
      sum( f.planIncoming ) as planIncoming,
      sum( f.actualIncoming ) as actualIncoming,
      sum( f.difference ) as difference,
      0 AS isEdit from  temp_resault1 f ;
      
drop temporary table if exists temp_resault4;
create temporary table temp_resault4  (
      approveStatus varchar(20),
      areaName  varchar(18),
      planIncoming  decimal(18,3),
      actualIncoming  decimal(18,3),
      difference  decimal(18,3),
      isEdit  int) ;
insert into temp_resault4 
        SELECT
      '汇总' AS approveStatus,
      '' AS areaName,
      sum( f.planIncoming ) as planIncoming,
      sum( f.actualIncoming ) as actualIncoming,
      sum( f.difference ) as difference,
      0 AS isEdit from  temp_resault2 f; 

drop temporary table if exists temp_resault5;
create temporary table temp_resault5 as 
     select * from temp_resault1
      union all 
      select * from temp_resault3
      union all 
      select * from temp_resault2
      union all 
      select * from temp_resault4;
      
    if (v_area_name<>'' or v_area_name<>null) then 
     select *  from temp_resault5 where areaName= v_area_name;
     else 
     select * from temp_resault5;
    end if;
      
 
 DROP TEMPORARY TABLE IF EXISTS temp_resault1; 
 DROP TEMPORARY TABLE IF EXISTS temp_resault2; 
 DROP TEMPORARY TABLE IF EXISTS temp_resault3; 
 DROP TEMPORARY TABLE IF EXISTS temp_resault4; 
 DROP TEMPORARY TABLE IF EXISTS temp_resault5; 
            
    
      
    
      
 

END






























-----------------------------------------------------------------------------------------------------------------
































-----------------------------------------------------------------------------------------------------------------
































-----------------------------------------------------------------------------------------------------------------
































-----------------------------------------------------------------------------------------------------------------
































-----------------------------------------------------------------------------------------------------------------
































-----------------------------------------------------------------------------------------------------------------
































-----------------------------------------------------------------------------------------------------------------
































-----------------------------------------------------------------------------------------------------------------































-----------------------------------------------------------------------------------------------------------------
































-----------------------------------------------------------------------------------------------------------------
































-----------------------------------------------------------------------------------------------------------------
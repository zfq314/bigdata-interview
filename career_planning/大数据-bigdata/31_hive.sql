show tables ;


select * from t_bf_cus_debit_receipt where dt='2022-12-01' ;

 select sum(total_price)/10000   as sr
 from t_bf_cus_debit_receipt where date_format(dt,'yyyy-MM-dd')='2022-12-01' and showroom_name='深圳展厅' and today_settle=1 and approve_status=1 and `status`=0
union all
select sum(total_price)/10000
 from t_bf_cus_debit_receipt where date_format(dt,'yyyy-MM-dd')='2022-12-01' and showroom_name='深圳展厅' and today_settle=0 and approve_status=1 and `status`=0;

select sum(total_price)/10000   as sr
 from t_bf_cus_debit_receipt where date_format(dt,'yyyy-MM-dd')='2022-12-01' and showroom_name='深圳展厅'  and approve_status=1 and `status`=0;

use sz_decent_cloud;

desc formatted fjgfzkbh;

create database  zfq_test_decent_cloud;

show tables ;

truncate table t_ka_szkhcqmx_h;

use zfq_test_decent_cloud;

load data inpath '/test_zfq_decent_cloud/t_ka_lscqmxb_b/2022-12-08' into table t_ka_lscqmxb_b partition (dt='2022-12-08');

select * from t_ka_lscqmxb_b ;
select count(*) from t_ka_lscqmxb_b;


select b.* from t_ka_lscqmxb_b a right join t_ka_lscqmxb_h b on  a.lscqmxb_h_identity=b.lscqmxb_h_identity;

select t1.wdmc AS wdmc,t1.customer_identity AS customer_identity,t1.customer_code AS customer_code,t1.customer_name AS customer_name,t1.parent_customer_code AS parent_customer_code,t1.parent_customer_name AS parent_customer_name,t1.child_customer_name AS child_customer_name,t1.area_name AS area_name,t1.province_name AS province_name,t1.city_name AS city_name,t1.county_name AS county_name,t1.child_customer_code AS child_customer_code,t1.is_child AS is_child,t1.active_flag AS active_flag,t1.is_supplier AS is_supplier,t1.purity_name AS purity_name,t1.license_desc AS license_desc,  area_name_business,t1.create_date AS create_date, technology_purity_identity AS technology_purity_identity from
 (
  select t1.*,t4.area_name as area_name_business, t2.technology_purity_identity from (
      select t_customer.branch_name AS wdmc,t_customer.customer_identity AS customer_identity,t_customer.customer_code AS customer_code,t_customer.customer_name AS customer_name,t_customer.customer_code AS parent_customer_code,t_customer.customer_name AS parent_customer_name,'' AS child_customer_name,t_customer.area_name AS area_name,t_customer.province AS province_name,t_customer.city_code AS city_name,t_customer.county_desc AS county_name,'' AS child_customer_code,0 AS is_child,t_customer.active_flag AS active_flag,t_customer.is_supplier AS is_supplier,t_customer.purity_name AS purity_name,t_customer.license_desc AS license_desc,cast(t_customer.create_date as date) AS create_date from t_customer union all select a.branch_name AS wdmc,b.child_customer_identity AS customer_identity,concat(a.customer_code,lpad(b.child_customer_seq,4,'0')) AS customer_code,b.child_customer_name AS customer_name,a.customer_code AS parent_customer_code,a.customer_name AS parent_customer_name,b.child_customer_name AS child_customer_name,a.area_name AS area_name,if(b.province is null,a.province,b.province) AS province_name,a.city_code AS city_name,a.county_desc AS county_name,b.child_customer_code AS child_customer_code,1 AS is_child,(case when (if(a.active_flag is null,'Y',a.active_flag) = 'N') then 'N' else if(b.active_flag is null,'Y',b.active_flag) end) AS active_flag,a.is_supplier AS is_supplier,a.purity_name AS purity_name,if(b.license_desc is null,a.license_desc,b.license_desc) AS license_desc,
         b.jdrq   AS create_date
from t_customer a join t_child_customer b on a.customer_identity = b.customer_identity
                                                                                         ) t1
left join t_fast_customer t2 on t1.customer_identity = t2.customer_identity
left join t_delay_region t3 on t1.province_name = t3.province
left join t_bf_area t4 on if(t2.area_identity is null,t3.area_identity,t2.area_identity) = t4.area_identity
 )t1;








load data inpath '/test_zfq_decent_cloud/t_estimate_update_log/2022-12-12' into table t_estimate_update_log partition (dt='2022-12-12');

select count(*) from t_estimate_update_log ;

show  databases ;
use zfq_test_decent_cloud;
desc formatted  t_work_fee_detail;
select replace('1_2_3_4_2_5','_',',');
select   split('1_2_3_4_2_5','_')  ;



select * from  t_bf_area;
select * from t_bf_bank_deposit_bill_sz;
truncate table t_bf_bank_deposit_bill_sz_detail;
truncate table t_bf_buy_cus_item;
truncate table t_bf_buy_cus_item_detail;
truncate table t_bf_buy_cus_material;
truncate table t_bf_buyback_material;
truncate table t_bf_change_outsource;
truncate table t_bf_cus_credit_receipt;
truncate table t_bf_cus_debit_receipt;
truncate table t_bf_cust_return_jewelry;
truncate table t_bf_cust_return_jewelry_detail;
truncate table t_bf_customer_the_bill;
truncate table t_bf_dkhhy_b;
truncate table t_bf_dkhhy_h;
truncate table t_bf_gold_transfer_in;
truncate table t_bf_gold_transfer_out;
truncate table t_bf_gold_transfer_out_detail;
truncate table t_bf_gold_transfer_out_print;
truncate table t_bf_gold_transfer_out_print_detail;
truncate table t_bf_pay_cus_material;
truncate table t_bf_pay_cus_material_detail;
truncate table t_bf_pay_outsource;
truncate table t_bf_payment_order;
truncate table t_bf_raw_material;
truncate table t_bf_receive_meterial;
truncate table t_bf_receive_meterial_detail;
truncate table t_bf_repair;
truncate table t_bf_retreat;
truncate table t_bf_settlement;
truncate table t_bf_settlement_adjustment_price;
truncate table t_bf_stock_transfer_bill;
truncate table t_bf_szztgzspd;
truncate table t_bf_szztgzspd_detail;
truncate table t_bf_the_bill;
truncate table t_bf_weighing_form_check;
truncate table t_child_customer;
truncate table t_customer;
truncate table t_delay_region;
truncate table t_fast_customer;
truncate table t_fast_package;
truncate table t_fast_package_i;
truncate table t_fast_package_i_product;
truncate table t_finance_customer_relation;
truncate table t_gf_area_customer;
truncate table t_ka_lllsz;
truncate table t_ka_lscqmxb_b;
truncate table t_ka_lscqmxb_h;
truncate table t_ka_splsz;
truncate table t_ka_szdzsqdh;
truncate table t_ka_szkhcqlxzz_b;
truncate table t_ka_szkhcqlxzz_h;
truncate table t_ka_szkhcqlxzzfb_h;
truncate table t_ka_szkhcqmx_h;
truncate table t_ka_szlxjsrq;
truncate table t_ka_yfllsz;
truncate table t_ka_yflsz;
truncate table t_ka_yslsz;
truncate table t_ka_ysmxz_b;
truncate table t_ka_ysmxz_h;
truncate table t_ka_zrye;
truncate table t_ka_ztkcrzz;
truncate table t_move_counter;
truncate table t_purity;
truncate table t_receive;
truncate table t_sale_from;
truncate table t_sale_from_account_detail;
truncate table t_sale_from_detail;
truncate table t_sales_return;
truncate table t_showroom;
truncate table t_showroom_counter;
truncate table t_technology_purity;

select * from  t_bf_area;
select * from t_bf_bank_deposit_bill_sz;
select * from t_bf_bank_deposit_bill_sz_detail;
select * from t_bf_buy_cus_item;
select * from t_bf_buy_cus_item_detail;
select * from t_bf_buy_cus_material;
select * from t_bf_buyback_material;
select * from t_bf_change_outsource;
select * from t_bf_cus_credit_receipt;
select * from t_bf_cus_debit_receipt;
select * from t_bf_cust_return_jewelry;
select * from t_bf_cust_return_jewelry_detail;
select * from t_bf_customer_the_bill;
select * from t_bf_dkhhy_b;
select * from t_bf_dkhhy_h;
select * from t_bf_gold_transfer_in;
select * from t_bf_gold_transfer_out;
select * from t_bf_gold_transfer_out_detail;
select * from t_bf_gold_transfer_out_print;
select * from t_bf_gold_transfer_out_print_detail;
select * from t_bf_pay_cus_material;
select * from t_bf_pay_cus_material_detail;
select * from t_bf_pay_outsource;
select * from t_bf_payment_order;
select * from t_bf_raw_material;
select * from t_bf_receive_meterial;
select * from t_bf_receive_meterial_detail;
select * from t_bf_repair;
select * from t_bf_retreat;
select * from t_bf_settlement;
select * from t_bf_settlement_adjustment_price;
select * from t_bf_stock_transfer_bill;
select * from t_bf_szztgzspd;
select * from t_bf_szztgzspd_detail;
select * from t_bf_the_bill;
select * from t_bf_weighing_form_check;
select * from t_child_customer;
select * from t_customer;
select * from t_delay_region;
select * from t_fast_customer;
select * from t_fast_package;
select * from t_fast_package_i;
select * from t_fast_package_i_product;
select * from t_finance_customer_relation;
select * from t_gf_area_customer;
select * from t_ka_lllsz;
select * from t_ka_lscqmxb_b;
select * from t_ka_lscqmxb_h;
select * from t_ka_splsz;
select * from t_ka_szdzsqdh;
select * from t_ka_szkhcqlxzz_b;
select * from t_ka_szkhcqlxzz_h;
select * from t_ka_szkhcqlxzzfb_h;
select * from t_ka_szkhcqmx_h;
select * from t_ka_szlxjsrq;
select * from t_ka_yfllsz;
select * from t_ka_yflsz;
select * from t_ka_yslsz;
select * from t_ka_ysmxz_b;
select * from t_ka_ysmxz_h;
select * from t_ka_zrye;
select * from t_ka_ztkcrzz;
select * from t_move_counter;
select * from t_purity;
select * from t_receive;
select * from t_sale_from;
select * from t_sale_from_account_detail;
select * from t_sale_from_detail;
select * from t_sales_return;
select * from t_showroom;
select * from t_showroom_counter;
select * from t_technology_purity;

alter table t_technology_purity drop partition(dt='2022-12-13');

load data  inpath '/test_zfq_decent_cloud/t_late_transfer_log/2022-12-14' into table  t_late_transfer_log partition (dt='2022-12-14');


drop database sz_new_report;



show tables ;


truncate table t_fast_package_operation_log;

select * from t_work_fee_detail ;

truncate table t_late_transfer_log;













select t1.wdmc AS wdmc,t1.customer_identity AS customer_identity,t1.customer_code AS customer_code,t1.customer_name AS customer_name,t1.parent_customer_code AS parent_customer_code,t1.parent_customer_name AS parent_customer_name,t1.child_customer_name AS child_customer_name,t1.area_name AS area_name,t1.province_name AS province_name,t1.city_name AS city_name,t1.county_name AS county_name,t1.child_customer_code AS child_customer_code,t1.is_child AS is_child,t1.active_flag AS active_flag,t1.is_supplier AS is_supplier,t1.purity_name AS purity_name,t1.license_desc AS license_desc,  area_name_business,t1.create_date AS create_date, technology_purity_identity AS technology_purity_identity from
 (
  select t1.*,t4.area_name as area_name_business, t2.technology_purity_identity from (
      select t_customer.branch_name AS wdmc,t_customer.customer_identity AS customer_identity,t_customer.customer_code AS customer_code,t_customer.customer_name AS customer_name,t_customer.customer_code AS parent_customer_code,t_customer.customer_name AS parent_customer_name,'' AS child_customer_name,t_customer.area_name AS area_name,t_customer.province AS province_name,t_customer.city_code AS city_name,t_customer.county_desc AS county_name,'' AS child_customer_code,0 AS is_child,t_customer.active_flag AS active_flag,t_customer.is_supplier AS is_supplier,t_customer.purity_name AS purity_name,t_customer.license_desc AS license_desc,cast(t_customer.create_date as date) AS create_date from t_customer union all select a.branch_name AS wdmc,b.child_customer_identity AS customer_identity,concat(a.customer_code,lpad(b.child_customer_seq,4,'0')) AS customer_code,b.child_customer_name AS customer_name,a.customer_code AS parent_customer_code,a.customer_name AS parent_customer_name,b.child_customer_name AS child_customer_name,a.area_name AS area_name,if(b.province is null,a.province,b.province) AS province_name,a.city_code AS city_name,a.county_desc AS county_name,b.child_customer_code AS child_customer_code,1 AS is_child,(case when (if(a.active_flag is null,'Y',a.active_flag) = 'N') then 'N' else if(b.active_flag is null,'Y',b.active_flag) end) AS active_flag,a.is_supplier AS is_supplier,a.purity_name AS purity_name,if(b.license_desc is null,a.license_desc,b.license_desc) AS license_desc,
         b.jdrq   AS create_date
from t_customer a join t_child_customer b on a.customer_identity = b.customer_identity
                                                                                 ) t1
left join t_fast_customer t2 on t1.customer_identity = t2.customer_identity
left join t_delay_region t3 on t1.province_name = t3.province
left join t_bf_area t4 on if(t2.area_identity is null,t3.area_identity,t2.area_identity
     ) = t4.area_identity
 )t1;


select
a.province as sf,
a.area_identity as id ,
b.area_name as qymc
from (select province,area_identity,max(dt) as max_dt from t_delay_region  where dt is not null group by province, area_identity)a
inner join t_bf_area b
on a.area_identity = b.area_identity and max_dt=b.dt
where status = 0 and b.dt is not null;

desc formatted t_bf_area;

select * from customer_area;

desc formatted customer_area;


select a.customer_identity,
	      b.area_name as qymc
	 from t_fast_customer a
	inner join t_bf_area b
   	on a.area_identity = b.area_identity and a.dt='2022-12-15' and b.dt='2022-12-15'
		where a.customer_identity not in(select customer_identity from t_gf_area_customer where dt='2022-12-15')
union all
select a.customer_identity,
	      b.area_name as qymc
	 from t_gf_area_customer a
	inner join t_bf_area b
   	on a.area_identity = b.area_identity and a.dt='2022-12-15' and b.dt='2022-12-15';


select * from customer_area_02;



		select t1.customer_identity,
				t1.customer_code,
				t1.customer_name,
				t3.province,
				case when t1.parent_customer_identity is null then t1.customer_name else t2.customer_name end as parent_customer_name,
				case when t1.parent_customer_identity is not null then t1.customer_name else null end as child_customer_name
		 from t_fast_customer t1
		left join t_fast_customer t2 on t1.parent_customer_identity = t2.customer_identity and (t1.dt='2022-12-15' and t2.dt='2022-12-15')
		left join t_customer t3 on t1.customer_identity=t3.customer_identity and (t1.dt='2022-12-15' and t3.dt='2022-12-15');



select
			t1.customer_identity,
 			-- ifnull(n.area_name,tt.area_name) as pqmc,
			'客户已停用或未分省' as qymc,
			t2.province_name as sjxqmc,
			t2.area_name as pqmc,
			t2.parent_customer_name as khmc,
			t2.child_customer_name as zkh ,
			sum(t3.drdqjz + t3.drwdqjz) as qlzl,
			sum(ifnull(t3.drdqzk,0) + ifnull(t3.drlx,0)+ifnull(t3.drwdqzk,0)+ifnull(t3.bygf,0)) as qlzlq
from t_ka_lscqmxb_h t1
inner join view_customer t2 on t1.customer_identity = t2.customer_identity
inner join t_ka_lscqmxb_b t3 on t1.lscqmxb_h_identity = t3.lscqmxb_h_identity
where t3.rq= DATE_SUB('2022-12-15',INTERVAL 1 day )
and t1.wdmc='深圳展厅'
-- and t2.parent_customer_name like '%展销%'
				 and t2.customer_name<>'港福珠宝（深圳）有限公司展销'
				 and ifnull(t2.parent_customer_name,'') <> '展销称差'
         and ifnull(t2.parent_customer_name,'') <> '展销称差（万足）'
				 and ifnull(t2.customer_name,'') <> '展销多金'
         and (ifnull(t2.parent_customer_name,'') like '%展销%'
         or ifnull(t2.parent_customer_name,'') like '%展'

         or ifnull(t2.parent_customer_name,'') like '%展(jds)'
         or ifnull(t2.parent_customer_name,'') like '%展(999.99)'
         or ifnull(t2.parent_customer_name,'') like '中金直营%'
         or ifnull(t2.parent_customer_name,'') like '中金入系统%'
         or ifnull(t2.parent_customer_name,'') like '上海pr订单%'
         or ifnull(t2.parent_customer_name,'') like '上海老庙po订单%'
         or ifnull(t2.parent_customer_name,'') like '老庙深圳办%'
         or ifnull(t2.parent_customer_name,'') like '非rfid%'
				 or ifnull(t2.parent_customer_name,'') like '%(暂代)%' -- 新加挂账个人
				 or t2.parent_customer_name in('陈世平','朱暹','翟娜','赵士鹏','郑导松','向昆仑','钱明铸','彭双霞','周建军','刘生智','邓嘉杰','韩锋')
				 )
group by t1.customer_identity, t2.parent_customer_name, t2.child_customer_name  ;






select t1.wdmc AS wdmc,t1.customer_identity AS customer_identity,t1.customer_code AS customer_code,t1.customer_name AS customer_name,t1.parent_customer_code AS parent_customer_code,t1.parent_customer_name AS parent_customer_name,t1.child_customer_name AS child_customer_name,t1.area_name AS area_name,t1.province_name AS province_name,t1.city_name AS city_name,t1.county_name AS county_name,t1.child_customer_code AS child_customer_code,t1.is_child AS is_child,t1.active_flag AS active_flag,t1.is_supplier AS is_supplier,t1.purity_name AS purity_name,t1.license_desc AS license_desc,  area_name_business,t1.create_date AS create_date, technology_purity_identity AS technology_purity_identity from
 (
  select t1.*,t4.area_name as area_name_business, t2.technology_purity_identity from (
      select t_customer.branch_name AS wdmc,t_customer.customer_identity AS customer_identity,t_customer.customer_code AS customer_code,t_customer.customer_name AS customer_name,t_customer.customer_code AS parent_customer_code,t_customer.customer_name AS parent_customer_name,'' AS child_customer_name,t_customer.area_name AS area_name,t_customer.province AS province_name,t_customer.city_code AS city_name,t_customer.county_desc AS county_name,'' AS child_customer_code,0 AS is_child,t_customer.active_flag AS active_flag,t_customer.is_supplier AS is_supplier,t_customer.purity_name AS purity_name,t_customer.license_desc AS license_desc,cast(t_customer.create_date as date) AS create_date from t_customer union all select a.branch_name AS wdmc,b.child_customer_identity AS customer_identity,concat(a.customer_code,lpad(b.child_customer_seq,4,'0')) AS customer_code,b.child_customer_name AS customer_name,a.customer_code AS parent_customer_code,a.customer_name AS parent_customer_name,b.child_customer_name AS child_customer_name,a.area_name AS area_name,if(b.province is null,a.province,b.province) AS province_name,a.city_code AS city_name,a.county_desc AS county_name,b.child_customer_code AS child_customer_code,1 AS is_child,(case when (if(a.active_flag is null,'Y',a.active_flag) = 'N') then 'N' else if(b.active_flag is null,'Y',b.active_flag) end) AS active_flag,a.is_supplier AS is_supplier,a.purity_name AS purity_name,if(b.license_desc is null,a.license_desc,b.license_desc) AS license_desc,
         b.jdrq   AS create_date
from t_customer a join t_child_customer b on a.customer_identity = b.customer_identity where a.dt='2022-12-15' and b.dt='2022-12-15'
                                                                                         ) t1
left join(select customer_identity,technology_purity_identity,area_identity,max(dt) as max_dt from t_fast_customer group by customer_identity,area_identity,technology_purity_identity)t2 on t1.customer_identity = t2.customer_identity
left join(select province,area_identity,max(dt) as max_dt from t_delay_region group by province,area_identity)  t3 on t1.province_name = t3.province
left join(select area_identity,area_name,max(dt) as max_dt from t_bf_area group by area_identity,area_name) t4 on if(t2.area_identity is null,t3.area_identity,t2.area_identity) = t4.area_identity
 )t1;

select area_identity,max(dt) as max_dt from t_bf_area group by area_identity;

SELECT CASE WHEN CKMC = '镶嵌Q柜'  OR CKMC = '镶嵌硬金柜'OR CKMC = '镶嵌柜-德钰东方' or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓'
      THEN '千足嵌'
            WHEN (JSMC = '千足硬金') AND CKMC <> '镶嵌Q柜'
      AND CKMC <> '镶嵌硬金柜'AND CKMC <> '镶嵌柜-德钰东方'
      AND ckmc <> '客单组镶嵌德钰东方' AND ckmc <> '客单组镶嵌柜'
      AND CKMC <> '维修仓' AND CKMC <> '古法金柜'
      AND CKMC <> '精品G柜' AND CKMC <> '硬金古法金柜' -- and ckmc not in ( '硬金A柜','硬金B柜','硬金精品C柜','硬金精品D柜')
      and ckmc <> '无字印柜'
      and ckmc <> '客单组'
      and ckmc <> '配货中心'
      THEN '千足金'
            WHEN CKMC in ('料仓')
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
    WHEN CKMC in ('料仓')
    THEN CONCAT('料仓-', JSMC)
    ELSE CKMC
   END AS CKMC,
       QCJZ AS QC,
       QCJS AS QCJS,
       QCJE AS QCJE,
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
   FROM T_KA_ZTKCRZZ
 WHERE WDMC = '深圳展厅' and dt='2022-12-15'
    AND RQ = '2022-12-15'
   AND (JSMC NOT LIKE '虚拟金料%');
show tables ;

use zfq_test_decent_cloud;

select * from view_customer;




drop table customer_area;
drop table view_customer;

drop table customer_area_02;



truncate table t_daily_interrest_err_log;
truncate table t_daily_interrest_log;
truncate table t_estimate_update_log;
truncate table t_history_data_move_log;
truncate table t_late_transfer_log;
truncate table t_login_log;
truncate table t_cpbszb_log;
truncate table t_cpbszh_log;
truncate table t_cover_customer_log;
truncate table t_wechat_message_log;
truncate table t_stored_procedure_log;
truncate table t_splszh_log;
truncate table t_salesman_choose_log;
truncate table t_download;
truncate table t_insert_log_fail;
truncate table t_b_menu;
truncate table t_approve_record;
truncate table rp_szztxsrb;
truncate table t_basic_purity;
truncate table t_bf_account_type_category;
truncate table t_bf_allocate_transfer;
truncate table t_bf_allocation_fee;


















select wdmc,customer_identity, khbm, khmc, zkhmc, pqmc, sjxqmc, djsxx, sxqxx, khbh,'客户信息不存在或客户已禁用' as qy
  from (select branch_name as wdmc,
               customer_identity as customer_identity,
               customer_code as khbm,
               customer_name as khmc,
               '' as zkhmc,
               area_name as pqmc,
               province as sjxqmc,
               city_code as djsxx,
               county_desc as sxqxx,
               '' as khbh
          from t_customer
         where dt='2022-12-15' and if(active_flag is null, 'Y',active_flag) ='Y'
         union all
        select branch_name as wdmc,
               b.child_customer_identity as customer_identity,
               concat(a.customer_code, lpad(b.child_customer_seq, 4,'0')) as khbm,
               a.customer_name as khmc,
               b.child_customer_name as zkhmc,
               a.area_name as pqmc,
               if(b.province is null, a.province,b.province) as sjxqmc,
               a.city_code as djsxx,
               a.county_desc as sxqxx,
               b.child_customer_code as khbh
          from t_customer a
         inner join t_child_customer b
            on a.customer_identity = b.customer_identity
         where a.dt='2022-12-15' and b.dt='2022-12-15' and if(a.active_flag is null, 'Y',a.active_flag) = 'Y'
           and if(b.active_flag is null, 'Y',b.active_flag) = 'Y'
        ) a;

select * from ods_view_customer
;
show databases ;
use zfq_test_decent_cloud;
alter table t_bf_area drop partition(dt='2022-12-16');



select t1.wdmc AS wdmc,t1.customer_identity AS customer_identity,t1.customer_code AS customer_code,t1.customer_name AS customer_name,t1.parent_customer_code AS parent_customer_code,t1.parent_customer_name AS parent_customer_name,t1.child_customer_name AS child_customer_name,t1.area_name AS area_name,t1.province_name AS province_name,t1.city_name AS city_name,t1.county_name AS county_name,t1.child_customer_code AS child_customer_code,t1.is_child AS is_child,t1.active_flag AS active_flag,t1.is_supplier AS is_supplier,t1.purity_name AS purity_name,t1.license_desc AS license_desc,  area_name_business,t1.create_date AS create_date, technology_purity_identity AS technology_purity_identity from
 (
  select t1.*,t4.area_name as area_name_business, t2.technology_purity_identity from (
      select t_customer.branch_name AS wdmc,t_customer.customer_identity AS customer_identity,t_customer.customer_code AS customer_code,t_customer.customer_name AS customer_name,t_customer.customer_code AS parent_customer_code,t_customer.customer_name AS parent_customer_name,'' AS child_customer_name,t_customer.area_name AS area_name,t_customer.province AS province_name,t_customer.city_code AS city_name,t_customer.county_desc AS county_name,'' AS child_customer_code,0 AS is_child,t_customer.active_flag AS active_flag,t_customer.is_supplier AS is_supplier,t_customer.purity_name AS purity_name,t_customer.license_desc AS license_desc,cast(t_customer.create_date as date) AS create_date from t_customer union all select a.branch_name AS wdmc,b.child_customer_identity AS customer_identity,concat(a.customer_code,lpad(b.child_customer_seq,4,'0')) AS customer_code,b.child_customer_name AS customer_name,a.customer_code AS parent_customer_code,a.customer_name AS parent_customer_name,b.child_customer_name AS child_customer_name,a.area_name AS area_name,if(b.province is null,a.province,b.province) AS province_name,a.city_code AS city_name,a.county_desc AS county_name,b.child_customer_code AS child_customer_code,1 AS is_child,(case when (if(a.active_flag is null,'Y',a.active_flag) = 'N') then 'N' else if(b.active_flag is null,'Y',b.active_flag) end) AS active_flag,a.is_supplier AS is_supplier,a.purity_name AS purity_name,if(b.license_desc is null,a.license_desc,b.license_desc) AS license_desc,
         b.jdrq   AS create_date
from t_customer a join t_child_customer b on a.customer_identity = b.customer_identity where a.dt='2022-12-16' and b.dt='2022-12-16'
                                                                                         ) t1
left join(select customer_identity,technology_purity_identity,area_identity,max(dt) as max_dt from t_fast_customer group by customer_identity,area_identity,technology_purity_identity)t2 on t1.customer_identity = t2.customer_identity
left join(select province,area_identity,max(dt) as max_dt from t_delay_region group by province,area_identity)  t3 on t1.province_name = t3.province
left join(select area_identity,area_name,max(dt) as max_dt from t_bf_area group by area_identity,area_name) t4 on if(t2.area_identity is null,t3.area_identity,t2.area_identity) = t4.area_identity
 )t1
group by t1.wdmc ,t1.customer_identity,t1.customer_code ,t1.customer_name ,t1.parent_customer_code ,t1.parent_customer_name,t1.child_customer_name ,t1.area_name,t1.province_name ,t1.city_name,t1.county_name,t1.child_customer_code,t1.is_child,t1.active_flag ,t1.is_supplier ,t1.purity_name, t1.license_desc  , area_name_business,t1.create_date , technology_purity_identity
;

select * from ods_customer_area_02;




select '短信五' as message,concat(
                                month("2022-12-16"),"月",
                                day("2022-12-16"),"日",
                                ":今日柜台现金收入:",sr,"万",
                                " 业务外面收入:",sr1,"万",
                                " 合计:",sr2,"万"
                                )
    from (
   select sum(sr)/10000  as sr,sum(sr1)/10000 as  sr1,sum(sr2)/10000 as  sr2
from (
   select IF(SUM(total_price) is null,0,SUM(total_price)) as sr,0.000 as sr1,0.000 as sr2
 from t_bf_cus_debit_receipt where dt='2022-12-16' and date_format(rq,'yyyy-MM-dd')='2022-12-16' and showroom_name='深圳展厅' and IF(today_settle is null ,0,today_settle)=1 and approve_status=1 and `status`=0
union all
select 0.000 as sr,IF(SUM(total_price) is null,0,SUM(total_price)) as sr1,0.000 as sr2
 from t_bf_cus_debit_receipt where dt='2022-12-16' and date_format(rq,'yyyy-MM-dd')='2022-12-16' and showroom_name='深圳展厅' and IF(today_settle is null ,0,today_settle)=0 and approve_status=1 and `status`=0
union all
select 0.000 as sr,0.000 as sr1,IF(SUM(total_price) is null,0,SUM(total_price)) as sr2
 from t_bf_cus_debit_receipt where dt='2022-12-16' and date_format(rq,'yyyy-MM-dd')='2022-12-16' and showroom_name='深圳展厅' and  approve_status=1 and `status`=0
    )t
        )m

;













select '短信五' as message,concat(month("$dt"),"月",day("$dt"),"日",
                                ":今日柜台现金收入:",sr,"万",
                                "业务外面收入:",sr1,"万",
                                "合计:",sr2,"万"
                                ) as mc
    from (
   select sum(sr)/10000  as sr,sum(sr1)/10000 as  sr1,sum(sr2)/10000 as  sr2
from (
   select IF(SUM(total_price) is null,0,SUM(total_price)) as sr,0.000 as sr1,0.000 as sr2
 from t_bf_cus_debit_receipt where dt='2022-12-17' and date_format(rq,'yyyy-MM-dd')='2022-12-17' and showroom_name='深圳展厅' and IF(today_settle is null ,0,today_settle)=1 and approve_status=1 and status=0
union all
select 0.000 as sr,IF(SUM(total_price) is null,0,SUM(total_price)) as sr1,0.000 as sr2
 from t_bf_cus_debit_receipt where dt='2022-12-17' and date_format(rq,'yyyy-MM-dd')='2022-12-17' and showroom_name='深圳展厅' and IF(today_settle is null ,0,today_settle)=0 and approve_status=1 and status=0
union all
select 0.000 as sr,0.000 as sr1,IF(SUM(total_price) is null,0,SUM(total_price)) as sr2
 from t_bf_cus_debit_receipt where dt='2022-12-17' and date_format(rq,'yyyy-MM-dd')='2022-12-17' and showroom_name='深圳展厅' and  approve_status=1 and status=0
    )t
        )m

;


 alter table ads_gn_szzt_pjlj drop partition(dt='2022-12-18');


create table IF NOT EXISTS ads_cx_zt_dxbb2_sz (message string,mc string) partitioned by (dt string) location '/zfq_test_decent_cloud/ads_cx_zt_dxbb2_sz';

select * from ads_cx_zt_dxbb2_sz;



select '销售单' as djm,  sum(jz) as jz , round(sum(je), 2) as  je ,round(sum(je)/sum(jz), 2) as dj  from (
SELECT
				sum(gold_weight)as jz,
        sum(gold_income)  as je
FROM
        t_sale_from t1
        LEFT JOIN t_sale_from_account_detail t2 ON t1.sale_identity = t2.sale_identity and t2.status = 0
WHERE
        t1.approve_status = 1
				and t1.`status`=0
        AND date_format(t1.bill_date,'yyyy-MM-dd')='2022-12-16'
        and t2.account_method = '结价'
        and sale_type='SP'
        and t1.dt='2022-12-16'
        and t2.dt='2022-12-16'
)a;

select * from ods_gn_szzt_pjlj_temp_resault_2
UNION ALL
select * from ods_gn_szzt_pjlj_temp_resault_1
union all
select * from ods_gn_szzt_pjlj_temp_resault_3

;



select '结价单' as djm,  sum(jz) as jz , round(sum(je), 2) as  je , round(sum(je)/sum(jz), 2)  as dj  from (
select a.purity_name , sum(settlement_weight ) as  jz , sum(settlement_price-settlement_weight * (b.full_gold_price+b.other_price)) as je
from  t_bf_settlement a,t_bf_settlement_adjustment_price b
where  a.showroom_name = '深圳展厅' and a.purity_name = b.purity_name and  date_format(a.rq,'yyyy-MM-dd')= '2022-12-16'  and  a.genus_name = '饰品'  and  a.purity_name = '千足金' and b.genus_name = '素金' and b.status=0 and a.dt='2022-12-16' and b.dt='2022-12-16'
group by  a.purity_name)a;










select a.purity_name , sum(settlement_weight ) as  jz , sum(settlement_price-settlement_weight * (b.full_gold_price+b.other_price)) as je
from  t_bf_settlement a,t_bf_settlement_adjustment_price b
where  a.showroom_name = '深圳展厅' and a.purity_name = b.purity_name and  date_format(a.rq,'yyyy-MM-dd')= '2022-12-16'   and  a.genus_name = '饰品'  and  a.purity_name = '金9999' and b.status=0 and a.dt='2022-12-16' and b.dt='2022-12-16'
group by  a.purity_name;


select a.purity_name , sum(settlement_weight ) as  jz , sum(settlement_price-settlement_weight * (b.full_gold_price+b.other_price)) as je
from  t_bf_settlement a,t_bf_settlement_adjustment_price b
where  a.showroom_name = '深圳展厅' and a.purity_name = b.purity_name and  date_format(a.rq,'yyyy-MM-dd')= '2022-12-16' and  a.genus_name = '饰品'  and  a.purity_name = '古法金' and b.status=0 and a.dt='2022-12-16' and b.dt='2022-12-16'
group by  a.purity_name;


select a.purity_name , sum(settlement_weight ) as  jz , sum(settlement_price) as je
from  t_bf_settlement a
where  a.showroom_name = '深圳展厅' and date_format(a.rq,'yyyy-MM-dd')= '2022-12-16' and  a.genus_name = '金料' and a.dt='2022-12-16'
group by  a.purity_name;


select '购存料单' as djm,   sum(jz) as jz , round(sum(je), 2) as je,round(sum(je)/sum(jz), 2) as dj from (select a.purity_name , sum(settlement_weight) as  jz , sum(settlement_price-settlement_weight * (b.full_gold_price+b.other_price)) as je
from  t_bf_buyback_material a,t_bf_settlement_adjustment_price b
where  showroom_name = '深圳展厅' and a.purity_name = b.purity_name and date_format(a.rq,'yyyy-MM-dd')= '2022-12-16' and  a.genus_name = '饰品'  and  a.purity_name = '千足金' and b.genus_name = '素金'  and b.status=0 and a.dt='2022-12-16'  and b.dt='2022-12-16'
group by  a.purity_name)a ;


create table IF NOT EXISTS ads_gn_szzt_pjlj(djm string,jz decimal(18,3),je decimal(18,3),dj decimal(18,3)) partitioned by (dt string) location '/zfq_test_decent_cloud/ads_gn_szzt_pjlj';


select *
from ads_gn_szzt_pjlj;

select * from ads_cx_zt_dxbb2_sz;


drop  table ads_cx_sz_cpbcx_hpl;
create table IF NOT EXISTS ads_cx_sz_cpbcx_hpl(create_time string,csmc string,plmc string,yjpl string,ejpl string,js decimal(18,3),zl decimal(18,3),je decimal(18,3),type string) partitioned by (dt string) location '/zfq_test_decent_cloud/ads_cx_sz_cpbcx_hpl';
select *
from ads_cx_sz_cpbcx_hpl;

use zfq_test_decent_cloud;

select * from ads_gn_szzt_pjlj;


 alter table ads_gn_szzt_pjlj drop partition(dt='2022-12-18');












select * from ods_view_customer;







select
			 t4.customer_identity,
			 t4.customer_code as khbm,
			 t4.customer_name as customer_name,
			 t4.child_customer_name as zkh,
			 sum(if(total_gold_weight is null, 0,total_gold_weight))as sale_weight,
       sum(if(total_price is null, 0,total_price))as sale_weightq
from t_sale_from t1
inner join (select customer_identity,customer_code,customer_name,'' child_customer_name from t_customer union all
           select a.child_customer_identity as customer_identity,b.customer_code,b.customer_name,a.child_customer_name from t_child_customer a
					 inner join t_customer b on a.customer_identity = b.customer_identity ) t4
					 on t1.settle_accounts_identity = t4.customer_identity
         where date_format(bill_date,'yyyy-MM-dd') = '2022-12-19'
				 and t1.approve_status = 1
				 and t1.status = 0
		 and t4.customer_name<>'港福珠宝（深圳）有限公司展销'
		 and if(t4.customer_name is null,'',t4.customer_name) <> '展销称差'
         and if(t4.customer_name is null,'',t4.customer_name) <> '展销称差（万足）'
		 and if(t4.customer_name is null,'',t4.customer_name) <> '展销多金'
         and if(t4.customer_name is null,'',t4.customer_name) like '%展销%'
         or if(t4.customer_name is null,'',t4.customer_name) like '%展'
         or if(t4.customer_name is null,'',t4.customer_name) like '%展(jds)'
         or if(t4.customer_name is null,'',t4.customer_name) like '%展(999.99)'
         or if(t4.customer_name is null,'',t4.customer_name) like '中金直营%'
         or if(t4.customer_name is null,'',t4.customer_name) like '中金入系统%'
         or if(t4.customer_name is null,'',t4.customer_name) like '上海pr订单%'
         or if(t4.customer_name is null,'',t4.customer_name) like '上海老庙po订单%'
         or if(t4.customer_name is null,'',t4.customer_name) like '老庙深圳办%'
         or if(t4.customer_name is null,'',t4.customer_name) like '非rfid%'
		 or if(t4.customer_name is null,'',t4.customer_name) like '%(暂代)%' -- 新加挂账个人
		 or t4.customer_name in('陈世平','朱暹','翟娜','赵士鹏','郑导松','向昆仑','钱明铸','彭双霞','周建军','刘生智','邓嘉杰','韩锋')
				 and t1.showroom_name = '深圳展厅'
				 group by t4.customer_identity
			 ;
select * from ods_customer_area;










select
			t1.customer_identity,
           '客户已停用或未分省' as qymc,
			t2.province_name as sjxqmc,
		    t2.area_name as pqmc,
			t2.parent_customer_name as khmc,
			t2.child_customer_name as zkh ,
			sum(t3.drdqjz + t3.drwdqjz) as qlzl,
			sum(if(t3.drdqzk is null ,0,t3.drdqzk) + if(t3.drlx is null,0,t3.drlx)+if(t3.drwdqzk is null ,0,t3.drwdqzk)+if(t3.bygf is null,0,t3.bygf)) as qlzlq
from t_ka_lscqmxb_h t1
inner join ods_view_customer t2 on t1.customer_identity = t2.customer_identity
inner join t_ka_lscqmxb_b t3 on t1.lscqmxb_h_identity = t3.lscqmxb_h_identity
where date_format(t3.rq,'yyyy-MM-dd')= DATE_SUB(date_format('2022-12-19','yyyy-MM-dd'), 1)
and t1.wdmc='深圳展厅' and t1.dt='2022-12-19'  and t3.dt='2022-12-19'
 		 and t2.customer_name<>'港福珠宝（深圳）有限公司展销'
		 and if(t2.parent_customer_name is null,'',t2.parent_customer_name) <> '展销称差'
         and if(t2.parent_customer_name is null,'',t2.parent_customer_name) <> '展销称差（万足）'
		 and if(t2.customer_name is null,'',t2.parent_customer_name) <> '展销多金'
         and (if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%展销%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%展'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%展(jds)'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%展(999.99)'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '中金直营%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '中金入系统%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '上海pr订单%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '上海老庙po订单%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '老庙深圳办%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '非rfid%'
		 or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%(暂代)%' -- 新加挂账个人
		 or t2.parent_customer_name in('陈世平','朱暹','翟娜','赵士鹏','郑导松','向昆仑','钱明铸','彭双霞','周建军','刘生智','邓嘉杰','韩锋')
		 )
group by t1.customer_identity, t2.parent_customer_name, t2.child_customer_name,t2.province_name,t2.area_name
;
desc formatted ods_zx_area_new_store_date;

select customer_identity,b.qymc,sjxqmc,pqmc,khmc,zkh,qlzl,qlzlq
 from ods_zx_area_new_store_date a ,ods_customer_area b where a.sjxqmc=b.sf ;


select date_sub('2022-12-19',1);
select * from ods_customer_area_02;

select b.customer_identity,b.qymc,sjxqmc,pqmc,khmc,zkh,qlzl,qlzlq
 from ods_zx_area_new_store_date_new a,ods_customer_area_02 b where a.customer_identity=b.customer_identity;


 alter table t_bf_area drop partition(dt='2022-12-20');



select * from ods_zx_area_new_store_date;

desc formatted ods_zx_area_new_store_date_new_result;


select customer_identity,
qymc,
sjxqmc,
pqmc,
khmc,
zkh,
qlzl,
qlzlq
from ods_zx_area_new_store_date_new_result;













select
			customer_identity,
			customer_code,
			customer_name,
			'' child_customer_name
			from t_customer  where dt='2022-12-20'
			union all
  select
	a.child_customer_identity as customer_identity,
	b.customer_code,
	b.customer_name,a.child_customer_name
	from t_child_customer a
 inner join t_customer b on a.customer_identity = b.customer_identity and a.dt='2022-12-20' and b.dt='2022-12-20';





select
			t1.customer_identity,
           '客户已停用或未分省' as qymc,
			t2.province_name as sjxqmc,
		    t2.area_name as pqmc,
			t2.parent_customer_name as khmc,
			t2.child_customer_name as zkh ,
			sum(t3.drdqjz + t3.drwdqjz) as qlzl,
			sum(if(t3.drdqzk is null ,0,t3.drdqzk) + if(t3.drlx is null,0,t3.drlx)+if(t3.drwdqzk is null ,0,t3.drwdqzk)+if(t3.bygf is null,0,t3.bygf)) as qlzlq
from t_ka_lscqmxb_h t1
inner join ods_view_customer t2 on t1.customer_identity = t2.customer_identity
inner join t_ka_lscqmxb_b t3 on t1.lscqmxb_h_identity = t3.lscqmxb_h_identity
where date_format(t3.rq,'yyyy-MM-dd')= date_sub(date_format('2022-12-20','yyyy-MM-dd'), 1)
and t1.wdmc='深圳展厅' and t1.dt='2022-12-20'  and t3.dt='2022-12-20'
 		 and t2.customer_name<>'港福珠宝（深圳）有限公司展销'
		 and if(t2.parent_customer_name is null,'',t2.parent_customer_name) <> '展销称差'
         and if(t2.parent_customer_name is null,'',t2.parent_customer_name) <> '展销称差（万足）'
		 and if(t2.customer_name is null,'',t2.parent_customer_name) <> '展销多金'
         and (if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%展销%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%展'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%展(jds)'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%展(999.99)'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '中金直营%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '中金入系统%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '上海pr订单%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '上海老庙po订单%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '老庙深圳办%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '非rfid%'
		 or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%(暂代)%' -- 新加挂账个人
		 or t2.parent_customer_name in('陈世平','朱暹','翟娜','赵士鹏','郑导松','向昆仑','钱明铸','彭双霞','周建军','刘生智','邓嘉杰','韩锋')
		 )
group by t1.customer_identity, t2.parent_customer_name, t2.child_customer_name,t2.province_name,t2.area_name
;

select * from t_ka_lscqmxb_b;





































select
			 t4.customer_identity,
			 t4.customer_code as khbm,
			 t4.customer_name as customer_name,
			 t4.child_customer_name as zkh,
			 sum(if(total_gold_weight is null, 0,total_gold_weight))as sale_weight,
             sum(if(total_price is null, 0,total_price))as sale_weightq
from t_sale_from t1
inner join (select customer_identity,customer_code,customer_name, child_customer_name from ods_zx_customer_middle ) t4
					 on t1.settle_accounts_identity = t4.customer_identity
         where date_format(bill_date,'yyyy-MM-dd') = '2022-12-20' and t1.dt='2022-12-20'
		 and t1.approve_status = 1
		 and t1.status = 0
		 and t4.customer_name<>'港福珠宝（深圳）有限公司展销'
		 and if(t4.customer_name is null,'',t4.customer_name ) <> '展销称差'
         and if(t4.customer_name is null,'',t4.customer_name ) <> '展销称差（万足）'
	     and if(t4.customer_name is null,'',t4.customer_name ) <> '展销多金'
         and (if(t4.customer_name is null,'',t4.customer_name ) like '%展销%'
         or if(t4.customer_name is null,'',t4.customer_name ) like '%展'
         or if(t4.customer_name is null,'',t4.customer_name ) like '%展(jds)'
         or if(t4.customer_name is null,'',t4.customer_name ) like '%展(999.99)'
         or if(t4.customer_name is null,'',t4.customer_name ) like '中金直营%'
         or if(t4.customer_name is null,'',t4.customer_name ) like '中金入系统%'
         or if(t4.customer_name is null,'',t4.customer_name ) like '上海pr订单%'
         or if(t4.customer_name is null,'',t4.customer_name ) like '上海老庙po订单%'
         or if(t4.customer_name is null,'',t4.customer_name ) like '老庙深圳办%'
         or if(t4.customer_name is null,'',t4.customer_name ) like '非rfid%'
		 or if(t4.customer_name is null,'',t4.customer_name ) like '%(暂代)%' -- 新加挂账个人
		 or t4.customer_name in('陈世平','朱暹','翟娜','赵士鹏','郑导松','向昆仑','钱明铸','彭双霞','周建军','刘生智','邓嘉杰','韩锋')
		) and t1.showroom_name = '深圳展厅'
   group by t4.customer_identity,t4.customer_code,t4.customer_name,t4.child_customer_name
			 ;


select
			t4.customer_identity,
			t4.customer_code as khbm,
			t4.customer_name as customer_name,
			t4.child_customer_name as zkh,
			sum(if(gold_weight_sum is null, 0,gold_weight_sum)) as return_weight,
			sum(if(work_fee_amount_sum is null, 0,work_fee_amount_sum)) as return_weightq -- 工费金额合计
from t_bf_cust_return_jewelry t1
inner join (select customer_identity,customer_code,customer_name,child_customer_name from ods_zx_customer_middle) t4
            on t1.customer_identity = t4.customer_identity
			where date_format(rq,'yyyy-MM-dd') = '2022-12-20' and t1.dt='2022-12-20'
            and approve_status = 1
			and t1.status = 0
			and t4.customer_name<>'港福珠宝（深圳）有限公司展销'
			and if(t4.customer_name is null,'',t4.customer_name ) <> '展销称差'
		    and if(t4.customer_name is null,'',t4.customer_name) <> '展销称差（万足）'
			and if(t4.customer_name is null,'',t4.customer_name) <> '展销多金'
			and (if(t4.customer_name is null,'',t4.customer_name) like '%展销%'
            or if(t4.customer_name is null,'',t4.customer_name) like '%展'
            or if(t4.customer_name is null,'',t4.customer_name) like '%展(jds)'
            or if(t4.customer_name is null,'',t4.customer_name) like '%展(999.99)'
            or if(t4.customer_name is null,'',t4.customer_name) like '中金直营%'
            or if(t4.customer_name is null,'',t4.customer_name) like '中金入系统%'
            or if(t4.customer_name is null,'',t4.customer_name) like '上海pr订单%'
            or if(t4.customer_name is null,'',t4.customer_name) like '上海老庙po订单%'
            or if(t4.customer_name is null,'',t4.customer_name) like '老庙深圳办%'
            or if(t4.customer_name is null,'',t4.customer_name) like '非rfid%'
			or if(t4.customer_name is null,'',t4.customer_name) like '%(暂代)%' -- 新加挂账个人
			or t4.customer_name in('陈世平','朱暹','翟娜','赵士鹏','郑导松','向昆仑','钱明铸','彭双霞','周建军','刘生智','邓嘉杰','韩锋')
						)
				   	and t1.showroom_name ='深圳展厅'
						group by t4.customer_identity,t4.customer_code,t4.customer_name,t4.child_customer_name
				 ;















select
			qymc,
			a.khmc,
			a.zkh,
			sum(if(qlzl is null,0,qlzl))+sum(if(sale_weight is null,0,sale_weight))-sum(if(return_weight is null,0,return_weight)) as jz,
			sum(if(qlzlq is null,0,qlzlq))+sum(if(sale_weightq is null,0,sale_weightq))-sum(if(return_weightq is null,0,return_weightq)) as je
			from ods_zx_area_new_store_data a
			left join ods_zx_area_new_sale_data b on a.customer_identity=b.customer_identity
			left join ods_zx_area_new_return_data c on a.customer_identity=c.customer_identity
		 group by a.customer_identity,qymc,a.khmc,a.zkh
			;


select
			qymc as newPqmc,
			qymc  as pqmc,
			khmc,
			case when zkh="" then khmc else zkh end as zkh,
			sum(lm) as lm,
			sum(lmq) as lmq,
			sum(zj) as zj,
			sum(zjq) as zjq,
			sum(bq) as bq,
			sum(bqq) as bqq,
			sum(lfx) as lfx,
			sum(lfxq) as lfxq,
			sum(hcl) as hcl,
			sum(hclq) as hclq,
			sum(yt) as yt,
			sum(ytq) as ytq,
			sum(zr) as zr,
			sum(zrq) as zrq,
			sum(zds) as zds,
			sum(zdsq) as zdsq,
			sum(gzgr) as gzgr,
			sum(gzgrq) as gzgrq,
			sum(lm)+sum(zj)+sum(bq)+sum(lfx)+sum(hcl)+sum(yt)+sum(zr)+sum(zds)+sum(gzgr) as hj,
			sum(lmq)+sum(zjq)+sum(bqq)+sum(lfxq)+sum(hclq)+sum(ytq)+sum(zrq)+sum(zdsq)+sum(gzgrq) as hjq
from
	(
	select
			qymc,
			khmc,
			zkh,
			case when (CONCAT(khmc,'-',zkh) like '%老庙%' or CONCAT(khmc,'-',zkh) like '%亚一%' ) then jz else 0 end lm,-- 老庙
			case when (CONCAT(khmc,'-',zkh) like '%老庙%' or CONCAT(khmc,'-',zkh) like '%亚一%' ) then je else 0 end lmq,-- 老庙
			case when (CONCAT(khmc,'-',zkh) like  '%中金%' or khmc like'%内蒙古卓然%') then jz else 0 end zj,-- 中金
			case when (CONCAT(khmc,'-',zkh) like  '%中金%' or khmc like'%内蒙古卓然%') then je else 0 end zjq,-- 中金
			case when CONCAT(khmc,'-',zkh) like '%宝庆%' then jz else 0 end bq, -- 宝庆
			case when CONCAT(khmc,'-',zkh) like '%宝庆%' then je else 0 end bqq, -- 宝庆
			case when CONCAT(khmc,'-',zkh) like '%老凤祥%' then jz else 0 end lfx, -- 老凤祥
			case when CONCAT(khmc,'-',zkh) like '%老凤祥%' then je else 0 end lfxq, -- 老凤祥
			case when CONCAT(khmc,'-',zkh) like '%荟萃楼%' then jz else 0 end hcl, -- 荟萃楼
			case when CONCAT(khmc,'-',zkh) like '%荟萃楼%' then je else 0 end hclq, -- 荟萃楼
			case when CONCAT(khmc,'-',zkh) like '%宇泰%' then jz else 0 end yt, -- 宇泰
			case when CONCAT(khmc,'-',zkh) like '%宇泰%' then je else 0 end ytq, -- 宇泰
			case when CONCAT(khmc,'-',zkh) like '%卓尔%' then jz else 0 end zr, -- 卓尔
			case when CONCAT(khmc,'-',zkh) like '%卓尔%' then je else 0 end zrq, -- 卓尔
			case when CONCAT(khmc,'-',zkh) like '%周大生%' then jz else 0 end zds, -- 宇泰
			case when CONCAT(khmc,'-',zkh) like '%周大生%' then je else 0 end zdsq, -- 宇泰
			case when CONCAT(khmc,'-',zkh) not like '%老庙%' and CONCAT(khmc,'-',zkh) not like '%亚一%' and CONCAT(khmc,'-',zkh) not like '%中金%' and CONCAT(khmc,'-',zkh) not like '%内蒙古卓然%'  and CONCAT(khmc,'-',zkh) not like '%宝庆%' and CONCAT(khmc,'-',zkh) not like '%老凤祥%' and CONCAT(khmc,'-',zkh) not like '%荟萃楼%' and CONCAT(khmc,'-',zkh) not like '%宇泰%' and CONCAT(khmc,'-',zkh) not like '%卓尔%' and CONCAT(khmc,'-',zkh) not like '%周大生%' then jz else 0 end gzgr,
			case when CONCAT(khmc,'-',zkh) not like '%老庙%' and CONCAT(khmc,'-',zkh) not like '%亚一%' and CONCAT(khmc,'-',zkh) not like '%中金%' and CONCAT(khmc,'-',zkh) not like '%内蒙古卓然%'  and CONCAT(khmc,'-',zkh) not like '%宝庆%' and CONCAT(khmc,'-',zkh) not like '%老凤祥%' and CONCAT(khmc,'-',zkh) not like '%荟萃楼%' and CONCAT(khmc,'-',zkh) not like '%宇泰%' and CONCAT(khmc,'-',zkh) not like '%卓尔%' and CONCAT(khmc,'-',zkh) not like '%周大生%' then je else 0 end gzgrq
			from ods_zx_area_new_result_data
	)t
	group by qymc,khmc,zkh  ;












create table IF NOT EXISTS ads_zx_area_new(pqmc string,khmc string,zkh string,lm decimal(18,3),lmq decimal(18,3),zj decimal(18,3),zjq decimal(18,3),bq decimal(18,3),bqq decimal(18,3),lfx decimal(18,3),lfxq decimal(18,3),hcl decimal(18,3),hclq decimal(18,3),
yt decimal(18,3),ytq decimal(18,3),zr decimal(18,3),zrq decimal(18,3),zds decimal(18,3),zdsq decimal(18,3),gzgr decimal(18,3),gzgrq decimal(18,3) ,hj decimal(18,3),hjq decimal(18,3)
                ) partitioned by (dt string) location '/zfq_test_decent_cloud/ads_zx_area_new';


use zfq_test_decent_cloud;

select * from ods_zx_area_new_store_date;


alter table ads_zx_area_new drop partition(dt='2022-12-20');







select * from t_ka_lscqmxb_h;
select
			t1.customer_identity,
           '客户已停用或未分省' as qymc,
			t2.province_name as sjxqmc,
		    t2.area_name as pqmc,
			t2.parent_customer_name as khmc,
			t2.child_customer_name as zkh ,
			sum(t3.drdqjz + t3.drwdqjz) as qlzl,
			sum(if(t3.drdqzk is null ,0,t3.drdqzk) + if(t3.drlx is null,0,t3.drlx)+if(t3.drwdqzk is null ,0,t3.drwdqzk)+if(t3.bygf is null,0,t3.bygf)) as qlzlq
from t_ka_lscqmxb_h t1
inner join ods_view_customer t2 on t1.customer_identity = t2.customer_identity
inner join t_ka_lscqmxb_b t3 on t1.lscqmxb_h_identity = t3.lscqmxb_h_identity
where date_format(t3.rq,'yyyy-MM-dd')= date_sub(date_format('2022-12-20','yyyy-MM-dd'), 1)
and t1.wdmc='深圳展厅' and t1.dt='2022-12-19'  and t3.dt='2022-12-19'
 		 and t2.customer_name<>'港福珠宝（深圳）有限公司展销'
		 and if(t2.parent_customer_name is null,'',t2.parent_customer_name) <> '展销称差'
         and if(t2.parent_customer_name is null,'',t2.parent_customer_name) <> '展销称差（万足）'
		 and if(t2.customer_name is null,'',t2.parent_customer_name) <> '展销多金'
         and (if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%展销%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%展'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%展(jds)'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%展(999.99)'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '中金直营%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '中金入系统%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '上海pr订单%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '上海老庙po订单%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '老庙深圳办%'
         or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '非rfid%'
		 or if(t2.parent_customer_name is null,'',t2.parent_customer_name) like '%(暂代)%' -- 新加挂账个人
		 or t2.parent_customer_name in('陈世平','朱暹','翟娜','赵士鹏','郑导松','向昆仑','钱明铸','彭双霞','周建军','刘生智','邓嘉杰','韩锋')
		 )
group by t1.customer_identity, t2.parent_customer_name, t2.child_customer_name,t2.province_name,t2.area_name;














use zfq_test_decent_cloud;





SELECT
	fjgf,
	sum( jz ) AS jz,
	sum( fjgfje ) AS fjgfje,
	sum( jcgf ) AS jcgf,
	csmc AS csmc,
	rq AS rq
FROM
	(
		-- 计算销售数据
		SELECT
			t2.additional_labour AS fjgf,
			sum( t2.net_weight ) AS jz,
			sum( t2.net_weight * t2.additional_labour ) AS fjgfje,
			sum( t6.jcgf * t2.net_weight ) AS jcgf,
			t5.purity_name AS csmc,
			date_format( t1.bill_date, 'yyyy-MM-dd' ) AS rq
		FROM
			t_sale_from t1
			INNER JOIN t_sale_from_detail t2 ON t1.sale_identity = t2.sale_identity AND t2.STATUS = 0 and t1.dt='2022-12-21' and t2.dt='2022-12-21'
			INNER JOIN t_fast_package_i t3 ON t3.package_i_code = t2.package_i_code and t3.dt='2022-12-21'
			INNER JOIN t_fast_package t4 ON t3.fast_package_identity = t4.fast_package_identity and t4.dt='2022-12-21'
			INNER JOIN t_purity t5 ON t1.purity_identity = t5.purity_identity and t5.dt='2022-12-21'
			INNER JOIN (
		SELECT
			sale_identity,
			round( sum( amount ) / sum( gold_weight ), 2 ) AS jcgf
		FROM
			t_sale_from_account_detail a
		WHERE
			a.account_method IN ( '转欠料', '结价' )
			AND a.STATUS = 0
		    and a.dt='2022-12-21'
		GROUP BY
			sale_identity
			) t6 ON t2.sale_identity = t6.sale_identity
		WHERE
			t1.approve_status = 1
			AND t5.purity_name IN ( '千足金' )
			AND t4.package_i_type = 'HS'
		    AND date_format(t1.bill_date,'yyyy-MM-dd') = '2022-12-21'
		GROUP BY
			t2.additional_labour,
			date_format( t1.bill_date, 'yyyy-MM-dd'),
		    t5.purity_name
		UNION ALL
		-- 计算退饰数据
		SELECT
			if( t1.attach_work_fee is null,  0,t1.attach_work_fee  ) AS fjgf,
			- sum( t1.gold_weight ) AS jz,
			- sum( if( t1.attach_work_fee_amount is null , 0 ,t1.attach_work_fee_amount) ) AS fjgfje,
			- sum( if( t1.base_work_fee_amount is null , 0, t1.base_work_fee_amount ) ) AS jcgf,
			t1.purity_name AS csmc,
			date_format( t2.approve_time, 'yyyy-MM-dd') AS rq
		FROM
			t_bf_cust_return_jewelry_detail t1
			LEFT JOIN t_bf_cust_return_jewelry t2 ON t1.return_identity = t2.return_identity
		WHERE
			t2.approve_status = 1
			AND t1.purity_name IN ( '千足金' )
			AND t2.`status` = 0
			AND t1.`status` = 0
		    and t1.dt='2022-12-21'
		    and t2.dt='2022-12-21'
			AND t2.counter_name not like  '%镶嵌%'
			AND date_format(t2.approve_time,'yyyy-MM-dd') = '2022-12-21'
		GROUP BY
			t1.purity_identity,
			t1.attach_work_fee,
		    t1.purity_name ,
			date_format( t2.approve_time, 'yyyy-MM-dd' )
	) a
GROUP BY
	rq,csmc,
	fjgf
ORDER BY
	date_format( rq, 'yyyy-MM-dd' ),
	fjgf;


SELECT
	fjgf,
	sum( jz ) AS jz,
	sum( fjgfje ) AS fjgfje,
	sum( jcgf ) AS jcgf,
	csmc AS csmc,
	rq AS rq
FROM
	(
		-- 计算销售数据
		SELECT
			t2.additional_labour AS fjgf,
			sum( t2.net_weight ) AS jz,
			sum( t2.net_weight * t2.additional_labour ) AS fjgfje,
			sum( t6.jcgf * t2.net_weight ) AS jcgf,
			t5.purity_name AS csmc,
			date_format( t1.bill_date, 'yyyy-MM-dd' ) AS rq
		FROM
			t_sale_from t1
			INNER JOIN t_sale_from_detail t2 ON t1.sale_identity = t2.sale_identity AND t2.STATUS = 0 and t1.dt='2022-12-21' and t2.dt='2022-12-21'
			INNER JOIN t_fast_package_i t3 ON t3.package_i_code = t2.package_i_code and t3.dt='2022-12-21'
			INNER JOIN t_fast_package t4 ON t3.fast_package_identity = t4.fast_package_identity and t4.dt='2022-12-21'
			INNER JOIN t_purity t5 ON t1.purity_identity = t5.purity_identity and t5.dt='2022-12-21'
			INNER JOIN (
		SELECT
			sale_identity,
			round( sum( amount ) / sum( gold_weight ), 2 ) AS jcgf
		FROM
			t_sale_from_account_detail a
		WHERE
			a.account_method IN ( '转欠料', '结价' )
			AND a.STATUS = 0
		    and a.dt='2022-12-21'
		GROUP BY
			sale_identity
			) t6 ON t2.sale_identity = t6.sale_identity
		WHERE
			t1.approve_status = 1
			AND t5.purity_name IN ( '金9999' )
			AND t4.package_i_type = 'HS'
		    AND date_format(t1.bill_date,'yyyy-MM-dd') = '2022-12-21'
		GROUP BY
			t2.additional_labour,
			date_format( t1.bill_date, 'yyyy-MM-dd'),
		    t5.purity_name
		UNION ALL
		-- 计算退饰数据
		SELECT
			if( t1.attach_work_fee is null,  0,t1.attach_work_fee  ) AS fjgf,
			- sum( t1.gold_weight ) AS jz,
			- sum( if( t1.attach_work_fee_amount is null , 0 ,t1.attach_work_fee_amount) ) AS fjgfje,
			- sum( if( t1.base_work_fee_amount is null , 0, t1.base_work_fee_amount ) ) AS jcgf,
			t1.purity_name AS csmc,
			date_format( t2.approve_time, 'yyyy-MM-dd') AS rq
		FROM
			t_bf_cust_return_jewelry_detail t1
			LEFT JOIN t_bf_cust_return_jewelry t2 ON t1.return_identity = t2.return_identity
		WHERE
			t2.approve_status = 1
			AND t1.purity_name IN ( '金9999' )
			AND t2.`status` = 0
			AND t1.`status` = 0
		    and t1.dt='2022-12-21'
		    and t2.dt='2022-12-21'
			AND t2.counter_name not like  '%镶嵌%'
			AND date_format(t2.approve_time,'yyyy-MM-dd') = '2022-12-21'
		GROUP BY
			t1.purity_identity,
			t1.attach_work_fee,
		    t1.purity_name ,
			date_format( t2.approve_time, 'yyyy-MM-dd' )
	) a
GROUP BY
	rq,csmc,
	fjgf
ORDER BY
	date_format( rq, 'yyyy-MM-dd' ),
	fjgf;



select csmc,rq,ROUND(sum(jz1),3) as jz1,ROUND(sum(jcgf1),2) as jcgf1,ROUND(sum(fjgfje1),2) as fjgf1,
 ROUND(sum(jz2),3)  as jz2,ROUND(sum(jcgf2),2) as jcgf2,ROUND(sum(fjgfje2),2) as fjgf2,
 ROUND(sum(jz3),3)  as jz3,ROUND(sum(jcgf3),2) as jcgf3,ROUND(sum(fjgfje3),2)as fjgf3,
 ROUND(sum(jz4),3)  as jz4,ROUND(sum(jcgf4),2) as jcgf4,ROUND(sum(fjgfje4),2) as fjgf4,
 ROUND(sum(jz5),3)  as jz5,ROUND(sum(jcgf5),2) as jcgf5,ROUND(sum(fjgfje5),2) as fjgf5
 from (
  select csmc,rq,
       case when fjgf < 2 then jz else '' end as jz1,
       case when fjgf < 2 then jcgf else '' end as jcgf1,
       case when fjgf < 2 then fjgfje else '' end as fjgfje1,

       case when fjgf >= 2 and fjgf < 3 then jz else '' end as jz2,
       case when fjgf >= 2 and fjgf < 3 then jcgf  else '' end as jcgf2,
       case when fjgf >= 2 and fjgf < 3 then fjgfje else '' end as fjgfje2,

       case when fjgf >= 3 and fjgf < 4 then jz else '' end as jz3,
       case when fjgf >= 3 and fjgf < 4 then jcgf  else '' end as jcgf3,
       case when fjgf >= 3 and fjgf < 4 then fjgfje else '' end as fjgfje3,

       case when fjgf >= 4 and fjgf < 5 then jz else '' end as jz4,
       case when fjgf >= 4 and fjgf < 5 then jcgf  else '' end as jcgf4,
       case when fjgf >= 4 and fjgf < 5 then fjgfje else '' end as fjgfje4,

       case when fjgf >= 5 then jz else '' end as jz5,
       case when fjgf >= 5 then jcgf  else '' end as jcgf5,
       case when fjgf >= 5 then fjgfje else '' end as fjgfje5
  from ods_cx_new_ccj_temp
 )t
 GROUP BY rq
 UNION ALL
  select csmc,rq,ROUND(sum(jz1),3) as jz1,ROUND(sum(jcgf1),2) as jcgf1,ROUND(sum(fjgfje1),2) as fjgf1,
 ROUND(sum(jz2),3)  as jz2,ROUND(sum(jcgf2),2) as jcgf2,ROUND(sum(fjgfje2),2) as fjgf2,
 ROUND(sum(jz3),3)  as jz3,ROUND(sum(jcgf3),2) as jcgf3,ROUND(sum(fjgfje3),2)as fjgf3,
 ROUND(sum(jz4),3)  as jz4,ROUND(sum(jcgf4),2) as jcgf4,ROUND(sum(fjgfje4),2) as fjgf4,
 ROUND(sum(jz5),3)  as jz5,ROUND(sum(jcgf5),2) as jcgf5,ROUND(sum(fjgfje5),2) as fjgf5
 from (
  select csmc,rq,
       case when fjgf < 2 then jz else '' end as jz1,
       case when fjgf < 2 then jcgf else '' end as jcgf1,
       case when fjgf < 2 then fjgfje else '' end as fjgfje1,

       case when fjgf >= 2 and fjgf < 3 then jz else '' end as jz2,
       case when fjgf >= 2 and fjgf < 3 then jcgf  else '' end as jcgf2,
       case when fjgf >= 2 and fjgf < 3 then fjgfje else '' end as fjgfje2,

       case when fjgf >= 3 and fjgf < 4 then jz else '' end as jz3,
       case when fjgf >= 3 and fjgf < 4 then jcgf  else '' end as jcgf3,
       case when fjgf >= 3 and fjgf < 4 then fjgfje else '' end as fjgfje3,

       case when fjgf >= 4 and fjgf < 5 then jz else '' end as jz4,
       case when fjgf >= 4 and fjgf < 5 then jcgf  else '' end as jcgf4,
       case when fjgf >= 4 and fjgf < 5 then fjgfje else '' end as fjgfje4,

       case when fjgf >= 5 then jz else '' end as jz5,
       case when fjgf >= 5 then jcgf  else '' end as jcgf5,
       case when fjgf >= 5 then fjgfje else '' end as fjgfje5
  from ods_cx_new_ccj_result
 )t
 GROUP BY rq,csmc;



drop table ads_cx_new_ccj;

create table IF NOT EXISTS ads_cx_new_ccj(csmc string,rq string,jz1 decimal(18,3),jcfg1 decimal(18,3),fjgf1 decimal(18,3),jz2 decimal(18,3),jcfg2 decimal(18,3),fjgf2 decimal(18,3),jz3 decimal(18,3),jcfg3 decimal(18,3),fjgf3 decimal(18,3),jz4 decimal(18,3),jcfg4 decimal(18,3),fjgf4 decimal(18,3),jz5 decimal(18,3),jcfg5 decimal(18,3),fjgf5 decimal(18,3)) partitioned by (dt string) location '/zfq_test_decent_cloud/ads_cx_new_ccj';

use zfq_test_decent_cloud;

select * from ads_cx_new_ccj;


use zfq_test_decent_cloud;



  SELECT T2.SHOWROOM_IDENTITY,
         T2.SHOWROOM_NAME,
         T1.COUNTER_IDENTITY,
         T1.COUNTER_NAME
    FROM T_SHOWROOM_COUNTER T1
    INNER JOIN T_SHOWROOM T2
      ON T1.SHOWROOM_IDENTITY = T2.SHOWROOM_IDENTITY and t1.dt='2023-01-02' and t2.dt='2023-01-02';

select * from ods_cx_szzt_xqxshzb_temp_showroom_counter;







   select t1.customer_identity,
          t1.customer_code,
          t1.customer_name,
          case when t1.parent_customer_identity is null then t1.customer_name else t2.customer_name end as parent_customer_name,
          case when t1.parent_customer_identity is not null then t1.customer_name else null end as child_customer_name
     from t_fast_customer t1
     left join t_fast_customer t2
       on t1.parent_customer_identity = t2.customer_identity and(t1.dt='2023-01-02' and t2.dt='2023-01-02')
group by t1.customer_identity,
          t1.customer_code,
          t1.customer_name,case when t1.parent_customer_identity is null then t1.customer_name else t2.customer_name end,case when t1.parent_customer_identity is not null then t1.customer_name else null end
;




select b.province as sf, a.area_name as qymc
  from t_bf_area a, t_delay_region b
 where a.area_identity  =  b.area_identity
   and a.status = 0 and a.dt='2023-01-02' and b.dt='2023-01-02';

select * from ods_cx_szzt_zxzqtjmxb_temp02;



select distinct b.customer_identity,
                b.customer_code as khbm,
                a.area_name as qymc

  from t_bf_area a, t_fast_customer b
 where a.area_identity  =  b.area_identity
   and a.status = 0 and a.dt='2023-01-02' and b.dt='2023-01-02';


select customer_identity, IF(TECH_PURITY_NAME is null , '三九',TECH_PURITY_NAME) AS TECH_PURITY_NAME, 0 as yyhlzl, sum(if(jz is null , 0,jz)) as zxzl, 0 as slzl, 0 as tszl, 0 as cq, 0 as sc, 0 as wdzl, 0 as jjzl, 0 as bgfzl
   from t_ka_lllsz -- 来料流水账
 where wdmc ='深圳展厅'
   and date_format(rq,'yyyy-MM-dd') = '2023-01-02'
   and dt='2023-01-02'
   and (swlx like '%做现转欠%' or swlx = '现款现料' or swlx = '现料' or swlx = '现料欠款' or swlx='欠款欠料' )
 group by customer_identity, TECH_PURITY_NAME;



select customer_identity, if(TECH_PURITY_NAME is null , '三九',TECH_PURITY_NAME) AS TECH_PURITY_NAME, 0 as yyhlzl, 0 as zxzl, sum(if(receive_gold_weight is null , 0,receive_gold_weight)) as slzl, 0 as tszl, 0 as cq, 0 as sc, 0 as wdzl, 0 as jjzl, 0 as bgfzl
   from t_bf_receive_meterial
 where showroom_name = '深圳展厅'
   and date_format(rq,'yyyy-MM-dd') >= '2023-01-02'
   and approve_status = 1
   and status = 0
   and dt='2023-01-02'
group by customer_identity, TECH_PURITY_NAME;











select customer_identity, if(TECH_PURITY_NAME is null , '三九',TECH_PURITY_NAME) AS TECH_PURITY_NAME, 0 as yyhlzl, 0 as zxzl, 0 as slzl, sum(if(jz is null , 0,jz)) as tszl, 0 as cq, 0 as sc, 0 as wdzl, 0 as jjzl, 0 as bgfzl
 from t_ka_lllsz
where wdmc = '深圳展厅'
  and date_format(rq,'yyyy-MM-dd') ='2023-01-02'
  and dt='2023-01-02'
  and swlx = '客户退饰'
group by customer_identity, TECH_PURITY_NAME;





select customer_identity, if(C.PURITY_NAME is null, '三九',C.PURITY_NAME) AS TECH_PURITY_NAME, 0 as yyhlzl, 0 as zxzl, 0 as slzl, 0 as tszl, 0 as cq, 0 as sc, 0 as wdzl, SUM(if(settlement_weight is null, 0,settlement_weight)) as jjzl, 0 as bgfzl
   from t_bf_settlement A
  left join t_purity b
    on a.purity_name = b.purity_name and a.dt='2023-01-02' and b.dt='2023-01-02'
  left join t_technology_purity c
    on b.technology_purity_identity = c.id and c.dt='2023-01-02'
 where showroom_name ='深圳展厅'
   and date_format(rq,'yyyy-MM-dd') >= '2023-01-02'
   and approve_status = 1
 GROUP BY CUSTOMER_IDENTITY, C.PURITY_NAME;


select customer_identity, if(TECH_PURITY_NAME is null, '三九',TECH_PURITY_NAME) AS TECH_PURITY_NAME, 0 as yyhlzl, 0 as zxzl, 0 as slzl, 0 as tszl, 0 as cq, 0 as sc, 0 as wdzl, 0 as jjzl, SUM(if(gold_weight is null, 0,gold_weight)) as bgfzl
   from t_bf_repair
 where showroom_name ='深圳展厅'
   and date_format(rq,'yyyy-MM-dd') = '2023-01-02'
    and approve_status = 1
   and status = 0
   and dt='2023-01-02'
 GROUP BY CUSTOMER_IDENTITY, TECH_PURITY_NAME;



select wdmc, customer_identity, khbm, khmc, zkhmc, csmc, pqmc, sjxqmc, djsxx, sxqxx, khbh
  from (select branch_name as wdmc,
               customer_identity,
               customer_code as khbm,
               customer_name as khmc,
               '' as zkhmc,
               area_name as pqmc,
               province as sjxqmc,
               city_code as djsxx,
               county_desc as sxqxx,
               '' as khbh,
               purity_name as csmc
          from t_customer
         where if(active_flag is null, 'Y',active_flag) ='Y' and dt='2023-01-02'
         union all
        select branch_name as wdmc,
               b.child_customer_identity as customer_identity,
               concat(a.customer_code, lpad(b.child_customer_seq, 4,'0')) as khbm,
               a.customer_name as khmc,
               b.child_customer_name as zkhmc,
               a.area_name as pqmc,
               if(b.province is null, a.province,b.province) as sjxqmc,
               a.city_code as djsxx,
               a.county_desc as sxqxx,
               b.child_customer_code as khbh,
               a.purity_name as csmc
          from t_customer a
         inner join t_child_customer b
            on a.customer_identity = b.customer_identity
         where if(a.active_flag is null , 'Y',a.active_flag) = 'Y'
           and if(b.active_flag is null , 'Y',b.active_flag) = 'Y'
      and a.dt='2023-01-02' and b.dt='2023-01-02'
       ) a;



desc formatted ods_cx_szzt_zxzqtjmxb_temp_khxx;


select wdmc,
customer_identity,
khbm,
khmc,
zkhmc,
csmc,
b.qymc as pqmc,
sjxqmc,
djsxx,
sxqxx,
khbh
from ods_cx_szzt_zxzqtjmxb_temp_khxx a ,ods_cx_szzt_zxzqtjmxb_temp01 b where a.sjxqmc = b.sf;


select  * from t_KA_szkhcqlxzzfb_h where dt='2023-01-02';




select wdmc, customer_identity, if(TECH_PURITY_NAME is null , '三九',TECH_PURITY_NAME) AS TECH_PURITY_NAME, sum(djje) as djje, 0 as jz, date_format(rq,'yyyy-MM-dd') as rq
from t_ka_ysmxz_h a, t_ka_ysmxz_b b
         where a.ysmxz_h_identity = b.ysmxz_h_identity
           and date_format(rq,'yyyy-MM-dd')='2023-01-02'
           and wdmc = '深圳展厅'
           and a.dt='2023-01-02'
           and b.dt='2023-01-02'
         group by wdmc, customer_identity, TECH_PURITY_NAME, date_format(rq,'yyyy-MM-dd')
    union all
         select wdmc, customer_identity, if(TECH_PURITY_NAME is null , '三九',TECH_PURITY_NAME) AS TECH_PURITY_NAME, 0 as je, sum(jz) as jz, date_format(rq,'yyyy-MM-dd') as rq from t_ka_lllsz a
          where date_format(rq,'yyyy-MM-dd') = '2023-01-02'
            and (djm = '付料单' or djm = '结算单' or djm = '购料单')
            and wdmc = '深圳展厅'
            and dt='2023-01-02'
          group by wdmc,customer_identity, TECH_PURITY_NAME, date_format(rq,'yyyy-MM-dd')
    union all
         select wdmc, customer_identity, if(TECH_PURITY_NAME is null , '三九',TECH_PURITY_NAME) AS TECH_PURITY_NAME, 0 as je, 0 - sum(jz) as jz, date_format(rq,'yyyy-MM-dd') as rq from t_ka_lllsz a
          where date_format(rq,'yyyy-MM-dd') = '2023-01-02'
            and djm <> '付料单'
            and djm <> '结算单'
            and djm <> '购料单'
            and wdmc = '深圳展厅'
            and dt='2023-01-02'
          group by wdmc, customer_identity, TECH_PURITY_NAME, date_format(rq,'yyyy-MM-dd');













select customer_identity, TECH_PURITY_NAME, if(sum(khjdzje) is null, 0,sum(khjdzje) ) khjdzje, if(sum(dzdje) is null , 0,sum(dzdje)) dzdje, if(sum(dxdje) is null , 0,sum(dxdje)) dxdje, if(sum(khjdzlz) is null, 0,sum(khjdzlz)) khjdzlz, if(sum(dzdlz) is null , 0,sum(dzdlz)) dzdlz
from (select showroom_name as wdmc,out_customer_identity as customer_identity, if(OUT_TECH_PURITY_NAME is null , '三九',OUT_TECH_PURITY_NAME) AS TECH_PURITY_NAME, 0 - (if(adjust_capital is null, 0,adjust_capital) + if(adjust_month_price is null, 0,adjust_month_price)) as khjdzje, 0 as dzdje, 0 as dxdje, 0 - adjust_weight as khjdzlz, 0 as dzdlz
         from t_bf_customer_the_bill
        where status = 0
          and date_format(rq,'yyyy-MM-dd') = '2023-01-02'
          and dt='2023-01-02'
       union all
       select showroom_name as wdmc, in_customer_identity as customer_identity, if(IN_TECH_PURITY_NAME is null , '三九',IN_TECH_PURITY_NAME) AS TECH_PURITY_NAME, if(adjust_capital is null, 0,adjust_capital) + if(adjust_month_price is null, 0,adjust_month_price) as khjdzje, 0 as dzdje, 0 as dxdje, adjust_weight as khjdzlz, 0 as dzdlz
         from t_bf_customer_the_bill
        where status = 0
          and date_format(rq,'yyyy-MM-dd') ='2023-01-02'
          and dt='2023-01-02'
        union all
       select showroom_name as wdmc, customer_identity, if(TECH_PURITY_NAME is null , '三九',TECH_PURITY_NAME) AS TECH_PURITY_NAME, 0 as khjdzje, if(adjust_capital is null, 0,adjust_capital) + if(adjust_month_price is null , 0,adjust_month_price) as dzdje, 0 as dxdje, 0 as khjdzlz, adjust_weight as dzdlz
         from t_bf_the_bill
        where status = 0
        and date_format(rq,'yyyy-MM-dd') = '2023-01-02'
        and dt='2023-01-02'
        and adjust_type = '调账款'

       union all
       select showroom_name as wdmc, customer_identity, if(TECH_PURITY_NAME is null, '三九',TECH_PURITY_NAME) AS TECH_PURITY_NAME, 0 as khjdzje, 0 as dzdje, if(adjust_capital is null, 0,adjust_capital) as dxdje, 0 as khjdzlz, 0 as dzdlz
         from t_bf_the_bill
          where status = 0
          and date_format(rq,'yyyy-MM-dd') ='2023-01-02'
          and dt='2023-01-02'
           and adjust_type = '调利息'
      ) a
where exists (select * from ods_cx_szzt_zxzqtjmxb_temp_khxx_02 where customer_identity = a.customer_identity and wdmc = a.wdmc)
group by customer_identity, TECH_PURITY_NAME;

insert into ads_cx_szzt_zxzqtjmxb partition (dt='$dt')
select CONCAT(case when d.zkhmc is not null and zkhmc<>'' then concat(d.khmc , '-' , d.zkhmc)
            else d.khmc end, '(', A.TECH_PURITY_NAME, ')') as khmc,
       d.csmc as csmc,
       a.yyhlzl as yyhlzl,
       d.khbm,
       d.khbh,
       a.zxzl as zxzl,
       a.slzl as slzl,
       a.tszl as tszl,
       c.qlzl + c.wdqqlzl + a.cq as cq,
       c.qlzl + c.wdqqlzl as scjz,
       c.ydqje + c.wdqje + c.dygfh + c.sygfh as scje,
       a.wdzl as wdzl,
       a.jjzl as jjzl,
       a.bgfzl as bgfzl,
       date_sub(b.jsrq,1) as jsrq,
       d.pqmc as qymc,
       e.ysql as yszl,
       e.ysqk as ysje,
       f.khjdzje as khjdzje,
       f.dxdje as dxdje,
       f.dzdje as dzdje,
       f.khjdzlz as khjdzlz,
       f.dzdlz as dzdlz
  from ods_cx_szzt_zxzqtjmxb_temp_temp a
  left join t_ka_szkhcqlxzz_h c on c.customer_identity = a.customer_identity AND C.PURITY_NAME = A.TECH_PURITY_NAME and c.dt='2023-01-02'
  left join t_KA_szlxjsrq b on 1 = 1 and b.dt='$dt'
  left join ods_cx_szzt_zxzqtjmxb_temp_khxx_02 d on d.customer_identity = a.customer_identity
  left join ods_cx_szzt_zxzqtjmxb_temp_yscq e on e.customer_identity = d.customer_identity AND E.TECH_PURITY_NAME = A.TECH_PURITY_NAME
  left join ods_cx_szzt_zxzqtjmxb_temp_dzd f on f.customer_identity = d.customer_identity AND F.TECH_PURITY_NAME = A.TECH_PURITY_NAME;

create table IF NOT EXISTS ads_cx_szzt_zxzqtjmxb(khmc string,csmc string,yyhlzl decimal(18,3),khbm string,khbh string
                                                ,zxzl decimal(18,3),slzl decimal(18,3),scje decimal(18,3),tszl decimal(18,3),
                                                cq decimal(18,3),scjz decimal(18,3),wdzl decimal(18,3),
                                                jjzl decimal(18,3),bgfzl decimal(18,3),jsrq string,
                                                qymc string,yszl decimal(18,3),ysje decimal(18,3),
                                                khjdzje decimal(18,3),dxdje decimal(18,3),dzdje decimal(18,3),khjdzlz decimal(18,3),dzdlz decimal(18,3)) partitioned by (dt string) location '/zfq_test_decent_cloud/ads_cx_szzt_zxzqtjmxb';



drop table ads_cx_szzt_zxzqtjmxb;

select * from ads_cx_szzt_zxzqtjmxb;















select b.province as  sf,
       a.area_name as qymc
  from t_bf_area a, t_delay_region b
 where a.area_identity = b.area_identity
 and a.dt='2023-01-02' and b.dt='2023-01-02';







SELECT date_format(A.RQ,'yyyy-MM-dd')AS RQ,
       B.KHBM AS KHBM,
       B.KHMC AS KHMC,
       B.ZKHMC AS ZKH,
       A.NEIGHT AS SLJZ,
       '区域权限未分配或客户已禁用' QYMC,
       B.SJXQMC AS SJXQMC,
       0 LLJZHJ,
       A.OLD_MATERIAL AS JLYSL,
       A.METERIAL999 AS SJYSL,
       A.METERIAL9999 AS SJYSL1,
       A.METERIAL99999 AS WJYSL,
       A.METERIA18K AS SBKYSL,
       A.METERIA22K AS ESEKYSL,
       0 JLSSL,
       0 SJSSL,
       0 SJSSL1,
       0 WJSSL,
       0 SBKSSL,
       0 ESEKSSL,
       A.REMARK AS BZ,
       A.PRICE AS SKJE,
       A.PRICE999 AS SJYSK,
       A.PRICE9999 AS SJYSK1,
       A.PRICE99999 AS WJYSK,
       A.PRICE18K AS SBKYSK,
       A.PRICE22K AS ESEKYSK,
       0 SJSSK,
       0 SJSSK1,
       0 WJSSK,
       0 SBKSSK,
       0 ESEKSSK,
       0 BCSKHJ
  FROM T_BF_RAW_MATERIAL A
  LEFT JOIN ods_cx_yslhz_mx_temp_customer B
    ON A.CUSTOMER_IDENTITY = B.CUSTOMER_IDENTITY
 WHERE date_format(A.RQ,'yyyy-MM-dd') = '2023-01-02'
   AND A.STATUS = 0
   and a.dt='2023-01-02'
;





SELECT date_format(A.RQ,'yyyy-MM-dd')AS RQ,
       B.KHBM AS KHBM,
       B.KHMC AS KHMC,
       B.ZKHMC AS ZKH,
       0 SLJZ,
       '区域权限未分配或客户已禁用' QYMC,
       B.SJXQMC AS SJXQMC,
       RECEIVE_GOLD_WEIGHT AS SJJZ,
       0 AS JLYSL,
       0 AS SJYSL,
       0 AS SJYSL1,
       0 AS WJYSL,
       0 AS SBKYSL,
       0 AS ESEKYSL,
       CASE WHEN D.CSMCH = '旧料'THEN RECEIVE_GOLD_WEIGHT ELSE 0 END AS JLSSL,
       CASE WHEN A.TECH_PURITY_NAME = '三九'THEN RECEIVE_GOLD_WEIGHT ELSE 0 END AS SJSSL,
       CASE WHEN A.TECH_PURITY_NAME = '四九' THEN RECEIVE_GOLD_WEIGHT ELSE 0 END AS SJSSL1,
       CASE WHEN A.TECH_PURITY_NAME = '五九'THEN RECEIVE_GOLD_WEIGHT ELSE 0 END AS WJSSL,
       0 SBKSSL,
       0 ESEKSSL,
       '' BZ,
       0 SKJE,
       0 AS SJYSK,
       0 AS SJYSK1,
       0 AS WJYSK,
       0 AS SBKYSK,
       0 AS ESEKYSK,
       0 SJSSK,
       0 SJSSK1,
       0 WJSSK,
       0 SBKSSK,
       0 ESEKSSK,
       0 SJSK
  FROM T_BF_RECEIVE_METERIAL A
  LEFT JOIN ods_cx_yslhz_mx_temp_customer B
    ON A.CUSTOMER_IDENTITY = B.CUSTOMER_IDENTITY and a.dt='2023-01-02'
  LEFT JOIN (SELECT RECEIVE_METERIAL_IDENTITY,
                    CSMCH
               FROM (SELECT RECEIVE_METERIAL_IDENTITY,
                            PURITY_NAME AS CSMCH,
                            ROW_NUMBER() OVER ( PARTITION BY RECEIVE_METERIAL_IDENTITY ORDER BY RECEIVE_METERIAL_DETAIL_IDENTITY ) AS RAK
                       FROM T_BF_RECEIVE_METERIAL_DETAIL where dt='2023-01-02') T
              WHERE RAK = 1) D
    ON D.RECEIVE_METERIAL_IDENTITY = A.RECEIVE_METERIAL_IDENTITY
 WHERE date_format(A.RQ,'yyyy-MM-dd') = '2023-01-02'
   AND A.STATUS = 0;


SELECT date_format(A.RQ,'yyyy-MM-dd')AS RQ,
       B.KHBM AS KHBM,
       B.KHMC AS KHMC,
       B.ZKHMC AS ZKH,
       0 SLJZ,
       '区域权限未分配或客户已禁用' QYMC,
       B.SJXQMC AS SJXQMC,
       0 SJJZ,
       0 AS JLYSL,
       0 AS SJYSL,
       0 AS SJYSL1,
       0 AS WJYSL,
       0 AS SBKYSL,
       0 AS ESEKYSL,
       0 JLSSL,
       0 SJSSL,
       0 SJSSL1,
       0 WJSSL,
       0 SBKSSL,
       0 ESEKSSL,
       '' BZ,
       0 SKJE,
       0 AS SJYSK,
       0 AS SJYSK1,
       0 AS WJYSK,
       0 AS SBKYSK,
       0 AS ESEKYSK,
       CASE WHEN A.TECH_PURITY_NAME = '三九'THEN TOTAL_PRICE ELSE 0 END AS SJSSK,
       CASE WHEN A.TECH_PURITY_NAME = '四九'THEN TOTAL_PRICE ELSE 0 END AS SJSSK1,
       CASE WHEN A.TECH_PURITY_NAME = '五九'THEN TOTAL_PRICE ELSE 0 END AS WJSSK,
       0 SBKSSK,
       0 ESEKSSK,
       TOTAL_PRICE AS SJSK
  FROM T_BF_CUS_DEBIT_RECEIPT A
  LEFT JOIN ods_cx_yslhz_mx_temp_customer  B
    ON A.CUSTOMER_IDENTITY = B.CUSTOMER_IDENTITY
 WHERE date_format(A.RQ,'yyyy-MM-dd') = '2023-01-02'
   and a.dt='2023-01-02'
   AND A.STATUS = 0;



SELECT A.RQ,
       A.KHBM,
       A.KHMC,
       A.ZKH,
       if(SUM(SLJZ) is null, 0,SUM(SLJZ)) SLJZ,
       QYMC,
       SJXQMC,
       if(SUM(LLJZHJ) is null, 0,SUM(LLJZHJ)) SJJZ,
       if(SUM(JLYSL) is null, 0,SUM(JLYSL) ) JLYSL,
       if(SUM(SJYSL) is null, 0,SUM(SJYSL)) SJYSL,
       if(SUM(SJYSL1) is null, 0,SUM(SJYSL1)) SJYSL1,
       if(SUM(WJYSL) is null, 0,SUM(WJYSL)) WJYSL,
       if(SUM(SBKYSL) is null, 0,SUM(SBKYSL) ) SBKYSL,
       if(SUM(ESEKYSL) is null, 0,SUM(ESEKYSL)) ESEKYSL,
       if(SUM(JLSSL) is null, 0,SUM(JLSSL) ) JLSSL,
       if(SUM(SJSSL) is null, 0,SUM(SJSSL)) SJSSL,
       if(SUM(SJSSL1) is null, 0,SUM(SJSSL1)) SJSSL1,
       if(SUM(WJSSL) is null, 0,SUM(WJSSL) ) WJSSL,
       if(SUM(SBKSSL) is null, 0,SUM(SBKSSL)) SBKSSL,
       if(SUM(ESEKSSL) is null, 0,SUM(ESEKSSL)) ESEKSSL,
       A.BZ,
       if(SUM(SKJE) is null, 0,SUM(SKJE)) SKJE,
       if(SUM(SJYSK) is null, 0,SUM(SJYSK) ) SJYSK,
       if(SUM(SJYSK1) is null, 0,SUM(SJYSK1)) SJYSK1,
       if(SUM(WJYSK) is null, 0,SUM(WJYSK) ) WJYSK,
       if(SUM(SBKYSK) is null, 0,SUM(SBKYSK) ) SBKYSK,
       if(SUM(ESEKYSK) is null, 0,SUM(ESEKYSK) ) ESEKYSK,
       if(SUM(SJSSK) is null, 0,SUM(SJSSK) ) SJSSK,
       if(SUM(SJSSK1) is null, 0,SUM(SJSSK1)) SJSSK1,
       if(SUM(WJSSK) is null, 0,SUM(WJSSK)) WJSSK,
       if(SUM(SBKSSK) is null, 0,SUM(SBKSSK)) SBKSSK,
       if(SUM(ESEKSSK) is null, 0,SUM(ESEKSSK)) ESEKSSK,
       if(SUM(BCSKHJ) is null, 0,SUM(BCSKHJ) ) SJSK
  FROM (
select * from ods_cx_yslhz_mx_temp_t1
union all
select * from ods_cx_yslhz_mx_temp_t2
union all
select * from ods_cx_yslhz_mx_temp_t3

           )a
 GROUP BY A.RQ, A.KHBM, A.KHMC, A.ZKH, A.BZ, QYMC, SJXQMC ;



desc formatted ods_cx_yslhz_mx_temp_ysls;


select
rq,
khbm,
khmc,
zkh,
sljz,
b.qymc as qymc,
sjxqmc,
sjjz,
jlysl,
sjysl,
sjysl1,
wjysl,
sbkysl,
esekysl,
jlssl,
sjssl,
sjssl1,
wjssl,
sbkssl,
esekssl,
bz,
skje,
sjysk,
sjysk1,
wjysk,
sbkysk,
esekysk,
sjssk,
sjssk1,
wjssk,
sbkssk,
esekssk,
sjsk
from ods_cx_yslhz_mx_temp_ysls a ,ods_cx_yslhz_mx_temp1 b where A.SJXQMC = B.SF;




SELECT RQ,
       KHMC,
       ZKH,
       '' BZ,
       QYMC,
       SUM(SLJZ) SLJZ,
       IFNULL(SUM(SJJZ), 0) SJJZ,
       IFNULL(SUM(JLYSL), 0) JLYSL,
       IFNULL(SUM(SJYSL), 0) SJYSL,
       IFNULL(SUM(SJYSL1), 0) SJYSL1,
       IFNULL(SUM(WJYSL), 0) WJYSL,
       IFNULL(SUM(SBKYSL), 0) SBKYSL,
       IFNULL(SUM(ESEKYSL), 0) ESEKYSL,
       IFNULL(SUM(JLSSL), 0) JLSSL,
       IFNULL(SUM(SJSSL), 0) SJSSL,
       IFNULL(SUM(SJSSL1), 0) SJSSL1,
       IFNULL(SUM(WJSSL), 0) WJSSL,
       IFNULL(SUM(SBKSSL), 0) SBKSSL,
       IFNULL(SUM(ESEKSSL), 0) ESEKSSL,
       SUM(SKJE) SKJE,
       IFNULL(SUM(SJSK), 0) SJSK,
       IFNULL(SUM(SJYSK), 0) SJYSK,
       IFNULL(SUM(SJYSK1), 0) SJYSK1,
       IFNULL(SUM(WJYSK), 0) WJYSK,
       IFNULL(SUM(SBKYSK), 0) SBKYSK,
       IFNULL(SUM(ESEKYSK), 0) ESEKYSK,
       IFNULL(SUM(SJSSK), 0) SJSSK,
       IFNULL(SUM(SJSSK1), 0) SJSSK1,
       IFNULL(SUM(WJSSK), 0) WJSSK,
       IFNULL(SUM(SBKSSK), 0) SBKSSK,
       IFNULL(SUM(ESEKSSK), 0) ESEKSSK
  FROM (SELECT RQ,
               KHMC,
               ZKH,
               '' BZ,
               QYMC,
               SUM(SLJZ) SLJZ,
               IFNULL(SUM(SJJZ), 0) SJJZ,
               IFNULL(SUM(JLYSL), 0) JLYSL,
               IFNULL(SUM(SJYSL), 0) SJYSL,
               IFNULL(SUM(SJYSL1), 0) SJYSL1,
               IFNULL(SUM(WJYSL), 0) WJYSL,
               IFNULL(SUM(SBKYSL), 0) SBKYSL,
               IFNULL(SUM(ESEKYSL), 0) ESEKYSL,
               IFNULL(SUM(JLSSL), 0) JLSSL,
               IFNULL(SUM(SJSSL), 0) SJSSL,
               IFNULL(SUM(SJSSL1), 0) SJSSL1,
               IFNULL(SUM(WJSSL), 0) WJSSL,
               IFNULL(SUM(SBKSSL), 0) SBKSSL,
               IFNULL(SUM(ESEKSSL), 0) ESEKSSL,
               SUM(SKJE) SKJE,
               IFNULL(SUM(SJSK), 0) SJSK,
               IFNULL(SUM(SJYSK), 0) SJYSK,
               IFNULL(SUM(SJYSK1), 0) SJYSK1,
               IFNULL(SUM(WJYSK), 0) WJYSK,
               IFNULL(SUM(SBKYSK), 0) SBKYSK,
               IFNULL(SUM(ESEKYSK), 0) ESEKYSK,
               IFNULL(SUM(SJSSK), 0) SJSSK,
               IFNULL(SUM(SJSSK1), 0) SJSSK1,
               IFNULL(SUM(WJSSK), 0) WJSSK,
               IFNULL(SUM(SBKSSK), 0) SBKSSK,
               IFNULL(SUM(ESEKSSK), 0) ESEKSSK
          FROM TEMP_YSLS A
         GROUP BY RQ, KHMC, ZKH, BZ, QYMC
       ) A
 GROUP BY RQ, KHMC, ZKH, BZ, QYMC;
use zfq_test_decent_cloud;
SELECT RQ,
       KHMC,
       ZKH,
       '' BZ,
       pymc,
       SUM(SLJZ) SLJZ,
       if(SUM(SJJZ) is null, 0,SUM(SJJZ)) SJJZ,
       if(SUM(JLYSL) is null, 0,SUM(JLYSL)) JLYSL,
       if(SUM(SJYSL) is null, 0,SUM(SJYSL)) SJYSL,
       if(SUM(SJYSL1) is null, 0,SUM(SJYSL1)) SJYSL1,
       if(SUM(WJYSL) is null, 0,SUM(WJYSL)) WJYSL,
       if(SUM(SBKYSL) is null, 0,SUM(SBKYSL)) SBKYSL,
       if(SUM(ESEKYSL) is null, 0,SUM(ESEKYSL)) ESEKYSL,
       if(SUM(JLSSL) is null, 0,SUM(JLSSL)) JLSSL,
       if(SUM(SJSSL) is null, 0,SUM(SJSSL)) SJSSL,
       if(SUM(SJSSL1) is null, 0,SUM(SJSSL1)) SJSSL1,
       if(SUM(WJSSL) is null, 0,SUM(WJSSL)) WJSSL,
       if(SUM(SBKSSL) is null, 0,SUM(SBKSSL)) SBKSSL,
       if(SUM(ESEKSSL) is null, 0,SUM(ESEKSSL)) ESEKSSL,
       SUM(SKJE) SKJE,
       if(SUM(SJSK) is null, 0,SUM(SJSK)) SJSK,
       if(SUM(SJYSK) is null, 0,SUM(SJYSK)) SJYSK,
       if(SUM(SJYSK1) is null, 0,SUM(SJYSK1)) SJYSK1,
       if(SUM(WJYSK) is null, 0,SUM(WJYSK)) WJYSK,
       if(SUM(SBKYSK) is null, 0,SUM(SBKYSK)) SBKYSK,
       if(SUM(ESEKYSK) is null, 0,SUM(ESEKYSK)) ESEKYSK,
       if(SUM(SJSSK) is null, 0,SUM(SJSSK)) SJSSK,
       if(SUM(SJSSK1) is null, 0,SUM(SJSSK1)) SJSSK1,
       if(SUM(WJSSK) is null, 0,SUM(WJSSK)) WJSSK,
       if(SUM(SBKSSK) is null, 0,SUM(SBKSSK)) SBKSSK,
       if(SUM(ESEKSSK) is null, 0,SUM(ESEKSSK)) ESEKSSK
  FROM (SELECT RQ,
               KHMC,
               ZKH,
               '' as BZ,
               pymc,
               SUM(SLJZ) SLJZ,
               if(SUM(SJJZ) is null, 0,SUM(SJJZ)) SJJZ,
               if(SUM(JLYSL) is null, 0,SUM(JLYSL)) JLYSL,
               if(SUM(SJYSL) is null, 0,SUM(SJYSL)) SJYSL,
               if(SUM(SJYSL1) is null, 0,SUM(SJYSL1)) SJYSL1,
               if(SUM(WJYSL) is null, 0,SUM(WJYSL)) WJYSL,
               if(SUM(SBKYSL) is null, 0,SUM(SBKYSL)) SBKYSL,
               if(SUM(ESEKYSL) is null, 0,SUM(ESEKYSL)) ESEKYSL,
               if(SUM(JLSSL) is null, 0,SUM(JLSSL)) JLSSL,
               if(SUM(SJSSL) is null, 0,SUM(SJSSL)) SJSSL,
               if(SUM(SJSSL1) is null, 0,SUM(SJSSL1)) SJSSL1,
               if(SUM(WJSSL) is null, 0,SUM(WJSSL)) WJSSL,
               if(SUM(SBKSSL) is null, 0,SUM(SBKSSL)) SBKSSL,
               if(SUM(ESEKSSL) is null, 0,SUM(ESEKSSL)) ESEKSSL,
               SUM(SKJE) SKJE,
               if(SUM(SJSK) is null, 0,SUM(SJSK)) SJSK,
               if(SUM(SJYSK) is null, 0,SUM(SJYSK)) SJYSK,
               if(SUM(SJYSK1) is null, 0,SUM(SJYSK1)) SJYSK1,
               if(SUM(WJYSK) is null, 0,SUM(WJYSK)) WJYSK,
               if(SUM(SBKYSK) is null, 0,SUM(SBKYSK)) SBKYSK,
               if(SUM(ESEKYSK) is null, 0,SUM(ESEKYSK)) ESEKYSK,
               if(SUM(SJSSK) is null, 0,SUM(SJSSK)) SJSSK,
               if(SUM(SJSSK1) is null, 0,SUM(SJSSK1)) SJSSK1,
               if(SUM(WJSSK) is null, 0,SUM(WJSSK)) WJSSK,
               if(SUM(SBKSSK) is null, 0,SUM(SBKSSK)) SBKSSK,
               if(SUM(ESEKSSK) is null, 0,SUM(ESEKSSK)) ESEKSSK
          FROM ods_cx_yslhz_mx_temp_ysls A
         GROUP BY RQ, KHMC, ZKH, BZ, pymc
       ) A
 GROUP BY RQ, KHMC, ZKH, BZ, pymc;




create table IF NOT EXISTS ads_cx_yslhz_mx (
    rq string,
    khmc string,
    zkh string,
    bz string,
    qymc string,
    sljz decimal(18,3),
    sjjz decimal(18,3),
    jlysl decimal(18,3),
    sjysl decimal(18,3),
    sjysl1 decimal(18,3),
    wjysl decimal(18,3),
    sbkysl decimal(18,3),
    esskysl decimal(18,3),
    jlssl decimal(18,3),
    sjssl decimal(18,3),
    sjssl1 decimal(18,3),
    wjssl decimal(18,3),
    sbkssl decimal(18,3),
    esekssl decimal(18,3),
    skje decimal(18,3),
    sjsk decimal(18,3),
    sjysk decimal(18,3),
    sjysk1 decimal(18,3),
    wjysk decimal(18,3),
    sbkysk decimal(18,3),
    eseysk decimal(18,3),
    sjssk decimal(18,3),
    sjssk1 decimal(18,3),
    wjssk decimal(18,3),
    sbkssk decimal(18,3),
    esekssk decimal(18,3)
) partitioned by (dt string) location '/zfq_test_decent_cloud/ads_cx_yslhz_mx';


select * from ads_cx_yslhz_mx;

use zfq_test_decent_cloud;
SELECT
			'' as type ,
	       C.PURITY_NAME AS CSMC,
								if(B.ADDITIONAL_LABOUR is null, 0,B.ADDITIONAL_LABOUR) AS FJGF,
								SUM(B.NET_WEIGHT) AS ZL,
								SUM(if(B.ADDITIONAL_LABOUR_PRICE is null, 0,B.ADDITIONAL_LABOUR_PRICE)) AS JE,
								'' AS BZ,
								SUM(if(B.TOTAL_NUMBER_DETAIL is null, 0,B.TOTAL_NUMBER_DETAIL)) AS JS,
							 	sum(technology_count_price) as jgf
	 FROM T_SALE_FROM A
	 inner join T_SALE_FROM_DETAIL B  on a.sale_identity= b.sale_identity and a.dt='2023-01-03' and b.dt='2023-01-03'
	 inner join t_fast_package_i  e on b.package_i_code= e.package_i_code and e.dt='2023-01-03'
	 inner join t_fast_package d on d.fast_package_identity=e.fast_package_identity and d.dt='2023-01-03'
	 inner join T_PURITY C on a.purity_identity=c.purity_identity and c.dt='2023-01-03'
 	WHERE A.APPROVE_STATUS = 1
		  and A.SALE_IDENTITY = B.SALE_IDENTITY
				AND A.PURITY_IDENTITY = C.PURITY_IDENTITY
 				AND date_format(A.create_time,'yyyy-MM-dd') = '2023-01-03'
				AND (if(B.TOTAL_NUMBER_DETAIL is null, 0,B.TOTAL_NUMBER_DETAIL ) = 0 OR (if(B.TOTAL_NUMBER_DETAIL is null, 0,B.TOTAL_NUMBER_DETAIL) > 0
				     AND B.ADDITIONAL_LABOUR <> 0
									AND B.ADDITIONAL_LABOUR_PRICE/B.TOTAL_NUMBER_DETAIL <> B.ADDITIONAL_LABOUR) OR (if(B.TOTAL_NUMBER_DETAIL is null, 0,B.TOTAL_NUMBER_DETAIL) > 0
									AND B.ADDITIONAL_LABOUR = 0))
				AND A.STATUS = 0
				AND B.STATUS = 0
  GROUP BY C.PURITY_NAME, if(B.ADDITIONAL_LABOUR is null, 0,B.ADDITIONAL_LABOUR);


 SELECT
				'' as type ,
	       C.PURITY_NAME AS CSMC,
								if(B.ADDITIONAL_LABOUR is null , 0,B.ADDITIONAL_LABOUR ) AS FJGF,
								SUM(B.NET_WEIGHT) AS ZL,
								SUM(if(B.ADDITIONAL_LABOUR_PRICE is null , 0,B.ADDITIONAL_LABOUR_PRICE)) AS JE,
								'按件' AS BZ,
								SUM(if(B.TOTAL_NUMBER_DETAIL is null , 0,B.TOTAL_NUMBER_DETAIL )) AS JS,
								sum(technology_count_price) as jgf
    FROM T_SALE_FROM A
	inner join T_SALE_FROM_DETAIL B  on a.sale_identity= b.sale_identity and a.dt='2023-01-03' and b.dt='2023-01-03'
    inner join t_fast_package_i  e on b.package_i_code= e.package_i_code and e.dt='2023-01-03'
	inner join t_fast_package d on d.fast_package_identity=e.fast_package_identity and d.dt='2023-01-03'
	inner join T_PURITY C on a.purity_identity=c.purity_identity and c.dt='2023-01-03'
  WHERE A.APPROVE_STATUS = 1
		  AND A.SALE_IDENTITY = B.SALE_IDENTITY
				AND A.PURITY_IDENTITY = C.PURITY_IDENTITY
 				AND date_format(A.create_time,'yyyy-MM-dd') = '2023-01-03'
  				AND if(B.TOTAL_NUMBER_DETAIL is null , 0,B.TOTAL_NUMBER_DETAIL) > 0
				AND B.ADDITIONAL_LABOUR <> 0
				AND B.ADDITIONAL_LABOUR_PRICE/B.TOTAL_NUMBER_DETAIL = B.ADDITIONAL_LABOUR
				AND A.STATUS = 0
				AND B.STATUS = 0
 	GROUP BY  C.PURITY_NAME, if(B.ADDITIONAL_LABOUR is null , 0,B.ADDITIONAL_LABOUR) ;

select * from ads_cx_sz_cpbcx_fjgf;




create table IF NOT EXISTS ads_cx_sz_cpbcx_fjgf (
   type string,
   csmc string,
   fjgf decimal(18,3),
   zl decimal(18,3),
   je decimal(18,3),
   bz string,
   js string,
   jgf decimal(18,3)
) partitioned by (dt string) location '/zfq_test_decent_cloud/ads_cx_sz_cpbcx_fjgf';



















select a.khbm as khbm,a.khmc as khmc,a.jz as jz,b.province as sf,b.jzhj as jzhj
	from (
	select tt.customer_code as khbm,
	tt.parent_customer_name as khmc,
	SUM(remaining_gold_weight) as jz
	from t_bf_receive_meterial h
	left join ods_cx_ztsz_lldfx_temp_customer tt on h.customer_identity=tt.customer_identity,
	t_bf_receive_meterial_detail b
	where h.receive_meterial_identity=b.receive_meterial_identity
	and h.status=0
	and material_explain_name='板料'
	and showroom_name='深圳展厅'
	and date_format(rq,'yyyy-MM-dd')='2023-01-03'
	and tt.parent_customer_name like '%特艺城%'
	and h.dt='2023-01-03'
	and b.dt='2023-01-03'
	group by tt.customer_code,tt.parent_customer_name) a
	left join ods_cx_ztsz_lldfx_temp_customer dd on dd.customer_code=a.khbm and dd.parent_customer_name=a.khmc
	left join (
	select if(dd.province is null, '',dd.province) as province,SUM(jz) as jzhj from (
	select
			tt.customer_code as khbm,
			tt.parent_customer_name as khmc,
			SUM(remaining_gold_weight) as jz
	from t_bf_receive_meterial h
	left join ods_cx_ztsz_lldfx_temp_customer tt on h.customer_identity=tt.customer_identity,
	t_bf_receive_meterial_detail b
	where h.receive_meterial_identity=b.receive_meterial_identity
	and h.status=0
	and material_explain_name='板料'
	and showroom_name='深圳展厅'
	and h.dt='2023-01-03'
	and b.dt='2023-01-03'
	and date_format(rq,'yyyy-MM-dd')='2023-01-03'
	and tt.parent_customer_name like '%特艺城%'
	group by tt.customer_code,tt.parent_customer_name,if(tt.child_customer_name is null,'',tt.child_customer_name)) a
	left join ods_cx_ztsz_lldfx_temp_customer dd on dd.customer_code=a.khbm and dd.parent_customer_name=a.khmc
	group by if(dd.province is null, '',dd.province )) b

 union  all



select a.khbm as khbm,a.khmc as khmc,a.jz as jz,b.province as sf,b.jzhj as jzhj
	from (
	select tt.customer_code as khbm,
	tt.parent_customer_name as khmc,
	SUM(remaining_gold_weight) as jz
	from t_bf_receive_meterial h
	left join ods_cx_ztsz_lldfx_temp_customer tt on h.customer_identity=tt.customer_identity,
	t_bf_receive_meterial_detail b
	where h.receive_meterial_identity=b.receive_meterial_identity
	and h.status=0
	and material_explain_name='板料'
	and showroom_name='深圳展厅'
	and date_format(rq,'yyyy-MM-dd')='2023-01-03'
	and tt.parent_customer_name like '%珠宝公司%'
	and h.dt='2023-01-03'
	and b.dt='2023-01-03'
	group by tt.customer_code,tt.parent_customer_name) a
	left join ods_cx_ztsz_lldfx_temp_customer dd on dd.customer_code=a.khbm and dd.parent_customer_name=a.khmc
	left join (
	select if(dd.province is null, '',dd.province) as province,SUM(jz) as jzhj from (
	select
			tt.customer_code as khbm,
			tt.parent_customer_name as khmc,
			SUM(remaining_gold_weight) as jz
	from t_bf_receive_meterial h
	left join ods_cx_ztsz_lldfx_temp_customer tt on h.customer_identity=tt.customer_identity,
	t_bf_receive_meterial_detail b
	where h.receive_meterial_identity=b.receive_meterial_identity
	and h.status=0
	and material_explain_name='板料'
	and showroom_name='深圳展厅'
	and h.dt='2023-01-03'
	and b.dt='2023-01-03'
	and date_format(rq,'yyyy-MM-dd')='2023-01-03'
	and tt.parent_customer_name like '%珠宝公司%'
	group by tt.customer_code,tt.parent_customer_name,if(tt.child_customer_name is null,'',tt.child_customer_name)) a
	left join ods_cx_ztsz_lldfx_temp_customer dd on dd.customer_code=a.khbm and dd.parent_customer_name=a.khmc
	group by if(dd.province is null, '',dd.province )) b
union all
select a.khbm as khbm,a.khmc as khmc,a.jz as jz,b.province as sf,b.jzhj as jzhj
	from (
	select tt.customer_code as khbm,
	tt.parent_customer_name as khmc,
	SUM(remaining_gold_weight) as jz
	from t_bf_receive_meterial h
	left join ods_cx_ztsz_lldfx_temp_customer tt on h.customer_identity=tt.customer_identity,
	t_bf_receive_meterial_detail b
	where h.receive_meterial_identity=b.receive_meterial_identity
	and h.status=0
	and material_explain_name='板料'
	and showroom_name='深圳展厅'
	and date_format(rq,'yyyy-MM-dd')='2023-01-03'
	and tt.parent_customer_name like '%鑫囍缘%'
	and h.dt='2023-01-03'
	and b.dt='2023-01-03'
	group by tt.customer_code,tt.parent_customer_name) a
	left join ods_cx_ztsz_lldfx_temp_customer dd on dd.customer_code=a.khbm and dd.parent_customer_name=a.khmc
	left join (
	select if(dd.province is null, '',dd.province) as province,SUM(jz) as jzhj from (
	select
			tt.customer_code as khbm,
			tt.parent_customer_name as khmc,
			SUM(remaining_gold_weight) as jz
	from t_bf_receive_meterial h
	left join ods_cx_ztsz_lldfx_temp_customer tt on h.customer_identity=tt.customer_identity,
	t_bf_receive_meterial_detail b
	where h.receive_meterial_identity=b.receive_meterial_identity
	and h.status=0
	and material_explain_name='板料'
	and showroom_name='深圳展厅'
	and h.dt='2023-01-03'
	and b.dt='2023-01-03'
	and date_format(rq,'yyyy-MM-dd')='2023-01-03'
	and tt.parent_customer_name like '%鑫囍缘%'
	group by tt.customer_code,tt.parent_customer_name,if(tt.child_customer_name is null,'',tt.child_customer_name)) a
	left join ods_cx_ztsz_lldfx_temp_customer dd on dd.customer_code=a.khbm and dd.parent_customer_name=a.khmc
	group by if(dd.province is null, '',dd.province )) b

union all

select a.khbm as khbm,a.khmc as khmc,a.jz as jz,b.province as sf,b.jzhj as jzhj
	from (
	select tt.customer_code as khbm,
	tt.parent_customer_name as khmc,
	SUM(remaining_gold_weight) as jz
	from t_bf_receive_meterial h
	left join ods_cx_ztsz_lldfx_temp_customer tt on h.customer_identity=tt.customer_identity,
	t_bf_receive_meterial_detail b
	where h.receive_meterial_identity=b.receive_meterial_identity
	and h.status=0
	and material_explain_name='板料'
	and showroom_name='深圳展厅'
	and date_format(rq,'yyyy-MM-dd')='2023-01-03'
	and tt.parent_customer_name  not like '%特艺城%' and tt.parent_customer_name  not like '%鑫囍缘%' and tt.parent_customer_name  not like '%珠宝公司%'
	and h.dt='2023-01-03'
	and b.dt='2023-01-03'
	group by tt.customer_code,tt.parent_customer_name) a
	left join ods_cx_ztsz_lldfx_temp_customer dd on dd.customer_code=a.khbm and dd.parent_customer_name=a.khmc
	left join (
	select if(dd.province is null, '',dd.province) as province,SUM(jz) as jzhj from (
	select
			tt.customer_code as khbm,
			tt.parent_customer_name as khmc,
			SUM(remaining_gold_weight) as jz
	from t_bf_receive_meterial h
	left join ods_cx_ztsz_lldfx_temp_customer tt on h.customer_identity=tt.customer_identity,
	t_bf_receive_meterial_detail b
	where h.receive_meterial_identity=b.receive_meterial_identity
	and h.status=0
	and material_explain_name='板料'
	and showroom_name='深圳展厅'
	and h.dt='2023-01-03'
	and b.dt='2023-01-03'
	and date_format(rq,'yyyy-MM-dd')='2023-01-03'
	and tt.parent_customer_name  not like '%特艺城%' and tt.parent_customer_name  not like '%鑫囍缘%' and tt.parent_customer_name  not like '%珠宝公司%'
	group by tt.customer_code,tt.parent_customer_name,if(tt.child_customer_name is null,'',tt.child_customer_name)) a
	left join ods_cx_ztsz_lldfx_temp_customer dd on dd.customer_code=a.khbm and dd.parent_customer_name=a.khmc
	group by if(dd.province is null, '',dd.province )) b;




create table IF NOT EXISTS ads_cx_ztsz_lldfx (
   khbm string,
   khmc string,
   jz decimal(18,3),
   sf string,
   jzhj decimal(18,3)
) partitioned by (dt string) location '/zfq_test_decent_cloud/ads_cx_ztsz_lldfx';


select * from ads_cx_ztsz_lldfx;



SELECT CASE WHEN CKMC = '镶嵌Q柜'  OR CKMC = '镶嵌硬金柜'OR CKMC = '镶嵌柜-德钰东方' or CKMC = '客单组镶嵌德钰东方' or CKMC = '客单组镶嵌柜' OR CKMC = '维修仓'
      THEN '千足嵌'
            WHEN (JSMC = '千足硬金') AND CKMC <> '镶嵌Q柜'
      AND CKMC <> '镶嵌硬金柜'AND CKMC <> '镶嵌柜-德钰东方'
      AND ckmc <> '客单组镶嵌德钰东方' AND ckmc <> '客单组镶嵌柜'
      AND CKMC <> '维修仓' AND CKMC <> '古法金柜'
      AND CKMC <> '精品G柜' AND CKMC <> '硬金古法金柜'
      and ckmc <> '无字印柜'
      and ckmc <> '客单组'
      and ckmc <> '配货中心'
      THEN '千足金'
            WHEN CKMC in ('料仓')
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
    WHEN CKMC in ('料仓')
    THEN CONCAT('料仓-', JSMC)
    ELSE CKMC
   END AS CKMC,
       QCJZ AS QC,
       QCJS AS QCJS,
       QCJE AS QCJE,
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
   FROM T_KA_ZTKCRZZ
 WHERE WDMC = '深圳展厅'
    AND date_format(RQ,'yyyy-MM-dd') = '2023-01-03'
	and dt='2023-01-03'
   AND (JSMC NOT LIKE '虚拟金料%');







SELECT T2.PARENT_CUSTOMER_NAME AS MC, 0.000 AS JZF, - SUM(if(T1.TOTAL_GOLD_WEIGHT is null, 0,T1.TOTAL_GOLD_WEIGHT )) AS SL, 0 AS GF, '' AS GFS
 FROM T_BF_PAY_OUTSOURCE T1
 LEFT JOIN ods_cx_ztsz_dtfkbb_new_view_customer T2
 ON T1.CUSTOMER_IDENTITY = T2.CUSTOMER_IDENTITY
 WHERE T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   AND T1.SHOWROOM_NAME = '深圳展厅'
   AND date_format(T1.CREATE_TIME,'yyyy-MM-dd') = '2022-01-04'
 GROUP BY T2.PARENT_CUSTOMER_NAME;







select concat(month('2023-01-05'),'月',day('2023-01-05'),'日');

select * from  ods_cx_ztsz_dtfkbb_new_view_customer;



SELECT SUPPLIER_NAME AS MC, SUM(if(RETURN_TOTAL_WEIGHT is null , 0,RETURN_TOTAL_WEIGHT)) AS JZF, 0.000 AS SL, SUM(if(RETURN_TOTAL_PRICE is null, 0,RETURN_TOTAL_PRICE)) AS GF, '' AS GFS
 FROM T_SALES_RETURN
 WHERE SHOWROOM_NAME = '深圳展厅'
   AND RETURN_STATUS <> '已作废'
   AND STATUS = 0
   AND SUPPLIER_TYPE = 1
   AND date_format(rq,'yyyy-MM-dd') = '2023-01-04'
   and dt='2023-01-04'
 GROUP BY SUPPLIER_NAME;



SELECT 2 AS XH, MC, round(SUM(if(JZF is null, 0,JZF)),3) AS JZF, round(SUM(if(SL is null, 0,SL)),3) AS SL, SUM(if(GF is null, 0,GF)) AS GF,
CASE WHEN SUM(if(GF is null, 0,GF)) = 0 THEN '' ELSE if(SUM(GF) is null, 0,SUM(GF) ) END AS GFS,
'' AS BZ FROM
(SELECT * FROM ods_cx_ztsz_dtfkbb_new_temp1
 UNION ALL
 SELECT * FROM ods_cx_ztsz_dtfkbb_new_temp2) A
 GROUP BY MC;


SELECT CONCAT(T3.PARENT_CUSTOMER_NAME, T3.CHILD_CUSTOMER_NAME) AS MC,
              SUM(if(T2.GOLD_WEIGHT is null, 0,T2.GOLD_WEIGHT)) AS JZF,
              0.000 AS SL,
              NULL AS GF,
              '' AS GFS,
      CASE WHEN if(t1.IF_PRINT_REMARK is null, 0,t1.IF_PRINT_REMARK) = 1 THEN T1.REMARK ELSE '' END AS BZ

  FROM T_SALE_FROM T1
 INNER JOIN T_SALE_FROM_ACCOUNT_DETAIL T2
     ON T1.SALE_IDENTITY = T2.SALE_IDENTITY
      AND T2.STATUS = 0
	  and t1.dt='2023-01-04'
	  and t2.dt='2023-01-04'
  INNER JOIN ods_cx_ztsz_dtfkbb_new_view_customer T3
       ON T1.SETTLE_ACCOUNTS_IDENTITY = T3.CUSTOMER_IDENTITY
 WHERE T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   AND (T2.ACCOUNT_METHOD = '转欠饰' OR T2.ACCOUNT_METHOD = '转欠料')
   AND T2.WORK_FEE_TYPE <> '做现转欠'
   AND T1.SHOWROOM_NAME = '深圳展厅'
   AND date_format(T1.BILL_DATE,'yyyy-MM-dd') = '2023-01-04'
 GROUP BY T3.PARENT_CUSTOMER_NAME, T3.CHILD_CUSTOMER_NAME, t1.IF_PRINT_REMARK, T1.REMARK;

SELECT MC, SUM(JZF) AS JZF, 0.000 AS SL, 0 AS GF, '' AS GFS, BZ
 FROM ods_cx_ztsz_dtfkbb_new_temp499
GROUP BY MC, BZ;




SELECT CONCAT(T2.PARENT_CUSTOMER_NAME, T2.CHILD_CUSTOMER_NAME) AS MC, JZF, SL, GF, GFS, BZ FROM (
 SELECT CUSTOMER_IDENTITY,
         0.000 AS JZF,
                0.000 AS SL,
                MONEY AS GF,
                '' AS GFS,
                REMARKS AS BZ
    FROM T_BF_REPAIR
  WHERE date_format(CREATE_TIME,'yyyy-MM-dd') = '2023-01-04'
    AND APPROVE_STATUS = 1
    AND STATUS = 0
	and dt='2023-01-04'
 UNION ALL
 SELECT CUSTOMER_IDENTITY,
         0.000 AS JZF,
                0.000 AS SL,
                0 - MONEY AS GF,
                '' AS GFS,
                REMARKS AS BZ
    FROM T_BF_RETREAT
  WHERE date_format(CREATE_TIME,'yyyy-MM-dd') = '2023-01-04'
    AND APPROVE_STATUS = 1
    AND STATUS = 0
	and dt='2023-01-04'
)A
INNER JOIN ods_cx_ztsz_dtfkbb_new_view_customer T2
       ON A.CUSTOMER_IDENTITY = T2.CUSTOMER_IDENTITY;



SELECT CONCAT(T3.PARENT_CUSTOMER_NAME, T3.CHILD_CUSTOMER_NAME) AS MC, round(SUM(JZF),3) AS JZF, round(SUM(SL),3) AS SL, round(SUM(JZF)-SUM(SL),3) AS DD FROM (
SELECT T1.SETTLE_ACCOUNTS_IDENTITY AS CUSTOMER_IDENTITY,
              SUM(if(T2.GOLD_WEIGHT is null, 0,T2.GOLD_WEIGHT)) AS JZF,
              0.000 AS SL
FROM T_SALE_FROM T1
 INNER JOIN T_SALE_FROM_ACCOUNT_DETAIL T2
     ON T1.SALE_IDENTITY = T2.SALE_IDENTITY
      AND T2.STATUS = 0
	  and t1.dt='2023-01-04'
	  and t2.dt='2023-01-04'
 WHERE T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   AND T2.WORK_FEE_TYPE LIKE '%做现转欠%'
   AND if(t1.IF_PRINT_REMARK is null, 0,t1.IF_PRINT_REMARK) = 0
   AND T1.SHOWROOM_NAME = '深圳展厅'
   AND date_format(T1.BILL_DATE,'yyyy-MM-dd') = '2023-01-04'
GROUP BY T1.SETTLE_ACCOUNTS_IDENTITY
UNION ALL
SELECT T1.CUSTOMER_IDENTITY,
       0.000 AS JZF,
       SUM(if(T1.REMAINING_GOLD_WEIGHT_TOTAL is null, 0,T1.REMAINING_GOLD_WEIGHT_TOTAL)) AS SL
  FROM T_BF_RECEIVE_METERIAL T1
 WHERE T1.SHOWROOM_NAME = '深圳展厅'
   AND date_format(T1.RECORD_DATE,'yyyy-MM-dd') = '2023-01-04'
   AND T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   and t1.dt='2023-01-04'
   AND if(T1.IS_BEFORE_DATE_RECEIVE is null, 0,T1.IS_BEFORE_DATE_RECEIVE) = 0
   AND if(T1.SALES_NO is null , '',T1.SALES_NO ) = ''
 GROUP BY T1.CUSTOMER_IDENTITY) A
  INNER JOIN ods_cx_ztsz_dtfkbb_new_view_customer T3
       ON A.CUSTOMER_IDENTITY = T3.CUSTOMER_IDENTITY
GROUP BY CONCAT(T3.PARENT_CUSTOMER_NAME, T3.CHILD_CUSTOMER_NAME);



SELECT CONCAT(T2.PARENT_CUSTOMER_NAME, if(T2.CHILD_CUSTOMER_NAME is null, '',T2.CHILD_CUSTOMER_NAME)) AS MC,
       0.000 AS JZF,
       CASE WHEN T2.PARENT_CUSTOMER_NAME = '深圳工厂' THEN SUM(if(T1.RECEIVE_GOLD_WEIGHT is null, 0,T1.RECEIVE_GOLD_WEIGHT)) ELSE SUM(if(T1.REMAINING_GOLD_WEIGHT_TOTAL is null, 0,T1.REMAINING_GOLD_WEIGHT_TOTAL)) END AS SL,
             SUM(if(T1.SUM_AMOUNT is null, 0,T1.SUM_AMOUNT)) AS GF,
              '' AS GFS,
       CASE WHEN if(T1.SHOW_MEMO is null, 0,T1.SHOW_MEMO) = 1 THEN T1.REMARKS ELSE '' END AS BZ
  FROM T_BF_RECEIVE_METERIAL T1
 INNER JOIN ods_cx_ztsz_dtfkbb_new_view_customer T2
       ON T1.CUSTOMER_IDENTITY = T2.CUSTOMER_IDENTITY
 WHERE T1.SHOWROOM_NAME = '深圳展厅'
   AND date_format(T1.RECORD_DATE,'yyyy-MM-dd') = '2023-01-04'
   AND T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   and t1.dt='2023-01-04'
GROUP BY T2.PARENT_CUSTOMER_NAME, T2.CHILD_CUSTOMER_NAME, T1.SHOW_MEMO, T1.REMARKS;


SELECT CONCAT(T2.PARENT_CUSTOMER_NAME, T2.CHILD_CUSTOMER_NAME) AS MC,
              0.000 AS JZF,
              0.000 AS SL,
              SUM(if(T1.TOTAL_PRICE is null, 0,T1.TOTAL_PRICE )) AS GF,
       if(SUM(T1.TOTAL_PRICE) is null, 0,SUM(T1.TOTAL_PRICE)) AS GFS,
       CASE WHEN if(t1.IF_PRINT_REMARK is null, 0,t1.IF_PRINT_REMARK) = 1 THEN T1.REMARK ELSE '' END AS BZ
  FROM T_SALE_FROM T1
  INNER JOIN ods_cx_ztsz_dtfkbb_new_view_customer T2
       ON T1.SETTLE_ACCOUNTS_IDENTITY = T2.CUSTOMER_IDENTITY
 WHERE T1.SHOWROOM_NAME = '深圳展厅'
   AND date_format(T1.BILL_DATE,'yyyy-MM-dd') = '2023-01-04'
   AND T2.PARENT_CUSTOMER_NAME <> '山东运营中心'
   AND T2.PARENT_CUSTOMER_NAME <> '山东鑫囍缘运营中心'
   AND if(T1.SALE_TYPE is null, '',T1.SALE_TYPE) <> 'JL'
      AND T1.APPROVE_STATUS = 1
      AND T1.STATUS = 0
	  and t1.dt='2023-01-04'
GROUP BY T2.PARENT_CUSTOMER_NAME, T2.CHILD_CUSTOMER_NAME, t1.IF_PRINT_REMARK, T1.REMARK;


SELECT KHMC AS MC, 0.000 AS JZF, 0.000 AS SL, 0-DJJE AS GF, '' AS GFS, '' AS BZ
FROM (
SELECT CONCAT(T2.PARENT_CUSTOMER_NAME, if(T2.CHILD_CUSTOMER_NAME is null, '',T2.CHILD_CUSTOMER_NAME)) AS KHMC,
       SUM(T1.TOTAL_PRICE) AS DJJE
  FROM T_BF_CUS_DEBIT_RECEIPT T1
  INNER JOIN ods_cx_ztsz_dtfkbb_new_view_customer T2
       ON T1.CUSTOMER_IDENTITY = T2.CUSTOMER_IDENTITY
 WHERE date_format(T1.CREATE_TIME,'yyyy-MM-dd') = '2023-01-04'
   AND T1.SHOWROOM_NAME = '深圳展厅'
   AND T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   and t1.dt='2023-01-04'
   AND if(T1.TODAY_SETTLE is null, 0,T1.TODAY_SETTLE) = 1
GROUP BY T2.PARENT_CUSTOMER_NAME, if(T2.CHILD_CUSTOMER_NAME is null , '',T2.CHILD_CUSTOMER_NAME)) A;



SELECT MC,
       if(SUM(JZF) is null, 0,SUM(JZF)) AS JZF,
       if(SUM(SL) is null, 0,SUM(SL)) AS SL,
       if(SUM(GF) is null, 0,SUM(GF)) AS GF,
       CASE WHEN if(SUM(GF) is null, 0,SUM(GF)) = 0 THEN '' ELSE SUM(GF) END AS GFS,
       BZ
  FROM (SELECT MC,JZF,SL,if(GF is null,0,gf) AS GF,if(GFS is null,'',gfs) AS GFS, BZ FROM ods_cx_ztsz_dtfkbb_new_temp4_new
        UNION ALL
        SELECT MC,JZF,SL,if(GF is null,0,gf) AS GF,if(GFS is null,'',gfs) AS GFS, BZ FROM ods_cx_ztsz_dtfkbb_new_temp4998
        UNION ALL
        SELECT MC,JZF,SL,if(GF is null,0,gf) AS GF,if(GFS is null,'',gfs) AS GFS, BZ FROM ods_cx_ztsz_dtfkbb_new_temp5
        UNION ALL
        SELECT MC,JZF,SL,if(GF is null,0,gf) AS GF,if(GFS is null,'',gfs) AS GFS, BZ FROM ods_cx_ztsz_dtfkbb_new_temp6
        UNION ALL
        SELECT MC,JZF,SL,if(GF is null,0,gf) AS GF,if(GFS is null,'',gfs) AS GFS, BZ FROM ods_cx_ztsz_dtfkbb_new_temp7
        ) A GROUP BY MC, BZ;



SELECT 4 AS XH,
       CONCAT('购', T3.PARENT_CUSTOMER_NAME, if(T3.CHILD_CUSTOMER_NAME is null , '',T3.CHILD_CUSTOMER_NAME), if(T4.PURITY_NAME is null,'',T4.PURITY_NAME)) AS MC,
              0.000 AS JZF,
              SUM(if(T2.GOLD_WEIGHT is null, 0,T2.GOLD_WEIGHT)) AS SL,
              0.000 AS GF,
			 sum(if(T2.PRICE is null, 0,T2.PRICE)) as GFS,
              '' AS BZ
  FROM T_BF_BUY_CUS_MATERIAL T1
  INNER JOIN T_BF_BUY_CUS_MATERIAL_DETAIL T2
     ON T1.BUY_CUS_IDENTITY = T2.BUY_CUS_IDENTITY and t1.dt= '2023-01-04' and t2.dt= '2023-01-04'
  INNER JOIN ods_cx_ztsz_dtfkbb_new_view_customer T3
     ON T1.CUSTOMER_IDENTITY = T3.CUSTOMER_IDENTITY
  LEFT JOIN T_PURITY T4
     ON T2.PURITY_IDENTITY = T4.PURITY_IDENTITY and t4.dt= '2023-01-04'
 WHERE T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   AND T1.SHOWROOM_NAME = '深圳展厅'
   AND date_format(T1.CREATE_TIME,'yyyy-MM-dd') =  '2023-01-04'
 GROUP BY T3.PARENT_CUSTOMER_NAME, T3.CHILD_CUSTOMER_NAME, T4.PURITY_NAME, T2.UNIT_PRICE;




desc formatted T_BF_BUY_CUS_MATERIAL_DETAIL;




SELECT 5 AS XH,
       CONCAT('售', T3.PARENT_CUSTOMER_NAME, CASE WHEN T3.CHILD_CUSTOMER_NAME = '' THEN T2.PURITY_NAME ELSE CONCAT(T3.CHILD_CUSTOMER_NAME, '', T2.PURITY_NAME, '') END) AS MC,
       0.000 AS JZF,
       - SUM(if(T2.GOLD_WEIGHT is null, 0 ,T2.GOLD_WEIGHT)) AS SL,
      0.000 AS GF,
       CONCAT('*',T2.UNIT_PRICE,' = ',T2.AMOUNT) AS GFS,
       CASE WHEN if(T1.IF_PRINT_REMARK is null, 0,T1.IF_PRINT_REMARK ) = 1 THEN T1.REMARK ELSE '' END AS BZ
   FROM T_SALE_FROM T1
 INNER JOIN T_SALE_FROM_ACCOUNT_DETAIL T2 ON T1.SALE_IDENTITY = T2.SALE_IDENTITY
      AND T2.STATUS = 0
	  and t1.dt='2023-01-04'
	  and t2.dt='2023-01-04'
  inner JOIN ods_cx_ztsz_dtfkbb_new_view_customer T3
     ON T1.SETTLE_ACCOUNTS_IDENTITY = T3.CUSTOMER_IDENTITY
 WHERE T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   AND T1.SALE_TYPE = 'JL'
      AND T1.SHOWROOM_NAME = '深圳展厅'
   AND date_format(T1.BILL_DATE,'yyyy-MM-dd') = '2023-01-04'
GROUP BY T3.PARENT_CUSTOMER_NAME, T3.CHILD_CUSTOMER_NAME, T2.PURITY_NAME, T2.AMOUNT, T2.UNIT_PRICE, T1.IF_PRINT_REMARK, T1.REMARK;



SELECT 6 AS XH,
       T2.PARENT_CUSTOMER_NAME AS MC,
              0.000 AS JZF,
              if(SUM(T1.TOTAL_GOLD_WEIGHT) is null, 0,SUM(T1.TOTAL_GOLD_WEIGHT)) AS SL,
              -if(SUM(T1.TOTAL_PRICE) is null, 0,SUM(T1.TOTAL_PRICE)) AS GF,
              -if(SUM(T1.TOTAL_PRICE) is null, 0,SUM(T1.TOTAL_PRICE)) AS GFS,
              '' AS BZ
  FROM T_BF_CHANGE_OUTSOURCE T1
  INNER JOIN ods_cx_ztsz_dtfkbb_new_view_customer T2
     ON T1.CUSTOMER_IDENTITY = T2.CUSTOMER_IDENTITY
 WHERE T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   and t1.dt='2023-01-04'
   AND T1.SHOWROOM_NAME = '深圳展厅'
   AND date_format(T1.CREATE_TIME,'yyyy-MM-dd') = '2023-01-04'
 GROUP BY T2.PARENT_CUSTOMER_NAME;



SELECT 6 AS XH,
       CONCAT(T2.PARENT_CUSTOMER_NAME, if(T2.CHILD_CUSTOMER_NAME is null, '',T2.CHILD_CUSTOMER_NAME)) AS MC,
              0.000 AS JZF,
              - if(SUM(T1.TOTAL_GOLD_WEIGHT) is null, 0,SUM(T1.TOTAL_GOLD_WEIGHT)) AS SL,
              NULL AS GF,
              '' AS GFS,
              '' AS BZ
  FROM T_BF_PAY_CUS_MATERIAL T1
  INNER JOIN ods_cx_ztsz_dtfkbb_new_view_customer T2
     ON T1.CUSTOMER_IDENTITY = T2.CUSTOMER_IDENTITY
 WHERE T1.APPROVE_STATUS = 1
   and t1.dt='2023-01-04'
   AND T1.STATUS = 0
   AND T1.SHOWROOM_NAME = '深圳展厅'
   AND date_format(T1.CREATE_TIME,'yyyy-MM-dd') = '2023-01-04'
GROUP BY T2.PARENT_CUSTOMER_NAME, T2.CHILD_CUSTOMER_NAME;




SELECT 7 AS XH, '当日成品结价' AS MC, SUM(if(T2.GOLD_WEIGHT is null, 0,T2.GOLD_WEIGHT ))AS JZF, 0.000 AS SL, NULL AS GF, '' AS GFS, '' AS BZ
  FROM T_SALE_FROM T1
 INNER JOIN T_SALE_FROM_ACCOUNT_DETAIL T2
     ON T1.SALE_IDENTITY = T2.SALE_IDENTITY
      AND T2.STATUS = 0
 WHERE T2.ACCOUNT_METHOD = '结价'
   AND T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   and t1.dt='2023-01-04'
      AND T1.SHOWROOM_NAME = '深圳展厅'
   AND date_format(T1.BILL_DATE,'yyyy-MM-dd') ='2023-01-04'
   AND T1.SALE_TYPE <> 'JL';



SELECT 8 AS XH, '客贴工费料' AS MC, SUM(if(T2.GOLD_WEIGHT is null, 0,T2.GOLD_WEIGHT))AS JZF, SUM(if(T2.GOLD_WEIGHT is null, 0,T2.GOLD_WEIGHT)) AS SL, NULL AS GF, '' AS GFS, '' AS BZ
  FROM T_SALE_FROM T1
 INNER JOIN T_SALE_FROM_ACCOUNT_DETAIL T2
     ON T1.SALE_IDENTITY = T2.SALE_IDENTITY
      AND T2.STATUS = 0
 WHERE T2.ACCOUNT_METHOD = '来料'
   AND T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   and t1.dt='2023-01-04'
   and t2.dt='2023-01-04'
      AND T1.SHOWROOM_NAME = '深圳展厅'
   AND date_format(T1.BILL_DATE,'yyyy-MM-dd') = '2023-01-04';


SELECT 9 AS XH,
       '退千足成品' AS MC,
       SUM(if(T2.WEIGHT is null, 0,T2.WEIGHT))AS JZF,
              SUM(if(T2.WEIGHT is null, 0,T2.WEIGHT)) AS SL,
              null AS GF,
              '' AS GFS,
              '' AS BZ

  FROM T_BF_GOLD_TRANSFER_OUT T1
 INNER JOIN T_BF_GOLD_TRANSFER_OUT_DETAIL T2
        ON T1.TRANSFER_OUT_IDENTITY = T2.TRANSFER_OUT_IDENTITY
 WHERE T1.TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND T1.TRANSFER_IN_SHOWROOM = '福州工厂'
   AND date_format(T1.APPROVE_TIME,'yyyy-MM-dd') = '2023-01-04'
   AND T1.APPROVE_STATUS = 1
   and t1.dt='2023-01-04'
   and t2.dt='2023-01-04'
   AND T1.STATUS = 0
   AND T1.GENUS_NAME <> '金料'
   AND T1.purity_name <> '金9999'
   AND T1.purity_name <> '金99999'
      AND T1.purity_name <> '古法金'
      AND T1.purity_name <> '足金(5G)'
   AND T1.purity_name <> '古法万足金'
      AND T1.purity_name <> '古法999.99'
      AND T1.purity_name <> '足金(无氰)';



SELECT 9 AS XH,
      '退万足成品' AS MC,
            SUM(if(T2.WEIGHT is null, 0,T2.WEIGHT))AS JZF,
            SUM(if(T2.WEIGHT is null, 0,T2.WEIGHT)) AS SL,
            null AS GF,
            '' AS GFS,
            '' AS BZ
  FROM T_BF_GOLD_TRANSFER_OUT T1
 INNER JOIN T_BF_GOLD_TRANSFER_OUT_DETAIL T2
        ON T1.TRANSFER_OUT_IDENTITY = T2.TRANSFER_OUT_IDENTITY
 WHERE T1.TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND T1.TRANSFER_IN_SHOWROOM = '福州工厂'
   AND date_format(T1.APPROVE_TIME,'yyyy-MM-dd') = '2023-01-04'
   and t1.dt='2023-01-04'
   and t2.dt='2023-01-04'
   AND T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   AND T1.GENUS_NAME <> '金料'
   AND T1.PURITY_NAME = '金9999';


SELECT 9 AS XH,
       '退五九金成品' AS MC,
             SUM(if(T2.WEIGHT is null, 0,T2.WEIGHT)) AS JZF,
              SUM(if(T2.WEIGHT is null, 0,T2.WEIGHT)) AS SL,
              null AS GF,
              '' AS GFS,
              '' AS BZ
FROM T_BF_GOLD_TRANSFER_OUT T1
 INNER JOIN T_BF_GOLD_TRANSFER_OUT_DETAIL T2
        ON T1.TRANSFER_OUT_IDENTITY = T2.TRANSFER_OUT_IDENTITY
 WHERE T1.TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND T1.TRANSFER_IN_SHOWROOM = '福州工厂'
   AND date_format(T1.APPROVE_TIME,'yyyy-MM-dd') = '2023-01-04'
   AND T1.APPROVE_STATUS = 1
   and t1.dt='2023-01-04'
   and t2.dt='2023-01-04'
   AND T1.STATUS = 0
   AND T1.GENUS_NAME <> '金料'

   AND T1.PURITY_NAME = '金99999';






SELECT 9 AS XH,
       '退古法金成品' AS MC,
       SUM(if(T2.WEIGHT is null, 0,T2.WEIGHT )) AS JZF,
       SUM(if(T2.WEIGHT is null, 0,T2.WEIGHT )) AS SL,
       null AS GF,
       '' AS GFS,
       '' AS BZ
FROM T_BF_GOLD_TRANSFER_OUT T1
 INNER JOIN T_BF_GOLD_TRANSFER_OUT_DETAIL T2
        ON T1.TRANSFER_OUT_IDENTITY = T2.TRANSFER_OUT_IDENTITY
 WHERE T1.TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND T1.TRANSFER_IN_SHOWROOM = '福州工厂'
   AND date_format(T1.APPROVE_TIME,'yyyy-MM-dd') = '2023-01-04'
   AND T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   and t1.dt='2023-01-04'
   and t2.dt='2023-01-04'
   AND T1.GENUS_NAME <> '金料'
   AND T1.PURITY_NAME = '古法金';






SELECT 9 AS XH, '退5G金成品' AS MC, SUM(if(T2.WEIGHT is null , 0,T2.WEIGHT))AS JZF, SUM(if(T2.WEIGHT is null , 0,T2.WEIGHT)) AS SL,null AS GF, '' AS GFS, '' AS BZ

FROM T_BF_GOLD_TRANSFER_OUT T1
 INNER JOIN T_BF_GOLD_TRANSFER_OUT_DETAIL T2
        ON T1.TRANSFER_OUT_IDENTITY = T2.TRANSFER_OUT_IDENTITY
 WHERE T1.TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND T1.TRANSFER_IN_SHOWROOM = '福州工厂'
   AND date_format(T1.APPROVE_TIME,'yyyy-MM-dd') = '2023-01-04'
   AND T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   and t1.dt='2023-01-04'
   and t2.dt='2023-01-04'
   AND T1.GENUS_NAME <> '金料'
   AND T1.PURITY_NAME = '足金(5G)';


SELECT 9 AS XH, '退古法万足成品' AS MC, SUM(if(T2.WEIGHT is null , 0,T2.WEIGHT))AS JZF, SUM(if(T2.WEIGHT is null , 0,T2.WEIGHT)) AS SL, null AS GF, '' AS GFS, '' AS BZ

FROM T_BF_GOLD_TRANSFER_OUT T1
 INNER JOIN T_BF_GOLD_TRANSFER_OUT_DETAIL T2
        ON T1.TRANSFER_OUT_IDENTITY = T2.TRANSFER_OUT_IDENTITY
 WHERE T1.TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND T1.TRANSFER_IN_SHOWROOM = '福州工厂'
   AND date_format(T1.APPROVE_TIME,'yyyy-MM-dd') = '2023-01-04'
   AND T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   and t1.dt='2023-01-04'
   and t2.dt='2023-01-04'
   AND T1.GENUS_NAME <> '金料'
   AND T1.PURITY_NAME = '古法万足金';


SELECT 9 AS XH, '退古法999.99成品' AS MC, SUM(if(T2.WEIGHT is null , 0,T2.WEIGHT))AS JZF, SUM(if(T2.WEIGHT is null , 0,T2.WEIGHT)) AS SL, null AS GF, '' AS GFS, '' AS BZ
FROM T_BF_GOLD_TRANSFER_OUT T1
 INNER JOIN T_BF_GOLD_TRANSFER_OUT_DETAIL T2
        ON T1.TRANSFER_OUT_IDENTITY = T2.TRANSFER_OUT_IDENTITY
 WHERE T1.TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND T1.TRANSFER_IN_SHOWROOM = '福州工厂'
   AND date_format(T1.APPROVE_TIME,'yyyy-MM-dd') = '2023-01-04'
   AND T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   and t1.dt='2023-01-04'
   and t2.dt='2023-01-04'
   AND T1.GENUS_NAME <> '金料'
   AND T1.PURITY_NAME = '古法999.99';





















SELECT 9 AS XH, '退足金(无氰)成品' AS MC, SUM(if(T2.WEIGHT is null, 0,T2.WEIGHT))AS JZF, SUM(if(T2.WEIGHT is null, 0,T2.WEIGHT)) AS SL, null AS GF, '' AS GFS, '' AS BZ
FROM T_BF_GOLD_TRANSFER_OUT T1
 INNER JOIN T_BF_GOLD_TRANSFER_OUT_DETAIL T2
        ON T1.TRANSFER_OUT_IDENTITY = T2.TRANSFER_OUT_IDENTITY
 WHERE T1.TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND T1.TRANSFER_IN_SHOWROOM = '福州工厂'
   AND date_format(T1.APPROVE_TIME,'yyyy-MM-dd') = '2023-01-04'
   AND T1.APPROVE_STATUS = 1
   AND T1.STATUS = 0
   and t1.dt='2023-01-04'
   and t2.dt='2023-01-04'
   AND T1.GENUS_NAME <> '金料'
   AND T1.PURITY_NAME = '足金(无氰)';


SELECT '特艺城' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, sum(if(ROUND(TOTAL_PRICE) is null,0,ROUND(TOTAL_PRICE)))  AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '特艺城展厅'
   AND date_format(DELIVER_GOODS_TIME,'yyyy-MM-dd') = '2023-01-04'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   and dt='2023-01-04'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';


SELECT '特艺城' AS MC, 0.000 AS JZF, -SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, sum(if(ROUND(TOTAL_PRICE) is null,0,ROUND(TOTAL_PRICE)))  AS GF, SUM(TOTAL_PRICE)  AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '特艺城展厅'
    AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-04'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   and dt='2023-01-04'
    AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';























SELECT '北京展厅' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE) )AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '北京运营中心'
    AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-04'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   and dt='2023-01-04'
    AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';


SELECT '北京展厅' AS MC, 0.000 AS JZF, -SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE )) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '北京运营中心'
    AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-04'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
     and dt='2023-01-04'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';




SELECT '北京金德尚' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE )) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '北京金德尚运营中心'
    AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-04'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   and dt='2023-01-04'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';


SELECT '北京金德尚' AS MC, 0.000 AS JZF, -SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, SUM(if(TOTAL_PRICE is null, 0,(TOTAL_PRICE ))) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '北京金德尚运营中心'
    AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-04'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
  and dt='2023-01-04'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';


SELECT 11 AS XH, MC, SUM(if(JZF is null, 0,JZF)) AS JZF, SUM(if(SL is null, 0,SL)) AS SL,
SUM(if(GF is null, 0,GF)) AS GF,
 CASE WHEN SUM(if(GF is null, 0,GF)) = 0 THEN '' ELSE SUM(if(GF is null, 0,GF)) END AS GFS,
 '' AS BZ FROM
(SELECT * FROM ods_cx_ztsz_dtfkbb_new_temp1160
UNION ALL
SELECT * FROM ods_cx_ztsz_dtfkbb_new_temp2160
) A GROUP BY MC;



SELECT '山东展厅' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF,SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '山东运营中心'
    AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-04'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
and dt='2023-01-04'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';



SELECT '山东展厅' AS MC, 0.000 AS JZF, -SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF,SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '山东运营中心'
    AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-04'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
  and dt='2023-01-04'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';















SELECT '南昌展厅' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '江西南昌展厅'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';


SELECT '南昌展厅' AS MC, 0.000 AS JZF, -SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '江西南昌展厅'

   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';


SELECT 12 AS XH, MC, SUM(if(JZF is null, 0,JZF)) AS JZF, SUM(if(SL is null, 0,SL)) AS SL,
SUM(if(GF is null, 0,GF)) AS GF,
 CASE WHEN SUM(if(GF is null, 0,GF)) = 0 THEN '' ELSE SUM(if(GF is null, 0,GF)) END AS GFS,
 '' AS BZ FROM
(SELECT * FROM TEMP1178
UNION ALL
SELECT * FROM TEMP2178
) A GROUP BY MC;




SELECT '江西金德尚' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '江西金德尚运营中心'

   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';

SELECT '江西金德尚' AS MC, 0.000 AS JZF, -SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '江西金德尚运营中心'

   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';


SELECT 11 AS XH, MC, SUM(if(JZF is null, 0,JZF)) AS JZF, SUM(if(SL is null, 0,SL)) AS SL,
SUM(if(GF is null, 0,GF)) AS GF,
 CASE WHEN SUM(if(GF is null, 0,GF)) = 0 THEN '' ELSE SUM(if(GF is null, 0,GF)) END AS GFS,
 '' AS BZ FROM
(SELECT * FROM TEMP110
UNION ALL
SELECT * FROM TEMP210
) A GROUP BY MC;



SELECT 'K金展厅' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = 'K金展厅'

   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';

SELECT 'K金展厅' AS MC, 0.000 AS JZF, -SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = 'K金展厅'

   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';

SELECT 12 AS XH, MC, SUM(if(JZF is null, 0,JZF)) AS JZF, SUM(if(SL is null, 0,SL)) AS SL,
SUM(if(GF is null, 0,GF)) AS GF,
 CASE WHEN SUM(if(GF is null, 0,GF)) = 0 THEN '' ELSE SUM(if(GF is null, 0,GF)) END AS GFS,
 '' AS BZ FROM
(SELECT * FROM TEMP11700
UNION ALL
SELECT * FROM TEMP21700
) A GROUP BY MC;


SELECT *  FROM (
SELECT '总部五楼展厅(万足)' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '总部万足展厅'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'
   AND PURITY_NAME = '金9999'
UNION ALL
SELECT '总部五楼展厅(五九)' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '总部万足展厅'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'
   AND PURITY_NAME = '金99999'
UNION ALL
SELECT '总部五楼展厅(千足)' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '总部万足展厅'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'
   AND PURITY_NAME <> '金9999'AND PURITY_NAME <> '金99999') A;


SELECT '总部五楼展厅' AS MC, 0.000 AS JZF, -SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '总部万足展厅'

   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';


SELECT * FROM (
SELECT '德诚珠宝(万足)' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '德诚珠宝'

   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'
   AND PURITY_NAME = '金9999'
UNION ALL
SELECT '德诚珠宝(五九)' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '德诚珠宝'

   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'
   AND PURITY_NAME = '金99999'
UNION ALL
SELECT '德诚珠宝(千足)' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '德诚珠宝'

   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'
   AND PURITY_NAME <> '金9999'
      AND PURITY_NAME <> '金99999') A;



SELECT '德诚珠宝' AS MC, 0.000 AS JZF, -SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '德诚珠宝'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';


SELECT '商品中心(XXY)' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '商品中心(XXY)'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';


SELECT '商品中心(XXY)' AS MC, 0.000 AS JZF, -SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '商品中心(XXY)'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
      and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';


SELECT '浙江德鑫' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF,  SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '浙江德鑫'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';


SELECT '深圳工厂' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(TOTAL_PRICE) AS GF,  SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '深圳工厂'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
     and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';


SELECT '钻石厂（深圳采购部）' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, NULL AS GF, '' AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '钻石厂（深圳采购部）'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
     and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';



SELECT '成都展厅' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF,  SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '成都展厅'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
     and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';


SELECT '海南展厅' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF,  SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '海南展厅'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
     and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料';


SELECT '海南展厅' AS MC, 0.000 AS JZF, -SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF,  SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '海南展厅'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
     and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';


SELECT '沈阳展厅' AS MC, 0.000 AS JZF, -SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF,  SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '沈阳展厅'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
     and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';



SELECT 2 AS XH, '深圳工厂' AS MC, 0.000 AS JZF, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, 0-SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF,
 CASE WHEN SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) = 0 THEN '' ELSE 0-SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) END AS GFS,
 '' AS BZ
FROM T_BF_GOLD_TRANSFER_IN
 WHERE TRANSFER_OUT_SHOWROOM = '深圳工厂'
   AND date_format(APPROVE_TIME,'yyyy-MM-dd')= '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
     and dt='2023-01-05'
   AND TRANSFER_IN_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';



SELECT 13 AS XH, '福州工厂' AS MC, 0.000 AS JZF, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, 0 AS GF,
       '' AS GFS,
       '' AS BZ
  FROM T_BF_GOLD_TRANSFER_IN
 WHERE TRANSFER_OUT_SHOWROOM = '福州工厂'
   AND date_format(APPROVE_TIME,'yyyy-MM-dd')= '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
     and dt='2023-01-05'
   AND TRANSFER_IN_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';



SELECT 13 AS XH, '特艺城' AS MC, 0.000 AS JZF, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, 0-SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF,
 CASE WHEN SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) = 0 THEN '' ELSE 0-SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) END AS GFS,
 '' AS BZ
FROM T_BF_GOLD_TRANSFER_IN
 WHERE TRANSFER_OUT_SHOWROOM = '特艺城展厅'
   AND date_format(APPROVE_TIME,'yyyy-MM-dd')= '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
     and dt='2023-01-05'
   AND TRANSFER_IN_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';





SELECT 13 AS XH, '北京展厅' AS MC, 0.000 AS JZF, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT)) AS SL, 0-SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) AS GF,
 CASE WHEN SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) = 0 THEN '' ELSE 0-SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE)) END AS GFS,
 '' AS BZ
FROM T_BF_GOLD_TRANSFER_IN
 WHERE TRANSFER_OUT_SHOWROOM = '北京运营中心'
   AND date_format(APPROVE_TIME,'yyyy-MM-dd')= '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
     and dt='2023-01-05'
   AND TRANSFER_IN_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';

SELECT 15 AS XH, '昨日余料' AS MC, 0.000 AS JZF, SUM(if(QCJZ is null, 0,QCJZ)) AS SL, NULL AS GF, '' AS GFS, '' AS BZ
  FROM T_KA_ZTKCRZZ
 WHERE WDMC = '深圳展厅'
   AND date_format(RQ,'yyyy-MM-dd') = '2023-01-05'
   and dt='2023-01-05'
   AND CKMC IN ('料仓');



SELECT 16 AS XH, '余料' AS MC, 0.000 AS JZF, 0-SUM(if(SL is null, 0,SL)) AS SL, NULL AS GF, '' AS GFS, '' AS BZ  FROM(
SELECT '余料' AS MC, NULL AS JZF, SUM(if(QCJZ is null, 0,QCJZ)) AS SL, NULL AS GF, '' AS GFS
  FROM T_KA_ZTKCRZZ
 WHERE WDMC = '深圳展厅'
   AND CKMC IN ('料仓')
   and dt='2023-01-05'
      AND date_format(RQ,'yyyy-MM-dd') = '2023-01-05'
UNION ALL
SELECT '余料' AS MC, 0.000 AS JZF, SUM(JZ) AS SL, NULL AS GF, '' AS GFS FROM T_KA_SPLSZ
WHERE WDMC = '深圳展厅'
   AND CKMC IN ('料仓')
   AND SFFX = '收'
   and dt='2023-01-05'
   AND date_format(RQ,'yyyy-MM-dd') = '2023-01-05'
UNION ALL
SELECT '余料' AS MC, 0.000 AS JZF, 0-SUM(JZ) AS SL, NULL AS GF, '' AS GFS FROM T_KA_SPLSZ
WHERE WDMC = '深圳展厅'
   AND CKMC IN ('料仓')
   AND SFFX = '发'
   and dt='2023-01-05'
   AND date_format(RQ,'yyyy-MM-dd') = '2023-01-05'
) GG;


SELECT * FROM (
SELECT '因美优品(万足)' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT ))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE )) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '因美优品'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'
   AND PURITY_NAME = '金9999'
UNION ALL
SELECT '因美优品(五九)' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT ))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE )) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '因美优品'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'
   AND PURITY_NAME = '金99999'
UNION ALL
SELECT '因美优品(千足)' AS MC, SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT ))AS JZF, 0.000 AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE )) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '因美优品'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME <> '金料'
   AND PURITY_NAME <> '金9999'AND PURITY_NAME <> '金99999') A;

SELECT '因美优品' AS MC, 0.000 AS JZF, -SUM(if(TOTAL_WEIGHT is null, 0,TOTAL_WEIGHT )) AS SL, SUM(if(TOTAL_PRICE is null, 0,TOTAL_PRICE )) AS GF, SUM(TOTAL_PRICE) AS GFS
FROM T_BF_GOLD_TRANSFER_OUT_PRINT
 WHERE TRANSFER_IN_SHOWROOM = '因美优品'
   AND date_format(approve_time,'yyyy-MM-dd') = '2023-01-05'
   AND APPROVE_STATUS = 1
   AND STATUS = 0
   and dt='2023-01-05'
   AND TRANSFER_OUT_SHOWROOM = '深圳展厅'
   AND GENUS_NAME = '金料';




create table IF NOT EXISTS ads_cx_ztsz_dtfkbb_new (
    xh string,
    mc string,
    jzf decimal(18,3),
    sl decimal(18,3),
    gf decimal(18,3),
    gfs decimal(18,3),
    bz string
) partitioned by (dt string) location '/zfq_test_decent_cloud/ads_cx_ztsz_dtfkbb_new';



select wdmc, customer_identity, khbm, khmc, zkh, pqmc, sjxqmc, djsxx, sxqxx, khbh, gys
	 from (select branch_name as wdmc,
		             customer_identity,
		             customer_code as khbm,
					 customer_name as khmc,
					 '' as zkh,
				     area_name as pqmc,
					 province as sjxqmc,
				     city_code as djsxx,
					 county_desc as sxqxx,
					 '' as khbh,
					 is_supplier as gys
					from t_customer
				where if(active_flag is null, 'y',active_flag) ='y'
				and dt='2023-01-05'
			union all
        select branch_name as wdmc,
			   b.child_customer_identity as customer_identity,
               concat(a.customer_code, lpad(b.child_customer_seq, 4,'0')) as khbm,
			   a.customer_name as khmc,
			   b.child_customer_name as zkh,
               a.area_name as pqmc,
        	  if(b.province is null, a.province,b.province) as sjxqmc,
        	  a.city_code as djsxx,
        	  a.county_desc as sxqxx,
        	  b.child_customer_code as khbh,
			  a.is_supplier as gys
        	 from t_customer a
        	inner join t_child_customer b
        	on a.customer_identity = b.customer_identity  and a.dt='2023-01-05' and b.dt='2023-01-05'
        	where if(a.active_flag is null, 'y',a.active_flag) = 'y'
            and if(b.active_flag is null, 'y',b.active_flag) = 'y'
        ) a;

select b.province as sf, a.area_name as qymc
  from t_bf_area a,
		     t_delay_region b
 where a.area_identity = b.area_identity
and a.dt='2023-01-05' and b.dt='2023-01-05'
;


select a.customer_identity as customer_identity,
       b.area_name as qymc
   from t_gf_area_customer a,
       t_bf_area b
	where a.area_identity = b.area_identity
and a.dt='2023-01-05' and b.dt='2023-01-05'
;


select customer_identity, sum(je) as jfje, sum(if(jz is null,0,jz)) as jfjz
		from (
        select customer_identity,je,jz
				from t_ka_yflsz
         where date_format(rq,'yyyy-MM-dd') = '2023-01-05'
	        		and sffx = '发'
	        		and wdmc = '深圳展厅'
					and dt='2023-01-05'
		union all
		select customer_identity, 0 as je, jz
		from t_ka_lllsz
         where date_format(rq,'yyyy-MM-dd') = '2023-01-05'
 	        		and sffx = '发'
					and dt='2023-01-05'
	        		and wdmc = '深圳展厅'
				) t
 group by customer_identity;





select customer_identity, sum(je) as dfje, sum(if(jz is null,0,jz)) as dfjz
		from (select customer_identity, je, jz
          from t_ka_yflsz
         where date_format(rq,'yyyy-MM-dd') ='2023-01-05'
 	        		and sffx = '收'
					and dt='2023-01-05'
	        		and wdmc = '深圳展厅'
					union all
			select b.customer_identity, a.djje as je, 0 as jz
								  from t_ka_ysmxz_b a
									inner join t_ka_ysmxz_h b
									   on a.ysmxz_h_identity = b.ysmxz_h_identity and a.dt='2023-01-05' and b.dt='2023-01-05'
         where date_format(a.rq,'yyyy-MM-dd') = '2023-01-05'
	        		and djm = '收款单'
	        		and wdmc = '深圳展厅'
			union all
		select customer_identity, 0 as je, jz
		from t_ka_lllsz
         where date_format(rq,'yyyy-MM-dd') >= '2023-01-05'
 	        		and sffx = '收'
					and dt='2023-01-05'
	        		and wdmc = '深圳展厅'
											) t
 group by customer_identity;

 select customer_identity,
       sum(je) as jfje
		from t_ka_yflsz
 where date_format(rq,'yyyy-MM-dd') = '2023-01-05'
   and sffx = '发'
   and wdmc = '深圳展厅'
   and dt='2023-01-05'
 group by customer_identity
	;




select customer_identity, sum(je) as dfje, sum(if(jz is null,0,jz)) as dfjz
  from (select customer_identity, je, jz
          from t_ka_yflsz
         where date_format(rq,'yyyy-MM-dd') = '2023-01-05'
        	  and sffx = '收'
			  and dt='2023-01-05'
        	  and wdmc = '深圳展厅'
								union all
								select b.customer_identity, a.djje as je, 0 as jz
								  from t_ka_ysmxz_b a
									inner join t_ka_ysmxz_h b
									   on a.ysmxz_h_identity = b.ysmxz_h_identity and a.dt='2023-01-05' and b.dt='2023-01-05'
         where date_format(a.rq,'yyyy-MM-dd') = '2023-01-05'
	        		and djm = '收款单'
	        		and wdmc = '深圳展厅'
							 union all
								select customer_identity, 0 as je, jz
								  from t_ka_lllsz
         where date_format(rq,'yyyy-MM-dd') = '2023-01-05'
	        		and sffx = '收'
					and dt='2023-01-05'
	        		and wdmc = '深圳展厅'
								) t
 group by customer_identity;

select customer_identity, sum(wwth) as wwth, sum(wwfl) as wwfl
  from (select customer_identity,
               case when swlx='委外退货' then jz else 0 end as wwth,
               case when swlx='委外付料' then jz else 0 end as wwfl
           from t_ka_yfllsz
         where date_format(rq,'yyyy-MM-dd') = '2023-01-05'
        	  and sffx = '发'
        			and wdmc =  '深圳展厅'
							union all
							select customer_identity, 0 as wwth, -jz as wwfl
								  from t_ka_lllsz
         where date_format(rq,'yyyy-MM-dd') = '2023-01-05'
	        		and sffx = '发'
	        		and wdmc = '深圳展厅' ) t
	group by customer_identity;



select customer_identity, sum(dzlz) as dzlz
  from (select a.customer_identity, a.adjust_weight as dzlz
		        from t_bf_the_bill a, t_customer b
         where a.customer_identity = b.customer_identity
			   and a.dt='2023-01-05' and b.dt='2023-01-05'
									  and if(b.is_supplier is null, 0,b.is_supplier) = 1
											and date_format(a.financial_settlement_time,'yyyy-MM-dd') = '2023-01-05'
											and a.showroom_name = '深圳展厅'
        union all
        select a.out_customer_identity as customer_identity,
								       a.adjust_weight as dzlz
								  from t_bf_customer_the_bill a, t_customer b
         where a.out_customer_identity = b.customer_identity
									  and if(b.is_supplier is null, 0,b.is_supplier) = 1
											and date_format(a.financial_settlement_time,'yyyy-MM-dd') = '2023-01-05'
											and a.dt='2023-01-05' and b.dt='2023-01-05'
											and a.showroom_name = '深圳展厅'
        union all
        select a.in_customer_identity as customer_identity, - adjust_weight as dzlz
								  from t_bf_customer_the_bill a, t_customer b
         where a.in_customer_identity = b.customer_identity
									  and if(b.is_supplier is null, 0,b.is_supplier) = 1
											and date_format(a.financial_settlement_time,'yyyy-MM-dd') = '2023-01-05'
											and a.dt='2023-01-05' and b.dt='2023-01-05'
											and a.showroom_name = '深圳展厅'
       ) a
 group by customer_identity;




select a.customer_identity,
       if(d.khbm is null, a.khbm,d.khbm ) as khbm,
       if(d.khmc is null, a.khmc,d.khmc) as khmc,
       if(d.zkh  is null,a.zkh,d.zkh) as zkh,
       a.ydqje,
       a.qlzl,
       0 - (a.ydqje + a.wdqje + a.sylx + a.sygfh + a.dygfh) as je,
       0 - (a.qlzl + a.wdqqlzl) as zl,
       a.lx,
       d.pqmc,
       d.sjxqmc,
       d.djsxx,
       d.sxqxx,
       d.khbh,
       date_sub(date_format(e.jsrq,'yyyy-MM-dd'), 1) as jsrq,
       a.ll,
       a.mxts,
       '客户已停用或未分省份' as qymc,
       a.qlzl as jrydqlz,
       a.ydqje as jrydqje,
       a.szkhcqlxzz_h_identity,
       d.gys
   from t_ka_szkhcqlxzz_h a
  left join t_ka_lscqmxb_h b
		  on a.customer_identity = b.customer_identity
			and a.wdmc = b.wdmc
			and a.dt='2023-01-05' and b.dt='2023-01-05'
  left join ods_RpQuerySaveOwe_Outsource_temp_customer d
		  on a.wdmc = d.wdmc
			and a.customer_identity = d.customer_identity
  left join t_ka_szlxjsrq e
		  on 1 = 1 and e.dt='2023-01-05'
 where	a.wdmc = '深圳展厅'
	  and if(b.ycbs is null, 0,b.ycbs ) = 0
			and if(b.cwbz is null, 0,b.cwbz) <> 2
			and if(d.gys is null,0,d.gys) = 1
order by a.customer_identity;


select  a.customer_identity,
a.khbm,
a.khmc,
a.zkh,
a.ydqje,
a.qlzl,
a.je,
a.zl,
a.lx,
a.pqmc,
a.sjxqmc,
a.djsxx,
a.sxqxx,
a.khbh,
a.jsrq,
a.ll,
a.mxts,
 b.qymc as qymc,
a.jrydqlz,
a.jrydqje,
a.szkhcqlxzz_h_identity,
a.gys
from ods_RpQuerySaveOwe_Outsource_temp_tt1  a inner join  ods_RpQuerySaveOwe_Outsource_temp_01 b  on a.sjxqmc = b.sf;



desc formatted  ods_RpQuerySaveOwe_Outsource_temp_tt1_3;

desc formatted ods_RpQuerySaveOwe_Outsource_temp_tt1_4;


create table IF NOT EXISTS ads_RpQuerySaveOwe_Outsource (
   customer_identity string,
khbm string,
khmc string,
zkh string,
ydqje decimal(18,3) ,
qlzl decimal(18,3),
je decimal(18,3),
zl decimal(18,3),
lx int,
pqmc string,
sjxqmc string,
djsxx string,
sxqxx string,
khbh string,
jsrq string,
ll decimal(18,3),
mxts int,
qymc string,
jrydqlz decimal(18,3),
jrydqje decimal(18,3),
szkhcqlxzz_h_identity string,
gys int
) partitioned by (dt string) location '/zfq_test_decent_cloud/ads_RpQuerySaveOwe_Outsource';





select a.province as sf,
       a.area_identity,
	   b.area_name as qymc
  from t_delay_region a
 inner join t_bf_area b
    on a.area_identity = b.area_identity and a.dt='2023-01-06' and b.dt='2023-01-06'
 where status = 0;

select a.customer_identity,
         a.customer_code   as khbm,
	      b.area_name as qymc
	 from t_fast_customer a
	inner join t_bf_area b
   	on a.area_identity = b.area_identity and a.dt='2023-01-06' and b.dt='2023-01-06';




select
			a2.khmc as khmc,
			if(SUM(chl) is null,0,SUM(chl)) as chl,
			if(sum(thl) is null,0,sum(thl)) as thl,
			if(sum(chl) is null,0,sum(chl)) - if(sum(thl) is null,0,sum(thl))  as xs,
			if(a2.sjxqmc is null,'',a2.sjxqmc) as sf,
			a2.pqmc as pqmc
       from (
						select
							b.customer_code as khmc,
							sum(total_gold_weight) as chl,
							0.00 as thl,
							0.00 as xs,
						    if(b.PROVINCE_NAME is null,'',b.PROVINCE_NAME) AS sjxqmc,
						    if(b.area_name is null,'',b.area_name) AS pqmc
							from t_sale_from a
							left join  ods_cx_zt_sz_tj_khxshzcx_hqz_1_view_customer b on a.settle_accounts_identity=b.customer_identity and a.dt='2023-01-06'
							left join  t_purity c on a.purity_identity=c.purity_identity  and c.dt='2023-01-06'
							where a.approve_status=1
							and a.status=0
							and date_format(bill_date,'yyyy-MM-dd')='2023-01-06'
							and showroom_name='深圳展厅'
 				GROUP BY b.customer_code,b.PROVINCE_NAME,b.area_name )a2 GROUP BY a2.khmc,a2.sjxqmc,a2.pqmc ;



				 select
							b.customer_code as khmc,
							0.00 as chl,
							sum(gold_weight) as thl,
							0.00 as xs,
							b.PROVINCE_NAME AS sjxqmc,
							b.area_name AS pqmc
							from t_bf_cust_return_jewelry a
							left join  ods_cx_zt_sz_tj_khxshzcx_hqz_1_view_customer b on a.customer_identity=b.customer_identity
							left join t_bf_cust_return_jewelry_detail c on a.return_identity=c.return_identity and a.dt='2023-01-06' and c.dt='2023-01-06'
							where a.approve_status=1
							and a.status=0
							and c.status=0
							and date_format(rq,'yyyy-MM-dd')='2023-01-06'

							and showroom_name='深圳展厅'
GROUP BY b.customer_code,b.PROVINCE_NAME,b.area_name
;


select * from ods_cx_zt_sz_tj_khxshzcx_hqz_1_view_customer;

		select
					khmc1,
					if(sum(jpjz) is null,0,sum(jpjz)) as jpjz
		from(
			select
					c.customer_code as khmc1,
					sum(net_weight) as jpjz
					from t_sale_from a
					inner join t_sale_from_detail b on a.sale_identity=b.sale_identity 	and a.dt='2023-01-06' and b.dt='2023-01-06'
					inner join ods_cx_zt_sz_tj_khxshzcx_hqz_1_view_customer c on a.settle_accounts_identity=c.customer_identity
					inner join  t_purity d on a.purity_identity=d.purity_identity and d.dt='2023-01-06'
					where a.approve_status =1
					and a.status=0
					and b.status=0
					and date_format(bill_date,'yyyy-MM-dd')='2023-01-06'
 					and showroom_name='深圳展厅'
					and additional_labour >=2.4
					and counter_name <>'镶嵌Q柜' AND  counter_name <>'镶嵌硬金柜'  AND  counter_name <> '硬金柜'   AND  d.purity_name <> '千足硬金'
					GROUP BY c.customer_code
			)a
			GROUP BY khmc1 ;
			select
						khmc,
						if(sum(jz) is null,0,sum(jz) ) jz
						from(
							select
							b.customer_code as khmc,
							sum(gold_weight) as jz
							from t_bf_cust_return_jewelry a
							inner join  ods_cx_zt_sz_tj_khxshzcx_hqz_1_view_customer b on a.customer_identity=b.customer_identity and a.dt='2023-01-06'
							inner join t_bf_cust_return_jewelry_detail c on a.return_identity=c.return_identity and c.dt='2023-01-06'
							where a.approve_status=1
							and a.status=0
							and c.status=0
							and date_format(rq,'yyyy-MM-dd')='2023-01-06'
							and showroom_name='深圳展厅'
							and   counter_name <> '镶嵌Q柜'  AND  counter_name <>'镶嵌硬金柜'  and c.purity_name<>'千足硬金' AND  if(work_fee_amount_sum is null,0,work_fee_amount_sum) >= 2.4
	         group by b.customer_code
						)a
						group by khmc;

		select
					khmc1,
					if(sum(xqjz) is null,0,sum(xqjz)) as xqjz,
					if(sum(xqgf) is null,0,sum(xqgf)) as xqgf
		from(
			select
					c.customer_code as khmc1,
					sum(net_weight) as xqjz,
					sum(additional_labour) as xqgf
					from t_sale_from a
					inner join t_sale_from_detail b on a.sale_identity=b.sale_identity and a.dt='2023-01-06' and b.dt='2023-01-06'
					inner join  ods_cx_zt_sz_tj_khxshzcx_hqz_1_view_customer c on a.settle_accounts_identity=c.customer_identity
			    inner join  t_purity d on a.purity_identity=d.purity_identity  and d.dt='2023-01-06'
					where a.approve_status =1
					and a.status=0
					and b.status=0
					and date_format(bill_date,'yyyy-MM-dd')='2023-01-06'
					and showroom_name='深圳展厅'
					and (counter_name ='镶嵌Q柜' or  counter_name ='镶嵌硬金柜')
					GROUP BY c.customer_code
			)a
			GROUP BY khmc1 ;



			select
						khmc,
						if(sum(jz) is null,0,sum(jz) ) jz,
						if(sum(gf) is null,0,sum(gf)) gf
						from(
							 select
							b.customer_code as khmc,
							sum(gold_weight) as jz,
							sum(work_fee_amount_sum) as gf
							from t_bf_cust_return_jewelry a
							inner join  ods_cx_zt_sz_tj_khxshzcx_hqz_1_view_customer b on a.customer_identity=b.customer_identity and a.dt='2023-01-06'
							inner join t_bf_cust_return_jewelry_detail c on a.return_identity=c.return_identity and c.dt='2023-01-06'
							where a.approve_status=1
							and a.status=0
							and c.status=0
							and date_format(rq,'yyyy-MM-dd')='2023-01-06'
							and showroom_name='深圳展厅'
							and   (counter_name ='镶嵌Q柜' or  counter_name ='镶嵌硬金柜')
	         group by b.customer_code
						)a
						group by khmc;


desc formatted ods_cx_zt_sz_tj_khxshzcx_hqz_1_result;


create table IF NOT EXISTS ads_cx_zt_sz_tj_khxshzcx_hqz_1 (
khmc string,
chl decimal(18,3),
thl decimal(18,3),
xs decimal(18,3),
sf string,
pqmc string,
jpjz decimal(18,3),
xqjz decimal(18,3),
xqgf decimal(18,3),
mc string,
zkhmc string
) partitioned by (dt string) location '/zfq_test_decent_cloud/ads_cx_zt_sz_tj_khxshzcx_hqz_1';
drop table ods_cx_zt_sz_tj_khxshzcx_hqz_1_result;




select
	1 as id, t2.parent_customer_name as qzkh, sum(if(t1.total_gold_weight is null, 0,t1.total_gold_weight)) as qzzx
  from t_sale_from t1
	inner join ods_cx_zt_dxbb_sz_cs_qzccj_1_view_customer t2
	   on t1.settle_accounts_identity = t2.customer_identity and t1.dt='2023-01-06'
 inner join t_purity t3
    on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-06'
 where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-06'
   and t3.purity_name = '千足金'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and (t2.parent_customer_name like '%展' or t2.parent_customer_name like '%展销')
   and t1.status=0
group by t2.parent_customer_name;


select id,if(sum(qzzx) is null,0,sum(qzzx)) as qzzx,qzkh from ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_qzzx group by id,qzkh;


select 1 as id, t2.parent_customer_name as yjkh, sum(if(t1.total_gold_weight is null, 0,t1.total_gold_weight)) as yjzx
  from t_sale_from t1
 inner join ods_cx_zt_dxbb_sz_cs_qzccj_1_view_customer t2
    on t1.settle_accounts_identity = t2.customer_identity and t1.dt='2023-01-06'
 inner join t_purity t3
    on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-06'
 where date_format(t1.bill_date,'yyyy-MM-dd')= '2023-01-06'
   and t3.purity_name = '千足硬金'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and (t2.parent_customer_name like '%展' or t2.parent_customer_name like '%展销')
   and t1.`status`=0
group by t2.parent_customer_name;


select 1 as id, t2.parent_customer_name as wqkh, sum(if(t1.total_gold_weight is null, 0,t1.total_gold_weight)) as wqzx
  from t_sale_from t1
 inner join ods_cx_zt_dxbb_sz_cs_qzccj_1_view_customer t2
    on t1.settle_accounts_identity = t2.customer_identity and t1.dt='2023-01-06'
 inner join t_purity t3
    on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-06'
 where date_format(t1.bill_date,'yyyy-MM-dd') >= '2023-01-06'
   and t3.purity_name = '足金(无氰)'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and (t2.parent_customer_name like '%展' or t2.parent_customer_name like '%展销')
   and t1.status=0
group by t2.parent_customer_name;


select 1 as id, t2.parent_customer_name as wzkh, sum(if(t1.total_gold_weight is null, 0,t1.total_gold_weight)) as wzzx
  from t_sale_from t1
 inner join ods_cx_zt_dxbb_sz_cs_qzccj_1_view_customer t2
    on t1.settle_accounts_identity = t2.customer_identity and t1.dt='2023-01-06'
 inner join t_purity t3
    on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-06'
 where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-06'
    and t3.purity_name = '金9999'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and (t2.parent_customer_name like '%展' or t2.parent_customer_name like '%展销')
   and t1.status=0
group by t2.parent_customer_name;


select 1 as id, t2.parent_customer_name as wjkh, sum(if(t1.total_gold_weight is null, 0,t1.total_gold_weight)) as wjzx
  from t_sale_from t1
 inner join ods_cx_zt_dxbb_sz_cs_qzccj_1_view_customer t2
    on t1.settle_accounts_identity = t2.customer_identity and t1.dt='2023-01-06'
 inner join t_purity t3
    on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-06'
 where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-06'
   and t3.purity_name = '金99999'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and (t2.parent_customer_name like '%展' or t2.parent_customer_name like '%展销')
   and t1.status=0
group by t2.parent_customer_name;


select 1 as id, t2.parent_customer_name as gfjkh, sum(if(t1.total_gold_weight is null, 0,t1.total_gold_weight)) as gfjzx
  from t_sale_from t1
 inner join ods_cx_zt_dxbb_sz_cs_qzccj_1_view_customer t2
    on t1.settle_accounts_identity = t2.customer_identity and t1.dt='2023-01-06'
 inner join t_purity t3
    on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-06'
where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-06'
    and t3.purity_name = '古法金'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and (t2.parent_customer_name like '%展' or t2.parent_customer_name like '%展销')
   and t1.status=0
group by t2.parent_customer_name;













































select 1 as id, t2.parent_customer_name as wgkh, sum(if(t1.total_gold_weight is null, 0,t1.total_gold_weight)) as wgzx
  from t_sale_from t1
 inner join ods_cx_zt_dxbb_sz_cs_qzccj_1_view_customer t2
    on t1.settle_accounts_identity = t2.customer_identity  and t1.dt='2023-01-06'
 inner join t_purity t3
    on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-06'
where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-06'
    and t3.purity_name = '足金(5g)'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and (t2.parent_customer_name like '%展' or t2.parent_customer_name like '%展销')
   and t1.status=0
group by t2.parent_customer_name;

select 1 as id, t2.parent_customer_name as gfwzjkh, sum(if(t1.total_gold_weight is null, 0,t1.total_gold_weight)) as gfwzjzx
  from t_sale_from t1
 inner join ods_cx_zt_dxbb_sz_cs_qzccj_1_view_customer t2
    on t1.settle_accounts_identity = t2.customer_identity and t1.dt='2023-01-06'
 inner join t_purity t3
    on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-06'
where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-06'
    and t3.purity_name = '古法万足金'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and (t2.parent_customer_name like '%展' or t2.parent_customer_name like '%展销')
   and t1.status=0
   group by t2.parent_customer_name;


select 1 as id, t2.parent_customer_name as gfwjjkh, sum(if(t1.total_gold_weight is null, 0,t1.total_gold_weight)) as gfwjjzx
  from t_sale_from t1
 inner join ods_cx_zt_dxbb_sz_cs_qzccj_1_view_customer t2
    on t1.settle_accounts_identity = t2.customer_identity and t1.dt='2023-01-06'
 inner join t_purity t3
    on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-06'
where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-06'

   and t3.purity_name = '古法999.99'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and (t2.parent_customer_name like '%展' or t2.parent_customer_name like '%展销')
   and t1.status=0
group by t2.parent_customer_name;


select 1 as id, t2.parent_customer_name as qzccjkh, sum(if(t1.total_gold_weight is null, 0,t1.total_gold_weight )) as qzccjzx
  from t_sale_from t1
 inner join ods_cx_zt_dxbb_sz_cs_qzccj_1_view_customer t2
    on t1.settle_accounts_identity = t2.customer_identity and t1.dt='2023-01-06'
 inner join t_purity t3
    on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-06'
where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-06'
    and t3.purity_name = '千足赤辰金'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and (t2.parent_customer_name like '%展' or t2.parent_customer_name like '%展销')
   and t1.status=0
group by t2.parent_customer_name;




select 1 as id, t2.parent_customer_name as wzccjkh, sum(if(t1.total_gold_weight is null, 0,t1.total_gold_weight)) as wzccjzx
  from t_sale_from t1
 inner join ods_cx_zt_dxbb_sz_cs_qzccj_1_view_customer t2
    on t1.settle_accounts_identity = t2.customer_identity and t1.dt='2023-01-06'
 inner join t_purity t3
    on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-06'
where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-06'
    and t3.purity_name = '万足赤辰金'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and (t2.parent_customer_name like '%展' or t2.parent_customer_name like '%展销')
   and t1.status=0
group by t2.parent_customer_name;




 select qzzx, qz, yjzx, yj, wqzx, wq, wzzx, wz, wjzx, wj, gfjzx, gfj, gfwzjzx, gfwzj, gfwjjzx, gfwjj, wgzx, wg, qzccjzx, qzccj, wzccjzx, wzccj
  from (
 select qzzx, qz, yjzx, yj, wqzx, wq, wzzx, wz, wjzx, wj, gfjzx, gfj, gfwzjzx, gfwzj, gfwjjzx, gfwjj, wgzx, wg, qzccjzx, qzccj, wzccjzx, wzccj
   from ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_1
   left join ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_2 on ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_2.id = ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_1.id
   left join ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_3 on ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_3.id = ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_1.id
   left join ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_4 on ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_4.id = ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_1.id
   left join ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_5 on ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_5.id = ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_1.id
   left join ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_6 on ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_6.id = ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_1.id
   left join ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_7 on ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_7.id = ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_1.id
   left join ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_8 on ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_8.id = ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_1.id
   left join ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_9 on ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_9.id = ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_1.id
   left join ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_10 on ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_10.id = ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_1.id
   left join ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_11 on ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_11.id = ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_1.id
      ) a group by qzzx, qz, yjzx, yj, wqzx, wq, wzzx, wz, wjzx, wj, gfjzx, gfj, gfwzjzx, gfwzj, gfwjjzx, gfwjj, wgzx, wg, qzccjzx, qzccj, wzccjzx, wzccj;


use zfq_test_decent_cloud;

select  if(sum(jjjz) is null, 0,sum(jjjz))  as qzxj
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-08'
   and t2.purity_name = '千足金'
   and t1.showroom_name = '深圳展厅'
   and t1.status=0
   and t1.sale_type <> 'jl';



select  if(sum(t2.amount) is null, 0,sum(t2.amount))/ if(sum(t2.gold_weight) is null, 1,sum(t2.gold_weight)) as qzpjdj
  from t_sale_from t1
 inner join t_sale_from_account_detail t2
    on t1.sale_identity = t2.sale_identity
		 and t2.status = 0 and  t1.dt='2023-01-08' and t2.dt='2023-01-08'
 inner join t_purity t3
    on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-08'
   and t3.purity_name = '千足金'
   and t1.showroom_name = '深圳展厅'
   and t2.account_method = '结价'
  and t1.status=0
   and t1.sale_type <> 'jl';






select  if(sum(lljzhj) is null, 0,sum(lljzhj))  as qzdh
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-08'
    and t2.purity_name = '千足金'
   and t1.showroom_name = '深圳展厅'
  and t1.status=0
   and t1.sale_type <> 'jl';





select  if(sum(zqljzhj) is null, 0,sum(zqljzhj)) +  if(sum(zqsjzhj) is null, 0,sum(zqsjzhj)) as qzkhql
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-08'
    and t2.purity_name = '千足金'
   and t1.showroom_name = '深圳展厅'
  and t1.status=0
   and t1.sale_type <> 'jl';
















select  if(sum(t1.total_gold_weight) is null, 0,sum(t1.total_gold_weight)) as qzzxl
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-08'
    and t2.purity_name = '千足金'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and t1.status=0
   and not exists (select 1 from ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_zx_customer tt where t1.settle_accounts_identity = tt.customer_identity);



select if(sum(jjjz) is null, 0,sum(jjjz)) as yjxj
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd')='2023-01-08'
   and t2.purity_name = '千足硬金'
  and t1.status=0
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl';

select  if(sum(t2.amount) is null, 0,sum(t2.amount))/ if(sum(t2.gold_weight) is null, 1,sum(t2.gold_weight))   as yjpjdj
from t_sale_from t1
inner join t_sale_from_account_detail t2
   on t1.sale_identity = t2.sale_identity
		and t2.status = 0 and t1.dt='2023-01-08' and t2.dt='2023-01-08'
inner join t_purity t3
   on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd')='2023-01-08'
   and t3.purity_name = '千足硬金'
   and t1.showroom_name = '深圳展厅'
   and t2.account_method = '结价'
  and t1.status=0
   and t1.sale_type <> 'jl';


select  if(sum(lljzhj) is null, 0,sum(lljzhj))  as yjdh
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd')='2023-01-08'
   and t2.purity_name = '千足硬金'
   and t1.showroom_name = '深圳展厅'
  and t1.status=0
   and t1.sale_type <> 'jl';




select  if(sum(zqljzhj) is null, 0,sum(zqljzhj)) +  if(sum(zqsjzhj) is null, 0,sum(zqsjzhj)) as yjkhql
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd')='2023-01-08'
   and t2.purity_name = '千足硬金'
   and t1.showroom_name = '深圳展厅'
  and t1.status=0
   and t1.sale_type <> 'jl';


select  if(sum(t1.total_gold_weight) is null, 0,sum(t1.total_gold_weight)) as yjzxl
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd')='2023-01-08'
   and t2.purity_name = '千足硬金'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
  and t1.status=0
			and not exists (select 1 from ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_zx_customer tt where t1.settle_accounts_identity = tt.customer_identity);


select if(sum(t2.amount) is null, 0,sum(t2.amount))/ if(sum(t2.gold_weight) is null, 1,sum(t2.gold_weight)) as wqpjdj
from t_sale_from t1
inner join t_sale_from_account_detail t2
   on t1.sale_identity = t2.sale_identity
		and t2.status = 0 and t1.dt='2023-01-08' and t2.dt='2023-01-08'
inner join t_purity t3
   on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') ='2023-01-08'
   and t3.purity_name = '足金(无氰)'
   and t1.showroom_name = '深圳展厅'
   and t2.account_method = '结价'
  and t1.status=0
   and t1.sale_type <> 'jl';




select  if(sum(lljzhj) is null, 0,sum(lljzhj)) as wqdh
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') ='2023-01-08'
   and t2.purity_name = '足金(无氰)'
   and t1.showroom_name = '深圳展厅'
  and t1.status=0
   and t1.sale_type <> 'jl';


select if(sum(zqljzhj) is null, 0,sum(zqljzhj)) +  if(sum(zqsjzhj) is null, 0,sum(zqsjzhj)) as wqkhql
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity  and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') ='2023-01-08'
   and t2.purity_name = '足金(无氰)'
   and t1.showroom_name = '深圳展厅'
  and t1.status=0
   and t1.sale_type <> 'jl';



select  if(sum(t1.total_gold_weight) is null, 0,sum(t1.total_gold_weight)) as wqzxl
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') ='2023-01-08'
   and t2.purity_name = '足金(无氰)'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and t1.status=0
			and not exists (select 1 from ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_zx_customer tt where t1.settle_accounts_identity = tt.customer_identity);


select  if(sum(jjjz) is null, 0,sum(jjjz))  as wzxj
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') ='2023-01-08'
   and t2.purity_name = '金9999'
   and t1.showroom_name = '深圳展厅'
  and t1.status=0
   and t1.sale_type <> 'jl';



select  if(sum(t2.amount) is null, 0,sum(t2.amount))/case when  if(sum(t2.gold_weight) is null, 0,sum(t2.gold_weight)) = 0 then 1 else  if(sum(t2.gold_weight) is null, 0,sum(t2.gold_weight)) end as wzpjdj
from t_sale_from t1
inner join t_sale_from_account_detail t2
   on t1.sale_identity = t2.sale_identity
		and t2.status = 0 and t1.dt='2023-01-08' and t2.dt='2023-01-08'
inner join t_purity t3
   on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') ='2023-01-08'
   and t3.purity_name = '金9999'
   and t1.showroom_name = '深圳展厅'
   and t2.account_method = '结价'
  and t1.status=0
   and t1.sale_type <> 'jl';


select  if(sum(zqljzhj) is null, 0,sum(zqljzhj)) +  if(sum(zqsjzhj) is null, 0,sum(zqsjzhj)) as wzkhql
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') ='2023-01-08'
   and t2.purity_name = '金9999'
  and t1.status=0
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl';



select  if(sum(t1.total_gold_weight) is null, 0,sum(t1.total_gold_weight)) as wzzxl
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') ='2023-01-08'
   and t2.purity_name = '金9999'
   and t1.showroom_name = '深圳展厅'
   and t1.sale_type <> 'jl'
   and t1.status=0 and not exists (select 1 from ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_zx_customer tt where t1.settle_accounts_identity = tt.customer_identity);


select  if(sum(jjjz) is null, 0,sum(jjjz))   as wjxj
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') ='2023-01-08'
   and t2.purity_name = '金99999'
   and t1.showroom_name = '深圳展厅'
  and t1.status=0
   and t1.sale_type <> 'jl';


select if(sum(t2.amount) is null, 0,sum(t2.amount))/case when if(sum(t2.gold_weight) is null, 0,sum(t2.gold_weight)) = 0 then 1 else  if(sum(t2.gold_weight) is null, 0,sum(t2.gold_weight)) end as wjpjdj
from t_sale_from t1
inner join t_sale_from_account_detail t2
   on t1.sale_identity = t2.sale_identity
		and t2.status = 0 and t1.dt='2023-01-08' and t2.dt='2023-01-08'
inner join t_purity t3
   on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') ='2023-01-08'
   and t3.purity_name = '金99999'
   and t1.showroom_name = '深圳展厅'
   and t2.account_method = '结价'
  and t1.status=0
   and t1.sale_type <> 'jl';


select if(sum(lljzhj) is null, 0,sum(lljzhj)) as wjdh
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where date_format(t1.bill_date,'yyyy-MM-dd') ='2023-01-08'
   and t2.purity_name = '金99999'
   and t1.showroom_name = '深圳展厅'
  and t1.status=0
 and t1.sale_type <> 'jl';




select 						sum(case when t2.purity_name = '千足金' then if(t1.total_gold_weight is null, 0,t1.total_gold_weight ) else 0 end) as qz_sale,
							sum(case when t2.purity_name = '千足硬金' then if(t1.total_gold_weight is null, 0,t1.total_gold_weight ) else 0 end) as yj_sale,
							sum(case when t2.purity_name IN ('足金(无氰)', '足金（无氰）') then if(t1.total_gold_weight is null, 0,t1.total_gold_weight ) else 0 end) as wq_sale,
							sum(case when t2.purity_name = '金9999' then if(t1.total_gold_weight is null, 0,t1.total_gold_weight ) else 0 end) as wz_sale,
							sum(case when t2.purity_name = '金99999' then if(t1.total_gold_weight is null, 0,t1.total_gold_weight ) else 0 end) as wj_sale,
							sum(case when t2.purity_name = '古法金' then if(t1.total_gold_weight is null, 0,t1.total_gold_weight ) else 0 end) as gfj_sale,
							sum(case when t2.purity_name = '古法万足金' then if(t1.total_gold_weight is null, 0,t1.total_gold_weight ) else 0 end) as gfwzj_sale,
							sum(case when t2.purity_name = '古法999.99' then if(t1.total_gold_weight is null, 0,t1.total_gold_weight ) else 0 end) as gfwjj_sale,
							sum(case when t2.purity_name IN ('足金（5G）', '足金(5G)') then if(t1.total_gold_weight is null, 0,t1.total_gold_weight ) else 0 end) as wg_sale,
							sum(case when t2.purity_name = '千足赤辰金' then if(t1.total_gold_weight is null, 0,t1.total_gold_weight ) else 0 end) as qzccj_sale,
							sum(case when t2.purity_name = '万足赤辰金' then if(t1.total_gold_weight is null, 0,t1.total_gold_weight ) else 0 end) as wzccj_sale
  from t_sale_from t1
 inner join t_purity t2
    on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
 where date_format(t1.bill_date,'yyyy-MM-dd') ='2023-01-08'
   and t1.showroom_name = '深圳展厅'
   and t1.status = 0
   and t1.sale_type <> 'JL'
			and not exists (select 1 from ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_zx_customer tt where t1.settle_accounts_identity = tt.customer_identity);



select 						sum(case when t2.purity_name = '千足金' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as qz_return,
							sum(case when t2.purity_name = '千足硬金' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as yj_return,
							sum(case when t2.purity_name IN ('足金(无氰)', '足金（无氰）') then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as wq_return,
							sum(case when t2.purity_name = '金9999' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as wz_return,
							sum(case when t2.purity_name = '金99999' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as wj_return,
							sum(case when t2.purity_name = '古法金' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as gfj_return,
							sum(case when t2.purity_name = '古法万足金' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as gfwzj_return,
							sum(case when t2.purity_name = '古法999.99' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as gfwjj_return,
							sum(case when t2.purity_name IN ('足金（5G）', '足金(5G)') then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as wg_return,
							sum(case when t2.purity_name = '千足赤辰金' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as qzccj_return,
							sum(case when t2.purity_name = '万足赤辰金' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as wzccj_return
 from t_bf_cust_return_jewelry t1
inner join t_purity t2
   on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where t1.showroom_name = '深圳展厅'
		and date_format(t1.rq,'yyyy-MM-dd') ='2023-01-08'
		and t1.approve_status = 1
		and t1.status = 0
		and not exists (select 1 from ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_zx_customer tt where t1.customer_identity = tt.customer_identity);



select 						sum(case when t2.purity_name = '千足金' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as qz_return,
							sum(case when t2.purity_name = '千足硬金' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as yj_return,
							sum(case when t2.purity_name IN ('足金(无氰)', '足金（无氰）') then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as wq_return,
							sum(case when t2.purity_name = '金9999' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as wz_return,
							sum(case when t2.purity_name = '金99999' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as wj_return,
							sum(case when t2.purity_name = '古法金' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as gfj_return,
							sum(case when t2.purity_name = '古法万足金' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as gfwzj_return,
							sum(case when t2.purity_name = '古法999.99' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as gfwjj_return,
							sum(case when t2.purity_name IN ('足金（5G）', '足金(5G)') then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as wg_return,
							sum(case when t2.purity_name = '千足赤辰金' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as qzccj_return,
							sum(case when t2.purity_name = '万足赤辰金' then if(t1.gold_weight_sum is null, 0,t1.gold_weight_sum) else 0 end) as wzccj_return
 from t_bf_cust_return_jewelry t1
inner join t_purity t2
   on t1.purity_identity = t2.purity_identity and t1.dt='2023-01-08' and t2.dt='2023-01-08'
where t1.showroom_name = '深圳展厅'
		and date_format(t1.rq,'yyyy-MM-dd') ='2023-01-08'
		and t1.approve_status = 1
		and t1.status = 0
		and not exists (select 1 from ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_zx_customer tt where t1.customer_identity = tt.customer_identity);



select if(qz_sale is null, 0,qz_sale) - if(qz_return is null, 0,qz_return) / 1000  as qz_net_sale,
       if(yj_sale is null, 0,yj_sale) - if(yj_return is null, 0,yj_return) / 1000  as yj_net_sale,
       if(wq_sale is null, 0,wq_sale) - if(wq_return is null, 0,wq_return) / 1000  as wq_net_sale,
       if(wz_sale is null, 0,wz_sale) - if(wz_return is null, 0,wz_return) / 1000  as wz_net_sale,
       if(wj_sale is null, 0,wj_sale) - if(wj_return is null, 0,wj_return) / 1000  as wj_net_sale,
       if(gfj_sale is null, 0,gfj_sale) - if(gfj_return is null, 0,gfj_return) / 1000  as gfj_net_sale,
       if(gfwzj_sale is null, 0,gfwzj_sale) - if(gfwzj_return is null, 0,gfwzj_return) / 1000  as gfwzj_net_sale,
       if(gfwjj_sale is null, 0,gfwjj_sale) - if(gfwjj_return is null, 0,gfwjj_return) / 1000  as gfwjj_net_sale,
       if(wg_sale is null, 0,wg_sale) - if(wg_return is null, 0,wg_return) / 1000  as wg_net_sale,
       if(qzccj_sale is null, 0,qzccj_sale) - if(qzccj_return is null, 0,qzccj_return) / 1000  as qzccj_net_sale,
       if(wzccj_sale is null, 0,wzccj_sale) - if(wzccj_return is null, 0,wzccj_return) / 1000  as wzccj_net_sale
  from ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_purity_sale, ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_purity_return;









select  qc + rk - ck as yjkc, qc + rk - ck as yjqk
  from
(select if(sum(qcjz) is null, 0,sum(qcjz)) as qc
  from t_ka_ztkcrzz
 where (ckmc = '硬金柜' or ckmc = '硬素金柜' or (ckmc = '硬金结算'and jsmc <> '足金(无氰)') or ckmc = '硬金精品d柜' or ckmc = '硬金精品c柜' or ckmc = '硬金b柜'
       or ckmc = '硬金a柜' or ckmc = '无字印柜' or ckmc = '单件化硬金柜台'
			    or (ckmc = '千足结算' and jsmc in ('足金(无氰)', '千足硬金'))
			    or (ckmc = '客单组' and jsmc in ('千足硬金'))
			    or (ckmc = '配货中心' and jsmc in ('千足硬金'))
			 )
   and date_format(rq,'yyyy-MM-dd') ='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   ) a,
 (select if(sum(jz) is null, 0,sum(jz)) as rk
  from t_ka_splsz
 where (ckmc = '硬金柜' or ckmc = '硬素金柜' or (ckmc = '硬金结算'and jsmc <> '足金(无氰)') or ckmc = '硬金精品d柜' or ckmc = '硬金精品c柜' or ckmc = '硬金b柜'
       or ckmc = '硬金a柜' or ckmc = '单件化硬金柜台'
							or ckmc = '无字印柜'
		     or (ckmc = '千足结算' and jsmc in ('足金(无氰)', '千足硬金'))
		     or (ckmc = '客单组' and jsmc in ('千足硬金'))
       or (ckmc = '配货中心' and jsmc in ('千足硬金'))
		)
   and date_format(rq,'yyyy-MM-dd') ='2023-01-08'
   and sffx = '收'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and swlx <> '称重入库' and djm <> '单件调拨入库单'
			and djh not like 'zj20%'
	 )b,
 (select if(sum(jz) is null, 0,sum(jz)) as ck
  from t_ka_splsz
 where wdmc = '深圳展厅'
	   and dt='2023-01-08'
   and (ckmc = '硬金柜' or ckmc = '硬素金柜' or (ckmc = '硬金结算'and jsmc <> '足金(无氰)') or ckmc = '硬金精品d柜' or ckmc = '硬金精品c柜' or ckmc = '硬金b柜'
       or ckmc = '硬金a柜' or ckmc = '单件化硬金柜台'
							or ckmc = '无字印柜'
				   or (ckmc = '千足结算' and jsmc in ('足金(无氰)', '千足硬金'))
				   or (ckmc = '客单组' and jsmc in ('千足硬金'))
			    or (ckmc = '配货中心' and jsmc in ('千足硬金'))
		)
   and date_format(rq,'yyyy-MM-dd') ='2023-01-08'
   and sffx = '发'
   and swlx <> '客户出货' and djm <> '单件调拨出库单'
			and djh not like 'zj20%'
				)c;






select  qc + rk - ck as qzkc, qc + rk - ck as qk
  from
(select if(sum(qcjz) is null, 0,sum(qcjz)) as qc
  from t_ka_ztkcrzz
where (ckmc <> '镶嵌q柜'
       and ckmc <> '维修仓'
       and ckmc <> '镶嵌柜-德钰东方'
       and ckmc not like '%镶嵌%'
       and ckmc not in ('料仓')
       and ckmc <> '古法金柜'
       and ckmc <> '精品g柜'
       and ckmc <> '无字印柜'
       and ckmc <> '单件化硬金柜台'
       and ckmc <> '硬金柜'
       and ckmc <> '硬素金柜'
       and ckmc <> '硬金结算'
       and ckmc <> '硬金精品d柜'
       and ckmc <> '硬金精品c柜'
       and ckmc <> '硬金b柜'
       and ckmc <> '硬金a柜'
       and (jsmc = '千足金' or jsmc = '足金' or (ckmc not in('客单组', '配货中心', '千足结算') and jsmc = '千足硬金')))
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   ) a,
 (select if(sum(jz) is null, 0,sum(jz)) as rk
  from t_ka_splsz
 where ckmc <> '镶嵌q柜'
   and ckmc <> '维修仓'
   and ckmc <> '镶嵌柜-德钰东方'
   and ckmc not like '%镶嵌%'
   and ckmc not in ('料仓')
   and ckmc <> '古法金柜'
   and ckmc <> '精品g柜'
   and ckmc <> '无字印柜'
   and ckmc <> '单件化硬金柜台'
   and ckmc <> '硬金柜'
   and ckmc <> '硬素金柜'
   and ckmc <> '硬金结算'
   and ckmc <> '硬金精品d柜'
   and ckmc <> '硬金精品c柜'
   and ckmc <> '硬金b柜'
   and ckmc <> '硬金a柜'
   and (jsmc = '千足金' or jsmc = '足金' or (ckmc not in('客单组', '配货中心', '千足结算') and jsmc = '千足硬金'))
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and sffx = '收'
   and swlx <> '称重入库' and djm <> '单件调拨入库单'
			and djh not like 'zj20%'
)b,
 (select if(sum(jz) is null, 0,sum(jz)) as ck
  from t_ka_splsz
 where ckmc <> '镶嵌q柜'
   and ckmc <> '维修仓'
   and ckmc <> '镶嵌柜-德钰东方'
   and ckmc not like '%镶嵌%'
   and ckmc not in ('料仓')
   and ckmc <> '古法金柜'
   and ckmc <> '精品g柜'
   and ckmc <> '无字印柜'
   and ckmc <> '单件化硬金柜台'
   and ckmc <> '硬金柜'
   and ckmc <> '硬素金柜'
   and ckmc <> '硬金结算'
   and ckmc <> '硬金精品d柜'
   and ckmc <> '硬金精品c柜'
   and ckmc <> '硬金b柜'
   and ckmc <> '硬金a柜'
   and (jsmc = '千足金' or jsmc = '足金' or (ckmc not in('客单组', '配货中心', '千足结算' ) and jsmc = '千足硬金'))
   and wdmc = '深圳展厅'
   and dt=2023-01-08
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and sffx = '发'
   and swlx <> '客户出货' and djm <> '单件调拨出库单'
			and djh not like 'zj20%'
)c;


select  qc + rk - ck as wqkc, qc + rk - ck as wqk
  from
(select if(sum(qcjz) is null, 0,sum(qcjz)) as qc
  from t_ka_ztkcrzz
where (ckmc = '无氰a柜' or ckmc = '硬金无氰柜' or ckmc = '5d秀爱金a柜' or ckmc = '5d秀爱金b柜' or ckmc = '5d秀爱金c柜'
or ckmc = '5d秀爱金d柜' or ckmc = '单件化硬金柜台' or ckmc = '硬金结算' or ckmc = '配货中心')
   and jsmc = '足金(无氰)'
   and date_format(rq,'yyyy-MM-dd')= '2023-01-08'
   and wdmc = '深圳展厅'
    and dt='2023-01-08'
    ) a,
 (select if(sum(jz) is null, 0,sum(jz) ) as rk
  from t_ka_splsz
 where wdmc = '深圳展厅'
   and dt='2023-01-08'
   and (ckmc = '无氰a柜' or ckmc = '硬金无氰柜' or ckmc = '5d秀爱金a柜' or ckmc = '5d秀爱金b柜' or ckmc = '5d秀爱金c柜'
 or ckmc = '5d秀爱金d柜' or ckmc = '单件化硬金柜台' or ckmc = '硬金结算'  or ckmc = '配货中心')
   and date_format(rq,'yyyy-MM-dd')= '2023-01-08'
   and jsmc = '足金(无氰)'
   and sffx = '收'
   and swlx <> '称重入库' and djm <> '单件调拨入库单'
			and djh not like 'zj20%'
)b,
 (select if(sum(jz) is null, 0,sum(jz) ) as ck
  from t_ka_splsz
 where wdmc = '深圳展厅'
   and dt='2023-01-08'
   and (ckmc = '无氰a柜' or ckmc = '硬金无氰柜' or ckmc = '5d秀爱金a柜' or ckmc = '5d秀爱金b柜' or ckmc = '5d秀爱金c柜'
 or ckmc = '5d秀爱金d柜' or ckmc = '单件化硬金柜台' or ckmc = '硬金结算'  or ckmc = '配货中心')
   and date_format(rq,'yyyy-MM-dd')= '2023-01-08'
   and jsmc = '足金(无氰)'
   and sffx = '发'
   and swlx <> '客户出货' and djm <> '单件调拨出库单'
			and djh not like 'zj20%'
)c;



select qc + rk-ck  as wzkc, qc + rk-ck as wk
  from
(select if(sum(qcjz) is null, 0,sum(qcjz)) as qc
  from t_ka_ztkcrzz
where ckmc not in ('料仓')
   and jsmc = '金9999'
   and date_format(rq,'yyyy-MM-dd')= '2023-01-08'
	 and ckmc <> '硬金结算'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   ) a,
 (select if(sum(jz) is null, 0,sum(jz) ) as rk
  from t_ka_splsz
 where ckmc not in ('料仓')
   and jsmc = '金9999'
   and date_format(rq,'yyyy-MM-dd')= '2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '收'
	 and ckmc <> '硬金结算'
   and swlx <> '称重入库' and djm <> '单件调拨入库单'
			and djh not like 'zj20%'
)b,
 (select if(sum(jz) is null, 0,sum(jz) ) as ck
  from t_ka_splsz a
 where ckmc not in ('料仓')
   and jsmc = '金9999'
   and date_format(rq,'yyyy-MM-dd')= '2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
	 and ckmc <> '硬金结算'
   and sffx = '发'
   and swlx <> '客户出货' and djm <> '单件调拨出库单'
			and djh not like 'zj20%'
)c;





select qc + rk - ck  as wjkc, qc + rk - ck as wjk
  from
(select if(sum(qcjz) is null, 0,sum(qcjz)) as qc
  from t_ka_ztkcrzz
where ckmc not in ('料仓')
   and jsmc = '金99999'
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
	 and ckmc <> '硬金结算'
   and wdmc = '深圳展厅' and dt='2023-01-08') a,
 (select if(sum(jz) is null, 0,sum(jz)) as rk
  from t_ka_splsz
 where ckmc not in ('料仓')
   and jsmc = '金99999'
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
	 and ckmc <> '硬金结算'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '收'
   and swlx <> '称重入库' and djm <> '单件调拨入库单'
			and djh not like 'zj20%'
)b,
 (select if(sum(jz) is null, 0,sum(jz)) as ck
  from t_ka_splsz
 where ckmc not in ('料仓')
   and jsmc = '金99999'
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
	 and ckmc <> '硬金结算'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '发'
   and swlx <> '客户出货' and djm <> '单件调拨出库单'
			and djh not like 'zj20%'
)c;




select qc + rk - ck  as xqkc, qc + rk - ck as xk
  from
(select if(sum(qcjz) is null, 0,sum(qcjz)) as qc
  from t_ka_ztkcrzz
where (ckmc = '镶嵌q柜' or ckmc = '维修仓' or ckmc = '镶嵌柜-德钰东方' or ckmc like '%镶嵌%')and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅' and dt='2023-01-08') a,
 (select if(sum(jz) is null, 0,sum(jz)) as rk
  from t_ka_splsz
 where (ckmc = '镶嵌q柜' or ckmc = '维修仓' or ckmc = '镶嵌柜-德钰东方' or ckmc like '%镶嵌%')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '收'
   and swlx <> '称重入库' and djm <> '单件调拨入库单'
			and djh not like 'zj20%'
)b,
 (select if(sum(jz) is null, 0,sum(jz)) as ck
  from t_ka_splsz
 where (ckmc = '镶嵌q柜' or ckmc = '维修仓' or ckmc = '镶嵌柜-德钰东方' or ckmc like '%镶嵌%')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '发'
   and swlx <> '客户出货' and djm <> '单件调拨出库单'
			and djh not like 'zj20%'
)c;




select qc + rk-ck   as gfkc, qc + rk-ck  as gf
  from
(
 select if(sum(qcjz) is null, 0,sum(qcjz)) as qc
  from t_ka_ztkcrzz
 where ckmc not in ('料仓')
   and (jsmc = '古法金' or ckmc = '古法金柜' or ckmc = '古法硬金柜')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
	 and ckmc <> '硬金结算'
) a,
 (select if(sum(jz) is null, 0,sum(jz)) as rk
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '古法金' or ckmc = '古法金柜' or ckmc = '古法硬金柜')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '收'
	 and ckmc <> '硬金结算'
   and swlx <> '称重入库' and djm <> '单件调拨入库单'
			and djh not like 'zj20%'
)b,
 (select if(sum(jz) is null, 0,sum(jz)) as ck
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '古法金' or ckmc = '古法金柜' or ckmc = '古法硬金柜')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
	 and ckmc <> '硬金结算'
   and sffx = '发'
   and swlx <> '客户出货' and djm <> '单件调拨出库单'
			and djh not like 'zj20%'
)c;




select qc + rk-ck   as wgkc, qc + rk-ck as wgk
  from
(
 select if(sum(qcjz) is null, 0,sum(qcjz)) as qc
  from t_ka_ztkcrzz
 where ckmc not in ('料仓')
   and (jsmc = '足金(5g)' or ckmc = '精品g柜')
	 and ckmc <> '单件化硬金柜台'
	 and ckmc <> '硬金结算'
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
) a,
 (select if(sum(jz) is null, 0,sum(jz)) as rk
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '足金(5g)' or ckmc = '精品g柜')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
	 and ckmc <> '单件化硬金柜台'
	 and ckmc <> '硬金结算'
   and sffx = '收'
   and swlx <> '称重入库' and djm <> '单件调拨入库单'
			and djh not like 'zj20%'
)b,
 (select if(sum(jz) is null, 0,sum(jz)) as ck
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '足金(5g)' or ckmc = '精品g柜')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '发'
	 and ckmc <> '单件化硬金柜台'
	 and ckmc <> '硬金结算'
   and swlx <> '客户出货' and djm <> '单件调拨出库单'
			and djh not like 'zj20%'
)c;


select qc + rk-ck   as gfwzkc, qc + rk-ck as gfwz
  from
(
 select if(sum(qcjz) is null, 0,sum(qcjz)) as qc
  from t_ka_ztkcrzz
 where ckmc not in ('料仓')
   and (jsmc = '古法万足金' or jsmc = '万足古法')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
	 and ckmc <> '硬金结算'
	 and ckmc <> '古法金柜'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
) a,
 (select if(sum(jz) is null, 0,sum(jz)) as rk
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '古法万足金' or jsmc = '万足古法')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
	 and ckmc <> '硬金结算'
	 and ckmc <> '古法金柜'
   and sffx = '收'
   and swlx <> '称重入库' and djm <> '单件调拨入库单'
			and djh not like 'zj20%'
)b,
 (select if(sum(jz) is null, 0,sum(jz)) as ck
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '古法万足金' or jsmc = '万足古法')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
	 and ckmc <> '硬金结算'
	 and ckmc <> '古法金柜'
   and sffx = '发'
   and swlx <> '客户出货' and djm <> '单件调拨出库单'
			and djh not like 'zj20%'
)c;



select qc + rk-ck   as gfwjkc, qc + rk-ck as gfwj -- into
  from
(
 select if(sum(qcjz) is null, 0,sum(qcjz)) as qc
  from t_ka_ztkcrzz
 where ckmc not in ('料仓')
   and (jsmc = '古法999.99')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
) a,
 (select if(sum(jz) is null, 0,sum(jz)) as rk
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '古法999.99')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '收'
   and swlx <> '称重入库' and djm <> '单件调拨入库单'
			and djh not like 'zj20%'
)b,
 (select if(sum(jz) is null, 0,sum(jz)) as ck
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '古法999.99')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '发'
   and swlx <> '客户出货' and djm <> '单件调拨出库单'
			and djh not like 'zj20%'
)c;









select qc + rk-ck   as qzccjkc, qc + rk-ck as qzccj
  from
(
 select if(sum(qcjz) is null, 0,sum(qcjz)) as qc
  from t_ka_ztkcrzz
 where ckmc not in ('料仓')
   and (jsmc = '千足赤辰金')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
) a,
 (select if(sum(jz) is null, 0,sum(jz)) as rk
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '千足赤辰金')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '收'
   and swlx <> '称重入库' and djm <> '单件调拨入库单'
			and djh not like 'zj20%'
)b,
 (select if(sum(jz) is null, 0,sum(jz)) as ck
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '千足赤辰金')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '发'
   and swlx <> '客户出货' and djm <> '单件调拨出库单'
			and djh not like 'zj20%'
)c;






select qc + rk-ck   as qzccjkc, qc + rk-ck as qzccj
  from
(
 select if(sum(qcjz) is null, 0,sum(qcjz)) as qc
  from t_ka_ztkcrzz
 where ckmc not in ('料仓')
   and (jsmc = '千足赤辰金')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
) a,
 (select if(sum(jz) is null, 0,sum(jz)) as rk
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '千足赤辰金')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '收'
   and swlx <> '称重入库' and djm <> '单件调拨入库单'
			and djh not like 'zj20%'
)b,
 (select if(sum(jz) is null, 0,sum(jz)) as ck
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '千足赤辰金')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '发'
   and swlx <> '客户出货' and djm <> '单件调拨出库单'
			and djh not like 'zj20%'
)c;







select qc + rk-ck   as wzccjkc, qc + rk-ck as wzccj
  from
(
 select if(sum(qcjz) is null, 0,sum(qcjz)) as qc
  from t_ka_ztkcrzz
 where ckmc not in ('料仓')
   and (jsmc = '万足赤辰金')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
) a,
 (select if(sum(jz) is null, 0,sum(jz)) as rk
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '万足赤辰金')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '收'
   and swlx <> '称重入库' and djm <> '单件调拨入库单'
			and djh not like 'zj20%'
)b,
 (select if(sum(jz) is null, 0,sum(jz)) as ck
  from t_ka_splsz
 where ckmc not in ('料仓')
   and (jsmc = '万足赤辰金')
   and date_format(rq,'yyyy-MM-dd')='2023-01-08'
   and wdmc = '深圳展厅'
   and dt='2023-01-08'
   and sffx = '发'
   and swlx <> '客户出货' and djm <> '单件调拨出库单'
			and djh not like 'zj20%'
)c;

 select  qk + wk + xk + yjqk + wjk + gf + gfwz + gfwj + wgk + wqk + qzccj + wzccj   as zkc
  from ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_temp12, ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_temp13, ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_temp14, ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_yj6, ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_wj6, ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_tempg15, ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_tempgfwz15, ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_tempgfwj15, ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_tempqzccj15, ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_tempwzccj15, ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_tempwg15, ods_cx_zt_dxbb_sz_cs_qzccj_1_temp_wq6;

use zfq_test_decent_cloud;



select if(sum(total_weight) is null, 0,sum(total_weight)) as l
  from t_bf_gold_transfer_out
where transfer_out_showroom = '深圳展厅'
   and transfer_in_showroom = '福州工厂'
   and approve_status = 1
   and status = 0
   and dt='2023-01-09'
   and date_format(rq ,'yyyy-MM-dd')= '2023-01-09'
;


select case when  if(t2.category_name is null, '',t2.category_name) = '' then '饰品' else t2.category_name end as yjpl, sum(t2.net_weight) as jz
  from t_sale_from t1
inner join t_sale_from_detail t2
   on t1.sale_identity = t2.sale_identity
		and t2.status = 0 and t1.dt='2023-01-09' and t2.dt='2023-01-09'
inner join t_purity t3
   on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-09'
where t1.showroom_name = '深圳展厅'
   and date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-09'
   and t3.purity_name = '千足金'
   and t1.approve_status = 1 and t1.status = 0
   and t2.counter_name <> '金条柜'
   and t2.counter_name <> '镶嵌q柜'
   and t2.counter_name not like '%镶嵌%'
   and t2.counter_name <> '硬金柜'
   and t2.counter_name <> '精品g柜'
   and t2.counter_name <> '精品d柜'
   and t2.counter_name <> '精品f柜'
group by t2.category_name;


select '合计' as yjpl, sum(t2.net_weight) as jz
  from t_sale_from t1
inner join t_sale_from_detail t2
   on t1.sale_identity = t2.sale_identity
		and t2.status = 0 and t1.dt='2023-01-09' and t2.dt='2023-01-09'
inner join t_purity t3
   on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-09'
where t1.showroom_name = '深圳展厅'
   and date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-09'
   and t3.purity_name = '千足金'
   and t1.approve_status = 1 and t1.status = 0
   and t2.counter_name <> '金条柜'
   and t2.counter_name <> '镶嵌q柜'
   and t2.counter_name not like '%镶嵌%'
   and t2.counter_name <> '硬金柜'
   and t2.counter_name <> '精品g柜'
   and t2.counter_name <> '精品d柜'
   and t2.counter_name <> '精品f柜';


select case when if(t2.category_name is null, '',t2.category_name) = '' then '饰品' else t2.category_name end as yjpl, sum(t2.net_weight) as jz
  from t_sale_from t1
inner join t_sale_from_detail t2
   on t1.sale_identity = t2.sale_identity
		and t2.status = 0 and t1.dt='2023-01-09' and t2.dt='2023-01-09'
inner join t_purity t3
   on t1.purity_identity = t3.purity_identity and t3.dt='2023-01-09'
where t1.showroom_name = '深圳展厅'
   and date_format(t1.bill_date,'yyyy-MM-dd') = '2023-01-09'
   and t3.purity_name = '千足金'
   and t2.counter_name <> '精品g柜'
and t1.approve_status = 1 and t1.status = 0
   and (t2.counter_name = '精品d柜' or t2.counter_name = '精品f柜')
group by t2.category_name;



select  if(sum(total_weight) is null, 0,sum(total_weight)) as jz
from t_bf_gold_transfer_out_print
where transfer_out_showroom = '深圳展厅' and transfer_in_showroom = '福州工厂' and genus_name = '金料' and (purity_name = '旧料' or purity_name = '万足旧料')
and date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and approve_status = 1 and status = 0 and dt='2023-01-09';

select if(sum(total_weight) is null, 0,sum(total_weight)) as jz from t_bf_gold_transfer_out_print
where transfer_out_showroom = '深圳展厅' and transfer_in_showroom = '福州工厂' and genus_name = '金料' and purity_name = '千足金料'
and date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and approve_status = 1 and status = 0 and dt='2023-01-09';

select if(sum(total_weight) is null, 0,sum(total_weight)) as jz from t_bf_gold_transfer_out_print
where transfer_out_showroom = '深圳展厅' and transfer_in_showroom = '福州工厂' and genus_name = '金料' and purity_name = '五九金料'
and date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and approve_status = 1 and status = 0 and dt='2023-01-09'
;


select if(sum(weight) is null, 0,sum(weight) ) as jz from t_bf_gold_transfer_out_print t1, t_bf_gold_transfer_out_print_detail t2
where t1.transfer_out_showroom = '深圳展厅' and t1.transfer_in_showroom = '福州工厂' and t1.genus_name = '饰品'
and date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and t1.approve_status = 1 and status = 0 and t1.dt='2023-01-09' and t2.dt='2023-01-09' and t1.gold_transfer_out_print_identity = t2.transfer_out_print_identity and t2.transfer_type = '熔料';

select if(sum(weight) is null, 0,sum(weight) ) as jz from t_bf_gold_transfer_out_print t1, t_bf_gold_transfer_out_print_detail t2
where t1.transfer_out_showroom = '深圳展厅' and t1.transfer_in_showroom = '福州工厂' and t1.genus_name = '饰品'
and date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and t1.approve_status = 1 and status = 0  and t1.dt='2023-01-09' and t2.dt= '2023-01-09' and t1.gold_transfer_out_print_identity = t2.transfer_out_print_identity and (t2.transfer_type <> '熔料');

select if(sum(total_weight) is null, 0,sum(total_weight)) as jz from t_bf_gold_transfer_out_print
where transfer_out_showroom = '深圳展厅' and transfer_in_showroom = '福州工厂'
and date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and approve_status = 1 and status = 0 and dt='2023-01-09';


select if(sum(total_weight) is null, 0,sum(total_weight)) as jz from t_bf_gold_transfer_out_print
where transfer_out_showroom = '深圳展厅' and transfer_in_showroom = '深圳工厂' and genus_name = '金料' and (purity_name = '旧料' or purity_name = '万足旧料')
and date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and approve_status = 1 and status = 0 and dt='2023-01-09';



select
       round(if(qcjz is null, 0,qcjz)/1000, 0) as jz,
       qcjz as zl from (
select if(sum(qcjz) is null, 0,sum(qcjz)) qcjz from t_ka_ztkcrzz where wdmc = '深圳展厅' and date_format(rq,'yyyy-MM-dd')= '2023-01-09' and (jsmc not like '虚拟金料%') and jsmc <> '旧料'
and ckmc in ('料仓') and dt='2023-01-09'
)a ;


select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_gold_weight) is null, 0,sum(total_gold_weight)) jz from t_bf_buy_cus_material
where showroom_name = '深圳展厅' and date_format(create_time,'yyyy-MM-dd') = '2023-01-09' and approve_status = 1 and status = 0 and dt='2023-01-09'
)a;





select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(b.remaining_gold_weight) is null, 0,sum(b.remaining_gold_weight)) jz
  from t_bf_receive_meterial a,
		     t_bf_receive_meterial_detail b,
       (select t1.customer_identity,
							        case when t1.is_child = 0 then t1.customer_name else t2.customer_name end as customer_name
							   from t_fast_customer t1
									 left join t_fast_customer t2
										  on t1.parent_customer_identity = t2.customer_identity and t1.dt='2023-01-09' and t2.dt='2023-01-09') c
where date_format(a.record_date,'yyyy-MM-dd') = '2023-01-09'
  and a.showroom_name = '深圳展厅'
		and b.material_explain_name = '板料'
  and a.receive_meterial_identity = b.receive_meterial_identity
  and a.customer_identity = c.customer_identity
  and ( (c.customer_name not like '(珠宝公司)%')
        and (c.customer_name not like '(特艺城)%')
  						and c.customer_name <> '福建中金'
  						and (c.customer_name not like '中金购料%')
  						and c.customer_name <> '广东深圳德诚平安'
  						and c.customer_name <> '福建德诚'
  						and c.customer_name not like '(鑫囍缘)%')
  and a.approve_status = 1
		and a.status = 0
		and a.dt='2023-01-09'
		and b.dt='2023-01-09'
)a;



select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl  from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_in
where date_format(create_time,'yyyy-MM-dd') = '2023-01-09' and transfer_out_showroom like '山东%' and transfer_in_showroom = '深圳展厅' and approve_status = 1 and status = 0 and purity_name = '千足金料' and dt='2023-01-09'
)a;


select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(jz) is null, 0,sum(jz)) jz from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_in
where date_format(create_time,'yyyy-MM-dd') = '2023-01-09' and transfer_in_showroom = '深圳展厅' and transfer_out_showroom = '总部万足展厅' and approve_status = 1 and status = 0 and purity_name = '千足金料'
union all
select if(sum(b.remaining_gold_weight) is null, 0,sum(b.remaining_gold_weight)) jz
  from t_bf_receive_meterial a,
		     t_bf_receive_meterial_detail b,
       (select t1.customer_identity,
					          case when t1.is_child = 0 then t1.customer_name else t2.customer_name end as customer_name
					     from t_fast_customer t1
					  		 left join t_fast_customer t2
					  			  on t1.parent_customer_identity = t2.customer_identity and t1.dt='2023-01-09' and t2.dt='2023-01-09') c
 where date_format(a.record_date,'yyyy-MM-dd') = '2023-01-09'
	  and a.showroom_name = '深圳展厅'
			and b.material_explain_name = '板料'
			and c.customer_name like '(珠宝公司)%'
			and a.receive_meterial_identity = b.receive_meterial_identity
   and a.customer_identity = c.customer_identity
			and approve_status = 1
			and a.dt='2023-01-09'
			and b.dt='2023-01-09'
			and status = 0) b
) a
;



select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(jz) is null, 0,sum(jz)) jz from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_in
where date_format(create_time,'yyyy-MM-dd') = '2023-01-09' and transfer_in_showroom = '深圳展厅' and transfer_out_showroom = '特艺城展厅' and approve_status = 1 and status = 0 and purity_name = '千足金料'
union all
select if(sum(b.remaining_gold_weight) is null, 0,sum(b.remaining_gold_weight)) jz
  from t_bf_receive_meterial a,
		     t_bf_receive_meterial_detail b,
       (select t1.customer_identity,
					          case when t1.is_child = 0 then t1.customer_name else t2.customer_name end as customer_name
					     from t_fast_customer t1
					  		 left join t_fast_customer t2
					  			  on t1.parent_customer_identity = t2.customer_identity and t1.dt='2023-01-09' and t2.dt='2023-01-09') c
 where date_format(a.record_date,'yyyy-MM-dd') = '2023-01-09'
	  and a.showroom_name = '深圳展厅'
			and b.material_explain_name = '板料'
			and c.customer_name like '(特艺城)%'
			and a.receive_meterial_identity = b.receive_meterial_identity
   and a.customer_identity = c.customer_identity
			and approve_status = 1
			and a.dt='2023-01-09'
			and b.dt='2023-01-09'
			and status = 0) b
) a;



select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_in
where date_format(create_time,'yyyy-MM-dd') = '2023-01-09' and transfer_out_showroom like '北京%' and transfer_in_showroom = '深圳展厅' and approve_status = 1 and status = 0 and purity_name = '千足金料' and dt='2023-01-09'
)a

;


select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(b.remaining_gold_weight) is null, 0,sum(b.remaining_gold_weight)) as jz
  from t_bf_receive_meterial a,
		     t_bf_receive_meterial_detail b,
       (select t1.customer_identity,
					          case when t1.is_child = 0 then t1.customer_name else t2.customer_name end as customer_name
					     from t_fast_customer t1
					  		 left join t_fast_customer t2
					  			  on t1.parent_customer_identity = t2.customer_identity and t1.dt='2023-01-09' and t2.dt='2023-01-09') c
 where date_format(a.record_date,'yyyy-MM-dd') = '2023-01-09'
	  and a.showroom_name = '深圳展厅'
			and b.material_explain_name = '板料'
			and a.receive_meterial_identity = b.receive_meterial_identity
   and a.customer_identity = c.customer_identity
			and (c.customer_name = '福建中金'or c.customer_name like '中金购料%' or c.customer_name = '广东深圳德诚平安' or c.customer_name = '福建德诚')
			and approve_status = 1
			and a.dt='2023-01-09'
			and b.dt='2023-01-09'
			and status = 0
)a;


select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_in
where date_format(create_time,'yyyy-MM-dd') = '2023-01-09' and transfer_out_showroom = 'k金展厅' and transfer_in_showroom = '深圳展厅' and approve_status = 1 and status = 0 and purity_name = '千足金料' and dt='2023-01-09'
)a;


select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_in
where date_format(create_time,'yyyy-MM-dd') = '2023-01-09' and transfer_out_showroom = '深圳工厂' and transfer_in_showroom = '深圳展厅' and approve_status = 1 and status = 0 and (purity_name = '千足金料' or purity_name = '五九金料' and dt='2023-01-09')
)a ;



select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_in
where date_format(create_time,'yyyy-MM-dd') = '2023-01-09' and transfer_out_showroom = '福州工厂' and transfer_in_showroom = '深圳展厅' and approve_status = 1 and status = 0 and (purity_name = '千足金料' or purity_name = '五九金料' and dt='2023-01-09')
)a;



select a.type from t_receive_stream_type a where a.name = '委外收货流水' and dt='2023-01-09';
select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_gold_weight) is null, 0,sum(total_gold_weight)) jz from t_receive
 where date_format(create_time,'yyyy-MM-dd') = '2023-01-09' and showroom_name = '深圳展厅' and genus_name = '饰品'
			and exists(select 1 from ods_cx_zt_dxbb1_sz_temp_type_list a where a.type = t_receive.receive_status)
			and status = 0
   and supplier_type = 1
   and dt='2023-01-09'
)a;

select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_gold_weight) is null, 0,sum(total_gold_weight)) jz from t_bf_pay_outsource
 where date_format(create_time,'yyyy-MM-dd') = '2023-01-09'
   and showroom_name = '深圳展厅'
			and approve_status = 1
			and status = 0
			and dt='2023-01-09'
)a ;




select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_gold_weight) is null, 0,sum(total_gold_weight)) jz from t_bf_pay_outsource
 where date_format(create_time,'yyyy-MM-dd') = '2023-01-09'
   and showroom_name = '深圳展厅'
			and approve_status = 1
			and status = 0
			and dt='2023-01-09'
)a;



select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_gold_weight) is null, 0,sum(total_gold_weight)) jz
  from t_bf_pay_cus_material a
 inner join (select t1.customer_identity,
					          case when t1.is_child = 0 then t1.customer_name else t2.customer_name end as customer_name
					     from t_fast_customer t1
					  		 left join t_fast_customer t2
					  			  on t1.parent_customer_identity = t2.customer_identity and t1.dt='2023-01-09' and t2.dt='2023-01-09') b
		 	on a.customer_identity = b.customer_identity
where date_format(a.create_time,'yyyy-MM-dd') = '2023-01-09'
  and a.showroom_name = '深圳展厅'
  and (b.customer_name not like '(珠宝公司)%')
		and (b.customer_name not like '(特艺城)%')
  and b.customer_name <> '福建中金'
		and (b.customer_name not like '中金购料%')
		and b.customer_name <> '广东深圳德诚平安'
		and b.customer_name <> '福建德诚'
  and b.customer_name <> '(广东)深圳市翠绿黄金精炼有限公司'
		and b.customer_name <> '众恒隆'
		and b.customer_name <> '粤鑫'
		and b.customer_name <> '(广东)深圳市莆金珠宝首饰有限公司'
  and approve_status = 1
  and status = 0
  and dt='2023-01-09'
)a;



select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_gold_weight) is null, 0,sum(total_gold_weight)) jz
  from t_bf_pay_cus_material a
 inner join (select t1.customer_identity,
					          case when t1.is_child = 0 then t1.customer_name else t2.customer_name end as customer_name
					     from t_fast_customer t1
					  		 left join t_fast_customer t2
					  			  on t1.parent_customer_identity = t2.customer_identity and t1.dt='2023-01-09' and t2.dt='2023-01-09') b
		 	on a.customer_identity = b.customer_identity
where date_format(a.create_time,'yyyy-MM-dd') = '2023-01-09'
  and a.showroom_name = '深圳展厅' and (b.customer_name = '福建中金' or (b.customer_name like '中金购料%') or b.customer_name = '广东深圳德诚平安' or b.customer_name = '福建德诚')
			and approve_status = 1
			and status = 0
			and dt='2023-01-09'
)a;


select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_out_print
where date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and transfer_out_showroom = '深圳展厅' and transfer_in_showroom = '福州工厂' and (purity_name = '千足金料' or purity_name = '五九金料' and dt='2023-01-09')
  and approve_status = 1
  and status = 0
)a;



select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_out_print
where date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and transfer_out_showroom = '深圳展厅' and transfer_in_showroom = '深圳工厂' and (purity_name = '千足金料' or purity_name = '五九金料' and dt='2023-01-09')
  and approve_status = 1
  and status = 0
)a;

select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_out_print
where date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and transfer_out_showroom = '深圳展厅' and transfer_in_showroom = 'k金展厅' and purity_name = '千足金料'
  and approve_status = 1
  and status = 0
  and dt='2023-01-09'
)a ;



select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(jz) is null, 0,sum(jz)) jz from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_out_print
where date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and transfer_out_showroom = '深圳展厅' and transfer_in_showroom = '特艺城展厅' and purity_name = '千足金料'
  and approve_status = 1
  and status = 0
and dt='2023-01-09'
union all
select if(sum(total_gold_weight) is null, 0,sum(total_gold_weight)) jz
  from t_bf_pay_cus_material a
 inner join (select t1.customer_identity,
					          case when t1.is_child = 0 then t1.customer_name else t2.customer_name end as customer_name
					     from t_fast_customer t1
					  		 left join t_fast_customer t2
					  			  on t1.parent_customer_identity = t2.customer_identity and t1.dt='2023-01-09' and t2.dt='2023-01-09') b
		 	on a.customer_identity = b.customer_identity
where date_format(a.create_time,'yyyy-MM-dd') = '2023-01-09'
  and a.showroom_name = '深圳展厅'
		and b.customer_name like '(特艺城)%'
  and approve_status = 1
  and status = 0
  and a.dt='2023-01-09'
   )b
)a;


select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_out_print
where date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and transfer_out_showroom = '深圳展厅' and transfer_in_showroom like '山东%' and purity_name = '千足金料'
  and approve_status = 1
  and status = 0
  and dt='2023-01-09'
)a;

select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_out_print
where date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and transfer_out_showroom = '深圳展厅' and transfer_in_showroom like '北京%' and purity_name = '千足金料'
  and approve_status = 1
  and status = 0
  and dt='2023-01-09'
)a ;



select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl  from (
select if(sum(jz) is null, 0,sum(jz)) jz from (
select if(sum(total_weight) is null, 0,sum(total_weight)) jz from t_bf_gold_transfer_out_print
where date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09' and transfer_out_showroom = '深圳展厅' and transfer_in_showroom = '珠宝公司' and purity_name = '千足金料'
  and approve_status = 1
  and status = 0
  and dt='2023-01-09'
union all
select if(sum(total_gold_weight) is null, 0,sum(total_gold_weight)) jz
  from t_bf_pay_cus_material a
 inner join (select t1.customer_identity,
					          case when t1.is_child = 0 then t1.customer_name else t2.customer_name end as customer_name
					     from t_fast_customer t1
					  		 left join t_fast_customer t2
					  			  on t1.parent_customer_identity = t2.customer_identity and t1.dt='2023-01-09' and t2.dt='2023-01-09') b
		 	on a.customer_identity = b.customer_identity
where date_format(a.create_time,'yyyy-MM-dd') = '2023-01-09'
  and a.showroom_name = '深圳展厅'
		and b.customer_name like '(珠宝公司)%'
  and approve_status = 1
  and dt='2023-01-09'
  and status = 0)b
)a ;

select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_gold_weight) is null, 0,sum(total_gold_weight)) jz from t_bf_change_outsource
where date_format(create_time,'yyyy-MM-dd') = '2023-01-09' and showroom_name = '深圳展厅'
  and approve_status = 1
  and status = 0
  and dt='2023-01-09'
)a ;


select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_gold_weight) is null, 0,sum(total_gold_weight)) jz from t_sale_from
where date_format(bill_date,'yyyy-MM-dd') = '2023-01-09' and showroom_name = '深圳展厅' and sale_type = 'jl'
  and approve_status = 1
  and status = 0
  and dt='2023-01-09'
)a;


select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(remaining_gold_weight) is null, 0,sum(remaining_gold_weight)) jz
  from t_bf_receive_meterial a,
		     t_bf_receive_meterial_detail b,
       (select t1.customer_identity,
							        case when t1.is_child = 0 then t1.customer_name else t2.customer_name end as customer_name
							   from t_fast_customer t1
									 left join t_fast_customer t2
										  on t1.parent_customer_identity = t2.customer_identity and t1.dt='2023-01-09' and t2.dt='2023-01-09') c
 where a.receive_meterial_identity = b.receive_meterial_identity
	  and	date_format(a.rq,'yyyy-MM-dd') = '2023-01-09'
	  and a.showroom_name = '深圳展厅'
			and b.material_explain_name = '板料'
			and c.customer_name like '(鑫囍缘)%'
			and a.customer_identity = c.customer_identity
  and approve_status = 1
  and status = 0
  and a.dt='2023-01-09'
  and b.dt='2023-01-09'
) a;

select
       round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl from (
select if(sum(total_gold_weight) is null, 0,sum(total_gold_weight)) jz
  from t_bf_pay_cus_material a
 inner join (select t1.customer_identity,
					          case when t1.is_child = 0 then t1.customer_name else t2.customer_name end as customer_name
					     from t_fast_customer t1
					  		 left join t_fast_customer t2
					  			  on t1.parent_customer_identity = t2.customer_identity and t1.dt='2023-01-09' and t2.dt='2023-01-09') b
		 	on a.customer_identity = b.customer_identity
where date_format(a.create_time,'yyyy-MM-dd') = '2023-01-09' and a.showroom_name = '深圳展厅' and b.customer_name like '(鑫囍缘)%'
  and approve_status = 1
  and status = 0
  and a.dt='2023-01-09'
)a;


select round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl
  from (select if(sum(total_weight) is null, 0,sum(total_weight)) as jz
          from t_bf_gold_transfer_in
         where date_format(create_time,'yyyy-MM-dd') = '2023-01-09'
	   and transfer_out_showroom like '江西%'
	   and transfer_in_showroom = '深圳展厅'
	   and approve_status = 1
	   and status = 0
	   and dt='2023-01-09'
	   and purity_name = '千足金料') a ;


select round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl
  from (select if(sum(total_weight) is null, 0,sum(total_weight)) as jz
          from t_bf_gold_transfer_out_print
         where date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09'
           and transfer_out_showroom = '深圳展厅'
           and transfer_in_showroom like '江西%'
           and purity_name = '千足金料'
           and approve_status = 1
           and status = 0
		   and dt='2023-01-09'
		   ) a ;


select round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl
  from (select if(sum(total_weight) is null, 0,sum(total_weight)) as jz
          from t_bf_gold_transfer_in
         where date_format(create_time,'yyyy-MM-dd') = '2023-01-09'
          and transfer_out_showroom like '浙江德鑫%'
          and transfer_in_showroom = '深圳展厅'
          and approve_status = 1
          and status = 0
          and purity_name = '千足金料'
		  and dt='2023-01-09'
		  ) a ;

select round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl
  from (select if(sum(total_weight) is null, 0,sum(total_weight)) as jz
          from t_bf_gold_transfer_out_print
         where date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09'
           and transfer_out_showroom = '深圳展厅'
           and transfer_in_showroom like '浙江德鑫%'
           and purity_name = '千足金料'
           and approve_status = 1
           and status = 0
		   and dt='2023-01-09'
		   ) a ;

select round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl
  from (select if(sum(total_weight) is null, 0,sum(total_weight)) as jz
          from t_bf_gold_transfer_in
         where date_format(create_time,'yyyy-MM-dd') = '2023-01-09'
          and transfer_out_showroom like '成都展厅%'
          and transfer_in_showroom = '深圳展厅'
          and approve_status = 1
          and status = 0
          and purity_name = '千足金料'
		  and dt='2023-01-09'
		  ) a ;


select round(if(jz is null, 0,jz)/1000, 0) as jz,
       jz as zl
  from (select if(sum(total_weight) is null, 0,sum(total_weight)) as jz
          from t_bf_gold_transfer_out_print
         where date_format(deliver_goods_time,'yyyy-MM-dd') = '2023-01-09'
           and transfer_out_showroom = '深圳展厅'
           and transfer_in_showroom like '成都展厅%'
           and purity_name = '千足金料'
           and approve_status = 1
           and status = 0
		   and dt='2023-01-09'
		   ) a ;


select case when (jsmc = '千足硬金' or jsmc = '足金') and ckmc <> '镶嵌q柜' and ckmc <> '镶嵌硬金柜' and ckmc <> '维修仓' then '千足金'

												when ckmc in ('料仓') then ''
												when ckmc = '镶嵌q柜' or ckmc = '镶嵌硬金柜' or ckmc = '维修仓' then '千足嵌'
							else jsmc end as csmc,
       case when
							   ckmc in ('料仓') then concat('料仓-', jsmc)
							else ckmc end as ckmc,
       qcjz as qc,
						 0 as rkzl,
						 0 as ckzl,
						 0 as a1,
						 0 as a2,
						 0 as a3,
						 0 as a4,
						 0 as a5,
						 0 as a6,
						 0 as a7,
						 0 as rkhj,
						 0 as b1,
						 0 as b2,
						 0 as b3,
						 0 as b4,
						 0 as b5,
						 0 as b6,
						 0 as ckhj,
						 0 as yk,
						 0 as yc,
						 0 as sc,
						 0 as cd
  from t_ka_ztkcrzz where wdmc = '深圳展厅' and date_format(rq,'yyyy-MM-dd') = '2023-01-09' and (jsmc not like '虚拟金料%') and dt='2023-01-09';




select case when (jsmc = '千足硬金' or jsmc = '足金') and ckmc <> '镶嵌q柜' and ckmc <> '镶嵌硬金柜' and ckmc <> '维修仓' then '千足金'

												when ckmc in ('料仓') then ''
												when ckmc = '镶嵌q柜' or ckmc = '镶嵌硬金柜' or ckmc = '维修仓' then '千足嵌'
						 else jsmc end as csmc,
       case when
							     ckmc in ('料仓') then concat('料仓-', jsmc)
							else ckmc end as ckmc,
							0 as qc,
       sum(case when swlx in ('调拨入库', '维修') and sffx = '收' and djm <> '单件调拨入库单' then round(jz, 3) else 0 end) as a1,
       sum(case when ((swlx = '委外入库') or (swlx = '换料入库')) and sffx = '收' then round(jz, 3) else 0 end) as a2,
       sum(case when (swlx = '采购入库' or swlx = '购客户成品') and sffx = '收' then round(jz, 3) else 0 end) as a3,
       sum(case when swlx = '客户来料' then round(jz, 3) else 0 end) as a4,
       sum(case when swlx = '客户退饰' and sffx = '收' then round(jz, 3) else 0 end) as a5,
       sum(case when swlx = '转仓入库' and sffx = '收' then round(jz, 3) else 0 end) as a6,
       sum(case when swlx = '成色转换' and sffx = '收' then if(jz is null, 0,jz)
                when swlx = '成色转换' and sffx = '发' then 0-if(jz is null, 0,jz)
									  else 0 end) as a7,
       sum(case when swlx <> '称重入库' and djm <> '单件调拨入库单' and sffx = '收' then round(jz, 3) else 0 end) as rkhj,
       sum(case when swlx = '销售出库' and sffx = '发' then round(jz, 3) else 0 end) as b1,
       sum(case when swlx = '调拨出库' and sffx = '发'and djm <> '单件调拨出库单' then round(jz, 3) else 0 end) as b2,
       sum(case when swlx = '熔料' and sffx = '发' then round(jz, 3) else 0 end) as b3,
       sum(case when (swlx = '维修' or swlx = '清洗' or swlx = '质量问题') and sffx = '发' then round(jz, 3) else 0 end) as b4,
       sum(case when (swlx = '委外付料' or swlx = '委外退货' or swlx = '付料' or swlx = '付客户料') and sffx = '发' then round(jz, 3) else 0 end) as b5,
       sum(case when swlx = '转仓出库' and sffx = '发' then round(jz, 3) else 0 end) as b6,
       sum(case when swlx <> '客户出货' and djm <> '单件调拨出库单' and sffx = '发' then round(jz, 3) else 0 end) as ckhj,
       sum(case when swlx = '盈亏调整' then round(jz, 3) else 0 end) as yk,
       0 as yc,
							0 as sc,
							0 as cd
 from t_ka_splsz where wdmc = '深圳展厅' and date_format(rq,'yyyy-MM-dd') = '2023-01-09' and (jsmc not like '虚拟金料%') and dt='2023-01-09'
group by ckmc, jsmc;


select case when (purity_name = '千足硬金' or purity_name = '足金') and counter_name <> '镶嵌q柜' and counter_name <> '镶嵌硬金柜' and counter_name <> '维修仓' then '千足金'

												when counter_name in ('料仓') then ''
												when counter_name = '镶嵌q柜' or counter_name = '镶嵌硬金柜' or counter_name = '维修仓' then '千足嵌'
							else purity_name end as csmc,
       case when
							     counter_name in ('料仓') then concat('料仓-', purity_name)
							 else counter_name end as ckmc,
							0 as qc,
       0 as a1,
							0 as a2,
							0 as a3,
							0 as a4,
							0 as a5,
							0 as a6,
							0 as a7,
							0 as rkhj,
							0 as b1,
							0 as b2,
							0 as b3,
							0 as b4,
							0 as b5,
							0 as b6,
							0 as ckhj,
							0 as yk,
							0 as yc,
							t_bf_weighing_form_check.tray_gold_weight as sc,
							0 as cd
 from t_bf_weighing_form_check where showroom_name = '深圳展厅' and date_format(weighing_date,'yyyy-MM-dd') = '2023-01-09' and dt='2023-01-09'
;


select 999 as xh,
       concat(csmc, (case when t1.ckmc like '料仓%' then '金料' else '饰品' end)) as kclx,
       t2.counter_code as ckbm,
							t1.ckmc,
							t1.qc,
       t1.a1, t1.a2, t1.a3, t1.a4, t1.a5, t1.a6, t1.a7, t1.rkhj,
       t1.b1, t1.b2, t1.b3, t1.b4, t1.b5, t1.b6, t1.ckhj,
       t1.yk,
       t1.yc, t1.sc, t1.cd
   from ods_cx_zt_dxbb1_sz_temp_temp4 t1
	 left join t_showroom_counter t2
		  on (case when t1.ckmc like '镶嵌q%' then '镶嵌q柜'
             when t1.ckmc like '镶嵌硬金%' then '镶嵌硬金柜'
								else t1.ckmc end) = t2.counter_name
			and t2.showroom_identity = '439228e3-1bfe-11eb-952f-beb5915aa4c3' and t2.dt='2023-01-09';

select '昨日库存' as mc, sum(qcjz) as zl, 0 as je, '' as bz   from t_ka_ztkcrzz
 where wdmc = '深圳展厅' and date_format(rq,'yyyy-MM-dd') = '2023-01-09' and (jsmc not like '虚拟金料%') and ckmc not in ('料仓') and dt='2023-01-09';



select supplier_name as khmc,
       round(sum(total_gold_weight),3) as zl,
       sum(total_fee) as je,
       '' as bz
  from t_receive
 where showroom_name = '深圳展厅'
	 and date_format(examine_time,'yyyy-MM-dd') =  '2023-01-09'
   and status = 0
   and receive_status in (select type from t_receive_stream_type a where a.name ='委外收货流水' and dt='2023-01-09' )
   and supplier_type = 1
   and purity_name <> '千足硬金'
  group by supplier_name;


select supplier_name as khmc,
       round(sum(total_gold_weight), 3) as zl,
       sum(total_fee) as je,
       '硬金' as bz
  from t_receive
 where showroom_name = '深圳展厅'
 	 and date_format(examine_time,'yyyy-MM-dd') =  '2023-01-09'
   and status = 0
   and receive_status in (select type from t_receive_stream_type a where a.name ='委外收货流水' and dt='2023-01-09' )
   and supplier_type = 1
   and purity_name = '千足硬金'
   and dt='2023-01-09'
  group by supplier_name;



select
       concat(t2.parent_customer_name, if(t2.child_customer_name is null, '',t2.child_customer_name)) as mc,
       sum(t1.gold_weight_sum) as zl,
       sum(t1.work_fee_amount_sum) as je,
       case when if(t1.if_show_remark is null, 0,t1.if_show_remark) = 1 then concat(t1.remark, '退货') else '退货' end as bz
  from t_bf_cust_return_jewelry t1
	inner join ods_cx_ztsz_cpbb_cs_5g_view_customer t2
	   on t1.customer_identity = t2.customer_identity and t1.dt='2023-01-10'
 where t1.showroom_name = '深圳展厅'
 	 and date_format(t1.approve_time,'yyyy-MM-dd') = '2023-01-10'
   and t1.approve_status = 1
   and t1.status = 0
 group by  t2.parent_customer_name, t2.child_customer_name, t1.if_show_remark, t1.remark;



select
       concat(t2.parent_customer_name, if(t2.child_customer_name is null, '',t2.child_customer_name)) as mc,
       sum(total_weight)as zl,
       sum(total_price) as je,
       '' as bz
  from t_bf_buy_cus_item t1
	inner join ods_cx_ztsz_cpbb_cs_5g_view_customer t2
	   on t1.customer_identity = t2.customer_identity and t1.dt='2023-01-10'
 where t1.showroom_name = '深圳展厅'
   and date_format(t1.approve_time,'yyyy-MM-dd') = '2023-01-10'
   and t1.approve_status = 1
   and t1.status = 0
 group by t2.parent_customer_name, t2.child_customer_name;



select '盘点盈亏' as mc,
       sum(jz) as zl,
       null as je,
       '' as bz
  from t_ka_splsz
 where date_format(rq,'yyyy-MM-dd') = '2023-01-10' and dt='2023-01-10'
   and wdmc = '深圳展厅'
   and swlx = '盈亏调整';


select mc,
sum(zl),
sum(je),
bz
from (select  '深圳工厂' as mc,
       sum(if(total_weight is null, 0,total_weight)) as zl,
       sum(if(total_price is null, 0,total_price)) as je,
       '' as bz
 from t_bf_gold_transfer_in
where transfer_out_showroom = '深圳工厂'
  and transfer_in_showroom = '深圳展厅'
  and date_format(approve_time,'yyyy-MM-dd') = '2023-01-10'
  and approve_status = 1
  and status = 0
  and dt='2023-01-10'
  and genus_name <> '金料'
union all
SELECT
'深圳工厂' as mc,
sum(if(total_gold_weight is null,0,total_gold_weight)) as zl,
sum(if(total_fee is null,0,total_fee)) as je,
'' as bz
FROM
 t_receive r
WHERE
 r.supplier_type = 0
 and r.supplier_source = '深圳工厂'
 AND r.STATUS = 0
 and dt='2023-01-10'
 and  date_format(examine_time,'yyyy-MM-dd') = '2023-01-10'
 and showroom_name='深圳展厅')t group by mc,bz;


select '福州工厂千足' as mc, sum(total_weight) as zl, sum(if(total_price is null, 0,total_price )) as je, '' as bz
 from t_bf_gold_transfer_in where transfer_out_showroom = '福州工厂' and transfer_in_showroom = '深圳展厅'
and date_format(approve_time,'yyyy-MM-dd') = '2023-01-10' and approve_status = 1 and dt='2023-01-10'
   and status = 0
    and  genus_name <> '金料' and purity_name <> '金9999' and purity_name <> '金99999' and purity_name <> '古法金' and purity_name <> '足金(5g)' and technology_type <> '5g'
and purity_name <> '古法万足金' and purity_name <> '古法999.99' and purity_name <> '足金(无氰)';



select '福州工厂万足' as mc, sum(total_weight) as zl, sum(if(total_price is null, 0,total_price )) as je, '' as bz
from t_bf_gold_transfer_in where transfer_out_showroom = '福州工厂' and transfer_in_showroom = '深圳展厅'
and date_format(approve_time,'yyyy-MM-dd') = '2023-01-10' and approve_status = 1
   and status = 0
   and dt='2023-01-10'
    and  genus_name <> '金料' and purity_name = '金9999';

select '福州工厂五九金' as mc, sum(total_weight) as zl, sum(if(total_price is null, 0,total_price )) as je, '' as bz
from t_bf_gold_transfer_in where transfer_out_showroom = '福州工厂' and transfer_in_showroom = '深圳展厅'
and date_format(approve_time,'yyyy-MM-dd') = '2023-01-10' and approve_status = 1
   and status = 0
   and dt='2023-01-10'
    and  genus_name <> '金料' and purity_name = '金99999';




select '千足售' as mc, sum(zl)as zl, 0 as je, '' as bz from
(
select '千足售' as mc, - sum(total_gold_weight) as zl, 0 as je, '' as bz from t_sale_from t1
inner join t_purity t2
on t1.purity_identity =t2.purity_identity
where t1.showroom_name = '深圳展厅'
  and date_format(t1.approve_time,'yyyy-MM-dd') = '2023-01-10' and approve_status = 1
   and t1.status = 0
    and t2.dt='2023-01-10'
   and t1.dt='2023-01-10'
   and t1.sale_type <> 'jl' and t2.purity_name <> '金9999'and t2.purity_name <> '金99999'
and t2.purity_name <> '古法金'and t2.purity_name <> '足金(5g)' and t2.purity_name <> '古法万足金' and t2.purity_name <> '古法999.99' and t2.purity_name <> '足金(无氰)'
union all
select '千足售' as mc, - sum(total_weight) as zl, 0 as je, '' as bz from t_bf_gold_transfer_out
where transfer_out_showroom = '深圳展厅' and  genus_name <> '金料' and date_format(approve_time,'yyyy-MM-dd') = '2023-01-10' and approve_status = 1
   and status = 0
   and dt='2023-01-10'
    and purity_name <> '金9999'and purity_name <> '金99999' and purity_name <> '古法金'
and purity_name <> '足金(5g)' and purity_name <> '古法万足金' and purity_name <> '古法999.99' and purity_name <> '足金(无氰)'
union all
select '千足售' as mc, - sum(return_total_weight)as zl, 0 as je, '' as bz from t_sales_return
where showroom_name = '深圳展厅' and date_format(examine_time,'yyyy-MM-dd') = '2023-01-10'
	and dt='2023-01-10'
   and status = 0
   and supplier_type = 1
    and purity_name <> '金9999' and purity_name <> '金99999' and purity_name <> '古法金'and purity_name <> '足金(5g)'
and purity_name <> '古法万足金' and purity_name <> '古法999.99' and purity_name <> '足金(无氰)'
) a;


select '万足售' as mc, sum(zl)as zl, 0 as je, '' as bz from
(
select '万足售' as mc, -sum(total_gold_weight)as zl, 0 as je, '' as bz from t_sale_from t1
inner join t_purity t2
on t1.purity_identity =t2.purity_identity
where t1.showroom_name = '深圳展厅' and date_format(t1.approve_time,'yyyy-MM-dd') = '2023-01-10' and t1.approve_status = 1
  and t1.status = 0
  and t1.dt='2023-01-10'
  and t2.dt='2023-01-10'
  and t1.sale_type <> 'jl' and t2.purity_name = '金9999'
union all
select '万足售' as mc, -sum(total_weight)as zl, 0 as je, '' as bz from t_bf_gold_transfer_out
where transfer_out_showroom = '深圳展厅' and  genus_name <> '金料' and date_format(approve_time,'yyyy-MM-dd') = '2023-01-10' and approve_status = 1
   and status = 0
   and dt='2023-01-10'
    and purity_name = '金9999'
union all
select '万足售' as mc, -sum(return_total_weight)as zl, 0 as je, '' as bz from t_sales_return
where showroom_name = '深圳展厅' and date_format(examine_time,'yyyy-MM-dd') = '2023-01-10'
and dt='2023-01-10'
   and status = 0
   and supplier_type = 1
    and purity_name = '金9999'
) a ;


select '五九金售' as mc, sum(zl)as zl, 0 as je, '' as bz from
(
select '五九金售' as mc, -sum(total_gold_weight)as zl, 0 as je, '' as bz from t_sale_from t1
inner join t_purity t2
on t1.purity_identity =t2.purity_identity
where t1.showroom_name = '深圳展厅' and date_format(t1.approve_time,'yyyy-MM-dd') = '2023-01-10' and t1.approve_status = 1
   and t1.status = 0
   and t1.dt='2023-01-10'
   and t2.dt='2023-01-10'
    and t1.sale_type <> 'jl' and t2.purity_name = '金99999'
union all
select '五九金售' as mc, -sum(total_weight)as zl, 0 as je, '' as bz from t_bf_gold_transfer_out
where transfer_out_showroom = '深圳展厅' and  genus_name <> '金料' and date_format(approve_time,'yyyy-MM-dd') = '2023-01-10' and approve_status = 1
   and status = 0
   and dt='2023-01-10'
    and purity_name = '金99999'
union all
select '五九金售' as mc, -sum(return_total_weight)as zl, 0 as je, '' as bz from t_sales_return
where showroom_name = '深圳展厅' and date_format(examine_time,'yyyy-MM-dd') = '2023-01-10'
  and dt='2023-01-10'
   and status = 0
   and supplier_type = 1
    and purity_name = '金99999'
) a;


select '古法金售' as mc, sum(zl)as zl, 0 as je, '' as bz from
(
select '古法金售' as mc, - sum(total_gold_weight)as zl, 0 as je, '' as bz from t_sale_from t1
inner join t_purity t2
on t1.purity_identity =t2.purity_identity
where t1.showroom_name = '深圳展厅' and date_format(t1.approve_time,'yyyy-MM-dd') = '2023-01-10' and t1.approve_status = 1
   and t1.status = 0
   and t1.dt='2023-01-10'
     and t2.dt='2023-01-10'
    and t1.sale_type <> 'jl' and t2.purity_name = '古法金'
union all
select '古法金售' as mc, - sum(total_weight)as zl, 0 as je, '' as bz from t_bf_gold_transfer_out
where transfer_out_showroom = '深圳展厅' and  genus_name <> '金料' and date_format(approve_time,'yyyy-MM-dd') = '2023-01-10' and approve_status = 1
   and status = 0
   and dt='2023-01-10'
   and purity_name = '古法金'
union all
select '古法金售' as mc, -sum(return_total_weight)as zl, 0 as je, '' as bz from t_sales_return
where showroom_name = '深圳展厅' and date_format(examine_time,'yyyy-MM-dd') = '2023-01-10'
and dt='2023-01-10'
   and status = 0
   and supplier_type = 1
    and purity_name = '古法金'
) a;

select '足金(5g)售' as mc, sum(zl)as zl, 0 as je, '' as bz from
(
select '足金(5g)售' as mc, -sum(total_gold_weight)as zl, 0 as je, '' as bz from t_sale_from t1
inner join t_purity t2
on t1.purity_identity =t2.purity_identity
where t1.showroom_name = '深圳展厅' and date_format(t1.approve_time,'yyyy-MM-dd') = '2023-01-10' and t1.approve_status = 1
   and t1.status = 0
   and t1.dt='2023-01-10'
   and t2.dt='2023-01-10'
    and t1.sale_type <> 'jl' and t2.purity_name = '足金(5g)'
union all
select '足金(5g)售' as mc, -sum(total_weight)as zl, 0 as je, '' as bz from t_bf_gold_transfer_out
where transfer_out_showroom = '深圳展厅' and  genus_name <> '金料' and date_format(approve_time,'yyyy-MM-dd') = '2023-01-10' and approve_status = 1
   and status = 0
and dt='2023-01-10'
    and purity_name = '足金(5g)'
union all
select '足金(5g)售' as mc, -sum(return_total_weight)as zl, 0 as je, '' as bz from t_sales_return
where showroom_name = '深圳展厅' and date_format(examine_time,'yyyy-MM-dd') = '2023-01-10'
	and dt='2023-01-10'
   and status = 0
   and supplier_type = 1
    and purity_name = '足金(5g)'
) a;

select '古法万足金售' as mc, sum(zl)as zl, 0 as je, '' as bz from
(
select '古法万足金售' as mc, -sum(total_gold_weight)as zl, 0 as je, '' as bz from t_sale_from t1
inner join t_purity t2
on t1.purity_identity =t2.purity_identity
where t1.showroom_name = '深圳展厅' and date_format(t1.approve_time,'yyyy-MM-dd') = '2023-01-10' and t1.approve_status = 1
   and t1.status = 0
	and t1.dt='2023-01-10'
   and t2.dt='2023-01-10'
   and t1.sale_type <> 'jl' and t2.purity_name = '古法万足金'
union all
select '古法万足金售' as mc, -sum(total_weight)as zl, 0 as je, '' as bz from t_bf_gold_transfer_out
where transfer_out_showroom = '深圳展厅' and  genus_name <> '金料' and date_format(approve_time,'yyyy-MM-dd') = '2023-01-10' and approve_status = 1
   and status = 0
	and dt='2023-01-10'
    and purity_name = '古法万足金'
union all
select '古法万足金售' as mc, -sum(return_total_weight)as zl, 0 as je, '' as bz from t_sales_return
where showroom_name = '深圳展厅' and date_format(examine_time,'yyyy-MM-dd') = '2023-01-10'
and dt='2023-01-10'
   and status = 0
   and supplier_type = 1
    and purity_name = '古法万足金'
) a;


select '古法999.99售' as mc, sum(zl)as zl, 0 as je, '' as bz from
(
select '古法999.99售' as mc, -sum(total_gold_weight)as zl, 0 as je, '' as bz from t_sale_from t1
inner join t_purity t2
on t1.purity_identity =t2.purity_identity
where t1.showroom_name = '深圳展厅' and date_format(t1.approve_time,'yyyy-MM-dd') = '2023-01-10' and t1.approve_status = 1
   and t1.status = 0
   and t1.dt='2023-01-10'
   and t2.dt='2023-01-10'
    and t1.sale_type <> 'jl' and t2.purity_name = '古法999.99'
union all
select '古法999.99售' as mc, -sum(total_weight)as zl, 0 as je, '' as bz from t_bf_gold_transfer_out
where transfer_out_showroom = '深圳展厅' and  genus_name <> '金料' and date_format(approve_time,'yyyy-MM-dd') = '2023-01-10' and approve_status = 1
   and status = 0
and dt='2023-01-10'
    and purity_name = '古法999.99'
union all
select '古法999.99售' as mc, -sum(return_total_weight)as zl, 0 as je, '' as bz from t_sales_return
where showroom_name = '深圳展厅' and date_format(examine_time,'yyyy-MM-dd') = '2023-01-10'
and dt='2023-01-10'
   and status = 0
   and supplier_type = 1
    and purity_name = '古法999.99'
) a;

select '足金(无氰)售' as mc, sum(zl)as zl, 0 as je, '' as bz from
(
select '足金(无氰)售' as mc, -sum(total_gold_weight)as zl, 0 as je, '' as bz from t_sale_from t1
inner join t_purity t2
on t1.purity_identity =t2.purity_identity
where t1.showroom_name = '深圳展厅' and date_format(t1.approve_time,'yyyy-MM-dd') = '2023-01-10' and t1.approve_status = 1
   and t1.status = 0
   and t1.dt='2023-01-10'
   and t2.dt='2023-01-10'
   and t1.sale_type <> 'jl' and t2.purity_name = '足金(无氰)'
union all
select '足金(无氰)售' as mc, -sum(total_weight)as zl, 0 as je, '' as bz from t_bf_gold_transfer_out
where transfer_out_showroom = '深圳展厅' and  genus_name <> '金料' and date_format(approve_time,'yyyy-MM-dd') = '2023-01-10' and approve_status = 1
   and status = 0
   and dt='2023-01-10'
   and purity_name = '足金(无氰)'
union all
select '足金(无氰)售' as mc, -sum(return_total_weight)as zl, 0 as je, '' as bz from t_sales_return
where showroom_name = '深圳展厅' and date_format(examine_time,'yyyy-MM-dd') = '2023-01-10'
and dt='2023-01-10'
   and status = 0
   and supplier_type = 1
    and purity_name = '足金(无氰)'
) a;



select mc,  zl,  je, bz from (
select * from ods_cx_ztsz_cpbb_cs_5g_temp5
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp6
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp9
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp7
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp8
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp20
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp10
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp110
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp1100
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp11000
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp11001
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp11002
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp11003
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp11004
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp22004
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp11
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp101
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp12
union all
select * from ods_cx_ztsz_cpbb_cs_5g_tempb2bc
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp13
union all
select * from ods_cx_ztsz_cpbb_cs_5g_tempdczb
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp15
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp150
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp1500
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp1501
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp1502
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp1503
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp1504
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp_cdzt
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp_hnzt
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp_syzt
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp14
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp17
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp170
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp1700
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp17000
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp17001
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp17002
union all
select * from ods_cx_ztsz_cpbb_cs_5g_temp17003
) a;



create table IF NOT EXISTS ads_cx_ztsz_cpbb_cs_5g(mc string,zl decimal(18,3),je decimal(18,3),bz string) partitioned by (dt string) location '/zfq_test_decent_cloud/ads_cx_ztsz_cpbb_cs_5g';


select
   concat('2023-01-10','展厅报表','(','深圳展厅',')') as mc,
   0.000 as gfje,
   0.000 as fk,
   ''as bz;


select
   concat('2023-01-10','的昨日金额')as mc,
   je as gfje ,
   null as fk,
lx as bz
  from t_ka_zrye
  where date_format(rq,'yyyy-MM-dd')=DATE_ADD(date_format('2023-01-10','yyyy-MM-dd'),-1) and lx='昨日余额' and wdmc='深圳展厅' and dt='2023-01-10';


   select concat('千足金当日结:', if(sum(gold_weight) is null,0,sum(gold_weight)) ,'*',round(if(sum(amount) is null,0,sum(amount))/if(sum(gold_weight) is null,0,sum(gold_weight)),3))as mc,
   if(sum(amount) is null,0,sum(amount))as gfje,
   null as fk,
   '' as bzf
 from t_sale_from h
 left join t_purity t on h.purity_identity=t.purity_identity and h.dt='2023-01-10' and t.dt='2023-01-10'
 left join t_sale_from_account_detail  f on h.sale_identity=f.sale_identity and f.dt='2023-01-10'
 where h.sale_identity=f.sale_identity and showroom_name='深圳展厅'  and t.purity_name='千足金'
 and date_format(h.bill_date,'yyyy-MM-dd')='2023-01-10' and account_method='结价' and h.approve_status=1 and h.`status`=0 and f.status = 0 and h.sale_type<>'jl'
  ;


select
   '千足金料工费' as mc,
   sum(case when (work_fee_type='来料转欠' or work_fee_type='（镶嵌）来料转欠') then gold_weight else 0 end)as jzf,
   0.000 as dj,
   sum(case when (work_fee_type='来料转欠'   or work_fee_type='（镶嵌）来料转欠' or account_method='转欠料' or account_method='转欠饰'or account_method='来料') then amount else 0 end) as gfje,
   '' as bzf
 from t_sale_from h
 left join t_purity t on h.purity_identity=t.purity_identity and h.dt='2023-01-10' and t.dt='2023-01-10'
 left join t_sale_from_account_detail  f on h.sale_identity=f.sale_identity and f.dt='2023-01-10'
 where h.sale_identity=f.sale_identity and showroom_name='深圳展厅'  and t.purity_name='千足金'
 and date_format(bill_date,'yyyy-MM-dd')='2023-01-10' and h.approve_status=1 and h. status =0 and f.status = 0 and h.sale_type<>'jl';


select
  '千足金料工费'as mc,
  0.000 as jzf,
  0.000 as dj,
  sum(money)as gfje,
  '' as bzf
 from  t_bf_repair  where  date_format(rq,'yyyy-MM-dd')='2023-01-10' and dt='2023-01-10'  and status=0;



select
   '千足金料工费'as mc,
   0.000 as jzf,
   0.000 as dj,
   sum(purify_amount) as gfje,
   ''as bzf
 from t_bf_receive_meterial h
  left join t_bf_receive_meterial_detail b on h.receive_meterial_identity=b.receive_meterial_identity and h.dt='2023-01-10' and b.dt='2023-01-10'
 where h.receive_meterial_identity=b.receive_meterial_identity and date_format(rq,'yyyy-MM-dd')='2023-01-10' and showroom_name='深圳展厅'
    and h.tech_purity_name = '三九';


select
   '千足金料工费' as mc,
   0.000 as jzf,
   0.000 as dj,
   if(sum(total_price) is null,0,sum(total_price)) as gfje,
   ''as bzf
 from t_bf_gold_transfer_out_print
 where (transfer_in_showroom='北京运营中心' or  transfer_in_showroom='北京金德尚运营中心' or transfer_in_showroom='总部万足展厅' or transfer_in_showroom='山东运营中心'
    or transfer_in_showroom='山东鑫囍缘运营中心'or transfer_in_showroom='德诚珠宝' or transfer_in_showroom='江西金德尚运营中心'
    or transfer_in_showroom='江西南昌展厅' or transfer_in_showroom='因美优品')
 and date_format(rq,'yyyy-MM-dd')='2023-01-10' and approve_status=1 and transfer_out_showroom='深圳展厅'  and genus_name<>'金料' and purity_name='千足金'
 and dt='2023-01-10'
 ;

select
   '千足金精品工费' as mc ,
   sum(additional_labour_price) as gfje,
   ''as bz
 from t_sale_from h
 left join t_purity t on h.purity_identity=t.purity_identity
 ,t_sale_from_detail b
 where h.sale_identity=b.sale_identity  and date_format(bill_date,'yyyy-MM-dd')='2023-01-10'  and showroom_name='深圳展厅'
    and(b.counter_name!='硬金柜'  and b.counter_name!='镶嵌q柜'  and b.counter_name!='镶嵌硬金柜')
    and t.purity_name='千足金' and h.approve_status=1 and h.status=0 and b.status = 0 and h.dt='2023-01-10' and t.dt='2023-01-10' and b.dt='2023-01-10';


select
   '千足金精品工费' as mc,
   sum(amount) as gfje,
   ''as bz
 from t_sale_from h
 left join t_purity c on h.purity_identity=c.purity_identity,
 t_sale_from_account_detail f
 where h.sale_identity=f.sale_identity and (work_fee_type='其他' or work_fee_type='含税'  or work_fee_type='退税费')
 and c.purity_name='千足金' and h.approve_status=1 and h.`status`=0 and f.status = 0 and h.sale_type<>'jl' and date_format(bill_date,'yyyy-MM-dd') = '2023-01-10' and showroom_name='深圳展厅'
 and h.dt='2023-01-10'
 and c.dt='2023-01-10'
 and f.dt='2023-01-10'
 ;


select
   concat('万足当日结价:',if(sum(gold_weight) is null,0,sum(gold_weight)),'*',round((if(sum(amount) is null,0,sum(amount))/if(sum(gold_weight) is null,0,sum(gold_weight))),2))as mc,
   if(sum(amount) is null,0,sum(amount))as gfje,
   null as fk,
   ''as bzf
 from t_sale_from h
 left join t_purity c on h.purity_identity=c.purity_identity,
 t_sale_from_account_detail f
 where h.sale_identity=f.sale_identity and showroom_name='深圳展厅'  and c.purity_name='金9999'
 and date_format(bill_date,'yyyy-MM-dd')='2023-01-10'  and account_method='结价' and h.approve_status=1 and h.status=0 and f.status = 0 and sale_type<>'jl'
 and h.dt='2023-01-10'
 and c.dt='2023-01-10'
 and f.dt='2023-01-10'
 ;



select
   '万足金料工费'as mc,
   sum(case when account_type='来料' then gold_weight else 0 end) as jzf,
   0.000 as dj,
   sum(case when (work_fee_type='来饰订饰转欠' or  work_fee_type='特殊转欠'or  work_fee_type='做现转欠' or work_fee_type='欠款欠料' or work_fee_type='来料转欠' or work_fee_type = '含签' ) then amount else 0 end) as gfje,
   ''as bzf
 from t_sale_from h
 left join t_purity c on h.purity_identity=c.purity_identity
 ,t_sale_from_account_detail f
 where h.sale_identity=f.sale_identity
 and date_format(bill_date,'yyyy-MM-dd')='2023-01-10' and showroom_name='深圳展厅'
 and c.purity_name='金9999' and h.approve_status=1 and h.status=0 and f.status = 0 and h.sale_type<>'jl'
 and h.dt='2023-01-10'
 and c.dt='2023-01-10'
 and f.dt='2023-01-10'
 ;


select
    '万足金料工费' as mc,
    0.000 as jzf,
    0.000 as dj,
    if(sum(total_weight) is null,0,sum(total_weight)) as gfje,
    ''as bzf
 from t_bf_gold_transfer_out_print
 where (transfer_in_showroom='北京运营中心' or  transfer_in_showroom='北京金德尚运营中心' or transfer_in_showroom='总部万足展厅'
     or transfer_in_showroom='山东运营中心'or transfer_in_showroom='山东鑫囍缘运营中心' or transfer_in_showroom='德诚珠宝'
     or transfer_in_showroom='江西金德尚运营中心' or transfer_in_showroom='江西南昌展厅' or transfer_in_showroom='因美优品')
 and date_format(rq,'yyyy-MM-dd')='2023-01-10'  and approve_status=1 and status=0 and transfer_out_showroom='深圳展厅'  and genus_name<>'金料' and purity_name='金9999'
 and dt='2023-01-10'
 ;


select
   '万足金料工费'as mc,
   0.000 as jzf,
   0.000 as dj,
   sum(purify_amount) as gfje,
   ''as bzf
 from t_bf_receive_meterial h,
  t_bf_receive_meterial_detail b
 where h.receive_meterial_identity=b.receive_meterial_identity and date_format(rq,'yyyy-MM-dd')='2023-01-10'  and showroom_name='深圳展厅'
    and h.tech_purity_name = '四九'
	and h.dt='2023-01-10'
	and b.dt='2023-01-10'
	;



select
    '万足精品工费' as mc,
    sum(additional_labour_price) as gfje,
    null as fk  ,
    ''as bz
 from t_sale_from h
 left join t_purity t on t.purity_identity=h.purity_identity,
 t_sale_from_detail b
 where h.sale_identity=b.sale_identity  and date_format(bill_date,'yyyy-MM-dd')='2023-01-10' and showroom_name='深圳展厅'
 and t.purity_name='金9999' and sale_type<>'jl' and h.approve_status=1 and h.status=0 and b.status = 0
 and h.dt='2023-01-10'
 and t.dt='2023-01-10'
 and b.dt='2023-01-10';


select
    '万足精品工费' as mc,
    sum(amount) as gfje,
    null as fk,
    '' as bz
  from t_sale_from h
  left join t_purity t on t.purity_identity=h.purity_identity,
  t_sale_from_account_detail f
  where h.sale_identity=f.sale_identity and ( work_fee_type='其他' or work_fee_type='含税'  or work_fee_type='退税费')
   and t.purity_name='金9999' and h.approve_status=1 and h.status=0 and f.status = 0 and sale_type<>'jl' and date_format(bill_date,'yyyy-MM-dd')='2023-01-10' and showroom_name='深圳展厅'
   and h.dt='2023-01-10'
   and t.dt='2023-01-10'
   and f.dt='2023-01-10'
   ;

select
   concat('五九金当日结价:',if(sum(f.gold_weight) is null,0,sum(f.gold_weight)),'*',round((if(sum(amount) is null,0,sum(amount))/if(sum(f.gold_weight) is null,0,sum(f.gold_weight))),2))as mc,
   if(sum(f.gold_weight) is null,0,sum(f.gold_weight)) * round((if(sum(amount) is null,0,sum(amount))/if(sum(f.gold_weight) is null,0,sum(f.gold_weight))),2) as gfje,
   null as fk,
   ''as bzf
 from t_sale_from h
 left join t_purity t on t.purity_identity=h.purity_identity,
 t_sale_from_account_detail f
 where h.sale_identity=f.sale_identity and showroom_name='深圳展厅'  and t.purity_name='金99999'
 and date_format(bill_date,'yyyy-MM-dd')='2023-01-10' and account_method='结价' and h.approve_status=1 and h.`status`=0 and f.status = 0  and sale_type<>'jl'
 and h.dt='2023-01-10'
 and t.dt='2023-01-10'
 and f.dt='2023-01-10'
 ;

select
   '五九金金料工费'as mc,
   sum(case when account_method='来料' then gold_weight else 0 end) as jzf,
   0.000 as dj,
   sum(case when (work_fee_type='来饰订饰转欠' or  work_fee_type='特殊转欠'or  work_fee_type='做现转欠' or work_fee_type='欠款欠料' or work_fee_type='来料转欠' or work_fee_type = '含签' ) then amount else 0 end) as gfje,
   ''as bzf
 from t_sale_from h
 left join t_purity t on t.purity_identity=h.purity_identity,
 t_sale_from_account_detail f
 where h.sale_identity=f.sale_identity
 and date_format(bill_date,'yyyy-MM-dd')='2023-01-10'
 and showroom_name='深圳展厅' and t.purity_name='金99999'
 and h.approve_status=1 and h.status=0 and f.status = 0
 and sale_type<>'jl'
 and h.dt='2023-01-10'
 and t.dt='2023-01-10'
 and f.dt='2023-01-10'
 ;


select
    '五九金金料工费' as mc,
    0.000 as jzf,
    0.000 as dj,
    if(sum(total_price) is null,0,sum(total_price)) as gfje,
    ''as bzf
 from t_bf_gold_transfer_out_print
 where (transfer_in_showroom='北京运营中心' or  transfer_in_showroom='北京金德尚运营中心' or transfer_in_showroom='总部万足展厅' or transfer_in_showroom='山东运营中心'
 or transfer_in_showroom='山东鑫囍缘运营中心' or transfer_in_showroom='德诚珠宝' or transfer_in_showroom='江西金德尚运营中心'
 or transfer_in_showroom='江西南昌展厅' or transfer_in_showroom='因美优品')
 and date_format(rq,'yyyy-MM-dd')='2023-01-10' and approve_status=1 and status=0 and transfer_out_showroom='深圳展厅'  and genus_name<>'金料' and purity_name='金99999'
 and dt='2023-01-10'
 ;

select
    '五九金金料工费'as mc,
    0.000 as jzf,
    0.000 as dj,
    sum(b.purify_amount) as gfje,
    ''as bzf
 from t_bf_receive_meterial h,
  t_bf_receive_meterial_detail b
 where h.receive_meterial_identity=b.receive_meterial_identity and date_format(rq,'yyyy-MM-dd')='2023-01-10' and showroom_name='深圳展厅' and status= 0
    and h.tech_purity_name = '五九'
	and h.dt='2023-01-10'
	and b.dt='2023-01-10'
	;



select
    '五九金金料工费' as mc,
    0.000 as jzf,
    0.000 as dj,
    if(0-sum(total_price) is null,0,0-sum(total_price)) as gfje,
    ''as bzf
 from  t_bf_gold_transfer_in
 where  transfer_out_showroom = '深圳工厂'
 and date_format(rq,'yyyy-MM-dd')='2023-01-10' and approve_status=1 and status=0 and transfer_in_showroom='深圳展厅'  and genus_name='金料' and purity_name='五九金料'
 and dt='2023-01-10'
 ;
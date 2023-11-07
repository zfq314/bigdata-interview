select 
a.province as sf, 
a.area_identity as id , 
b.area_name as qymc
from t_delay_region a 
inner join t_bf_area b
on a.area_identity = b.area_identity
where status = 0 and 
a.dt='2022-11-30' and b.dt='2022-11-30'
; 

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
 )t1

                       SELECT
                        t.field,
                        case t.type 
                        when 'varchar' then 'string,'
                        when 'datetime' then 'string,'
                        when 'bigint' then 'bigint,'
                        when 'int' then 'int,'
                        when 'tinyint' then 'int,'
                        when 'int' then 'int,'
												when 'bit' then 'int,'
												when 'smallint' then 'int,'
                        when 'longblob' then 'string,'
                        when 'date' then 'string,'
												when 'char' then 'string,'
                        when 'text' then 'string,'
												when 'double' then 'double,'
                        when 'longtext' then 'string,'
												when 'blob' then 'string,'
                        when 'decimal' then 'decimal(18,3),'
                        else 'type err--'  
                        end  as type
                       FROM
                        ( select field,type from(SELECT column_name AS field,data_type AS type,ORDINAL_POSITION a1,lead(ORDINAL_POSITION,1) over(ORDER BY ORDINAL_POSITION asc) as a2 FROM information_schema.COLUMNS WHERE  table_schema='decent_cloud' and table_name = "zyyj" group by field ORDER BY ORDINAL_POSITION asc)m where a2 is not null   ) t
                                                                                                union all 
                        SELECT
                        t.field,
                        case t.type 
                        when 'varchar' then 'string'
                        when 'datetime' then 'string'
                        when 'bigint' then 'bigint'
                        when 'int' then 'int'
                        when 'tinyint' then 'int'
                        when 'int' then 'int'
												when 'bit' then 'int'
												when 'double' then 'double'
												when 'smallint' then 'int'
                        when 'longblob' then 'string'
												when 'char' then 'string'
                        when 'date' then 'string'
                        when 'text' then 'string'
                        when 'longtext' then 'string'
												when 'blob' then 'string'
                        when 'decimal' then 'decimal(18,3)'
                        else 'type err--'  
                        end  as type
                       FROM
                        ( select field,type from(SELECT column_name AS field,data_type AS type,ORDINAL_POSITION a1,lead(ORDINAL_POSITION,1) over(ORDER BY ORDINAL_POSITION asc) as a2 FROM information_schema.COLUMNS WHERE  table_schema='decent_cloud' and table_name = "zyyj"   ORDER BY ORDINAL_POSITION asc)m where a2 is  null   ) t;
												
												
												
												
												select field from(
												SELECT CONCAT(column_name,',') AS field,lead(ORDINAL_POSITION,1) over(ORDER BY ORDINAL_POSITION asc) as a2 FROM information_schema.COLUMNS WHERE  table_schema='decent_cloud' and table_name = "t_sale_from" ORDER BY ORDINAL_POSITION asc
												)t   where a2 is not  null 
												
												union all 
												
												select field from(
												SELECT CONCAT(column_name) AS field,lead(ORDINAL_POSITION,1) over(ORDER BY ORDINAL_POSITION asc) as a2 FROM information_schema.COLUMNS WHERE  table_schema='decent_cloud' and table_name = "t_sale_from" ORDER BY ORDINAL_POSITION asc
												)t   where a2 is  null 
												
												                       	 
id, sale_code, sale_identity, if_update_work_fee, if_tax_rate, tax_rate, area, showroom_identity, showroom_name,  DATE_FORMAT(sale_date,'%Y-%m-%d %H:%i:%s')  sale_date, purity_identity, sale_type, customer_identity, main_customer_identity, 
admin_settle_accounts_identity, settle_accounts_identity, grain_price, total_number, total_gold_weight, total_weight, total_additional_labour, total_conversion_gold, total_label_price, total_stone_price, total_price, replace(replace(remark,'\n',''),'\t','') remark, discount_remark, 
if_print_remark, create_by, DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s')  create_time, approve_by, DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time, approve_status, update_by,DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s')  update_time, 
if_update_discount, discount, if_gold_work_stone, if_retail, type, retail_work_fee, status, if_dydf, child_customer_code, settle_child_customer_code, jjjz, jjje, lljzhj, llgfhj, zqljzhj, zqlgfje, zqsjzhj, fyhj, zqgfhj, zqjz, tsjz, tsjehj, jsjzxj, 
jsjexj, qzl, lk, DATE_FORMAT(bill_date,'%Y-%m-%d %H:%i:%s') bill_date, synchronize_zds, meterial_weight, meterial_price, meterial_code, jewelry_weight, jewelry_price, jewelry_code, invalid_why, print_count, gold_price, 
bdze,DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time
												
    AttemptID:attempt_1665929783632_1107_m_000000_1 Timed out after 600 secs Container killed by the ApplicationMaster. Container killed on request. Exit code is 143 Container exited with a non-zero exit code 143												
												

任务id
application_1665929783632_1107                                               


商业贷款转公积金
上海车牌牌照流程
装修贷款处理

有问题的数据

这几张表是数据比较大的表
lscqmxbb_eos
t_cpbszh_log_detail
t_ka_lscqmxb_b
t_ka_mxz
t_ka_szkhcqlxzz_b_history
t_ka_szkhcqlxzz_h_history
t_mxzh
t_product_basic_info


全值匹配我最爱，最左前缀要遵守；
带头大哥不能死，中间兄弟不能断；
索引列上少计算，范围之后全失效；
LIKE百分写最右，覆盖索引不写星；
不等空值还有 or，索引失效要少用；
VAR 引号不可丢，SQL 优化有诀窍。


1、全值匹配我最爱
2、最佳左前缀法则：如果索引了多例，要遵守最左前缀法则。指的是查询从索引的最左前列开始并且不跳过索引中的列。
3、不在索引列上做任何操作（计算、函数、（自动or手动）类型转换），会导致索引失效而转向全表扫描
4、存储引擎不能使用索引中范围条件右边的列
5、尽量使用覆盖索引（只访问索引的查询（索引列和查询列一致）），减少select *
6、mysql在使用不等于（!=或者<>）的时候无法使用索引会导致全表扫描
7、is null，is not null 也无法使用索引（早期版本不能走索引，后续版本应该优化过，可以走索引）
8、like以通配符开头（’%abc…’）mysql索引失效会变成全表扫描操作字符串不加单引号索引失效
9、少用or，用它连接时会索引失效


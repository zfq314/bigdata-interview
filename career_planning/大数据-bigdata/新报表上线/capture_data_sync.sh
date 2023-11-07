#! /bin/bash

if [ -n "$2" ] ;then
    do_date=$2
else
    do_date=`date -d '-1 day' +%F`
fi
sqoop=/data/program/sqoop-1.4.6/bin/sqoop


database=decent_cloud
passwd=dba@2022app
user=dba

import_data() {
	$sqoop import -D mapreduce.job.queuename=default \
	--driver com.mysql.cj.jdbc.Driver \
	--connect "jdbc:mysql://10.2.12.47:3306/decent_cloud?tinyInt1isBit=false&zerodatetimebehavior=converttonull&serverTimezone=GMT%2B8&&useSSL=false&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=utf-8" \
	--fields-terminated-by "\t" \
	--username $user \
    --password $passwd \
	--delete-target-dir \
	--null-string '\\N' \
	--null-non-string '\\N' \
	--target-dir /test_zfq_decent_cloud/$1/$do_date \
	--delete-target-dir \
	--num-mappers 1 \
	--fields-terminated-by "\t" \
	--query "$2"' and  $CONDITIONS;'
}
import_t_daily_interrest_err_log(){
import_data t_daily_interrest_err_log " select date_format(run_time,'%Y-%m-%d %H:%i:%s') run_time,
pro_name,
err_msg from $database.t_daily_interrest_err_log where 1=1"
}
import_t_daily_interrest_log(){
import_data t_daily_interrest_log " select date_format(run_time,'%Y-%m-%d %H:%i:%s') run_time,
pro_name,
log_info from $database.t_daily_interrest_log where 1=1"
}
import_t_estimate_update_log(){
import_data t_estimate_update_log " select id,
user_id,
package_code,
date_format(estimate_time,'%Y-%m-%d %H:%i:%s') estimate_time,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
reason_for_application from $database.t_estimate_update_log where 1=1"
}
import_t_history_data_move_log(){
import_data t_history_data_move_log " select date_format(run_time,'%Y-%m-%d %H:%i:%s') run_time,
msg_info from $database.t_history_data_move_log where 1=1"
}
import_t_late_transfer_log(){
import_data t_late_transfer_log " select id,
customer_code,
customer_identity,
replace(replace(replace(customer_name,'\n',''),'\t',''),'\r','') customer_name,
replace(replace(replace(package_all,'\n',''),'\t',''),'\r','') package_all,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
recept_by from $database.t_late_transfer_log where 1=1"
}
import_t_login_log(){
import_data t_login_log " select id,
buyer_id,
buyer_identity,
customer_id,
customer_identity,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
showroom_identity from $database.t_login_log where 1=1"
}
import_t_cpbszb_log(){
import_data t_cpbszb_log " select id,
DjBth,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
status,
DjLsh,
package_i_identity,
package_i_code,
fast_package_identity,
xh from $database.t_cpbszb_log where 1=1"
}
import_t_cpbszh_log(){
import_data t_cpbszh_log " select id,
DjLsh,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
fast_package_identity,
order_identity,
package_code,
status,
sales_order,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
sales_type,
salesman_identity,
kdsj from $database.t_cpbszh_log where 1=1"
}
import_t_cover_customer_log(){
import_data t_cover_customer_log " select id,
operate_id,
operate_name,
operate_time,
operate_msg from $database.t_cover_customer_log where 1=1"
}
import_t_wechat_message_log(){
import_data t_wechat_message_log " select id,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
type,
replace(replace(replace(content,'\n',''),'\t',''),'\r','') content,
success,
error_message from $database.t_wechat_message_log where 1=1"
}
import_t_stored_procedure_log(){
import_data t_stored_procedure_log " select id,
execute_id,
stored_procedure_name,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user,
log from $database.t_stored_procedure_log where 1=1"
}
import_t_splszh_log(){
import_data t_splszh_log " select id,
splszh_djLsh,
djLsh,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
fast_package_identity,
order_identity,
package_code,
status from $database.t_splszh_log where 1=1"
}
import_t_salesman_choose_log(){
import_data t_salesman_choose_log " select id,
customer_identity,
salesman_identity,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_salesman_choose_log where 1=1"
}
import_t_download(){
import_data t_download " select id,
down_identity,
file_name,
file_path,
message,
handle_status,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
end_time,
create_user from $database.t_download where 1=1"
}
import_t_insert_log_fail(){
import_data t_insert_log_fail " select param,
date_format(insert_time,'%Y-%m-%d %H:%i:%s') insert_time from $database.t_insert_log_fail where 1=1"
}
import_t_b_menu(){
import_data t_b_menu " select id,
name,
path,
type,
is_default,
sort,
is_show from $database.t_b_menu where 1=1"
}
import_t_approve_record(){
import_data t_approve_record " select id,
approve_type,
data_id,
from_name,
table_name,
create_user,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_approve_record where 1=1"
}
import_rp_szztxsrb(){
import_data rp_szztxsrb " select date_format(record_date,'%Y-%m-%d %H:%i:%s') record_date,
xh,
plm,
jjjz,
jjje,
dljz,
dlje,
fcpzl,
hlzl,
hlgf,
rljz,
qxwx,
rlgf,
qxGF,
xqjs,
xqgf,
qtje,
hjzl,
hjje,
zqszl,
zqgf,
fjgf from $database.rp_szztxsrb where 1=1"
}
import_t_basic_purity(){
import_data t_basic_purity " select id,
basic_purity_identity,
basic_purity_name from $database.t_basic_purity where 1=1"
}
import_t_bf_account_type_category(){
import_data t_bf_account_type_category " select id,
account_type_category_code,
account_type_category_identity,
account_type_category_name,
work_fee,
effective_date,
status,
type,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_account_type_category where 1=1"
}
import_t_bf_allocate_transfer(){
import_data t_bf_allocate_transfer " select id,
allocate_transfer_identity,
allocate_transfer_code,
showroom_name,
purity_identity,
purity_name,
category_help_code,
category_name,
basic_work_fee,
average_cost,
rule,
allocate_transfer_price,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_allocate_transfer where 1=1"
}
import_t_bf_allocation_fee(){
import_data t_bf_allocation_fee " select id,
allocation_fee_identity,
allocation_fee_code,
showroom_name,
apply_scene,
swlx,
purity_identity,
purity_name,
genus_range,
allocate_transfer_code,
work_fee_basic,
worl_fee_style,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
cost,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_allocation_fee where 1=1"
}
import_t_bf_allocation_fee_add_price(){
import_data t_bf_allocation_fee_add_price " select id,
allocation_fee_identity,
start_price,
end_price,
price,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_allocation_fee_add_price where 1=1"
}
import_t_bf_ancient_law_cus_discount(){
import_data t_bf_ancient_law_cus_discount " select id,
cus_discount_identity,
cus_discount_code,
showroom_identity,
counter_identity,
purity_identity,
customer_identity,
customer_code,
parent_customer_identity,
parent_customer_code,
customer_discount,
unit_other_work_fee,
child_customer_seq,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
unit_batch_price,
transfer_owed_diff_price,
create_by,
create_by_name,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
update_by_name,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_ancient_law_cus_discount where 1=1"
}
import_t_bf_ancient_law_cus_discount_detail(){
import_data t_bf_ancient_law_cus_discount_detail " select id,
cus_discount_identity,
cus_discount_detail_identity,
first_genus_identity,
first_genus_name,
second_genus_identity,
second_genus_name,
base_work_fee,
other_work_fee,
batch_price,
status from $database.t_bf_ancient_law_cus_discount_detail where 1=1"
}
import_t_bf_buy_cus_material_detail(){
import_data t_bf_buy_cus_material_detail " select id,
buy_cus_detail_identity,
buy_cus_identity,
purity_identity,
gold_weight,
price,
unit_price from $database.t_bf_buy_cus_material_detail where 1=1"
}
import_t_bf_change_purity(){
import_data t_bf_change_purity " select id,
change_purity_code,
change_purity_identity,
showroom_name,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
weight,
price,
number_of_units,
counter_identity,
counter_name,
out_purity_identity,
out_purity_name,
in_purity_identity,
in_purity_name,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_change_purity where 1=1"
}
import_t_bf_collect_money_account(){
import_data t_bf_collect_money_account " select id,
showroom_name,
bank_name,
bank_code,
bank_card,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
is_delete,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
bank_belonging,
zhmc,
zhzh,
zhlx from $database.t_bf_collect_money_account where 1=1"
}
import_t_bf_collect_money_style(){
import_data t_bf_collect_money_style " select id,
collect_money_style,
collect_money_code,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_collect_money_style where 1=1"
}
import_t_bf_current_wholesale_gold_price(){
import_data t_bf_current_wholesale_gold_price " select id,
current_wholesale_identity,
current_wholesale_history_detail_identity,
showroom_identity,
purity_identity,
purity_name,
gold_price,
small_unit_price,
large_unit_price,
base_work_fee,
small_base_work_fee,
large_base_work_fee,
purification_fee,
small_purification_fee,
large_purification_fee,
small_attach_work_fee,
large_attach_work_fee,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_current_wholesale_gold_price where 1=1"
}
import_t_bf_current_wholesale_gold_price_history(){
import_data t_bf_current_wholesale_gold_price_history " select id,
current_wholesale_history_identity,
showroom_identity,
create_by,
create_by_name,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
approve_by_name,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_current_wholesale_gold_price_history where 1=1"
}
import_t_bf_current_wholesale_gold_price_history_detail(){
import_data t_bf_current_wholesale_gold_price_history_detail " select id,
current_wholesale_history_identity,
current_wholesale_history_detail_identity,
purity_identity,
purity_name,
gold_price,
small_unit_price,
large_unit_price,
base_work_fee,
small_base_work_fee,
large_base_work_fee,
purification_fee,
small_purification_fee,
large_purification_fee,
small_attach_work_fee,
large_attach_work_fee,
status from $database.t_bf_current_wholesale_gold_price_history_detail where 1=1"
}
import_t_bf_cus_credit_receipt_detail(){
import_data t_bf_cus_credit_receipt_detail " select id,
cus_credit_receipt_detail_identity,
cus_credit_receipt_identity,
collect_money_style,
bank,
price,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark from $database.t_bf_cus_credit_receipt_detail where 1=1"
}
import_t_bf_cus_debit_receipt_detail(){
import_data t_bf_cus_debit_receipt_detail " select id,
cus_debit_identity,
cus_debit_detail_identity,
price_identity,
bank_name,
bank_identity,
account,
detail_price,
detail_today_price,
detail_history_price,
detail_service_charge,
detail_remark,
check_finance,
money_order_code,
money_order_people,
money_order_account,
money_order_card from $database.t_bf_cus_debit_receipt_detail where 1=1"
}
import_t_bf_cus_debit_receipt_record(){
import_data t_bf_cus_debit_receipt_record " select id,
recoed_sale_identity,
other_identity,
sale_code,
sale_name,
sale_time,
sale_type,
customer_identity,
parent_customer_identity,
sale_price,
this_price,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
csmc,
ysjzf,
bchxje,
syysje,
yslsh,
ysbth,
khzjm,
wfje from $database.t_bf_cus_debit_receipt_record where 1=1"
}
import_t_bf_deliver_goods_from(){
import_data t_bf_deliver_goods_from " select id,
deliver_goods_code,
deliver_goods_identity,
area,
date_format(refer_to_start_date,'%Y-%m-%d %H:%i:%s') refer_to_start_date,
date_format(refer_to_end_date,'%Y-%m-%d %H:%i:%s') refer_to_end_date,
if_no_mine_company,
if_franchisee,
purity_identity,
showroom_identity,
customer_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
total_number,
total_gold_weight,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
collection_company,
gross_weight,
package_number,
delivery_by_first,
delivery_by_second,
sign_for,
sign_status,
date_format(date_this,'%Y-%m-%d %H:%i:%s') date_this,
print_by,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count from $database.t_bf_deliver_goods_from where 1=1"
}
import_t_bf_deliver_goods_from_detail(){
import_data t_bf_deliver_goods_from_detail " select id,
deliver_goods_identity,
deliver_goods_detail_identity,
sale_identity,
sale_code,
sale_date,
parent_customer_identity,
product_style,
purity_identity,
gold_weight,
sale_number,
customer_identity,
customer_code,
child_customer_code,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
status from $database.t_bf_deliver_goods_from_detail where 1=1"
}
import_t_bf_dzddydy(){
import_data t_bf_dzddydy " select id,
dzddydy_identity,
wdmc,
customer_identity,
khbm,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
replace(replace(replace(ZKH,'\n',''),'\t',''),'\r','') ZKH,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
qzqkje,
qzqlzl,
sjqkje,
sjqlzl,
wjqkje,
wjqlzl,
wyid from $database.t_bf_dzddydy where 1=1"
}
import_t_bf_financial_block_list(){
import_data t_bf_financial_block_list " select id,
financial_block_list_code,
financial_block_list_identity,
showroom_name,
customer_type,
customer_identity,
parent_customer_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_financial_block_list where 1=1"
}
import_t_bf_five_g_cus_discount(){
import_data t_bf_five_g_cus_discount " select id,
five_g_cus_discount_identity,
five_g_cus_discount_code,
showroom_identity,
customer_identity,
customer_code,
parent_customer_identity,
parent_customer_code,
child_customer_seq,
customer_discount,
other_price,
transfer_owed_diff_price,
create_by,
create_by_name,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
update_by_name,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_five_g_cus_discount where 1=1"
}
import_t_bf_gold_inlay_transfer_in(){
import_data t_bf_gold_inlay_transfer_in " select id,
inlay_transfer_in_identity,
inlay_transfer_in_code,
inlay_transfer_out_code,
transfer_out_showroom,
transfer_out_counter_name,
transfer_out_counter_identity,
transfer_in_showroom,
transfer_in_counter_name,
transfer_in_counter_identity,
total_number,
total_weight,
rkdh,
drdh,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
total_work_fee,
total_stone_weight,
wxqx,
purity_name,
ztdbjsj,
jxydblx,
yyyxh,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
settlement_approve,
status,
eos_head_key,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
date_format(out_time,'%Y-%m-%d %H:%i:%s') out_time,
receive_id from $database.t_bf_gold_inlay_transfer_in where 1=1"
}
import_t_bf_gold_inlay_transfer_in_detail(){
import_data t_bf_gold_inlay_transfer_in_detail " select id,
inlay_transfer_in_identity,
inlay_transfer_in_detail_identity,
product_code,
product_name,
metalwork_name,
category_name,
factory_code,
company_code,
purity_name,
main_stone_name,
main_stone_weight,
main_stone_specs,
gold_weight,
label_price,
number,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
transfer_type,
type_code,
series_name,
outside,
goods_weight,
processing_charges,
jp,
ztdbjsjb,
eos_body_key,
receive_id,
receive_detail_id from $database.t_bf_gold_inlay_transfer_in_detail where 1=1"
}
import_t_bf_gold_inlay_transfer_out(){
import_data t_bf_gold_inlay_transfer_out " select id,
inlay_transfer_out_identity,
inlay_transfer_out_code,
transfer_out_showroom,
transfer_out_counter_name,
transfer_out_counter_identity,
transfer_in_showroom,
transfer_in_counter_name,
transfer_in_counter_identity,
total_number,
total_weight,
rkdh,
drdh,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
total_work_fee,
total_stone_weight,
wxqx,
purity_name,
ztdbjsj,
jxydblx,
yyyxh,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
date_format(out_time,'%Y-%m-%d %H:%i:%s') out_time,
receive_id,
transfer_type from $database.t_bf_gold_inlay_transfer_out where 1=1"
}
import_t_bf_gold_inlay_transfer_out_detail(){
import_data t_bf_gold_inlay_transfer_out_detail " select id,
inlay_transfer_out_identity,
inlay_transfer_out_detail_identity,
product_code,
product_name,
metalwork_name,
category_name,
factory_code,
company_code,
purity_name,
main_stone_name,
main_stone_weight,
main_stone_specs,
gold_weight,
label_price,
number,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
transfer_type,
type_code,
series_name,
outside,
goods_weight,
processing_charges,
jp,
ztdbjsjb,
receive_id,
receive_detail_id from $database.t_bf_gold_inlay_transfer_out_detail where 1=1"
}
import_t_bf_gold_transfer_change(){
import_data t_bf_gold_transfer_change " select id,
inlay_change_identity,
inlay_change_code,
transfer_out_showroom,
transfer_out_counter_name,
transfer_out_counter_identity,
transfer_in_showroom,
transfer_in_counter_name,
transfer_in_counter_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
total_number,
total_weight,
total_label_price,
purity_name,
dydf,
date_format(out_time,'%Y-%m-%d %H:%i:%s') out_time,
transfer_in_code,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_gold_transfer_change where 1=1"
}
import_t_bf_gold_transfer_change_detail(){
import_data t_bf_gold_transfer_change_detail " select id,
inlay_change_identity,
inlay_change_detail_identity,
inlay_transfer_in_code,
purity_name,
genus_name,
number,
gold_weight,
label_price,
swlx,
inlay_transfer_out_code,
date_format(out_time,'%Y-%m-%d %H:%i:%s') out_time from $database.t_bf_gold_transfer_change_detail where 1=1"
}
import_t_bf_gold_transfer_in_detail(){
import_data t_bf_gold_transfer_in_detail " select id,
transfer_in_identity,
transfer_out_detail_identity,
transfer_in_detail_identity,
product_code,
first_category_name,
second_category_name,
number,
in_weight,
basic_price,
additional_labour_price,
price,
label_price,
out_weight,
transfer_type,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
unit_price,
eos_body_key,
discount_work_fee,
receive_id,
receive_detail_id from $database.t_bf_gold_transfer_in_detail where 1=1"
}
import_t_bf_hard_gold_work_fee(){
import_data t_bf_hard_gold_work_fee " select id,
hard_gold_work_fee_identity,
showroom_identity,
customer_identity,
replace(replace(replace(customer_code,'\n',''),'\t',''),'\r','') customer_code,
child_customer_seq,
replace(replace(replace(help_code,'\n',''),'\t',''),'\r','') help_code,
if_child,
parent_customer_identity,
replace(replace(replace(parent_customer_code,'\n',''),'\t',''),'\r','') parent_customer_code,
create_by,
create_by_name,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
update_by_name,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
default_work_fee,
transfer_owed_diff_price,
if_used,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_hard_gold_work_fee where 1=1"
}
import_t_bf_initial_inventory_bill(){
import_data t_bf_initial_inventory_bill " select id,
initial_inventory_identity,
initial_inventory_code,
showroom_name,
inventory_date,
year,
month,
day,
storage_name,
fineness_name,
category_name,
initial_packages,
initial_amount,
initial_gold_weight,
balance_packages,
balance_amount,
balance_gold_weight,
profit_loss_packages,
profit_loss_amount,
profit_loss_gold_weight,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
status from $database.t_bf_initial_inventory_bill where 1=1"
}
import_t_bf_inlaid_metal_average_daily(){
import_data t_bf_inlaid_metal_average_daily " select id,
average_daily_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
inlaid_metal_code,
average_daily,
date,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_inlaid_metal_average_daily where 1=1"
}
import_t_bf_interest_st_adj_item(){
import_data t_bf_interest_st_adj_item " select id,
adjust_item_identity,
showroom_name,
day_rate,
interest_free_days,
contract_date,
storage_fee,
month_extension_time,
rated_sales,
interest_free_gold_weight,
storage_fee_term,
effective_date,
customer_identity,
parent_customer_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
category_info_code,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
customer_type,
customer_type_code,
tech_purity_name,
tech_purity_code,
payment_days,
overday_rate from $database.t_bf_interest_st_adj_item where 1=1"
}
import_t_bf_khlsedb(){
import_data t_bf_khlsedb " select id,
khlsedb_identity,
djh,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
wdbm,
wdmch,
customer_identity,
PARENT_customer_identity,
lsed,
replace(replace(replace(ZKH,'\n',''),'\t',''),'\r','') ZKH,
zdrid,
zdr,
date_format(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
shrid,
shr,
date_format(shsj,'%Y-%m-%d %H:%i:%s') shsj,
lsjz,
jjj,
spdh,
approve_status,
status from $database.t_bf_khlsedb where 1=1"
}
import_t_bf_material_explain(){
import_data t_bf_material_explain " select id,
material_explain_identity,
material_explain_code,
material_explain_name,
type_code,
type_name,
status,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
if_convert from $database.t_bf_material_explain where 1=1"
}
import_t_bf_other_showroom_customer_block_list(){
import_data t_bf_other_showroom_customer_block_list " select id,
other_showroom_customer_block_code,
other_showroom_customer_block_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_other_showroom_customer_block_list where 1=1"
}
import_t_bf_pay_outsource_detail(){
import_data t_bf_pay_outsource_detail " select id,
pay_outsource_detail_identity,
pay_outsource_identity,
pay_purity_name,
pay_gold_weight,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark from $database.t_bf_pay_outsource_detail where 1=1"
}
import_t_bf_payment_order_detail(){
import_data t_bf_payment_order_detail " select id,
payment_order_identity,
payment_order_detail_identity,
payment_name,
payment_identity,
bank_name,
bank_identity,
price,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark from $database.t_bf_payment_order_detail where 1=1"
}
import_t_bf_purify_detail(){
import_data t_bf_purify_detail " select id,
purify_detail_identity,
purify_identity,
purity_name,
material_explain,
percent_start,
percent_end,
purity_price,
if_convert from $database.t_bf_purify_detail where 1=1"
}
import_t_bf_ready_money(){
import_data t_bf_ready_money " select id,
purity_name,
purity_identity,
work_fee_type,
work_fee,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_ready_money where 1=1"
}
import_t_bf_remark(){
import_data t_bf_remark " select id,
remark_identity,
remark_code,
remark_name,
remark_help_code,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_remark where 1=1"
}
import_t_bf_sales_ticket_print_zds(){
import_data t_bf_sales_ticket_print_zds " select id,
print_zds_identity,
jsjzhj,
khllysje,
khtsyfje,
sales_ticket_print_zds_code,
replace(replace(replace(bzh,'\n',''),'\t',''),'\r','') bzh,
csmch,
plmch,
qtfy,
fysm,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
wdmc,
wdlx,
lljzhj,
jehj,
xjsq,
zdhs,
tsjzhj,
tzgf,
tzgfh,
bqjehj,
fjgfzkh,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
customer_identity,
parent_customer_identity,
status,
print_count,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_sales_ticket_print_zds where 1=1"
}
import_t_bf_sales_ticket_print_zds_detail(){
import_data t_bf_sales_ticket_print_zds_detail " select id,
print_zds_detail_identity,
print_zds_identity,
xh,
ckmc,
plmc,
jsb,
jz,
fjgf,
tzfjgf,
fjgfje,
fs,
csmcf,
plmcf,
jzf,
dj,
gf,
gfje,
bzf,
bzb,
yjpl from $database.t_bf_sales_ticket_print_zds_detail where 1=1"
}
import_t_bf_stock_transfer_bill_detail(){
import_data t_bf_stock_transfer_bill_detail " select id,
stock_transfer_detail_identity,
stock_transfer_identity,
sequence,
bar_code,
number_of_packages,
gold_weight,
content,
tag_price,
stock_gold_weight,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
transfer_type,
coding,
out_expenses,
in_expenses,
category_code,
category_name,
purity_code,
purity_name from $database.t_bf_stock_transfer_bill_detail where 1=1"
}
import_t_bf_temporary_money_form(){
import_data t_bf_temporary_money_form " select id,
temporary_money_code,
temporary_money_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
print_time_code,
credit_gold_weight,
credit_total_price,
contract_time,
credit_gold_price,
debt_material_desc,
debt_price_desc,
today_material_shipment,
today_price_shipment,
penal_sum,
exceed_price,
exceed_total_price,
temporary_ratify_price,
thousand_wage,
myriad_wage,
five_nine_wage,
plan_repayment_date_one,
plan_repayment_date_two,
plan_repayment_date_three,
plan_material_one,
plan_material_two,
plan_material_three,
plan_repayment_one,
plan_repayment_two,
plan_repayment_three,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
salesman,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
bdze,
zcqkts,
dzhyhf from $database.t_bf_temporary_money_form where 1=1"
}
import_t_bf_transfer_owed_work_fee_from(){
import_data t_bf_transfer_owed_work_fee_from " select id,
transfer_owed_code,
transfer_owed_help_code,
transfer_owed_identity,
work_fee_type,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
purity_identity,
purity_name,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
purity_code from $database.t_bf_transfer_owed_work_fee_from where 1=1"
}
import_t_bf_transfer_owed_work_fee_input(){
import_data t_bf_transfer_owed_work_fee_input " select id,
work_fee_input_code,
work_fee_input_identity,
showroom_identity,
customer_code,
customer_identity,
parent_customer_code,
parent_customer_identity,
child_customer_seq,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_transfer_owed_work_fee_input where 1=1"
}
import_t_bf_transfer_owed_work_fee_input_detail(){
import_data t_bf_transfer_owed_work_fee_input_detail " select id,
work_fee_input_identity,
work_fee_input_detail_identity,
purity_identity,
purity_name,
transfer_owed_identity,
work_fee_type,
work_fee,
status from $database.t_bf_transfer_owed_work_fee_input_detail where 1=1"
}
import_t_bf_transfer_type(){
import_data t_bf_transfer_type " select id,
code,
name,
status from $database.t_bf_transfer_type where 1=1"
}
import_t_bf_warehouse_type(){
import_data t_bf_warehouse_type " select id,
warehouse_type_identity,
warehouse_type_code,
warehouse_type_name,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
status from $database.t_bf_warehouse_type where 1=1"
}
import_t_bf_weighing_form(){
import_data t_bf_weighing_form " select id,
weighing_identity,
weighing_code,
weighing_date,
showroom_name,
showroom_code,
counter_identity,
counter_name,
type_name,
purity_name,
purity_identity,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
type_warehouse,
number,
total_label,
total_gold_weight,
total,
electron_number,
customer_inventory,
status,
tray_difference,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_weighing_form where 1=1"
}
import_t_bf_with_sign(){
import_data t_bf_with_sign " select id,
with_sign_code,
with_sign_name,
with_sign_identity,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_with_sign where 1=1"
}
import_t_bf_xq_single_return(){
import_data t_bf_xq_single_return " select id,
xq_single_return_identity,
xq_single_return_code,
date_format(open_date,'%Y-%m-%d %H:%i:%s') open_date,
date_format(date_this,'%Y-%m-%d %H:%i:%s') date_this,
if_print_remark,
showroom_identity,
showroom_name,
purity_identity,
purity_name,
purity_percent,
customer_code,
customer_identity,
customer_name,
parent_customer_code,
parent_customer_identity,
parent_customer_name,
out_of_stock_code,
total_number,
label_price_total,
total_amount,
total_weight,
replace(replace(replace(detail_address,'\n',''),'\t',''),'\r','') detail_address,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
counter_identity,
counter_name,
package_i_small_code,
create_by,
create_by_name,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
approve_by_name,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
total_return_work_fee from $database.t_bf_xq_single_return where 1=1"
}
import_t_bf_xq_single_return_detail(){
import_data t_bf_xq_single_return_detail " select id,
xq_single_return_identity,
xq_single_return_detail_identity,
xh,
package_i_small_code,
product_bar_code,
if_record_count,
additional_work_fee,
weight,
counter_identity,
counter_name,
product_style,
purity_identity,
purity_name,
first_genus_name,
second_genus_name,
factory_code,
label_price,
amount,
master_stone_name,
master_stone_number,
master_stone_weight,
gold_stone_name,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
gold_stone_code,
number,
product_name,
qr_code,
search_code,
discount_rate,
discount_unit_price,
package_code,
big_category,
sale_work_fee,
receive_date,
receive_code,
receive_name,
date_format(account_date,'%Y-%m-%d %H:%i:%s') account_date,
account_code,
customer_identity,
customer_code,
customer_name,
parent_customer_identity,
parent_customer_name,
base_work_fee,
base_work_fee_amount,
additional_work_fee_amount,
refer_to_amount,
status from $database.t_bf_xq_single_return_detail where 1=1"
}
import_t_buyer(){
import_data t_buyer " select id,
buyer_identity,
wechat_desc,
buyer_name,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
openid,
phone from $database.t_buyer where 1=1"
}
import_t_category(){
import_data t_category " select id,
category_identity,
category_code,
category_name,
category_help_code,
parent_id,
parent_identity,
deep_level,
path_str,
create_user_id,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
date_format(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
pic_url,
code_seq from $database.t_category where 1=1"
}
import_t_category_counter_info(){
import_data t_category_counter_info " select id,
showroom_name,
counter_identity,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
category_info_code from $database.t_category_counter_info where 1=1"
}
import_t_category_labour(){
import_data t_category_labour " select id,
category_labour_code,
showroom_counter_id,
showroom_counter_identity,
category_id,
category_identity,
purity_id,
purity_identity,
genus_id,
genus_identity,
item_id,
item_identity,
additional_labour,
standard_labour,
is_deleted,
second_category_identity,
category_name,
first_category_name,
second_category_name,
help_code from $database.t_category_labour where 1=1"
}
import_t_check_account(){
import_data t_check_account " select id,
counter_name,
counter_identity,
weight,
number,
price,
eos_weight,
eos_number,
eos_price,
date_format(check_date,'%Y-%m-%d %H:%i:%s') check_date,
create_user,
check_diff_user from $database.t_check_account where 1=1"
}
import_t_check_account_detail(){
import_data t_check_account_detail " select id,
counter_name,
counter_identity,
weight,
number,
price,
date_format(check_date,'%Y-%m-%d %H:%i:%s') check_date,
create_user from $database.t_check_account_detail where 1=1"
}
import_t_check_counter(){
import_data t_check_counter " select id,
counter_name,
counter_identity,
xh,
type,
purity_identity from $database.t_check_counter where 1=1"
}
import_t_check_quality_detial(){
import_data t_check_quality_detial " select id,
receive_identity,
receive_code,
order_identity,
order_code,
product_code,
product_name,
product_style,
company_code,
factory_code,
outsource_code,
piece_weight,
zj_weight,
zj_number,
zj_end,
zj_remark,
zj_weight_receive,
zj_number_receive,
zj_weight_back,
zj_number_back,
zj_weight_back_receive,
zj_number_back_receive,
zj_status_before,
zj_status,
status,
zj_code,
receive_detial_id,
icp_jcz,
hsj_jcz,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_check_quality_detial where 1=1"
}
import_t_check_quality_status(){
import_data t_check_quality_status " select id,
number,
check_style,
status from $database.t_check_quality_status where 1=1"
}
import_t_child_customer_id_djbth(){
import_data t_child_customer_id_djbth " select id,
djbth from $database.t_child_customer_id_djbth where 1=1"
}
import_t_client_discount(){
import_data t_client_discount " select id,
client_discount_identity,
showroom_identity,
showroom_name,
customer_identity,
customer_code,
discount_class,
settle_discount,
mosaic_discount,
general_discount,
hight_quality_discount,
special_discount,
metal_work_stone_discount,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
is_enable,
eos_head_key,
eos_body_key from $database.t_client_discount where 1=1"
}
import_t_counter_account(){
import_data t_counter_account " select id,
counter_identity,
counter_name,
day_begin_weight,
day_end_weight,
current_weight,
transfer_out_weigth,
stock_transfer_out_weight,
stock_transfer_in_weight,
sale_from_weight,
move_counter_weight,
replace(replace(replace(data_id,'\n',''),'\t',''),'\r','') data_id,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
replace(replace(replace(content,'\n',''),'\t',''),'\r','') content,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark from $database.t_counter_account where 1=1"
}
import_t_counter_account_5ga(){
import_data t_counter_account_5ga " select id,
counter_identity,
counter_name,
day_begin_weight,
day_end_weight,
current_weight,
transfer_out_weigth,
stock_transfer_out_weight,
stock_transfer_in_weight,
sale_from_weight,
move_counter_weight,
replace(replace(replace(data_id,'\n',''),'\t',''),'\r','') data_id,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
replace(replace(replace(content,'\n',''),'\t',''),'\r','') content,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark from $database.t_counter_account_5ga where 1=1"
}
import_t_counter_like(){
import_data t_counter_like " select id,
fast_package_id,
fast_package_identity,
customer_id,
custoer_identity,
showroom_counter_id,
showroom_counter_identity,
counter_user_id,
counter_user_identity,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
date_format(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
like_values,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark from $database.t_counter_like where 1=1"
}
import_t_counter_message(){
import_data t_counter_message " select id,
message_identity,
code,
salesman_identity,
counter_identity,
customer_identity,
message_content,
message_type,
net_weight,
gross_weight,
leave_counter_weight,
is_read,
is_reject,
is_delete,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
product_code,
is_scand,
delpackage_detail from $database.t_counter_message where 1=1"
}
import_t_cpbszb(){
import_data t_cpbszb " select DjLsh,
DjBth,
DjState,
xh,
JJB,
CKMC,
CKBM,
fjgf,
zhl,
plmc,
YJPLBM,
YJPL,
EJPLBM,
EJPL,
SPTM,
GCKH,
BZGF,
fjje,
plbm,
ZSMC,
ZSSL,
ZSZL,
JSMC,
bzsm,
JSBM,
JS,
SPMC,
EWM,
CXM,
SFXG,
ZLB,
ZKJEB,
YFJGF,
GFZK,
SFDZ,
YJJCGF,
JPGF,
JGF,
TSGF,
LJJJE,
date_format(etl_dt,'%Y-%m-%d %H:%i:%s') etl_dt from $database.t_cpbszb where 1=1"
}
import_t_cpbszh(){
import_data t_cpbszh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
XSZKH,
wdmc,
djh,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
wdbm,
khbm,
csmc,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
ZKHBM,
ZKHBH,
replace(replace(replace(ZKH,'\n',''),'\t',''),'\r','') ZKH,
YWY,
lxr,
KHZJM,
zjz,
dz,
replace(replace(replace(bz,'\n',''),'\t',''),'\r','') bz,
zdrid,
zdr,
date_format(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
shr,
date_format(shsj,'%Y-%m-%d %H:%i:%s') shsj,
CSBM,
CS,
ckdh,
hjje,
HJJS,
lxdh,
JSMCB,
PLMCB,
ZL,
JJ,
ZDBC,
TMXY,
DJZT,
ZFRQ,
QSH,
JSH,
FZGF,
ssckbm,
BQJGHJ,
DBTBZ,
ZKJEH,
CKMCH,
DZCQS,
YJLBH,
YJPLBMH,
date_format(KDRQ,'%Y-%m-%d %H:%i:%s') KDRQ,
GZBZ,
THDH,
THDJM,
ZCJZ,
GZRQ,
CPBBS,
WC,
QY,
DST,
SHMC,
SHBM,
QHXH,
DB,
BDB,
BTCKMC,
BTCKBM,
B2BXS,
FCDH,
WDXAJBQ,
LM,
fast_package_identity,
date_format(etl_dt,'%Y-%m-%d %H:%i:%s') etl_dt,
order_identity,
package_code from $database.t_cpbszh where 1=1"
}
import_t_custom_column(){
import_data t_custom_column " select id,
column_id,
project_type,
subject_type,
subject_name,
col,
column_name,
column_width,
order_no,
login_user,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_by,
iz_selected,
iz_disable,
del_flag from $database.t_custom_column where 1=1"
}
import_t_customer_account_debt_trans_detail(){
import_data t_customer_account_debt_trans_detail " select id,
showroom_name,
customer_identity,
account_purity_name,
trans_date,
actual_date,
trans_name,
trans_code,
trans_amount,
trans_fee,
trans_weight,
type,
free_interest_days,
over_due_days,
month_settle_days,
free_storage_days,
interest_date,
due_date,
overdue_date,
storage_date,
gold_price_today,
total_money,
deduction_money,
remain_money,
is_settle,
last_deduction_date from $database.t_customer_account_debt_trans_detail where 1=1"
}
import_t_customer_account_repay_trans_detail(){
import_data t_customer_account_repay_trans_detail " select id,
showroom_name,
customer_identity,
account_purity_name,
trans_date,
actual_date,
trans_name,
trans_code,
trans_amount,
trans_fee,
trans_weight,
type,
free_interest_days,
over_due_days,
month_settle_days,
free_storage_days,
interest_date,
due_date,
overdue_date,
storage_date,
gold_price_today,
total_money,
deduction_money,
remain_money,
is_settle,
last_deduction_date from $database.t_customer_account_repay_trans_detail where 1=1"
}
import_t_customer_account_save_owe_info(){
import_data t_customer_account_save_owe_info " select id,
info_identity,
showroom_name,
customer_identity,
customer_code,
parent_customer_name,
child_customer_name,
account_purity_name,
undue_amount,
undue_weight,
due_amount,
due_weight,
overdue_amount,
overdue_weight,
free_storage_weight,
storage_weight,
last_month_fee,
this_month_fee,
interest_weight,
interest_amount,
due_interest_weight,
due_interest_amount,
overdue_interest_weight,
overdue_interest_amount,
interest_total,
due_interest_today,
overdue_interest_today,
storage_fee_today,
fee_interest_today,
adjust_interest_today,
free_interest_days,
over_due_days,
interest_rate_1,
interest_rate_2,
storage_price,
free_storage_days,
month_settle_days,
customer_type,
customer_type_code from $database.t_customer_account_save_owe_info where 1=1"
}
import_t_customer_account_save_owe_info_history(){
import_data t_customer_account_save_owe_info_history " select date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
id,
info_identity,
showroom_name,
customer_identity,
customer_code,
parent_customer_name,
child_customer_name,
account_purity_name,
undue_amount,
undue_weight,
due_amount,
due_weight,
overdue_amount,
overdue_weight,
free_storage_weight,
storage_weight,
last_month_fee,
this_month_fee,
interest_weight,
interest_amount,
due_interest_weight,
due_interest_amount,
overdue_interest_weight,
overdue_interest_amount,
interest_total,
due_interest_today,
overdue_interest_today,
storage_fee_today,
fee_interest_today,
adjust_interest_today,
free_interest_days,
over_due_days,
interest_rate_1,
interest_rate_2,
storage_price,
free_storage_days,
month_settle_days,
customer_type,
customer_type_code from $database.t_customer_account_save_owe_info_history where 1=1"
}
import_t_customer_buyer(){
import_data t_customer_buyer " select id,
customer_id,
customer_identity,
buyer_id,
buyer_identity,
is_defualt from $database.t_customer_buyer where 1=1"
}
import_t_customer_counter_fastout(){
import_data t_customer_counter_fastout " select id,
identity,
customer_identity,
counter_identity,
is_default from $database.t_customer_counter_fastout where 1=1"
}
import_t_customer_discount(){
import_data t_customer_discount " select id,
customer_identity,
purity_identity,
purity_name,
counter_identity,
counter_name,
replace(replace(replace(discount_remark,'\n',''),'\t',''),'\r','') discount_remark,
is_discount,
djlsh from $database.t_customer_discount where 1=1"
}
import_t_customer_discount_detail(){
import_data t_customer_discount_detail " select id,
discount_id,
additional_labour,
discount_number from $database.t_customer_discount_detail where 1=1"
}
import_t_customer_discount_detail_hs(){
import_data t_customer_discount_detail_hs " select id,
discount_hs_id,
additional_labour,
discount_number,
additional_money,
status,
sequence from $database.t_customer_discount_detail_hs where 1=1"
}
import_t_customer_discount_hjxq_temp(){
import_data t_customer_discount_hjxq_temp " select customer_code,
mosaic_discount,
general_discount,
hight_quality_discount,
special_discount from $database.t_customer_discount_hjxq_temp where 1=1"
}
import_t_customer_discount_hs(){
import_data t_customer_discount_hs " select id,
customer_identity,
customer_code,
customer_name,
purity_identity,
purity_name,
is_discount,
discount_remark,
voucher_id,
voucher_time,
voucher_name,
inter,
update_id,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status from $database.t_customer_discount_hs where 1=1"
}
import_t_customer_discount_kjxq_temp(){
import_data t_customer_discount_kjxq_temp " select customer_code,
metal_work_stone_discount,
general_discount,
hight_quality_discount,
special_discount from $database.t_customer_discount_kjxq_temp where 1=1"
}
import_t_customer_discount_sync(){
import_data t_customer_discount_sync " select customer_code,
showroom_code,
seq,
is_discount,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date from $database.t_customer_discount_sync where 1=1"
}
import_t_customer_engrave(){
import_data t_customer_engrave " select id,
engrave_identity,
counter_identity,
customer_identity,
replace(replace(replace(engrave_content,'\n',''),'\t',''),'\r','') engrave_content,
is_default,
is_deleted,
date_format(expired_date,'%Y-%m-%d %H:%i:%s') expired_date,
if_expired,
is_enable,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
update_date,
purity_identity from $database.t_customer_engrave where 1=1"
}
import_t_customer_exhibitsales_sync(){
import_data t_customer_exhibitsales_sync " select id,
customer_code,
showroom_code,
KHLXH from $database.t_customer_exhibitsales_sync where 1=1"
}
import_t_customer_gemset_discount(){
import_data t_customer_gemset_discount " select customer_identity,
khbm,
replace(replace(replace(zkhmc,'\n',''),'\t',''),'\r','') zkhmc,
kxdydf_ph_discount,
kxdydf_jp_discount,
kxdydf_tj_discount,
kx_discount,
ks_discount,
ks_discount_desc,
hx_discount,
hx_discount_desc,
hjdydf_ph_discount,
hjdydf_jp_discount,
hjdydf_tj_discount,
id,
create_user,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
children_customer_identity from $database.t_customer_gemset_discount where 1=1"
}
import_t_customer_gemset_discount_history(){
import_data t_customer_gemset_discount_history " select customer_identity,
khbm,
replace(replace(replace(zkhmc,'\n',''),'\t',''),'\r','') zkhmc,
kx_discount,
ks_discount,
old_kx_discount,
old_ks_discount,
ks_discount_desc,
hx_discount_desc,
id,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
create_user,
children_customer_identity from $database.t_customer_gemset_discount_history where 1=1"
}
import_t_customer_interest_detail(){
import_data t_customer_interest_detail " select id,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
customer_identity,
account_purity_name,
due_amount,
due_weight,
overdue_amount,
overdue_weight,
storage_weight,
interest_fee,
gold_price_today,
interest_rate_1,
interest_rate_2,
storage_price,
due_interest_today,
overdue_interest_today,
storage_fee_today,
fee_interest_today,
adjust_interest from $database.t_customer_interest_detail where 1=1"
}
import_t_customer_interest_standard_info(){
import_data t_customer_interest_standard_info " select id,
interest_standard_identity,
showroom_name,
customer_identity,
account_purity_name,
free_interest_days,
over_due_days,
interest_rate_1,
interest_rate_2,
storage_price,
free_storage_days,
month_settle_days,
customer_type,
customer_type_code,
start_date,
end_date from $database.t_customer_interest_standard_info where 1=1"
}
import_t_customer_phone_cp(){
import_data t_customer_phone_cp " select customer_code,
customer_name,
seq,
is_child,
phone1,
phone2,
phone3,
phone4,
active_flag,
parent_code,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
child_customer_code from $database.t_customer_phone_cp where 1=1"
}
import_t_customer_repair(){
import_data t_customer_repair " select id,
repair_identity,
repair_code,
category_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
customer_identity,
parent_customer_identity,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user,
repair_status,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
status,
total_init_weight,
total_number,
total_last_weight,
total_repair_weight from $database.t_customer_repair where 1=1"
}
import_t_customer_repair_detail(){
import_data t_customer_repair_detail " select id,
repair_identity,
repair_detail_identity,
first_category_name,
init_weight,
number,
last_weight,
repair_weight,
repair_status,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
status from $database.t_customer_repair_detail where 1=1"
}
import_t_customer_salesman(){
import_data t_customer_salesman " select id,
customer_id,
customer_identity,
salesman_id,
salesman_identity,
reception_salesman_identity,
is_deleted,
reception_salesman_id from $database.t_customer_salesman where 1=1"
}
import_t_customer_tag(){
import_data t_customer_tag " select id,
tag_identity,
counter_identity,
customer_identity,
tag_content,
is_deleted,
is_default from $database.t_customer_tag where 1=1"
}
import_t_customer_trans_deducation_detail(){
import_data t_customer_trans_deducation_detail " select id,
customer_identity,
account_purity_name,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
debt_trans_id,
debt_trans_name,
debt_trans_code,
repay_trans_id,
repay_trans_name,
repay_trans_code,
repay_type,
repay_amount,
repay_weight from $database.t_customer_trans_deducation_detail where 1=1"
}
import_t_customer_trans_detail_debt_amount(){
import_data t_customer_trans_detail_debt_amount " select id,
showroom_name,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
customer_identity,
customer_code,
parent_customer_name,
child_customer_name,
account_purity_name,
trans_date,
actual_date,
start_deduction_date,
trans_name,
trans_code,
trans_amount,
remain_amount,
deduction_amount,
is_settle,
last_deduction_date,
interest_amount,
type,
free_interest_days,
over_due_days,
month_settle_days,
interest_date,
overdue_date,
month_settle_date from $database.t_customer_trans_detail_debt_amount where 1=1"
}
import_t_customer_trans_detail_debt_weight(){
import_data t_customer_trans_detail_debt_weight " select id,
showroom_name,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
customer_identity,
customer_code,
replace(replace(replace(parent_customer_name,'\n',''),'\t',''),'\r','') parent_customer_name,
child_customer_name,
account_purity_name,
trans_date,
actual_date,
start_deduction_date,
trans_name,
trans_code,
trans_weight,
remain_weight,
deduction_weight,
is_settle,
last_deduction_date,
interest_weight,
type,
free_interest_days,
over_due_days,
free_storage_days,
month_settle_days,
interest_date,
overdue_date,
storage_date,
month_settle_date from $database.t_customer_trans_detail_debt_weight where 1=1"
}
import_t_customer_trans_detail_repay_amount(){
import_data t_customer_trans_detail_repay_amount " select id,
showroom_name,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
customer_identity,
customer_code,
replace(replace(replace(parent_customer_name,'\n',''),'\t',''),'\r','') parent_customer_name,
replace(replace(replace(child_customer_name,'\n',''),'\t',''),'\r','') child_customer_name,
account_purity_name,
trans_date,
actual_date,
trans_name,
trans_code,
trans_amount,
remain_amount,
deduction_amount,
is_settle,
interest_amount,
type,
free_interest_days,
over_due_days,
month_settle_days,
interest_date,
overdue_date,
month_settle_date,
start_deduction_date from $database.t_customer_trans_detail_repay_amount where 1=1"
}
import_t_customer_trans_detail_repay_weight(){
import_data t_customer_trans_detail_repay_weight " select id,
showroom_name,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
customer_identity,
customer_code,
replace(replace(replace(parent_customer_name,'\n',''),'\t',''),'\r','') parent_customer_name,
replace(replace(replace(child_customer_name,'\n',''),'\t',''),'\r','') child_customer_name,
account_purity_name,
trans_date,
actual_date,
trans_name,
trans_code,
trans_weight,
remain_weight,
deduction_weight,
is_settle,
interest_weight,
type,
free_interest_days,
over_due_days,
free_storage_days,
month_settle_days,
interest_date,
overdue_date,
storage_date,
month_settle_date,
start_deduction_date from $database.t_customer_trans_detail_repay_weight where 1=1"
}
import_t_customer_type(){
import_data t_customer_type " select id,
customer_type_identity,
customer_type_code,
customer_type_name,
is_deleted,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_customer_type where 1=1"
}
import_t_default_discount_mosaic(){
import_data t_default_discount_mosaic " select id,
default_discount_mosaic_identity,
showroom_identity,
counter_identity,
mosaic_discount,
eos_head_key,
eos_body_key,
hj_dydf_ph_discount,
hj_dydf_jp_discount from $database.t_default_discount_mosaic where 1=1"
}
import_t_delay_task(){
import_data t_delay_task " select id,
task_identity,
handler_user,
handler_user_type,
customer_identity,
package_type,
date_format(estimate_time,'%Y-%m-%d %H:%i:%s') estimate_time,
delay_status,
comments,
is_end,
replace(replace(replace(end_time,'\n',''),'\t',''),'\r','') end_time,
create_user,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
delat_code,
replace(replace(replace(initial_create_time,'\n',''),'\t',''),'\r','') initial_create_time,
replace(replace(replace(approval_time,'\n',''),'\t',''),'\r','') approval_time,
status,
auto_type from $database.t_delay_task where 1=1"
}
import_t_delay_task_detail(){
import_data t_delay_task_detail " select id,
task_identity,
package_code,
weight from $database.t_delay_task_detail where 1=1"
}
import_t_deposit_jewelry(){
import_data t_deposit_jewelry " select id,
deposit_identity,
jewelry_purity_name,
jewelry_weight from $database.t_deposit_jewelry where 1=1"
}
import_t_deposit_order(){
import_data t_deposit_order " select id,
deposit_identity,
deposit_code,
deposit_type,
goods_source,
receiver_type,
receiver_factory_name,
receiver_dept,
receiver_name,
deposit_number,
replace(replace(replace(deposit_remarks,'\n',''),'\t',''),'\r','') deposit_remarks,
customer_code,
customer_identity,
customer_name,
children_customer_name,
jewelry_type,
jewelry_weight,
create_identity,
create_name,
sf_code,
delivery_code,
delivery_time,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
marking_status,
deposit_status,
is_delete,
deposit_registration_type,
showroom_identity,
delivery_user_identity,
delivery_user_name,
first_name from $database.t_deposit_order where 1=1"
}
import_t_deposit_setting(){
import_data t_deposit_setting " select id,
name,
children_name,
type,
showroom_identity from $database.t_deposit_setting where 1=1"
}
import_t_eos_fail(){
import_data t_eos_fail " select id,
fast_package_identity,
showroom_code,
order_identity,
customer_identity,
salesman_identity,
number from $database.t_eos_fail where 1=1"
}
import_t_eos_order(){
import_data t_eos_order " select id,
order_identity,
order_code,
purity_name,
date_format(estimate_time,'%Y-%m-%d %H:%i:%s') estimate_time,
supplier_identity,
supplier_name,
supplier_source,
supplier_type,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
customer_name,
customer_code,
engrave_content,
customer_showroom,
order_type,
counter_name,
engrave_code,
djlsh,
variety,
end_reason,
return_identity,
source_order_type,
if_receive_happen,
order_total_number,
order_total_weight,
receiving_status,
kgd,
is_have_recall,
djh,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
khdm,
ppmc,
dj_state from $database.t_eos_order where 1=1"
}
import_t_eos_order_detial(){
import_data t_eos_order_detial " select id,
order_identity,
order_code,
product_photo,
product_code,
product_bar_code,
product_name,
product_style,
category_code,
transfer_settlement_price,
gold_stone_name,
company_code,
factory_code,
purity_name,
master_stone_name,
piece_weight,
gold_weight,
order_number,
order_weight,
work_fee,
date_format(estimate_time,'%Y-%m-%d %H:%i:%s') estimate_time,
technology_unit_price,
color_gold_weight,
label_price,
metal_color,
contain_loss_weight,
total_weight,
loss_rate,
net_gold_weight,
unit_gold_weight,
price,
jade_stone_size,
price_interval_lowest,
price_interval_highest,
stone_unit,
master_stone_number,
master_stone_weight,
master_stone_unit_price,
valuation_method,
valuation_method_one,
side_stone_name_one,
side_stone_number_one,
side_stone_weight_one,
side_stone_unit_price_one,
valuation_method_two,
side_stone_name_two,
side_stone_number_two,
side_stone_weight_two,
side_stone_unit_price_two,
stone_fee,
stone_total_fee,
base_work_fee,
attach_work_fee,
make_up_fee,
other_fee,
total_fee,
style_category,
specification_name,
label_name,
if_boutique,
if_receive_ok,
return_identity,
first_category,
second_category,
djbth,
djlsh,
return_detail_id,
receive_payment_type,
receiving_detail_status,
receive_code,
receive_detail_id,
djh,
realddbh,
fee_type,
htm,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
khdm,
hz,
bqm,
specifications,
workmanship,
ppmc from $database.t_eos_order_detial where 1=1"
}
import_t_fast_order(){
import_data t_fast_order " select id,
order_identity,
package_number,
processed_number,
customer_identity,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
is_complete,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
gold_price,
serial_number,
is_urgent,
settlement_method,
is_suspend,
date_format(customer_confirmation_time,'%Y-%m-%d %H:%i:%s') customer_confirmation_time,
sales_status_id,
counter_name,
wait_number,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
salesman_identity,
date_format(confirm_time,'%Y-%m-%d %H:%i:%s') confirm_time,
completion_time from $database.t_fast_order where 1=1"
}
import_t_fast_order_purity(){
import_data t_fast_order_purity " select id,
order_purity_identity,
order_identity,
purity_identity,
purity_code,
purity_name,
deduction_weight from $database.t_fast_order_purity where 1=1"
}
import_t_fast_package_delete(){
import_data t_fast_package_delete " select id,
customer_identity,
package_code,
replace(replace(replace(reason,'\n',''),'\t',''),'\r','') reason,
create_user,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_fast_package_delete where 1=1"
}
import_t_fast_package_engrave(){
import_data t_fast_package_engrave " select id,
engrave_identity,
engrave_content,
date_format(customer_require_time,'%Y-%m-%d %H:%i:%s') customer_require_time,
net_weight,
gross_weight,
counter_code,
customer_identity,
showroom_counter_identity,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
code,
engrave_status,
date_format(creat_time,'%Y-%m-%d %H:%i:%s') creat_time,
is_fast_out,
operation_content,
batch_code,
engrave_staff,
quality_staff,
qualitycon_staff,
date_format(receive_time,'%Y-%m-%d %H:%i:%s') receive_time,
date_format(complete_time,'%Y-%m-%d %H:%i:%s') complete_time from $database.t_fast_package_engrave where 1=1"
}
import_t_fast_package_flowing(){
import_data t_fast_package_flowing " select id,
flowing_identity,
fast_package_identity,
package_code,
net_weight,
type,
is_now,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
create_user_id,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
modify_user_id,
date_format(modify_date,'%Y-%m-%d %H:%i:%s') modify_date from $database.t_fast_package_flowing where 1=1"
}
import_t_fast_package_i_plastic(){
import_data t_fast_package_i_plastic " select id,
package_i_identity,
plastic_number,
plastic_size,
plastic_id,
replace(replace(replace(plastic_name,'\n',''),'\t',''),'\r','') plastic_name from $database.t_fast_package_i_plastic where 1=1"
}
import_t_fast_package_reason(){
import_data t_fast_package_reason " select id,
showroom_identity,
delete_reason,
del_flag from $database.t_fast_package_reason where 1=1"
}
import_t_fast_package_record(){
import_data t_fast_package_record " select id,
fast_package_record_identity,
fast_package_identity,
package_code,
package_name,
status_id,
customer_identity,
counter_user_identity,
initial_package_code,
net_weight,
gross_weight,
purity_identity,
showroom_counter_identity,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date from $database.t_fast_package_record where 1=1"
}
import_t_fast_package_status(){
import_data t_fast_package_status " select id,
status_code,
status_name from $database.t_fast_package_status where 1=1"
}
import_t_fast_package_tag(){
import_data t_fast_package_tag " select id,
tag_identity,
tag_content,
customer_require_time,
net_weight,
gross_weight,
customer_identity,
counter_code,
showroom_counter_identity,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
code,
tag_status,
is_fast_out,
operation_content,
batch_code,
date_format(creat_time,'%Y-%m-%d %H:%i:%s') creat_time,
date_format(receive_time,'%Y-%m-%d %H:%i:%s') receive_time,
date_format(complete_time,'%Y-%m-%d %H:%i:%s') complete_time,
tag_staff from $database.t_fast_package_tag where 1=1"
}
import_t_fast_package_update_customer(){
import_data t_fast_package_update_customer " select id,
package_code,
initial_package_code,
is_print,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date from $database.t_fast_package_update_customer where 1=1"
}
import_t_fast_technology_price(){
import_data t_fast_technology_price " select id,
technology_identity,
package_i_identity,
technology_num,
technology_unit_price,
technology_count_price from $database.t_fast_technology_price where 1=1"
}
import_t_finance_customer_info(){
import_data t_finance_customer_info " select id,
finance_customer_info_identity,
showroom_identity,
showroom_name,
finance_customer_code,
finance_customer_name,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user_id,
create_user_name,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_user_id,
update_user_name,
is_delete,
djlsh from $database.t_finance_customer_info where 1=1"
}
import_t_fjgfzkbb_sync(){
import_data t_fjgfzkbb_sync " select djlsh,
gfje,
zkl from $database.t_fjgfzkbb_sync where 1=1"
}
import_t_fjgfzkbh_sync(){
import_data t_fjgfzkbh_sync " select djlsh,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
khbm,
replace(replace(replace(bz,'\n',''),'\t',''),'\r','') bz,
replace(replace(replace(zkhmc,'\n',''),'\t',''),'\r','') zkhmc,
zkhbh,
csgs,
khbm_jds,
khmc_jds from $database.t_fjgfzkbh_sync where 1=1"
}
import_t_gemstone_attribute(){
import_data t_gemstone_attribute " select id,
purity_name,
gold_gem_code,
gold_gem_name from $database.t_gemstone_attribute where 1=1"
}
import_t_genus(){
import_data t_genus " select id,
genus_identity,
genus_code,
genus_name,
genus_help_code,
create_user_id,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
date_format(modify_date,'%Y-%m-%d %H:%i:%s') modify_date from $database.t_genus where 1=1"
}
import_t_incoming_difference(){
import_data t_incoming_difference " select id,
area_identity,
area_name,
plan_incoming,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_by from $database.t_incoming_difference where 1=1"
}
import_t_incoming_maintain(){
import_data t_incoming_maintain " select id,
name,
sub_name,
identity,
type,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by from $database.t_incoming_maintain where 1=1"
}
import_t_initial_package_update_customer(){
import_data t_initial_package_update_customer " select id,
old_code,
new_code,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
create_user from $database.t_initial_package_update_customer where 1=1"
}
import_t_initial_weight(){
import_data t_initial_weight " select id,
initial_weight_identity,
super_tag,
showroom_identity,
customer_identity,
showroom_counter_identity,
counter_user_identity,
initial_counter_user_identity,
initial_weight,
net_weight,
tray_number,
is_engrave,
is_tag,
engrave_content,
tag_content,
date_format(engrave_require_time,'%Y-%m-%d %H:%i:%s') engrave_require_time,
date_format(tag_require_time,'%Y-%m-%d %H:%i:%s') tag_require_time,
business_require,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
is_immediate,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user,
business_require_time,
business_require_id,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
is_handle_engrave,
is_handle_tag,
is_send_notify,
is_fast_out,
is_stay,
stay_identity,
sales_status_id,
status_id,
salesman_identity,
is_return,
delay_number,
is_visible,
disable_delay,
date_format(estimate_time,'%Y-%m-%d %H:%i:%s') estimate_time,
delay_status,
delay_salesman_identity,
delay_care,
goods_picker,
goods_picker_phone,
is_end from $database.t_initial_weight where 1=1"
}
import_t_initial_weight_delete(){
import_data t_initial_weight_delete " select id,
initial_weight_identity,
super_tag,
new_code,
showroom_identity,
customer_identity,
showroom_counter_identity,
counter_user_identity,
initial_counter_user_identity,
initial_weight,
net_weight,
tray_number,
is_engrave,
is_tag,
engrave_content,
tag_content,
date_format(engrave_require_time,'%Y-%m-%d %H:%i:%s') engrave_require_time,
date_format(tag_require_time,'%Y-%m-%d %H:%i:%s') tag_require_time,
business_require,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
is_immediate,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user,
business_require_time,
business_require_id,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
is_handle_engrave,
is_handle_tag,
is_send_notify,
is_fast_out,
is_stay,
stay_identity,
sales_status_id,
status_id,
salesman_identity,
is_return,
delay_number,
is_visible,
delay_status,
disable_delay,
date_format(estimate_time,'%Y-%m-%d %H:%i:%s') estimate_time,
delay_salesman_identity,
delay_care,
goods_picker,
goods_picker_phone from $database.t_initial_weight_delete where 1=1"
}
import_t_initial_weight_record(){
import_data t_initial_weight_record " select id,
initial_weight_record_identity,
initial_weight_identity,
super_tag,
customer_identity,
showroom_counter_identity,
counter_user_identity,
initial_counter_user_identity,
initial_weight,
net_weight,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date from $database.t_initial_weight_record where 1=1"
}
import_t_initial_weight_status(){
import_data t_initial_weight_status " select id,
status_code,
status_name from $database.t_initial_weight_status where 1=1"
}
import_t_ka_kxjczb(){
import_data t_ka_kxjczb " select id,
wdbm,
wdmc,
customer_identity,
parent_customer_identity,
jz,
kxed,
kqze,
kxzq,
kqzl,
KCEB,
RXSZE,
HCKXED,
DRJYZE,
KQJZ,
KQJE,
MXTS,
DQJZ,
DQJE,
czzt,
same_customer_purity from $database.t_ka_kxjczb where 1=1"
}
import_t_ka_llmxz_b(){
import_data t_ka_llmxz_b " select id,
llmxz_H_identity,
llmxz_B_identity,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
djm,
djh,
djhh,
csbm,
csmc,
hl,
plbm,
plmc,
zqjz,
wjjz,
yjjz,
replace(replace(replace(bz,'\n',''),'\t',''),'\r','') bz,
dcwdmc,
gylx,
customer_identity,
parent_customer_identity,
jz,
czzt from $database.t_ka_llmxz_b where 1=1"
}
import_t_ka_llmxz_h(){
import_data t_ka_llmxz_h " select id,
llmxz_H_identity,
customer_identity,
parent_customer_identity,
jz,
wdbm,
wdmc,
customer_help_code from $database.t_ka_llmxz_h where 1=1"
}
import_t_ka_lsedzb(){
import_data t_ka_lsedzb " select id,
lsedzb_identity,
wdbm,
wdmc,
customer_identity,
lsed,
kqze,
kxzq,
kqzl,
mxts from $database.t_ka_lsedzb where 1=1"
}
import_t_ka_lsz_h(){
import_data t_ka_lsz_h " select id,
djm,
djh,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
sptm,
swlx,
wdmc,
splx,
ckmc,
spmc,
ppmc,
dlmc,
jsmc,
plmc,
sffx,
js,
jz,
hz,
sjcb,
bzjg,
bqjg,
ykj,
jp,
jsje,
lsje,
zsmc,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
rhf,
chf,
czzt from $database.t_ka_lsz_h where 1=1"
}
import_t_ka_mxz(){
import_data t_ka_mxz " select id,
kczt,
kdzt,
sptm,
zshm,
giazs,
wdmc,
ckmc,
gysbm,
gys,
ppmc,
dlmc,
jsmc,
plmc,
gckh,
gskh,
gg,
spmc,
splx,
xlmc,
jz,
hz,
jgf,
xsgf,
sxf,
zsys,
zsjd,
zsqg,
zssl,
zszl,
fsmc,
fssl,
fszl,
js,
sjcb,
sccb,
bzjg,
bqjg,
dw,
khh,
ykj,
jp,
gflx,
pjsm,
cfhh,
replace(replace(replace(bz,'\n',''),'\t',''),'\r','') bz,
date_format(rkrq,'%Y-%m-%d %H:%i:%s') rkrq,
rkdh,
rkdm,
date_format(gxrq,'%Y-%m-%d %H:%i:%s') gxrq,
gxdh,
pdzt,
pddh,
lsdh,
date_format(lsrq,'%Y-%m-%d %H:%i:%s') lsrq,
xsdj,
sjzk,
ml,
mjj,
lsje,
jsdh,
jsrq,
jsje,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
zsmc,
cxm,
ewm,
ewmx,
lbdm,
zscb,
fscb,
wxfy,
bzcb,
zsgg,
wxdm,
bqm from $database.t_ka_mxz where wdmc='深圳展厅' and date(rkrq)>='2022-01-01' and 1=1 "
}
import_t_ka_mxz_update(){
import_data t_ka_mxz_update " select id,
kczt,
kdzt,
sptm,
zshm,
giazs,
wdmc,
ckmc,
gysbm,
gys,
ppmc,
dlmc,
jsmc,
plmc,
gckh,
gskh,
gg,
spmc,
splx,
xlmc,
jz,
hz,
jgf,
xsgf,
sxf,
zsys,
zsjd,
zsqg,
zssl,
zszl,
fsmc,
fssl,
fszl,
js,
sjcb,
sccb,
bzjg,
bqjg,
dw,
khh,
ykj,
jp,
gflx,
pjsm,
cfhh,
replace(replace(replace(bz,'\n',''),'\t',''),'\r','') bz,
date_format(rkrq,'%Y-%m-%d %H:%i:%s') rkrq,
rkdh,
rkdm,
date_format(gxrq,'%Y-%m-%d %H:%i:%s') gxrq,
gxdh,
pdzt,
pddh,
lsdh,
date_format(lsrq,'%Y-%m-%d %H:%i:%s') lsrq,
xsdj,
sjzk,
ml,
mjj,
lsje,
jsdh,
date_format(jsrq,'%Y-%m-%d %H:%i:%s') jsrq,
jsje,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
zsmc,
cxm,
ewm,
ewmx,
lbdm,
zscb,
fscb,
wxfy,
bzcb,
zsgg,
wxdm,
bqm from $database.t_ka_mxz_update where 1=1"
}
import_t_ka_spkcmxz(){
import_data t_ka_spkcmxz " select id,
WDBM,
wdmc,
ckbm,
ckmc,
ppbm,
ppmc,
dlbm,
dlmc,
jsbm,
jsmc,
plbm,
plmc,
js,
jz,
cb,
bj,
czzt from $database.t_ka_spkcmxz where 1=1"
}
import_t_ka_szdzsqdh_temp(){
import_data t_ka_szdzsqdh_temp " select id,
djlsh,
djh,
wdmc,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
khbm,
replace(replace(replace(ZKH,'\n',''),'\t',''),'\r','') ZKH,
zdr,
date_format(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
zdrid,
date_format(cwjsrq,'%Y-%m-%d %H:%i:%s') cwjsrq,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
replace(replace(replace(bz,'\n',''),'\t',''),'\r','') bz,
dzbjje,
dzgfje,
dzjlzl,
tzlxje,
drkhmc,
drkhbm,
drzkhmc,
cwkhbm,
cwkhmc,
glkhmc,
khqkbj,
khgfye,
khlx,
khqlzl,
khqkbj1,
khgfye1,
khlx1,
khqlzl1,
cwqrtzbj,
cwqrtzgf,
cwqrtzlx,
cwqrtzlz,
ywjlqr,
date_format(sj1,'%Y-%m-%d %H:%i:%s') sj1,
fgldqr,
date_format(sj2,'%Y-%m-%d %H:%i:%s') sj2,
zjlpf,
date_format(sj3,'%Y-%m-%d %H:%i:%s') sj3,
cwqr,
date_format(sj4,'%Y-%m-%d %H:%i:%s') sj4,
dszfh,
date_format(sj5,'%Y-%m-%d %H:%i:%s') sj5,
date_format(cwshsj,'%Y-%m-%d %H:%i:%s') cwshsj,
date_format(zjlpfrq,'%Y-%m-%d %H:%i:%s') zjlpfrq,
sfdy,
dysj,
cwecqr,
cwecqrsj,
out_tech_purity_name,
out_tech_purity_code,
in_tech_purity_name,
in_tech_purity_code from $database.t_ka_szdzsqdh_temp where 1=1"
}
import_t_ka_szkhcqlxzz_f(){
import_data t_ka_szkhcqlxzz_f " select szkhcqlxzz_h_identity,
szkhcqlxzz_f_identity,
swlx,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
xmje,
yjsjd from $database.t_ka_szkhcqlxzz_f where 1=1"
}
import_t_ka_szkhcqmx_b(){
import_data t_ka_szkhcqmx_b " select szkhcqmx_h_identity,
szkhcqmx_b_identity,
djlsh,
djbth,
djstate,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
zl,
je,
lxb,
ze,
ts,
zlqj,
scbs,
date_format(zxrqb,'%Y-%m-%d %H:%i:%s') zxrqb from $database.t_ka_szkhcqmx_b where 1=1"
}
import_t_ka_szkhcqmx_f(){
import_data t_ka_szkhcqmx_f " select djlsh,
szkhcqmx_h_identity,
szkhcqmx_f_identity,
djfth,
djstate,
date_format(rqf,'%Y-%m-%d %H:%i:%s') rqf,
zlf,
jef,
lxf,
zef,
tsf,
zlqjf,
scbsf,
date_format(zxrq,'%Y-%m-%d %H:%i:%s') zxrq from $database.t_ka_szkhcqmx_f where 1=1"
}
import_t_ka_xltj_b(){
import_data t_ka_xltj_b " select id,
identity,
djh,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
csmc,
xszl,
jjzl,
jjje,
czzt from $database.t_ka_xltj_b where 1=1"
}
import_t_ka_xltj_h(){
import_data t_ka_xltj_h " select id,
identity,
wdmc,
customer_identity,
parent_customer_identity from $database.t_ka_xltj_h where 1=1"
}
import_t_ka_yflmxz(){
import_data t_ka_yflmxz " select id,
WDMC,
khbm,
customer_identity,
parent_customer_identity,
lxr,
CSBM,
CSMC,
plbm,
plmc,
JZ,
khlx,
czzt from $database.t_ka_yflmxz where 1=1"
}
import_t_ka_yfmxz(){
import_data t_ka_yfmxz " select id,
wdmc,
customer_identity,
parent_customer_identity,
lb,
je,
bb,
khlx from $database.t_ka_yfmxz where 1=1"
}
import_t_ka_yfrzzh(){
import_data t_ka_yfrzzh " select id,
yfrzz_identity,
nian,
yue,
ri,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
wdmc,
zjm,
customer_identity,
khbm,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
qcje,
qcjz,
zjje,
zjjz,
jsje,
jsjz,
jcje,
jcjz from $database.t_ka_yfrzzh where 1=1"
}
import_t_ka_yhrq(){
import_data t_ka_yhrq " select id,
yhrq_identity,
showroom_name,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_ka_yhrq where 1=1"
}
import_t_ka_ysmxz_s(){
import_data t_ka_ysmxz_s " select id,
ysmxz_h_identity,
ysmxz_b_identity,
ysmxz_s_identity,
date_format(hxdjrq,'%Y-%m-%d %H:%i:%s') hxdjrq,
hxdh,
hxdm,
hxje,
sm,
date_format(hxczrq,'%Y-%m-%d %H:%i:%s') hxczrq,
hxczdh,
drwdmc from $database.t_ka_ysmxz_s where 1=1"
}
import_t_ka_ysmxz_sold(){
import_data t_ka_ysmxz_sold " select id,
ysmxz_sold_identity,
sptm,
zshm,
giazs,
wdmc,
ckmc,
gysbm,
gys,
ppmc,
dlmc,
jsmc,
plmc,
gckh,
gskh,
gg,
spmc,
splx,
xlmc,
jz,
hz,
jgf,
xsgf,
sxf,
zsys,
zsjd,
zsqg,
zssl,
zszl,
fsmc,
fssl,
fszl,
js,
sjcb,
sccb,
bzjg,
bqjg,
dw,
khh,
ykj,
jp,
gflx,
pjsm,
cfhh,
replace(replace(replace(bz,'\n',''),'\t',''),'\r','') bz,
date_format(rkrq,'%Y-%m-%d %H:%i:%s') rkrq,
rkdh,
rkdm,
date_format(gxrq,'%Y-%m-%d %H:%i:%s') gxrq,
gxdh,
pdzt,
pddh,
lsdh,
date_format(lsrq,'%Y-%m-%d %H:%i:%s') lsrq,
xsdj,
sjzk,
ZKJE,
ml,
mjj,
lsje,
jsdh,
date_format(jsrq,'%Y-%m-%d %H:%i:%s') jsrq,
jsje,
customer_identity,
khbm,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
ZSMC,
CXM,
EWM,
JJ,
CSMC from $database.t_ka_ysmxz_sold where 1=1"
}
import_t_ka_zjlsz(){
import_data t_ka_zjlsz " select id,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
djm,
djh,
swlx,
gsmc,
je,
sffx,
replace(replace(replace(zh,'\n',''),'\t',''),'\r','') zh,
fssj,
fsje,
zjlx,
yh,
yhzh,
zcwd,
replace(replace(replace(bz,'\n',''),'\t',''),'\r','') bz,
czzt,
customer_identity,
parent_customer_identity from $database.t_ka_zjlsz where 1=1"
}
import_t_ka_zjyez(){
import_data t_ka_zjyez " select id,
gsmc,
replace(replace(replace(zh,'\n',''),'\t',''),'\r','')  zh,
je,
zjlx,
yh,
yhzh,
czzt,
customer_identity,
parent_customer_identity from $database.t_ka_zjyez where 1=1"
}
import_t_ka_ztkczz(){
import_data t_ka_ztkczz " select id,
ztkczz_identity,
nian,
yue,
wdmc,
ckmc,
jsmc,
plmc,
qcjs,
qcjz,
qcje,
qmjs,
qmjz,
qmje from $database.t_ka_ztkczz where 1=1"
}
import_t_kj_child_customer(){
import_data t_kj_child_customer " select id,
customer_identity,
child_customer_identity,
djlsh,
djbth,
child_customer_code,
child_customer_seq,
customer_name,
mobile_phone,
mobile_phone1,
contact_man,
active_flag,
ty_customer_code,
purity_name,
contact_address,
help_code2,
balance_rate_b,
mosaic_discount_b,
province,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
area_name_b,
city_code_b,
country_code_b,
legal_person_tel_b,
company_nature_b,
customer_type_nb,
brand_name_b,
license_time_b,
of_area_b,
authorize_payer_b,
payer_bank_count_b,
payer_credit_card_b,
payer_bank_name_b,
payer_bank_branch_b,
payer_bank_sub_branch_b,
authorize_active_date_b,
authorize_active_str_b,
authorize_payer_b2,
payer_bank_count_b2,
payer_credit_card_b2,
payer_bank_name_b2,
payer_bank_branch_b2,
payer_bank_sub_branch_b2,
authorize_active_date_b2,
authorize_active_str_b2,
offical_or_personal from $database.t_kj_child_customer where 1=1"
}
import_t_kj_customer(){
import_data t_kj_customer " select id,
customer_identity,
djlsh,
customer_code,
replace(replace(replace(customer_name,'\n',''),'\t',''),'\r','') customer_name,
office_phone,
phone_no,
mobile_phone,
mobile_phone1,
active_flag,
ty_customer_code,
purity_name,
customer_classification,
input_type,
subject_code,
customer_short_name,
bank_name,
bank_account,
tax_amount,
address,
fax_no,
web_url,
help_code,
legal_person,
id_code,
position,
email,
create_user_code,
create_user_ame,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_code,
modify_user_name,
show_balance_rate,
show_sale_rate,
credit_level,
credit_quato,
credit_desc,
pay_time_limit,
price_pay_limit,
balance_rate,
branch_name,
company_name,
province,
province_code,
city,
city_code,
county,
county_desc,
town,
town_desc,
memo,
area_code,
area_name,
labour_discount,
is_customer,
is_supplier,
is_provincial,
day_interest_rate,
salesman_name,
salesman_phone,
address_detail,
contact_no,
contact_name,
is_five,
customer_card_code,
contract_begin_date,
contract_end_date,
alliance_amount,
brand_amount,
deposit_amount,
is_child,
license_desc,
customer_debt_name,
test_customer_type,
uniq_id,
mosaic_discount,
is_diamond,
is_kgold,
is_platinum,
class_code,
class_level,
level_name,
diamond_effect_time,
customer_type,
of_area,
legal_person_tel,
frequent_contacts_position,
frequent_contacts_wechat,
delivery_name,
delivery_id_code,
delivery_mobile_no,
authorization_date,
company_nature,
registered_capital,
license_code,
license_range,
brand_type,
license_approve_time,
license_approve_time_char,
new_customer_type,
authorize_payer,
payer_bank_count,
payer_credit_card,
payer_bank_name,
payer_bank_branch,
payer_bank_sub_branch,
authorize_active_date,
authorize_active_str,
authorize_payerb,
payerb_bank_count,
payerb_credit_card,
payerb_bank_name,
payerb_bank_branch,
payerb_bank_sub_branch,
authorize_active_dateb,
authorize_active_strb,
is_official,
is_personal,
second_responsible_person from $database.t_kj_customer where 1=1"
}
import_t_material_price_rule(){
import_data t_material_price_rule " select id,
purity_identity,
customer_identity,
rule,
prefix from $database.t_material_price_rule where 1=1"
}
import_t_move_counter_detail(){
import_data t_move_counter_detail " select id,
move_identity,
move_code,
product_code,
outsource_code,
product_name,
product_style,
piece_weight,
order_number,
order_weight,
receive_number,
receive_weight,
receive_weight_commit,
receive_number_commit,
receive_number_receive,
receive_weight_receive,
actual_number,
actual_weight,
difference_number,
difference_weight,
work_fee,
product_photo,
receive_id,
total_work_fee,
status from $database.t_move_counter_detail where 1=1"
}
import_t_package_delete_approve(){
import_data t_package_delete_approve " select id,
package_delete_approve_identity,
package_code,
delete_reason,
approve_status,
reject_reason,
create_user,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
approve_user,
approve_date from $database.t_package_delete_approve where 1=1"
}
import_t_package_engrave_tag(){
import_data t_package_engrave_tag " select id,
engrave_tag_identity,
fast_package_identity,
is_engrave,
is_tag,
engrave_content,
tag_content,
date_format(engrave_require_time,'%Y-%m-%d %H:%i:%s') engrave_require_time,
date_format(tag_require_time,'%Y-%m-%d %H:%i:%s') tag_require_time,
business_require,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
is_immediate,
is_handle_engrave,
is_handle_tag,
up_count,
business_require_time from $database.t_package_engrave_tag where 1=1"
}
import_t_package_stay_weight_customer(){
import_data t_package_stay_weight_customer " select date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
customer_identity,
customer_code,
replace(replace(replace(customer_name,'\n',''),'\t',''),'\r','') customer_name,
replace(replace(replace(customer_name_template,'\n',''),'\t',''),'\r','') customer_name_template,
parent_Customer_identity,
parent_Customer_code,
replace(replace(replace(parent_Customer_Name,'\n',''),'\t',''),'\r','') parent_Customer_Name,
counter_name,
department_name,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
net_weight,
is_inital from $database.t_package_stay_weight_customer where 1=1"
}
import_t_packing_paper(){
import_data t_packing_paper " select id,
paper_name,
paper_weight,
paper_type,
tolerance_weight,
counter_identity from $database.t_packing_paper where 1=1"
}
import_t_physical_counter(){
import_data t_physical_counter " select id,
physical_identity,
physical_name,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
status,
showroom_identity,
showroom_name,
super_counter from $database.t_physical_counter where 1=1"
}
import_t_print_log(){
import_data t_print_log " select id,
print_identity,
print_customer_code,
print_date from $database.t_print_log where 1=1"
}
import_t_product_basic_info(){
import_data t_product_basic_info " select id,
product_basic_info_identity,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
product_code,
product_name,
factory_model_code,
gold_weight,
category_second_name,
standard_fee,
main_stone_name,
main_stone_specs,
qty,
category_name,
sales_fee,
storage_date,
storage_number,
storage_name,
goods_weight,
is_high_quality,
outsourc_code,
data_class,
order_status,
store_status,
eos_head_key1,
eos_head_key2,
eos_body_key,
company_model_code,
genus_code,
metal_color,
specification,
total_weight,
loss,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
special_commodity_b,
last_open_order_no,
last_open_order,
last_no,
last_serial,
special_b,
certificate_no,
main_stone_color,
clarity,
contains_consumption_weight,
total_stone_weight,
main_stone_weight,
auxiliary_stone_weight1,
auxiliary_stone_weight2,
auxiliary_stone_weight3,
auxiliary_stone_weight4,
auxiliary_stone_weight5,
auxiliary_stone_weight6,
parts_weight1,
parts_weight2,
parts_weight3,
print_main_stone_weight,
print_auxiliary_stone_weight,
category_second_identity,
category_identity,
gold_stone_name,
stone_code,
stone_name,
stone_shape,
stone_number_s,
stone_unit_price_s,
pricing_method,
total_price_s,
auxiliary_stone_package_code1,
auxiliary_stone_name1,
auxiliary_stone_shape1,
auxiliary_stone_color1,
auxiliary_stone_clarity1,
auxiliary_stone_qty1,
auxiliary_stone_unit_price1,
pricing_method1,
auxiliary_stone_total_amount1,
auxiliary_stone_package_code2,
auxiliary_stone_name2,
auxiliary_stone_shape2,
auxiliary_stone_color2,
auxiliary_stone_clarity2,
auxiliary_stone_qty2,
auxiliary_stone_unit_price2,
pricing_method2,
auxiliary_stone_total_amount2,
auxiliary_stone_package_code3,
auxiliary_stone_name3,
auxiliary_stone_shape3,
auxiliary_stone_color3,
auxiliary_stone_clarity3,
auxiliary_stone_qty3,
auxiliary_stone_unit_price3,
pricing_method3,
auxiliary_stone_total_amount3,
auxiliary_stone_package_code4,
auxiliary_stone_name4,
auxiliary_stone_shape4,
auxiliary_stone_color4,
auxiliary_stone_clarity4,
auxiliary_stone_qty4,
auxiliary_stone_unit_price4,
pricing_method4,
auxiliary_stone_total_amount4,
auxiliary_stone_package_code5,
auxiliary_stone_name5,
auxiliary_stone_shape5,
auxiliary_stone_color5,
auxiliary_stone_clarity5,
auxiliary_stone_qty5,
auxiliary_stone_unit_price5,
pricing_method5,
auxiliary_stone_total_amount5,
auxiliary_stone_package_code6,
auxiliary_stone_name6,
auxiliary_stone_shape6,
auxiliary_stone_color6,
auxiliary_stone_clarity6,
auxiliary_stone_qty6,
auxiliary_stone_unit_price6,
pricing_method6,
auxiliary_stone_total_amount6,
accessory_name1,
accessory_qty1,
accessory_unit_price1,
pricing_method7,
accessory_amount1,
accessory_name2,
accessory_qty2,
accessory_unit_price2,
pricing_method8,
accessory_amount2,
accessory_name3,
accessory_qty3,
accessory_unit_price3,
pricing_method9,
accessory_amount3,
qr_code,
query_code,
series_name,
gold_stone_code from $database.t_product_basic_info where date(storage_date)>='2022-01-01' and 1=1"
}
import_t_product_fee(){
import_data t_product_fee " select id,
product_fee_identity,
showroom_identity,
counter_identity,
product_code,
certificate_fee,
seam_fee,
back_cover_fee,
drawing_fee,
sandblasting_fee,
basic_fee,
start_fee,
stone_encrusted_fee,
processing_fee,
other_fee,
additional_labour,
parting_fee,
stone_encrusted_fee1,
other_fee1,
company_expenses,
certificate_fee0,
stone_fee,
label_fee,
eos_head_key1,
eos_head_key2,
eos_body_key,
main_stone_cost_amount,
auxiliary_stone_cost_amount1,
auxiliary_stone_cost_amount2,
auxiliary_stone_cost_amount3,
auxiliary_stone_cost_amount4,
auxiliary_stone_cost_amount5,
auxiliary_stone_cost_amount6,
parts_cost_amount1,
parts_cost_amount2,
parts_cost_amount3,
label_price,
main_stone_price,
auxiliary_stone_total_price1,
auxiliary_stone_total_price2,
auxiliary_stone_total_price3,
auxiliary_stone_total_price4,
auxiliary_stone_total_price5,
auxiliary_stone_total_price6,
gold_unit_price,
total_price,
gold_total_price,
purchase_amount,
fixed_price_storage,
main_stone_cost,
auxiliary_stone_cost,
stone_total_fee,
auxiliary_total_fee,
auxiliary_cost,
gold_costs,
data_class from $database.t_product_fee where 1=1"
}
import_t_product_model_basic(){
import_data t_product_model_basic " select id,
product_model_basic_identity,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
model_code,
category_second_name,
category_second_identity,
category_name,
category_identity,
complementary_material,
simple_model_no,
label_short_code,
gold_weight,
style_name,
price_method,
mnemonic_code,
data_class,
eos_head_key,
eos_body_key from $database.t_product_model_basic where 1=1"
}
import_t_product_model_discount(){
import_data t_product_model_discount " select id,
product_model_discount_identity,
showroom_identity,
showroom_name,
model_code,
model_name,
factory_model_code,
factory_model_name,
price_method,
sales_min_discount,
is_enable,
eos_head_key,
eos_body_key from $database.t_product_model_discount where 1=1"
}
import_t_product_model_fee(){
import_data t_product_model_fee " select id,
product_model_fee_identity,
model_code,
model_name,
metal_color_code,
metal_color_name,
single_fee,
sales_fee,
actual_sales_fee,
data_class,
eos_head_key,
eos_body_key,
mnemonic_code,
model_code_color from $database.t_product_model_fee where 1=1"
}
import_t_province_salesman(){
import_data t_province_salesman " select id,
province_salesman_identity,
province_code,
province,
salesman_id,
salesman_identity,
data_create_time,
data_update_time,
region,
showroom_identity from $database.t_province_salesman where 1=1"
}
import_t_purity_engrave(){
import_data t_purity_engrave " select id,
purity_engrave_identity,
purity_identity,
purity_name,
engrave_name,
create_user_id,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
date_format(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
type,
status from $database.t_purity_engrave where 1=1"
}
import_t_purity_tag(){
import_data t_purity_tag " select id,
purity_tag_identity,
purity_identity,
purity_name,
tag_name,
create_user_id,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
date_format(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
type,
status from $database.t_purity_tag where 1=1"
}
import_t_qc(){
import_data t_qc " select id,
receive_identity,
receive_code,
purity_name,
qc_total_weight,
qc_total_number,
total_fee,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
supplier_identity,
supplier_name,
supplier_source,
supplier_type,
receive_type,
qc_status,
status,
qc_type from $database.t_qc where 1=1"
}
import_t_qc_detial(){
import_data t_qc_detial " select id,
receive_identity,
receive_code,
order_identity,
order_code,
product_code,
product_name,
product_style,
company_code,
factory_code,
outsource_code,
piece_weight,
qc_weight,
qc_number,
qc_end,
qc_remark,
status,
eos_order_detail_id from $database.t_qc_detial where 1=1"
}
import_t_queue_factory(){
import_data t_queue_factory " select queue_name,
queue_value,
date_format(queue_date,'%Y-%m-%d %H:%i:%s') queue_date,
reset from $database.t_queue_factory where 1=1"
}
import_t_reason_dictionaries(){
import_data t_reason_dictionaries " select id,
reason_name,
type,
status,
reason_type from $database.t_reason_dictionaries where 1=1"
}
import_t_reason_dictionaries_harmful(){
import_data t_reason_dictionaries_harmful " select id,
name,
type,
status from $database.t_reason_dictionaries_harmful where 1=1"
}
import_t_receive_check_account(){
import_data t_receive_check_account " select id,
check_account_identity,
counter_name,
counter_identity,
start_weight,
end_weight,
today_weight,
reality_weight,
is_delete,
date_format(check_date,'%Y-%m-%d %H:%i:%s') check_date,
create_user,
surplus,
firm_offer from $database.t_receive_check_account where 1=1"
}
import_t_receive_check_account_detail(){
import_data t_receive_check_account_detail " select id,
check_account_identity,
counter_name,
counter_identity,
purity_name,
purity_identity,
start_weight,
end_weight,
today_weight,
reality_weight,
in_total_weight,
out_total_weight,
return_total_weight,
sz_in_weight,
sz_out_weight,
fz_in_weight,
fz_out_weight,
zx_in_weight,
zx_out_weight,
is_delete,
date_format(check_date,'%Y-%m-%d %H:%i:%s') check_date,
create_user,
surplus,
firm_offer,
yktz from $database.t_receive_check_account_detail where 1=1"
}
import_t_receive_detial(){
import_data t_receive_detial " select id,
receive_identity,
receive_code,
order_identity,
order_code,
product_photo,
product_code,
product_name,
product_style,
company_code,
factory_code,
outsource_code,
piece_weight,
order_number,
receive_number,
order_weight,
receive_weight,
receive_old_weight,
receive_old_number,
weight_percentage,
number_percentage,
work_fee,
total_work_fee,
date_format(estimate_time,'%Y-%m-%d %H:%i:%s') estimate_time,
is_check,
check_number,
check_weight,
over_reason,
qc_end,
qc_remark,
zj_end,
zj_remark,
eos_order_detail_id,
status,
zj_code,
technology_unit_price,
supplied_technology_unit_price,
color_gold_weight,
supplied_work_fee,
metal_color,
qc_number,
qc_weight,
if_check_return,
materials_spread,
is_examine,
add_price,
if_transfer_back,
genus_name,
attach_work_fee,
attach_work_fee_je,
label_price,
hz,
bqm,
allocation_status from $database.t_receive_detial where 1=1"
}
import_t_receive_detial_reword(){
import_data t_receive_detial_reword " select id,
reword_identity,
return_identity,
receive_identity,
order_identity,
receive_detial_id,
rework_num,
rework_weight,
check_return_number,
check_return_weight,
no_rework_num,
no_rework_weight,
val_status,
return_reason,
eos_order_detail_id,
qxth_identity from $database.t_receive_detial_reword where 1=1"
}
import_t_receive_detial_work_fee(){
import_data t_receive_detial_work_fee " select id,
receive_detail_id,
number,
weight,
quality_testing_number,
quality_testing_weight,
zj_number_receive,
zj_weight_receive,
zj_number_back,
zj_weight_back,
zj_weight_back_receive,
zj_number_back_receive,
other_number,
other_weight,
work_fee,
if_check_return,
return_total_number,
return_total_weight,
status,
work_fee_mc from $database.t_receive_detial_work_fee where 1=1"
}
import_t_receive_difference_detail(){
import_data t_receive_difference_detail " select id,
receive_identity,
receive_code,
order_identity,
replace(replace(replace(order_code,'\n',''),'\t',''),'\r','')  order_code,
receive_detial_id,
difference_type,
difference_type_desc,
old_number,
receive_number,
difference_number,
difference_number_change,
old_weight,
receive_weight,
difference_weight,
difference_weight_change,
difference_status,
difference_status_desc,
difference_attribution,
difference_attribution_desc,
difference_photo,
qc_receive_number,
qc_receive_weight,
return_type,
return_type_desc,
audit_result,
if_confirm_back,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
status from $database.t_receive_difference_detail where 1=1"
}
import_t_receive_eos_order_purity(){
import_data t_receive_eos_order_purity " select id,
purity_name,
purity_type,
status from $database.t_receive_eos_order_purity where 1=1"
}
import_t_receive_eos_order_records(){
import_data t_receive_eos_order_records " select id,
receive_code,
supplier_type,
order_number,
receive_number,
order_weight,
receive_weight,
receive_detail_id,
order_detail_id,
djbth,
djlsh,
date_format(receive_time,'%Y-%m-%d %H:%i:%s') receive_time,
date_format(audit_time,'%Y-%m-%d %H:%i:%s') audit_time,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
order_code from $database.t_receive_eos_order_records where 1=1"
}
import_t_receive_flgfbh(){
import_data t_receive_flgfbh " select id,
dj_lsh,
dj_bt_zdh,
dj_ft_zdh,
dj_st_zdh,
dj_state,
dj_count,
wdmc,
wdbm,
pxbm,
pxmc,
pxgf,
zdr,
zdrid,
date_format(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
shr,
shrid,
date_format(shsj,'%Y-%m-%d %H:%i:%s') shsj,
djzt,
gysmc,
gysbm,
zfr,
zfrid,
zfsj from $database.t_receive_flgfbh where 1=1"
}
import_t_receive_order(){
import_data t_receive_order " select id,
receive_identity,
order_identity from $database.t_receive_order where 1=1"
}
import_t_receive_payment_code_info(){
import_data t_receive_payment_code_info " select id,
payment_code,
payment_name,
product_photo from $database.t_receive_payment_code_info where 1=1"
}
import_t_receive_purity_mapping(){
import_data t_receive_purity_mapping " select id,
receive_purity_name,
purity_name,
status from $database.t_receive_purity_mapping where 1=1"
}
import_t_receive_status(){
import_data t_receive_status " select id,
number,
receive_style,
status from $database.t_receive_status where 1=1"
}
import_t_receive_stream_type(){
import_data t_receive_stream_type " select id,
type,
name from $database.t_receive_stream_type where 1=1"
}
import_t_sale_from_account(){
import_data t_sale_from_account " select id,
sale_account_identity,
sale_identity,
total_not_account,
total_ok_account,
total_price,
incoming_identity,
incoming_number,
incoming_weight,
return_identity,
return_number,
return_weight,
status from $database.t_sale_from_account where 1=1"
}
import_t_sale_summary_sync(){
import_data t_sale_summary_sync " select id,
djh,
customer_name,
customer_code,
order_weight,
purity_name,
date_format(zd_time,'%Y-%m-%d %H:%i:%s') zd_time,
network_name,
counter_name,
category_name,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
djlx from $database.t_sale_summary_sync where 1=1"
}
import_t_sales_return_detial(){
import_data t_sales_return_detial " select id,
receive_identity,
receive_code,
order_identity,
replace(replace(replace(order_code,'\n',''),'\t',''),'\r','')  order_code,
product_code,
outsource_code,
product_bar_code,
product_name,
product_style,
company_code,
factory_code,
piece_weight,
order_number,
receive_number,
order_weight,
receive_weight,
work_fee,
total_work_fee,
qc_weight,
qc_number,
qc_end,
qc_remark,
return_number,
return_weight,
return_reason,
purity_name,
supplier_identity,
supplier_name,
supplier_source,
supplier_type,
status,
return_identity,
return_code,
technology_unit_price,
total_technology_unit_price,
supplied_technology_unit_Price,
price,
supplied_work_fee,
if_check_return,
materials_spread,
receive_detial_id,
eos_order_detail_id,
detail_color,
label_price,
replace(replace(replace(img_url,'\n',''),'\t',''),'\r','')  img_url,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
check_number_all,
check_weight_all from $database.t_sales_return_detial where 1=1"
}
import_t_sales_return_this_count(){
import_data t_sales_return_this_count " select id,
return_identity,
return_code,
receive_identity,
receive_code,
receive_detail_id,
this_return_count,
this_return_weight,
receive_work_id from $database.t_sales_return_this_count where 1=1"
}
import_t_salesman(){
import_data t_salesman " select id,
salesman_identity,
is_leader,
user_id,
user_identity,
user_name,
phone_no,
busy_flag,
begin_out_date,
end_out_date,
act_salesman_id,
act_salesman_identity,
act_salesman_name,
showroom_id,
pub_openid,
showroom_identity,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
date_format(etl_dt,'%Y-%m-%d %H:%i:%s') etl_dt,
is_deleted,
job_id,
job_identity,
phone_no1,
pub_openid1,
salesman_depart_identity,
salesman_role_identity,
history_permission,
salesman_region,
region_leader from $database.t_salesman where 1=1"
}
import_t_salesman_area(){
import_data t_salesman_area " select id,
salesman_identity,
area_identity,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_salesman_area where 1=1"
}
import_t_salesman_depart(){
import_data t_salesman_depart " select id,
salesman_depart_identity,
salesman_depart_code,
salesman_depart_name,
father_depart_identity,
father_depart_code,
father_depart_name,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
update_date from $database.t_salesman_depart where 1=1"
}
import_t_salesman_log(){
import_data t_salesman_log " select id,
customer_id,
customer_identity,
showroom_identity,
salesman_id,
salesman_identity,
salesman_name,
react_type,
next_saleman_id,
next_saleman_identity,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
date_format(react_time,'%Y-%m-%d %H:%i:%s') react_time,
father_id,
showroom_code,
log_type,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
father_salesman_id,
father_salesman_name,
date_format(insert_time,'%Y-%m-%d %H:%i:%s') insert_time from $database.t_salesman_log where 1=1"
}
import_t_salesman_role(){
import_data t_salesman_role " select id,
salesman_role_identity,
salesman_role_code,
salesman_role_name,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
date_format(update_date,'%Y-%m-%d %H:%i:%s') update_date from $database.t_salesman_role where 1=1"
}
import_t_salesman_time_log(){
import_data t_salesman_time_log " select id,
salesman_id,
salesman_identity,
salesman_name,
date_format(begin_out_date,'%Y-%m-%d %H:%i:%s') begin_out_date,
date_format(end_out_date,'%Y-%m-%d %H:%i:%s') end_out_date,
act_salesman_id,
act_salesman_identity,
act_salesman_name,
date_format(etl_dt,'%Y-%m-%d %H:%i:%s') etl_dt from $database.t_salesman_time_log where 1=1"
}
import_t_salesman_time_out(){
import_data t_salesman_time_out " select id,
timeout_type,
timeout_code from $database.t_salesman_time_out where 1=1"
}
import_t_settlement_stay(){
import_data t_settlement_stay " select id,
settlement_stay_identity,
fast_package_identity,
fast_package_code,
stay_status,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
create_user,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_settlement_stay where 1=1"
}
import_t_showroom_counter_second(){
import_data t_showroom_counter_second " select id,
counter_name from $database.t_showroom_counter_second where 1=1"
}
import_t_showroom_storage_data(){
import_data t_showroom_storage_data " select showroom_name,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
purity_name,
yestoday_weight,
in_storage_weight,
remain_weight from $database.t_showroom_storage_data where 1=1"
}
import_t_singleton_inventory(){
import_data t_singleton_inventory " select id,
inventory_identity,
inventory_code,
showroom_name,
showroo_identity,
counter_name,
counter_identity,
purity_name,
purity_identity,
total_pieces,
label_price_total,
total_gold_weight,
date_format(inventory_date,'%Y-%m-%d %H:%i:%s') inventory_date,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
is_delete from $database.t_singleton_inventory where 1=1"
}
import_t_singleton_inventory_detailed(){
import_data t_singleton_inventory_detailed " select id,
inventory_detailed_identity,
inventory_identity,
product_package_no,
commodity_barcode,
warehouse_name,
additional_labor_cost,
weight,
category_name,
first_category,
secondary_category,
factory_model_no,
label_price,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
number,
is_delete,
project_key from $database.t_singleton_inventory_detailed where 1=1"
}
import_t_special_style_discount(){
import_data t_special_style_discount " select style_code,
style_discount,
is_enable from $database.t_special_style_discount where 1=1"
}
import_t_stored_procedure_status(){
import_data t_stored_procedure_status " select id,
stored_procedure_name,
execute_status from $database.t_stored_procedure_status where 1=1"
}
import_t_supplier(){
import_data t_supplier " select id,
supplier_identity,
supplier_source,
supplier_type,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_by,
status from $database.t_supplier where 1=1"
}
import_t_supplier_detial(){
import_data t_supplier_detial " select id,
supplier_name,
supplier_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
supplier_code,
customer_identity,
type,
djlsh from $database.t_supplier_detial where 1=1"
}
import_t_supplier_rebate(){
import_data t_supplier_rebate " select id,
supplier_identity,
supplier_name,
supplier_source,
rebate,
rebate_money,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
rebate_enable from $database.t_supplier_rebate where 1=1"
}
import_t_sync_time(){
import_data t_sync_time " select id,
code,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_sync_time where 1=1"
}
import_t_szpxgfjcbh(){
import_data t_szpxgfjcbh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
DJH,
WDBM,
WDMC,
CKBM,
CKMC,
PLBM,
ZJM,
PLMC,
EJPLBM,
EJPLMC,
EJPLZJM,
JBGF,
ZDRID,
ZDR,
date_format(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
XGRID,
XGR,
XGSJ from $database.t_szpxgfjcbh where 1=1"
}
import_t_temp_customer_trans_deducation_today(){
import_data t_temp_customer_trans_deducation_today " select customer_identity,
account_purity_name,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
debt_trans_code,
debt_type,
repay_trans_code,
deducation_amount from $database.t_temp_customer_trans_deducation_today where 1=1"
}
import_t_temp_customer_transform(){
import_data t_temp_customer_transform " select SOURCE,
DJLSH,
CUSTOMER_IDENTITY_999,
KHBM_999,
replace(replace(replace(KHMC_999,'\n',''),'\t',''),'\r','') KHMC_999,
replace(replace(replace(ZKH_999,'\n',''),'\t',''),'\r','')  ZKH_999,
CUSTOMER_IDENTITY,
KHBM,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
replace(replace(replace(ZKH,'\n',''),'\t',''),'\r','') ZKH,
TECH_PURITY_NAME from $database.t_temp_customer_transform where 1=1"
}
import_t_temp_customer_ysmxz(){
import_data t_temp_customer_ysmxz " select ysmxz_h_identity,
ysmxz_b_identity,
customer_identity,
wdmc,
khbm,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
replace(replace(replace(ZKH,'\n',''),'\t',''),'\r','') ZKH,
tech_purity_name,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
djm,
djh,
fs,
djje,
jjje,
gfje,
date_format(hkshrq,'%Y-%m-%d %H:%i:%s') hkshrq,
swlb from $database.t_temp_customer_ysmxz where 1=1"
}
import_t_temp_interest_adjust_money_record(){
import_data t_temp_interest_adjust_money_record " select append_date,
append_record_name,
djlsh,
out_customer_code,
append_amount,
append_fee,
in_customer_code from $database.t_temp_interest_adjust_money_record where 1=1"
}
import_t_temp_lllsz(){
import_data t_temp_lllsz " select wdmc,
customer_identity,
khbm,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
replace(replace(replace(ZKH,'\n',''),'\t',''),'\r','') ZKH,
tech_purity_name,
djm,
djh,
swlx,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
jz from $database.t_temp_lllsz where 1=1"
}
import_t_temp_trans_history(){
import_data t_temp_trans_history " select date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
khbm_old,
khbm,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
replace(replace(replace(ZKH,'\n',''),'\t',''),'\r','') ZKH,
customer_identity,
purity_name,
khbm_999,
replace(replace(replace(khmc_999,'\n',''),'\t',''),'\r','') khmc_999,
replace(replace(replace(zkh_999,'\n',''),'\t',''),'\r','') zkh_999,
djje,
djjz from $database.t_temp_trans_history where 1=1"
}
import_t_temp_ysmxz(){
import_data t_temp_ysmxz " select ysmxz_h_identity,
ysmxz_b_identity,
customer_identity,
wdmc,
khbm,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
replace(replace(replace(ZKH,'\n',''),'\t',''),'\r','') ZKH,
tech_purity_name,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
djm,
djh,
fs,
djje,
jjje,
gfje,
date_format(hkshrq,'%Y-%m-%d %H:%i:%s') hkshrq,
swlb from $database.t_temp_ysmxz where 1=1"
}
import_t_temp_ywy(){
import_data t_temp_ywy " select CZR,
CZRID,
je from $database.t_temp_ywy where 1=1"
}
import_t_tran_miss_package(){
import_data t_tran_miss_package " select djlsh,
fast_package_identity from $database.t_tran_miss_package where 1=1"
}
import_t_tykhgjb(){
import_data t_tykhgjb " select DjLsh,
DjBth,
DjState,
WDMC,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
KHBM,
replace(replace(replace(ZKH,'\n',''),'\t',''),'\r','') ZKH,
CSGS,
CRBS,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_tykhgjb where 1=1"
}
import_t_tykhgjh(){
import_data t_tykhgjh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
GSWD,
TYKHMC,
TYKHBM,
WHR,
ZHWHSJ,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_tykhgjh where 1=1"
}
import_t_wechat_pub(){
import_data t_wechat_pub " select id,
pub_identity,
openid,
nickname,
sex,
language,
country,
province,
city,
headimgurl,
phone,
create_user_id,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
date_format(modify_date,'%Y-%m-%d %H:%i:%s') modify_date from $database.t_wechat_pub where 1=1"
}
import_t_wechat_smallroutine(){
import_data t_wechat_smallroutine " select id,
smallroutine_identity,
openid,
nickname,
sex,
language,
country,
province,
city,
headimgurl,
phone,
create_user_id,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
date_format(modify_date,'%Y-%m-%d %H:%i:%s') modify_date from $database.t_wechat_smallroutine where 1=1"
}
import_t_wholesaling_category_info(){
import_data t_wholesaling_category_info " select id,
type_coding,
type_code,
type_name,
status,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_wholesaling_category_info where 1=1"
}
import_t_work_fee_detail(){
import_data t_work_fee_detail " select id,
work_fee_id,
fee_count,
subtotal,
fee_unit_price,
name from $database.t_work_fee_detail where 1=1"
}
case $1 in
"t_daily_interrest_err_log")
import_t_daily_interrest_err_log
;;
"t_daily_interrest_log")
import_t_daily_interrest_log
;;
"t_estimate_update_log")
import_t_estimate_update_log
;;
"t_history_data_move_log")
import_t_history_data_move_log
;;
"t_late_transfer_log")
import_t_late_transfer_log
;;
"t_login_log")
import_t_login_log
;;
"t_cpbszb_log")
import_t_cpbszb_log
;;
"t_cpbszh_log")
import_t_cpbszh_log
;;
"t_cover_customer_log")
import_t_cover_customer_log
;;
"t_wechat_message_log")
import_t_wechat_message_log
;;
"t_stored_procedure_log")
import_t_stored_procedure_log
;;
"t_splszh_log")
import_t_splszh_log
;;
"t_salesman_choose_log")
import_t_salesman_choose_log
;;
"t_download")
import_t_download
;;
"t_insert_log_fail")
import_t_insert_log_fail
;;
"t_b_menu")
import_t_b_menu
;;
"t_approve_record")
import_t_approve_record
;;
"rp_szztxsrb")
import_rp_szztxsrb
;;
"t_basic_purity")
import_t_basic_purity
;;
"t_bf_account_type_category")
import_t_bf_account_type_category
;;
"t_bf_allocate_transfer")
import_t_bf_allocate_transfer
;;
"t_bf_allocation_fee")
import_t_bf_allocation_fee
;;
"t_bf_allocation_fee_add_price")
import_t_bf_allocation_fee_add_price
;;
"t_bf_ancient_law_cus_discount")
import_t_bf_ancient_law_cus_discount
;;
"t_bf_ancient_law_cus_discount_detail")
import_t_bf_ancient_law_cus_discount_detail
;;
"t_bf_buy_cus_material_detail")
import_t_bf_buy_cus_material_detail
;;
"t_bf_change_purity")
import_t_bf_change_purity
;;
"t_bf_collect_money_account")
import_t_bf_collect_money_account
;;
"t_bf_collect_money_style")
import_t_bf_collect_money_style
;;
"t_bf_current_wholesale_gold_price")
import_t_bf_current_wholesale_gold_price
;;
"t_bf_current_wholesale_gold_price_history")
import_t_bf_current_wholesale_gold_price_history
;;
"t_bf_current_wholesale_gold_price_history_detail")
import_t_bf_current_wholesale_gold_price_history_detail
;;
"t_bf_cus_credit_receipt_detail")
import_t_bf_cus_credit_receipt_detail
;;
"t_bf_cus_debit_receipt_detail")
import_t_bf_cus_debit_receipt_detail
;;
"t_bf_cus_debit_receipt_record")
import_t_bf_cus_debit_receipt_record
;;
"t_bf_deliver_goods_from")
import_t_bf_deliver_goods_from
;;
"t_bf_deliver_goods_from_detail")
import_t_bf_deliver_goods_from_detail
;;
"t_bf_dzddydy")
import_t_bf_dzddydy
;;
"t_bf_financial_block_list")
import_t_bf_financial_block_list
;;
"t_bf_five_g_cus_discount")
import_t_bf_five_g_cus_discount
;;
"t_bf_gold_inlay_transfer_in")
import_t_bf_gold_inlay_transfer_in
;;
"t_bf_gold_inlay_transfer_in_detail")
import_t_bf_gold_inlay_transfer_in_detail
;;
"t_bf_gold_inlay_transfer_out")
import_t_bf_gold_inlay_transfer_out
;;
"t_bf_gold_inlay_transfer_out_detail")
import_t_bf_gold_inlay_transfer_out_detail
;;
"t_bf_gold_transfer_change")
import_t_bf_gold_transfer_change
;;
"t_bf_gold_transfer_change_detail")
import_t_bf_gold_transfer_change_detail
;;
"t_bf_gold_transfer_in_detail")
import_t_bf_gold_transfer_in_detail
;;
"t_bf_hard_gold_work_fee")
import_t_bf_hard_gold_work_fee
;;
"t_bf_initial_inventory_bill")
import_t_bf_initial_inventory_bill
;;
"t_bf_inlaid_metal_average_daily")
import_t_bf_inlaid_metal_average_daily
;;
"t_bf_interest_st_adj_item")
import_t_bf_interest_st_adj_item
;;
"t_bf_khlsedb")
import_t_bf_khlsedb
;;
"t_bf_material_explain")
import_t_bf_material_explain
;;
"t_bf_other_showroom_customer_block_list")
import_t_bf_other_showroom_customer_block_list
;;
"t_bf_pay_outsource_detail")
import_t_bf_pay_outsource_detail
;;
"t_bf_payment_order_detail")
import_t_bf_payment_order_detail
;;
"t_bf_purify_detail")
import_t_bf_purify_detail
;;
"t_bf_ready_money")
import_t_bf_ready_money
;;
"t_bf_remark")
import_t_bf_remark
;;
"t_bf_sales_ticket_print_zds")
import_t_bf_sales_ticket_print_zds
;;
"t_bf_sales_ticket_print_zds_detail")
import_t_bf_sales_ticket_print_zds_detail
;;
"t_bf_stock_transfer_bill_detail")
import_t_bf_stock_transfer_bill_detail
;;
"t_bf_temporary_money_form")
import_t_bf_temporary_money_form
;;
"t_bf_transfer_owed_work_fee_from")
import_t_bf_transfer_owed_work_fee_from
;;
"t_bf_transfer_owed_work_fee_input")
import_t_bf_transfer_owed_work_fee_input
;;
"t_bf_transfer_owed_work_fee_input_detail")
import_t_bf_transfer_owed_work_fee_input_detail
;;
"t_bf_transfer_type")
import_t_bf_transfer_type
;;
"t_bf_warehouse_type")
import_t_bf_warehouse_type
;;
"t_bf_weighing_form")
import_t_bf_weighing_form
;;
"t_bf_with_sign")
import_t_bf_with_sign
;;
"t_bf_xq_single_return")
import_t_bf_xq_single_return
;;
"t_bf_xq_single_return_detail")
import_t_bf_xq_single_return_detail
;;
"t_buyer")
import_t_buyer
;;
"t_category")
import_t_category
;;
"t_category_counter_info")
import_t_category_counter_info
;;
"t_category_labour")
import_t_category_labour
;;
"t_check_account")
import_t_check_account
;;
"t_check_account_detail")
import_t_check_account_detail
;;
"t_check_counter")
import_t_check_counter
;;
"t_check_quality_detial")
import_t_check_quality_detial
;;
"t_check_quality_status")
import_t_check_quality_status
;;
"t_child_customer_id_djbth")
import_t_child_customer_id_djbth
;;
"t_client_discount")
import_t_client_discount
;;
"t_counter_account")
import_t_counter_account
;;
"t_counter_account_5ga")
import_t_counter_account_5ga
;;
"t_counter_like")
import_t_counter_like
;;
"t_counter_message")
import_t_counter_message
;;
"t_cpbszb")
import_t_cpbszb
;;
"t_cpbszh")
import_t_cpbszh
;;
"t_custom_column")
import_t_custom_column
;;
"t_customer_account_debt_trans_detail")
import_t_customer_account_debt_trans_detail
;;
"t_customer_account_repay_trans_detail")
import_t_customer_account_repay_trans_detail
;;
"t_customer_account_save_owe_info")
import_t_customer_account_save_owe_info
;;
"t_customer_account_save_owe_info_history")
import_t_customer_account_save_owe_info_history
;;
"t_customer_buyer")
import_t_customer_buyer
;;
"t_customer_counter_fastout")
import_t_customer_counter_fastout
;;
"t_customer_discount")
import_t_customer_discount
;;
"t_customer_discount_detail")
import_t_customer_discount_detail
;;
"t_customer_discount_detail_hs")
import_t_customer_discount_detail_hs
;;
"t_customer_discount_hjxq_temp")
import_t_customer_discount_hjxq_temp
;;
"t_customer_discount_hs")
import_t_customer_discount_hs
;;
"t_customer_discount_kjxq_temp")
import_t_customer_discount_kjxq_temp
;;
"t_customer_discount_sync")
import_t_customer_discount_sync
;;
"t_customer_engrave")
import_t_customer_engrave
;;
"t_customer_exhibitsales_sync")
import_t_customer_exhibitsales_sync
;;
"t_customer_gemset_discount")
import_t_customer_gemset_discount
;;
"t_customer_gemset_discount_history")
import_t_customer_gemset_discount_history
;;
"t_customer_interest_detail")
import_t_customer_interest_detail
;;
"t_customer_interest_standard_info")
import_t_customer_interest_standard_info
;;
"t_customer_phone_cp")
import_t_customer_phone_cp
;;
"t_customer_repair")
import_t_customer_repair
;;
"t_customer_repair_detail")
import_t_customer_repair_detail
;;
"t_customer_salesman")
import_t_customer_salesman
;;
"t_customer_tag")
import_t_customer_tag
;;
"t_customer_trans_deducation_detail")
import_t_customer_trans_deducation_detail
;;
"t_customer_trans_detail_debt_amount")
import_t_customer_trans_detail_debt_amount
;;
"t_customer_trans_detail_debt_weight")
import_t_customer_trans_detail_debt_weight
;;
"t_customer_trans_detail_repay_amount")
import_t_customer_trans_detail_repay_amount
;;
"t_customer_trans_detail_repay_weight")
import_t_customer_trans_detail_repay_weight
;;
"t_customer_type")
import_t_customer_type
;;
"t_default_discount_mosaic")
import_t_default_discount_mosaic
;;
"t_delay_task")
import_t_delay_task
;;
"t_delay_task_detail")
import_t_delay_task_detail
;;
"t_deposit_jewelry")
import_t_deposit_jewelry
;;
"t_deposit_order")
import_t_deposit_order
;;
"t_deposit_setting")
import_t_deposit_setting
;;
"t_eos_fail")
import_t_eos_fail
;;
"t_eos_order")
import_t_eos_order
;;
"t_eos_order_detial")
import_t_eos_order_detial
;;
"t_fast_order")
import_t_fast_order
;;
"t_fast_order_purity")
import_t_fast_order_purity
;;
"t_fast_package_delete")
import_t_fast_package_delete
;;
"t_fast_package_engrave")
import_t_fast_package_engrave
;;
"t_fast_package_flowing")
import_t_fast_package_flowing
;;
"t_fast_package_i_plastic")
import_t_fast_package_i_plastic
;;
"t_fast_package_reason")
import_t_fast_package_reason
;;
"t_fast_package_record")
import_t_fast_package_record
;;
"t_fast_package_status")
import_t_fast_package_status
;;
"t_fast_package_tag")
import_t_fast_package_tag
;;
"t_fast_package_update_customer")
import_t_fast_package_update_customer
;;
"t_fast_technology_price")
import_t_fast_technology_price
;;
"t_finance_customer_info")
import_t_finance_customer_info
;;
"t_fjgfzkbb_sync")
import_t_fjgfzkbb_sync
;;
"t_fjgfzkbh_sync")
import_t_fjgfzkbh_sync
;;
"t_gemstone_attribute")
import_t_gemstone_attribute
;;
"t_genus")
import_t_genus
;;
"t_incoming_difference")
import_t_incoming_difference
;;
"t_incoming_maintain")
import_t_incoming_maintain
;;
"t_initial_package_update_customer")
import_t_initial_package_update_customer
;;
"t_initial_weight")
import_t_initial_weight
;;
"t_initial_weight_delete")
import_t_initial_weight_delete
;;
"t_initial_weight_record")
import_t_initial_weight_record
;;
"t_initial_weight_status")
import_t_initial_weight_status
;;
"t_ka_kxjczb")
import_t_ka_kxjczb
;;
"t_ka_llmxz_b")
import_t_ka_llmxz_b
;;
"t_ka_llmxz_h")
import_t_ka_llmxz_h
;;
"t_ka_lsedzb")
import_t_ka_lsedzb
;;
"t_ka_lsz_h")
import_t_ka_lsz_h
;;
"t_ka_mxz")
import_t_ka_mxz
;;
"t_ka_mxz_update")
import_t_ka_mxz_update
;;
"t_ka_spkcmxz")
import_t_ka_spkcmxz
;;
"t_ka_szdzsqdh_temp")
import_t_ka_szdzsqdh_temp
;;
"t_ka_szkhcqlxzz_b_history")
import_t_ka_szkhcqlxzz_b_history
;;
"t_ka_szkhcqlxzz_f")
import_t_ka_szkhcqlxzz_f
;;
"t_ka_szkhcqmx_b")
import_t_ka_szkhcqmx_b
;;
"t_ka_szkhcqmx_f")
import_t_ka_szkhcqmx_f
;;
"t_ka_xltj_b")
import_t_ka_xltj_b
;;
"t_ka_xltj_h")
import_t_ka_xltj_h
;;
"t_ka_yflmxz")
import_t_ka_yflmxz
;;
"t_ka_yfmxz")
import_t_ka_yfmxz
;;
"t_ka_yfrzzh")
import_t_ka_yfrzzh
;;
"t_ka_yhrq")
import_t_ka_yhrq
;;
"t_ka_ysmxz_s")
import_t_ka_ysmxz_s
;;
"t_ka_ysmxz_sold")
import_t_ka_ysmxz_sold
;;
"t_ka_zjlsz")
import_t_ka_zjlsz
;;
"t_ka_zjyez")
import_t_ka_zjyez
;;
"t_ka_ztkczz")
import_t_ka_ztkczz
;;
"t_kj_child_customer")
import_t_kj_child_customer
;;
"t_kj_customer")
import_t_kj_customer
;;
"t_material_price_rule")
import_t_material_price_rule
;;
"t_move_counter_detail")
import_t_move_counter_detail
;;
"t_package_delete_approve")
import_t_package_delete_approve
;;
"t_package_engrave_tag")
import_t_package_engrave_tag
;;
"t_package_stay_weight_customer")
import_t_package_stay_weight_customer
;;
"t_packing_paper")
import_t_packing_paper
;;
"t_physical_counter")
import_t_physical_counter
;;
"t_print_log")
import_t_print_log
;;
"t_product_basic_info")
import_t_product_basic_info
;;
"t_product_fee")
import_t_product_fee
;;
"t_product_model_basic")
import_t_product_model_basic
;;
"t_product_model_discount")
import_t_product_model_discount
;;
"t_product_model_fee")
import_t_product_model_fee
;;
"t_province_salesman")
import_t_province_salesman
;;
"t_purity_engrave")
import_t_purity_engrave
;;
"t_purity_tag")
import_t_purity_tag
;;
"t_qc")
import_t_qc
;;
"t_qc_detial")
import_t_qc_detial
;;
"t_queue_factory")
import_t_queue_factory
;;
"t_reason_dictionaries")
import_t_reason_dictionaries
;;
"t_reason_dictionaries_harmful")
import_t_reason_dictionaries_harmful
;;
"t_receive_check_account")
import_t_receive_check_account
;;
"t_receive_check_account_detail")
import_t_receive_check_account_detail
;;
"t_receive_detial")
import_t_receive_detial
;;
"t_receive_detial_reword")
import_t_receive_detial_reword
;;
"t_receive_detial_work_fee")
import_t_receive_detial_work_fee
;;
"t_receive_difference_detail")
import_t_receive_difference_detail
;;
"t_receive_eos_order_purity")
import_t_receive_eos_order_purity
;;
"t_receive_eos_order_records")
import_t_receive_eos_order_records
;;
"t_receive_flgfbh")
import_t_receive_flgfbh
;;
"t_receive_order")
import_t_receive_order
;;
"t_receive_payment_code_info")
import_t_receive_payment_code_info
;;
"t_receive_purity_mapping")
import_t_receive_purity_mapping
;;
"t_receive_status")
import_t_receive_status
;;
"t_receive_stream_type")
import_t_receive_stream_type
;;
"t_sale_from_account")
import_t_sale_from_account
;;
"t_sale_summary_sync")
import_t_sale_summary_sync
;;
"t_sales_return_detial")
import_t_sales_return_detial
;;
"t_sales_return_this_count")
import_t_sales_return_this_count
;;
"t_salesman")
import_t_salesman
;;
"t_salesman_area")
import_t_salesman_area
;;
"t_salesman_depart")
import_t_salesman_depart
;;
"t_salesman_log")
import_t_salesman_log
;;
"t_salesman_role")
import_t_salesman_role
;;
"t_salesman_time_log")
import_t_salesman_time_log
;;
"t_salesman_time_out")
import_t_salesman_time_out
;;
"t_settlement_stay")
import_t_settlement_stay
;;
"t_showroom_counter_second")
import_t_showroom_counter_second
;;
"t_showroom_storage_data")
import_t_showroom_storage_data
;;
"t_singleton_inventory")
import_t_singleton_inventory
;;
"t_singleton_inventory_detailed")
import_t_singleton_inventory_detailed
;;
"t_special_style_discount")
import_t_special_style_discount
;;
"t_stored_procedure_status")
import_t_stored_procedure_status
;;
"t_supplier")
import_t_supplier
;;
"t_supplier_detial")
import_t_supplier_detial
;;
"t_supplier_rebate")
import_t_supplier_rebate
;;
"t_sync_time")
import_t_sync_time
;;
"t_szpxgfjcbh")
import_t_szpxgfjcbh
;;
"t_temp_customer_trans_deducation_today")
import_t_temp_customer_trans_deducation_today
;;
"t_temp_customer_transform")
import_t_temp_customer_transform
;;
"t_temp_customer_ysmxz")
import_t_temp_customer_ysmxz
;;
"t_temp_interest_adjust_money_record")
import_t_temp_interest_adjust_money_record
;;
"t_temp_lllsz")
import_t_temp_lllsz
;;
"t_temp_trans_history")
import_t_temp_trans_history
;;
"t_temp_ysmxz")
import_t_temp_ysmxz
;;
"t_temp_ywy")
import_t_temp_ywy
;;
"t_tran_miss_package")
import_t_tran_miss_package
;;
"t_tykhgjb")
import_t_tykhgjb
;;
"t_tykhgjh")
import_t_tykhgjh
;;
"t_wechat_pub")
import_t_wechat_pub
;;
"t_wechat_smallroutine")
import_t_wechat_smallroutine
;;
"t_wholesaling_category_info")
import_t_wholesaling_category_info
;;
"t_work_fee_detail")
import_t_work_fee_detail
;;
"all")
import_t_daily_interrest_err_log
import_t_daily_interrest_log
import_t_estimate_update_log
import_t_history_data_move_log
import_t_late_transfer_log
import_t_login_log
import_t_cpbszb_log
import_t_cpbszh_log
import_t_cover_customer_log
import_t_wechat_message_log
import_t_stored_procedure_log
import_t_splszh_log
import_t_salesman_choose_log
import_t_download
import_t_insert_log_fail
import_t_b_menu
import_t_approve_record
import_rp_szztxsrb
import_t_basic_purity
import_t_bf_account_type_category
import_t_bf_allocate_transfer
import_t_bf_allocation_fee
import_t_bf_allocation_fee_add_price
import_t_bf_ancient_law_cus_discount
import_t_bf_ancient_law_cus_discount_detail
import_t_bf_buy_cus_material_detail
import_t_bf_change_purity
import_t_bf_collect_money_account
import_t_bf_collect_money_style
import_t_bf_current_wholesale_gold_price
import_t_bf_current_wholesale_gold_price_history
import_t_bf_current_wholesale_gold_price_history_detail
import_t_bf_cus_credit_receipt_detail
import_t_bf_cus_debit_receipt_detail
import_t_bf_cus_debit_receipt_record
import_t_bf_deliver_goods_from
import_t_bf_deliver_goods_from_detail
import_t_bf_dzddydy
import_t_bf_financial_block_list
import_t_bf_five_g_cus_discount
import_t_bf_gold_inlay_transfer_in
import_t_bf_gold_inlay_transfer_in_detail
import_t_bf_gold_inlay_transfer_out
import_t_bf_gold_inlay_transfer_out_detail
import_t_bf_gold_transfer_change
import_t_bf_gold_transfer_change_detail
import_t_bf_gold_transfer_in_detail
import_t_bf_hard_gold_work_fee
import_t_bf_initial_inventory_bill
import_t_bf_inlaid_metal_average_daily
import_t_bf_interest_st_adj_item
import_t_bf_khlsedb
import_t_bf_material_explain
import_t_bf_other_showroom_customer_block_list
import_t_bf_pay_outsource_detail
import_t_bf_payment_order_detail
import_t_bf_purify_detail
import_t_bf_ready_money
import_t_bf_remark
import_t_bf_sales_ticket_print_zds
import_t_bf_sales_ticket_print_zds_detail
import_t_bf_stock_transfer_bill_detail
import_t_bf_temporary_money_form
import_t_bf_transfer_owed_work_fee_from
import_t_bf_transfer_owed_work_fee_input
import_t_bf_transfer_owed_work_fee_input_detail
import_t_bf_transfer_type
import_t_bf_warehouse_type
import_t_bf_weighing_form
import_t_bf_with_sign
import_t_bf_xq_single_return
import_t_bf_xq_single_return_detail
import_t_buyer
import_t_category
import_t_category_counter_info
import_t_category_labour
import_t_check_account
import_t_check_account_detail
import_t_check_counter
import_t_check_quality_detial
import_t_check_quality_status
import_t_child_customer_id_djbth
import_t_client_discount
import_t_counter_account
import_t_counter_account_5ga
import_t_counter_like
import_t_counter_message
import_t_cpbszb
import_t_cpbszh
import_t_custom_column
import_t_customer_account_debt_trans_detail
import_t_customer_account_repay_trans_detail
import_t_customer_account_save_owe_info
import_t_customer_account_save_owe_info_history
import_t_customer_buyer
import_t_customer_counter_fastout
import_t_customer_discount
import_t_customer_discount_detail
import_t_customer_discount_detail_hs
import_t_customer_discount_hjxq_temp
import_t_customer_discount_hs
import_t_customer_discount_kjxq_temp
import_t_customer_discount_sync
import_t_customer_engrave
import_t_customer_exhibitsales_sync
import_t_customer_gemset_discount
import_t_customer_gemset_discount_history
import_t_customer_interest_detail
import_t_customer_interest_standard_info
import_t_customer_phone_cp
import_t_customer_repair
import_t_customer_repair_detail
import_t_customer_salesman
import_t_customer_tag
import_t_customer_trans_deducation_detail
import_t_customer_trans_detail_debt_amount
import_t_customer_trans_detail_debt_weight
import_t_customer_trans_detail_repay_amount
import_t_customer_trans_detail_repay_weight
import_t_customer_type
import_t_default_discount_mosaic
import_t_delay_task
import_t_delay_task_detail
import_t_deposit_jewelry
import_t_deposit_order
import_t_deposit_setting
import_t_eos_fail
import_t_eos_order
import_t_eos_order_detial
import_t_fast_order
import_t_fast_order_purity
import_t_fast_package_delete
import_t_fast_package_engrave
import_t_fast_package_flowing
import_t_fast_package_i_plastic
import_t_fast_package_reason
import_t_fast_package_record
import_t_fast_package_status
import_t_fast_package_tag
import_t_fast_package_update_customer
import_t_fast_technology_price
import_t_finance_customer_info
import_t_fjgfzkbb_sync
import_t_fjgfzkbh_sync
import_t_gemstone_attribute
import_t_genus
import_t_incoming_difference
import_t_incoming_maintain
import_t_initial_package_update_customer
import_t_initial_weight
import_t_initial_weight_delete
import_t_initial_weight_record
import_t_initial_weight_status
import_t_ka_kxjczb
import_t_ka_llmxz_b
import_t_ka_llmxz_h
import_t_ka_lsedzb
import_t_ka_lsz_h
import_t_ka_mxz
import_t_ka_mxz_update
import_t_ka_spkcmxz
import_t_ka_szdzsqdh_temp
import_t_ka_szkhcqlxzz_f
import_t_ka_szkhcqmx_b
import_t_ka_szkhcqmx_f
import_t_ka_xltj_b
import_t_ka_xltj_h
import_t_ka_yflmxz
import_t_ka_yfmxz
import_t_ka_yfrzzh
import_t_ka_yhrq
import_t_ka_ysmxz_s
import_t_ka_ysmxz_sold
import_t_ka_zjlsz
import_t_ka_zjyez
import_t_ka_ztkczz
import_t_kj_child_customer
import_t_kj_customer
import_t_material_price_rule
import_t_move_counter_detail
import_t_package_delete_approve
import_t_package_engrave_tag
import_t_package_stay_weight_customer
import_t_packing_paper
import_t_physical_counter
import_t_print_log
import_t_product_basic_info
import_t_product_fee
import_t_product_model_basic
import_t_product_model_discount
import_t_product_model_fee
import_t_province_salesman
import_t_purity_engrave
import_t_purity_tag
import_t_qc
import_t_qc_detial
import_t_queue_factory
import_t_reason_dictionaries
import_t_reason_dictionaries_harmful
import_t_receive_check_account
import_t_receive_check_account_detail
import_t_receive_detial
import_t_receive_detial_reword
import_t_receive_detial_work_fee
import_t_receive_difference_detail
import_t_receive_eos_order_purity
import_t_receive_eos_order_records
import_t_receive_flgfbh
import_t_receive_order
import_t_receive_payment_code_info
import_t_receive_purity_mapping
import_t_receive_status
import_t_receive_stream_type
import_t_sale_from_account
import_t_sale_summary_sync
import_t_sales_return_detial
import_t_sales_return_this_count
import_t_salesman
import_t_salesman_area
import_t_salesman_depart
import_t_salesman_log
import_t_salesman_role
import_t_salesman_time_log
import_t_salesman_time_out
import_t_settlement_stay
import_t_showroom_counter_second
import_t_showroom_storage_data
import_t_singleton_inventory
import_t_singleton_inventory_detailed
import_t_special_style_discount
import_t_stored_procedure_status
import_t_supplier
import_t_supplier_detial
import_t_supplier_rebate
import_t_sync_time
import_t_szpxgfjcbh
import_t_temp_customer_trans_deducation_today
import_t_temp_customer_transform
import_t_temp_customer_ysmxz
import_t_temp_interest_adjust_money_record
import_t_temp_lllsz
import_t_temp_trans_history
import_t_temp_ysmxz
import_t_temp_ywy
import_t_tran_miss_package
import_t_tykhgjb
import_t_tykhgjh
import_t_wechat_pub
import_t_wechat_smallroutine
import_t_wholesaling_category_info
import_t_work_fee_detail
;;
esac
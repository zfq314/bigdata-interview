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
	$sqoop import \
    -D mapred.job.queue.name=hive \
	--driver com.mysql.cj.jdbc.Driver \
	--connect "jdbc:mysql://10.2.12.47:3306/decent_cloud?tinyInt1isBit=false&zerodatetimebehavior=converttonull&serverTimezone=GMT%2B8&&useSSL=false&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=utf-8" \
	--fields-terminated-by "\t" \
	--username $user \
    --password $passwd \
	--delete-target-dir \
    --null-string '\\N' \
	--null-non-string '\\N' \
	--target-dir /decent_cloud_database/$1/$do_date \
	--delete-target-dir \
	--num-mappers 1 \
	--fields-terminated-by "\t" \
	--query "$2"' and  $CONDITIONS'
}
import_rp_szztxsrb(){
import_data rp_szztxsrb " select 
DATE_FORMAT(record_date,'%Y-%m-%d') record_date,
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
fjgf from $database.rp_szztxsrb where 1=1 and date(record_date)>='$do_date'"
}
import_t_approve_record(){
import_data t_approve_record " select 
id,
approve_type,
data_id,
from_name,
table_name,
create_user,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_approve_record where 1=1 and date(create_time)>='$do_date'"
}
import_t_b_menu(){
import_data t_b_menu " select 
id,
name,
path,
type,
is_default,
sort,
is_show from $database.t_b_menu where 1=1"
}
import_t_basic_purity(){
import_data t_basic_purity " select id,
basic_purity_identity,
basic_purity_name
 from $database.t_basic_purity where 1=1"
}
import_t_bf_account_type_category(){
import_data t_bf_account_type_category " select 
id,
account_type_category_code,
account_type_category_identity,
account_type_category_name,
work_fee,
effective_date,
status,
type,
rq from $database.t_bf_account_type_category where 1=1"
}
import_t_bf_allocate_transfer(){
import_data t_bf_allocate_transfer " select 
id,
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
replace(replace(remark,'\n',''),'\t','') remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
rq from $database.t_bf_allocate_transfer where 1=1"
}
import_t_bf_allocation_fee(){
import_data t_bf_allocation_fee " select 
id,
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
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
cost,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_allocation_fee where 1=1"
}
import_t_bf_allocation_fee_add_price(){
import_data t_bf_allocation_fee_add_price " select 
id,
allocation_fee_identity,
start_price,
end_price,
price,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_allocation_fee_add_price where 1=1"
}
import_t_bf_ancient_law_cus_discount(){
import_data t_bf_ancient_law_cus_discount " select 
id,
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
replace(replace(remark,'\n',''),'\t','') remark,
unit_batch_price,
transfer_owed_diff_price,
create_by,
create_by_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
update_by_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_ancient_law_cus_discount where 1=1"
}
import_t_bf_ancient_law_cus_discount_detail(){
import_data t_bf_ancient_law_cus_discount_detail " select 
id,
cus_discount_identity,
cus_discount_detail_identity,
first_genus_identity,
first_genus_name,
second_genus_identity,
second_genus_name,
base_work_fee,
other_work_fee,
batch_price,
status from $database.t_bf_ancient_law_cus_discount_detail where 1=1 and cus_discount_identity in (select cus_discount_identity from t_bf_ancient_law_cus_discount where DATE(create_time)>='$do_date')"
}
import_t_bf_area(){
import_data t_bf_area " select 
id,
area_identity,
area_code,
area_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
showroom_name,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_area where 1=1"
}
import_t_bf_bank_deposit_bill_sz(){
import_data t_bf_bank_deposit_bill_sz " select 
id,
bank_eposit_identity,
bank_eposit_code,
showroom_code,
showroom_name,
cus_debit_code,
total_price,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_bf_bank_deposit_bill_sz where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_bank_deposit_bill_sz_detail(){
import_data t_bf_bank_deposit_bill_sz_detail " select 
id,
bank_eposit_detail_identity,
bank_eposit_identity,
ckfs,
zcyh,
zczh,
zchm,
crwd,
crwdbm,
crfs,
cryh,
cryhbm,
crhm,
crzh,
cryhgs,
je,
replace(replace(BZ,'\n',''),'\t','') bz,
cwsh from $database.t_bf_bank_deposit_bill_sz_detail where 1=1 and bank_eposit_identity in (select bank_eposit_identity from t_bf_bank_deposit_bill_sz where DATE(approve_time)>='$do_date')"
}
import_t_bf_buy_cus_item(){
import_data t_bf_buy_cus_item " select 
id,
buy_cus_item_identity,
buy_cus_item_code,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
approve_status,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
showroom_name,
counter_identity,
replace(replace(remark,'\n',''),'\t','') remark,
customer_identity,
parent_customer_identity,
total_number,
total_weight,
total_label_price,
total_price,
record_book_by,
DATE_FORMAT(record_book_time,'%Y-%m-%d %H:%i:%s') record_book_time,
credit_code,
record_book_status,
business_type,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
print_count,
tech_purity_name,
tech_purity_code,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_buy_cus_item where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_buy_cus_item_detail(){
import_data t_bf_buy_cus_item_detail " select 
id,
buy_cus_item_detail_identity,
buy_cus_item_identity,
purity_identity,
number,
weight,
work_fee,
label_price,
unit_price,
work_fee_price,
if_update_work_fee,
price,
basic_work_fee,
basic_work_fee_price,
additional_work_fee,
additional_work_fee_price,
gold_price,
gold_income,
gold_stone_code,
gold_stone_name from $database.t_bf_buy_cus_item_detail where 1=1 and buy_cus_item_identity in(select buy_cus_item_identity from t_bf_buy_cus_item where DATE(approve_time)>='$do_date') "
}
import_t_bf_buy_cus_material(){
import_data t_bf_buy_cus_material " select 
id,
buy_cus_code,
buy_cus_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
showroom_name,
counter_identity,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
total_gold_weight,
replace(replace(remark,'\n',''),'\t','') remark,
customer_identity,
parent_customer_identity,
total_price,
customer_credit,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
tech_purity_name,
tech_purity_code,
print_count,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_buy_cus_material where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_buy_cus_material_detail(){
import_data t_bf_buy_cus_material_detail " select 
id,
buy_cus_detail_identity,
buy_cus_identity,
purity_identity,
gold_weight,
price,
unit_price from $database.t_bf_buy_cus_material_detail where 1=1 and buy_cus_identity in (select buy_cus_identity from t_bf_buy_cus_material WHERE DATE(approve_time)>='$do_date' )"
}
import_t_bf_buyback_material(){
import_data t_bf_buyback_material " select 
id,
settlement_code,
settlement_time,
settlement_date,
settlement_type,
showroom_name,
genus_name,
purity_name,
customer_identity,
parent_customer_identity,
settlement_weight,
settlement_unit_price,
settlement_price,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
replace(replace(remarks,'\n',''),'\t','') remarks,
area,
approve_status,
inlaid,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_buyback_material where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_change_purity(){
import_data t_bf_change_purity " select 
id,
change_purity_code,
change_purity_identity,
showroom_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remark,'\n',''),'\t','') remark,
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
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_change_purity where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_collect_money_account(){
import_data t_bf_collect_money_account " select 
id,
showroom_name,
bank_name,
bank_code,
bank_card,
replace(replace(remark,'\n',''),'\t','') remark,
is_delete,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
bank_belonging,
zhmc,
zhzh,
zhlx from $database.t_bf_collect_money_account where 1=1"
}
import_t_bf_collect_money_style(){
import_data t_bf_collect_money_style " select 
id,
collect_money_style,
collect_money_code,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_collect_money_style where 1=1"
}
import_t_bf_current_wholesale_gold_price(){
import_data t_bf_current_wholesale_gold_price " select 
id,
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
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_current_wholesale_gold_price where 1=1"
}
import_t_bf_current_wholesale_gold_price_history(){
import_data t_bf_current_wholesale_gold_price_history " select 
id,
current_wholesale_history_identity,
showroom_identity,
create_by,
create_by_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
approve_by_name,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_current_wholesale_gold_price_history where 1=1"
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
status
 from $database.t_bf_current_wholesale_gold_price_history_detail where 1=1"
}
import_t_bf_cus_credit_receipt(){
import_data t_bf_cus_credit_receipt " select 
id,
cus_credit_receipt_identity,
cus_credit_receipt_code,
showroom_name,
customer_identity,
parent_customer_identity,
total_price,
replace(replace(remark,'\n',''),'\t','') remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
approve_status,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
borrow_money,
withdraw_money,
credit_code,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
tech_purity_name,
tech_purity_code from $database.t_bf_cus_credit_receipt where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_cus_credit_receipt_detail(){
import_data t_bf_cus_credit_receipt_detail " select 
id,
cus_credit_receipt_detail_identity,
cus_credit_receipt_identity,
collect_money_style,
bank,
price,
replace(replace(remark,'\n',''),'\t','')  remark from $database.t_bf_cus_credit_receipt_detail where 1=1 and cus_credit_receipt_identity in (select cus_credit_receipt_identity from t_bf_cus_credit_receipt where DATE(approve_time)>='$do_date')"
}
import_t_bf_cus_debit_receipt(){
import_data t_bf_cus_debit_receipt " select 
id,
cus_debit_identity,
cus_debit_code,
customer_identity,
parent_customer_identity,
showroom_name,
receivable_price,
receivable_gold_weight,
reduced_price,
reference_price,
total_price,
total_receivable_price,
replace(replace(remark,'\n',''),'\t','')  remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
today_sell_price,
today_received_price,
yestoday_receivable_price,
today_settle,
sell_price,
today_price,
history_price,
verify_material_price,
verify_sell_price,
service_charge,
free_of_interest,
rate_of_interest,
DATE_FORMAT(debt_time,'%Y-%m-%d %H:%i:%s') debt_time,
yestoday_price_date,
yestoday_price,
DATE_FORMAT(practical_price_time,'%Y-%m-%d %H:%i:%s')practical_price_time,
month_rate_of_interest,
raw_material_identity,
price,
disburser_one,
disburser_number_one,
disburser_two,
disburser_number_two,
status,
price999,
price9999,
price99999,
price18k,
price22k,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
tech_purity_name,
tech_purity_code from $database.t_bf_cus_debit_receipt where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_cus_debit_receipt_detail(){
import_data t_bf_cus_debit_receipt_detail " select 
id,
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
money_order_card from $database.t_bf_cus_debit_receipt_detail where 1=1 and cus_debit_identity in (select cus_debit_identity from t_bf_cus_debit_receipt where DATE(approve_time)>='$do_date')"
}
import_t_bf_cus_debit_receipt_record(){
import_data t_bf_cus_debit_receipt_record " select 
id,
recoed_sale_identity,
other_identity,
sale_code,
sale_name,
DATE_FORMAT(sale_time,'%Y-%m-%d %H:%i:%s') sale_time,
sale_type,
customer_identity,
parent_customer_identity,
sale_price,
this_price,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
csmc,
ysjzf,
bchxje,
syysje,
yslsh,
ysbth,
khzjm,
wfje from $database.t_bf_cus_debit_receipt_record where 1=1 and date(rq)>='$do_date'"
}
import_t_bf_cust_return_jewelry(){
import_data t_bf_cust_return_jewelry " select 
id,
return_code,
return_identity,
date_this,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
source_counter_name,
source_counter_identity,
customer_identity,
customer_code,
if_child,
parent_customer_identity,
child_customer_seq,
purity_identity,
gold_price_amount_sum,
number_of_objects_sum,
work_fee_amount_sum,
gold_weight_sum,
replace(replace(remark,'\n',''),'\t','')  remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
if_show_remark,
if_outside,
if_five_g,
print_count,
area,
amount_sum,
xq_code,
pay_no_amount,
pay_ok_amount,
process_type,
status,
gold_avg_price,
form_total_amount,
customer_base_code,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_cust_return_jewelry where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_cust_return_jewelry_detail(){
import_data t_bf_cust_return_jewelry_detail " select 
id,
return_identity,
return_detail_identity,
gold_weight,
work_fee_type,
transfer_owed_identity,
default_work_fee,
purity_identity,
purity_name,
first_product_style,
first_product_style_identity,
second_product_style,
second_product_style_identity,
number_of_objects,
base_work_fee,
base_work_fee_amount,
attach_work_fee,
attach_work_fee_amount,
source_attach_work_fee,
hang_out_unit_price,
hang_out_fee,
return_work_fee_sub_total,
label_price,
content,
gold_price_amount,
deduction_product_weight,
remain_gold_weight,
if_update_work_fee_amount,
replace(replace(remark,'\n',''),'\t','')  remark,
work_fee_discount,
other_price,
if_update_discount,
status,
transfer_owed_diff_price,
material_explain_name,
transfer_owed_diff_price_total,
gold_price,
small_base_work_fee,
large_base_work_fee,
unit_price from $database.t_bf_cust_return_jewelry_detail where 1=1 and return_identity in (select return_identity from t_bf_cust_return_jewelry where DATE(approve_time)>='$do_date')"
}
import_t_bf_customer_the_bill(){
import_data t_bf_customer_the_bill " select 
id,
customer_the_bill_code,
customer_the_bill_identity,
showroom_name,
out_customer_identity,
out_parent_customer_identity,
financial_settlement_time,
adjust_weight,
adjust_month_price,
adjust_capital,
replace(replace(remark,'\n',''),'\t','')  remark,
in_customer_identity,
in_parent_customer_identity,
inner_customer_identity,
inner_customer_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
interest_adjustments,
status,
financial_client_code,
financial_client_name,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
out_tech_purity_name,
out_tech_purity_code,
in_tech_purity_name,
in_tech_purity_code from $database.t_bf_customer_the_bill where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_deliver_goods_from(){
import_data t_bf_deliver_goods_from " select 
id,
deliver_goods_code,
deliver_goods_identity,
area,
refer_to_start_date,
refer_to_end_date,
if_no_mine_company,
if_franchisee,
purity_identity,
showroom_identity,
customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
total_number,
total_gold_weight,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remark,'\n',''),'\t','')  remark,
collection_company,
gross_weight,
package_number,
delivery_by_first,
delivery_by_second,
sign_for,
sign_status,
date_this,
print_by,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count from $database.t_bf_deliver_goods_from where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_deliver_goods_from_detail(){
import_data t_bf_deliver_goods_from_detail " select 
id,
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
replace(replace(remark,'\n',''),'\t','')  remark,
status from $database.t_bf_deliver_goods_from_detail where 1=1 and deliver_goods_identity in (select deliver_goods_identity from t_bf_deliver_goods_from where DATE(approve_time)>='$do_date')"
}
import_t_bf_dkhhy_b(){
import_data t_bf_dkhhy_b " select 
bid,
dkhhy_b_identity,
dkhhy_h_identity,
wdmc,
customer_identity,
parent_customer_identity,
zkhbs,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user_id,
create_user_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_user_id,
update_user_name,
djlsh,
djbth,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
id from $database.t_bf_dkhhy_b where 1=1 and date(update_time)>='$do_date'"
}
import_t_bf_dkhhy_h(){
import_data t_bf_dkhhy_h " select 
id,
dkhhy_h_identity,
showroom_name,
customer_identity,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user_id,
create_user_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_user_id,
update_user_name,
djlsh,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
status from $database.t_bf_dkhhy_h where 1=1 and date(update_time)>='$do_date'"
}
import_t_bf_dzddydy(){
import_data t_bf_dzddydy " select 
id,
dzddydy_identity,
wdmc,
customer_identity,
khbm,
khmc,
zkh,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
qzqkje,
qzqlzl,
sjqkje,
sjqlzl,
wjqkje,
wjqlzl,
wyid from $database.t_bf_dzddydy where 1=1 and date(rq)>='$do_date'"
}
import_t_bf_financial_block_list(){
import_data t_bf_financial_block_list " select 
id,
financial_block_list_code,
financial_block_list_identity,
showroom_name,
customer_type,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_financial_block_list where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_five_g_cus_discount(){
import_data t_bf_five_g_cus_discount " select 
id,
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
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
update_by_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
replace(replace(remark,'\n',''),'\t','')  remark,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_five_g_cus_discount where 1=1 and date(update_time)>='$do_date'"
}
import_t_bf_gold_inlay_transfer_in(){
import_data t_bf_gold_inlay_transfer_in " select 
id,
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
replace(replace(remark,'\n',''),'\t','')  remark,
total_work_fee,
total_stone_weight,
wxqx,
purity_name,
ztdbjsj,
jxydblx,
yyyxh,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
settlement_approve,
status,
eos_head_key,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
DATE_FORMAT(out_time,'%Y-%m-%d %H:%i:%s') out_time,
receive_id from $database.t_bf_gold_inlay_transfer_in where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_gold_inlay_transfer_in_detail(){
import_data t_bf_gold_inlay_transfer_in_detail " select 
id,
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
replace(replace(remark,'\n',''),'\t','')  remark,
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
receive_detail_id from $database.t_bf_gold_inlay_transfer_in_detail where 1=1 and inlay_transfer_in_identity in (select inlay_transfer_in_identity from t_bf_gold_inlay_transfer_in where DATE(approve_time)>='$do_date')"
}
import_t_bf_gold_inlay_transfer_out(){
import_data t_bf_gold_inlay_transfer_out " select 
id,
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
replace(replace(remark,'\n',''),'\t','')  remark,
total_work_fee,
total_stone_weight,
wxqx,
purity_name,
ztdbjsj,
jxydblx,
yyyxh,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
DATE_FORMAT(out_time,'%Y-%m-%d %H:%i:%s') out_time,
receive_id,
transfer_type from $database.t_bf_gold_inlay_transfer_out where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_gold_inlay_transfer_out_detail(){
import_data t_bf_gold_inlay_transfer_out_detail " select 
id,
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
replace(replace(remark,'\n',''),'\t','')  remark,
transfer_type,
type_code,
series_name,
outside,
goods_weight,
processing_charges,
jp,
ztdbjsjb,
receive_id,
receive_detail_id from $database.t_bf_gold_inlay_transfer_out_detail where 1=1 and inlay_transfer_out_identity in (select inlay_transfer_out_identity from t_bf_gold_inlay_transfer_out where DATE(approve_time)>='$do_date')"
}
import_t_bf_gold_transfer_change(){
import_data t_bf_gold_transfer_change " select 
id,
inlay_change_identity,
inlay_change_code,
transfer_out_showroom,
transfer_out_counter_name,
transfer_out_counter_identity,
transfer_in_showroom,
transfer_in_counter_name,
transfer_in_counter_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
total_number,
total_weight,
total_label_price,
purity_name,
dydf,
DATE_FORMAT(out_time,'%Y-%m-%d %H:%i:%s') out_time,
transfer_in_code,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_gold_transfer_change where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_gold_transfer_change_detail(){
import_data t_bf_gold_transfer_change_detail " select 
id,
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
DATE_FORMAT(out_time,'%Y-%m-%d %H:%i:%s') out_time from $database.t_bf_gold_transfer_change_detail where 1=1 and inlay_change_identity in (select inlay_change_identity from t_bf_gold_transfer_change where DATE(approve_time)>='$do_date')"
}
import_t_bf_gold_transfer_in(){
import_data t_bf_gold_transfer_in " select 
id,
transfer_in_code,
transfer_out_code,
transfer_out_identity,
transfer_in_identity,
transfer_out_showroom,
transfer_out_counter_name,
transfer_out_counter_identity,
transfer_in_showroom,
transfer_in_counter_name,
transfer_in_counter_identity,
purity_name,
genus_name,
exhibition_type,
technology_type,
total_number,
total_label_price,
total_weight,
total_price,
total_additional_labour_price,
replace(replace(remark,'\n',''),'\t','')  remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
if_print_remark,
status,
crdj,
eos_head_key,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
DATE_FORMAT(out_time,'%Y-%m-%d %H:%i:%s') out_time,
print_count,
receive_id,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_gold_transfer_in where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_gold_transfer_in_detail(){
import_data t_bf_gold_transfer_in_detail " select 
id,
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
replace(replace(remark,'\n',''),'\t','')  remark,
unit_price,
eos_body_key,
discount_work_fee,
receive_id,
receive_detail_id from $database.t_bf_gold_transfer_in_detail where 1=1 and transfer_in_identity in (select transfer_in_identity from t_bf_gold_transfer_in where date(approve_time)>='$do_date' )"
}
import_t_bf_gold_transfer_out(){
import_data t_bf_gold_transfer_out " select 
id,
transfer_out_code,
transfer_out_identity,
transfer_out_showroom,
transfer_out_counter_name,
transfer_out_counter_identity,
transfer_in_showroom,
transfer_in_counter_name,
transfer_in_counter_identity,
purity_name,
genus_name,
exhibition_type,
technology_type,
total_number,
total_label_price,
total_weight,
total_price,
total_additional_labour_price,
replace(replace(remark,'\n',''),'\t','')  remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
if_print_remark,
is_print,
status,
DATE_FORMAT(shipments_date,'%Y-%m-%d') shipments_date,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
DATE_FORMAT(drrq,'%Y-%m-%d %H:%i:%s') drrq,
print_count,
receive_id,
transfer_type,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time,
scan_status,
DATE_FORMAT(scan_time,'%Y-%m-%d %H:%i:%s') scan_time,
sacn_by from $database.t_bf_gold_transfer_out where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_gold_transfer_out_detail(){
import_data t_bf_gold_transfer_out_detail " select 
id,
transfer_out_identity,
transfer_out_detail_identity,
product_code,
transfer_style,
first_category_name,
second_category_name,
number,
weight,
basic_price,
additional_labour_price,
price,
label_price,
transfer_type,
rllx,
replace(replace(remark,'\n',''),'\t','')  remark,
if_update_price,
xsfjgf,
discount_work_fee,
discount_price,
unit_price,
htm,
average_cost,
receive_id,
receive_detail_id from $database.t_bf_gold_transfer_out_detail where 1=1 and transfer_out_identity in (select transfer_out_identity from t_bf_gold_transfer_out where date(approve_time)>='$do_date')"
}
import_t_bf_gold_transfer_out_print(){
import_data t_bf_gold_transfer_out_print " select 
id,
gold_transfer_out_print_identity,
gold_transfer_out_print_code,
genus_name,
purity_name,
transfer_out_showroom,
transfer_in_showroom,
transfer_in_counter_name,
total_number,
total_label_price,
total_weight,
total_price,
total_additional_labour_price,
DATE_FORMAT(deliver_goods_time,'%Y-%m-%d %H:%i:%s') deliver_goods_time,
replace(replace(remark,'\n',''),'\t','')  remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s')  create_time,
approve_by,
dycs,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s')  approve_time,
approve_status,
batch_setting_basic_price,
status,
bthshj,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
total_unit_price,
print_count,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_gold_transfer_out_print where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_gold_transfer_out_print_detail(){
import_data t_bf_gold_transfer_out_print_detail " select 
id,
transfer_out_print_identity,
transfer_out_code,
transfer_out_detail_print_identity,
transfer_out_counter_name,
transfer_in_showroom,
transfer_in_counter_name,
genus_name,
category_name,
number,
weight,
additional_labour_price,
basic_price,
price,
label_price,
old_price,
transfer_type,
transfer_style,
xsfjgf,
discount_work_fee,
discount_price,
product_code,
replace(replace(remark,'\n',''),'\t','')  remark,
unit_price,
old_basic_price,
add_basic_price,
transfer_out_detail_identity from $database.t_bf_gold_transfer_out_print_detail where 1=1 and transfer_out_print_identity in (select transfer_out_print_identity from t_bf_gold_transfer_out_print where date(approve_time)>='$do_date')"
}
import_t_bf_hard_gold_work_fee(){
import_data t_bf_hard_gold_work_fee " select 
id,
hard_gold_work_fee_identity,
showroom_identity,
customer_identity,
customer_code,
child_customer_seq,
help_code,
if_child,
parent_customer_identity,
parent_customer_code,
create_by,
create_by_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
update_by_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
replace(replace(remark,'\n',''),'\t','')  remark,
default_work_fee,
transfer_owed_diff_price,
if_used,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_hard_gold_work_fee where 1=1 and date(update_time)>='$do_date'"
}
import_t_bf_initial_inventory_bill(){
import_data t_bf_initial_inventory_bill " select 
id,
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
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remarks,'\n',''),'\t','')  remarks,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
status from $database.t_bf_initial_inventory_bill where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_inlaid_metal_average_daily(){
import_data t_bf_inlaid_metal_average_daily " select 
id,
average_daily_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s')  create_time,
inlaid_metal_code,
average_daily,
DATE_FORMAT(date,'%Y-%m-%d') date,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_inlaid_metal_average_daily where 1=1 and date(rq)>='$do_date'"
}
import_t_bf_interest_st_adj_item(){
import_data t_bf_interest_st_adj_item " select 
id,
adjust_item_identity,
showroom_name,
day_rate,
interest_free_days,
DATE_FORMAT(contract_date,'%Y-%m-%d')  contract_date,
storage_fee,
month_extension_time,
rated_sales,
interest_free_gold_weight,
storage_fee_term,
effective_date,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
category_info_code,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
customer_type,
customer_type_code,
tech_purity_name,
tech_purity_code,
payment_days,
overday_rate from $database.t_bf_interest_st_adj_item where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_khlsedb(){
import_data t_bf_khlsedb " select 
id,
khlsedb_identity,
djh,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdbm,
wdmch,
customer_identity,
PARENT_customer_identity,
lsed,
zkh,
zdrid,
zdr,
DATE_FORMAT(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
shrid,
shr,
DATE_FORMAT(shsj,'%Y-%m-%d %H:%i:%s') shsj,
lsjz,
jjj,
spdh,
approve_status,
status from $database.t_bf_khlsedb where 1=1 and date(rq)>='$do_date'"
}
import_t_bf_material_explain(){
import_data t_bf_material_explain " select 
id,
material_explain_identity,
material_explain_code,
material_explain_name,
type_code,
type_name,
status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
if_convert from $database.t_bf_material_explain where 1=1 and date(update_time)>=$do_date"
}
import_t_bf_other_showroom_customer_block_list(){
import_data t_bf_other_showroom_customer_block_list " select 
id,
other_showroom_customer_block_code,
other_showroom_customer_block_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_other_showroom_customer_block_list where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_pay_cus_material(){
import_data t_bf_pay_cus_material " select 
id,
pay_cus_code,
pay_cus_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
showroom_name,
counter_identity,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
total_gold_weight,
total_price,
gold_average_price,
replace(replace(remark,'\n',''),'\t','')  remark,
customer_identity,
parent_customer_identity,
customer_credit,
allow_sale,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
tech_purity_name,
tech_purity_code,
print_count,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_pay_cus_material where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_pay_cus_material_detail(){
import_data t_bf_pay_cus_material_detail " select 
id,
pay_cus_detail_identity,
pay_cus_identity,
purity_identity,
gold_weight,
replace(replace(remarks,'\n',''),'\t','')  remarks from $database.t_bf_pay_cus_material_detail where 1=1 and pay_cus_identity in (select pay_cus_identity from t_bf_pay_cus_material where date(approve_time)>='$do_date')"
}
import_t_bf_pay_outsource(){
import_data t_bf_pay_outsource " select 
id,
pay_outsource_identity,
pay_outsource_code,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
counter_name,
counter_identity,
total_gold_weight,
today_return_weight,
today_pay_weight,
today_put_weight,
replace(replace(remark,'\n',''),'\t','') remark,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
tech_purity_name,
tech_purity_code,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_pay_outsource where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_pay_outsource_detail(){
import_data t_bf_pay_outsource_detail " select 
id,
pay_outsource_detail_identity,
pay_outsource_identity,
pay_purity_name,
pay_gold_weight,
replace(replace(remark,'\n',''),'\t','')  remark from $database.t_bf_pay_outsource_detail where 1=1 and pay_outsource_identity in (select pay_outsource_identity from t_bf_pay_outsource where date(approve_time)>='$do_date')"
}
import_t_bf_payment_order(){
import_data t_bf_payment_order " select 
id,
payment_order_code,
payment_order_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remark,'\n',''),'\t','')  remark,
total_payment,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
tech_purity_code,
tech_purity_name from $database.t_bf_payment_order where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_payment_order_detail(){
import_data t_bf_payment_order_detail " select 
id,
payment_order_identity,
payment_order_detail_identity,
payment_name,
payment_identity,
bank_name,
bank_identity,
price,
replace(replace(remark,'\n',''),'\t','')  remark from $database.t_bf_payment_order_detail where 1=1 and  payment_order_identity in (select payment_order_identity from t_bf_payment_order where date(approve_time)>='$do_date')"
}
import_t_bf_purify_detail(){
import_data t_bf_purify_detail " select 
id,
purify_detail_identity,
purify_identity,
purity_name,
material_explain,
percent_start,
percent_end,
purity_price,
if_convert from $database.t_bf_purify_detail where 1=1"
}
import_t_bf_raw_material(){
import_data t_bf_raw_material " select 
id,
raw_material_code,
raw_material_identity,
raw_material_time,
showroom_name,
customer_identity,
parent_customer_identity,
temporary_money_identity,
temporary_money_code,
neight,
price,
replace(replace(remark,'\n',''),'\t','') remark,
old_material,
meterial999,
meterial9999,
meterial99999,
meteria18k,
meteria22k,
price999,
price9999,
price99999,
price18k,
price22k,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_raw_material where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_ready_money(){
import_data t_bf_ready_money " select 
id,
purity_name,
purity_identity,
work_fee_type,
work_fee,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_ready_money where 1=1 and date(rq)>='$do_date'"
}
import_t_bf_receive_meterial(){
import_data t_bf_receive_meterial " select id,
receive_meterial_identity,
DATE_FORMAT(record_date,'%Y-%m-%d') record_date,
receive_meterial_code,
showroom_code,
showroom_name,
receive_gold_weight,
sum_amount,
sales_no,
area_name,
is_convert,
show_memo,
today_sale_gold_weith,
is_customer_meterial,
today_customer_receive_weight,
amount_paid,
amount_unpaid,
print_qty,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remarks,'\n',''),'\t','')  remarks,
remaining_gold_weight_total,
letter_codes,
gold_price,
total_transactions,
status,
is_before_date_receive,
real_receive_date,
counter_identity,
counter_code,
counter_name,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
customer39_weight,
customer49_weight,
customer59_weight,
customer18k_weight,
customer22k_weight,
customer_codes,
tech_purity_name,
tech_purity_code,
print_count,
s39,
s49,
s59,
c39,
c49,
c59,
c5g
 from $database.t_bf_receive_meterial where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_receive_meterial_detail(){
import_data t_bf_receive_meterial_detail " select 
id,
receive_meterial_detail_identity,
receive_meterial_identity,
line,
purity_name,
material_explain_name,
incoming_gold_weight,
percentage,
material_content,
day_of_gold,
purify_amount,
purify_expense,
amount,
replace(replace(remarks,'\n',''),'\t','') remarks,
the_convert_costs,
the_convert_amount,
material_gold_weight,
remaining_gold_weight,
purity_identity,
material_explain_code,
convert_purity_name,
convert_gold_weight,
cor_material_fee,
cor_material_fee_amount,
category_name,
category_code from $database.t_bf_receive_meterial_detail where 1=1 and receive_meterial_identity in (select receive_meterial_identity from t_bf_receive_meterial where date(approve_time)>='$do_date')"
}
import_t_bf_remark(){
import_data t_bf_remark " select 
id,
remark_identity,
remark_code,
remark_name,
remark_help_code,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_remark where 1=1 and date(update_time)>='$do_date'" 
}
import_t_bf_repair(){
import_data t_bf_repair " select 
id,
repair_code,
repair_identity,
repair_type,
sale_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
owe_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
gold_weight,
price,
money,
replace(replace(remarks,'\n',''),'\t','') remarks,
status,
sale_code,
tech_purity_name,
tech_purity_code,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
purity_name,
purity_code,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_repair where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_retreat(){
import_data t_bf_retreat " select 
id,
retreat_code,
retreat_identity,
sale_identity,
retreat_type,
showroom_name,
customer_identity,
parent_customer_identity,
DATE_FORMAT(owe_time,'%Y-%m-%d %H:%i:%s') owe_time,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
gold_weight,
price,
money,
replace(replace(remarks,'\n',''),'\t','') remarks,
status,
sale_code,
tech_purity_name,
tech_purity_code,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
purity_name,
purity_code,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_retreat where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_sales_ticket_print_zds(){
import_data t_bf_sales_ticket_print_zds " select 
id,
print_zds_identity,
jsjzhj,
khllysje,
khtsyfje,
sales_ticket_print_zds_code,
bzh,
csmch,
plmch,
qtfy,
fysm,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
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
create_time,
customer_identity,
parent_customer_identity,
status,
print_count,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_sales_ticket_print_zds where 1=1 and date(rq)>='$do_date'"
}
import_t_bf_sales_ticket_print_zds_detail(){
import_data t_bf_sales_ticket_print_zds_detail " select 
id,
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
yjpl from $database.t_bf_sales_ticket_print_zds_detail where 1=1 and print_zds_identity in (select print_zds_identity from t_bf_sales_ticket_print_zds where date(rq)>='$do_date')"
}
import_t_bf_settlement(){
import_data t_bf_settlement " select 
id,
inlaid,
settlement_time,
settlement_type,
showroom_name,
genus_name,
purity_name,
customer_identity,
parent_customer_identity,
settlement_weight,
settlement_unit_price,
settlement_price,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
replace(replace(remarks,'\n',''),'\t','')  remarks,
area,
settlement_code,
approve_status,
settlement_date,
customer_coding,
customer_no,
purity_code,
genus_code,
showroom_identity,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_settlement where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_settlement_adjustment_price(){
import_data t_bf_settlement_adjustment_price " select 
id,
settlement_adjustment_price_identity,
settlement_adjustment_price_code,
purity_identity,
purity_name,
category_name,
genus_name,
full_gold_price,
other_price,
basic_work_fee,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_settlement_adjustment_price where 1=1 and date(update_time)>='$do_date'"
}
import_t_bf_stock_transfer_bill(){
import_data t_bf_stock_transfer_bill " select 
id,
stock_transfer_identity,
stock_transfer_code,
DATE_FORMAT(date,'%Y-%m-%d') date,
showroom_code,
showroom_name,
settlement_type,
out_counter_identity,
out_purity_identity,
out_purity_name,
into_counter_identity,
amount_gold_weight,
number_electronic_scale,
transfer_instructions,
transfer_type,
product_package_no,
amount_tag_price,
in_purity_identity,
in_purity_name,
into_stock_fineness_name,
into_stock_fineness_code,
fiveD_tag,
bookkeeping_by,
bookkeeping_time,
bookkeeping_status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remarks,'\n',''),'\t','') remarks,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
status,
is_sysgen,
relation_code from $database.t_bf_stock_transfer_bill where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_stock_transfer_bill_detail(){
import_data t_bf_stock_transfer_bill_detail " select 
id,
stock_transfer_detail_identity,
stock_transfer_identity,
sequence,
bar_code,
number_of_packages,
gold_weight,
content,
tag_price,
stock_gold_weight,
replace(replace(remarks,'\n',''),'\t','') remarks,
transfer_type,
coding,
out_expenses,
in_expenses,
category_code,
category_name,
purity_code,
purity_name from $database.t_bf_stock_transfer_bill_detail where 1=1 and stock_transfer_identity in (select stock_transfer_identity from t_bf_stock_transfer_bill where date(approve_time)>='$do_date')"
}
import_t_bf_stock_transfer_bill_detail_hw(){
import_data t_bf_stock_transfer_bill_detail_hw " select 
id,
stock_transfer_detail_identity,
stock_transfer_identity,
sequence,
bar_code,
number_of_packages,
gold_weight,
content,
tag_price,
stock_gold_weight,
replace(replace(remarks,'\n',''),'\t','') remarks,
transfer_type,
coding,
out_expenses,
in_expenses,
category_code,
category_name,
purity_code,
purity_name from $database.t_bf_stock_transfer_bill_detail_hw where 1=1 "
}
import_t_bf_stock_transfer_bill_hw(){
import_data t_bf_stock_transfer_bill_hw " select 
id,
stock_transfer_identity,
stock_transfer_code,
DATE_FORMAT(date,'%Y-%m-%d') date,
showroom_code,
showroom_name,
settlement_type,
out_counter_identity,
out_purity_identity,
out_purity_name,
into_counter_identity,
amount_gold_weight,
number_electronic_scale,
transfer_instructions,
transfer_type,
product_package_no,
amount_tag_price,
in_purity_identity,
in_purity_name,
into_stock_fineness_name,
into_stock_fineness_code,
fiveD_tag,
bookkeeping_by,
bookkeeping_time,
bookkeeping_status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remarks,'\n',''),'\t','') remarks,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
status from $database.t_bf_stock_transfer_bill_hw where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_szztgzspd(){
import_data t_bf_szztgzspd " select 
id,
h_identity,
wdmc,
djhm,
DATE_FORMAT(xdrq,'%Y-%m-%d') xdrq,
DATE_FORMAT(gzrq,'%Y-%m-%d') gzrq,
tykhbm,
tykhmc,
customer_identity,
parent_customer_identity,
bzsm,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
cancellation,
status,
xqjs,
xqjz,
xqje,
yjjz,
yjje,
qzjz,
qzje,
wzjz,
wzje,
wjjz,
wjje,
wgjz,
wgje,
gfjz,
gfje,
zjwqjz,
zjwqje,
gfwzjz,
gfwzje,
qzccjjz,
qzccjje,
wzccjjz,
wzccjje,
jys,
gzzt,
gzzt_status,
gzrid,
gzrm,
DATE_FORMAT(gzsj,'%Y-%m-%d %H:%i:%s')  gzsj,
zfrid,
zfrm,
zfsj,
qy,
qzds,
wzds,
yjds,
xqds,
wjds,
wgds,
gfjds,
zjwqds,
gfwzds,
qzccjds,
wzccjds from $database.t_bf_szztgzspd where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_szztgzspd_detail(){
import_data t_bf_szztgzspd_detail " select 
id,
sale_code,
b_identity,
h_identity,
customer_identity,
parent_customer_identity,
purity_identity,
csgs,
js,
jz,
zje,
bzsm from $database.t_bf_szztgzspd_detail where 1=1 and h_identity in (select h_identity from t_bf_szztgzspd where date(approve_time)>='$do_date')"
}
import_t_bf_temporary_money_form(){
import_data t_bf_temporary_money_form " select 
id,
temporary_money_code,
temporary_money_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
print_time_code,
credit_gold_weight,
credit_total_price,
DATE_FORMAT(contract_time,'%Y-%m-%d %H:%i:%s') contract_time,
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
replace(replace(remark,'\n',''),'\t','') remark,
salesman,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
bdze,
zcqkts,
dzhyhf from $database.t_bf_temporary_money_form where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_the_bill(){
import_data t_bf_the_bill " select 
id,
the_bill_code,
the_bill_identity,
showroom_name,
customer_identity,
parent_customer_identity,
inner_customer_identity,
inner_customer_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remark,'\n',''),'\t','') remark,
DATE_FORMAT(financial_settlement_time,'%Y-%m-%d %H:%i:%s') financial_settlement_time,
adjust_weight,
adjust_month_price,
adjust_capital,
status,
salesman,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
tech_purity_name,
tech_purity_code,
adjust_type,
adjust_interest from $database.t_bf_the_bill where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_transfer_owed_work_fee_from(){
import_data t_bf_transfer_owed_work_fee_from " select 
id,
transfer_owed_code,
transfer_owed_help_code,
transfer_owed_identity,
work_fee_type,
replace(replace(remark,'\n',''),'\t','') remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
purity_identity,
purity_name,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
purity_code from $database.t_bf_transfer_owed_work_fee_from where 1=1 and date(update_time)>='$do_date'"
}
import_t_bf_transfer_owed_work_fee_input(){
import_data t_bf_transfer_owed_work_fee_input " select 
id,
work_fee_input_code,
work_fee_input_identity,
showroom_identity,
customer_code,
customer_identity,
parent_customer_code,
parent_customer_identity,
child_customer_seq,
replace(replace(remark,'\n',''),'\t','') remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
rq from $database.t_bf_transfer_owed_work_fee_input where 1=1 and date(update_time)>='$do_date'"
}
import_t_bf_transfer_owed_work_fee_input_detail(){
import_data t_bf_transfer_owed_work_fee_input_detail " select 
id,
work_fee_input_identity,
work_fee_input_detail_identity,
purity_identity,
purity_name,
transfer_owed_identity,
work_fee_type,
work_fee,
status from $database.t_bf_transfer_owed_work_fee_input_detail where 1=1 and work_fee_input_identity in (select work_fee_input_identity from t_bf_transfer_owed_work_fee_input where date(rq)>='$do_date') "
}
import_t_bf_transfer_type(){
import_data t_bf_transfer_type " select 
id,
code,
name,
status from $database.t_bf_transfer_type where 1=1"
}
import_t_bf_warehouse_type(){
import_data t_bf_warehouse_type " select 
id,
warehouse_type_identity,
warehouse_type_code,
warehouse_type_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
status from $database.t_bf_warehouse_type where 1=1 and date(update_time)>='$do_date'"
}
import_t_bf_with_sign(){
import_data t_bf_with_sign " select 
id,
with_sign_code,
with_sign_name,
with_sign_identity,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_with_sign where 1=1"
}
import_t_bf_xq_single_return(){
import_data t_bf_xq_single_return " select 
id,
xq_single_return_identity,
xq_single_return_code,
DATE_FORMAT(open_date,'%Y-%m-%d %H:%i:%s') open_date,
DATE_FORMAT(date_this,'%Y-%m-%d %H:%i:%s') date_this,
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
detail_address,
replace(replace(remark,'\n',''),'\t','') remark,
counter_identity,
counter_name,
package_i_small_code,
create_by,
create_by_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
approve_by_name,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
total_return_work_fee from $database.t_bf_xq_single_return where 1=1 and date(approve_time)>='$do_date'"
}
import_t_bf_xq_single_return_detail(){
import_data t_bf_xq_single_return_detail " select 
id,
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
replace(replace(remark,'\n',''),'\t','') remark,
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
account_date,
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
status from $database.t_bf_xq_single_return_detail where 1=1 and xq_single_return_identity in (select xq_single_return_identity from t_bf_xq_single_return where date(approve_time)>='$do_date')"
}
import_t_buyer(){
import_data t_buyer " select 
id,
buyer_identity,
wechat_desc,
buyer_name,
create_date,
openid,
phone from $database.t_buyer where 1=1"
}
import_t_category(){
import_data t_category " select 
id,
category_identity,
category_code,
category_name,
category_help_code,
parent_id,
parent_identity,
deep_level,
path_str,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
pic_url,
code_seq from $database.t_category where 1=1 and date(modify_date)>='$do_date'"
}
import_t_category_counter_info(){
import_data t_category_counter_info " select 
id,
showroom_name,
counter_identity,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
category_info_code from $database.t_category_counter_info where 1=1 and date(update_time)>='$do_date'"
}
import_t_category_labour(){
import_data t_category_labour " select 
id,
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
import_data t_check_account " select 
id,
counter_name,
counter_identity,
weight,
number,
price,
eos_weight,
eos_number,
eos_price,
DATE_FORMAT(check_date,'%Y-%m-%d %H:%i:%s') check_date,
create_user,
check_diff_user from $database.t_check_account where 1=1 and date(check_date)>='$do_date'"
}
import_t_check_account_detail(){
import_data t_check_account_detail " select 
id,
counter_name,
counter_identity,
weight,
number,
price,
DATE_FORMAT(check_date,'%Y-%m-%d %H:%i:%s') check_date,
create_user from $database.t_check_account_detail where 1=1 and date(check_date)>='$do_date'"
}
import_t_check_counter(){
import_data t_check_counter " select 
id,
counter_name,
counter_identity,
xh,
type,
purity_identity from $database.t_check_counter where 1=1"
}
import_t_check_quality_detial(){
import_data t_check_quality_detial " select 
id,
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
replace(replace(remark,'\n',''),'\t','') remark,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_check_quality_detial where 1=1 and date(create_time)>='$do_date'"
}
import_t_check_quality_status(){
import_data t_check_quality_status " select 
id,
number,
check_style,
status from $database.t_check_quality_status where 1=1"
}
import_t_child_customer(){
import_data t_child_customer " select 
id,
customer_id,
customer_identity,
child_customer_identity,
child_customer_name,
child_customer_code,
child_customer_seq,
contact_name,
phone_no,
phone_no_b,
customer_address,
help_code,
active_flag,
legal_person,
id_code,
province,
data_date,
ty_customer_code,
djlsh,
djbth,
license_code,
license_desc,
license_range,
DATE_FORMAT(license_time,'%Y-%m-%d %H:%i:%s') license_time from $database.t_child_customer where 1=1"
}
import_t_child_customer_id_djbth(){
import_data t_child_customer_id_djbth " select 
id,
djbth from $database.t_child_customer_id_djbth where 1=1"
}
import_t_client_discount(){
import_data t_client_discount " select 
id,
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
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
is_enable,
eos_head_key,
eos_body_key from $database.t_client_discount where 1=1 and date(update_time)>='$do_date'"
}
import_t_columns(){
import_data t_columns " select 
id,
project_type,
subject_type,
subject_name,
column_code,
column_name,
column_width,
order_no,
del_flag,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_columns where 1=1 and date(update_time)>='$do_date'"
}
import_t_counter_account(){
import_data t_counter_account " select 
id,
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
data_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
content,
replace(replace(remark,'\n',''),'\t','') remark from $database.t_counter_account where 1=1 and date(create_date)>='$do_date'"
}
import_t_counter_account_5ga(){
import_data t_counter_account_5ga " select 
id,
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
data_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
content,
replace(replace(remark,'\n',''),'\t','') remark from $database.t_counter_account_5ga where 1=1 and date(create_date)>='$do_date'"
}
import_t_counter_like(){
import_data t_counter_like " select 
id,
fast_package_id,
fast_package_identity,
customer_id,
custoer_identity,
showroom_counter_id,
showroom_counter_identity,
counter_user_id,
counter_user_identity,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
like_values,
replace(replace(remark,'\n',''),'\t','') remark from $database.t_counter_like where 1=1 and date(modify_date)>='$do_date'"
}
import_t_counter_message(){
import_data t_counter_message " select 
id,
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
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
replace(replace(remarks,'\n',''),'\t','') remarks,
product_code,
is_scand from $database.t_counter_message where 1=1 and date(create_time)>='$do_date'"
}
import_t_cover_customer_log(){
import_data t_cover_customer_log " select 
id,
operate_id,
operate_name,
DATE_FORMAT(operate_time,'%Y-%m-%d %H:%i:%s') operate_time,
operate_msg from $database.t_cover_customer_log where 1=1 and date(operate_time)>='$do_date'"
}
import_t_cpbszb(){
import_data t_cpbszb " select 
DjLsh,
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
DATE_FORMAT(etl_dt,'%Y-%m-%d %H:%i:%s') etl_dt from $database.t_cpbszb where 1=1 and date(etl_dt)>='$do_date'"
}
import_t_cpbszb_log(){
import_data t_cpbszb_log " select 
id,
DjBth,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
status,
DjLsh,
package_i_identity,
package_i_code,
fast_package_identity,
xh from $database.t_cpbszb_log where 1=1 and date(create_time)>='$do_date'"
}
import_t_cpbszh(){
import_data t_cpbszh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
XSZKH,
wdmc,
djh,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdbm,
khbm,
csmc,
khmc,
ZKHBM,
ZKHBH,
ZKH,
YWY,
lxr,
KHZJM,
zjz,
dz,
replace(replace(BZ,'\n',''),'\t','') bz,
zdrid,
zdr,
DATE_FORMAT(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
shr,
DATE_FORMAT(shsj,'%Y-%m-%d %H:%i:%s') shsj,
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
DATE_FORMAT(ZFRQ,'%Y-%m-%d') ZFRQ,
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
DATE_FORMAT(KDRQ,'%Y-%m-%d %H:%i:%s') KDRQ,
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
DATE_FORMAT(etl_dt,'%Y-%m-%d %H:%i:%s') etl_dt,
order_identity,
package_code from $database.t_cpbszh where 1=1 and date(zdsj)>='$do_date'"
}
import_t_cpbszh_log(){
import_data t_cpbszh_log " select 
id,
DjLsh,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
fast_package_identity,
order_identity,
package_code,
status,
sales_order,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
sales_type,
salesman_identity,
kdsj from $database.t_cpbszh_log where 1=1 and date(update_time)>='$do_date'"
}
import_t_cpbszh_log_detail(){
import_data t_cpbszh_log_detail " select 
id,
djlsh,
fast_package_identity,
sales_order,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
sales_type,
salesman_identity from $database.t_cpbszh_log_detail where 1=1 and date(update_time)>='$do_date'"
}
import_t_custom_column(){
import_data t_custom_column " select 
id,
column_id,
project_type,
subject_type,
subject_name,
col,
column_name,
column_width,
order_no,
login_user,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_by,
iz_selected,
iz_disable,
del_flag from $database.t_custom_column where 1=1 and date(update_time)>='$do_date'"
}
import_t_customer(){
import_data t_customer " select 
id,
customer_identity,
input_type,
active_flag,
subject_code,
customer_code,
customer_name,
customer_short_name,
bank_name,
bank_account,
tax_amount,
address,
phone_no,
fax_no,
web_url,
help_code,
legal_person,
id_code,
position,
mobile_phone,
office_phone,
email,
create_user_code,
create_user_ame,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
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
branch_type,
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
sex,
is_five,
customer_card_code,
DATE_FORMAT(contract_begin_date,'%Y-%m-%d %H:%i:%s') contract_begin_date,
DATE_FORMAT(contract_end_date,'%Y-%m-%d %H:%i:%s') contract_end_date,
alliance_amount,
brand_amount,
deposit_amount,
mobile_phone1,
license_desc,
shop_short_name,
customer_debt_name,
test_customer_type,
is_child,
uniq_id,
is_finance,
license_code,
license_range,
license_time,
customer_class,
position_name,
company_nature,
registered_capital,
year_sale_amount,
nature_code,
nature_name,
brand_code,
brand_name,
references_customer,
child_customer,
spec_events_day,
wechat_no,
interest,
buyer_name,
buyer_sex,
buyer_id_code,
buyer_mobile_no,
buyer_position,
delivery_name,
delivery_sex,
delivery_id_code,
delivery_mobile_no,
delivery_position,
authorization_date,
receive_address,
is_display,
customer_type,
of_area,
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
data_date,
ty_customer_code,
purity_name,
customer_classification,
djlsh from $database.t_customer where 1=1 and date(create_date)>='$do_date'"
}
import_t_customer_buyer(){
import_data t_customer_buyer " select 
id,
customer_id,
customer_identity,
buyer_id,
buyer_identity,
is_defualt from $database.t_customer_buyer where 1=1"
}
import_t_customer_counter_fastout(){
import_data t_customer_counter_fastout " select 
id,
identity,
customer_identity,
counter_identity,
is_default from $database.t_customer_counter_fastout where 1=1"
}
import_t_customer_discount(){
import_data t_customer_discount " select 
id,
customer_identity,
purity_identity,
purity_name,
counter_identity,
counter_name,
discount_remark,
is_discount,
djlsh from $database.t_customer_discount where 1=1"
}
import_t_customer_discount_detail(){
import_data t_customer_discount_detail " select 
id,
discount_id,
additional_labour,
discount_number from $database.t_customer_discount_detail where 1=1"
}
import_t_customer_discount_detail_hs(){
import_data t_customer_discount_detail_hs " select 
id,
discount_hs_id,
additional_labour,
discount_number,
additional_money,
status,
sequence from $database.t_customer_discount_detail_hs where 1=1"
}
import_t_customer_discount_hjxq_temp(){
import_data t_customer_discount_hjxq_temp " select 
customer_code,
mosaic_discount,
general_discount,
hight_quality_discount,
special_discount from $database.t_customer_discount_hjxq_temp where 1=1"
}
import_t_customer_discount_hs(){
import_data t_customer_discount_hs " select 
id,
customer_identity,
customer_code,
customer_name,
purity_identity,
purity_name,
is_discount,
discount_remark,
voucher_id,
DATE_FORMAT(voucher_time,'%Y-%m-%d %H:%i:%s') voucher_time,
voucher_name,
inter,
update_id,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status from $database.t_customer_discount_hs where 1=1 and date(update_time)>='$do_date'"
}
import_t_customer_discount_kjxq_temp(){
import_data t_customer_discount_kjxq_temp " select 
customer_code,
metal_work_stone_discount,
general_discount,
hight_quality_discount,
special_discount from $database.t_customer_discount_kjxq_temp where 1=1"
}
import_t_customer_discount_sync(){
import_data t_customer_discount_sync " select 
customer_code,
showroom_code,
seq,
is_discount,
data_date from $database.t_customer_discount_sync where 1=1"
}
import_t_customer_engrave(){
import_data t_customer_engrave " select 
id,
engrave_identity,
counter_identity,
customer_identity,
engrave_content,
is_default,
is_deleted,
DATE_FORMAT(expired_date,'%Y-%m-%d') expired_date,
if_expired,
is_enable,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
DATE_FORMAT(update_date,'%Y-%m-%d %H:%i:%s') update_date,
purity_identity from $database.t_customer_engrave where 1=1 and date(update_date)>='$do_date'"
}
import_t_customer_exhibitsales_sync(){
import_data t_customer_exhibitsales_sync " select 
id,
customer_code,
showroom_code,
KHLXH from $database.t_customer_exhibitsales_sync where 1=1"
}
import_t_customer_gemset_discount(){
import_data t_customer_gemset_discount " select 
customer_identity,
khbm,
zkhmc,
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
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
children_customer_identity from $database.t_customer_gemset_discount where 1=1 and date(update_time)>='$do_date'"
}
import_t_customer_gemset_discount_history(){
import_data t_customer_gemset_discount_history " select 
customer_identity,
khbm,
zkhmc,
kx_discount,
ks_discount,
old_kx_discount,
old_ks_discount,
ks_discount_desc,
hx_discount_desc,
id,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
create_user,
children_customer_identity from $database.t_customer_gemset_discount_history where 1=1 and date(update_time)>='$do_date'"
}
import_t_customer_phone_cp(){
import_data t_customer_phone_cp " select 
customer_code,
customer_name,
seq,
is_child,
phone1,
phone2,
phone3,
phone4,
active_flag,
parent_code,
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date,
child_customer_code from $database.t_customer_phone_cp where 1=1 and date(data_date)>='$do_date'"
}
import_t_customer_salesman(){
import_data t_customer_salesman " select 
id,
customer_id,
customer_identity,
salesman_id,
salesman_identity,
reception_salesman_identity,
is_deleted,
reception_salesman_id from $database.t_customer_salesman where 1=1"
}
import_t_customer_tag(){
import_data t_customer_tag " select 
id,
tag_identity,
counter_identity,
customer_identity,
tag_content,
is_deleted,
is_default from $database.t_customer_tag where 1=1"
}
import_t_customer_type(){
import_data t_customer_type " select 
id,
customer_type_identity,
customer_type_code,
customer_type_name,
is_deleted,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_customer_type where 1=1 and date(update_time)>='$do_date'"
}
import_t_daily_interrest_err_log(){
import_data t_daily_interrest_err_log " select 
DATE_FORMAT(run_time,'%Y-%m-%d %H:%i:%s') run_time,
pro_name,
err_msg from $database.t_daily_interrest_err_log where 1=1 and date(run_time)>='$do_date'"
}
import_t_daily_interrest_log(){
import_data t_daily_interrest_log " select 
DATE_FORMAT(run_time,'%Y-%m-%d %H:%i:%s') run_time,
pro_name,
log_info from $database.t_daily_interrest_log where 1=1 and date(run_time)>='$do_date'"
}
import_t_default_discount_mosaic(){
import_data t_default_discount_mosaic " select 
id,
default_discount_mosaic_identity,
showroom_identity,
counter_identity,
mosaic_discount,
eos_head_key,
eos_body_key,
hj_dydf_ph_discount,
hj_dydf_jp_discount from $database.t_default_discount_mosaic where 1=1"
}
import_t_delay_region(){
import_data t_delay_region " select 
id,
province,
salesman_role_identity,
area_identity from $database.t_delay_region where 1=1"
}
import_t_delay_task(){
import_data t_delay_task " select 
id,
task_identity,
handler_user,
handler_user_type,
customer_identity,
package_type,
estimate_time,
delay_status,
comments,
is_end,
DATE_FORMAT(end_time,'%Y-%m-%d %H:%i:%s') end_time,
create_user,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
delat_code,
DATE_FORMAT(initial_create_time,'%Y-%m-%d %H:%i:%s') initial_create_time,
DATE_FORMAT(approval_time,'%Y-%m-%d %H:%i:%s') approval_time,
status,
auto_type from $database.t_delay_task where 1=1 and date(approval_time)>='$do_date'"
}
import_t_delay_task_detail(){
import_data t_delay_task_detail " select 
id,
task_identity,
package_code,
weight from $database.t_delay_task_detail where 1=1"
}
import_t_deposit_jewelry(){
import_data t_deposit_jewelry " select 
id,
deposit_identity,
jewelry_purity_name,
jewelry_weight from $database.t_deposit_jewelry where 1=1"
}
import_t_deposit_order(){
import_data t_deposit_order " select 
id,
deposit_identity,
deposit_code,
deposit_type,
goods_source,
receiver_type,
receiver_factory_name,
receiver_dept,
receiver_name,
deposit_number,
deposit_remarks,
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
DATE_FORMAT(delivery_time,'%Y-%m-%d %H:%i:%s') delivery_time,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
marking_status,
deposit_status,
is_delete,
deposit_registration_type,
showroom_identity,
delivery_user_identity,
delivery_user_name,
first_name from $database.t_deposit_order where 1=1 and date(create_time)>='$do_date'"
}
import_t_deposit_setting(){
import_data t_deposit_setting " select 
id,
name,
children_name,
type,
showroom_identity from $database.t_deposit_setting where 1=1"
}
import_t_djjz_procedure_excute_err_log(){
import_data t_djjz_procedure_excute_err_log " select 
id,
procedure_name,
procedure_describe,
DATE_FORMAT(excute_time,'%Y-%m-%d %H:%i:%s') excute_time,
excute_user,
bill_identity,
bill_code,
err_msg from $database.t_djjz_procedure_excute_err_log where 1=1 and date(excute_time)>='$do_date'"
}
import_t_download(){
import_data t_download " select 
id,
down_identity,
file_name,
file_path,
message,
handle_status,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
DATE_FORMAT(end_time,'%Y-%m-%d %H:%i:%s') end_time,
create_user from $database.t_download where 1=1 and date(end_time)>='$do_date'"
}
import_t_eos_fail(){
import_data t_eos_fail " select 
id,
fast_package_identity,
showroom_code,
order_identity,
customer_identity,
salesman_identity,
number from $database.t_eos_fail where 1=1"
}
import_t_eos_order(){
import_data t_eos_order " select 
id,
order_identity,
order_code,
purity_name,
estimate_time,
supplier_identity,
supplier_name,
supplier_source,
supplier_type,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
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
khmc,
khdm,
ppmc from $database.t_eos_order where 1=1 and date(update_time)>='$do_date'"
}
import_t_eos_order_detial(){
import_data t_eos_order_detial " select 
id,
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
estimate_time,
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
khmc,
khdm,
hz,
bqm,
specifications,
workmanship,
ppmc from $database.t_eos_order_detial where 1=1"
}
import_t_estimate_update_log(){
import_data t_estimate_update_log " select 
id,
user_id,
package_code,
estimate_time,
create_time,
reason_for_application from $database.t_estimate_update_log where 1=1"
}
import_t_fast_cus(){
import_data t_fast_cus " select 
id,
customer_identity,
customer_name,
customer_code,
is_child,
phone1,
phone2,
phone3,
phone4,
contact_man,
parent_customer_identity,
is_discount,
is_engrave,
is_tag,
is_fast_out,
company_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
province,
mobile_contact_person,
replace(replace(remarks,'\n',''),'\t','') remarks,
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date,
ty_customer_code,
purity_name,
is_extends,
is_exhibition from $database.t_fast_cus where 1=1 and date(data_date)>='$do_date'"
}
import_t_fast_customer(){
import_data t_fast_customer " select 
id,
customer_identity,
customer_name,
customer_code,
is_child,
phone1,
phone2,
phone3,
phone4,
contact_man,
parent_customer_identity,
is_discount,
is_engrave,
is_tag,
is_fast_out,
company_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
province,
mobile_contact_person,
replace(replace(remarks,'\n',''),'\t','') remarks,
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date,
ty_customer_code,
purity_name,
is_extends,
is_exhibition,
area_identity,
technology_purity_identity,
showroom_identity,
label_show_original_price,
status from $database.t_fast_customer where 1=1 and date(data_date)>='$do_date'"
}
import_t_fast_order(){
import_data t_fast_order " select 
id,
order_identity,
package_number,
processed_number,
customer_identity,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
is_complete,
replace(replace(remarks,'\n',''),'\t','') remarks,
gold_price,
serial_number,
is_urgent,
settlement_method,
is_suspend,
customer_confirmation_time,
sales_status_id,
counter_name,
wait_number,
update_time,
salesman_identity,
DATE_FORMAT(confirm_time,'%Y-%m-%d %H:%i:%s') confirm_time,
DATE_FORMAT(completion_time,'%Y-%m-%d %H:%i:%s') completion_time from $database.t_fast_order where 1=1 and date(confirm_time)>='$do_date'"
}
import_t_fast_order_purity(){
import_data t_fast_order_purity " select 
id,
order_purity_identity,
order_identity,
purity_identity,
purity_code,
purity_name,
deduction_weight from $database.t_fast_order_purity where 1=1"
}
import_t_fast_package(){
import_data t_fast_package " select 
id,
fast_package_identity,
package_code,
package_name,
status_id,
showroom_identity,
customer_id,
customer_identity,
counter_user_id,
counter_user_identity,
initial_package_code,
net_weight,
gross_weight,
purity_id,
purity_identity,
showroom_counter_id,
showroom_counter_identity,
additional_labour_amount,
standard_labour_amount,
status,
is_delete,
replace(replace(remarks,'\n',''),'\t','') remarks,
marking_identity,
create_date,
is_urgent,
DATE_FORMAT(confirmatio_time,'%Y-%m-%d %H:%i:%s') confirmatio_time,
is_lm,
sales_status_id,
DATE_FORMAT(customer_require_time,'%Y-%m-%d %H:%i:%s') customer_require_time,
DATE_FORMAT(customer_confirmation_time,'%Y-%m-%d %H:%i:%s') customer_confirmation_time,
DATE_FORMAT(leave_counter_time,'%Y-%m-%d %H:%i:%s') leave_counter_time,
settlement_method,
update_user,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
is_fast_out,
order_identity,
print_label,
is_print,
is_stay,
stay_identity,
is_return,
is_b2b,
additional_labour_no_discount_amount,
salesman_identity,
delay_number,
is_visible,
delay_status,
disable_delay,
DATE_FORMAT(estimate_time,'%Y-%m-%d') estimate_time,
delay_salesman_identity,
delay_care,
goods_picker,
goods_picker_phone,
return_goods,
package_i_type,
current_data_type,
DATE_FORMAT(business_require_time,'%Y-%m-%d %H:%i:%s') business_require_time,
sale_code,
kdsj,
if_sale_status,
DATE_FORMAT(gzrq,'%Y-%m-%d %H:%i:%s') gzrq from $database.t_fast_package where 1=1 and date(update_time)>='$do_date'"
}
import_t_fast_package_delete(){
import_data t_fast_package_delete " select 
id,
customer_identity,
package_code,
reason,
create_user,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_fast_package_delete where 1=1 and date(create_time)>='$do_date'"
}
import_t_fast_package_engrave(){
import_data t_fast_package_engrave " select 
id,
engrave_identity,
engrave_content,
customer_require_time,
net_weight,
gross_weight,
counter_code,
customer_identity,
showroom_counter_identity,
replace(replace(remarks,'\n',''),'\t','') remarks,
code,
engrave_status,
DATE_FORMAT(creat_time,'%Y-%m-%d %H:%i:%s') creat_time,
is_fast_out,
operation_content,
batch_code,
engrave_staff,
quality_staff,
qualitycon_staff,
DATE_FORMAT(receive_time,'%Y-%m-%d %H:%i:%s') receive_time,
DATE_FORMAT(complete_time,'%Y-%m-%d %H:%i:%s') complete_time from $database.t_fast_package_engrave where 1=1 and date(creat_time)>='$do_date'"
}
import_t_fast_package_flowing(){
import_data t_fast_package_flowing " select 
id,
flowing_identity,
fast_package_identity,
package_code,
net_weight,
type,
is_now,
replace(replace(remarks,'\n',''),'\t','') remarks,
create_user_id,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date from $database.t_fast_package_flowing where 1=1 and date(modify_date)>='$do_date'"
}
import_t_fast_package_i(){
import_data t_fast_package_i " select 
id,
package_i_identity,
fast_package_id,
package_i_code,
fast_package_identity,
category_id,
category_identity,
item_qty,
net_weight,
genus_id,
genus_identity,
additional_labour,
standard_labour,
gross_weight,
status,
is_delete,
package_status,
replace(replace(remarks,'\n',''),'\t','') remarks,
is_discount,
packing_paper_number,
plastic_bag_number,
manual_input_number,
automatic_input_number,
gross_manual_input_number,
gross_automatic_input_number,
dif_reason,
is_return,
additional_labour_discount,
additional_labour_discount_amount,
technology_num,
technology_unit_price,
technology_count_price,
genus_name,
price_method,
product_code,
metal_color,
stone_color,
specs,
gold_weight,
parts_weight,
total_stone_weight,
main_stone_weight,
auxiliary_stone_weight,
total_weight,
loss,
gold_costs,
label_price,
fixed_price,
sales_fee,
product_type,
product_name,
certificate_no,
clarity,
contains_consumption_weight,
help_remember_code,
total_number,
company_model_code,
category_second_identity,
discount,
discount_price,
stone_costs,
gold_unit_price,
special_discount,
sales_discount_fee,
stone_encrusted_fee,
stone_total_fee,
parts_cost_amount_total_fee,
main_stone_prices,
auxiliary_stone_price,
auxiliary_stone_total_price,
main_stone_price,
is_dydf_counter,
is_fixed_price,
other_price,
batch_price from $database.t_fast_package_i where 1=1"
}
import_t_fast_package_i_plastic(){
import_data t_fast_package_i_plastic " select 
id,
package_i_identity,
plastic_number,
plastic_size,
plastic_id,
plastic_name from $database.t_fast_package_i_plastic where 1=1"
}
import_t_fast_package_i_product(){
import_data t_fast_package_i_product " select 
id,
fast_package_prodct_identity,
fast_package_item_id,
fast_package_item_identity,
main_item_id,
main_item_identity,
item_qty,
net_weight,
additional_labour,
standard_labour,
status,
is_delete,
product_code,
genus_name,
first_genus_name,
second_genus_name,
factory_code,
label_price,
replace(replace(remarks,'\n',''),'\t','') remarks,
is_high_quality,
discount,
discount_price,
fast_package_identity from $database.t_fast_package_i_product where 1=1"
}
import_t_fast_package_operation_log(){
import_data t_fast_package_operation_log " select 
id,
operation_identity,
operation_content,
operation_type,
create_user,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_fast_package_operation_log where 1=1 and date(create_time)>='$do_date'"
}
import_t_fast_package_reason(){
import_data t_fast_package_reason " select 
id,
showroom_identity,
delete_reason,
del_flag from $database.t_fast_package_reason where 1=1"
}
import_t_fast_package_record(){
import_data t_fast_package_record " select 
id,
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
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date from $database.t_fast_package_record where 1=1 and date(data_date)>='$do_date'"
}
import_t_fast_package_status(){
import_data t_fast_package_status " select 
id,
status_code,
status_name from $database.t_fast_package_status where 1=1"
}
import_t_fast_package_tag(){
import_data t_fast_package_tag " select 
id,
tag_identity,
tag_content,
customer_require_time,
net_weight,
gross_weight,
customer_identity,
counter_code,
showroom_counter_identity,
replace(replace(remarks,'\n',''),'\t','') remarks,
code,
tag_status,
is_fast_out,
operation_content,
batch_code,
DATE_FORMAT(creat_time,'%Y-%m-%d %H:%i:%s') creat_time,
DATE_FORMAT(receive_time,'%Y-%m-%d %H:%i:%s') receive_time,
DATE_FORMAT(complete_time,'%Y-%m-%d %H:%i:%s') complete_time,
tag_staff from $database.t_fast_package_tag where 1=1 and date(complete_time)>='$do_date'"
}
import_t_fast_package_update_customer(){
import_data t_fast_package_update_customer " select 
id,
package_code,
initial_package_code,
is_print,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date from $database.t_fast_package_update_customer where 1=1 and date(create_date)>='$do_date'"
}
import_t_fast_technology_price(){
import_data t_fast_technology_price " select 
id,
technology_identity,
package_i_identity,
technology_num,
technology_unit_price,
technology_count_price from $database.t_fast_technology_price where 1=1"
}
import_t_finance_customer_info(){
import_data t_finance_customer_info " select 
id,
finance_customer_info_identity,
showroom_identity,
showroom_name,
finance_customer_code,
finance_customer_name,
create_time,
create_user_id,
create_user_name,
update_time,
update_user_id,
update_user_name,
is_delete,
djlsh from $database.t_finance_customer_info where 1=1"
}
import_t_finance_customer_relation(){
import_data t_finance_customer_relation " select 
id,
finance_customer_relation_identity,
finance_customer_info_identity,
showroom_identity,
showroom_name,
customer_identity,
customer_code,
parent_customer_identity,
parent_customer_name,
customer_name,
child_customer_name,
is_main_customer,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user_id,
create_user_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_user_id,
update_user_name,
is_delete,
djlsh,
djbth from $database.t_finance_customer_relation where 1=1 and date(update_time)>='$do_date'"
}
import_t_fjgfzkbb_sync(){
import_data t_fjgfzkbb_sync " select 
djlsh,
gfje,
zkl from $database.t_fjgfzkbb_sync where 1=1"
}
import_t_fjgfzkbh_sync(){
import_data t_fjgfzkbh_sync " select 
djlsh,
khmc,
khbm,
replace(replace(BZ,'\n',''),'\t','') bz,
zkhmc,
zkhbh,
csgs,
khbm_jds,
khmc_jds from $database.t_fjgfzkbh_sync where 1=1"
}
import_t_gemstone_attribute(){
import_data t_gemstone_attribute " select 
id,
purity_name,
gold_gem_code,
gold_gem_name from $database.t_gemstone_attribute where 1=1"
}
import_t_genus(){
import_data t_genus " select 
id,
genus_identity,
genus_code,
genus_name,
genus_help_code,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date from $database.t_genus where 1=1 and date(modify_date)>='$do_date'"
}
import_t_gf_area_customer(){
import_data t_gf_area_customer " select 
id,
area_identity,
customer_identity,
is_child,
is_delete from $database.t_gf_area_customer where 1=1"
}
import_t_history_data_move_log(){
import_data t_history_data_move_log " select 
DATE_FORMAT(run_time,'%Y-%m-%d %H:%i:%s') run_time,
msg_info from $database.t_history_data_move_log where 1=1 and date(run_time)>='$do_date'"
}
import_t_hw_model_fee(){
import_data t_hw_model_fee " select 
id,
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
model_code_color from $database.t_hw_model_fee where 1=1"
}
import_t_incoming_difference(){
import_data t_incoming_difference " select 
id,
area_identity,
area_name,
plan_incoming,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_by from $database.t_incoming_difference where 1=1 and date(update_time)>='$do_date'"
}
import_t_incoming_maintain(){
import_data t_incoming_maintain " select 
id,
name,
sub_name,
identity,
type,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by from $database.t_incoming_maintain where 1=1 and date(create_time)>='$do_date'"
}
import_t_initial_package_update_customer(){
import_data t_initial_package_update_customer " select 
id,
old_code,
new_code,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
create_user from $database.t_initial_package_update_customer where 1=1 and date(create_date)>='$do_date'"
}
import_t_initial_weight(){
import_data t_initial_weight " select 
id,
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
engrave_require_time,
tag_require_time,
business_require,
replace(replace(remarks,'\n',''),'\t','') remarks,
is_immediate,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user,
DATE_FORMAT(business_require_time,'%Y-%m-%d %H:%i:%s') business_require_time,
business_require_id,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
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
estimate_time,
delay_status,
delay_salesman_identity,
delay_care,
goods_picker,
goods_picker_phone,
is_end from $database.t_initial_weight where 1=1  and date(update_time)>='$do_date'"
}
import_t_initial_weight_delete(){
import_data t_initial_weight_delete " select 
id,
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
DATE_FORMAT(engrave_require_time,'%Y-%m-%d %H:%i:%s') engrave_require_time,
DATE_FORMAT(tag_require_time,'%Y-%m-%d %H:%i:%s') tag_require_time,
business_require,
replace(replace(remarks,'\n',''),'\t','') remarks,
is_immediate,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user,
DATE_FORMAT(business_require_time,'%Y-%m-%d %H:%i:%s') business_require_time,
business_require_id,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
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
DATE_FORMAT(estimate_time,'%Y-%m-%d') estimate_time,
delay_salesman_identity,
delay_care,
goods_picker,
goods_picker_phone from $database.t_initial_weight_delete where 1=1 and date(update_time)>='$do_date'"
}
import_t_initial_weight_record(){
import_data t_initial_weight_record " select 
id,
initial_weight_record_identity,
initial_weight_identity,
super_tag,
customer_identity,
showroom_counter_identity,
counter_user_identity,
initial_counter_user_identity,
initial_weight,
net_weight,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date from $database.t_initial_weight_record where 1=1"
}
import_t_initial_weight_status(){
import_data t_initial_weight_status " select 
id,
status_code,
status_name from $database.t_initial_weight_status where 1=1"
}
import_t_insert_log_fail(){
import_data t_insert_log_fail " select 
param,
DATE_FORMAT(insert_time,'%Y-%m-%d %H:%i:%s') insert_time from $database.t_insert_log_fail where 1=1 and date(insert_time)>='$do_date'"
}
import_t_ka_kxjczb(){
import_data t_ka_kxjczb " select 
id,
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
import_t_ka_lllsz(){
import_data t_ka_lllsz " select 
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
id,
djm,
djh,
swlx,
csbm,
csmc,
plbm,
plmc,
sffx,
jz,
wdbm,
wdmc,
ckbm,
ckmc,
hl,
llsm,
khlx,
gylx,
customer_identity,
parent_customer_identity,
czzt,
lllsz_identity,
zjm,
tech_purity_name,
tech_purity_code from $database.t_ka_lllsz where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_llmxz_b(){
import_data t_ka_llmxz_b " select 
id,
llmxz_H_identity,
llmxz_B_identity,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
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
replace(replace(BZ,'\n',''),'\t','') bz,
dcwdmc,
gylx,
customer_identity,
parent_customer_identity,
jz,
czzt from $database.t_ka_llmxz_b where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_llmxz_h(){
import_data t_ka_llmxz_h " select 
id,
llmxz_H_identity,
customer_identity,
parent_customer_identity,
jz,
wdbm,
wdmc,
customer_help_code from $database.t_ka_llmxz_h where 1=1"
}
import_t_ka_lscqmxb_b(){
import_data t_ka_lscqmxb_b " select 
lscqmxb_h_identity,
lscqmxb_b_identity,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
drdqzk,
drlx,
drwdqzk,
drdqjz,
drwdqjz,
bygf,
sygf,
ccjz,
drxzlx,
drccf,
yjd,
qzxl,
wzxl,
xlhz,
sylx,
scbs,
yccjz,
ylx,
syql,
syzqk,
yccf,
kmxccjz,
djlsh,
djbth from $database.t_ka_lscqmxb_b where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_lscqmxb_h(){
import_data t_ka_lscqmxb_h " select 
id,
lscqmxb_h_identity,
wdmc,
wdbm,
customer_identity,
khbm,
khmc,
zkh,
purity_name,
zjm,
wyid,
ycbs,
cwbz,
ztyc,
djlsh from $database.t_ka_lscqmxb_h where 1=1"
}
import_t_ka_lsedzb(){
import_data t_ka_lsedzb " select 
id,
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
import_data t_ka_lsz_h " select 
id,
djm,
djh,
rq,
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
khmc,
rhf,
chf,
czzt from $database.t_ka_lsz_h where 1=1"
}
import_t_ka_mxz(){
import_data t_ka_mxz " select 
id,
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
replace(replace(BZ,'\n',''),'\t','') bz,
DATE_FORMAT(rkrq,'%Y-%m-%d')  rkrq,
rkdh,
rkdm,
DATE_FORMAT(gxrq,'%Y-%m-%d %H:%i:%s')  gxrq,
gxdh,
pdzt,
pddh,
lsdh,
lsrq,
xsdj,
sjzk,
ml,
mjj,
lsje,
jsdh,
jsrq,
jsje,
khmc,
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
bqm from $database.t_ka_mxz where 1=1 and date(gxrq)>='$do_date'"
}
import_t_ka_mxz_update(){
import_data t_ka_mxz_update " select 
id,
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
replace(replace(BZ,'\n',''),'\t','') bz,
rkrq,
rkdh,
rkdm,
gxrq,
gxdh,
pdzt,
pddh,
lsdh,
lsrq,
xsdj,
sjzk,
ml,
mjj,
lsje,
jsdh,
jsrq,
jsje,
khmc,
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
import_data t_ka_spkcmxz " select 
id,
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
import_t_ka_splsz(){
import_data t_ka_splsz " select 
id,
djm,
djh,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
RKYY,
swlx,
KCLX,
WDBM,
wdmc,
CKBM,
ckmc,
jsmc,
plmc,
YJPL,
EJPL,
sffx,
js,
jz,
bqjg,
GJF,
YFJGF,
FJGF,
FJGFJE,
jgf,
jgfje,
JCGF,
JCGFJE,
dlcj,
dlcjje,
customer_identity,
parent_customer_identity,
RHF,
CHF,
replace(replace(BZ,'\n',''),'\t','') BZ,
BZGF,
ZL,
XSGF,
RHWDMC,
FKHSL,
GYLX,
ZQCE,
ZQCEXJ,
MZ,
czzt,
tech_purity_code,
tech_purity_name,
bzh from $database.t_ka_splsz where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_splsz_hw(){
import_data t_ka_splsz_hw " select 
id,
djm,
djh,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
RKYY,
swlx,
KCLX,
WDBM,
wdmc,
CKBM,
ckmc,
jsmc,
plmc,
YJPL,
EJPL,
sffx,
js,
jz,
bqjg,
GJF,
YFJGF,
FJGF,
FJGFJE,
jgf,
jgfje,
JCGF,
JCGFJE,
dlcj,
dlcjje,
customer_identity,
parent_customer_identity,
RHF,
CHF,
replace(replace(BZ,'\n',''),'\t','') BZ,
BZGF,
ZL,
XSGF,
RHWDMC,
FKHSL,
GYLX,
ZQCE,
ZQCEXJ,
MZ,
czzt,
tech_purity_code,
tech_purity_name from $database.t_ka_splsz_hw where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_szdzsqdh(){
import_data t_ka_szdzsqdh " select 
id,
djlsh,
djh,
wdmc,
khmc,
khbm,
zkh,
zdr,
DATE_FORMAT(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
zdrid,
cwjsrq,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
replace(replace(BZ,'\n',''),'\t','') bz,
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
DATE_FORMAT(sj1,'%Y-%m-%d %H:%i:%s') sj1,
fgldqr,
DATE_FORMAT(sj2,'%Y-%m-%d %H:%i:%s') sj2,
zjlpf,
DATE_FORMAT(sj3,'%Y-%m-%d %H:%i:%s') sj3,
cwqr,
DATE_FORMAT(sj4,'%Y-%m-%d %H:%i:%s') sj4,
dszfh,
DATE_FORMAT(sj5,'%Y-%m-%d %H:%i:%s') sj5,
DATE_FORMAT(cwshsj,'%Y-%m-%d %H:%i:%s') cwshsj,
DATE_FORMAT(zjlpfrq,'%Y-%m-%d %H:%i:%s') zjlpfrq,
sfdy,
dysj,
cwecqr,
cwecqrsj,
out_tech_purity_name,
out_tech_purity_code,
in_tech_purity_name,
in_tech_purity_code from $database.t_ka_szdzsqdh where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_szdzsqdh_temp(){
import_data t_ka_szdzsqdh_temp " select 
id,
djlsh,
djh,
wdmc,
khmc,
khbm,
zkh,
zdr,
DATE_FORMAT(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
zdrid,
DATE_FORMAT(cwjsrq,'%Y-%m-%d %H:%i:%s') cwjsrq,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
replace(replace(BZ,'\n',''),'\t','') bz,
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
DATE_FORMAT(sj1,'%Y-%m-%d %H:%i:%s') sj1,
fgldqr,
DATE_FORMAT(sj2,'%Y-%m-%d %H:%i:%s') sj2,
zjlpf,
DATE_FORMAT(sj3,'%Y-%m-%d %H:%i:%s') sj3,
cwqr,
DATE_FORMAT(sj4,'%Y-%m-%d %H:%i:%s') sj4,
dszfh,
DATE_FORMAT(sj5,'%Y-%m-%d %H:%i:%s') sj5,
DATE_FORMAT(cwshsj,'%Y-%m-%d %H:%i:%s') cwshsj,
DATE_FORMAT(zjlpfrq,'%Y-%m-%d %H:%i:%s') zjlpfrq,
sfdy,
dysj,
cwecqr,
cwecqrsj,
out_tech_purity_name,
out_tech_purity_code,
in_tech_purity_name,
in_tech_purity_code from $database.t_ka_szdzsqdh_temp where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_szkhcqlxzz_b(){
import_data t_ka_szkhcqlxzz_b " select 
szkhcqlxzz_h_identity,
szkhcqlxzz_b_identity,
djbth,
lxb,
pl,
fsrq,
je,
dj,
zq,
btlx,
dygf,
sygf,
ccjq,
jxxh,
kqqk from $database.t_ka_szkhcqlxzz_b where 1=1"
}
import_t_ka_szkhcqlxzz_b_history(){
import_data t_ka_szkhcqlxzz_b_history " select 
data_date,
szkhcqlxzz_h_identity,
szkhcqlxzz_b_identity,
djbth,
lxb,
pl,
DATE_FORMAT(fsrq,'%Y-%m-%d %H:%i:%s') fsrq,
je,
dj,
zq,
btlx,
dygf,
sygf,
ccjq,
jxxh,
kqqk from $database.t_ka_szkhcqlxzz_b_history where 1=1 and date(fsrq)>='$do_date'"
}
import_t_ka_szkhcqlxzz_f(){
import_data t_ka_szkhcqlxzz_f " select 
szkhcqlxzz_h_identity,
szkhcqlxzz_f_identity,
swlx,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
xmje,
yjsjd from $database.t_ka_szkhcqlxzz_f where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_szkhcqlxzz_f_history(){
import_data t_ka_szkhcqlxzz_f_history " select 
data_date,
szkhcqlxzz_h_identity,
szkhcqlxzz_f_identity,
swlx,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
xmje,
yjsjd from $database.t_ka_szkhcqlxzz_f_history where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_szkhcqlxzz_h(){
import_data t_ka_szkhcqlxzz_h " select 
id,
szkhcqlxzz_h_identity,
djbtzdh,
wdmc,
wdbm,
customer_identity,
khbm,
khmc,
zkh,
purity_name,
zjm,
khlx,
mxts,
ll,
YDQJE,
WDQJE,
qlzl,
qldj,
lx,
drlx,
drccf,
dygfh,
sygfh,
wdqqlzl,
wdqqldj,
ccf,
ccfqx,
wyid,
DRHKYE,
drhlye,
BTHKYE,
bthlye,
xlhz,
htr,
edxl,
mxjz,
qzjxl,
wzjxl,
qzjjj,
ckjx,
yjd,
htydq,
ccjz,
yjyq,
htysjcd,
sywjlx,
xkh,
sylx,
sylxcl,
wdqjepd,
ccmxjz,
sygflx,
deccf,
yccjz,
syql,
syzqk,
khzl from $database.t_ka_szkhcqlxzz_h where 1=1"
}
import_t_ka_szkhcqlxzz_h_history(){
import_data t_ka_szkhcqlxzz_h_history " select 
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date,
id,
szkhcqlxzz_h_identity,
djbtzdh,
wdmc,
wdbm,
customer_identity,
khbm,
khmc,
zkh,
purity_name,
zjm,
khlx,
mxts,
ll,
YDQJE,
WDQJE,
qlzl,
qldj,
lx,
drlx,
drccf,
dygfh,
sygfh,
wdqqlzl,
wdqqldj,
ccf,
ccfqx,
wyid,
DRHKYE,
drhlye,
BTHKYE,
bthlye,
xlhz,
htr,
edxl,
mxjz,
qzjxl,
wzjxl,
qzjjj,
ckjx,
yjd,
htydq,
ccjz,
yjyq,
htysjcd,
sywjlx,
xkh,
sylx,
sylxcl,
wdqjepd,
ccmxjz,
sygflx,
deccf,
yccjz,
syql,
syzqk,
khzl from $database.t_ka_szkhcqlxzz_h_history where 1=1 and date(data_date)>='$do_date'"
}
import_t_ka_szkhcqlxzzfb_h(){
import_data t_ka_szkhcqlxzzfb_h " select 
id,
szkhcqlxzz_h_identity,
djbtzdh,
wdmc,
wdbm,
customer_identity,
khbm,
khmc,
zkh,
purity_name,
zjm,
khlx,
mxts,
ll,
YDQJE,
WDQJE,
qlzl,
qldj,
lx,
drlx,
drccf,
dygfh,
sygfh,
wdqqlzl,
wdqqldj,
ccf,
ccfqx,
wyid,
DRHKYE,
drhlye,
BTHKYE,
bthlye,
xlhz,
htr,
edxl,
mxjz,
qzjxl,
wzjxl,
qzjjj,
ckjx,
yjd,
htydq,
ccjz,
yjyq,
htysjcd,
sywjlx,
xkh,
sylx,
sylxcl,
wdqjepd,
ccmxjz,
sygflx,
deccf,
yccjz,
syql,
syzqk,
khzl from $database.t_ka_szkhcqlxzzfb_h where 1=1"
}
import_t_ka_szkhcqmx_b(){
import_data t_ka_szkhcqmx_b " select 
szkhcqmx_h_identity,
szkhcqmx_b_identity,
djlsh,
djbth,
djstate,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
zl,
je,
lxb,
ze,
ts,
zlqj,
scbs,
DATE_FORMAT(zxrqb,'%Y-%m-%d %H:%i:%s') zxrqb from $database.t_ka_szkhcqmx_b where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_szkhcqmx_f(){
import_data t_ka_szkhcqmx_f " select 
djlsh,
szkhcqmx_h_identity,
szkhcqmx_f_identity,
djfth,
djstate,
DATE_FORMAT(rqf,'%Y-%m-%d %H:%i:%s') rqf,
zlf,
jef,
lxf,
zef,
tsf,
zlqjf,
scbsf,
DATE_FORMAT(zxrq,'%Y-%m-%d %H:%i:%s') zxrq from $database.t_ka_szkhcqmx_f where 1=1 and date(rqf)>='$do_date'"
}
import_t_ka_szkhcqmx_h(){
import_data t_ka_szkhcqmx_h " select 
szkhcqmx_h_identity,
djlsh,
djbtzdh,
djftzdh,
djstzdh,
djstate,
djcount,
wdbm,
wdmc,
khbm,
khmc,
zkhbh,
zkhmc,
qkje,
qlzl,
qlje,
lx,
jj,
cqze,
zcqkts,
khbs,
khlx,
ycbs,
customer_identity,
purity_name from $database.t_ka_szkhcqmx_h where 1=1"
}
import_t_ka_szlxjsrq(){
import_data t_ka_szlxjsrq " select 
szlxjsrq_identity,
DATE_FORMAT(jsrq,'%Y-%m-%d %H:%i:%s')  jsrq from $database.t_ka_szlxjsrq where 1=1 and date(jsrq)>='$do_date'"
}
import_t_ka_xltj_b(){
import_data t_ka_xltj_b " select 
id,
identity,
djh,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
csmc,
xszl,
jjzl,
jjje,
czzt from $database.t_ka_xltj_b where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_xltj_h(){
import_data t_ka_xltj_h " select 
id,
identity,
wdmc,
customer_identity,
parent_customer_identity from $database.t_ka_xltj_h where 1=1"
}
import_t_ka_yfllsz(){
import_data t_ka_yfllsz " select 
id,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
djm,
DJH,
SWLX,
customer_identity,
parent_customer_identity,
SFFX,
JZ,
wdbm,
wdmc,
khlx,
czzt,
CSBM,
CSMC,
plbm,
plmc,
CKBM,
ckmc,
hl,
llsm,
tech_purity_name,
tech_purity_code from $database.t_ka_yfllsz where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_yflmxz(){
import_data t_ka_yflmxz " select 
id,
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
import_t_ka_yflsz(){
import_data t_ka_yflsz " select 
id,
DATE_FORMAT(rq,'%Y-%m-%d') RQ,
djm,
DJH,
SWLX,
customer_identity,
parent_customer_identity,
SFFX,
JZ,
Je,
bb,
WDBM,
wdmc,
lb,
khlx,
czzt,
tech_purity_name,
tech_purity_code from $database.t_ka_yflsz where 1=1"
}
import_t_ka_yfmxz(){
import_data t_ka_yfmxz " select 
id,
wdmc,
customer_identity,
parent_customer_identity,
lb,
je,
bb,
khlx from $database.t_ka_yfmxz where 1=1"
}
import_t_ka_yfrzzh(){
import_data t_ka_yfrzzh " select 
id,
yfrzz_identity,
nian,
yue,
ri,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdmc,
zjm,
customer_identity,
khbm,
khmc,
qcje,
qcjz,
zjje,
zjjz,
jsje,
jsjz,
jcje,
jcjz from $database.t_ka_yfrzzh where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_yfrzzh_hw(){
import_data t_ka_yfrzzh_hw " select 
id,
yfrzz_identity,
nian,
yue,
ri,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdmc,
zjm,
customer_identity,
khbm,
khmc,
qcje,
qcjz,
zjje,
zjjz,
jsje,
jsjz,
jcje,
jcjz from $database.t_ka_yfrzzh_hw where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_yhrq(){
import_data t_ka_yhrq " select 
id,
yhrq_identity,
showroom_name,
DATE_FORMAT(rq,'%Y-%m-%d') rq from $database.t_ka_yhrq where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_yslsz(){
import_data t_ka_yslsz " select 
id,
yslsz_identity,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
djm,
djh,
swlx,
sffx,
je,
bb,
wdbm,
wdmc,
lb,
replace(replace(BZ,'\n',''),'\t','') bz,
gylx,
customer_identity,
parent_customer_identity,
czzt,
khlx from $database.t_ka_yslsz where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_ysmxz_b(){
import_data t_ka_ysmxz_b " select 
id,
ysmxz_h_identity,
ysmxz_b_identity,
djm,
djh,
settlement_type,
djje,
wfje,
yfje,
replace(replace(BZ,'\n',''),'\t','') bz,
DATE_FORMAT(zhskrq,'%Y-%m-%d %H:%i:%s')  zhskrq,
csbm,
csmc,
plbm,
plmc,
dcwdmc,
fs,
jjje,
gfje,
hkshrq,
ybf,
hkjsfs,
gylx,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
czzt from $database.t_ka_ysmxz_b where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_ysmxz_h(){
import_data t_ka_ysmxz_h " select 
id,
ysmxz_h_identity,
customer_identity,
parent_customer_identity,
wdbm,
wdmc,
lb,
je,
bb,
zjm,
yjkh,
khlx,
tech_purity_name,
tech_purity_code from $database.t_ka_ysmxz_h where 1=1"
}
import_t_ka_ysmxz_s(){
import_data t_ka_ysmxz_s " select 
id,
ysmxz_h_identity,
ysmxz_b_identity,
ysmxz_s_identity,
DATE_FORMAT(hxdjrq,'%Y-%m-%d %H:%i:%s') hxdjrq,
hxdh,
hxdm,
hxje,
sm,
DATE_FORMAT(hxczrq,'%Y-%m-%d %H:%i:%s') hxczrq,
hxczdh,
drwdmc from $database.t_ka_ysmxz_s where 1=1 and date(hxdjrq)>='$do_date'"
}
import_t_ka_ysmxz_sold(){
import_data t_ka_ysmxz_sold " select 
id,
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
replace(replace(BZ,'\n',''),'\t','') bz,
rkrq,
rkdh,
rkdm,
gxrq,
gxdh,
pdzt,
pddh,
lsdh,
lsrq,
xsdj,
sjzk,
ZKJE,
ml,
mjj,
lsje,
jsdh,
DATE_FORMAT(jsrq,'%Y-%m-%d %H:%i:%s') jsrq,
jsje,
customer_identity,
khbm,
khmc,
ZSMC,
CXM,
EWM,
JJ,
CSMC from $database.t_ka_ysmxz_sold where 1=1"
}
import_t_ka_zjlsz(){
import_data t_ka_zjlsz " select 
id,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
djm,
djh,
swlx,
gsmc,
je,
sffx,
zh,
fssj,
fsje,
zjlx,
yh,
yhzh,
zcwd,
replace(replace(BZ,'\n',''),'\t','') bz,
czzt,
customer_identity,
parent_customer_identity from $database.t_ka_zjlsz where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_zjyez(){
import_data t_ka_zjyez " select 
id,
gsmc,
zh,
je,
zjlx,
yh,
yhzh,
czzt,
customer_identity,
parent_customer_identity from $database.t_ka_zjyez where 1=1"
}
import_t_ka_zrye(){
import_data t_ka_zrye " select 
zrye_identity,
dh,
je,
jz,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdmc,
lx from $database.t_ka_zrye where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_ztkcrzz(){
import_data t_ka_ztkcrzz " select 
id,
ztkcrzz_identity,
nian,
yue,
ri,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
wdmc,
ckmc,
jsmc,
plmc,
qcjs,
qcjz,
qcje,
qmjs,
qmjz,
qmje,
rkjs,
rkjz,
rkje,
ckjs,
ckjz,
ckje,
ykjs,
ykjz,
ykje from $database.t_ka_ztkcrzz where 1=1 and date(rq)>='$do_date'"
}
import_t_ka_ztkczz(){
import_data t_ka_ztkczz " select 
id,
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
import_data t_kj_child_customer " select 
id,
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
create_date,
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
import_data t_kj_customer " select 
id,
customer_identity,
djlsh,
customer_code,
customer_name,
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
create_date,
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
import_t_late_transfer_log(){
import_data t_late_transfer_log " select 
id,
customer_code,
customer_identity,
customer_name,
package_all,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
recept_by from $database.t_late_transfer_log where 1=1 and date(create_time)>='$do_date'"
}
import_t_login_log(){
import_data t_login_log " select 
id,
buyer_id,
buyer_identity,
customer_id,
customer_identity,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
showroom_identity from $database.t_login_log where 1=1 and date(create_time)>='$do_date'"
}
import_t_material_price_rule(){
import_data t_material_price_rule " select 
id,
purity_identity,
customer_identity,
rule from $database.t_material_price_rule where 1=1"
}
import_t_move_counter(){
import_data t_move_counter " select 
id,
move_identity,
move_code,
order_identity,
order_code,
receive_identity,
receive_code,
purity_name,
customer_name,
customer_code,
engrave,
estimate_time,
showroom_counter_identity,
showroom_counter_name,
total_gold_weight,
total_number,
total_work_fee,
supplier_name,
stock_status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
customer_showroom,
move_type,
move_status,
DATE_FORMAT(confirm_time,'%Y-%m-%d %H:%i:%s') confirm_time,
confirm_by,
replace(replace(remark,'\n',''),'\t','') remark,
status from $database.t_move_counter where 1=1 and date(update_time)>='$do_date'"
}
import_t_move_counter_detail(){
import_data t_move_counter_detail " select 
id,
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
import_t_mxzh(){
import_data t_mxzh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
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
replace(replace(BZ,'\n',''),'\t','') bz,
DATE_FORMAT(rkrq,'%Y-%m-%d %H:%i:%s') rkrq,
rkdh,
rkdm,
gxrq,
gxdh,
pdzt,
pddh,
lsdh,
lsrq,
xsdj,
sjzk,
ml,
mjj,
lsje,
jsdh,
jsrq,
jsje,
khmc,
ZSMC,
CXM,
EWM,
EWMX,
LBDM,
ZSCB,
FSCB,
WXFY,
BZCB,
ZSGG,
WXDM from $database.t_mxzh where 1=1 and date(rkrq)>='$do_date'"
}
import_t_package_engrave_tag(){
import_data t_package_engrave_tag " select 
id,
engrave_tag_identity,
fast_package_identity,
is_engrave,
is_tag,
engrave_content,
tag_content,
engrave_require_time,
tag_require_time,
business_require,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
is_immediate,
is_handle_engrave,
is_handle_tag,
up_count,
business_require_time from $database.t_package_engrave_tag where 1=1 and date(create_time)>='$do_date'"
}
import_t_package_stay_weight_customer(){
import_data t_package_stay_weight_customer " select 
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date,
customer_identity,
customer_code,
customer_name,
customer_name_template,
parent_Customer_identity,
parent_Customer_code,
parent_Customer_Name,
counter_name,
department_name,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
net_weight,
is_inital from $database.t_package_stay_weight_customer where 1=1 and date(create_date)>='$do_date'"
}
import_t_packing_paper(){
import_data t_packing_paper " select 
id,
paper_name,
paper_weight,
paper_type,
tolerance_weight,
counter_identity from $database.t_packing_paper where 1=1"
}
import_t_physical_counter(){
import_data t_physical_counter " select 
id,
physical_identity,
physical_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
status,
showroom_identity,
showroom_name,
super_counter from $database.t_physical_counter where 1=1 and date(create_time)>='$do_date'"
}
import_t_print_log(){
import_data t_print_log " select 
id,
print_identity,
print_customer_code,
print_date from $database.t_print_log where 1=1"
}
import_t_product_basic_info(){
import_data t_product_basic_info " select 
id,
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
DATE_FORMAT(storage_date,'%Y-%m-%d %H:%i:%s') storage_date,
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
replace(replace(remark,'\n',''),'\t','') remark,
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
gold_stone_code from $database.t_product_basic_info where 1=1 and date(storage_date)>='$do_date'"
}
import_t_product_fee(){
import_data t_product_fee " select 
id,
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
import_data t_product_model_basic " select 
id,
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
import_data t_product_model_discount " select 
id,
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
import_data t_product_model_fee " select 
id,
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
import_data t_province_salesman " select 
id,
province_salesman_identity,
province_code,
province,
salesman_id,
salesman_identity,
DATE_FORMAT(data_create_time,'%Y-%m-%d %H:%i:%s') data_create_time,
DATE_FORMAT(data_update_time,'%Y-%m-%d %H:%i:%s') data_update_time,
region,
showroom_identity
 from $database.t_province_salesman where 1=1 and date(data_update_time)>='$do_date'"
}
import_t_purity(){
import_data t_purity " select 
id,
purity_identity,
purity_code,
purity_name,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
status,
type,
purity_type,
help_code,
purity_percent,
basic_purity_identity,
technology_purity_identity from $database.t_purity where 1=1 and date(modify_date)>='$do_date'"
}
import_t_purity_engrave(){
import_data t_purity_engrave " select 
id,
purity_engrave_identity,
purity_identity,
purity_name,
engrave_name,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
type,
status from $database.t_purity_engrave where 1=1 and date(modify_date)>='$do_date'"
}
import_t_purity_tag(){
import_data t_purity_tag " select 
id,
purity_tag_identity,
purity_identity,
purity_name,
tag_name,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
type,
status from $database.t_purity_tag where 1=1 and date(modify_date)>='$do_date'"
}
import_t_qc(){
import_data t_qc " select 
id,
receive_identity,
receive_code,
purity_name,
qc_total_weight,
qc_total_number,
total_fee,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
supplier_identity,
supplier_name,
supplier_source,
supplier_type,
receive_type,
qc_status,
status,
qc_type from $database.t_qc where 1=1 and date(update_time)>='$do_date'"
}
import_t_qc_detial(){
import_data t_qc_detial " select 
id,
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
eos_order_detail_id
 from $database.t_qc_detial where 1=1"
}
import_t_queue_factory(){
import_data t_queue_factory " select 
queue_name,
queue_value,
DATE_FORMAT(queue_date,'%Y-%m-%d %H:%i:%s') queue_date,
reset from $database.t_queue_factory where 1=1 and date(queue_date)>='$do_date'"
}
import_t_reason_dictionaries(){
import_data t_reason_dictionaries " select id,
reason_name,
type,
status,
reason_type
 from $database.t_reason_dictionaries where 1=1"
}
import_t_reason_dictionaries_harmful(){
import_data t_reason_dictionaries_harmful " select 
id,
name,
type,
status from $database.t_reason_dictionaries_harmful where 1=1"
}
import_t_receive(){
import_data t_receive " select 
id,
receive_identity,
receive_code,
purity_name,
total_gold_weight,
total_number,
total_fee,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
supplier_type,
receive_type,
receive_status,
status,
end_reason,
supplier_identity,
supplier_name,
supplier_source,
variety,
first_status,
receive_reason,
qc_type,
if_all_return,
check_status,
color_gold_weight,
is_examine,
if_sure_price_ok,
if_product_code_add_ok,
showroom_name,
genus_name,
examine_by,
DATE_FORMAT(examine_time,'%Y-%m-%d %H:%i:%s') examine_time,
receive_remark,
total_fee_check,
showroom_identity,
counter_identity,
counter_name,
ppmc from $database.t_receive where 1=1 and date(update_time)>='$do_date'"
}
import_t_receive_check_account(){
import_data t_receive_check_account " select 
id,
check_account_identity,
counter_name,
counter_identity,
start_weight,
end_weight,
today_weight,
reality_weight,
is_delete,
DATE_FORMAT(check_date,'%Y-%m-%d %H:%i:%s') check_date,
create_user,
surplus,
firm_offer from $database.t_receive_check_account where 1=1 and date(check_date)>='$do_date'"
}
import_t_receive_check_account_detail(){
import_data t_receive_check_account_detail " select 
id,
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
check_date,
create_user,
surplus,
firm_offer from $database.t_receive_check_account_detail where 1=1"
}
import_t_receive_detial(){
import_data t_receive_detial " select 
id,
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
estimate_time,
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
import_data t_receive_detial_reword " select 
id,
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
import_data t_receive_detial_work_fee " select 
id,
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
import_data t_receive_difference_detail " select 
id,
receive_identity,
receive_code,
order_identity,
order_code,
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
replace(replace(remark,'\n',''),'\t','') remark,
status from $database.t_receive_difference_detail where 1=1"
}
import_t_receive_eos_order_purity(){
import_data t_receive_eos_order_purity " select 
id,
purity_name,
purity_type,
status from $database.t_receive_eos_order_purity where 1=1"
}
import_t_receive_eos_order_records(){
import_data t_receive_eos_order_records " select 
id,
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
receive_time,
audit_time,
create_by,
create_time,
update_by,
update_time,
order_code from $database.t_receive_eos_order_records where 1=1"
}
import_t_receive_flgfbh(){
import_data t_receive_flgfbh " select 
id,
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
DATE_FORMAT(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
shr,
shrid,
DATE_FORMAT(shsj,'%Y-%m-%d %H:%i:%s') shsj,
djzt,
gysmc,
gysbm,
zfr,
zfrid,
zfsj from $database.t_receive_flgfbh where 1=1 and date(zdsj)>='$do_date'"
}
import_t_receive_order(){
import_data t_receive_order " select 
id,
receive_identity,
order_identity from $database.t_receive_order where 1=1"
}
import_t_receive_payment_code_info(){
import_data t_receive_payment_code_info " select 
id,
payment_code,
payment_name,
product_photo from $database.t_receive_payment_code_info where 1=1"
}
import_t_receive_purity_mapping(){
import_data t_receive_purity_mapping " select 
id,
receive_purity_name,
purity_name,
status from $database.t_receive_purity_mapping where 1=1"
}
import_t_receive_status(){
import_data t_receive_status " select 
id,
number,
receive_style,
status from $database.t_receive_status where 1=1"
}
import_t_receive_stream_type(){
import_data t_receive_stream_type " select 
id,
type,
name from $database.t_receive_stream_type where 1=1"
}
import_t_sale_from(){
import_data t_sale_from " select 
id, sale_code, sale_identity, if_update_work_fee, if_tax_rate, tax_rate, area, showroom_identity, showroom_name,  DATE_FORMAT(sale_date,'%Y-%m-%d %H:%i:%s')  sale_date, purity_identity, sale_type, customer_identity, main_customer_identity, 
admin_settle_accounts_identity, settle_accounts_identity, grain_price, total_number, total_gold_weight, total_weight, total_additional_labour, total_conversion_gold, total_label_price, total_stone_price, total_price, replace(replace(remark,'\n',''),'\t','') remark, discount_remark, 
if_print_remark, create_by, DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s')  create_time, approve_by, DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time, approve_status, update_by,DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s')  update_time, 
if_update_discount, discount, if_gold_work_stone, if_retail, type, retail_work_fee, status, if_dydf, child_customer_code, settle_child_customer_code, jjjz, jjje, lljzhj, llgfhj, zqljzhj, zqlgfje, zqsjzhj, fyhj, zqgfhj, zqjz, tsjz, tsjehj, jsjzxj, 
jsjexj, qzl, lk, DATE_FORMAT(bill_date,'%Y-%m-%d %H:%i:%s') bill_date, synchronize_zds, meterial_weight, meterial_price, meterial_code, jewelry_weight, jewelry_price, jewelry_code, invalid_why, print_count, gold_price, 
bdze,DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time
 from $database.t_sale_from where 1=1 and date(bill_date)>='$do_date'"
}
import_t_sale_from_account(){
import_data t_sale_from_account " select 
id,
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
import_t_sale_from_account_detail(){
import_data t_sale_from_account_detail " select 
id,
row_id,
sale_account_identity,
sale_identity,
sale_account_detail_identity,
account_type,
work_fee_type,
account_method,
purity_identity,
purity_name,
product_style,
gold_price,
gold_weight,
unit_price,
work_fee,
amount,
replace(replace(remark,'\n',''),'\t','')  remark,
purification_work_fee,
purification_work_fee_amount,
conversion_gold_work_fee,
conversion_gold_amount,
base_work_fee,
base_work_fee_amount,
gold_income,
gold_material_price,
status,
parent_type,
content,
actual_content,
price,
big_category_attribution,
receive_meterial_code,
receive_meterial_detail_identity from $database.t_sale_from_account_detail where 1=1"
}
import_t_sale_from_detail(){
import_data t_sale_from_detail " select 
id,
sale_detail_identity,
sale_identity,
counter_name,
genus_name,
package_code,
total_number_detail,
net_weight,
package_i_code,
additional_labour,
update_additional_labour,
additional_labour_price,
replace(replace(remark,'\n',''),'\t','') remark,
small_remark,
status,
category_name,
second_category_name,
label_price,
batch_price,
other_price from $database.t_sale_from_detail where 1=1"
}
import_t_sale_summary_sync(){
import_data t_sale_summary_sync " select 
id,
djh,
customer_name,
customer_code,
order_weight,
purity_name,
zd_time,
network_name,
counter_name,
category_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
djlx from $database.t_sale_summary_sync where 1=1 and date(update_time)>='$do_date'"
}
import_t_sales_return(){
import_data t_sales_return " select 
id,
return_identity,
return_code,
receive_identity,
receive_code,
purity_name,
supplier_identity,
supplier_name,
supplier_source,
supplier_type,
return_total_weight,
return_total_number,
return_total_price,
return_time,
return_type,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
receive_reason,
receive_type,
return_status,
expected_delivery_time,
counter_identity,
counter_name,
gross_weight,
showroom_name,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
sale_return_remark,
examine_by,
DATE_FORMAT(examine_time,'%Y-%m-%d %H:%i:%s') examine_time,
check_number_all,
check_weight_all from $database.t_sales_return where 1=1 and date(update_time)>='$do_date'"
}
import_t_sales_return_detial(){
import_data t_sales_return_detial " select 
id,
receive_identity,
receive_code,
order_identity,
order_code,
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
img_url,
replace(replace(remark,'\n',''),'\t','') remark,
check_number_all,
check_weight_all from $database.t_sales_return_detial where 1=1"
}
import_t_sales_return_this_count(){
import_data t_sales_return_this_count " select 
id,
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
import_data t_salesman " select 
id,
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
replace(replace(remarks,'\n',''),'\t','') remarks,
DATE_FORMAT(etl_dt,'%Y-%m-%d %H:%i:%s') etl_dt,
is_deleted,
job_id,
job_identity,
phone_no1,
pub_openid1,
salesman_depart_identity,
salesman_role_identity,
history_permission,
salesman_region,
region_leader from $database.t_salesman where 1=1 and date(etl_dt)>='$do_date'"
}
import_t_salesman_area(){
import_data t_salesman_area " select 
id,
salesman_identity,
area_identity,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_salesman_area where 1=1 and date(update_time)>='$do_date'"
}
import_t_salesman_choose_log(){
import_data t_salesman_choose_log " select 
id,
customer_identity,
salesman_identity,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_salesman_choose_log where 1=1 and date(create_time)>='$do_date'"
}
import_t_salesman_depart(){
import_data t_salesman_depart " select 
id,
salesman_depart_identity,
salesman_depart_code,
salesman_depart_name,
father_depart_identity,
father_depart_code,
father_depart_name,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
DATE_FORMAT(update_date,'%Y-%m-%d %H:%i:%s') update_date from $database.t_salesman_depart where 1=1 and date(update_date)>='$do_date'"
}
import_t_salesman_log(){
import_data t_salesman_log " select 
id,
customer_id,
customer_identity,
showroom_identity,
salesman_id,
salesman_identity,
salesman_name,
react_type,
next_saleman_id,
next_saleman_identity,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
DATE_FORMAT(react_time,'%Y-%m-%d %H:%i:%s') react_time,
father_id,
showroom_code,
log_type,
replace(replace(remarks,'\n',''),'\t','') remarks,
father_salesman_id,
father_salesman_name,
DATE_FORMAT(insert_time,'%Y-%m-%d %H:%i:%s') insert_time
 from $database.t_salesman_log where 1=1 and date(create_time)>='$do_date'"
}
import_t_salesman_role(){
import_data t_salesman_role " select 
id,
salesman_role_identity,
salesman_role_code,
salesman_role_name,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
DATE_FORMAT(update_date,'%Y-%m-%d %H:%i:%s') update_date from $database.t_salesman_role where 1=1 "
}
import_t_salesman_time_log(){
import_data t_salesman_time_log " select 
id,
salesman_id,
salesman_identity,
salesman_name,
DATE_FORMAT(begin_out_date,'%Y-%m-%d %H:%i:%s') begin_out_date,
DATE_FORMAT(end_out_date,'%Y-%m-%d %H:%i:%s') end_out_date,
act_salesman_id,
act_salesman_identity,
act_salesman_name,
DATE_FORMAT(etl_dt,'%Y-%m-%d %H:%i:%s') etl_dt from $database.t_salesman_time_log where 1=1"
}
import_t_salesman_time_out(){
import_data t_salesman_time_out " select 
id,
timeout_type,
timeout_code from $database.t_salesman_time_out where 1=1"
}
import_t_settlement_stay(){
import_data t_settlement_stay " select 
id,
settlement_stay_identity,
fast_package_identity,
fast_package_code,
stay_status,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
create_user,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_settlement_stay where 1=1"
}
import_t_showroom(){
import_data t_showroom " select 
id,
showroom_identity,
showroom_code,
showroom_name,
status,
DATE_FORMAT(final_time,'%Y-%m-%d %H:%i:%s') final_time,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
longitude,
dimension,
showroom_type,
is_delete from $database.t_showroom where 1=1 and date(modify_date)>='$do_date'"
}
import_t_showroom_counter(){
import_data t_showroom_counter " select 
id,
counter_identity,
showroom_id,
showroom_identity,
counter_code,
counter_name,
showroom_code,
showroom_name,
stock_code,
stock_name,
modify_user_code,
modify_user_name,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
last_user_name,
DATE_FORMAT(last_date,'%Y-%m-%d %H:%i:%s') last_date,
purity_id,
purity_identity,
is_delete,
genus_id,
genus_identity,
code_seq,
create_time,
eos_zdrid,
eos_zdr,
type,
sort,
physical_identity,
physical_name,
is_single_piece,
is_metal_working,
is_default,
variety,
max_additional_labour,
max_technology_unit_price,
technology_purity_identity,
is_many_purity from $database.t_showroom_counter where 1=1 and date(modify_date)>='$do_date'"
}
import_t_showroom_counter_second(){
import_data t_showroom_counter_second " select 
id,
counter_name from $database.t_showroom_counter_second where 1=1"
}
import_t_showroom_storage_data(){
import_data t_showroom_storage_data " select 
showroom_name,
DATE_FORMAT(data_date,'%Y-%m-%d') data_date,
purity_name,
yestoday_weight,
in_storage_weight,
remain_weight from $database.t_showroom_storage_data where 1=1 and date(data_date)>='$do_date'"
}
import_t_special_style_discount(){
import_data t_special_style_discount " select 
style_code,
style_discount,
is_enable from $database.t_special_style_discount where 1=1"
}
import_t_splszh_log(){
import_data t_splszh_log " select 
id,
splszh_djLsh,
djLsh,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
fast_package_identity,
order_identity,
package_code,
status from $database.t_splszh_log where 1=1 and date(create_time)>='$do_date'"
}
import_t_stored_procedure_log(){
import_data t_stored_procedure_log " select 
id,
execute_id,
stored_procedure_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user,
log from $database.t_stored_procedure_log where 1=1 and date(create_time)>='$do_date'"
}
import_t_stored_procedure_status(){
import_data t_stored_procedure_status " select 
id,
stored_procedure_name,
execute_status from $database.t_stored_procedure_status where 1=1"
}
import_t_supplier(){
import_data t_supplier " select 
id,
supplier_identity,
supplier_source,
supplier_type,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_by,
status from $database.t_supplier where 1=1 and date(update_time)>='$do_date'"
}
import_t_supplier_detial(){
import_data t_supplier_detial " select 
id,
supplier_name,
supplier_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
supplier_code,
customer_identity,
type,
djlsh from $database.t_supplier_detial where 1=1 and date(update_time)>='$do_date'"
}
import_t_supplier_rebate(){
import_data t_supplier_rebate " select 
id,
supplier_identity,
supplier_name,
supplier_source,
rebate,
rebate_money,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
rebate_enable from $database.t_supplier_rebate where 1=1 and date(update_time)>='$do_date'"
}
import_t_sync_time(){
import_data t_sync_time " select 
id,
code,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_sync_time where 1=1"
}
import_t_szpxgfjcbh(){
import_data t_szpxgfjcbh " select 
DjLsh,
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
ZDSJ,
XGRID,
XGR,
XGSJ from $database.t_szpxgfjcbh where 1=1"
}
import_t_technology_purity(){
import_data t_technology_purity " select 
id,
purity_name from $database.t_technology_purity where 1=1"
}
import_t_temp_customer_transform(){
import_data t_temp_customer_transform " select 
SOURCE,
DJLSH,
CUSTOMER_IDENTITY_999,
KHBM_999,
KHMC_999,
ZKH_999,
CUSTOMER_IDENTITY,
KHBM,
KHMC,
ZKH,
TECH_PURITY_NAME from $database.t_temp_customer_transform where 1=1"
}
import_t_temp_interest_adjust_money_record(){
import_data t_temp_interest_adjust_money_record " select 
append_date,
append_record_name,
djlsh,
out_customer_code,
append_amount,
append_fee,
in_customer_code from $database.t_temp_interest_adjust_money_record where 1=1"
}
import_t_temp_lllsz(){
import_data t_temp_lllsz " select 
wdmc,
customer_identity,
khbm,
khmc,
zkh,
tech_purity_name,
djm,
djh,
swlx,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
jz from $database.t_temp_lllsz where 1=1 and date(rq)>='$do_date'"
}
import_t_temp_trans_history(){
import_data t_temp_trans_history " select 
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
khbm_old,
khbm,
khmc,
zkh,
customer_identity,
purity_name,
khbm_999,
khmc_999,
zkh_999,
djje,
djjz from $database.t_temp_trans_history where 1=1 and date(rq)>='$do_date'"
}
import_t_temp_ysmxz(){
import_data t_temp_ysmxz " select 
ysmxz_h_identity,
ysmxz_b_identity,
customer_identity,
wdmc,
khbm,
khmc,
zkh,
tech_purity_name,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
djm,
djh,
fs,
djje,
jjje,
gfje,
DATE_FORMAT(hkshrq,'%Y-%m-%d %H:%i:%s') hkshrq,
swlb from $database.t_temp_ysmxz where 1=1 and date(rq)>='$do_date'"
}
import_t_temp_ywy(){
import_data t_temp_ywy " select 
CZR,
CZRID,
je from $database.t_temp_ywy where 1=1"
}
import_t_tran_miss_package(){
import_data t_tran_miss_package " select 
djlsh,
fast_package_identity from $database.t_tran_miss_package where 1=1"
}
import_t_tykhgjb(){
import_data t_tykhgjb " select 
DjLsh,
DjBth,
DjState,
WDMC,
KHMC,
KHBM,
ZKH,
CSGS,
CRBS,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_tykhgjb where 1=1 and date(update_time)>='$do_date'"
}
import_t_tykhgjh(){
import_data t_tykhgjh " select 
DjLsh,
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
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_tykhgjh where 1=1 and date(update_time)>='$do_date'"
}
import_t_wechat_message_log(){
import_data t_wechat_message_log " select 
id,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
type,
content,
success,
error_message from $database.t_wechat_message_log where 1=1 and date(create_time)>='$do_date'"
}
import_t_wechat_pub(){
import_data t_wechat_pub " select 
id,
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
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date from $database.t_wechat_pub where 1=1 and date(modify_date)>='$do_date'"
}
import_t_wechat_smallroutine(){
import_data t_wechat_smallroutine " select 
id,
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
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date from $database.t_wechat_smallroutine where 1=1 and date(modify_date)>='$do_date'"
}
import_t_wholesaling_category_info(){
import_data t_wholesaling_category_info " select 
id,
type_coding,
type_code,
type_name,
status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_wholesaling_category_info where 1=1 and date(create_time)>='$do_date'"
}
import_t_work_fee_detail(){
import_data t_work_fee_detail " select 
id,
work_fee_id,
fee_count,
subtotal,
fee_unit_price,
name from $database.t_work_fee_detail where 1=1"
}
import_temp_csmc(){
import_data temp_csmc " select 
csmc,
khbm from $database.temp_csmc where 1=1"
}
import_temp_customer_hw(){
import_data temp_customer_hw " select 
WDMC,
CUSTOMER_IDENTITY,
KHBM,
KHMC,
ZKHMC,
CSMC,
PQMC,
SJXQMC,
DJSXX,
SXQXX,
KHBH from $database.temp_customer_hw where 1=1"
}
import_tykhgjb_eos(){
import_data tykhgjb_eos " select 
DjLsh,
DjBth,
DjState,
WDMC,
KHMC,
KHBM,
ZKH,
CSGS,
CRBS from $database.tykhgjb_eos where 1=1"
}
import_tykhgjh_eos(){
import_data tykhgjh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
GSWD,
TYKHMC,
TYKHBM,
WHR,
ZHWHSJ from $database.tykhgjh_eos where 1=1"
}
import_v_hw(){
import_data v_hw " select 
id,
customer_id,
customer_identity,
child_customer_identity,
child_customer_name,
child_customer_code,
child_customer_seq,
contact_name,
phone_no,
phone_no_b,
customer_address,
help_code,
active_flag,
legal_person,
id_code,
province,
data_date,
ty_customer_code,
djlsh,
djbth from $database.v_hw where 1=1"
}
import_view_customer(){
import_data view_customer " select 
wdmc,
customer_identity,
customer_code,
customer_name,
parent_customer_code,
parent_customer_name,
child_customer_name,
area_name,
province_name,
city_name,
county_name,
child_customer_code,
is_child,
active_flag,
is_supplier,
purity_name,
license_desc,
area_name_business from $database.view_customer where 1=1"
}
import_view_oa_customer_1(){
import_data view_oa_customer_1 " select 
customer_code,
customer_name,
child_customer_name,
bj,
gf,
lx,
qlzl,
wdmc
 from $database.view_oa_customer_1 where 1=1"
}
import_wdmlh(){
import_data wdmlh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
QY,
kdwddm,
gdwddm,
wdbm,
wdmc,
wdfzr,
wdjc,
yyzt,
sjbm,
sjmc,
sjdm,
djsbm,
djsmc,
xsqbm,
xsqmc,
xslx,
wdlx,
pqbm,
pqmc,
lwdbm,
zjm,
zhwhrm,
DATE_FORMAT(zhwhrq,'%Y-%m-%d %H:%i:%s') zhwhrq,
gsbm,
gsmc,
glkc,
jsxs,
jkhbm,
psbz,
jcdw,
jbmbm,
kxkhbm,
lxdh,
txdz,
JLZ,
DATE_FORMAT(JLSJ,'%Y-%m-%d %H:%i:%s') JLSJ,
BTXS,
CKCZ,
EWMXS,
SDGSWD from $database.wdmlh where 1=1 and date(zhwhrq)>='$do_date'"
}
import_wgkhyhbh(){
import_data wgkhyhbh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
DJH,
WDBM,
WDMC,
KHBM,
KHMC,
ZKHMC,
ZKHBH,
KHZK,
LJJGF,
ZDRID,
ZDR,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
XGRID,
XGR,
DATE_FORMAT(XGSJ,'%Y-%m-%d %H:%i:%s') XGSJ,
replace(replace(BZ,'\n',''),'\t','') BZ,
ZQCE,
Z,
KHQY from $database.wgkhyhbh where 1=1 and date(ZDSJ)>='$do_date'"
}
import_wgpxgfbh(){
import_data wgpxgfbh " select 
DjLsh,
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
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
XGRID,
XGR,
DATE_FORMAT(XGSJ,'%Y-%m-%d %H:%i:%s') XGSJ from $database.wgpxgfbh where 1=1 and date(ZDSJ)>='$do_date'"
}
import_wj(){
import_data wj " select 
xh,
sf,
khmc,
replace(replace(BZ,'\n',''),'\t','') bz,
zy,
zkhyy,
sfks,
sqqx,
xtkhmc,
xtzkhmc,
customer_identity from $database.wj where 1=1"
}
import_wz(){
import_data wz " select 
xh,
sf,
khmc,
bz,
zy,
zkhyy,
sfks,
sqqx,
xtkhmc,
xtzkhmc,
customer_identity,
expired_date from $database.wz where 1=1"
}
import_xltjh_eos(){
import_data xltjh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDMC,
KHBM,
KHMC,
ZKH from $database.xltjh_eos where 1=1"
}
import_xsdszb(){
import_data xsdszb " select 
DjLsh,
DjBth,
DjState,
BTXH,
cpbh,
ckmc,
KHBM,
KHMC,
ZKHB,
plmc,
YJPL,
EJPL,
jz,
jsbm,
JSMC,
jsb,
fjgf,
DZFJGF,
fjgfje,
replace(replace(BZ,'\n',''),'\t','') bz,
plbm,
bh,
csbm,
csmc,
cs,
btjs,
ckbm,
bzgf,
JSDH,
BZB,
SHD,
YCK,
SFGZ,
THDH,
THDJM,
CPBZT,
MZ,
JGF,
JGFJE,
YFJGF,
LJJJE,
PLJJGF from $database.xsdszb where 1=1"
}
import_xsdszf(){
import_data xsdszf " select 
DjLsh,
DjFth,
DjState,
LLDXH,
FTXH,
fs,
lldh,
CSMCF,
PLMCF,
JZF,
HLF,
QZJJF,
DJ,
gf,
gfje,
bzf,
cj,
WJJZ,
YJJZ,
FTJS,
llrq,
CSBMF,
PLBMF,
LLDJH,
ZXDJ,
ZDDJ,
ZDJCGF,
ZXJCGF,
LLJZ,
ZQGFBM,
ZQGFLX,
TCGF,
TCGFJE,
ZSGF,
ZSJE,
JCGF,
JCGFJE,
JSR,
JLJ from $database.xsdszf where 1=1"
}
import_xsdszh(){
import_data xsdszh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
XSBZ,
XZZKH,
CZKH,
KHLLJZ,
KHLLJE,
KHTSDJH,
KHLLDJH,
KHTSGFJE,
TSJZHJ,
ZKHH,
djzt,
djh,
ZDBC,
SCSKDH,
cpbjh,
KHZJM,
bzh,
csbmh,
csmch,
hlH,
plmcH,
plbmh,
CZKHBM,
JSKH,
JSKHBM,
ZKH,
ZKHBM,
khlxr,
jjjz,
jjje,
qtfy,
fhlx,
rq,
zdr,
zdrid,
zdsj,
wdbm,
wdmc,
WDLX,
shr,
shrid,
shsj,
fjgfhj,
ckjzhj,
lljzhj,
ZQSJZHJ,
FYHJ,
JSHJ,
jehj,
llgfhj,
ZQLGFJE,
zqplbm,
ZQLJZHJ,
xjsq,
gsbm,
gsmc,
wfje,
yfje,
bths,
fths,
llhs,
ZQLXS,
ZQSXS,
jjhs,
jj,
WJJZXJ,
jsjzxj,
jsjexj,
ZFRQ,
DZGF,
DZGFH,
BQJEHJ,
ZJM,
DST,
YBF,
LXGF,
LXJJJE,
KHBH,
ZXBS,
DYCS,
DYSJ,
QY,
KXED,
LSED,
SPR,
YXKD,
KQZE,
BDZE,
KXZQ,
KQZL,
JJJ,
KXKHBM,
KX,
FJHS,
B2BXS,
ZQCE,
LJ,
GFH,
push_status from $database.xsdszh where 1=1"
}
import_xsdszh_history_eos(){
import_data xsdszh_history_eos " select 
tabName,
DATE_FORMAT(jsrq,'%Y-%m-%d %H:%i:%s') jsrq,
customer_code,
csmc from $database.xsdszh_history_eos where 1=1 and date(jsrq)>='$do_date'"
}
import_yflmxzh_eos(){
import_data yflmxzh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDMC,
khbm,
khmc,
lxr,
CSBM,
CSMC,
plbm,
plmc,
JZ,
khlx from $database.yflmxzh_eos where 1=1"
}
import_yfmxzh_eos(){
import_data yfmxzh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDMC,
khbm,
khmc,
ZKH,
LB,
je,
bb,
khlx,
zjm from $database.yfmxzh_eos where 1=1"
}
import_yjgfbh(){
import_data yjgfbh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDBM,
WDMC,
KHMC,
KHBM,
ZJM,
ZKHH,
ZKH,
ZKHBH,
ZDR,
ZDRID,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
ZHXGR,
SHRID,
DATE_FORMAT(SHSJ,'%Y-%m-%d %H:%i:%s') SHSJ,
BZ,
MRGF,
Z,
Z1,
ZQCE,
KHQY from $database.yjgfbh where 1=1 and date(ZDSJ)>='$do_date'"
}
import_ysmxzb_eos(){
import_data ysmxzb_eos " select 
djlsh,
djbth,
djstate,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
djh,
djm,
swlb,
djje,
wfje,
yfje,
replace(replace(BZ,'\n',''),'\t','') bz,
DATE_FORMAT(zhskrq,'%Y-%m-%d %H:%i:%s') zhskrq,
csbm,
csmc,
plbm,
plmc,
dcwdmc,
fs,
jjje,
gfje,
DATE_FORMAT(hkshrq,'%Y-%m-%d %H:%i:%s') hkshrq,
ybf,
hkjsfs,
gylx from $database.ysmxzb_eos where 1=1 and date(rq)>='$do_date'"
}
import_ysmxzh_eos(){
import_data ysmxzh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDMC,
khbm,
khmc,
ZKH,
LB,
je,
bb,
khlx,
zjm,
YJKH from $database.ysmxzh_eos where 1=1"
}
import_zjyezh_eos(){
import_data zjyezh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
gsmc,
ZH,
JE,
ZJLX,
YX,
YXZH
 from $database.zjyezh_eos where 1=1"
}
import_zy5g(){
import_data zy5g " select 
xh,
sf,
khmc,
replace(replace(BZ,'\n',''),'\t','') bz,
zy,
zkhyy,
sfks,
sqqx,
xtkhmc,
xtzkhmc,
customer_identity from $database.zy5g where 1=1"
}
import_zyyj(){
import_data zyyj " select 
xh,
sf,
khmc,
replace(replace(BZ,'\n',''),'\t','') bz,
zy,
zkhyy,
sfks,
sqqx,
xtkhmc,
xtzkhmc,
customer_identity from $database.zyyj where 1=1"
}
case $1 in
"rp_szztxsrb")
import_rp_szztxsrb
;;
"t_approve_record")
import_t_approve_record
;;
"t_b_menu")
import_t_b_menu
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
"t_bf_area")
import_t_bf_area
;;
"t_bf_bank_deposit_bill_sz")
import_t_bf_bank_deposit_bill_sz
;;
"t_bf_bank_deposit_bill_sz_detail")
import_t_bf_bank_deposit_bill_sz_detail
;;
"t_bf_buy_cus_item")
import_t_bf_buy_cus_item
;;
"t_bf_buy_cus_item_detail")
import_t_bf_buy_cus_item_detail
;;
"t_bf_buy_cus_material")
import_t_bf_buy_cus_material
;;
"t_bf_buy_cus_material_detail")
import_t_bf_buy_cus_material_detail
;;
"t_bf_buyback_material")
import_t_bf_buyback_material
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
"t_bf_cus_credit_receipt")
import_t_bf_cus_credit_receipt
;;
"t_bf_cus_credit_receipt_detail")
import_t_bf_cus_credit_receipt_detail
;;
"t_bf_cus_debit_receipt")
import_t_bf_cus_debit_receipt
;;
"t_bf_cus_debit_receipt_detail")
import_t_bf_cus_debit_receipt_detail
;;
"t_bf_cus_debit_receipt_record")
import_t_bf_cus_debit_receipt_record
;;
"t_bf_cust_return_jewelry")
import_t_bf_cust_return_jewelry
;;
"t_bf_cust_return_jewelry_detail")
import_t_bf_cust_return_jewelry_detail
;;
"t_bf_customer_the_bill")
import_t_bf_customer_the_bill
;;
"t_bf_deliver_goods_from")
import_t_bf_deliver_goods_from
;;
"t_bf_deliver_goods_from_detail")
import_t_bf_deliver_goods_from_detail
;;
"t_bf_dkhhy_b")
import_t_bf_dkhhy_b
;;
"t_bf_dkhhy_h")
import_t_bf_dkhhy_h
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
"t_bf_gold_transfer_in")
import_t_bf_gold_transfer_in
;;
"t_bf_gold_transfer_in_detail")
import_t_bf_gold_transfer_in_detail
;;
"t_bf_gold_transfer_out")
import_t_bf_gold_transfer_out
;;
"t_bf_gold_transfer_out_detail")
import_t_bf_gold_transfer_out_detail
;;
"t_bf_gold_transfer_out_print")
import_t_bf_gold_transfer_out_print
;;
"t_bf_gold_transfer_out_print_detail")
import_t_bf_gold_transfer_out_print_detail
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
"t_bf_pay_cus_material")
import_t_bf_pay_cus_material
;;
"t_bf_pay_cus_material_detail")
import_t_bf_pay_cus_material_detail
;;
"t_bf_pay_outsource")
import_t_bf_pay_outsource
;;
"t_bf_pay_outsource_detail")
import_t_bf_pay_outsource_detail
;;
"t_bf_payment_order")
import_t_bf_payment_order
;;
"t_bf_payment_order_detail")
import_t_bf_payment_order_detail
;;
"t_bf_purify_detail")
import_t_bf_purify_detail
;;
"t_bf_raw_material")
import_t_bf_raw_material
;;
"t_bf_ready_money")
import_t_bf_ready_money
;;
"t_bf_receive_meterial")
import_t_bf_receive_meterial
;;
"t_bf_receive_meterial_detail")
import_t_bf_receive_meterial_detail
;;
"t_bf_remark")
import_t_bf_remark
;;
"t_bf_repair")
import_t_bf_repair
;;
"t_bf_retreat")
import_t_bf_retreat
;;
"t_bf_sales_ticket_print_zds")
import_t_bf_sales_ticket_print_zds
;;
"t_bf_sales_ticket_print_zds_detail")
import_t_bf_sales_ticket_print_zds_detail
;;
"t_bf_settlement")
import_t_bf_settlement
;;
"t_bf_settlement_adjustment_price")
import_t_bf_settlement_adjustment_price
;;
"t_bf_stock_transfer_bill")
import_t_bf_stock_transfer_bill
;;
"t_bf_stock_transfer_bill_detail")
import_t_bf_stock_transfer_bill_detail
;;
"t_bf_stock_transfer_bill_detail_hw")
import_t_bf_stock_transfer_bill_detail_hw
;;
"t_bf_stock_transfer_bill_hw")
import_t_bf_stock_transfer_bill_hw
;;
"t_bf_szztgzspd")
import_t_bf_szztgzspd
;;
"t_bf_szztgzspd_detail")
import_t_bf_szztgzspd_detail
;;
"t_bf_temporary_money_form")
import_t_bf_temporary_money_form
;;
"t_bf_the_bill")
import_t_bf_the_bill
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
"t_child_customer")
import_t_child_customer
;;
"t_child_customer_id_djbth")
import_t_child_customer_id_djbth
;;
"t_client_discount")
import_t_client_discount
;;
"t_columns")
import_t_columns
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
"t_cover_customer_log")
import_t_cover_customer_log
;;
"t_cpbszb")
import_t_cpbszb
;;
"t_cpbszb_log")
import_t_cpbszb_log
;;
"t_cpbszh")
import_t_cpbszh
;;
"t_cpbszh_log")
import_t_cpbszh_log
;;
"t_cpbszh_log_detail")
import_t_cpbszh_log_detail
;;
"t_custom_column")
import_t_custom_column
;;
"t_customer")
import_t_customer
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
"t_customer_phone_cp")
import_t_customer_phone_cp
;;
"t_customer_salesman")
import_t_customer_salesman
;;
"t_customer_tag")
import_t_customer_tag
;;
"t_customer_type")
import_t_customer_type
;;
"t_daily_interrest_err_log")
import_t_daily_interrest_err_log
;;
"t_daily_interrest_log")
import_t_daily_interrest_log
;;
"t_default_discount_mosaic")
import_t_default_discount_mosaic
;;
"t_delay_region")
import_t_delay_region
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
"t_djjz_procedure_excute_err_log")
import_t_djjz_procedure_excute_err_log
;;
"t_download")
import_t_download
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
"t_estimate_update_log")
import_t_estimate_update_log
;;
"t_fast_cus")
import_t_fast_cus
;;
"t_fast_customer")
import_t_fast_customer
;;
"t_fast_order")
import_t_fast_order
;;
"t_fast_order_purity")
import_t_fast_order_purity
;;
"t_fast_package")
import_t_fast_package
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
"t_fast_package_i")
import_t_fast_package_i
;;
"t_fast_package_i_plastic")
import_t_fast_package_i_plastic
;;
"t_fast_package_i_product")
import_t_fast_package_i_product
;;
"t_fast_package_operation_log")
import_t_fast_package_operation_log
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
"t_finance_customer_relation")
import_t_finance_customer_relation
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
"t_gf_area_customer")
import_t_gf_area_customer
;;
"t_history_data_move_log")
import_t_history_data_move_log
;;
"t_hw_model_fee")
import_t_hw_model_fee
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
"t_insert_log_fail")
import_t_insert_log_fail
;;
"t_ka_kxjczb")
import_t_ka_kxjczb
;;
"t_ka_lllsz")
import_t_ka_lllsz
;;
"t_ka_llmxz_b")
import_t_ka_llmxz_b
;;
"t_ka_llmxz_h")
import_t_ka_llmxz_h
;;
"t_ka_lscqmxb_b")
import_t_ka_lscqmxb_b
;;
"t_ka_lscqmxb_h")
import_t_ka_lscqmxb_h
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
"t_ka_splsz")
import_t_ka_splsz
;;
"t_ka_splsz_hw")
import_t_ka_splsz_hw
;;
"t_ka_szdzsqdh")
import_t_ka_szdzsqdh
;;
"t_ka_szdzsqdh_temp")
import_t_ka_szdzsqdh_temp
;;
"t_ka_szkhcqlxzz_b")
import_t_ka_szkhcqlxzz_b
;;
"t_ka_szkhcqlxzz_b_history")
import_t_ka_szkhcqlxzz_b_history
;;
"t_ka_szkhcqlxzz_f")
import_t_ka_szkhcqlxzz_f
;;
"t_ka_szkhcqlxzz_f_history")
import_t_ka_szkhcqlxzz_f_history
;;
"t_ka_szkhcqlxzz_h")
import_t_ka_szkhcqlxzz_h
;;
"t_ka_szkhcqlxzz_h_history")
import_t_ka_szkhcqlxzz_h_history
;;
"t_ka_szkhcqlxzzfb_h")
import_t_ka_szkhcqlxzzfb_h
;;
"t_ka_szkhcqmx_b")
import_t_ka_szkhcqmx_b
;;
"t_ka_szkhcqmx_f")
import_t_ka_szkhcqmx_f
;;
"t_ka_szkhcqmx_h")
import_t_ka_szkhcqmx_h
;;
"t_ka_szlxjsrq")
import_t_ka_szlxjsrq
;;
"t_ka_xltj_b")
import_t_ka_xltj_b
;;
"t_ka_xltj_h")
import_t_ka_xltj_h
;;
"t_ka_yfllsz")
import_t_ka_yfllsz
;;
"t_ka_yflmxz")
import_t_ka_yflmxz
;;
"t_ka_yflsz")
import_t_ka_yflsz
;;
"t_ka_yfmxz")
import_t_ka_yfmxz
;;
"t_ka_yfrzzh")
import_t_ka_yfrzzh
;;
"t_ka_yfrzzh_hw")
import_t_ka_yfrzzh_hw
;;
"t_ka_yhrq")
import_t_ka_yhrq
;;
"t_ka_yslsz")
import_t_ka_yslsz
;;
"t_ka_ysmxz_b")
import_t_ka_ysmxz_b
;;
"t_ka_ysmxz_h")
import_t_ka_ysmxz_h
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
"t_ka_zrye")
import_t_ka_zrye
;;
"t_ka_ztkcrzz")
import_t_ka_ztkcrzz
;;
"t_ka_ztkczz")
import_t_ka_ztkczz
;;
"t_khxxszb")
import_t_khxxszb
;;
"t_kj_child_customer")
import_t_kj_child_customer
;;
"t_kj_customer")
import_t_kj_customer
;;
"t_late_transfer_log")
import_t_late_transfer_log
;;
"t_login_log")
import_t_login_log
;;
"t_material_price_rule")
import_t_material_price_rule
;;
"t_move_counter")
import_t_move_counter
;;
"t_move_counter_detail")
import_t_move_counter_detail
;;
"t_mxzh")
import_t_mxzh
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
"t_purity")
import_t_purity
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
"t_receive")
import_t_receive
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
"t_sale_from")
import_t_sale_from
;;
"t_sale_from_account")
import_t_sale_from_account
;;
"t_sale_from_account_detail")
import_t_sale_from_account_detail
;;
"t_sale_from_detail")
import_t_sale_from_detail
;;
"t_sale_summary_sync")
import_t_sale_summary_sync
;;
"t_sales_return")
import_t_sales_return
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
"t_salesman_choose_log")
import_t_salesman_choose_log
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
"t_showroom")
import_t_showroom
;;
"t_showroom_counter")
import_t_showroom_counter
;;
"t_showroom_counter_second")
import_t_showroom_counter_second
;;
"t_showroom_storage_data")
import_t_showroom_storage_data
;;
"t_special_style_discount")
import_t_special_style_discount
;;
"t_stored_procedure_log")
import_t_stored_procedure_log
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
"t_technology_purity")
import_t_technology_purity
;;
"t_temp_customer_transform")
import_t_temp_customer_transform
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
"t_wechat_message_log")
import_t_wechat_message_log
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
"temp_csmc")
import_temp_csmc
;;
"temp_customer_hw")
import_temp_customer_hw
;;
"tykhgjb_eos")
import_tykhgjb_eos
;;
"tykhgjh_eos")
import_tykhgjh_eos
;;
"v_hw")
import_v_hw
;;
"view_customer")
import_view_customer
;;
"view_oa_customer_1")
import_view_oa_customer_1
;;
"wdmlh")
import_wdmlh
;;
"wgkhyhbh")
import_wgkhyhbh
;;
"wgpxgfbh")
import_wgpxgfbh
;;
"wj")
import_wj
;;
"wz")
import_wz
;;
"xltjh_eos")
import_xltjh_eos
;;
"xsdszb")
import_xsdszb
;;
"xsdszf")
import_xsdszf
;;
"xsdszh")
import_xsdszh
;;
"xsdszh_history_eos")
import_xsdszh_history_eos
;;
"yflmxzh_eos")
import_yflmxzh_eos
;;
"yfmxzh_eos")
import_yfmxzh_eos
;;
"yjgfbh")
import_yjgfbh
;;
"ysmxzb_eos")
import_ysmxzb_eos
;;
"ysmxzh_eos")
import_ysmxzh_eos
;;
"zjyezh_eos")
import_zjyezh_eos
;;
"zy5g")
import_zy5g
;;
"zyyj")
import_zyyj
;;	
"all")
import_rp_szztxsrb
import_t_approve_record
import_t_b_menu
import_t_basic_purity
import_t_bf_account_type_category
import_t_bf_allocate_transfer
import_t_bf_allocation_fee
import_t_bf_allocation_fee_add_price
import_t_bf_ancient_law_cus_discount
import_t_bf_ancient_law_cus_discount_detail
import_t_bf_area
import_t_bf_bank_deposit_bill_sz
import_t_bf_bank_deposit_bill_sz_detail
import_t_bf_buy_cus_item
import_t_bf_buy_cus_item_detail
import_t_bf_buy_cus_material
import_t_bf_buy_cus_material_detail
import_t_bf_buyback_material
import_t_bf_change_purity
import_t_bf_collect_money_account
import_t_bf_collect_money_style
import_t_bf_current_wholesale_gold_price
import_t_bf_current_wholesale_gold_price_history
import_t_bf_current_wholesale_gold_price_history_detail
import_t_bf_cus_credit_receipt
import_t_bf_cus_credit_receipt_detail
import_t_bf_cus_debit_receipt
import_t_bf_cus_debit_receipt_detail
import_t_bf_cus_debit_receipt_record
import_t_bf_cust_return_jewelry
import_t_bf_cust_return_jewelry_detail
import_t_bf_customer_the_bill
import_t_bf_deliver_goods_from
import_t_bf_deliver_goods_from_detail
import_t_bf_dkhhy_b
import_t_bf_dkhhy_h
import_t_bf_dzddydy
import_t_bf_financial_block_list
import_t_bf_five_g_cus_discount
import_t_bf_gold_inlay_transfer_in
import_t_bf_gold_inlay_transfer_in_detail
import_t_bf_gold_inlay_transfer_out
import_t_bf_gold_inlay_transfer_out_detail
import_t_bf_gold_transfer_change
import_t_bf_gold_transfer_change_detail
import_t_bf_gold_transfer_in
import_t_bf_gold_transfer_in_detail
import_t_bf_gold_transfer_out
import_t_bf_gold_transfer_out_detail
import_t_bf_gold_transfer_out_print
import_t_bf_gold_transfer_out_print_detail
import_t_bf_hard_gold_work_fee
import_t_bf_initial_inventory_bill
import_t_bf_inlaid_metal_average_daily
import_t_bf_interest_st_adj_item
import_t_bf_khlsedb
import_t_bf_material_explain
import_t_bf_other_showroom_customer_block_list
import_t_bf_pay_cus_material
import_t_bf_pay_cus_material_detail
import_t_bf_pay_outsource
import_t_bf_pay_outsource_detail
import_t_bf_payment_order
import_t_bf_payment_order_detail
import_t_bf_purify_detail
import_t_bf_raw_material
import_t_bf_ready_money
import_t_bf_receive_meterial
import_t_bf_receive_meterial_detail
import_t_bf_remark
import_t_bf_repair
import_t_bf_retreat
import_t_bf_sales_ticket_print_zds
import_t_bf_sales_ticket_print_zds_detail
import_t_bf_settlement
import_t_bf_settlement_adjustment_price
import_t_bf_stock_transfer_bill
import_t_bf_stock_transfer_bill_detail
import_t_bf_stock_transfer_bill_detail_hw
import_t_bf_stock_transfer_bill_hw
import_t_bf_szztgzspd
import_t_bf_szztgzspd_detail
import_t_bf_temporary_money_form
import_t_bf_the_bill
import_t_bf_transfer_owed_work_fee_from
import_t_bf_transfer_owed_work_fee_input
import_t_bf_transfer_owed_work_fee_input_detail
import_t_bf_transfer_type
import_t_bf_warehouse_type
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
import_t_child_customer
import_t_child_customer_id_djbth
import_t_client_discount
import_t_columns
import_t_counter_account
import_t_counter_account_5ga
import_t_counter_like
import_t_counter_message
import_t_cover_customer_log
import_t_cpbszb
import_t_cpbszb_log
import_t_cpbszh
import_t_cpbszh_log
import_t_cpbszh_log_detail
import_t_custom_column
import_t_customer
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
import_t_customer_phone_cp
import_t_customer_salesman
import_t_customer_tag
import_t_customer_type
import_t_daily_interrest_err_log
import_t_daily_interrest_log
import_t_default_discount_mosaic
import_t_delay_region
import_t_delay_task
import_t_delay_task_detail
import_t_deposit_jewelry
import_t_deposit_order
import_t_deposit_setting
import_t_djjz_procedure_excute_err_log
import_t_download
import_t_eos_fail
import_t_eos_order
import_t_eos_order_detial
import_t_estimate_update_log
import_t_fast_cus
import_t_fast_customer
import_t_fast_order
import_t_fast_order_purity
import_t_fast_package
import_t_fast_package_delete
import_t_fast_package_engrave
import_t_fast_package_flowing
import_t_fast_package_i
import_t_fast_package_i_plastic
import_t_fast_package_i_product
import_t_fast_package_operation_log
import_t_fast_package_reason
import_t_fast_package_record
import_t_fast_package_status
import_t_fast_package_tag
import_t_fast_package_update_customer
import_t_fast_technology_price
import_t_finance_customer_info
import_t_finance_customer_relation
import_t_fjgfzkbb_sync
import_t_fjgfzkbh_sync
import_t_gemstone_attribute
import_t_genus
import_t_gf_area_customer
import_t_history_data_move_log
import_t_hw_model_fee
import_t_incoming_difference
import_t_incoming_maintain
import_t_initial_package_update_customer
import_t_initial_weight
import_t_initial_weight_delete
import_t_initial_weight_record
import_t_initial_weight_status
import_t_insert_log_fail
import_t_ka_kxjczb
import_t_ka_lllsz
import_t_ka_llmxz_b
import_t_ka_llmxz_h
import_t_ka_lscqmxb_b
import_t_ka_lscqmxb_h
import_t_ka_lsedzb
import_t_ka_lsz_h
import_t_ka_mxz
import_t_ka_mxz_update
import_t_ka_spkcmxz
import_t_ka_splsz
import_t_ka_splsz_hw
import_t_ka_szdzsqdh
import_t_ka_szdzsqdh_temp
import_t_ka_szkhcqlxzz_b
import_t_ka_szkhcqlxzz_b_history
import_t_ka_szkhcqlxzz_f
import_t_ka_szkhcqlxzz_f_history
import_t_ka_szkhcqlxzz_h
import_t_ka_szkhcqlxzz_h_history
import_t_ka_szkhcqlxzzfb_h
import_t_ka_szkhcqmx_b
import_t_ka_szkhcqmx_f
import_t_ka_szkhcqmx_h
import_t_ka_szlxjsrq
import_t_ka_xltj_b
import_t_ka_xltj_h
import_t_ka_yfllsz
import_t_ka_yflmxz
import_t_ka_yflsz
import_t_ka_yfmxz
import_t_ka_yfrzzh
import_t_ka_yfrzzh_hw
import_t_ka_yhrq
import_t_ka_yslsz
import_t_ka_ysmxz_b
import_t_ka_ysmxz_h
import_t_ka_ysmxz_s
import_t_ka_ysmxz_sold
import_t_ka_zjlsz
import_t_ka_zjyez
import_t_ka_zrye
import_t_ka_ztkcrzz
import_t_ka_ztkczz
import_t_kj_child_customer
import_t_kj_customer
import_t_late_transfer_log
import_t_login_log
import_t_material_price_rule
import_t_move_counter
import_t_move_counter_detail
import_t_mxzh
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
import_t_purity
import_t_purity_engrave
import_t_purity_tag
import_t_qc
import_t_qc_detial
import_t_queue_factory
import_t_reason_dictionaries
import_t_reason_dictionaries_harmful
import_t_receive
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
import_t_sale_from
import_t_sale_from_account
import_t_sale_from_account_detail
import_t_sale_from_detail
import_t_sale_summary_sync
import_t_sales_return
import_t_sales_return_detial
import_t_sales_return_this_count
import_t_salesman
import_t_salesman_area
import_t_salesman_choose_log
import_t_salesman_depart
import_t_salesman_log
import_t_salesman_role
import_t_salesman_time_log
import_t_salesman_time_out
import_t_settlement_stay
import_t_showroom
import_t_showroom_counter
import_t_showroom_counter_second
import_t_showroom_storage_data
import_t_special_style_discount
import_t_splszh_log
import_t_stored_procedure_log
import_t_stored_procedure_status
import_t_supplier
import_t_supplier_detial
import_t_supplier_rebate
import_t_sync_time
import_t_szpxgfjcbh
import_t_technology_purity
import_t_temp_customer_transform
import_t_temp_interest_adjust_money_record
import_t_temp_lllsz
import_t_temp_trans_history
import_t_temp_ysmxz
import_t_temp_ywy
import_t_tran_miss_package
import_t_tykhgjb
import_t_tykhgjh
import_t_wechat_message_log
import_t_wechat_pub
import_t_wechat_smallroutine
import_t_wholesaling_category_info
import_t_work_fee_detail
import_temp_csmc
import_temp_customer_hw
import_tykhgjb_eos
import_tykhgjh_eos
import_v_hw
import_view_customer
import_view_oa_customer_1
import_wdmlh
import_wgkhyhbh
import_wgpxgfbh
import_wj
import_wz
import_xltjh_eos
import_xsdszb
import_xsdszf
import_xsdszh
import_xsdszh_history_eos
import_yflmxzh_eos
import_yfmxzh_eos
import_yjgfbh
import_ysmxzb_eos
import_ysmxzh_eos
import_zjyezh_eos
import_zy5g
import_zyyj
	;;
esac
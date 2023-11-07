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
import_t_bf_area(){
import_data t_bf_area " select id,
area_identity,
area_code,
area_name,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
showroom_name,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_area where 1=1"
}
import_t_bf_bank_deposit_bill_sz(){
import_data t_bf_bank_deposit_bill_sz " select id,
bank_eposit_identity,
bank_eposit_code,
showroom_code,
showroom_name,
cus_debit_code,
total_price,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_bf_bank_deposit_bill_sz where 1=1"
}
import_t_bf_bank_deposit_bill_sz_detail(){
import_data t_bf_bank_deposit_bill_sz_detail " select id,
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
replace(replace(replace(bz,'\n',''),'\t',''),'\r','')  bz,
cwsh from $database.t_bf_bank_deposit_bill_sz_detail where 1=1"
}
import_t_bf_buy_cus_item(){
import_data t_bf_buy_cus_item " select id,
buy_cus_item_identity,
buy_cus_item_code,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
approve_status,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
showroom_name,
counter_identity,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','')  remark,
customer_identity,
parent_customer_identity,
total_number,
total_weight,
total_label_price,
total_price,
record_book_by,
date_format(record_book_time,'%Y-%m-%d %H:%i:%s') record_book_time,
credit_code,
record_book_status,
business_type,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
print_count,
tech_purity_name,
tech_purity_code,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_buy_cus_item where 1=1"
}
import_t_bf_buy_cus_item_detail(){
import_data t_bf_buy_cus_item_detail " select id,
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
gold_stone_name from $database.t_bf_buy_cus_item_detail where 1=1"
}
import_t_bf_buy_cus_material(){
import_data t_bf_buy_cus_material " select id,
buy_cus_code,
buy_cus_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
showroom_name,
counter_identity,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
total_gold_weight,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','')  remark,
customer_identity,
parent_customer_identity,
total_price,
customer_credit,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
tech_purity_name,
tech_purity_code,
print_count,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_buy_cus_material where 1=1"
}
import_t_bf_buyback_material(){
import_data t_bf_buyback_material " select id,
settlement_code,
date_format(settlement_time,'%Y-%m-%d %H:%i:%s') settlement_time,
date_format(settlement_date,'%Y-%m-%d %H:%i:%s') settlement_date,
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
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
replace(replace(remarks,'\n',''),'\t','') remarks,
area,
approve_status,
inlaid,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_buyback_material where 1=1"
}
import_t_bf_change_outsource(){
import_data t_bf_change_outsource " select id,
change_outsource_code,
change_outsource_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
counter_name,
counter_identity,
total_gold_weight,
total_price,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
print_count,
tech_purity_name,
tech_purity_code,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_change_outsource where 1=1"
}
import_t_bf_cus_credit_receipt(){
import_data t_bf_cus_credit_receipt " select id,
cus_credit_receipt_identity,
cus_credit_receipt_code,
showroom_name,
customer_identity,
parent_customer_identity,
total_price,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','')  remark,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
approve_status,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
borrow_money,
withdraw_money,
credit_code,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
tech_purity_name,
tech_purity_code from $database.t_bf_cus_credit_receipt where 1=1"
}
import_t_bf_cus_debit_receipt(){
import_data t_bf_cus_debit_receipt " select id,
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
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
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
date_format(debt_time,'%Y-%m-%d %H:%i:%s') debt_time,
date_format(yestoday_price_date,'%Y-%m-%d %H:%i:%s') yestoday_price_date,
yestoday_price,
practical_price_time,
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
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
tech_purity_name,
tech_purity_code from $database.t_bf_cus_debit_receipt where 1=1"
}
import_t_bf_cust_return_jewelry(){
import_data t_bf_cust_return_jewelry " select id,
return_code,
return_identity,
date_format(date_this,'%Y-%m-%d %H:%i:%s') date_this,
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
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
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
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_cust_return_jewelry where 1=1"
}
import_t_bf_cust_return_jewelry_detail(){
import_data t_bf_cust_return_jewelry_detail " select id,
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
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
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
unit_price from $database.t_bf_cust_return_jewelry_detail where 1=1"
}
import_t_bf_customer_the_bill(){
import_data t_bf_customer_the_bill " select id,
customer_the_bill_code,
customer_the_bill_identity,
showroom_name,
out_customer_identity,
out_parent_customer_identity,
financial_settlement_time,
adjust_weight,
adjust_month_price,
adjust_capital,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
in_customer_identity,
in_parent_customer_identity,
inner_customer_identity,
inner_customer_name,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
interest_adjustments,
status,
financial_client_code,
financial_client_name,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
out_tech_purity_name,
out_tech_purity_code,
in_tech_purity_name,
in_tech_purity_code from $database.t_bf_customer_the_bill where 1=1"
}
import_t_bf_dkhhy_b(){
import_data t_bf_dkhhy_b " select bid,
dkhhy_b_identity,
dkhhy_h_identity,
wdmc,
customer_identity,
parent_customer_identity,
zkhbs,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user_id,
create_user_name,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_user_id,
update_user_name,
djlsh,
djbth,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
id from $database.t_bf_dkhhy_b where 1=1"
}
import_t_bf_dkhhy_h(){
import_data t_bf_dkhhy_h " select id,
dkhhy_h_identity,
showroom_name,
customer_identity,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user_id,
create_user_name,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_user_id,
update_user_name,
djlsh,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
status from $database.t_bf_dkhhy_h where 1=1"
}
import_t_bf_gold_transfer_in(){
import_data t_bf_gold_transfer_in " select id,
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
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
if_print_remark,
status,
crdj,
eos_head_key,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
date_format(out_time,'%Y-%m-%d %H:%i:%s') out_time,
print_count,
receive_id,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_gold_transfer_in where 1=1"
}
import_t_bf_gold_transfer_out(){
import_data t_bf_gold_transfer_out " select id,
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
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
if_print_remark,
is_print,
status,
date_format(shipments_date,'%Y-%m-%d %H:%i:%s') shipments_date,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
date_format(drrq,'%Y-%m-%d %H:%i:%s') drrq,
print_count,
receive_id,
transfer_type,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time,
scan_status,
date_format(scan_time,'%Y-%m-%d %H:%i:%s') scan_time,
sacn_by from $database.t_bf_gold_transfer_out where 1=1"
}
import_t_bf_gold_transfer_out_detail(){
import_data t_bf_gold_transfer_out_detail " select id,
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
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
if_update_price,
xsfjgf,
discount_work_fee,
discount_price,
unit_price,
htm,
average_cost,
receive_id,
receive_detail_id from $database.t_bf_gold_transfer_out_detail where 1=1"
}
import_t_bf_gold_transfer_out_print(){
import_data t_bf_gold_transfer_out_print " select id,
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
date_format(deliver_goods_time,'%Y-%m-%d %H:%i:%s') deliver_goods_time,
replace(replace(remark,'\n',''),'\t','') remark,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
dycs,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
batch_setting_basic_price,
status,
bthshj,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
total_unit_price,
print_count,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_gold_transfer_out_print where 1=1"
}
import_t_bf_gold_transfer_out_print_detail(){
import_data t_bf_gold_transfer_out_print_detail " select id,
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
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
unit_price,
old_basic_price,
add_basic_price,
transfer_out_detail_identity from $database.t_bf_gold_transfer_out_print_detail where 1=1"
}
import_t_bf_pay_cus_material(){
import_data t_bf_pay_cus_material " select id,
pay_cus_code,
pay_cus_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
showroom_name,
counter_identity,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
total_gold_weight,
total_price,
gold_average_price,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
customer_identity,
parent_customer_identity,
customer_credit,
allow_sale,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
tech_purity_name,
tech_purity_code,
print_count,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_pay_cus_material where 1=1"
}
import_t_bf_pay_cus_material_detail(){
import_data t_bf_pay_cus_material_detail " select id,
pay_cus_detail_identity,
pay_cus_identity,
purity_identity,
gold_weight,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks from $database.t_bf_pay_cus_material_detail where 1=1"
}
import_t_bf_pay_outsource(){
import_data t_bf_pay_outsource " select id,
pay_outsource_identity,
pay_outsource_code,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
counter_name,
counter_identity,
total_gold_weight,
today_return_weight,
today_pay_weight,
today_put_weight,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
tech_purity_name,
tech_purity_code,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_pay_outsource where 1=1"
}
import_t_bf_payment_order(){
import_data t_bf_payment_order " select id,
payment_order_code,
payment_order_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
total_payment,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s')  rq,
tech_purity_code,
tech_purity_name from $database.t_bf_payment_order where 1=1"
}
import_t_bf_raw_material(){
import_data t_bf_raw_material " select id,
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
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
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
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_raw_material where 1=1"
}
import_t_bf_receive_meterial(){
import_data t_bf_receive_meterial " select id,
receive_meterial_identity,
record_date,
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
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time,
customer_identity,
parent_customer_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remarks,'\n',''),'\t','') remarks,
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
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
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
c5g from $database.t_bf_receive_meterial where 1=1"
}
import_t_bf_receive_meterial_detail(){
import_data t_bf_receive_meterial_detail " select id,
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
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
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
category_code from $database.t_bf_receive_meterial_detail where 1=1"
}
import_t_bf_repair(){
import_data t_bf_repair " select id,
repair_code,
repair_identity,
repair_type,
sale_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
date_format(owe_time,'%Y-%m-%d %H:%i:%s') owe_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
gold_weight,
price,
money,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
status,
sale_code,
tech_purity_name,
tech_purity_code,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
purity_name,
purity_code,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_repair where 1=1"
}
import_t_bf_retreat(){
import_data t_bf_retreat " select id,
retreat_code,
retreat_identity,
sale_identity,
retreat_type,
showroom_name,
customer_identity,
parent_customer_identity,
date_format(owe_time,'%Y-%m-%d %H:%i:%s') owe_time,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
gold_weight,
price,
money,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
status,
sale_code,
tech_purity_name,
tech_purity_code,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
purity_name,
purity_code,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_retreat where 1=1"
}
import_t_bf_settlement(){
import_data t_bf_settlement " select id,
inlaid,
date_format(settlement_time,'%Y-%m-%d %H:%i:%s') settlement_time,
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
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
area,
settlement_code,
approve_status,
date_format(settlement_date,'%Y-%m-%d %H:%i:%s') settlement_date,
customer_coding,
customer_no,
purity_code,
genus_code,
showroom_identity,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_settlement where 1=1"
}
import_t_bf_settlement_adjustment_price(){
import_data t_bf_settlement_adjustment_price " select id,
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
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_settlement_adjustment_price where 1=1"
}
import_t_bf_stock_transfer_bill(){
import_data t_bf_stock_transfer_bill " select id,
stock_transfer_identity,
stock_transfer_code,
date_format(date,'%Y-%m-%d %H:%i:%s') date,
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
date_format(bookkeeping_time,'%Y-%m-%d %H:%i:%s') bookkeeping_time,
bookkeeping_status,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
status,
is_sysgen,
relation_code,
purity_identity from $database.t_bf_stock_transfer_bill where 1=1"
}
import_t_bf_szztgzspd(){
import_data t_bf_szztgzspd " select id,
h_identity,
wdmc,
djhm,
date_format(xdrq,'%Y-%m-%d %H:%i:%s') xdrq,
date_format(gzrq,'%Y-%m-%d %H:%i:%s') gzrq,
tykhbm,
tykhmc,
customer_identity,
parent_customer_identity,
bzsm,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
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
date_format(gzsj,'%Y-%m-%d %H:%i:%s') gzsj,
zfrid,
zfrm,
date_format(zfsj,'%Y-%m-%d %H:%i:%s') zfsj,
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
wzccjds from $database.t_bf_szztgzspd where 1=1"
}
import_t_bf_szztgzspd_detail(){
import_data t_bf_szztgzspd_detail " select id,
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
bzsm from $database.t_bf_szztgzspd_detail where 1=1"
}
import_t_bf_the_bill(){
import_data t_bf_the_bill " select id,
the_bill_code,
the_bill_identity,
showroom_name,
customer_identity,
parent_customer_identity,
inner_customer_identity,
inner_customer_name,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
financial_settlement_time,
adjust_weight,
adjust_month_price,
adjust_capital,
status,
salesman,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
tech_purity_name,
tech_purity_code,
adjust_type,
adjust_interest from $database.t_bf_the_bill where 1=1"
}
import_t_bf_weighing_form_check(){
import_data t_bf_weighing_form_check " select id,
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
tray_gold_weight,
tray_difference_total,
check_total,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_weighing_form_check where 1=1"
}
import_t_child_customer(){
import_data t_child_customer " select id,
replace(replace(replace(customer_id,'\n',''),'\t',''),'\r','') customer_id,
replace(replace(replace(customer_identity,'\n',''),'\t',''),'\r','') customer_identity,
replace(replace(replace(child_customer_identity,'\n',''),'\t',''),'\r','') child_customer_identity,
replace(replace(replace(child_customer_name,'\n',''),'\t',''),'\r','') child_customer_name,
replace(replace(replace(child_customer_code,'\n',''),'\t',''),'\r','') child_customer_code,
replace(replace(replace(child_customer_seq,'\n',''),'\t',''),'\r','') child_customer_seq,
replace(replace(replace(contact_name,'\n',''),'\t',''),'\r','') contact_name,
replace(replace(replace(phone_no,'\n',''),'\t',''),'\r','') phone_no,
replace(replace(replace(phone_no_b,'\n',''),'\t',''),'\r','') phone_no_b,
replace(replace(replace(customer_address,'\n',''),'\t',''),'\r','') customer_address,
replace(replace(replace(help_code,'\n',''),'\t',''),'\r','') help_code,
replace(replace(replace(active_flag,'\n',''),'\t',''),'\r','') active_flag,
replace(replace(replace(legal_person,'\n',''),'\t',''),'\r','') legal_person,
replace(replace(replace(id_code,'\n',''),'\t',''),'\r','') id_code,
replace(replace(replace(province,'\n',''),'\t',''),'\r','') province,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
replace(replace(replace(ty_customer_code,'\n',''),'\t',''),'\r','') ty_customer_code,
replace(replace(replace(djlsh,'\n',''),'\t',''),'\r','') djlsh,
replace(replace(replace(djbth,'\n',''),'\t',''),'\r','') djbth,
replace(replace(replace(license_code,'\n',''),'\t',''),'\r','') license_code,
replace(replace(replace(license_desc,'\n',''),'\t',''),'\r','') license_desc,
replace(replace(replace(license_range,'\n',''),'\t',''),'\r','') license_range,
date_format(license_time,'%Y-%m-%d') license_time,
date_format(jdrq,'%Y-%m-%d %H:%i:%s') jdrq,
replace(replace(replace(city_code,'\n',''),'\t',''),'\r','') city_code,
replace(replace(replace(county_desc,'\n',''),'\t',''),'\r','') county_desc,
replace(replace(replace(company_nature,'\n',''),'\t',''),'\r','') company_nature,
replace(replace(replace(customer_type,'\n',''),'\t',''),'\r','') customer_type,
replace(replace(replace(brand_name,'\n',''),'\t',''),'\r','') brand_name,
replace(replace(replace(wechat_no,'\n',''),'\t',''),'\r','') wechat_no,
replace(replace(replace(delivery_name,'\n',''),'\t',''),'\r','') delivery_name,
replace(replace(replace(delivery_sex,'\n',''),'\t',''),'\r','') delivery_sex,
replace(replace(replace(delivery_id_code,'\n',''),'\t',''),'\r','') delivery_id_code,
replace(replace(replace(delivery_mobile_no,'\n',''),'\t',''),'\r','') delivery_mobile_no from $database.t_child_customer where 1=1"
}
import_t_customer(){
import_data t_customer " select id,
replace(replace(replace(customer_identity,'\n',''),'\t',''),'\r','') customer_identity,
replace(replace(replace(input_type,'\n',''),'\t',''),'\r','') input_type,
replace(replace(replace(active_flag,'\n',''),'\t',''),'\r','') active_flag,
replace(replace(replace(subject_code,'\n',''),'\t',''),'\r','') subject_code,
replace(replace(replace(customer_code,'\n',''),'\t',''),'\r','') customer_code,
replace(replace(replace(customer_name,'\n',''),'\t',''),'\r','') customer_name,
replace(replace(replace(customer_short_name,'\n',''),'\t',''),'\r','') customer_short_name,
replace(replace(replace(bank_name,'\n',''),'\t',''),'\r','') bank_name,
replace(replace(replace(bank_account,'\n',''),'\t',''),'\r','') bank_account,
replace(replace(replace(tax_amount,'\n',''),'\t',''),'\r','') tax_amount,
replace(replace(replace(address,'\n',''),'\t',''),'\r','') address,
replace(replace(replace(phone_no,'\n',''),'\t',''),'\r','') phone_no,
replace(replace(replace(fax_no,'\n',''),'\t',''),'\r','') fax_no,
replace(replace(replace(web_url,'\n',''),'\t',''),'\r','') web_url,
replace(replace(replace(help_code,'\n',''),'\t',''),'\r','') help_code,
replace(replace(replace(legal_person,'\n',''),'\t',''),'\r','') legal_person,
replace(replace(replace(id_code,'\n',''),'\t',''),'\r','') id_code,
replace(replace(replace(position,'\n',''),'\t',''),'\r','') position,
replace(replace(replace(mobile_phone,'\n',''),'\t',''),'\r','') mobile_phone,
replace(replace(replace(office_phone,'\n',''),'\t',''),'\r','') office_phone,
replace(replace(replace(email,'\n',''),'\t',''),'\r','') email,
replace(replace(replace(create_user_code,'\n',''),'\t',''),'\r','') create_user_code,
replace(replace(replace(create_user_ame,'\n',''),'\t',''),'\r','') create_user_ame,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
replace(replace(replace(modify_user_code,'\n',''),'\t',''),'\r','') modify_user_code,
replace(replace(replace(modify_user_name,'\n',''),'\t',''),'\r','') modify_user_name,
replace(replace(replace(show_balance_rate,'\n',''),'\t',''),'\r','') show_balance_rate,
replace(replace(replace(show_sale_rate,'\n',''),'\t',''),'\r','') show_sale_rate,
replace(replace(replace(credit_level,'\n',''),'\t',''),'\r','') credit_level,
replace(replace(replace(credit_quato,'\n',''),'\t',''),'\r','') credit_quato,
replace(replace(replace(credit_desc,'\n',''),'\t',''),'\r','') credit_desc,
replace(replace(replace(pay_time_limit,'\n',''),'\t',''),'\r','') pay_time_limit,
replace(replace(replace(price_pay_limit,'\n',''),'\t',''),'\r','') price_pay_limit,
replace(replace(replace(balance_rate,'\n',''),'\t',''),'\r','') balance_rate,
replace(replace(replace(branch_name,'\n',''),'\t',''),'\r','') branch_name,
replace(replace(replace(company_name,'\n',''),'\t',''),'\r','') company_name,
replace(replace(replace(branch_type,'\n',''),'\t',''),'\r','') branch_type,
replace(replace(replace(province,'\n',''),'\t',''),'\r','') province,
replace(replace(replace(province_code,'\n',''),'\t',''),'\r','') province_code,
replace(replace(replace(city,'\n',''),'\t',''),'\r','') city,
replace(replace(replace(city_code,'\n',''),'\t',''),'\r','') city_code,
replace(replace(replace(county,'\n',''),'\t',''),'\r','') county,
replace(replace(replace(county_desc,'\n',''),'\t',''),'\r','') county_desc,
replace(replace(replace(town,'\n',''),'\t',''),'\r','') town,
replace(replace(replace(town_desc,'\n',''),'\t',''),'\r','') town_desc,
replace(replace(replace(memo,'\n',''),'\t',''),'\r','') memo,
replace(replace(replace(area_code,'\n',''),'\t',''),'\r','') area_code,
replace(replace(replace(area_name,'\n',''),'\t',''),'\r','') area_name,
replace(replace(replace(labour_discount,'\n',''),'\t',''),'\r','') labour_discount,
replace(replace(replace(is_customer,'\n',''),'\t',''),'\r','') is_customer,
replace(replace(replace(is_supplier,'\n',''),'\t',''),'\r','') is_supplier,
replace(replace(replace(is_provincial,'\n',''),'\t',''),'\r','') is_provincial,
replace(replace(replace(day_interest_rate,'\n',''),'\t',''),'\r','') day_interest_rate,
replace(replace(replace(salesman_name,'\n',''),'\t',''),'\r','') salesman_name,
replace(replace(replace(salesman_phone,'\n',''),'\t',''),'\r','') salesman_phone,
replace(replace(replace(address_detail,'\n',''),'\t',''),'\r','') address_detail,
replace(replace(replace(contact_no,'\n',''),'\t',''),'\r','') contact_no,
replace(replace(replace(contact_name,'\n',''),'\t',''),'\r','') contact_name,
replace(replace(replace(sex,'\n',''),'\t',''),'\r','') sex,
replace(replace(replace(is_five,'\n',''),'\t',''),'\r','') is_five,
replace(replace(replace(customer_card_code,'\n',''),'\t',''),'\r','') customer_card_code,
date_format(contract_begin_date,'%Y-%m-%d %H:%i:%s') contract_begin_date,
date_format(contract_end_date,'%Y-%m-%d %H:%i:%s') contract_end_date,
replace(replace(replace(alliance_amount,'\n',''),'\t',''),'\r','') alliance_amount,
replace(replace(replace(brand_amount,'\n',''),'\t',''),'\r','') brand_amount,
replace(replace(replace(deposit_amount,'\n',''),'\t',''),'\r','') deposit_amount,
replace(replace(replace(mobile_phone1,'\n',''),'\t',''),'\r','') mobile_phone1,
replace(replace(replace(license_desc,'\n',''),'\t',''),'\r','') license_desc,
replace(replace(replace(shop_short_name,'\n',''),'\t',''),'\r','') shop_short_name,
replace(replace(replace(customer_debt_name,'\n',''),'\t',''),'\r','') customer_debt_name,
replace(replace(replace(test_customer_type,'\n',''),'\t',''),'\r','') test_customer_type,
replace(replace(replace(is_child,'\n',''),'\t',''),'\r','') is_child,
replace(replace(replace(uniq_id,'\n',''),'\t',''),'\r','') uniq_id,
replace(replace(replace(is_finance,'\n',''),'\t',''),'\r','') is_finance,
replace(replace(replace(license_code,'\n',''),'\t',''),'\r','') license_code,
replace(replace(replace(license_range,'\n',''),'\t',''),'\r','') license_range,
date_format(license_time,'%Y-%m-%d %H:%i:%s') license_time,
replace(replace(replace(customer_class,'\n',''),'\t',''),'\r','') customer_class,
replace(replace(replace(position_name,'\n',''),'\t',''),'\r','') position_name,
replace(replace(replace(company_nature,'\n',''),'\t',''),'\r','') company_nature,
replace(replace(replace(registered_capital,'\n',''),'\t',''),'\r','') registered_capital,
replace(replace(replace(year_sale_amount,'\n',''),'\t',''),'\r','') year_sale_amount,
replace(replace(replace(nature_code,'\n',''),'\t',''),'\r','') nature_code,
replace(replace(replace(nature_name,'\n',''),'\t',''),'\r','') nature_name,
replace(replace(replace(brand_code,'\n',''),'\t',''),'\r','') brand_code,
replace(replace(replace(brand_name,'\n',''),'\t',''),'\r','') brand_name,
replace(replace(replace(references_customer,'\n',''),'\t',''),'\r','') references_customer,
replace(replace(replace(child_customer,'\n',''),'\t',''),'\r','') child_customer,
date_format(spec_events_day,'%Y-%m-%d %H:%i:%s') spec_events_day,
replace(replace(replace(wechat_no,'\n',''),'\t',''),'\r','') wechat_no,
replace(replace(replace(interest,'\n',''),'\t',''),'\r','') interest,
replace(replace(replace(buyer_name,'\n',''),'\t',''),'\r','') buyer_name,
replace(replace(replace(buyer_sex,'\n',''),'\t',''),'\r','') buyer_sex,
replace(replace(replace(buyer_id_code,'\n',''),'\t',''),'\r','') buyer_id_code,
replace(replace(replace(buyer_mobile_no,'\n',''),'\t',''),'\r','') buyer_mobile_no,
replace(replace(replace(buyer_position,'\n',''),'\t',''),'\r','') buyer_position,
replace(replace(replace(delivery_name,'\n',''),'\t',''),'\r','') delivery_name,
replace(replace(replace(delivery_sex,'\n',''),'\t',''),'\r','') delivery_sex,
replace(replace(replace(delivery_id_code,'\n',''),'\t',''),'\r','') delivery_id_code,
replace(replace(replace(delivery_mobile_no,'\n',''),'\t',''),'\r','') delivery_mobile_no,
replace(replace(replace(delivery_position,'\n',''),'\t',''),'\r','') delivery_position,
date_format(authorization_date,'%Y-%m-%d %H:%i:%s') authorization_date,
replace(replace(replace(receive_address,'\n',''),'\t',''),'\r','') receive_address,
replace(replace(replace(is_display,'\n',''),'\t',''),'\r','') is_display,
replace(replace(replace(customer_type,'\n',''),'\t',''),'\r','') customer_type,
replace(replace(replace(of_area,'\n',''),'\t',''),'\r','') of_area,
replace(replace(replace(authorize_payer,'\n',''),'\t',''),'\r','') authorize_payer,
replace(replace(replace(payer_bank_count,'\n',''),'\t',''),'\r','') payer_bank_count,
replace(replace(replace(payer_credit_card,'\n',''),'\t',''),'\r','') payer_credit_card,
replace(replace(replace(payer_bank_name,'\n',''),'\t',''),'\r','') payer_bank_name,
replace(replace(replace(payer_bank_branch,'\n',''),'\t',''),'\r','') payer_bank_branch,
replace(replace(replace(payer_bank_sub_branch,'\n',''),'\t',''),'\r','') payer_bank_sub_branch,
date_format(authorize_active_date,'%Y-%m-%d %H:%i:%s') authorize_active_date,
replace(replace(replace(authorize_active_str,'\n',''),'\t',''),'\r','') authorize_active_str,
replace(replace(replace(authorize_payerb,'\n',''),'\t',''),'\r','') authorize_payerb,
replace(replace(replace(payerb_bank_count,'\n',''),'\t',''),'\r','') payerb_bank_count,
replace(replace(replace(payerb_credit_card,'\n',''),'\t',''),'\r','') payerb_credit_card,
replace(replace(replace(payerb_bank_name,'\n',''),'\t',''),'\r','') payerb_bank_name,
replace(replace(replace(payerb_bank_branch,'\n',''),'\t',''),'\r','') payerb_bank_branch,
replace(replace(replace(payerb_bank_sub_branch,'\n',''),'\t',''),'\r','') payerb_bank_sub_branch,
replace(replace(replace(authorize_active_dateb,'\n',''),'\t',''),'\r','') authorize_active_dateb,
replace(replace(replace(authorize_active_strb,'\n',''),'\t',''),'\r','') authorize_active_strb,
replace(replace(replace(is_official,'\n',''),'\t',''),'\r','') is_official,
replace(replace(replace(is_personal,'\n',''),'\t',''),'\r','') is_personal,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
replace(replace(replace(ty_customer_code,'\n',''),'\t',''),'\r','') ty_customer_code,
replace(replace(replace(purity_name,'\n',''),'\t',''),'\r','') purity_name,
replace(replace(replace(customer_classification,'\n',''),'\t',''),'\r','') customer_classification,
replace(replace(replace(djlsh,'\n',''),'\t',''),'\r','') djlsh from $database.t_customer where 1=1"
}
import_t_delay_region(){
import_data t_delay_region " select id,
province,
salesman_role_identity,
area_identity from $database.t_delay_region where 1=1"
}
import_t_fast_customer(){
import_data t_fast_customer " select id,
replace(replace(replace(customer_identity,'\n',''),'\t',''),'\r','') customer_identity,
replace(replace(replace(customer_name,'\n',''),'\t',''),'\r','') customer_name,
replace(replace(replace(customer_code,'\n',''),'\t',''),'\r','') customer_code,
replace(replace(replace(is_child,'\n',''),'\t',''),'\r','') is_child,
replace(replace(replace(phone1,'\n',''),'\t',''),'\r','') phone1,
replace(replace(replace(phone2,'\n',''),'\t',''),'\r','') phone2,
replace(replace(replace(phone3,'\n',''),'\t',''),'\r','') phone3,
replace(replace(replace(phone4,'\n',''),'\t',''),'\r','') phone4,
replace(replace(replace(contact_man,'\n',''),'\t',''),'\r','') contact_man,
replace(replace(replace(parent_customer_identity,'\n',''),'\t',''),'\r','') parent_customer_identity,
replace(replace(replace(is_discount,'\n',''),'\t',''),'\r','') is_discount,
replace(replace(replace(is_engrave,'\n',''),'\t',''),'\r','') is_engrave,
replace(replace(replace(is_tag,'\n',''),'\t',''),'\r','') is_tag,
replace(replace(replace(is_fast_out,'\n',''),'\t',''),'\r','') is_fast_out,
replace(replace(replace(company_name,'\n',''),'\t',''),'\r','') company_name,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
replace(replace(replace(province,'\n',''),'\t',''),'\r','') province,
replace(replace(replace(mobile_contact_person,'\n',''),'\t',''),'\r','') mobile_contact_person,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
date_format(data_date,'%Y-%m-%d %H:%i:%s') data_date,
replace(replace(replace(ty_customer_code,'\n',''),'\t',''),'\r','') ty_customer_code,
replace(replace(replace(purity_name,'\n',''),'\t',''),'\r','') purity_name,
replace(replace(replace(is_extends,'\n',''),'\t',''),'\r','') is_extends,
replace(replace(replace(is_exhibition,'\n',''),'\t',''),'\r','') is_exhibition,
replace(replace(replace(area_identity,'\n',''),'\t',''),'\r','') area_identity,
replace(replace(replace(technology_purity_identity,'\n',''),'\t',''),'\r','') technology_purity_identity,
replace(replace(replace(showroom_identity,'\n',''),'\t',''),'\r','') showroom_identity,
replace(replace(replace(label_show_original_price,'\n',''),'\t',''),'\r','') label_show_original_price,
replace(replace(replace(status,'\n',''),'\t',''),'\r','') status from $database.t_fast_customer where 1=1"
}
import_t_fast_package(){
import_data t_fast_package " select id,
replace(replace(replace(fast_package_identity,'\n',''),'\t',''),'\r','') fast_package_identity,
replace(replace(replace(package_code,'\n',''),'\t',''),'\r','') package_code,
replace(replace(replace(package_name,'\n',''),'\t',''),'\r','') package_name,
replace(replace(replace(status_id,'\n',''),'\t',''),'\r','') status_id,
replace(replace(replace(showroom_identity,'\n',''),'\t',''),'\r','') showroom_identity,
replace(replace(replace(customer_id,'\n',''),'\t',''),'\r','') customer_id,
replace(replace(replace(customer_identity,'\n',''),'\t',''),'\r','') customer_identity,
replace(replace(replace(counter_user_id,'\n',''),'\t',''),'\r','') counter_user_id,
replace(replace(replace(counter_user_identity,'\n',''),'\t',''),'\r','') counter_user_identity,
replace(replace(replace(initial_package_code,'\n',''),'\t',''),'\r','') initial_package_code,
replace(replace(replace(net_weight,'\n',''),'\t',''),'\r','') net_weight,
replace(replace(replace(gross_weight,'\n',''),'\t',''),'\r','') gross_weight,
replace(replace(replace(purity_id,'\n',''),'\t',''),'\r','') purity_id,
replace(replace(replace(purity_identity,'\n',''),'\t',''),'\r','') purity_identity,
replace(replace(replace(showroom_counter_id,'\n',''),'\t',''),'\r','') showroom_counter_id,
replace(replace(replace(showroom_counter_identity,'\n',''),'\t',''),'\r','') showroom_counter_identity,
replace(replace(replace(additional_labour_amount,'\n',''),'\t',''),'\r','') additional_labour_amount,
replace(replace(replace(standard_labour_amount,'\n',''),'\t',''),'\r','') standard_labour_amount,
replace(replace(replace(status,'\n',''),'\t',''),'\r','') status,
replace(replace(replace(is_delete,'\n',''),'\t',''),'\r','') is_delete,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
replace(replace(replace(marking_identity,'\n',''),'\t',''),'\r','') marking_identity,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
replace(replace(replace(is_urgent,'\n',''),'\t',''),'\r','') is_urgent,
date_format(confirmatio_time,'%Y-%m-%d %H:%i:%s') confirmatio_time,
replace(replace(replace(is_lm,'\n',''),'\t',''),'\r','') is_lm,
replace(replace(replace(sales_status_id,'\n',''),'\t',''),'\r','') sales_status_id,
date_format(customer_require_time,'%Y-%m-%d %H:%i:%s') customer_require_time,
date_format(customer_confirmation_time,'%Y-%m-%d %H:%i:%s') customer_confirmation_time,
date_format(leave_counter_time,'%Y-%m-%d %H:%i:%s') leave_counter_time,
replace(replace(replace(settlement_method,'\n',''),'\t',''),'\r','') settlement_method,
replace(replace(replace(update_user,'\n',''),'\t',''),'\r','') update_user,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
replace(replace(replace(is_fast_out,'\n',''),'\t',''),'\r','') is_fast_out,
replace(replace(replace(order_identity,'\n',''),'\t',''),'\r','') order_identity,
replace(replace(replace(print_label,'\n',''),'\t',''),'\r','') print_label,
replace(replace(replace(is_print,'\n',''),'\t',''),'\r','') is_print,
replace(replace(replace(is_stay,'\n',''),'\t',''),'\r','') is_stay,
replace(replace(replace(stay_identity,'\n',''),'\t',''),'\r','') stay_identity,
replace(replace(replace(is_return,'\n',''),'\t',''),'\r','') is_return,
replace(replace(replace(is_b2b,'\n',''),'\t',''),'\r','') is_b2b,
replace(replace(replace(additional_labour_no_discount_amount,'\n',''),'\t',''),'\r','') additional_labour_no_discount_amount,
replace(replace(replace(salesman_identity,'\n',''),'\t',''),'\r','') salesman_identity,
replace(replace(replace(delay_number,'\n',''),'\t',''),'\r','') delay_number,
replace(replace(replace(is_visible,'\n',''),'\t',''),'\r','') is_visible,
replace(replace(replace(delay_status,'\n',''),'\t',''),'\r','') delay_status,
replace(replace(replace(disable_delay,'\n',''),'\t',''),'\r','') disable_delay,
date_format(estimate_time,'%Y-%m-%d %H:%i:%s') estimate_time,
replace(replace(replace(delay_salesman_identity,'\n',''),'\t',''),'\r','') delay_salesman_identity,
replace(replace(replace(delay_care,'\n',''),'\t',''),'\r','') delay_care,
replace(replace(replace(goods_picker,'\n',''),'\t',''),'\r','') goods_picker,
replace(replace(replace(goods_picker_phone,'\n',''),'\t',''),'\r','') goods_picker_phone,
replace(replace(replace(return_goods,'\n',''),'\t',''),'\r','') return_goods,
replace(replace(replace(package_i_type,'\n',''),'\t',''),'\r','') package_i_type,
replace(replace(replace(current_data_type,'\n',''),'\t',''),'\r','') current_data_type,
date_format(business_require_time,'%Y-%m-%d %H:%i:%s') business_require_time,
replace(replace(replace(sale_code,'\n',''),'\t',''),'\r','') sale_code,
date_format(kdsj,'%Y-%m-%d %H:%i:%s') kdsj,
replace(replace(replace(if_sale_status,'\n',''),'\t',''),'\r','') if_sale_status,
date_format(gzrq,'%Y-%m-%d %H:%i:%s') gzrq,
replace(replace(replace(origina_counter,'\n',''),'\t',''),'\r','') origina_counter,
replace(replace(replace(source,'\n',''),'\t',''),'\r','') source,
replace(replace(replace(source_identity,'\n',''),'\t',''),'\r','') source_identity,
replace(replace(replace(initial_counter_user_identity,'\n',''),'\t',''),'\r','') initial_counter_user_identity from $database.t_fast_package where 1=1"
}
import_t_fast_package_i(){
import_data t_fast_package_i " select id,
replace(replace(replace(package_i_identity,'\n',''),'\t',''),'\r','') package_i_identity,
replace(replace(replace(fast_package_id,'\n',''),'\t',''),'\r','') fast_package_id,
replace(replace(replace(package_i_code,'\n',''),'\t',''),'\r','') package_i_code,
replace(replace(replace(fast_package_identity,'\n',''),'\t',''),'\r','') fast_package_identity,
replace(replace(replace(category_id,'\n',''),'\t',''),'\r','') category_id,
replace(replace(replace(category_identity,'\n',''),'\t',''),'\r','') category_identity,
replace(replace(replace(item_qty,'\n',''),'\t',''),'\r','') item_qty,
replace(replace(replace(net_weight,'\n',''),'\t',''),'\r','') net_weight,
replace(replace(replace(genus_id,'\n',''),'\t',''),'\r','') genus_id,
replace(replace(replace(genus_identity,'\n',''),'\t',''),'\r','') genus_identity,
replace(replace(replace(additional_labour,'\n',''),'\t',''),'\r','') additional_labour,
replace(replace(replace(standard_labour,'\n',''),'\t',''),'\r','') standard_labour,
replace(replace(replace(gross_weight,'\n',''),'\t',''),'\r','') gross_weight,
replace(replace(replace(status,'\n',''),'\t',''),'\r','') status,
replace(replace(replace(is_delete,'\n',''),'\t',''),'\r','') is_delete,
replace(replace(replace(package_status,'\n',''),'\t',''),'\r','') package_status,
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
replace(replace(replace(is_discount,'\n',''),'\t',''),'\r','') is_discount,
replace(replace(replace(packing_paper_number,'\n',''),'\t',''),'\r','') packing_paper_number,
replace(replace(replace(plastic_bag_number,'\n',''),'\t',''),'\r','') plastic_bag_number,
replace(replace(replace(manual_input_number,'\n',''),'\t',''),'\r','') manual_input_number,
replace(replace(replace(automatic_input_number,'\n',''),'\t',''),'\r','') automatic_input_number,
replace(replace(replace(gross_manual_input_number,'\n',''),'\t',''),'\r','') gross_manual_input_number,
replace(replace(replace(gross_automatic_input_number,'\n',''),'\t',''),'\r','') gross_automatic_input_number,
replace(replace(replace(dif_reason,'\n',''),'\t',''),'\r','') dif_reason,
replace(replace(replace(is_return,'\n',''),'\t',''),'\r','') is_return,
replace(replace(replace(additional_labour_discount,'\n',''),'\t',''),'\r','') additional_labour_discount,
replace(replace(replace(additional_labour_discount_amount,'\n',''),'\t',''),'\r','') additional_labour_discount_amount,
replace(replace(replace(technology_num,'\n',''),'\t',''),'\r','') technology_num,
replace(replace(replace(technology_unit_price,'\n',''),'\t',''),'\r','') technology_unit_price,
replace(replace(replace(technology_count_price,'\n',''),'\t',''),'\r','') technology_count_price,
replace(replace(replace(genus_name,'\n',''),'\t',''),'\r','') genus_name,
replace(replace(replace(price_method,'\n',''),'\t',''),'\r','') price_method,
replace(replace(replace(product_code,'\n',''),'\t',''),'\r','') product_code,
replace(replace(replace(metal_color,'\n',''),'\t',''),'\r','') metal_color,
replace(replace(replace(stone_color,'\n',''),'\t',''),'\r','') stone_color,
replace(replace(replace(specs,'\n',''),'\t',''),'\r','') specs,
replace(replace(replace(gold_weight,'\n',''),'\t',''),'\r','') gold_weight,
replace(replace(replace(parts_weight,'\n',''),'\t',''),'\r','') parts_weight,
replace(replace(replace(total_stone_weight,'\n',''),'\t',''),'\r','') total_stone_weight,
replace(replace(replace(main_stone_weight,'\n',''),'\t',''),'\r','') main_stone_weight,
replace(replace(replace(auxiliary_stone_weight,'\n',''),'\t',''),'\r','') auxiliary_stone_weight,
replace(replace(replace(total_weight,'\n',''),'\t',''),'\r','') total_weight,
replace(replace(replace(loss,'\n',''),'\t',''),'\r','') loss,
replace(replace(replace(gold_costs,'\n',''),'\t',''),'\r','') gold_costs,
replace(replace(replace(label_price,'\n',''),'\t',''),'\r','') label_price,
replace(replace(replace(fixed_price,'\n',''),'\t',''),'\r','') fixed_price,
replace(replace(replace(sales_fee,'\n',''),'\t',''),'\r','') sales_fee,
replace(replace(replace(product_type,'\n',''),'\t',''),'\r','') product_type,
replace(replace(replace(product_name,'\n',''),'\t',''),'\r','') product_name,
replace(replace(replace(certificate_no,'\n',''),'\t',''),'\r','') certificate_no,
replace(replace(replace(clarity,'\n',''),'\t',''),'\r','') clarity,
replace(replace(replace(contains_consumption_weight,'\n',''),'\t',''),'\r','') contains_consumption_weight,
replace(replace(replace(help_remember_code,'\n',''),'\t',''),'\r','') help_remember_code,
replace(replace(replace(total_number,'\n',''),'\t',''),'\r','') total_number,
replace(replace(replace(company_model_code,'\n',''),'\t',''),'\r','') company_model_code,
replace(replace(replace(category_second_identity,'\n',''),'\t',''),'\r','') category_second_identity,
replace(replace(replace(discount,'\n',''),'\t',''),'\r','') discount,
replace(replace(replace(discount_price,'\n',''),'\t',''),'\r','') discount_price,
replace(replace(replace(stone_costs,'\n',''),'\t',''),'\r','') stone_costs,
replace(replace(replace(gold_unit_price,'\n',''),'\t',''),'\r','') gold_unit_price,
replace(replace(replace(special_discount,'\n',''),'\t',''),'\r','') special_discount,
replace(replace(replace(sales_discount_fee,'\n',''),'\t',''),'\r','') sales_discount_fee,
replace(replace(replace(stone_encrusted_fee,'\n',''),'\t',''),'\r','') stone_encrusted_fee,
replace(replace(replace(stone_total_fee,'\n',''),'\t',''),'\r','') stone_total_fee,
replace(replace(replace(parts_cost_amount_total_fee,'\n',''),'\t',''),'\r','') parts_cost_amount_total_fee,
replace(replace(replace(main_stone_prices,'\n',''),'\t',''),'\r','') main_stone_prices,
replace(replace(replace(auxiliary_stone_price,'\n',''),'\t',''),'\r','') auxiliary_stone_price,
replace(replace(replace(auxiliary_stone_total_price,'\n',''),'\t',''),'\r','') auxiliary_stone_total_price,
replace(replace(replace(main_stone_price,'\n',''),'\t',''),'\r','') main_stone_price,
replace(replace(replace(is_dydf_counter,'\n',''),'\t',''),'\r','') is_dydf_counter,
replace(replace(replace(is_fixed_price,'\n',''),'\t',''),'\r','') is_fixed_price,
replace(replace(replace(other_price,'\n',''),'\t',''),'\r','') other_price,
replace(replace(replace(batch_price,'\n',''),'\t',''),'\r','') batch_price from $database.t_fast_package_i where 1=1"
}
import_t_fast_package_i_product(){
import_data t_fast_package_i_product " select id,
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
replace(replace(replace(remarks,'\n',''),'\t',''),'\r','') remarks,
is_high_quality,
discount,
discount_price,
fast_package_identity from $database.t_fast_package_i_product where 1=1"
}
import_t_finance_customer_relation(){
import_data t_finance_customer_relation " select id,
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
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user_id,
create_user_name,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_user_id,
update_user_name,
is_delete,
djlsh,
djbth from $database.t_finance_customer_relation where 1=1"
}
import_t_gf_area_customer(){
import_data t_gf_area_customer " select id,
area_identity,
customer_identity,
is_child,
is_delete from $database.t_gf_area_customer where 1=1"
}
import_t_ka_lllsz(){
import_data t_ka_lllsz " select rq,
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
tech_purity_code from $database.t_ka_lllsz where 1=1"
}
import_t_ka_lscqmxb_b(){
import_data t_ka_lscqmxb_b " select lscqmxb_h_identity,
lscqmxb_b_identity,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
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
djbth from $database.t_ka_lscqmxb_b where 1=1 and rq = (select date_sub(jsrq,interval 1 day) from t_ka_szlxjsrq)"
}
import_t_ka_lscqmxb_h(){
import_data t_ka_lscqmxb_h " select id,
lscqmxb_h_identity,
wdmc,
wdbm,
customer_identity,
khbm,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
replace(replace(replace(zkh,'\n',''),'\t',''),'\r','') zkh,
purity_name,
zjm,
wyid,
ycbs,
cwbz,
ztyc,
djlsh from $database.t_ka_lscqmxb_h where 1=1"
}
import_t_ka_splsz(){
import_data t_ka_splsz " select id,
djm,
djh,
date_format(rq,'%Y-%m-%d') rq,
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
replace(replace(replace(RHF,'\n',''),'\t',''),'\r','')  RHF,
replace(replace(replace(CHF,'\n',''),'\t',''),'\r','')  CHF,
replace(replace(replace(bz,'\n',''),'\t',''),'\r','')  bz,
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
replace(replace(replace(bzh,'\n',''),'\t',''),'\r','')  bzh from $database.t_ka_splsz where 1=1"
}
import_t_ka_szdzsqdh(){
import_data t_ka_szdzsqdh " select id,
djlsh,
djh,
wdmc,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
khbm,
replace(replace(replace(zkh,'\n',''),'\t',''),'\r','') zkh,
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
sj1,
fgldqr,
sj2,
zjlpf,
sj3,
cwqr,
sj4,
dszfh,
sj5,
date_format(cwshsj,'%Y-%m-%d %H:%i:%s') cwshsj,
zjlpfrq,
sfdy,
date_format(dysj,'%Y-%m-%d %H:%i:%s') dysj,
cwecqr,
date_format(cwecqrsj,'%Y-%m-%d %H:%i:%s') cwecqrsj,
out_tech_purity_name,
out_tech_purity_code,
in_tech_purity_name,
in_tech_purity_code from $database.t_ka_szdzsqdh where 1=1"
}
import_t_ka_szkhcqlxzz_b(){
import_data t_ka_szkhcqlxzz_b " select szkhcqlxzz_h_identity,
szkhcqlxzz_b_identity,
djbth,
lxb,
pl,
date_format(fsrq,'%Y-%m-%d %H:%i:%s') fsrq,
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
import_t_ka_szkhcqlxzz_h(){
import_data t_ka_szkhcqlxzz_h " select id,
szkhcqlxzz_h_identity,
djbtzdh,
wdmc,
wdbm,
customer_identity,
khbm,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
replace(replace(replace(zkh,'\n',''),'\t',''),'\r','') zkh,
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
import_t_ka_szkhcqlxzzfb_h(){
import_data t_ka_szkhcqlxzzfb_h " select id,
szkhcqlxzz_h_identity,
djbtzdh,
wdmc,
wdbm,
customer_identity,
khbm,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
replace(replace(replace(zkh,'\n',''),'\t',''),'\r','') zkh,
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
import_t_ka_szkhcqmx_h(){
import_data t_ka_szkhcqmx_h " select szkhcqmx_h_identity,
djlsh,
djbtzdh,
djftzdh,
djstzdh,
djstate,
djcount,
wdbm,
wdmc,
khbm,
replace(replace(replace(khmc,'\n',''),'\t',''),'\r','') khmc,
zkhbh,
replace(replace(replace(zkhmc,'\n',''),'\t',''),'\r','') zkhmc,
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
import_data t_ka_szlxjsrq " select szlxjsrq_identity,
date_format(jsrq,'%Y-%m-%d %H:%i:%s') jsrq from $database.t_ka_szlxjsrq where 1=1"
}
import_t_ka_yfllsz(){
import_data t_ka_yfllsz " select id,
date_format(rq,'%Y-%m-%d') rq,
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
tech_purity_code from $database.t_ka_yfllsz where 1=1"
}
import_t_ka_yflsz(){
import_data t_ka_yflsz " select id,
date_format(RQ,'%Y-%m-%d') RQ,
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
import_t_ka_yslsz(){
import_data t_ka_yslsz " select id,
yslsz_identity,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
djm,
djh,
swlx,
sffx,
je,
bb,
wdbm,
wdmc,
lb,
bz,
gylx,
customer_identity,
parent_customer_identity,
czzt,
khlx from $database.t_ka_yslsz where 1=1"
}
import_t_ka_ysmxz_b(){
import_data t_ka_ysmxz_b " select id,
ysmxz_h_identity,
ysmxz_b_identity,
djm,
djh,
settlement_type,
djje,
wfje,
yfje,
replace(replace(replace(bz,'\n',''),'\t',''),'\r','') bz,
date_format(zhskrq,'%Y-%m-%d %H:%i:%s') zhskrq,
csbm,
csmc,
plbm,
plmc,
dcwdmc,
fs,
jjje,
gfje,
date_format(hkshrq,'%Y-%m-%d %H:%i:%s') hkshrq,
ybf,
hkjsfs,
gylx,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
czzt from $database.t_ka_ysmxz_b where 1=1"
}
import_t_ka_ysmxz_h(){
import_data t_ka_ysmxz_h " select id,
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
import_t_ka_zrye(){
import_data t_ka_zrye " select zrye_identity,
dh,
je,
jz,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
wdmc,
lx from $database.t_ka_zrye where 1=1"
}
import_t_ka_ztkcrzz(){
import_data t_ka_ztkcrzz " select id,
ztkcrzz_identity,
nian,
yue,
ri,
date_format(rq,'%Y-%m-%d') rq,
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
ykje from $database.t_ka_ztkcrzz where 1=1"
}
import_t_move_counter(){
import_data t_move_counter " select id,
move_identity,
move_code,
order_identity,
order_code,
receive_identity,
receive_code,
purity_name,
replace(replace(replace(customer_name,'\n',''),'\t',''),'\r','') customer_name,
replace(replace(replace(customer_code,'\n',''),'\t',''),'\r','') customer_code,
replace(replace(replace(engrave,'\n',''),'\t',''),'\r','') engrave,
estimate_time,
showroom_counter_identity,
showroom_counter_name,
total_gold_weight,
total_number,
total_work_fee,
supplier_name,
stock_status,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
customer_showroom,
move_type,
move_status,
date_format(confirm_time,'%Y-%m-%d %H:%i:%s') confirm_time,
confirm_by,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
status from $database.t_move_counter where 1=1"
}
import_t_purity(){
import_data t_purity " select id,
purity_identity,
purity_code,
purity_name,
create_user_id,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
date_format(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
status,
type,
purity_type,
help_code,
purity_percent,
basic_purity_identity,
technology_purity_identity from $database.t_purity where 1=1"
}
import_t_receive(){
import_data t_receive " select id,
replace(replace(replace(receive_identity,'\n',''),'\t',''),'\r','')receive_identity,
replace(replace(replace(receive_code,'\n',''),'\t',''),'\r','')receive_code,
replace(replace(replace(purity_name,'\n',''),'\t',''),'\r','')purity_name,
replace(replace(replace(total_gold_weight,'\n',''),'\t',''),'\r','')total_gold_weight,
replace(replace(replace(total_number,'\n',''),'\t',''),'\r','')total_number,
replace(replace(replace(total_fee,'\n',''),'\t',''),'\r','')total_fee,
replace(replace(replace(create_by,'\n',''),'\t',''),'\r','')create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
replace(replace(replace(update_by,'\n',''),'\t',''),'\r','')update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
replace(replace(replace(supplier_type,'\n',''),'\t',''),'\r','')supplier_type,
replace(replace(replace(receive_type,'\n',''),'\t',''),'\r','')receive_type,
replace(replace(replace(receive_status,'\n',''),'\t',''),'\r','')receive_status,
replace(replace(replace(status,'\n',''),'\t',''),'\r','')status,
replace(replace(replace(end_reason,'\n',''),'\t',''),'\r','')end_reason,
replace(replace(replace(supplier_identity,'\n',''),'\t',''),'\r','')supplier_identity,
replace(replace(replace(supplier_name,'\n',''),'\t',''),'\r','') supplier_name,
replace(replace(replace(supplier_source,'\n',''),'\t',''),'\r','')supplier_source,
replace(replace(replace(variety,'\n',''),'\t',''),'\r','')variety,
replace(replace(replace(first_status,'\n',''),'\t',''),'\r','')first_status,
replace(replace(replace(receive_reason,'\n',''),'\t',''),'\r','')receive_reason,
replace(replace(replace(qc_type,'\n',''),'\t',''),'\r','')qc_type,
replace(replace(replace(if_all_return,'\n',''),'\t',''),'\r','')if_all_return,
replace(replace(replace(check_status,'\n',''),'\t',''),'\r','')check_status,
replace(replace(replace(color_gold_weight,'\n',''),'\t',''),'\r','')color_gold_weight,
replace(replace(replace(is_examine,'\n',''),'\t',''),'\r','')is_examine,
replace(replace(replace(if_sure_price_ok,'\n',''),'\t',''),'\r','')if_sure_price_ok,
replace(replace(replace(if_product_code_add_ok,'\n',''),'\t',''),'\r','')if_product_code_add_ok,
replace(replace(replace(showroom_name,'\n',''),'\t',''),'\r','')showroom_name,
replace(replace(replace(genus_name,'\n',''),'\t',''),'\r','')genus_name,
replace(replace(replace(examine_by,'\n',''),'\t',''),'\r','')examine_by,
date_format(examine_time,'%Y-%m-%d %H:%i:%s') examine_time,
replace(replace(replace(receive_remark,'\n',''),'\t',''),'\r','')receive_remark,
replace(replace(replace(total_fee_check,'\n',''),'\t',''),'\r','')total_fee_check,
replace(replace(replace(showroom_identity,'\n',''),'\t',''),'\r','')showroom_identity,
replace(replace(replace(counter_identity,'\n',''),'\t',''),'\r','')counter_identity,
replace(replace(replace(counter_name,'\n',''),'\t',''),'\r','')counter_name,
replace(replace(replace(ppmc,'\n',''),'\t',''),'\r','')ppmc,
replace(replace(replace(customer_name,'\n',''),'\t',''),'\r','')customer_name from $database.t_receive where 1=1"
}
import_t_sale_from(){
import_data t_sale_from " select id,
sale_code,
sale_identity,
if_update_work_fee,
if_tax_rate,
tax_rate,
area,
showroom_identity,
showroom_name,
date_format(sale_date,'%Y-%m-%d %H:%i:%s') sale_date,
purity_identity,
sale_type,
customer_identity,
main_customer_identity,
admin_settle_accounts_identity,
settle_accounts_identity,
grain_price,
total_number,
total_gold_weight,
total_weight,
total_additional_labour,
total_conversion_gold,
total_label_price,
total_stone_price,
total_price,
replace(replace(replace(remark,'\n',''),'\t',''),'\r','') remark,
discount_remark,
if_print_remark,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
if_update_discount,
discount,
if_gold_work_stone,
if_retail,
type,
retail_work_fee,
status,
if_dydf,
child_customer_code,
settle_child_customer_code,
jjjz,
jjje,
lljzhj,
llgfhj,
zqljzhj,
zqlgfje,
zqsjzhj,
fyhj,
zqgfhj,
zqjz,
tsjz,
tsjehj,
jsjzxj,
jsjexj,
qzl,
lk,
date_format(bill_date,'%Y-%m-%d %H:%i:%s') bill_date,
synchronize_zds,
meterial_weight,
meterial_price,
meterial_code,
jewelry_weight,
jewelry_price,
jewelry_code,
invalid_why,
print_count,
gold_price,
bdze,
date_format(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_sale_from where 1=1"
}
import_t_sale_from_account_detail(){
import_data t_sale_from_account_detail " select id,
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
replace(replace(replace(remark,'\n',''),'\t',''),'\r','')  remark,
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
import_data t_sale_from_detail " select id,
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
replace(replace(replace(remark,'\n',''),'\t',''),'\r','')  remark,
small_remark,
status,
category_name,
second_category_name,
label_price,
batch_price,
other_price from $database.t_sale_from_detail where 1=1"
}
import_t_sales_return(){
import_data t_sales_return " select id,
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
date_format(return_time,'%Y-%m-%d %H:%i:%s') return_time,
return_type,
create_by,
date_format(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
date_format(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
receive_reason,
receive_type,
return_status,
expected_delivery_time,
counter_identity,
counter_name,
gross_weight,
showroom_name,
date_format(rq,'%Y-%m-%d %H:%i:%s') rq,
replace(replace(replace(sale_return_remark,'\n',''),'\t',''),'\r','') sale_return_remark,
examine_by,
date_format(examine_time,'%Y-%m-%d %H:%i:%s') examine_time,
check_number_all,
check_weight_all from $database.t_sales_return where 1=1"
}
import_t_showroom(){
import_data t_showroom " select id,
showroom_identity,
showroom_code,
showroom_name,
status,
final_time,
create_user_id,
date_format(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
date_format(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
longitude,
dimension,
showroom_type,
is_delete from $database.t_showroom where 1=1"
}
import_t_showroom_counter(){
import_data t_showroom_counter " select id,
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
date_format(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
last_user_name,
last_date,
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
is_many_purity,
purity_name_str from $database.t_showroom_counter where 1=1"
}
import_t_technology_purity(){
import_data t_technology_purity " select id,
purity_name from $database.t_technology_purity where 1=1"
}
case $1 in
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
"t_bf_buyback_material")
import_t_bf_buyback_material
;;
"t_bf_change_outsource")
import_t_bf_change_outsource
;;
"t_bf_cus_credit_receipt")
import_t_bf_cus_credit_receipt
;;
"t_bf_cus_debit_receipt")
import_t_bf_cus_debit_receipt
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
"t_bf_dkhhy_b")
import_t_bf_dkhhy_b
;;
"t_bf_dkhhy_h")
import_t_bf_dkhhy_h
;;
"t_bf_gold_transfer_in")
import_t_bf_gold_transfer_in
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
"t_bf_pay_cus_material")
import_t_bf_pay_cus_material
;;
"t_bf_pay_cus_material_detail")
import_t_bf_pay_cus_material_detail
;;
"t_bf_pay_outsource")
import_t_bf_pay_outsource
;;
"t_bf_payment_order")
import_t_bf_payment_order
;;
"t_bf_raw_material")
import_t_bf_raw_material
;;
"t_bf_receive_meterial")
import_t_bf_receive_meterial
;;
"t_bf_receive_meterial_detail")
import_t_bf_receive_meterial_detail
;;
"t_bf_repair")
import_t_bf_repair
;;
"t_bf_retreat")
import_t_bf_retreat
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
"t_bf_szztgzspd")
import_t_bf_szztgzspd
;;
"t_bf_szztgzspd_detail")
import_t_bf_szztgzspd_detail
;;
"t_bf_the_bill")
import_t_bf_the_bill
;;
"t_bf_weighing_form_check")
import_t_bf_weighing_form_check
;;
"t_child_customer")
import_t_child_customer
;;
"t_customer")
import_t_customer
;;
"t_delay_region")
import_t_delay_region
;;
"t_fast_customer")
import_t_fast_customer
;;
"t_fast_package")
import_t_fast_package
;;
"t_fast_package_i")
import_t_fast_package_i
;;
"t_fast_package_i_product")
import_t_fast_package_i_product
;;
"t_finance_customer_relation")
import_t_finance_customer_relation
;;
"t_gf_area_customer")
import_t_gf_area_customer
;;
"t_ka_lllsz")
import_t_ka_lllsz
;;
"t_ka_lscqmxb_b")
import_t_ka_lscqmxb_b
;;
"t_ka_lscqmxb_h")
import_t_ka_lscqmxb_h
;;
"t_ka_splsz")
import_t_ka_splsz
;;
"t_ka_szdzsqdh")
import_t_ka_szdzsqdh
;;
"t_ka_szkhcqlxzz_b")
import_t_ka_szkhcqlxzz_b
;;
"t_ka_szkhcqlxzz_h")
import_t_ka_szkhcqlxzz_h
;;
"t_ka_szkhcqlxzzfb_h")
import_t_ka_szkhcqlxzzfb_h
;;
"t_ka_szkhcqmx_h")
import_t_ka_szkhcqmx_h
;;
"t_ka_szlxjsrq")
import_t_ka_szlxjsrq
;;
"t_ka_yfllsz")
import_t_ka_yfllsz
;;
"t_ka_yflsz")
import_t_ka_yflsz
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
"t_ka_zrye")
import_t_ka_zrye
;;
"t_ka_ztkcrzz")
import_t_ka_ztkcrzz
;;
"t_move_counter")
import_t_move_counter
;;
"t_purity")
import_t_purity
;;
"t_receive")
import_t_receive
;;
"t_sale_from")
import_t_sale_from
;;
"t_sale_from_account_detail")
import_t_sale_from_account_detail
;;
"t_sale_from_detail")
import_t_sale_from_detail
;;
"t_sales_return")
import_t_sales_return
;;
"t_showroom")
import_t_showroom
;;
"t_showroom_counter")
import_t_showroom_counter
;;
"t_technology_purity")
import_t_technology_purity
;;
"all")
import_t_bf_area
import_t_bf_bank_deposit_bill_sz
import_t_bf_bank_deposit_bill_sz_detail
import_t_bf_buy_cus_item
import_t_bf_buy_cus_item_detail
import_t_bf_buy_cus_material
import_t_bf_buyback_material
import_t_bf_change_outsource
import_t_bf_cus_credit_receipt
import_t_bf_cus_debit_receipt
import_t_bf_cust_return_jewelry
import_t_bf_cust_return_jewelry_detail
import_t_bf_customer_the_bill
import_t_bf_dkhhy_b
import_t_bf_dkhhy_h
import_t_bf_gold_transfer_in
import_t_bf_gold_transfer_out
import_t_bf_gold_transfer_out_detail
import_t_bf_gold_transfer_out_print
import_t_bf_gold_transfer_out_print_detail
import_t_bf_pay_cus_material
import_t_bf_pay_cus_material_detail
import_t_bf_pay_outsource
import_t_bf_payment_order
import_t_bf_raw_material
import_t_bf_receive_meterial
import_t_bf_receive_meterial_detail
import_t_bf_repair
import_t_bf_retreat
import_t_bf_settlement
import_t_bf_settlement_adjustment_price
import_t_bf_stock_transfer_bill
import_t_bf_szztgzspd
import_t_bf_szztgzspd_detail
import_t_bf_the_bill
import_t_bf_weighing_form_check
import_t_child_customer
import_t_customer
import_t_delay_region
import_t_fast_customer
import_t_fast_package
import_t_fast_package_i
import_t_fast_package_i_product
import_t_finance_customer_relation
import_t_gf_area_customer
import_t_ka_lllsz
import_t_ka_lscqmxb_b
import_t_ka_lscqmxb_h
import_t_ka_splsz
import_t_ka_szdzsqdh
import_t_ka_szkhcqlxzz_b
import_t_ka_szkhcqlxzz_h
import_t_ka_szkhcqlxzzfb_h
import_t_ka_szkhcqmx_h
import_t_ka_szlxjsrq
import_t_ka_yfllsz
import_t_ka_yflsz
import_t_ka_yslsz
import_t_ka_ysmxz_b
import_t_ka_ysmxz_h
import_t_ka_zrye
import_t_ka_ztkcrzz
import_t_move_counter
import_t_purity
import_t_receive
import_t_sale_from
import_t_sale_from_account_detail
import_t_sale_from_detail
import_t_sales_return
import_t_showroom
import_t_showroom_counter
import_t_technology_purity
;;
esac
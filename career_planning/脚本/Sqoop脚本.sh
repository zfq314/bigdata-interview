1、 # -- sqoop数据导入脚本

# replace(replace(replace(remark,'\n',''),'\t',''),'\r','')  remark, 特殊字符替换 

# date_format(approve_time,'%Y-%m-%d %H:%i:%s') approve_time, 日期格式化

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
case $1 in
"t_showroom")
import_t_showroom
;;
"all")
import_t_showroom
;;
esac







2、-- sqoop数据导出脚本
#!/bin/bash
#-Dmapreduce.job.queuename=hive \
hive_db_name=zfq_test_decent_cloud
mysql_db_name=decent
mysql="/data/program/mysql-8.0.22/bin/mysql"
hive="/data/program/hive-1.2.1/bin/hive"
$hive -e "drop table zfq_test_decent_cloud.ads_gn_szzt_pjlj_temp;
create table zfq_test_decent_cloud.ads_gn_szzt_pjlj_temp location '/zfq_test_decent_cloud/ads_gn_szzt_pjlj_temp' as  select * from zfq_test_decent_cloud.ads_gn_szzt_pjlj ;"

#清空数据表
$mysql -hhadoop31 -P3306 -uroot -phadoopdb-hadooponeoneone@dc.com. --default-character-set=utf8 -e "truncate table decent.ads_gn_szzt_pjlj"

export_data() {
/data/program/sqoop-1.4.6/bin/sqoop export -Dorg.apache.sqoop.export.text.dump_data_on_error=true \
--connect "jdbc:mysql://hadoop31:3306/${mysql_db_name}?useUnicode=true&characterEncoding=utf-8"  \
--username root \
--password hadoopdb-hadooponeoneone@dc.com. \
--table $1 \
--num-mappers 1 \
--export-dir /zfq_test_decent_cloud/ads_gn_szzt_pjlj_temp \
--input-fields-terminated-by "\001" \
--update-mode allowinsert  \
--columns djm,jz,je,dj,dt \
--input-null-string '\\N'    \
--input-null-non-string '\\N'
}

case $1 in
  "ads_gn_szzt_pjlj")
     export_data "ads_gn_szzt_pjlj"
;;
   "all")
     export_data "ads_gn_szzt_pjlj"
;;
esac

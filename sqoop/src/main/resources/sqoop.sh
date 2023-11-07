数据导出脚本模板
decent_cloud_all_import_data.sh 数据导出脚本

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
			case $1 in
			"t_daily_interrest_err_log")
			import_t_daily_interrest_err_log
			;;
			"all")
			import_t_daily_interrest_err_log
			;;
			esac

        SELECT CONCAT('import_',name') FROM result;
        SELECT
        CONCAT(
        'import_',
        NAME,
        '(){\n',
        'import_data "',
        NAME,
        '"',' "',' select * FROM ',name,' where 1=1 ', '"','\n',
        '}')
        FROM
        result;


数据装载脚本
	decent_cloud_all_load_data 数据装载脚本

	#!/bin/bash
	do_date=`date -d "-1 day" +%F`
	db=zfq_test_decent_cloud
	hive=/data/program/hive-1.2.1/bin/hive
	dir=/test_zfq_decent_cloud
	sql="
	set hive.exec.dynamic.partition.mode=nonstrict;
	load data inpath '$dir/t_daily_interrest_err_log/$do_date' into table $db.t_daily_interrest_err_log partition (dt='$do_date');
	 "
	$hive -e "$sql"

    -- 数据装载模板
	SELECT CONCAT('load data inpath ',"'",'$dir/',names,'/$do_date',"'",' into table $db.',names,' partition (dt=',"'",'$do_date',"'",');') FROM `sync_table`

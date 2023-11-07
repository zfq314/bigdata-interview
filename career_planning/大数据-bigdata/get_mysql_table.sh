#!/bin/bash
source /etc/profile

#该脚本为手动传参根据MySQL表信息创建hive表
#输入参数判断逻辑 必须数据两个参数，一个是MySQL库名，第二个是表名
#if [ $# -eq 2 ];then
#		db_name=$1 ##mysql 库名
#		tbl_name=$2 ##MySQL 表名
#else
#        echo "参数个数错误"
#		exit 8
#fi

db_name=decent_cloud
tbl_name=$1

DB_HOST='10.2.12.46'
DB_PORT='3306'
DB_NAME=$db_name
TBL_NAME=$tbl_name
USERNAME='dba'
PASSWORD='dba@2022app'
PARAMS='?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai'

HIVE_DB='sz_decent_cloud'
HIVE_TIR='/sz_decent_cloud'
HIVE_TBL=$HIVE_TIR'_'$DB_NAME'_'$TBL_NAME
echo $HIVE_TBL

echo 'DB_NAME='$DB_NAME
echo 'TBL_NAME='$TBL_NAME

#构建hive建表语句

DDL_TMP=`mysql -h${DB_HOST} -P${DB_PORT} -u${USERNAME} -p${PASSWORD} information_schema -e "

SET SESSION group_concat_max_len=102400; 

SELECT
CONCAT('CREATE TABLE IF NOT EXISTS ',
'${HIVE_DB}',
'.',
'${HIVE_TBL}',
' ( ',
SUBSTRING(column_info, 1, LENGTH(column_info) - 1),
')',
' COMMENT ',
'\'',
TABLE_COMMENT,
'\'',
' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',
'\'\\t\'' ,
' WITH SERDEPROPERTIES (\'field.delim\'=',
'\'\\t\'' ,
',',
'\'serialization.format\'=',
'\'\\t\'' ,
')',
' STORED AS TEXTFILE',
';') AS ddl
FROM
(
SELECT
	TABLE_NAME,
	TABLE_COMMENT ,
	GROUP_CONCAT(CONCAT(COLUMN_NAME,
	' ',
	DATA_TYPE,
	' COMMENT ',
	'\'',
	COLUMN_COMMENT,
	'\'')) AS column_info
FROM
	(
	SELECT
		t1.TABLE_NAME ,
		CASE
			WHEN t2.TABLE_COMMENT = NULL THEN t1.TABLE_NAME
			ELSE t2.TABLE_COMMENT
		END AS TABLE_COMMENT,
		COLUMN_NAME ,
		CASE
			WHEN DATA_TYPE = 'tinyint' THEN 'tinyint'
			WHEN DATA_TYPE = 'smallint' THEN 'smallint'
			WHEN DATA_TYPE = 'mediumint' THEN 'int'
			WHEN DATA_TYPE = 'int' THEN 'int'
			WHEN DATA_TYPE = 'integer' THEN 'int'
			WHEN DATA_TYPE = 'bigint' THEN 'bigint'
			WHEN DATA_TYPE = 'float' THEN 'float'
			WHEN DATA_TYPE = 'double' THEN 'double'
			WHEN DATA_TYPE = 'decimal' THEN 'decimal'
			WHEN DATA_TYPE = 'datetime' THEN 'string'
			WHEN DATA_TYPE = 'timestamp' THEN 'string'
			WHEN DATA_TYPE = 'char' THEN 'string'
			WHEN DATA_TYPE = 'varchar' THEN 'string'
			WHEN DATA_TYPE = 'text' THEN 'string'
			ELSE 'string'
		END AS DATA_TYPE ,
		CASE
			WHEN COLUMN_COMMENT = NULL THEN COLUMN_NAME
			ELSE COLUMN_COMMENT
		END AS COLUMN_COMMENT
	FROM
		COLUMNS t1
	JOIN TABLES t2 ON
		t1.TABLE_NAME = t2.TABLE_NAME
	WHERE
		t1.TABLE_NAME = '$TBL_NAME' ) t3
GROUP BY
	TABLE_NAME,
	TABLE_COMMENT ) t4;

"`

#echo 'DDL_TMP='$DDL_TMP
#截取获得正确的建表语句
DDL=${DDL_TMP:3}
echo 'DDL='$DDL

#hive建表语句
beeline -u "jdbc:hive2://hadoo31:10000/" -n hive -p hive -e "$DDL"
#impala-shell建表
#impala-shell -q "$DDL" -i localhost

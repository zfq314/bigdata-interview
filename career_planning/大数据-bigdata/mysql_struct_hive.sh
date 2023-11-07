#!/bin/bash

DB_HOST='10.2.12.46'
DB_PORT='3306'
DB_NAME=decent_cloud
TBL_NAME=t_receive
USERNAME='dba'
PASSWORD='dba@2022app'
PARAMS='?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai'

HIVE_DB='sz_decent_cloud'
HIVE_TIR='ods'
HIVE_TBL=$HIVE_TIR'_'$TBL_NAME
echo $HIVE_TBL

#构建hive建表语句

abc=$(mysql -h${DB_HOST} -P${DB_PORT} -u${USERNAME} -p${PASSWORD} information_schema -e "

SET SESSION group_concat_max_len=102400; 

SELECT
CONCAT('CREATE TABLE IF NOT EXISTS ',
'${HIVE_DB}',
'.',
'${HIVE_TBL}',
' (',
SUBSTRING(column_info, 1, LENGTH(column_info) - 0),
')',
' COMMENT ',
'\'',
TABLE_COMMENT,
'\'',
' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',
'\'\\t\'' ,
' STORED AS ORC',
' TBLPROPERTIES(\"orc.compress\"=\"ZLIB\")',
';') AS ddl
FROM
(
SELECT
    TABLE_NAME,
    TABLE_COMMENT ,
    GROUP_CONCAT(distinct CONCAT('\`',
COLUMN_NAME,
'\`',
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
            case when data_type='bigint' then 'bigint'
when data_type='binary' then 'binary'
when data_type='char' then 'string'
when data_type='date' then 'string'
when data_type='datetime' then 'string'
when data_type='decimal' then 'double'
when data_type='double' then 'double'
when data_type='enum' then 'string'
when data_type='float' then 'double'
when data_type='int' then 'int'
when data_type='json' then 'map<string,string>'
when data_type='longtext' then 'string'
when data_type='mediumtext' then 'string'
when data_type='smallint' then 'int'
when data_type='text' then 'string'
when data_type='time' then 'string'
when data_type='timestamp' then 'string'
when data_type='tinyint' then 'int'
when data_type='varbinary' then 'binary'
when data_type='varchar' then 'string'
else 'string'
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

")
#截取获得正确的建表语句
DDL=${abc:3}
echo $DDL

#hive执行建表语句

exe_hive="/data/program/hive-1.2.1/bin/hive"
TARGET_DB=sz_decent_cloud
HQL="use ${TARGET_DB};
${DDL}"
bash ${exe_hive} -e "${HQL}"

echo "---完成---"
 
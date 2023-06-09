mysql 字段注释

SELECT
    COLUMN_NAME AS field,
    DATA_TYPE AS data_type,
    COLUMN_COMMENT AS field_comment
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
        TABLE_SCHEMA = 'decent_cloud'
  AND TABLE_NAME = 't_crm_customer' and COLUMN_COMMENT like '%时间%';

mysql 表注释
select table_name 表名,TABLE_COMMENT '表注解' from INFORMATION_SCHEMA.TABLES Where table_schema = 'decent_cloud' AND TABLE_COMMENT  LIKE '%预%';

增量数据导入方式
        先配置canal
        /data/program/canal/conf/canal.properties 修改canal的主要配置

        /data/program/canal/conf/example/instance.properties 修改采集实例的主要配置

        -- 将上面采集的数据写入kafka,修改相关的配置，指定kafka的topic

        /data/program/canal/bin/startup.sh 启动canal



        消费kafka数据,查看数据写入kafka
        kafka-console-consumer.sh --bootstrap-server hadoop31:9092 --topic canal_test



canal过滤掉存储过程的配置

canal.instance.filter.druid.ddl = true
canal.instance.filter.query.dcl = true
canal.instance.filter.query.dml = true
canal.instance.filter.query.ddl = true
canal.instance.filter.table.error =true





hive 建表模板


create table if not exists
(

)
partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/$database/';



生产从库授权信息
# 名城生产库

    限制IP登录：否
        slave2_p：10.2.12.115，端口：3016，用户：hado_select/9GkK5EVbAMM3MZzC6uRteVfskzblyiV，库：decent_cloud，库操作权限：select



*/10 * * * * sh /root/mc-data-sync/




select distinct  get_json_object(data,'$.table') from origin_table;

解析脚本

	select
              field
        from
           (
			SELECT CONCAT('get_json_object(data,''','$.',column_name,''') as ',column_name,',') AS field,ORDINAL_POSITION as a1 ,lead(ORDINAL_POSITION,1) over(ORDER BY ORDINAL_POSITION asc) as a2  FROM information_schema.COLUMNS WHERE  table_schema='decent_cloud' and table_name = "qm_customer_select_all" ORDER BY ORDINAL_POSITION asc
            ) m where m.a2 is not null
        union all
        select
              field
        from
           (SELECT CONCAT('get_json_object(data,''','$.',column_name,''') as ',column_name) AS field,ORDINAL_POSITION as a1 ,lead(ORDINAL_POSITION,1) over(ORDER BY ORDINAL_POSITION asc) as a2  FROM information_schema.COLUMNS WHERE  table_schema='decent_cloud' and table_name = "qm_customer_select_all" ORDER BY ORDINAL_POSITION asc
		   ) m where m.a2 is  null

insert into $destination_bd.t_ka_zjyez partition (dt='$do_date')
select
        id,
        gsmc,
        zh,
        je,
        zjlx,
        yh,
        yhzh,
        czzt,
        customer_identity,
        parent_customer_identity
from(
select
        get_json_object(data,'$.id') as id,
        get_json_object(data,'$.gsmc') as gsmc,
        get_json_object(data,'$.zh') as zh,
        get_json_object(data,'$.je') as je,
        get_json_object(data,'$.zjlx') as zjlx,
        get_json_object(data,'$.yh') as yh,
        get_json_object(data,'$.yhzh') as yhzh,
        get_json_object(data,'$.czzt') as czzt,
        get_json_object(data,'$.customer_identity') as customer_identity,
        get_json_object(data,'$.parent_customer_identity') as parent_customer_identity,
        row_number() over (partition by get_json_object(data,'$.id')order by  ts desc) rk
from (
    select
       translate( translate(get_json_object(data,'$.data'),'[','') ,']','') as data,
       get_json_object(data,'$.ts') as ts,
       get_json_object(data,'$.type') as type,
       dt
    from  $source_db.origin_table where  get_json_object(data,'$.table')='t_ka_zjyez' and dt='$do_date'
         )m)t where rk=1;



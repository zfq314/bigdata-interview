##### 知识大面

```
系统平台 （Hadoop、CDH、HDP）
监控管理 （CM、Hue、Ambari、Dr.Elephant、Ganglia、Zabbix、Eagle）
文件系统 （HDFS、GPFS、Ceph、GlusterFS、Swift 、BeeGFS、Alluxio）
资源调度 （YARN、Mesos）
协调框架 （ZooKeeper 、Etcd、Consul）
数据存储 （HBase、Cassandra、ScyllaDB 、MongoDB、Accumulo 、Redis 、Ignite、Arrow 、Geode、CouchDB、Kudu、CarbonData）
数据处理 （MapReduce、Spark、Flink、Storm、Tez、Samza、Apex、Beam、Heron）
查询分析（Hive、SparkSQL、Presto、Kylin、Impala、Druid、ElasticSearch、HAWQ、Lucene、Solr、 Phoenix）
数据收集 （Flume、Filebeat、Logstash、Chukwa ）
数据交换 （Sqoop 、Kettle、DataX 、NiFi）
消息系统 （Pulsar、Kafka、RocketMQ、ActiveMQ、RabbitMQ）
任务调度 （Azkaban、Oozie、Airflow、Dolphinscheduler）
数据治理 （Ranger 、Sentry、Atlas）
可视化 （Kibana 、D3.js、ECharts）
数据挖掘 （Mahout 、MADlib 、Spark ML、TensorFlow、Keras）
云平台 （Amazon S3、GCP、Microsoft Azure）
```

##### linux_shell

```
后台挂起的命令：nohup ./decent_cloud_all_import_data.sh all >./sqoop.log 2>&1 &
```

##### java

```

```

##### hdfs

```
hdfs_ha
读流程
写流程
任务提交流程
```

##### kafka

```
基本命令
查看topic: kafka-topics.sh  --zookeeper hadoop31:2181 --list
创建topic: kafka-topics.sh --create --topic  test --zookeeper hadoop31:2181 --partitions 3  --replication-factor 2
生产topic: kafka-console-producer.sh --topic test  --broker-list hadoop31:9092
消费topic: kafka-console-consumer.sh  --topic test --from-beginning --bootstrap-server hadoop31:9092
消费kafka的命令：kafka-console-consumer.sh --bootstrap-server hadoop31:9092 --topic canal_test
```

##### zookeeper

```

```

##### flume

```
flume启动命令：/data/program/flume/bin/flume-ng agent -n a2 -c conf -f /data/program/flume/conf/kafka-to-hdfs-dc.conf -Dflume.root.log ger=INFO,console


	flume 采集脚本
	#! /bin/bash
	case $1 in
	"start"){
	for i in hadoop31
	do
	echo " ============================ ★ 启动 $i 采集flume ============================ "
	ssh $i "nohup /data/program/flume/bin/flume-ng agent --conf-file /data/program/flume/conf/kafka-flume-hdfs-topic-decent_cloud.conf --name a1 -Dflume.root.logger=INFO,LOGFILE >/data/program/flume/kafka-flume-hdfs-topic-decent_cloud.log 2>&1  &"
	done
	};;
	"stop"){
	for i in hadoop31
	do
	echo " ============================ ★ 停止 $i 采集flume ============================ "
	ssh $i "ps -ef | grep kafka-flume-hdfs-topic-decent_cloud | grep -v grep |awk  '{print $2}' | xargs -n1 kill -9 "
	done
	};;
	esac
```

##### sqoop

```
#! /bin/bash
if [ -n "$2" ] ;then
do_date=$2
else
do_date=`date -d '-1 day' +%F`
fi
sqoop=/data/program/sqoop-1.4.6/bin/sqoop

database=decent_cloud
passwd=Decent@2023dba
user=dba
dir=mczt_decent_cloud

import_data() {
$sqoop import -D mapreduce.job.queuename=default \
--driver com.mysql.cj.jdbc.Driver \
--connect "jdbc:mysql://10.10.80.140:3306/decent_cloud?tinyInt1isBit=false&zerodatetimebehavior=converttonull&serverTimezone=GMT%2B8&&useSSL=false&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=utf-8" \
--fields-terminated-by "\t" \
--username $user \
--password $passwd \
--delete-target-dir \
--null-string '\\N' \
--null-non-string '\\N' \
--target-dir /$dir/$1/$do_date \
--delete-target-dir \
--num-mappers 1 \
--fields-terminated-by "\t" \
--query "$2"' and  $CONDITIONS;'
}
import_t_customer_discount_detail_hs(){
import_data "t_customer_discount_detail_hs" " select * FROM t_customer_discount_detail_hs where 1=1 "
}
case $1 in
"all")
import_t_customer_discount_detail_hs
;;
esac
```

##### flink

```

```

##### flinkcdc

```

```

##### hive

```

```

##### hbase

```

```

##### datax

```

```

##### doris

```

```

##### Phoenix

```

```

##### clickhouse

```

```

##### Druid

```

```

##### Kylin

```

```

##### Presto

```

```

##### python

```

```

##### spark

```

```

##### mysql

```
函数
存储过程
索引优化

############### 字段查询	
		select 
              field 
        from 
           (
			SELECT CONCAT(column_name,',') AS field,ORDINAL_POSITION as a1 ,lead(ORDINAL_POSITION,1) over(ORDER BY ORDINAL_POSITION asc) as a2  FROM information_schema.COLUMNS WHERE  table_schema='decent_cloud' and table_name = "t_sale_from" ORDER BY ORDINAL_POSITION asc
            ) m where m.a2 is not null 
        union all
        select 
              field 
        from 
           (SELECT column_name AS field,ORDINAL_POSITION as a1 ,lead(ORDINAL_POSITION,1) over(ORDER BY ORDINAL_POSITION asc) as a2  FROM information_schema.COLUMNS WHERE  table_schema='decent_cloud' and table_name = "t_sale_from" ORDER BY ORDINAL_POSITION asc
		   ) m where m.a2 is  null
###############
###有助于hive里面建表 mysql 字段获取 建表的时候，字段获取，字段和数据类型查询
				select 
						  LOWER(field) as field
						  ,type
					from 
					   (
								SELECT 		
									CONCAT(column_name) AS field,
									case data_type 
									when 'varchar' then 'string,'
									when 'datetime' then 'string,'
									when 'bigint' then 'bigint,'
									when 'int' then 'int,'
									when 'tinyint' then 'int,'
									when 'int' then 'int,'
									when 'longblob' then 'string,'
									when 'text' then 'string,'
									when 'longtext' then 'string,'
									when 'decimal' then 'decimal(18,2),'
									when 'date' then 'string,'
									when 'json' then 'string,'
									when 'char' then 'string,'
									when 'blob' then 'string,'
									when 'smallint' then 'int,'
									when 'double' then 'double,'
									when 'mediumtext' then 'string,'
									when 'bit' then 'int,' 
									else 'type err--'  
									end as type,
			ORDINAL_POSITION as a1 ,lead(ORDINAL_POSITION,1) over(ORDER BY ORDINAL_POSITION asc) as a2  FROM information_schema.COLUMNS WHERE  table_schema='decent_cloud' and table_name = "sys_permission" ORDER BY ORDINAL_POSITION asc
						) m where m.a2 is not null 
					union all
					select 
						  LOWER(field) as field
						  ,type
					from 
					   (SELECT 	   column_name AS field,
								    case data_type 
									when 'varchar' then 'string'
									when 'datetime' then 'string'
									when 'bigint' then 'bigint'
									when 'int' then 'int'
									when 'tinyint' then 'int'
									when 'int' then 'int'
									when 'longblob' then 'string'
									when 'text' then 'string'
									when 'longtext' then 'string'
									when 'decimal' then 'decimal(18,2)'
									when 'date' then 'string'
									when 'json' then 'string'
									when 'char' then 'string'
									when 'blob' then 'string'
									when 'smallint' then 'int'
									when 'double' then 'double'
									when 'mediumtext' then 'string' 
									when 'bit' then 'int' 
									else 'type err--'  
									end as type,
			ORDINAL_POSITION as a1 ,lead(ORDINAL_POSITION,1) over(ORDER BY ORDINAL_POSITION asc) as a2  FROM information_schema.COLUMNS WHERE  table_schema='decent_cloud' and table_name = "sys_permission" ORDER BY ORDINAL_POSITION asc
					   ) m where m.a2 is  null
#####################################end####################################		   
		   
```

##### sqlserver

```
eos一些语法
基本的用法
sql的存储过程
支持跨库查询
一些基本语法的差异
```

##### 离线数仓

```

```

##### 实时数仓

```
实时数仓搭建流程
```

##### 数仓建模

```
范式关系建模
维度建模
```

##### 采集系统

```
离线采集系统 日志-flume-kafka-flume-hdfs-hive
实时采集系统
```

##### 岗位

```
数仓开发工程师
大数据开发工程师
etl工程师
数据开发工程师
数据平台开发工程师
```


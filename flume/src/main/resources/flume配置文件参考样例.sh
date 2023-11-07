写flume采集配置文件 kafka-to-hdfs-dc.conf

		## 组件
		a2.sources=r2
		a2.channels=c1
		a2.sinks=k2

		## source1数据源
		a2.sources.r2.type = org.apache.flume.source.kafka.KafkaSource
		a2.sources.r2.batchSize = 5000
		a2.sources.r2.batchDurationMillis = 2000
		a2.sources.r2.kafka.bootstrap.servers = hadoop31:9092,hadoop32:9092,hadoop33:9092
		a2.sources.r2.kafka.topics= canal_test

		## channel1数据通道
		a2.channels.c1.type = file
		a2.channels.c1.checkpointDir = /data/program/flume/checkpoint/canal_test
		a2.channels.c1.dataDirs = /data/program/flume/data/canal_test/
		a2.channels.c1.maxFileSize = 2146435071
		a2.channels.c1.capacity = 1000000
		a2.channels.c1.keep-alive = 6

		## sink2数据流向
		a2.sinks.k2.type = hdfs
		a2.sinks.k2.hdfs.path = /origin_data/canal_test/%Y-%m-%d/
		a2.sinks.k2.hdfs.filePrefix = canal_test
		a2.sinks.k2.hdfs.round = false

		## 控制小文件的产生
		a2.sinks.k2.hdfs.rollInterval = 60
		a2.sinks.k2.hdfs.rollSize = 0
		a2.sinks.k2.hdfs.rollCount = 0
		## 控制输出文件是原生文件。
		a2.sinks.k2.hdfs.fileType = CompressedStream
		a2.sinks.k2.hdfs.codeC = lzop

		## 拼装
		a2.sources.r2.channels = c1
		a2.sinks.k2.channel= c1


参数解释:
a2.sinks.k2.hdfs.rollInterval = 60 -- 指定多久生产一个文件
a2.sinks.k2.hdfs.rollSize = 0 -- 指定达到文件指定的大小会滚动生产文件  如果值是0 表示此参数禁用
a2.sinks.k2.hdfs.rollCount = 0 -- 指定event的个数， 如果值是0 表示此参数禁用

启动flume命令
	/data/program/flume/bin/flume-ng agent -n a2 -c conf -f /data/program/flume/conf/kafka-to-hdfs-dc.conf -Dflume.root.log ger=INFO,console


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
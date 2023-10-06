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
架构：生产者、broker、消费者、zookeeper
生产端分区分配策略：
	UniformStickyPartitioner纯粹的粘性分区器 
		（1）如果指定了分区号，则会按照指定的分区号进行分配
		（2）若没有指定分区好，则使用粘性分区器
	RoundRobinPartitioner轮询分区器
        （1）如果在消息中指定了分区则使用指定分区。
        （2）如果未指定分区，都会将消息轮询每个分区，将数据平均分配到每个分区中。
    自定义分区器
		自定义分区策略：可以通过实现 org.apache.kafka.clients.producer.Partitioner 接口，重写 partition 方法来达到自定义分区效果。
		
kafka丢不丢数据
	Producer角度
    acks=0，生产者发送过来数据就不管了，可靠性差，效率高；
    acks=1，生产者发送过来数据Leader应答，可靠性中等，效率中等；
    acks=-1 生产者发送过来数据Leader和ISR队列里面所有Follwer应答，可靠性高，效率低；
    在生产环境中，acks=0很少使用；acks=1，一般用于传输普通日志，允许丢个别数据；acks=-1，一般用于传输和钱相关的数据，对可靠性要求比较高的场景。
    
    Broker角度
	副本数大于等于2。
	min.insync.replicas大于等于2。
	
Kafka的ISR副本同步队列
    ISR（In-Sync Replicas），副本同步队列。如果Follower长时间未向Leader发送通信请求或同步数据，则该Follower将被踢出ISR。该时间阈值由replica.lag.time.max.ms参数设定，默认30s。
    任意一个维度超过阈值都会把Follower剔除出ISR，存入OSR（Outof-Sync Replicas）列表，新加入的Follower也会先存放在OSR中。
    Kafka分区中的所有副本统称为AR = ISR + OSR
    
Kafka数据重复
去重 = 幂等性 + 事务
    Kafka的事务一共有如下5个API
    // 1初始化事务
    void initTransactions();

    // 2开启事务
    void beginTransaction() throws ProducerFencedException;

    // 3在事务内提交已经消费的偏移量（主要用于消费者）
    void sendOffsetsToTransaction(Map<TopicPartition, OffsetAndMetadata> offsets,
                                  String consumerGroupId) throws ProducerFencedException;

    // 4提交事务
    void commitTransaction() throws ProducerFencedException;

    // 5放弃事务（类似于回滚事务的操作）
    void abortTransaction() throws ProducerFencedException;

	（1）生产者角度
        acks设置为-1 （acks=-1）。
        幂等性（enable.idempotence = true） + 事务 。
	（2）broker服务端角度
        分区副本大于等于2 （--replication-factor 2）。
        ISR里应答的最小副本数量大于等于2 （min.insync.replicas = 2）。
	（3）消费者
        事务 + 手动提交offset （enable.auto.commit = false）。
        消费者输出的目的地必须支持事务（MySQL、Kafka）。

 Kafka如何保证数据有序or怎么解决乱序
   Kafka 最多只保证单分区内的消息是有序的，所以如果要保证业务全局严格有序，就要设置 Topic 为单分区。
   如何设置单分区内有序;
   方案一
   		禁止重试，设置参数
   		设置retries 等于0
   		说明，数据出现乱序的根本原因，失败重试，关闭重试，则可以保证数据是有序的，但是这样做，可能回导致数据丢失
   方案二
   		启用幂等性需设置以下参数
   		设置enable.idempotence=true启用幂等
   		设置max.in.flight.requests.per.connection 1.0.x之后，小于等于5
   		设置retries 保证大于0
   		设置acks 保证其为-1
   		
 Kafka分区Leader选举规则
在ISR中存活为前提，按照AR中排在前面的优先。例如AR[1,0,2]，ISR [1，0，2]，那么Leader就会按照1，0，2的顺序轮询。

Kafka中AR的顺序
如果Kafka服务器只有4个节点，那么设置Kafka的分区数大于服务器台数，在Kafka底层如何分配存储副本呢？

Kafka日志保存时间
默认保存7天；生产环境建议3天。

 Kafka过期数据清理
日志清理的策略只有delete和compact两种。
delete日志删除：将过期数据删除
log.cleanup.policy = delete ，所有数据启用删除策略
（1）基于时间：默认打开。以segment中所有记录中的最大时间戳作为该文件时间戳。
（2）基于大小：默认关闭。超过设置的所有日志总大小，删除最早的segment。
log.retention.bytes，默认等于-1，表示无穷大。

如果一个 segment 中有一部分数据过期，一部分没有过期，怎么处理？
处理的规则：等待获取最新数据时间戳，也就是所有记录中的最大时间戳，作为判断过期的依据，然后进行清理。

compact 日志压缩： 对于相同 key 的不同 value 值，只保留最后一个版本。
压缩后的 offset 可能是不连续的，比如上图中没有 6 ，当从这些 offset 消费消息时，将会拿到比这个 offset 大
的 offset 对应的消息，实际上会拿到 offset 为 7 的消息，并从这个位置开始消费。
这种策略只适合特殊场景，比如消息的 key 是用户 ID ， value 是用户的资料，通过这种压缩策略，整个消息 集里就保存了所有用户最新的资料。

Kafka为什么能高效读写数据
    1）Kafka本身是分布式集群，可以采用分区技术，并行度高
    2）读数据采用稀疏索引，可以快速定位要消费的数据
    3）顺序写磁盘
    Kafka的producer生产数据，要写入到log文件中，写的过程是一直追加到文件末端，为顺序写。官网有数据表明，同样的磁盘，顺序写能到600M/s，而随机写只有100K/s。这与磁盘的机械机构有关，顺序写之所以快，是因为其省去了大量磁头寻址的时间。
	4）页缓存 + 零拷贝技术

自动创建主题
如果Broker端配置参数auto.create.topics.enable设置为true（默认值是true），那么当生产者向一个未创建的主题发送消息时，会自动创建一个分区数为num.partitions（默认值为1）、副本因子为default.replication.factor（默认值为1）的主题。除此之外，当一个消费者开始从未知主题中读取消息时，或者当任意一个客户端向未知主题发送元数据请求时，都会自动创建一个相应主题。这种创建主题的方式是非预期的，增加了主题管理和维护的难度。生产环境建议将该参数设置为false。

副本数设定
一般我们设置成2个或3个，很多企业设置为2个。
副本的优势：提高可靠性；副本劣势：增加了网络IO传输。

Kakfa分区数
（1）创建一个只有1个分区的Topic。
（2）测试这个Topic的Producer吞吐量和Consumer吞吐量。
（3）假设他们的值分别是Tp和Tc，单位可以是MB/s。
（4）然后假设总的目标吞吐量是Tt，那么分区数 = Tt / min（Tp，Tc）。
例如：Producer吞吐量 = 20m/s；Consumer吞吐量 = 50m/s，期望吞吐量100m/s；
分区数 = 100 / 20 = 5分区
分区数一般设置为：3-10个
分区数不是越多越好，也不是越少越好，需要搭建完集群，进行压测，再灵活调整分区个数。


Kafka增加分区
1）可以通过命令行的方式增加分区，但是分区数只能增加，不能减少。
2）为什么分区数只能增加，不能减少？
（1）按照Kafka现有的代码逻辑而言，此功能完全可以实现，不过也会使得代码的复杂度急剧增大。
（2）实现此功能需要考虑的因素很多，比如删除掉的分区中的消息该作何处理？
    如果随着分区一起消失则消息的可靠性得不到保障；
    如果需要保留则又需要考虑如何保留，直接存储到现有分区的尾部，消息的时间戳就不会递增，如此对于Spark、Flink这类需要消息时间戳（事件时间）的组件将会受到影响；
    如果分散插入到现有的分区中，那么在消息量很大的时候，内部的数据复制会占用很大的资源，而且在复制期间，此主题的可用性又如何得到保障？
    同时，顺序性问题、事务性问题、以及分区和副本的状态机切换问题都是不得不面对的。
（3）反观这个功能的收益点却是很低，如果真的需要实现此类的功能，完全可以重新创建一个分区数较小的主题，然后将现有主题中的消息按照既定的逻辑复制过去即可。

Kafka中多少个Topic
ODS层：2个
DWD层：20个

Kafka消费者是拉取数据还是推送数据
拉取数据。

 Kafka消费端分区分配策略
 粘性分区：
该分区分配算法是最复杂的一种，可以通过 partition.assignment.strategy 参数去设置，从 0.11 版本开始引入，目的就是在执行新分配时，尽量在上一次分配结果上少做调整，其主要实现了以下2个目标：
（1）Topic Partition 的分配要尽量均衡。
（2）当 Rebalance 发生时，尽量与上一次分配结果保持一致。
注意：当两个目标发生冲突的时候，优先保证第一个目标，这样可以使分配更加均匀，其中第一个目标是3种分配策略都尽量去尝试完成的，而第二个目标才是该算法的精髓所在

消费者再平衡的条件
1）Rebalance 的触发条件有三种
（1）当Consumer Group 组成员数量发生变化（主动加入、主动离组或者故障下线等）。
（2）当订阅主题的数量或者分区发生变化。

3）主动加入消费者组
在现有集中增加消费者，也会触发Kafka再平衡。注意，如果下游是Flink，Flink会自己维护offset，不会触发Kafka再平衡。


指定Offset消费
可以在任意offset处消费数据。
kafkaConsumer.seek(topic, 1000);


指定时间消费
可以通过时间来消费数据。
HashMap<TopicPartition, Long> timestampToSearch = new HashMap<>();
timestampToSearch.put(topicPartition, System.currentTimeMillis() - 1 * 24 * 3600 * 1000);
kafkaConsumer.offsetsForTimes(timestampToSearch);


 Kafka数据积压
1）发现数据积压
通过Kafka的监控器Eagle，可以看到消费lag，就是积压情况：

（1）消费者消费能力不足
①可以考虑增加Topic的分区数，并且同时提升消费组的消费者数量，消费者数 = 分区数。（两者缺一不可）。
增加分区数；
bin/kafka-topics.sh --bootstrap-server hadoop102:9092 --alter --topic first --partitions 3
②提高每批次拉取的数量，提高单个消费者的消费能力。

（2）消费者处理能力不行
①消费者，调整fetch.max.bytes大小，默认是50m。
②消费者，调整max.poll.records大小，默认是500条。
如果下游是Spark、Flink等计算引擎，消费到数据之后还要进行计算分析处理，当处理能力跟不上消费能力时，会导致背压的出现，从而使消费的速率下降。

需要对计算性能进行调优（看Spark、Flink优化）。
（3）消息积压后如何处理
某时刻，突然开始积压消息且持续上涨。这种情况下需要你在短时间内找到消息积压的原因，迅速解决问题。
导致消息积压突然增加，只有两种：发送变快了或者消费变慢了。
假如赶上大促或者抢购时，短时间内不太可能优化消费端的代码来提升消费性能，此时唯一的办法是通过扩容消费端的实例数来提升总体的消费能力。如果短时间内没有足够的服务器资源进行扩容，只能降级一些不重要的业务，减少发送方发送的数据量，最低限度让系统还能正常运转，保证重要业务服务正常。
假如通过内部监控到消费变慢了，需要你检查消费实例，分析一下是什么原因导致消费变慢？
①优先查看日志是否有大量的消费错误。
②此时如果没有错误的话，可以通过打印堆栈信息，看一下你的消费线程卡在哪里「触发死锁或者卡在某些等待资源」。

如何提升吞吐量
如何提升吞吐量？
1）提升生产吞吐量
（1）buffer.memory：发送消息的缓冲区大小，默认值是32m，可以增加到64m。
（2）batch.size：默认是16k。如果batch设置太小，会导致频繁网络请求，吞吐量下降；如果batch太大，会导致一条消息需要等待很久才能被发送出去，增加网络延时。
（3）linger.ms，这个值默认是0，意思就是消息必须立即被发送。一般设置一个5-100毫秒。如果linger.ms设置的太小，会导致频繁网络请求，吞吐量下降；如果linger.ms太长，会导致一条消息需要等待很久才能被发送出去，增加网络延时。
（4）compression.type：默认是none，不压缩，但是也可以使用lz4压缩，效率还是不错的，压缩之后可以减小数据量，提升吞吐量，但是会加大producer端的CPU开销。
2）增加分区
3）消费者提高吞吐量
（1）调整fetch.max.bytes大小，默认是50m。
（2）调整max.poll.records大小，默认是500条。

 Kafka中数据量计算
每天总数据量100g，每天产生1亿条日志，10000万/24/60/60=1150条/每秒钟
平均每秒钟：1150条
低谷每秒钟：50条
高峰每秒钟：1150条 *（2-20倍）= 2300条 - 23000条
每条日志大小：0.5k - 2k（取1k）
每秒多少数据量：2.0M - 20MB

 Kafka如何压测？
用Kafka官方自带的脚本，对Kafka进行压测。
生产者压测：kafka-producer-perf-test.sh
消费者压测：kafka-consumer-perf-test.sh

磁盘选择
kafka底层主要是顺序写，固态硬盘和机械硬盘的顺序写速度差不多。
建议选择普通的机械硬盘。
每天总数据量：1亿条 * 1k ≈ 100g
100g * 副本2 * 保存时间3天 / 0.7 ≈ 1T
建议三台服务器硬盘总大小，大于等于1T。

内存选择
Kafka内存组成：堆内存 + 页缓存

Kafka挂掉
在生产环境中，如果某个Kafka节点挂掉。
正常处理办法：
（1）先看日志，尝试重新启动一下，如果能启动正常，那直接解决。
（2）如果重启不行，检查内存、CPU、网络带宽。调优=》调优不行增加资源
（3）如果将Kafka整个节点误删除，如果副本数大于等于2，可以按照服役新节点的方式重新服役一个新节点，并执行负载均衡。


服役新节点退役旧节点
可以通过bin/kafka-reassign-partitions.sh脚本服役和退役节点


Kafka单条日志传输大小
Kafka对于消息体的大小默认为单条最大值是1M但是在我们应用场景中，常常会出现一条消息大于1M，如果不对Kafka进行配置。则会出现生产者无法将消息推送到Kafka或消费者无法去消费Kafka里面的数据，这时我们就要对Kafka进行以下配置：server.properties。


Kafka参数优化
重点调优参数：
（1）buffer.memory 32m
（2）batch.size：16k
（3）linger.ms默认0  调整 5-100ms
（4）compression.type采用压缩 snappy
（5）消费者端调整fetch.max.bytes大小，默认是50m。
（6）消费者端调整max.poll.records大小，默认是500条。
（7）单条日志大小：message.max.bytes、max.request.size、replica.fetch.max.bytes适当调整2-10m
（8）Kafka堆内存建议每个节点：10g ~ 15g 
在kafka-server-start.sh中修改
if [ "x$KAFKA_HEAP_OPTS" = "x" ]; then
    export KAFKA_HEAP_OPTS="-Xmx10G -Xms10G"
fi
（9）增加CPU核数
num.io.threads = 8  负责写磁盘的线程数
num.replica.fetchers = 1 副本拉取线程数 
num.network.threads = 3  数据传输线程数
	（10）日志保存时间log.retention.hours 3天
	（11）副本数，调整为2
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
1、decimal
hive 除了支持 int,double,string等常用类型，也支持 decimal 类型，用于在数据库中存储精确的数值，常用在表示金额的字段上

Hive SQL的group by对比MySQL，有一个让我特别不能接受的原则：select后面所有的列中，没有使用聚合函数的列，必须出现在group by子句中。

使用 load data local 表示从本地文件系统加载，文件会拷贝到hdfs上
使用 load data 表示从hdfs文件系统加载，文件会直接移动到hive相关目录下，注意不是拷贝过去，因为hive认为hdfs文件已经有3副本了，没必要再次拷贝了
如果表是分区表，load 时不指定分区会报错
如果加载相同文件名的文件，会被自动重命名

如果 hdfs 开启了回收站，drop 删除的表数据是可以从回收站恢复的，表结构恢复不了，需要自己重新创建；truncate 清空的表是不进回收站的，所以无法恢复truncate清空的表。
所以 truncate 一定慎用，一旦清空除物理恢复外将无力回天


join连接

INNER JOIN 内连接：只有进行连接的两个表中都存在与连接条件相匹配的数据才会被保留下来
LEFT OUTER JOIN 左外连接：左边所有数据会被返回，右边符合条件的被返回
RIGHT OUTER JOIN 右外连接：右边所有数据会被返回，左边符合条件的被返回、
FULL OUTER JOIN 满外(全外)连接: 将会返回所有表中符合条件的所有记录。如果任一表的指定字段没有符合条件的值的话，那么就使用NULL值替代。


hive2版本已经支持不等值连接，就是 join on条件后面可以使用大于小于符号;
并且也支持 join on 条件后跟or (早前版本 on 后只支持 = 和 and，不支持 > < 和 or)
如hive执行引擎使用MapReduce，一个join就会启动一个job，一条sql语句中如有多个join，则会启动多个job

left semi join
为什么把这个单独拿出来说，因为它和其他的 join 语句不太一样，
这个语句的作用和 in/exists 作用是一样的，是 in/exists 更高效的实现
SELECT A.* FROM A where id in (select id from B)
SELECT A.* FROM A left semi join B ON A.id=B.id
上述两个 sql 语句执行结果完全一样，只不过第二个执行效率高


聚合函数中 null 值
聚合操作时要注意 null 值：
count(*) 包含 null 值，统计所有行数；
count(id) 不包含id为 null 的值；
min 求最小值是不包含 null，除非所有值都是 null；
avg 求平均值也是不包含 null。
以上需要特别注意，null 值最容易导致算出错误的结果

get_json_object的用法
get_json_object(columnname,'$.getname')


- 常和聚合函数在一起;
- 出现在 group by 中的字段可以出现在 select中，也可以不出现，
  但是出现在 select中字段（除函数和常量外）必须在group by 出现过的字段。


 having  与 where 的不同
1） where 后面不能写分组函数，但是 having 可以 ；
2） having 只用于 Group by 分组统计语句；


排序
全局排序 ： Order By
1)  全局排序，只能有一个Reducer ；
2） DESC : 降序 ；
3)  ASC : 升序（'默认值'）；
4） Order by 子句必须在SELECT语句的结尾 ；
5)  排序的字段可以是多个；
示例：
select id , name ,sal from emp order by sal desc ,name asc ;
-- 先按照薪水降序，薪水相同的，则按照名字进行升序排序；


mapreduce内部排序 ：sort by
1)  理解：
理解为在 reduce 中进行排序。所以一般是需要有多个 reduce 才有作用，是在每个reduce中进行排序，属于局部排序，而不是全局排序。
2） 使用场景：
当数据量很大时，不要进行全局排序，只需要进行局部排序。
3） 一般不单独使用，因为无法控制什么样的数据进入同一个 reduce 中；
-- 一般配合distribute by 使用，分区排序就是指定什么样的数据会进入同一个reduce中。
4） 单独使用时，进入同一个 reduce 任务中的数据是随机的。 -- 伪随机，就是每次计算的结果是一样的，但是进入每一个reduce 中的数据是随机的。

-- 示例：
1） 设置reducer的个数：
set mapreduce.job.reduces=3; -- 设置reduce个数为3
2） 根据部门编号降序查看员工信息 ： 
select * from emp sort by deptno desc;
-- 此时生成3个结果文件，并且每个结果文件中均是按照deptno 进行降序排序。

分区排序 ： distribute by
1. 理解 ： 类似在 MapReduce 中的自定义分区（partition ）;
2. 一般就是配合 sort by 使用；
3. 同样，在使用的时候，不能是一个reduce，需要多个reduce；
4. 什么样的数据会进行同一个reduce 呢 ？
  1）首先，这个分区不是很智能，使用的方式是：分区的字段的 （ hashcode  % reduce的个数 ），计算值相等的，则进入同一个reduce；
  2）不会使用toString方式进行分区。
5. distribute by 必须写在sort by 的前面；
6. tez 引擎会进行reduce的优化，即假设设置为3个reduce，但是运行时有可能是2个reduce，所以验证时032，需使用mr引擎。-- set hive.execution.engine=mr;

-- 示例：
insert overwrite local directory '/opt/module/hive/datas/distribute-result' select * from emp distribute by deptno sort by empno desc; -- 假设 reduce = 3 ；
-- 先按照deptno进行分区(m = hashcode(deptno) % 3 , m值相等的数据进入同一个分区），然后在分区内进行局部排序，最后将查询的结果导出到本地指定的一个文件中。


Cluster By
1. 理解 ：当distribute by 和 sort by 的字段相同时，可以使用Cluster by 进行替代；
2. 不能指定排序的顺序，只能是升序。

-- 示例：
方式一 ：select * from emp  cluster by deptno ;
方式二 ：select * from emp distribute by deptno sort by deptno ;
-- 方式一和方式二是等价的。

分区表
-- 理解：
1） Hive 中的分区就是分目录 ；
2） 分区表对应一个hdfs文件系统的独立的文件；
3） 实际上是把一个大的数据集根据业务的需求分割成多个小的数集；
4） 在查询时，通过where语句进行条件筛选，指定数据在哪个分区内，提高查询的效率；
5)  同时用于解决数据倾斜的问题。

分桶表
-- 理解：为什么会有分桶表？或者说分桶表是用来解决什么问题呢？
1）提供一个数据隔离和优化查询的便利方式，如当某一个表或者是某一个分区的数据量特别大时，通过分桶的方式，可以将数据再进行分解成多个模块，这样在进行查询时，提供了查询的效率。 -- 说明查询的分区操作时自动的。
2）什么样的数据会进入同一个桶中呢？
通过 （分桶字段的）hashcode % 桶的个数 ，取模数相等的进入同一个桶内。（不适用于TEZ引擎）
3）分桶表针对的是数据文件；而分区是针对数据路径。                                        


常用函数
1） unix_timestamp : 返回当前或指定的时间戳；
SELECT  unix_timestamp("2020-05-02 11:22:00"); ==>1588418520
2） from_unixtime : 将时间戳转化为日期格式
SELECT FROM_unixtime(1588418520); ==> 2020-05-02 11:22:00
3) current_date : 当前日期
4）current_timestamp: 当前日期 + 时间；
5）to_date : 获取日期部分
6）year/month/day/hour/minute/second() : 获取年、月、日、小时、分、秒
7）weekofyear(): 当前时间是一年中的第几周
8）dayofmonth(): 当前时间是一个月中的第几天
9）months_between() : 两个日期间的月份
10) datediff() : 两个日期相差的天数
11) add_months：日期加减月
12) date_add：日期加天数
13) date_sub：日期减天数
14) last_day: 日期的当月的最后一天

1） 查看系统自带的函数
show functions;
2) 查询函数的用法
desc function extended 函数名


集合操作
1） size： 集合中元素的个数
2） map_keys： 返回map中的key
3） map_values: 返回map中的value
4） array_contains: 判断array中是否包含某个元素
5） sort_array： 将array中的元素排序

取整函数

1) round： 四舍五入
2) ceil：  向上取整
3) floor： 向下取整

字符串处理
1）upper： 转大写
2）lower： 转小写
3）length： 长度
4）trim：  前后去空格
5）lpad： 向左补齐，到指定长度
6）rpad：  向右补齐，到指定长度
7）regexp_replace： SELECT regexp_replace('100-200', '(\\d+)', 'num') ；
	使用正则表达式匹配目标字符串，匹配成功后替换！
	
	

空值处理 
-- 语法：
nvl(value,default_value)

-- 说明：
1）如果value 为null，则返回default_value ，否则返回vaule；
2）如果两个值（value , default_value）均为null，则返回null；


case when sum

-- 示例：
select 
  dept_id,
  sum(case sex when '男' then 1 else 0 end) male_count,
  sum(case sex when '女' then 1 else 0 end) female_count
from 
  emp_sex
group by
  dept_id;
  
  /*  解读：
  1.按照dept_id 进行分组，同一组的数据先进行计算；
  2.假设dept_id=10的数据有10条，则10数据分别在sum函数中进行计算，计算完成以后得出一个结果；
  3.一组数据最后得到一条数据结果。
  */


行专列
-- 相关函数
1） concat('str1','str2','str3',...) : 表示将str1/str2/str3... 依次进行连接，str1/str2/str3... 可以说任何数据类型；
-- 示例：SELECT  concat('132','-','456'); ==> 132-456

2) concat_ws('连接符'，'str1','str2',...) : 表示使用'连接符'将str1/str2...依次进行连接，str1/str2...只能是字符串或者是字符串数组。
-- 示例：
SELECT  concat_ws('-','java','maven'); ==> java-maven;
SELECT  concat_ws(null,'java','maven'); ==> null -- 当连接符为null时，结果返回null
SELECT  concat_ws('.', 'www', array('facebook', 'com')) ；==> www.facebook.com

3） collect_set(col) : 函数只接受基本数据类型，它的主要作用是将某字段的值进行去重汇总，产生array类型字段
-- 示例：
SELECT COLLECT_set(deptno) from emp; ==>[20,30,10]


列转行
-- 语法：
lateral view explode (split(字段，分割符)) 表名 as 列名
-- 说明：
lateral view : 侧写；
explode(): 将指定的集合拆解分成多行 -- 炸裂
split(字段，分割符) : 将指定的字符串按照分割符封装成一个集合。

-- 示例：
SELECT movie,category_name 
FROM movie_info 
lateral VIEW
explode(split(category,",")) movie_info_tmp  AS category_name ; -- categor_name 为炸裂的列名，move_info_tmp为侧写的表名


开窗函数
相关函数说明：开窗函数是为每一条数据进行开窗
1） over() : 单独使用此函数，默认的窗口大小为结果集的大小。
2） partition by : 在窗口函数中进行分区
 	over(partition by 字段) ：对结果集内进行分区，每条数据的开窗大小为该结果集中分区集的大小。
3) over( order by 字段) ： 在窗口函数中只用到了order by 排序时，也会对每条数据进行开一个窗口，默认的开窗大小为：从结果集的开始位置到当前处理数据的位置。
-- 实例：
-- 1.查询在2017年4月份购买过的顾客及总人数
-- 解析，顾客全部要，多个顾客，多行，人数为一个值，一行，则是需要进行开窗，因为不是一一匹配的。
        SELECT  name ,
        COUNT(*)   OVER () `人数`
        from business 
        WHERE  SUBSTRING(orderdate,1,7)='2017-04' 
        group by name ;

-- 2.查询顾客的购买明细及月购买总额
    SELECT name ,orderdate ,cost ,
    sum (cost) over(partition by MONTH (orderdate))
    from business;
    
-- 3.上述的场景, 将每个顾客的cost按照日期进行累加
    SELECT name ,orderdate ,cost ,
    sum (cost) over(partition by name order by orderdate)
    from business;
    
4） CURRENT ROW：当前行
	n PRECEDING：往前n行数据
	n FOLLOWING：往后n行数据
5）UNBOUNDED：起点，
	UNBOUNDED PRECEDING 表示从前面的起点 
    UNBOUNDED FOLLOWING 表示到后面的终点
6）LAG(col,n,default_val)：往前第n行数据
7）LEAD(col,n, default_val)：往后第n行数据
8）NTILE(n)：把有序窗口的行分发到指定数据的组中，各个组有编号，编号从1开始，对于每一行，NTILE返回此行所属的组的编号。注意：n必须为int类型。
示例：
-- 需求：查询前20%时间的订单信息
select * from (
    select name,orderdate,cost, ntile(5) over(order by orderdate) sorted
    from business
) t
where sorted = 1;


ranK 
-- 函数说明
1) RANK() 排序相同时会重复，总数不会变; 
   -- 1 2 2 4 5 5 7
2) DENSE_RANK() 排序相同时会重复，总数会减少; 
  -- 1 2 2 3 3 4 4 5
3) ROW_NUMBER() 会根据顺序计算。
  -- 1 2 3 4 5 6 


自定函数的分类：
1） UDF（User-Defined-Function） -- 一进一出

2） UDAF（User-Defined Aggregation Function） -- 聚集函数，多进一出
	类似于：count/max/min
	
3） UDTF（User-Defined Table-Generating Functions） -- 一进多出
	如lateral view explode()
	
add jar /opt/module/hive/datas/myudf.jar;
create temporary function my_len as "com.lianzp.hive. MyStringLength";


总结几点：
1）不同存储格式的存储文件的大小对比总结：
ORC >  Parquet >  textFile
2）存储文件的查询速度测试：基本相差不大。

-- 在实际的项目开发当中，hive表的数据存储格式一般选择：orc或parquet；压缩方式一般选择snappy，lzo。



```

##### hbase

```

```

##### datax

```
speed速度:
writeMode:写入模式
同构数据 mysql-to-mysql
{
    "job": {
        "content": [
            {
                "reader": {
                    "name": "mysqlreader", 
                    "parameter": {
                        "connection": [
                            {
                                 "querySql": [
                                    "select * from t_sale_from;"
                                ],
                                "jdbcUrl": ["jdbc:mysql://10.10.80.64:3306/decent_cloud?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai"],
                            }
                        ], 
                        "password": "juan@#app2022", 
                        "username": "huyajuan",
                    }
                }, 
                "writer": {
                    "name": "mysqlwriter", 
                    "parameter": {
                        "column": ["*"], 
                        "connection": [
                            {
                                "jdbcUrl": "jdbc:mysql://10.10.80.64:3306/decent_cloud?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai", 
                                "table": ["t_sale_from_copy1"]
                            }
                        ], 
                        "password": "juan@#app2022", 
                        "preSql": [], 
                        "session": [], 
                        "username": "huyajuan", 
                        "writeMode": "replace"
                    }
                }
            }
        ], 
        "setting": {
            "speed": {
                "channel" : 5
            }
        }
    }
}

异构数据库 sqlserver-to-mysql
{
    "job": {
        "content": [
            {
                "reader": {
                    "name": "sqlserverreader", 
                    "parameter": {
                        "connection": [
                            {
                                 "querySql": [
                                    " select kczt, kdzt, sptm, zshm, giazs, wdmc, ckmc, gysbm, gys, ppmc, dlmc, jsmc, plmc, gckh, gskh, gg, spmc, splx, xlmc, jz, hz, jgf, xsgf, sxf, zsys, zsjd, zsqg, zssl, zszl, fsmc, fssl, fszl, js, sjcb, sccb, bzjg, bqjg, dw, case when khh='是' then 1 when khh='否' then 0 else NULL end  as khh , case when ykj='是' then 1 when ykj='否' then 0 else NULL end  as ykj , jp, gflx, pjsm, cfhh, bz, rkrq, rkdh, rkdm, gxrq, gxdh, pdzt, pddh, lsdh, lsrq, xsdj, sjzk, ml, mjj, lsje, jsdh, jsrq, jsje, khmc, ZSMC, CXM, EWM, EWMX, LBDM, ZSCB, FSCB, WXFY, BZCB, ZSGG, WXDM  from mxzh WHERE sptm IN ('XQ00219382', 'XQ00617433', 'XQ00632089', 'XQ00493328', 'XQ00576232');"
                                ],
                                "jdbcUrl": ["jdbc:sqlserver://10.2.1.202:1455;DatabaseName=dcdata"],
                            }
                        ], 
                        "password": "Dc*2014#05#13.", 
                        "username": "sa",
                    }
                }, 
                "writer": {
                    "name": "mysqlwriter", 
                    "parameter": {
                        "column": ["kczt", "kdzt", "sptm", "zshm", "giazs", "wdmc", "ckmc", "gysbm", "gys", "ppmc", "dlmc", "jsmc", "plmc", "gckh", "gskh", "gg", "spmc", "splx", "xlmc", "jz", "hz", "jgf", "xsgf", "sxf", "zsys", "zsjd", "zsqg", "zssl", "zszl", "fsmc", "fssl", "fszl", "js", "sjcb", "sccb", "bzjg", "bqjg", "dw", "khh", "ykj", "jp", "gflx", "pjsm", "cfhh", "bz", "rkrq", "rkdh", "rkdm", "gxrq", "gxdh", "pdzt", "pddh", "lsdh", "lsrq", "xsdj", "sjzk", "ml", "mjj", "lsje", "jsdh", "jsrq", "jsje", "khmc", "zsmc", "cxm", "ewm", "ewmx", "lbdm", "zscb", "fscb", "wxfy", "bzcb", "zsgg", "wxdm"], 
                        "connection": [
                            {
                                "jdbcUrl": "jdbc:mysql://10.2.12.46:3306/decent_cloud?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai", 
                                "table": ["t_ka_mxz"]
                            }
                        ], 
                        "password": "dba@2022app", 
                        "preSql": [], 
                        "session": [], 
                        "username": "dba", 
                        "writeMode": "replace"
                    }
                }
            }
        ], 
        "setting": {
            "speed": {
                "channel" : 5
            }
        }
    }
}



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

所有空表
select TABLE_NAME from information_schema.TABLES where TABLE_SCHEMA ='数据库名称' and TABLE_ROWS = 0;

所有非空表
select TABLE_NAME from information_schema.TABLES where TABLE_SCHEMA ='数据库名称' and TABLE_ROWS >0;

查询当前数据库包含某字段的所有表

SELECT DISTINCT TABLE_NAME FROM information_schema.COLUMNS WHERE COLUMN_NAME = '字段名称' AND TABLE_SCHEMA='数据库名称';
		   
```

##### sqlserver

```
eos一些语法
基本的用法
sql的存储过程
支持跨库查询
一些基本语法的差异
```

##### **SeaTunnel** 

```
Apache SeaTunnel 是一个分布式、高性能、易扩展、用于海量数据（离线&实时）同步和转化的数据集成平台
链接： https://seatunnel.readthedocs.io/zh_CN/latest/quickstart/
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

##### Dinky 

```
实时即未来，Dinky 为 Apache Flink 而生，让 Flink SQL 纵享丝滑。
Dinky 是一个开箱即用、易扩展，以 Apache Flink 为基础，连接 OLAP 和数据湖等众多框架的一站式实时计算平台，致力于流批一体和湖仓一体的探索与实践。
最后，Dinky 的发展皆归功于 Apache Flink 等其他优秀的开源项目的指导与成果。
```

##### paimon

```
incubating 孵化中
upgrade 升级
imperative 必要的

Apache Paimon是一个流数据湖平台，是Streaming 实时计算能力和 Lakehouse 新架构优势的结合，具有高速数据摄取、变更日志跟踪和高效的实时分析能力。
它最早是由 Flink社区内部孵化而来，原名 Flink Table Store（简称FTS），是Flink的子项目。
2023年3月12日捐赠给Apache软件基金会后改名 Apache Paimon。


```



##### 立住Flag

```
 flag要具体且具象化

        我要找个好工作！我要赚大钱！
        这不是目标，这是口号。
        没有标准就不具备实现的可能。

        一个人挣不到大钱，
        因为他没想明白多少钱算大钱。
        在具体的时间给出一个具体的目标！
        比如，你来学习，
        半年以后找一个月薪一万五的工作。

        具体之后再具象化。
        我拿到第一个月的工资，
        我要给我爸买什么，给我妈买什么，
        犒劳一下自己买点什么……
        想一想就有画面感的目标，
        会给你更大的动力。

        如果你的目标是：两年内换车。
        换什么牌子？什么型号？
        要什么配置？什么颜色？
        买个模型摆桌子上，
        手机壁纸换成这辆车你喜欢的颜色。

        工作摸鱼的时候瞄到车模，
        不摸了，有空多学点技术，
        摸鱼的最高境界是：摸鱼学习。
        晚上掏出手机想打打游戏，
        一看壁纸，不成，我得干点正事，
        我要努力，买我的dream car！
        你看，这动力不就来了吗？
        
公之于众，反向施压

        让你的flag增加点仪式感，
        大点字写在纸上，贴在床头。
        每天早上起床看一眼，
        昨天你足够努力了吗？

        没有，惩罚自己，
        男的趴地下做五十个俯卧撑，
        女的做五十个仰卧起坐，
        让自己长长记性。
        你不对自己狠一点，
        你的flag永远立不起来。

        flag发到你的死党群或闺蜜群，
        让你的狐朋狗友或小姐妹监督你。
        把你今年要干成什么事晒到微博，
        晒到朋友圈，公之于众，
        接受群众雪亮的眼睛的监督，
        通过仪式感对自己反向施压。

        你为什么立了那么多flag没实现？
        因为你就是自己在心里想想，
        知难而退了，半途而废了……
        再换一个flag！
        你只是在喊口号，感动自己。

        晒出你的flag，让时间来见证：
        你是个牛人，还是个吹牛的人。
        
立个稍微高一丢丢的flag 

        取其上者得其中，
        取其中者得其下，
        取其下者则狗屁都无所得。

        flag要是跳一跳脚可以实现的，
        而不是你唾手可得或遥不可及的。

        大目标指引方向，
        小目标建立自信。
        什么五年计划、十年计划可以有，
        但一定要分解成阶段性的小目标。
        一个个小目标的实现给你成就感，
        而成就感的累积会变成你的自信。

        不要动不动搞一个时间周期特别长，
        坚持好几个月都看不到效果的目标，
        一旦受阻，你会很容易放弃。

付出相匹配的努力 
        两位同学来学习。
        小帅目标月薪一万，
        晚上十一点多睡了，
        我觉得，还算合理；
        小美目标月薪一万五，
        晚上十一点多也歇了，
        我觉得，这就有点不科学了。

        两个人各方面条件差不多，
        你比人家的目标高了五千，
        却没付出更多的努力，
        雷声大雨点小，全靠想得美啊？

        用结果感动自己，
        而不是用口号感动自己。
        想要结果你就得在过程中付出，
        这是立flag最为重要的一点，
        要让你的努力匹配上你的目标。

        这个世界上有很多朴素的道理，
        其中有一条是：付出与收获成正比。

        这个十一长假，
        或是到年底之前，又或是明年……
        你有什么flag？
        用这四招试试看，你能不能立得住？

```


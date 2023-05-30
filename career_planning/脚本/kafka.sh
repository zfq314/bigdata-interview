# 架构
生产者、Broker、消费者、Zookeeper。

# 创建topic 
# 创建一个3分区1副本名为test的topic，必须指定分区数 --partitions 和副本数--replication-factor，其中副本数量不能超过kafka节点（broker）数量
./kafka-topics.sh --zookeeper localhost:2181  --topic test --partitions 3 --replication-factor 1 --create


# 删除名为test的topic
# 删除topic时只有在kafka安装目录config目录下的server.properties中将delete.topic.enable 设置为true topic才会真实删除，否则只是标记为删除，实则不会删除
./kafka-topics.sh --zookeeper localhost:2181  --topic test  --delete


# 查看名为test的topic的详细信息，分区 副本的数量
./kafka-topics.sh --zookeeper localhost:2181  --topic test --describe


# 查看kafka中创建了那些topic
./kafka-topics.sh  --zookeeper localhost:2181 --list


# 将名为test的topic 修改为4个分区
# 注意 分区数只能增加不能减少
./kafka-topics.sh --zookeeper localhost:2181 -alter --partitions 4 --topic test


# 使用命令行 给名为 test 的topic 中生产数据
# 执行以下命令，然后在命令行中写入要发送kafka的数据回车即可发送数据到kafka
./kafka-console-producer.sh --broker-list localhost:9092 --topic test

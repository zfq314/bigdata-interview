```
Apache Paimon (incubating) 是一项流式数据湖存储技术,可以为用户提供高吞吐、低延迟的数据摄入、流式订阅以及实时查询能力。

Paimon CDC 是整合了 Flink CDC、Kafka、Paimon 的入湖工具，帮助你更好更方便的完成一键入湖。


你可以通过 Flink SQL 或者 Flink DataStream API 将 Flink CDC 数据写入 Paimon 中，也可以通过Paimon 提供的 CDC 工具来完成入湖。那这两种方式有什么区别呢？

Flink SQL 来完成入湖，简单，但是当源表添加新列后，同步作业不会同步新的列，下游 Paimon 表也不会增加新列。

Paimon CDC 工具来同步数据，可以看到，当源表发生列的新增后，流作业会自动新增列的同步，并传导到下游的 Paimon 表中，完成 Schema Evolution 的同步。
另外 Paimon CDC 工具也提供了整库同步：


整库同步可以帮助你：
一个作业同步多张表，以低成本的方式同步大量小表
作业里同时自动进行 Schema Evolution
新表将会被自动进行同步，你不用重启作业，全自动完成



通过 Paimon CDC 的入湖程序可以让你全自动的同步业务数据库到 Paimon 里，数据、Schema Evolution、新增表，全部被自动完成，你只用管好这一个 Flink 作业即可。这套入湖程序已经被部署到各行各业，各个公司里，给业务数据带来非常方便的镜像到湖存储里面的能力。

更有其它数据源等你来体验：Mysql、Kafka、MongoDB、Pulsar、PostgresSQL。

Paimon 的长期使命包括：
极致易用性、高性能的数据入湖，方便的湖存储管理，丰富生态的查询。
方便的数据流读，与 Flink 生态的良好集成，给业务带来1分钟新鲜度的数据。
加强的 Append 数据处理，时间旅行、数据排序带来高效的查询，升级 Hive 数仓。
```


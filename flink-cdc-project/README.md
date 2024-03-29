Flink CDC 是一个基于流的数据集成工具，旨在为用户提供一套功能更加全面的编程接口（API）。 
该工具使得用户能够以 YAML 配置文件的形式，优雅地定义其 ETL（Extract, Transform, Load）流程，并协助用户自动化生成定制化的 Flink 算子并且提交 Flink 作业。
Flink CDC 在任务提交过程中进行了优化，并且增加了一些高级特性，
如表结构变更自动同步（Schema Evolution）、数据转换（Data Transformation）、整库同步（Full Database Synchronization）以及 精确一次（Exactly-once）语义


Flink CDC 深度集成并由 Apache Flink 驱动，提供以下核心功能：

✅ 端到端的数据集成框架
✅ 为数据集成的用户提供了易于构建作业的 API
✅ 支持在 Source 和 Sink 中处理多个表
✅ 整库同步
✅具备表结构变更自动同步的能力（Schema Evolution），


Flink CDC 提供了基于 YAML 格式的用户 API，更适合于数据集成场景。以下是一个 YAML 文件的示例，它定义了一个数据管道(Pipeline)，该Pipeline从 MySQL 捕获实时变更，并将它们同步到 Apache Doris：

source:
    type: mysql
    hostname: localhost
    port: 3306
    username: root
    password: 123456
    tables: app_db.\.*
    server-id: 5400-5404
    server-time-zone: UTC

sink:
    type: doris
    fenodes: 127.0.0.1:8030
    username: root
    password: ""
    table.create.properties.light_schema_change: true
    table.create.properties.replication_num: 1

pipeline:
    name: Sync MySQL Database to Doris
    parallelism: 2



通过使用 flink-cdc.sh 提交 YAML 文件，一个 Flink 作业将会被编译并部署到指定的 Flink 集群



下载 Flink 1.18.0，解压后得到 flink-1.18.0 目录。 使用下面的命令跳转至 Flink 目录下，并且设置 FLINK_HOME 为 flink-1.18.0 所在目录。

cd flink-1.18.0
通过在 conf/flink-conf.yaml 配置文件追加下列参数开启 checkpoint，每隔 3 秒做一次 checkpoint。

execution.checkpointing.interval: 3000
使用下面的命令启动 Flink 集群。

./bin/start-cluster.sh


3.编写任务配置 yaml 文件 下面给出了一个整库同步的示例文件 mysql-to-doris.yaml：

################################################################################
# Description: Sync MySQL all tables to Doris
################################################################################
source:
type: mysql
hostname: localhost
port: 3306
username: root
password: 123456
tables: app_db.\.*
server-id: 5400-5404
server-time-zone: UTC

sink:
type: doris
fenodes: 127.0.0.1:8030
username: root
password: ""
table.create.properties.light_schema_change: true
table.create.properties.replication_num: 1

pipeline:
name: Sync MySQL Database to Doris
parallelism: 2






Route the changes #
Flink CDC 提供了将源表的表结构/数据路由到其他表名的配置，借助这种能力，我们能够实现表名库名替换，整库同步等功能。 下面提供一个配置文件说明：

################################################################################
# Description: Sync MySQL all tables to Doris
################################################################################
source:
    type: mysql
    hostname: localhost
    port: 3306
    username: root
    password: 123456
    tables: app_db.\.*
    server-id: 5400-5404
    server-time-zone: UTC

sink:
    type: doris
    fenodes: 127.0.0.1:8030
    benodes: 127.0.0.1:8040
    username: root
    password: ""
    table.create.properties.light_schema_change: true
    table.create.properties.replication_num: 1

route:
    - source-table: app_db.orders
      sink-table: ods_db.ods_orders
    - source-table: app_db.shipments
      sink-table: ods_db.ods_shipments
    - source-table: app_db.products
      sink-table: ods_db.ods_products

pipeline:
    name: Sync MySQL Database to Doris
    parallelism: 2
通过上面的 route 配置，会将 app_db.orders 表的结构和数据同步到 ods_db.ods_orders 中。从而实现数据库迁移的功能。 特别地，source-table 支持正则表达式匹配多表，从而实现分库分表同步的功能，例如下面的配置：

route:
- source-table: app_db.order\.*
  sink-table: ods_db.ods_orders
  这样，就可以将诸如 app_db.order01、app_db.order02、app_db.order03 的表汇总到 ods_db.ods_orders 中。
  注意，目前还不支持多表中存在相同主键数据的场景，将在后续版本支持。








下面给出了一个整库同步的示例文件 mysql-to-starrocks.yaml：

################################################################################
# Description: Sync MySQL all tables to StarRocks
################################################################################
source:
    type: mysql
    hostname: localhost
    port: 3306
    username: root
    password: 123456
    tables: app_db.\.*
    server-id: 5400-5404
    server-time-zone: UTC

sink:
    type: starrocks
    name: StarRocks Sink
    jdbc-url: jdbc:mysql://127.0.0.1:9030
    load-url: 127.0.0.1:8030
    username: root
    password: ""
    table.create.properties.replication_num: 1

pipeline:
    name: Sync MySQL Database to StarRocks
    parallelism: 2
其中：

source 中的 tables: app_db.\.* 通过正则匹配同步 app_db 下的所有表。
sink 添加 table.create.properties.replication_num 参数是由于 Docker 镜像中只有一个 StarRocks BE 节点。




################################################################################
# Description: Sync MySQL all tables to StarRocks
################################################################################
source:
    type: mysql
    hostname: localhost
    port: 3306
    username: root
    password: 123456
    tables: app_db.\.*
    server-id: 5400-5404
    server-time-zone: UTC

sink:
    type: starrocks
    name: StarRocks Sink
    jdbc-url: jdbc:mysql://127.0.0.1:9030
    load-url: 127.0.0.1:8030
    username: root
    password: ""
    table.create.properties.replication_num: 1

route:
    - source-table: app_db.orders
      sink-table: ods_db.ods_orders
    - source-table: app_db.shipments
      sink-table: ods_db.ods_shipments
    - source-table: app_db.products
      sink-table: ods_db.ods_products

pipeline:
    name: Sync MySQL Database to StarRocks
    parallelism: 2
通过上面的 route 配置，会将 app_db.orders 表的结构和数据同步到 ods_db.ods_orders 中。从而实现数据库迁移的功能。
特别地，source-table 支持正则表达式匹配多表，从而实现分库分表同步的功能，例如下面的配置：

route:
- source-table: app_db.order\.*
sink-table: ods_db.ods_orders
这样，就可以将诸如 app_db.order01、app_db.order02、app_db.order03 的表汇总到 ods_db.ods_orders 中。 
  注意，目前还不支持多表中存在相同主键数据的场景，将在后续版本支持。
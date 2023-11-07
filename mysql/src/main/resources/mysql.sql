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




索引优化级别

由好到差
system > const > eq_ref > ref > fulltext > ref_or_null > index_merge > unique_subquery > index_subquery > range > index > ALL all:全表扫描

一般来说，得保证查询至少达到range级别，最好能达到ref，type出现index和all时，表示走的是全表扫描没有走索引，效率低下，这时需要对sql进行调优
bill_date是索引字段，如果是approve_time是没什么效果的


开启慢日志查询，然后找出有问题的sql或者存储过程

函数导致索引失效（date）
explain select * from t_sale_from where bill_date BETWEEN '2023-10-1 00:00:00' and '2023-10-18 23:59:59'

explain select * from t_sale_from where  DATE(bill_date) >='2023-10-1' and DATE(bill_date)<= '2023-10-18'

数据准备：
        CREATE TABLE staffs (
                                id INT PRIMARY KEY AUTO_INCREMENT,
                                name VARCHAR (24)  NULL DEFAULT '' COMMENT '姓名',
                                age INT NOT NULL DEFAULT 0 COMMENT '年龄',
                                pos VARCHAR (20) NOT NULL DEFAULT '' COMMENT '职位',
                                add_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入职时间'
        ) CHARSET utf8 COMMENT '员工记录表' ;


        INSERT INTO staffs(name,age,pos,add_time) VALUES('zhangsan',18,'manager',NOW());
        INSERT INTO staffs(name,age,pos,add_time) VALUES('lisi',19,'dev',NOW());
        INSERT INTO staffs(name,age,pos,add_time) VALUES('wangwu',20,'dev',NOW());

        SELECT * FROM staffs;

        ALTER TABLE staffs ADD INDEX idx_staffs_nameAgePos(name, age, pos); -- 添加索引



1全值匹配 (索引idx_staffs_nameAgePos 建立索引时以 name，age，pos 的顺序建立的。全值匹配表示 按顺序匹配的
    EXPLAIN SELECT * FROM staffs WHERE name = 'July';
    EXPLAIN SELECT * FROM staffs WHERE name = 'July' AND age = 25;
    EXPLAIN SELECT * FROM staffs WHERE age = 25 AND name = 'July' AND pos = 'dev';

    --索引失效
    EXPLAIN SELECT * FROM staffs WHERE age = 25;
    EXPLAIN SELECT add_time FROM staffs WHERE age = 25 AND pos = 'dev';


 2最左前缀法则(如果索引了多列，要遵守最左前缀法则。指的是查询从索引的最左前列开始并且不跳过索引中的列。)
                                          -- 【注意】
    -- and 忽略左右关系。既即使没有没有按顺序 由于优化器的存在，会自动优化。
    -- 除开上述条件 才满足最左前缀法则。
    EXPLAIN SELECT * FROM staffs WHERE age = 25 AND pos = 'dev'; -- 索引失效
    EXPLAIN SELECT * FROM staffs WHERE pos = 'dev';-- 索引失效

 3不在索引列上做任何操作（计算、函数、(自动or手动)类型转换），如果做的话，会导致索引失效而转向全表扫描
    EXPLAIN SELECT * FROM staffs WHERE left(NAME,4) = 'July';

4存储引擎不能使用索引中范围条件(bettween、<、>、in等)右边的列(范围条件右边与范围条件使用的同一个组合索引，右边的才会失效。若是不同索引则不会失效)。
    索引正常：EXPLAIN SELECT * FROM staffs WHERE  name = 'July' AND age = 25 AND pos = 'dev';
    索引失效：EXPLAIN SELECT * FROM staffs WHERE  name = 'July' AND age > 25 AND pos = 'dev'; -- 索引失效 age开始索引失效

 5减少select *，使用哪些字段查哪些字段。
 6mysql5.7 在使用不等于(!= 或者<>)的时候无法使用索引会导致全表扫描。但8.0不会。


    EXPLAIN SELECT * FROM staffs WHERE  name = 'July';
    EXPLAIN SELECT * FROM staffs WHERE  name <> 'July';
    EXPLAIN SELECT * FROM staffs WHERE  name != 'July';



7mysql5.7 is not null 也无法使用索引，但是is null是可以使用索引的。但8.0不会

    EXPLAIN SELECT * FROM staffs WHERE  NAME IS NOT NULL; -- 索引失效
    EXPLAIN SELECT * FROM staffs WHERE  NAME IS NULL;

8like以%开头(’%abc…’)mysql索引失效会变成全表扫描的操作

    EXPLAIN SELECT * FROM staffs WHERE  NAME LIKE '%J'; -- ALL(索引失效)
    EXPLAIN SELECT * FROM staffs WHERE  NAME LIKE 'J%'; -- range

9字符串不加单引号索引失效 ( 底层进行转换使索引失效，使用了函数造成索引失效)（隐式类型转换）

    EXPLAIN SELECT * FROM staffs WHERE  NAME = 987




存储引擎介绍


InnoDB存储引擎
特点：

InnoDB存储引擎提供了具有提交、回滚和崩溃恢复能力的事务安全。相比较MyISAM存储引擎，InnoDB写的处理效率差一点并且会占用更多的磁盘空间保留数据和索引。
提供了对数据库事务ACID（原子性Atomicity、一致性Consistency、隔离性Isolation、持久性Durability）的支持，实现了SQL标准的四种隔离级别。
设计目标就是处理大容量的数据库系统，MySQL运行时InnoDB会在内存中建立缓冲池，用于缓冲数据和索引。
执行“select count(*) from table”语句时需要扫描全表，因为使用innodb引擎的表不会保存表的具体行数，所以需要扫描整个表才能计算多少行。
InnoDB引擎是行锁，粒度更小，所以写操作不会锁定全表，在并发较高时，使用InnoDB会提升效率。即存在大量UPDATE/INSERT操作时，效率较高。

使用场景：
经常UPDETE/INSERT的表，使用处理多并发的写请求
支持事务，只能选出InnoDB。
可以从灾难中恢复（日志+事务回滚）
外键约束、列属性AUTO_INCREMENT支持


MyISAM存储引擎
特点：

MyISAM不支持事务，不支持外键，SELECT/INSERT为主的应用可以使用该引擎。
每个MyISAM在存储成3个文件，扩展名分别是：
1) frm：存储表定义（表结构等信息）
2) MYD(MYData)，存储数据
3) MYI(MYIndex)，存储索引
不同MyISAM表的索引文件和数据文件可以放置到不同的路径下。
MyISAM类型的表提供修复的工具，可以用CHECK TABLE语句来检查MyISAM表健康，并用REPAIR TABLE语句修复一个损坏的MyISAM表。
在MySQL5.6以前，只有MyISAM支持Full-text全文索引

使用场景：
经常SELECT的表，插入不频繁，查询非常频繁。
不支持事务。
做很多count 的计算


MyISAM和Innodb区别
InnoDB和MyISAM是许多人在使用MySQL时最常用的两个存储引擎，这两个存储引擎各有优劣，视具体应用而定。基本的差别为：MyISAM类型不支持事务处理，而InnoDB类型支持。
MyISAM类型强调的是性能，其执行速度比InnoDB类型更快，而InnoDB提供事务支持已经外部键等高级数据库功能。


具体实现的差别：

MyISAM是非事务安全型的，而InnoDB是事务安全型的。
MyISAM锁的粒度是表级，而InnoDB支持行级锁定。
MyISAM不支持外键，而InnoDB支持外键
MyISAM相对简单，所以在效率上要优于InnoDB，小型应用可以考虑使用MyISAM。
InnoDB表比MyISAM表更安全。


存储优化
禁用索引
对于使用索引的表，插入记录时，MySQL会对插入的记录建立索引。如果插入大量数据，建立索引会降低插入数据速度。为了解决这个问题，可以在批量插入数据之前禁用索引，数据插入完成后再开启索引
禁用索引的语句：
ALTER TABLE table_name DISABLE KEYS
开启索引语句：
ALTER TABLE table_name ENABLE KEYS

MyISAM对于空表批量插入数据，则不需要进行操作，因为MyISAM引擎的表是在导入数据后才建立索引。

禁用唯一性检查
    唯一性校验会降低插入记录的速度，可以在插入记录之前禁用唯一性检查，插入数据完成后再开启。(保证插入的数据没有重复的)
    禁用唯一性检查的语句：SET UNIQUE_CHECKS = 0;
    开启唯一性检查的语句：SET UNIQUE_CHECKS = 1;


禁用外键检查
插入数据之前执行禁止对外键的检查，数据插入完成后再恢复，可以提供插入速度。

禁用：SET foreign_key_checks = 0;
开启：SET foreign_key_checks = 1;


 禁止自动提交
插入数据之前执行禁止事务的自动提交，数据插入完成后再恢复，可以提高插入速度。

禁用：SET autocommit = 0;
开启：SET autocommit = 1;


表结构优化

表拆分，水平拆分垂直拆分
读写分离
数据库集群
硬件优化

内存
足够大的内存，是提高MySQL数据库性能的方法之一。内存的IO比硬盘快的多，可以增加系统的缓冲区容量，使数据在内存停留的时间更长，以减少磁盘的IO。服务器内存建议不要小于2GB，推荐使用4GB以上的物理内存。

磁盘
MySQL每秒钟都在进行大量、复杂的查询操作，对磁盘的读写量可想而知。所以，通常认为磁盘I/O是制约MySQL性能的最大因素之一，对于日均访问量在100万PV以上的系统，由于磁盘I/O的制约，MySQL的性能会非常低下 考虑以下几种解决方案：
使用SSD或者PCIe SSD设备，至少获得数百倍甚至万倍的IOPS提升；
购置阵列卡，可明显提升IOPS
尽可能选用RAID-10，而非RAID-5
使用机械盘的话，尽可能选择高转速的，例如选用15000RPM，而不是7200RPM的盘

 CPU
CPU仅仅只能决定运算速度，即使是运算速度都还取决于与内存之间的总线带宽以及内存本身的速度。但是一般情况下，我们都需要选择计算速度较快的CPU。
关闭节能模式。操作系统和CPU硬件配合，系统不繁忙的时候，为了节约电能和降低温度，它会将CPU降频。这对环保人士和抵制地球变暖来说是一个福音，但是对MySQL来说，可能是一个灾难。为了保证MySQL能够充分利用CPU的资源，建议设置CPU为最大性能模式。

网络
应该尽可能选择网络延时低，吞吐量高的设备。

网络延时：不同的网络设备其延时会有差异，延时自然是越小越好。
吞吐量：对于数据库集群来说，各个节点之间的网络吞吐量可能直接决定集群的处理能力。

查询缓存，全局缓存


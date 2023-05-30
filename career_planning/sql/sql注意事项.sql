1、 -- mysql 存储过程 如果条件成立就执行条件查询,如果条件不成立的话，就查询所有

a.customer_identity = v_customer_identity or ifnull(v_customer_identity, '') = ''


2、-- mysql 存储过程 开启事务 关闭事务
	/*声明一个变量，标识是否有SQL异常*/
	DECLARE hasSqlError INT DEFAULT FALSE;
	DECLARE ERR_CODE VARCHAR(20);
	DECLARE ERR_MSG TEXT;

	/*在执行过程中出任何异常设置hasSqlError为TRUE*/
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
	   BEGIN
	    GET CURRENT DIAGNOSTICS CONDITION 1
	    ERR_CODE = MYSQL_ERRNO, ERR_MSG = MESSAGE_TEXT;
	    SET hasSqlError = TRUE;
	   END;	

	-- 开始事务
	START TRANSACTION;

	-- 异常判断
	IF not hasSqlError THEN
	COMMIT;  /*提交事务*/
	SELECT '执行成功!' AS MSG_INFO;
	INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, '执行成功');
	UPDATE t_stored_procedure_status set execute_status = 0 WHERE stored_procedure_name = 'gn_zt_kcrzzjz'; -- 更新库存结转存储过程执行状态

	ELSE
	  ROLLBACK;   /*回滚事务*/
	  SELECT '执行失败！' AS MSG_INFO;
	  SELECT CONCAT('gn_zt_kcrzzjz', ERR_CODE,' ',ERR_MSG) AS MSG_INFO;
	  INSERT INTO T_STORED_PROCEDURE_LOG(EXECUTE_ID, STORED_PROCEDURE_NAME, CREATE_USER, LOG) VALUES (v_uuid, 'gn_zt_kcrzzjz', v_user_name, CONCAT('执行失败，',ERR_CODE,' ',ERR_MSG));
	END IF;

3、-- 当相应的 x>0时候 拼接 否则不拼接  特殊需求处理
CASE WHEN TEMP_B13.JZ = 0 THEN '' ELSE CONCAT(', 付外协:' , TEMP_B13.JZ , 'K',CASE WHEN TEMP_B13_FJL.JZ=0 THEN '' ELSE CONCAT('(其中付旧料',TEMP_B13_FJL.JZ,'K',')') END ) END -- 付外协-旧料 '(其中付旧料',TEMP_B13_FJL.JZ,'K',')'

4、--  行列转换统计用case when 居多

select 
			SUBSTRING_INDEX(qymc,'-',1)  as newPqmc,
			qymc  as pqmc,
			khmc,
			zkh,
			sum(lm) as lm,
			sum(lmq) as lmq,
			sum(zj) as zj,
			sum(zjq) as zjq,
			sum(bq) as bq,
			sum(bqq) as bqq,
			sum(lfx) as lfx,
			sum(lfxq) as lfxq,
			sum(hcl) as hcl,
			sum(hclq) as hclq,
			sum(yt) as yt,
			sum(ytq) as ytq,
			sum(zr) as zr,
			sum(zrq) as zrq,
			sum(zds) as zds,
			sum(zdsq) as zdsq,
			sum(nbzx) as nbzx,
			sum(nbzxq) as nbzxq,
			sum(gzgr) as gzgr,
			sum(gzgrq) as gzgrq,
			sum(lm)+sum(zj)+sum(bq)+sum(lfx)+sum(hcl)+sum(yt)+sum(zr)+sum(zds)+sum(nbzx)+sum(gzgr) as hj,
			sum(lmq)+sum(zjq)+sum(bqq)+sum(lfxq)+sum(hclq)+sum(ytq)+sum(zrq)+sum(zdsq)+sum(nbzxq)+sum(gzgrq) as hjq
from 
	(
	select 
			qymc,
			khmc,
			zkh,
			case when (CONCAT(khmc,'-',zkh) like '%老庙%' or CONCAT(khmc,'-',zkh) like '%亚一%' ) then jz else 0 end lm,-- 老庙
			case when (CONCAT(khmc,'-',zkh) like '%老庙%' or CONCAT(khmc,'-',zkh) like '%亚一%' ) then je else 0 end lmq,-- 老庙
			case when (CONCAT(khmc,'-',zkh) like  '%中金%' or khmc like'%内蒙古卓然%') then jz else 0 end zj,-- 中金
			case when (CONCAT(khmc,'-',zkh) like  '%中金%' or khmc like'%内蒙古卓然%') then je else 0 end zjq,-- 中金
			case when CONCAT(khmc,'-',zkh) like '%宝庆%' then jz else 0 end bq, -- 宝庆
			case when CONCAT(khmc,'-',zkh) like '%宝庆%' then je else 0 end bqq, -- 宝庆
			case when CONCAT(khmc,'-',zkh) like '%老凤祥%' then jz else 0 end lfx, -- 老凤祥
			case when CONCAT(khmc,'-',zkh) like '%老凤祥%' then je else 0 end lfxq, -- 老凤祥
			case when CONCAT(khmc,'-',zkh) like '%荟萃楼%' then jz else 0 end hcl, -- 荟萃楼
			case when CONCAT(khmc,'-',zkh) like '%荟萃楼%' then je else 0 end hclq, -- 荟萃楼
			case when CONCAT(khmc,'-',zkh) like '%宇泰%' then jz else 0 end yt, -- 宇泰
			case when CONCAT(khmc,'-',zkh) like '%宇泰%' then je else 0 end ytq, -- 宇泰
			case when CONCAT(khmc,'-',zkh) like '%卓尔%' then jz else 0 end zr, -- 卓尔
			case when CONCAT(khmc,'-',zkh) like '%卓尔%' then je else 0 end zrq, -- 卓尔
			case when CONCAT(khmc,'-',zkh) like '%周大生%' then jz else 0 end zds, -- 宇泰
			case when CONCAT(khmc,'-',zkh) like '%周大生%' then je else 0 end zdsq, -- 宇泰
			case when CONCAT(khmc,'-',zkh) like '%内部展销%' then jz else 0 end nbzx, -- 内部展销
			case when CONCAT(khmc,'-',zkh) like '%内部展销%' then je else 0 end nbzxq, -- 内部展销钱
			case when CONCAT(khmc,'-',zkh) not like '%老庙%' and CONCAT(khmc,'-',zkh) not like '%亚一%' and CONCAT(khmc,'-',zkh) not like '%中金%' and CONCAT(khmc,'-',zkh) not like '%内蒙古卓然%'  and CONCAT(khmc,'-',zkh) not like '%宝庆%' and CONCAT(khmc,'-',zkh) not like '%老凤祥%' and CONCAT(khmc,'-',zkh) not like '%荟萃楼%' and CONCAT(khmc,'-',zkh) not like '%宇泰%' and CONCAT(khmc,'-',zkh) not like '%卓尔%' and CONCAT(khmc,'-',zkh) not like '%周大生%' and CONCAT(khmc,'-',zkh) not like '%内部展销%' then jz else 0 end gzgr,
			case when CONCAT(khmc,'-',zkh) not like '%老庙%' and CONCAT(khmc,'-',zkh) not like '%亚一%' and CONCAT(khmc,'-',zkh) not like '%中金%' and CONCAT(khmc,'-',zkh) not like '%内蒙古卓然%'  and CONCAT(khmc,'-',zkh) not like '%宝庆%' and CONCAT(khmc,'-',zkh) not like '%老凤祥%' and CONCAT(khmc,'-',zkh) not like '%荟萃楼%' and CONCAT(khmc,'-',zkh) not like '%宇泰%' and CONCAT(khmc,'-',zkh) not like '%卓尔%' and CONCAT(khmc,'-',zkh) not like '%周大生%' and CONCAT(khmc,'-',zkh) not like '%内部展销%' then je else 0 end gzgrq
			from result_data
	)t
	group by qymc,khmc,zkh HAVING sum(lm)+sum(zj)+sum(bq)+sum(lfx)+sum(hcl)+sum(yt)+sum(zr)+sum(zds)+sum(nbzx)+sum(gzgr)<>0  or sum(lmq)+sum(zjq)+sum(bqq)+sum(lfxq)+sum(hclq)+sum(ytq)+sum(zrq)+sum(zdsq)+sum(nbzxq)+sum(gzgrq)<>0  ;


5、 -- msyql 中文排序 特殊处理  

ORDER BY CONVERT(pqmc USING gbk);	

6、 -- MySQL 8.0 支持窗口函数 

	row number 

7、-- mysql一列多值改成多行,借助msyql的系统函数 ，借助 help_topic系统函数

select t.*,
substring_index(substring_index(technology_purity_identity,',',b.help_topic_id+1),',',-1) as purity_jq from (
select 
			a.*, -- 1,2,3 technology_purity_identity 值
			b.showroom_name 
	from t_fast_customer a left join t_showroom b on a.showroom_identity=b.showroom_identity
	where a.customer_code='KH003975' and b.showroom_identity='ba4ead54-decc-11ea-9cfd-aecc6b4ae066'
)t
join
  mysql.help_topic b
  on b.help_topic_id < (length(t.technology_purity_identity) - length(replace(t.technology_purity_identity,',',''))+1) 


8、 group_concat 的使用

SELECT 
    GROUP_CONCAT(DISTINCT v
        ORDER BY v ASC
        SEPARATOR ';')
FROM
    t;
--去重 DISTINCT子句用于在连接分组之前消除组中的重复值。
--排序 ORDER BY子句允许您在连接之前按升序或降序排序值。 默认情况下，它按升序排序值。 如果要按降序对值进行排序，则需要明确指定DESC选项。
--分隔符 SEPARATOR指定在组中的值之间插入的文字值。如果不指定分隔符，则GROUP_CONCAT函数使用逗号(，)作为默认分隔符。
--空值处理 GROUP_CONCAT函数忽略NULL值，如果找不到匹配的行，或者所有参数都为NULL值，则返回NULL。
--长度报错处理，需要修改服务器相关参数,然后重启服务 GROUP_CONCAT函数返回二进制或非二进制字符串，这取决于参数。 默认情况下，返回字符串的最大长度为1024。如果您需要更多的长度，可以通过在SESSION或GLOBAL级别设置group_concat_max_len系统变量来扩展最大长度。



8、-- mysql脚本 用  dolphinscheduler 调度工具调度
	#!/bin/bash

	HOSTNAME="10.2.12.46" #数据库信息

	PORT="3306"

	USERNAME="dba"

	PASSWORD="dba@2022app"

	DBNAME="decent_cloud"

	#TABLENAME="t_eos_szlxjsrqh"

	mysql="/data/program/mysql-8.0.22/bin/mysql"

	wdmc='439228e3-1bfe-11eb-952f-beb5915aa4c3'

	do_date=`date -d "-1 day" +%F`

	echo "Begin execute GenSzztxsrb()"

	execSql="call GenSzztxsrb('$do_date','$wdmc')"

	echo $execSql

	$mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -D${DBNAME} -e "${execSql}"

9、 -- 读取mysqlbinlog 文件 统计 

./mysqlbinlog --no-defaults --base64-output=decode-rows -v -v binlog.000109 binlog.000109 binlog.000109 | awk '/###/ {if($0~/UPDATE|INSERT|SELECT/)count[$2" "$NF]++}END{for(i in count) print i,"\t",count[i]}' | column -t | sort -k3nr


10、 -- ddl
	-- 数据库模式定义语言DDL(Data Definition Language)，是用于描述数据库中要存储的现实世界实体的语言。

11、-- dml
	-- 数据操纵语言（Data Manipulation Language,DML）是用于数据库操作，对数据库其中的对象和数据运行访问工作的编程语句，通常是数据库专用编程语言之中的一个子集，例如在信息软件产业通行标准的SQL语言中，以INSERT、UPDATE、DELETE三种指令为核心，分别代表插入(意指新增或创建)、更新(修改)与删除(销毁)。


12、-- MySQL Binlog
	-- binlog应用场景
	-- 在 Master 端开启 Binlog， Master 把它的二进制日志传递给 Slaves，来达到 Master-Slave 数据一致的目的。
	-- 读写分离：Mysql主从之间通过binlog复制来进行横向扩展，从而实现读写分离
	-- 数据恢复：使用MySQL binlog工具来恢复数据

	-- 二进制日志包括两类文件
	-- 二进制日志索引文件：文件名后缀为.index，用来记录当前使用的 binlog 文件
	-- 二进制日志文件：文件名后缀为.00000*，记录数据库所有的 DDL 和 DML(除了数据查询语句)语句事件。


-- 	MySQL Binlog三种格式的区别
-- （1）statement：语句级， binlog 会记录每次一执行写操作的语句。相对 row 模式节省空间，但是可能产生不一致性，比如“ update test set create_date=now()”， 如果用 binlog 日志进行恢复，由于执行时间不同可能产生的数据就不同。
-- 	优点： 节省空间
-- 	缺点： 有可能造成数据不一致。

-- （2）row：行级， binlog 会记录每次操作后每行记录的变化。
-- 	优点：保持数据的绝对一致性。因为不管 sql 是什么，引用了什么函数，他只记录执行后的效果
-- 	缺点：占用较大空间

	-- mixed：混合级别，statement 的升级版，一定程度上解决了statement模式因为一些情况造成的数据不一致的问题。默认还是statement，在某些情况下，如函数中包含UUID()、包含AUTO_INCREMENT 字段的表被更新时、执行INSERT DELAYED 语句时会按照ROW的方式进行处理
	-- 优点：节省空间，同时兼顾了一定的一致性
	-- 缺点：还有些极个别情况依旧会造成不一致，另外statement 和 mixed 对于需要对 binlog 监控的情况都不方便

13、-- Canal
	-- 1、Canal介绍
	-- canal 是用 java 开发的基于数据库增量日志解析，提供增量数据订阅&消费的中间件。目前， canal 主要支持了 MySQL 的 binlog 解析，解析完成后才利用 canal client 来处理获得的相关数据。

	-- 2、Canal工作原理
	-- 把自己伪装成 slave， 假装从 master 复制数据

	-- 3、使用场景：
	-- 原始场景： canal 阿里 otter 中间件的一部分，otter 是阿里用于进行异地数据库之间的同步框架。
	-- 更新缓存
	-- 抓取业务数据新增变化表，用于制作拉链表。
	-- 抓取业务表的新增变化数据，用于制作实时统计


14、-- Maxwell

	-- 1、Maxwell介绍
	-- Maxwell是由美国Zendesk开源，用Java编写的MySQL实时抓取软件。 实时读取MySQL二进制日志Binlog，并生成 JSON 格式的消息，作为生产者发送给 Kafka，RabbitMQ、 Redis、文件或其它平台的应用程序。

	-- 2、Maxwell工作原理
	-- 把自己伪装成 MySQL 的一个 slave， 然后以 slave的身份假装从 MySQL(master)复制数据。

	-- 3、Maxwell使用
	-- （1）Maxwell进程启动

	-- 使用命令行参数
	-- bin/maxwell --user='maxwell' --password='123456' --host='hadoop102' --producer=stdout

	-- bin/maxwell --user='maxwell' --password='123456' --host='hadoop102' --producer=kafka 
	-- --kafka.bootstrap.servers=hadoop102:9092 --kafka_topic=maxwell
	-- --producer 生产者模式(stdout：控制台 kafka： kafka 集群)

	-- （2）监控MySQL数据输出到Kafka

	-- Maxwell如何控制这些数据的分区?
	-- #控制数据分区模式，可选模式有 库名，表名，主键，列名

	-- producer_partition_by=database #控制数据分区模式，可选模式有 库名，表名，主键，列名
	-- #producer_partition_columns=name
	-- #producer_partition_by_fallback=database
	-- maxwell 是以数据行为单位进行日志的采集的
	-- （3）监控MySQL指定表数据输出到控制台

	-- （4）Maxwell数据初始化

	-- Maxwell 进程默认只能监控 mysql 的 binlog 日志的新增及变化的数据，但是Maxwell 是支持数据初始化的，可以通过修改 Maxwell 的元数据，来对 MySQL 的某张表进行数据初始化，也就是我们常说的全量同步

	-- insert into maxwell.bootstrap(database_name,table_name) values('test_maxwell','test2');
	-- 当数据全部初始化完成以后， Maxwell 的元数据会变化，

	-- is_complete 字段从 0 变为 1
	-- start_at 字段从 null 变为具体时间(数据同步开始时间)
	-- complete_at 字段从 null 变为具体时间(数据同步结束时间)	


14、 -- 根据表注释获取表名
select table_name 表名,TABLE_COMMENT '表注解' from INFORMATION_SCHEMA.TABLES Where table_schema = 'decent_cloud' AND TABLE_COMMENT  LIKE '%预%';

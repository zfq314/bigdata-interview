
1、静态ip切换目录：cd /etc/sysconfig/network-scripts

2、解压目录 tar -zxvf xxx.tar.gz -C /指定目录

3、vim  yy 复制 p粘贴

4、改主机名 sudo hostnamectl set-hostname node3

5、生成密钥 ssh-keygen -t rsa  免费登录,密钥拷贝 ssh-copy-id node3

6、添加主机列表 sudo vim /etc/hosts 

7、xcall.sh 的脚本
	#!/bin/bash
	params=$@
	i=1
	for (( i=1 ; i <= 3 ; i = $i + 1 )) ; do
	    echo ============= node$i $params =============
	    ssh node$i "$params"
	done

8、xsync.sh 的脚本	
	
	#!/bin/sh

	# 获取输入参数个数，如果没有参数，直接退出
	#!/bin/sh
	# 获取输入参数个数，如果没有参数，直接退出
	pcount=$#
	if((pcount==0)); then
	        echo no args...;
	        exit;
	fi

	# 获取文件名称
	p1=$1
	fname=`basename $p1`
	echo fname=$fname
	# 获取上级目录到绝对路径
	pdir=`cd -P $(dirname $p1); pwd`
	echo pdir=$pdir
	# 获取当前用户名称
	user=`whoami`
	# 循环
	for((host=1; host<=3; host++)); do
	        echo $pdir/$fname $user@node$host:$pdir
	        echo ==================node$host==================
	        rsync -rvl $pdir/$fname $user@node$host:$pdir
	done
	#Note:这里的slave对应自己主机名，需要做相应修改。另外，for循环中的host的边界值由自己的主机编号决定。


9、 安装 lrzsz yum -y install lrzsz 



10、配置文件

vim core-site.xml
	
	<configuration>
  <!-- 指定NameNode的地址 -->
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://node1:8020</value>
    </property>

    <!-- 指定hadoop数据的存储目录 -->
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/opt/module/hadoop-3.1.3/data</value>
    </property>

    <!-- 配置HDFS网页登录使用的静态用户为atguigu -->
    <property>
        <name>hadoop.http.staticuser.user</name>
        <value>zfq</value>
    </property>
</configuration>



vim hdfs-site.xml

<configuration>
	<!-- nn web端访问地址-->
	<property>
        <name>dfs.namenode.http-address</name>
        <value>node1:9870</value>
    </property>
	<!-- 2nn web端访问地址-->
    <property>
        <name>dfs.namenode.secondary.http-address</name>
        <value>node3:9868</value>
    </property>
</configuration>




vim yarn-site.xml
<configuration>
    <!-- 指定MR走shuffle -->
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>

    <!-- 指定ResourceManager的地址-->
    <property>
        <name>yarn.resourcemanager.hostname</name>
        <value>node2</value>
    </property>

    <!-- 环境变量的继承 -->
    <property>
        <name>yarn.nodemanager.env-whitelist</name>
        <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
    </property>
<!-- 开启日志聚集功能 -->
<property>
    <name>yarn.log-aggregation-enable</name>
    <value>true</value>
</property>
<!-- 设置日志聚集服务器地址 -->
<property>  
    <name>yarn.log.server.url</name>  
    <value>http://node1:19888/jobhistory/logs</value>
</property>
<!-- 设置日志保留时间为7天 -->
<property>
    <name>yarn.log-aggregation.retain-seconds</name>
    <value>604800</value>
</property>



</configuration>


vim mapred-site.xml


<!-- 指定MapReduce程序运行在Yarn上 -->
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>

    <!-- 历史服务器端地址 -->
<property>
    <name>mapreduce.jobhistory.address</name>
    <value>node1:10020</value>
</property>

<!-- 历史服务器web端地址 -->
<property>
    <name>mapreduce.jobhistory.webapp.address</name>
    <value>node1:19888</value>
</property>

    <property>
    <!-- 是否对容器强制执行虚拟内存限制 -->
        <name>yarn.nodemanager.vmem-check-enabled</name>
        <value>false</value>
        <description>Whether virtual memory limits will be enforced for containers</description>
    </property>
    <property>
    <!-- 为容器设置内存限制时虚拟内存与物理内存之间的比率 -->
        <name>yarn.nodemanager.vmem-pmem-ratio</name>
        <value>4</value>
        <description>Ratio between virtual memory to physical memory when setting memory limits for containers</description>
    </property>


vim works 

	node1
	node2
	node3

11、格式化 hdfs namenode -format

12、启动Hadoop报错（Error: JAVA_HOME is not set and could not be found.） 需要设置下hadoop-env.sh 指定下目录

export JAVA_HOME=/opt/module/jdk1.8.0_381
export HADOOP_CONF_DIR=/opt/module/hadoop-3.1.3/etc/hadoop



13、 启停脚本
#!/bin/bash

if [ $# -lt 1 ]
then
    echo "No Args Input..."
    exit ;
fi

case $1 in
"start")
        echo " =================== 启动 hadoop集群 ==================="

        echo " --------------- 启动 hdfs ---------------"
        ssh node1 "/opt/module/hadoop-3.1.3/sbin/start-dfs.sh"
        echo " --------------- 启动 yarn ---------------"
        ssh node2 "/opt/module/hadoop-3.1.3/sbin/start-yarn.sh"
        echo " --------------- 启动 historyserver ---------------"
        ssh node1 "/opt/module/hadoop-3.1.3/bin/mapred --daemon start historyserver"
;;
"stop")
        echo " =================== 关闭 hadoop集群 ==================="

        echo " --------------- 关闭 historyserver ---------------"
        ssh node1 "/opt/module/hadoop-3.1.3/bin/mapred --daemon stop historyserver"
        echo " --------------- 关闭 yarn ---------------"
        ssh node2 "/opt/module/hadoop-3.1.3/sbin/stop-yarn.sh"
        echo " --------------- 关闭 hdfs ---------------"
        ssh node1 "/opt/module/hadoop-3.1.3/sbin/stop-dfs.sh"
;;
*)
    echo "Input Args Error..."
;;
esac

14、官方wordcount的代码

hadoop jar /opt/module/hadoop-3.1.3/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.1.3.jar wordcount /word.txt /output

15、 MySQL获取当前时间是本月的第几周 要求 周是以周日为每周的第一天 周数从每个月的第一个星期日开始的,不是每个月的1号

    sql实现：

SELECT FLOOR((DATEDIFF(DATE(NOW()), (DATE_ADD((DATE_SUB(DATE(NOW()), INTERVAL (DAYOFMONTH(DATE(NOW())) - 1) DAY)), INTERVAL(IF((DAYOFWEEK( DATE_SUB(DATE(NOW()), INTERVAL (DAYOFMONTH(DATE(NOW())) - 1) DAY))) = 1, 0, 8 - (DAYOFWEEK( DATE_SUB(DATE(NOW()), INTERVAL (DAYOFMONTH(DATE(NOW())) - 1) DAY))))) DAY)))) / 7) + 1 as week_num ;

存储过程实现：
            CREATE DEFINER=`app_user`@`%` PROCEDURE `test`()
            BEGIN
             
            SET @current_date = CURDATE();

            -- Find the first day of the month
            SET @first_day_of_month = DATE_SUB(@current_date, INTERVAL (DAYOFMONTH(@current_date) - 1) DAY);

            -- Find the day of the week (0 = Sunday, 1 = Monday, ..., 6 = Saturday)
            SET @day_of_week = DAYOFWEEK(@first_day_of_month);

            -- Calculate the offset to get to the first Sunday of the month
            SET @sunday_offset = IF(@day_of_week = 1, 0, 8 - @day_of_week);

            -- Find the first Sunday of the month
            SET @first_sunday_of_month = DATE_ADD(@first_day_of_month, INTERVAL @sunday_offset DAY);

            -- Calculate the week number within the month (1st week, 2nd week, etc.)
            SET @days_since_first_sunday = DATEDIFF(@current_date, @first_sunday_of_month);
            SET @week_number = FLOOR(@days_since_first_sunday / 7) + 1;

            -- Output the result
            SELECT @week_number AS current_week_number;



END




16、 mysql
        SELECT name as nss,
         max(case course when '语文' then score else 0 end )as chinese,
         max(case course when '数学' then score else 0 end )as math,
         max(case course when '物理' then score else 0 end )as wl
         FROM `user`
         GROUP BY name
         
         
         MySQL报错：sql_mode=only_full_group_by 4种解决方法含举例，轻松解决ONLY_FULL_GROUP_BY的报错问题

         在MySQL 5.7后，MySQL默认开启了SQL_MODE严格模式，对数据进行严格校验。如果代码中含有group by聚合操作，那么select中的列，除了使用聚合函数之外的，如max()、min()等，都必须出现在group by中。




17、
    hdfs 的读写流程
        读流程
        写流程

    hdfs 的原理

    shuffle 机制

        mapper
            shuffle 
        reduce 


    任务提交流程

    端口 
    Namenode 端口:
        2.x端口   3.x端口   name    desc
        50470      9871    dfs.namenode.https-address  The namenode secure http server address and port.
        50070      9870    dfs.namenode.http-address   The address and the base port where the dfs namenode web ui will listen on.
        8020       9820    fs.defaultFS                指定HDFS运行时nameNode地址
 

     Secondary NN 端口:
    2.x端口   3.x端口   name    desc
      50091   9869    dfs.namenode.secondary.https-address    The secondary namenode HTTPS server address and port
      50090   9868    dfs.namenode.secondary.http-address     The secondary namenode HTTPS server address and port

      Datanode 端口:
        2.x端口   3.x端口   name    desc
        50020     9867    dfs.datanode.ipc.address    The datanode ipc server address and port.
        50010     9866    dfs.datanode.address        The datanode server address and port for data transfer.
        50475     9865    dfs.datanode.https.address  The datanode secure http server address and port
        50075     9864    dfs.datanode.http.address   The datanode http server address and por
     
 

    Yarn 端口
         2.x端口   3.x端口   name    desc
          8088      8088    yarn.resourcemanager.webapp.address http服务端口


    Hadoop 3.X
    HDFS NameNode 内部通信端口：8020/9000/9820
    HDFS NameNode HTTP UI：9870
    HDFS DataNode HTTP UI：9864
    Yarn 查看任务执行端口：8088
    历史服务器通信端口：19888

    Hadoop 2.X
    HDFS NameNode 内部通信端口：8020/9000
    HDFS NameNode HTTP UI：50070
    HDFS DataNode HTTP UI：50075
    Yarn 查看任务执行端口：8088
    历史服务器通信端口：19888


    Hadoop：    
    50070：HDFS WEB UI端口
    8020 ： 高可用的HDFS RPC端口
    9000 ： 非高可用的HDFS RPC端口
    8088 ： Yarn 的WEB UI 接口
    8485 ： JournalNode 的RPC端口
    8019 ： ZKFC端口
    19888：jobhistory WEB UI端口

    Zookeeper:
        2181 ： 客户端连接zookeeper的端口
        2888 ： zookeeper集群内通讯使用，Leader监听此端口
        3888 ： zookeeper端口 用于选举leader

    Hbase:

        60010：Hbase的master的WEB UI端口 （旧的） 新的是16010
        60030：Hbase的regionServer的WEB UI 管理端口    

    Hive:

        9083  :  metastore服务默认监听端口
        10000：Hive 的JDBC端口

    Spark：

        7077 ： spark 的master与worker进行通讯的端口  standalone集群提交Application的端口
        8080 ： master的WEB UI端口  资源调度
        8081 ： worker的WEB UI 端口  资源调度
        4040 ： Driver的WEB UI 端口  任务调度
        18080：Spark History Server的WEB UI 端口

    Kafka：
        9092： Kafka集群节点之间通信的RPC端口

    Redis：
        6379： Redis服务端口

    CDH：

        7180： Cloudera Manager WebUI端口
        7182： Cloudera Manager Server 与 Agent 通讯端口

    HUE：
        8888： Hue WebUI 端口


    优化


    配置文件参数优化：

    小文件的优化：

    脚本的启停:
                #！/bin/bash

                if [[ $# -lt 1 ]]; then
                    echo "No Args Input"
                    exit;
                fi

                case $1 in
                    "start" )
                    echo "starting......"
                        ;;
                    "stop")
                    echo "stoping......"
                    ;;
                      *)
                   echo "Input  Args Error..."
                    ;;
                esac




17 、mysql 存储过程可优化的地方

    可以加索引
    drop temporary table if exists $t_ka_splsz;
    create temporary table $t_ka_splsz (index idx1(wdmc,ckmc,jsmc)) as   
    select * from t_ka_splsz  where wdmc=v_wdmc and date(rq)>=v_qsrq and date(rq)<=v_jzrq;

    可以加事务

    /*声明一个变量，标识是否有sql异常*/
        DECLARE hasSqlError int DEFAULT FALSE;
        DECLARE ERR_CODE VARCHAR(20);
        DECLARE ERR_MSG TEXT;
    /*在执行过程中出任何异常设置hasSqlError为TRUE*/
       DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
       BEGIN
       GET CURRENT DIAGNOSTICS CONDITION 1
       ERR_CODE = MYSQL_ERRNO, ERR_MSG = MESSAGE_TEXT;
       SET hasSqlError = TRUE;
      END;


      -- 异常处理
      -- 事务回滚
        IF hasSqlError THEN 
          ROLLBACK;
          SELECT CONCAT('gn_zt_kcrzzjz_fjz:', ERR_CODE, ' ', ERR_MSG) AS MSG_INFO;
          INSERT INTO T_DAILY_INTERREST_ERR_LOG SELECT NOW(), 'gn_zt_kcrzzjz_fjz', CONCAT(ERR_CODE, ' ', ERR_MSG);

       --  事务提交   
        ELSE
          COMMIT;
          INSERT INTO T_DAILY_INTERREST_LOG(RUN_TIME, LOG_INFO) 
          SELECT NOW(), 'gn_zt_kcrzzjz_fjz执行成功';

    
        先创建临时表 
        然后with table_name as 
        (列比较固定，单据多)
        select * from 


        create temporary table temptables 
        (
        csmc VARCHAR(60),
        ckmc VARCHAR(60),
        type VARCHAR(60)
        );
        --  with as 可以创建多个临时表，需要注意同一个查询语句只需要写一个with 另外子查询用都好隔开就可以了
        insert into temptables   -- 插入临时表 位置必须不能动 
                with ckmc_tab  as 
                (
                            select 
                                        a.purity_name as csmc,
                                        b.warehouse_name as ckmc,
                                        null as type
                            from t_sale_from a 
                            left join t_sale_from_detail b on a.sale_identity=b.sale_identity
                            where approve_status=1 and b.`status`=0 and a.status=0 
                ),
                 type_tab  as 
                (
                            select 
                                        a.purity_name as csmc,
                                        null as ckmc,
                                        b.account_method as type
                            from t_sale_from a 
                            left join t_sale_from_account_detail b on a.sale_identity=b.sale_identity
                            where approve_status=1 and b.`status`=0 and a.status=0 
                )
                select 
                            csmc,
                            ckmc,
                            type
                from ckmc_tab
                union all 
                        select 
                                csmc,
                                ckmc,
                                type
                from type_tab
                ;
                -- 查询数据
                select * from temptables;
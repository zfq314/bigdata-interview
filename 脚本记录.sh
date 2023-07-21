
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
         
         
         MySQL报错：sql_mode=only_full_group_by 4种解决方法含举例，轻松解决ONLY_FULL_GROUP_BY的报错问题\
         在MySQL 5.7后，MySQL默认开启了SQL_MODE严格模式，对数据进行严格校验。如果代码中含有group by聚合操作，那么select中的列，除了使用聚合函数之外的，如max()、min()等，都必须出现在group by中。
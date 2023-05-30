# 集群崩溃 处理方式

第一步
	 ：停止进程 

第二步 
	：删除 /data /log 

第三步：
	 格式化

主要原因 ：datanode节点的版本需要一致，否则，无法启动集群

看这个目录的	VERSION 是否一致，如果不一致的话，无法启动集群

/data/program/hadoop-2.7.2/data/tmp/dfs/name/current

VERSION 的主要内容

hadoop31
#Tue Oct 11 06:45:23 CST 2022
namespaceID=771447616
clusterID=CID-e33e9563-2006-4b49-812e-851d9fe7e9a9
cTime=0
storageType=NAME_NODE
blockpoolID=BP-2101474534-10.10.80.31-1605179824423
layoutVersion=-63
hadoop32

#Sun Oct 16 17:51:12 CST 2022
namespaceID=771447616
clusterID=CID-e33e9563-2006-4b49-812e-851d9fe7e9a9
cTime=0
storageType=NAME_NODE
blockpoolID=BP-2101474534-10.10.80.31-1605179824423
layoutVersion=-63	


hadoop33
#Sat Oct 08 13:36:38 CST 2022
storageID=DS-77cf80e7-5e8c-4999-9c7b-a8498f6d4894
clusterID=CID-e33e9563-2006-4b49-812e-851d9fe7e9a9
cTime=0
datanodeUuid=4b271c30-6725-45af-81ce-3f2487106e84
storageType=DATA_NODE
layoutVersion=-56

hadoop30
#Sat Oct 08 13:36:37 CST 2022
storageID=DS-57548ec0-e1f0-4584-ae7c-e0e0893843a5
clusterID=CID-e33e9563-2006-4b49-812e-851d9fe7e9a9
cTime=0
datanodeUuid=bc67f9c5-6a1f-49c2-8526-b66a0f8ec1be
storageType=DATA_NODE
layoutVersion=-56


hadoop34

#Sat Oct 08 13:36:37 CST 2022
storageID=DS-9fdb6dfd-c053-440d-8eb7-b89dd610717d
clusterID=CID-e33e9563-2006-4b49-812e-851d9fe7e9a9
cTime=0
datanodeUuid=8c25118c-6c3d-4a7b-ab22-b0da27934b81
storageType=DATA_NODE
layoutVersion=-56




namenode 节点的数据节点的存放目录
data : /data/program/hadoop-2.7.2/data/tmp/dfs/data/current
name : /data/program/hadoop-2.7.2/data/tmp/dfs/name

非namenode 节点的数据节点的存放目录 hadoop30/hadoop33/hadoop34
data : /data/program/hadoop-2.7.2/data/tmp/dfs/data/current
name : /data/program/hadoop-2.7.2/data/tmp/dfs/name 没有此目录

新挂载磁盘 ：
			不修改配置文件，新挂载磁盘做软连接配置，
			data -> /mnt/bigdata-storage1/data	

大数据高可用配置：
				需要zk 注册中心 

QuorumPeerMain zk服务
zkfc 
journanode:
			两个NameNode为了数据同步，会通过一组称作JournalNodes的独立进程进行相互通信。当active状态的NameNode的命名空间有任何修改时，会告知大部分的JournalNodes进程。standby状态的NameNode有能力读取JNs中的变更信息，并且一直监控edit log的变化，把变化应用于自己的命名空间。standby可以确保在集群出错时，命名空间状态已经完全同步了。
			为了确保快速切换，standby状态的NameNode有必要知道集群中所有数据块的位置。为了做到这点，所有的datanodes必须配置两个NameNode的地址，发送数据块位置信息和心跳给他们两个。 

对于HA集群而言，确保同一时刻只有一个NameNode处于active状态是至关重要的。否则，两个NameNode的数据状态就会产生分歧，可能丢失数据，或者产生错误的结果。为了保证这点，JNs必须确保同一时刻只有一个NameNode可以向自己写数据。

面试题：
hadoop3.x 
		namenode 内部通信端口 8020/9000/9820
			     用户查询接口 9870
			     yarn 8088
			     历史服务器19888

hadoop2.x 
		namenode 内部通信端口 8020/9000
			     用户查询接口 50070
			     yarn 8088
			     历史服务器19888

3.x 配置文件 core-site.xml hdfs-site.xml yarn-site.xml mapred-site.xml workers  			     

2.x 配置文件 core-site.xml hdfs-site.xml yarn-site.xml mapred-site.xml slaves  	

core-site.xml


<configuration>
		<property>
			<name>fs.defaultFS</name>
        	<value>hdfs://mycluster</value>
		</property>

		<property>
			<name>hadoop.tmp.dir</name>
			<value>/data/program/hadoop-2.7.2/data/tmp</value>
		</property>
		<property>
	<name>ha.zookeeper.quorum</name>
	<value>hadoop31:2181,hadoop32:2181,hadoop33:2181</value>
</property>
# 配置压缩格式
<property>
<name>io.compression.codecs</name>
<value>
org.apache.hadoop.io.compress.GzipCodec,
org.apache.hadoop.io.compress.DefaultCodec,
org.apache.hadoop.io.compress.BZip2Codec,
org.apache.hadoop.io.compress.SnappyCodec,
com.hadoop.compression.lzo.LzoCodec,
com.hadoop.compression.lzo.LzopCodec
</value>
</property>

<property>
    <name>io.compression.codec.lzo.class</name>
    <value>com.hadoop.compression.lzo.LzoCodec</value>
</property>

# 开启垃圾箱配置，将删除的文件先放到垃圾箱，然后达到过期时间会自动删除
    <property>
        <name>fs.trash.interval</name>
        <value>1440</value>
    </property>
    <property>
        <name>fs.trash.checkpoint.interval</name>
        <value>1440</value>
    </property>
</configuration>


mapred-site.xml

<configuration>
<!-- 指定MR运行在Yarn上 -->
<property>
		<name>mapreduce.framework.name</name>
		<value>yarn</value>
</property>
        <property>
                <name>mapreduce.map.cpu.vcores</name>
                <value>4</value>
                <description>每个MapTask容器申请的核心数；默认1</description> 
        </property>   
        <property>
                <name>mapreduce.map.memory.mb</name>
                <value>4096</value>
                <description>每个Map task容器申请的内存大小；默认1G</description> 
        </property>
        <property>
                <name>mapreduce.map.java.opts</name>
                <value>-Xmx3072m</value>
                <description>map使用的JVM的堆大小heapsize；根据单个mapper/reducer容器内存进行调整，heapsize不能大于单个mapper/reducer容器内存值，一般设置为mapreduce.map.memory.mb的85%左右</description> 
        </property>  
<!--reduce阶段的设置 -->
        <property>
                <name>mapreduce.reduce.cpu.vcores</name>
                <value>4</value>
                <description>每个ReduceTask容器申请的核心数；默认1</description> 
        </property> 
        <property>
                <name>mapreduce.reduce.memory.mb</name>
                <value>4096</value>
                <description>Reduce task申请的内存大小</description> 
        </property>             
        <property>
                <name>mapreduce.reduce.java.opts</name>
                <value>-Xmx6144m</value>
                <description>Reduce阶段的JVM的堆大小；同上</description> 
        </property>
</configuration>



hdfs-site.xml

<!-- 完全分布式集群名称 -->
	<property>
		<name>dfs.nameservices</name>
		<value>mycluster</value>
	</property>
	<property>
　　<name>dfs.replication</name>
　　<value>2</value>
	</property>
	<!-- 集群中NameNode节点都有哪些 -->
	<property>
		<name>dfs.ha.namenodes.mycluster</name>
		<value>nn1,nn2</value>
	</property>

	<!-- nn1的RPC通信地址 -->
	<property>
		<name>dfs.namenode.rpc-address.mycluster.nn1</name>
		<value>hadoop31:9000</value>
	</property>

	<!-- nn2的RPC通信地址 -->
	<property>
		<name>dfs.namenode.rpc-address.mycluster.nn2</name>
		<value>hadoop32:9000</value>
	</property>

	<!-- nn1的http通信地址 -->
	<property>
		<name>dfs.namenode.http-address.mycluster.nn1</name>
		<value>hadoop31:50070</value>
	</property>

	<!-- nn2的http通信地址 -->
	<property>
		<name>dfs.namenode.http-address.mycluster.nn2</name>
		<value>hadoop32:50070</value>
	</property>

	<!-- 指定NameNode元数据在JournalNode上的存放位置 -->
	<property>
		<name>dfs.namenode.shared.edits.dir</name>
	<value>qjournal://hadoop31:8485;hadoop32:8485;hadoop33:8485/mycluster</value>
	</property>

	<!-- 配置隔离机制，即同一时刻只能有一台服务器对外响应 -->
	<property>
		<name>dfs.ha.fencing.methods</name>
		<value>sshfence</value>
	</property>

	<!-- 使用隔离机制时需要ssh无秘钥登录-->
	<property>
		<name>dfs.ha.fencing.ssh.private-key-files</name>
		<value>/root/.ssh/id_rsa</value>
	</property>

	<!-- 声明journalnode服务器存储目录-->
	<property>
		<name>dfs.journalnode.edits.dir</name>
		<value>/data/program/hadoop-2.7.2/data/jn</value>
	</property>

	<!-- 关闭权限检查-->
	<property>
		<name>dfs.permissions.enable</name>
		<value>false</value>
	</property>

	<!-- 访问代理类：client，mycluster，active配置失败自动切换实现方式-->
	<property>
  		<name>dfs.client.failover.proxy.provider.mycluster</name>
	<value>org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider</value>
	</property>
	<property>
		<name>dfs.ha.automatic-failover.enabled</name>
		<value>true</value>
	</property>
<property>
        <name>dfs.permissions.enabled</name>
        <value>true</value>
    </property>
    <property>
        <name>dfs.permissions</name>
        <value>true</value>
    </property>
    <property>
        <name>dfs.namenode.inode.attributes.provider.class</name>
        <value/>
    </property>
</configuration>


yarn-site.xml


<configuration>

<!-- Site specific YARN configuration properties -->
 <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>

    <!--启用resourcemanager ha-->
    <property>
        <name>yarn.resourcemanager.ha.enabled</name>
        <value>true</value>
    </property>
 
    <!--声明两台resourcemanager的地址-->
    <property>
        <name>yarn.resourcemanager.cluster-id</name>
        <value>cluster-yarn1</value>
    </property>

    <property>
        <name>yarn.resourcemanager.ha.rm-ids</name>
        <value>rm1,rm2</value>
    </property>

    <property>
        <name>yarn.resourcemanager.hostname.rm1</name>
        <value>hadoop31</value>
    </property>

    <property>
        <name>yarn.resourcemanager.hostname.rm2</name>
        <value>hadoop32</value>
    </property>
 
    <!--指定zookeeper集群的地址--> 
    <property>
        <name>yarn.resourcemanager.zk-address</name>
        <value>hadoop31:2181,hadoop32:2181,hadoop33:2181</value>
    </property>

    <!--启用自动恢复--> 
    <property>
        <name>yarn.resourcemanager.recovery.enabled</name>
        <value>true</value>
    </property>
 
    <!--指定resourcemanager的状态信息存储在zookeeper集群--> 
    <property>
        <name>yarn.resourcemanager.store.class</name>     
		<value>org.apache.hadoop.yarn.server.resourcemanager.recovery.ZKRMStateStore</value>
</property>
	        <!-- 日志聚集功能使能 -->
        <property>
            <name>yarn.log-aggregation-enable</name>
            <value>true</value>
        </property>

        <!-- 日志保留时间设置7天 -->
        <property>
            <name>yarn.log-aggregation.retain-seconds</name>
            <value>604800</value>
        </property>
        <!-- 时间线服务start -->
    <property>
        <name>yarn.timeline-service.enabled</name>
        <value>true</value>
    </property>
    <property>
        <name>yarn.timeline-service.hostname</name>
        <value>hadoop31</value>
    </property>
    <property>
        <name>yarn.timeline-service.http-cross-origin.enabled</name>
        <value>true</value>
    </property>

    <property>
        <name>yarn.resourcemanager.system-metrics-publisher.enabled</name>
        <value>true</value>
    </property>
        <property>
    <name>yarn.nodemanager.pmem-check-enabled</name>
    <value>false</value>
</property>
<!--是否启动一个线程检查每个任务正使用的虚拟内存量，如果任务超出分配值，则直接将其杀掉，默认是true -->
<property>
    <name>yarn.nodemanager.vmem-check-enabled</name>
    <value>true</value>
</property>
<property>
    <name>yarn.timeline-service.enabled</name>
    <value>false</value>
</property>
<property>
    <name>yarn.log.server.url</name>
    <value>http://hadoop31:19888/jobhistory/logs</value>
</property>
        <property>
                <name>yarn.nodemanager.pmem-check-enabled</name>
                <value>true</value>
                <description>检测物理内存的使用是否超出分配值，若任务超出分配值，则将其杀掉，默认true。</description> 
        </property>          
        <property>
                <name>yarn.nodemanager.vmem-pmem-ratio</name>
                <value>8</value>
                <description>任务每使用1MB物理内存，最多可使用虚拟内存量比率，默认2.1；在上一项中设置为false不检测虚拟内存时，此项就无意义了</description> 
        </property>  
        <property>
                <name>yarn.nodemanager.resource.cpu-vcores</name>
                <value>12</value>
                <description>该节点上YARN可使用的总核心数；一般设为cat /proc/cpuinfo| grep "processor"| wc -l 的值。默认是8个；</description>  
        </property>
        <property>
                <name>yarn.nodemanager.resource.memory-mb</name>
                <value>16384</value>
                <description>该节点上YARN可使用的物理内存总量，【向操作系统申请的总量】默认是8192（MB）</description>  
        </property>
        <property>
                <name>yarn.scheduler.minimum-allocation-mb</name>
                <value>4096</value>
                <description>单个容器/调度器可申请的最少物理内存量，默认是1024（MB）；一般每个contain都分配这个值；即：capacity memory:3072, vCores:1，如果提示物理内存溢出，提高这个值即可；</description> 
        </property>
        <property>
                <name>yarn.scheduler.maximum-allocation-mb</name>
                <value>8000</value>
                <description>单个容器申请最大值</description> 
        </property>    
	
    <property>
    <description>The minimum allocation for every container request at the RM,
    in terms of virtual CPU cores. Requests lower than this will throw a
    InvalidResourceRequestException.</description>
    <name>yarn.scheduler.minimum-allocation-vcores</name>
    <value>1</value>
  </property>
 <property>
     <name>yarn.nodemanager.disk-health-checker.min-healthy-disks</name>
     <value>0.0</value>
  </property>
  <property>
     <name>yarn.nodemanager.disk-health-checker.max-disk-utilization-per-disk-percentage</name>
     <value>100.0</value>
 </property>
</configuration>


Hadoop的Web页面没有删除权限问题

https://blog.csdn.net/weixin_45284133/article/details/105493874


设置多队列
capacity-scheduler.xml
<configuration>

  <property>
    <name>yarn.scheduler.capacity.maximum-applications</name>
    <value>10000</value>
    <description>
      Maximum number of applications that can be pending and running.
    </description>
  </property>

  <property>
    <name>yarn.scheduler.capacity.maximum-am-resource-percent</name>
    <value>0.1</value>
    <description>
      Maximum percent of resources in the cluster which can be used to run 
      application masters i.e. controls number of concurrent running
      applications.
    </description>
  </property>

  <property>
    <name>yarn.scheduler.capacity.resource-calculator</name>
    <value>org.apache.hadoop.yarn.util.resource.DominantResourceCalculator</value>

    <description>
      The ResourceCalculator implementation to be used to compare 
      Resources in the scheduler.
      The default i.e. DefaultResourceCalculator only uses Memory while
      DominantResourceCalculator uses dominant-resource to compare 
      multi-dimensional resources such as Memory, CPU etc.
    </description>
  </property>

  <property>
    <name>yarn.scheduler.capacity.root.queues</name>
    <value>default,hive</value>
    <description>
      The queues at the this level (root is the root queue).
    </description>
  </property>

  <property>
    <name>yarn.scheduler.capacity.root.default.capacity</name>
    <value>50</value>
    <description>Default queue target capacity.</description>
  </property>
<property>
    <name>yarn.scheduler.capacity.root.hive.capacity</name>
<value>50</value>
    <description>
      hive队列的容量为50%
    </description>
</property>
  <property>
    <name>yarn.scheduler.capacity.root.default.user-limit-factor</name>
    <value>1</value>
    <description>
      Default queue user limit a percentage from 0.0 to 1.0.
    </description>
  </property>
   <property>
    <name>yarn.scheduler.capacity.root.hive.user-limit-factor</name>
<value>1</value>
    <description>
      一个用户最多能够获取该队列资源容量的比例，取值0-1
    </description>
</property>
  <property>
    <name>yarn.scheduler.capacity.root.default.maximum-capacity</name>
    <value>100</value>
    <description>
      The maximum capacity of the default queue. 
    </description>
  </property>

<property>
    <name>yarn.scheduler.capacity.root.hive.maximum-capacity</name>
<value>80</value>
    <description>
      hive队列的最大容量（自己队列资源不够，可以使用其他队列资源上限）
    </description>
</property>
	
<property>
    <name>yarn.scheduler.capacity.root.hive.state</name>
    <value>RUNNING</value>
    <description>
      开启hive队列运行，不设置队列不能使用
    </description>
</property>

<property>
    <name>yarn.scheduler.capacity.root.hive.acl_submit_applications</name>
<value>*</value>
    <description>
      访问控制，控制谁可以将任务提交到该队列,*表示任何人
    </description>
</property>

<property>
    <name>yarn.scheduler.capacity.root.hive.acl_administer_queue</name>
<value>*</value>
    <description>
      访问控制，控制谁可以管理(包括提交和取消)该队列的任务，*表示任何人
    </description>
</property>

<property>
    <name>yarn.scheduler.capacity.root.hive.acl_application_max_priority</name>
<value>*</value>
<description>
      指定哪个用户可以提交配置任务优先级
    </description>
</property>

<property>
    <name>yarn.scheduler.capacity.root.hive.maximum-application-lifetime</name>
<value>-1</value>
    <description>
      hive队列中任务的最大生命时长，以秒为单位。任何小于或等于零的值将被视为禁用。
</description>
</property>

<property>
<name>yarn.scheduler.capacity.root.hive.default-application-lifetime</name>
<value>-1</value>
    <description>
      hive队列中任务的默认生命时长，以秒为单位。任何小于或等于零的值将被视为禁用。
</description>
</property>





  <property>
    <name>yarn.scheduler.capacity.root.default.state</name>
    <value>RUNNING</value>
    <description>
      The state of the default queue. State can be one of RUNNING or STOPPED.
    </description>
  </property>

  <property>
    <name>yarn.scheduler.capacity.root.default.acl_submit_applications</name>
    <value>*</value>
    <description>
      The ACL of who can submit jobs to the default queue.
    </description>
  </property>

  <property>
    <name>yarn.scheduler.capacity.root.default.acl_administer_queue</name>
    <value>*</value>
    <description>
      The ACL of who can administer jobs on the default queue.
    </description>
  </property>

  <property>
    <name>yarn.scheduler.capacity.node-locality-delay</name>
    <value>40</value>
    <description>
      Number of missed scheduling opportunities after which the CapacityScheduler 
      attempts to schedule rack-local containers. 
      Typically this should be set to number of nodes in the cluster, By default is setting 
      approximately number of nodes in one rack which is 40.
    </description>
  </property>

  <property>
    <name>yarn.scheduler.capacity.queue-mappings</name>
    <value></value>
    <description>
      A list of mappings that will be used to assign jobs to queues
      The syntax for this list is [u|g]:[name]:[queue_name][,next mapping]*
      Typically this list will be used to map users to queues,
      for example, u:%user:%user maps all users to queues with the same name
      as the user.
    </description>
  </property>

  <property>
    <name>yarn.scheduler.capacity.queue-mappings-override.enable</name>
    <value>false</value>
    <description>
      If a queue mapping is present, will it override the value specified
      by the user? This can be used by administrators to place jobs in queues
      that are different than the one specified by the user.
      The default is false.
    </description>
  </property>

</configuration>






sqoop任务失败
AttemptID:attempt_1665929783632_1107_m_000000_1 Timed out after 600 secs Container killed by the ApplicationMaster.
Container killed on request. Exit code is 143 Container exited with a non-zero exit code 143

maptask 超时问题 Timed out after 600 secs


导致该问题出现的原因
处理程序存在死循环
网络问题 丢包导致
map 堆内存不够 full gc

map 堆内存不够导致的异常










hadoop 节点数据均衡

hdfs dfsadmin -setBalancerBandwidth 104857600  -- 临时设置迁移的速度
start-balancer.sh -threshold 2 -- 设置差异的负载因子

linux 清除错误输出 Ctrl + Backspace

core-site.xml 
# -- 指定ha模式下访问hdfs的命名空间
        <property>
            <name>fs.defaultFS</name>
            <value>hdfs://mycluster</value>
        </property>

# -- 设置垃圾回收，误删除操作的文件在指定的文件内可以找回，单位是分钟
    <property>
        <name>fs.trash.interval</name>
        <value>1440</value>
    </property>
    <property>
        <name>fs.trash.checkpoint.interval</name>
        <value>1440</value>
    </property>

# -- 数据存放目录
# 这个目录下  /dfs/name -- 存放edits_0000000000......文件,fsimage_0000000000........文件  /dfs/data  /data/program/hadoop-2.7.2/data/tmp/dfs/data/current/BP-2101474534-10.10.80.31-1605179824423/current/finalized/subdir99 --当前数据情况
    <property>
    <name>hadoop.tmp.dir</name>
    <value>/data/program/hadoop-2.7.2/data/tmp</value> 
    </property>


# -- datanode指定数据存放目录
<property>
    <name>dfs.datanode.data.dir</name>
    <value>file:///dfs/data1,file:///hd2/dfs/data2,file:///hd3/dfs/data3,file:///hd4/dfs/data4</value>
</property>

yarn的资源调度器

1）先进先出调度器（FIFO）
　　FIFO是Hadoop中默认的调度器，也是一种批处理调度器。它先按照作业的优先级高低，再按照到达时间的先后选择被执行的作业。

2）容量调度器（Capacity Scheduler），需要配置多队列
支持多个队列，每个队列可配置一定的资源量，每个队列采用FIFO调度策略，为了防止同一个用户的作业独占队列中的资源，该调度器会对同一用户提交的作业所占资源量进行限定。调度时，首先按以下策略选择一个合适队列：计算每个队列中正在运行的任务数与其应该分得的计算资源之间的比值，选择一个该比值最小的队列；然后按以下策略选择该队列中一个作业：按照作业优先级和提交时间顺序选择，同时考虑用户资源量限制和内存限制

3）公平调度器（Fair Scheduler）
同计算能力调度器类似，支持多队列多用户，每个队列中的资源量可以配置，同一队列中的作业公平共享队列中所有资源



2）工作机制详解

（0）Mr程序提交到客户端所在的节点
（1）Yarnrunner向Resourcemanager申请一个Application。
（2）rm将该应用程序的资源路径返回给yarnrunner
（3）该程序将运行所需资源提交到HDFS上
（4）程序资源提交完毕后，申请运行mrAppMaster
（5）RM将用户的请求初始化成一个task
（6）其中一个NodeManager领取到task任务。
（7）该NodeManager创建容器Container，并产生MRAppmaster
（8）Container从HDFS上拷贝资源到本地
（9）MRAppmaster向RM 申请运行maptask容器
（10）RM将运行maptask任务分配给另外两个NodeManager，另两个NodeManager分别领取任务并创建容器。
（11）MR向两个接收到任务的NodeManager发送程序启动脚本，这两个NodeManager分别启动maptask，maptask对数据分区排序。
（12）MRAppmaster向RM申请2个容器，运行reduce task。
（13）reduce task向maptask获取相应分区的数据。
（14）程序运行完毕后，MR会向RM注销自己。



5）作业提交详解

（1）作业提交
client调用job.waitForCompletion方法，向整个集群提交MapReduce作业 (第1步) 。 
新的作业ID(应用ID)由资源管理器分配(第2步)。
作业的client核实作业的输出, 计算输入的split, 将作业的资源(包括Jar包, 配置文件, split信息)拷贝给HDFS(第3步)。
最后, 通过调用资源管理器的submitApplication()来提交作业(第4步)。

（2）作业初始化
当资源管理器收到submitApplciation()的请求时, 就将该请求发给调度器(scheduler), 调度器分配container, 然后资源管理器在该container内启动应用管理器进程, 由节点管理器监控(第5步)。
MapReduce作业的应用管理器是一个主类为MRAppMaster的Java应用。其通过创造一些bookkeeping对象来监控作业的进度, 得到任务的进度和完成报告(第6步)。然后其通过分布式文件系统得到由客户端计算好的输入split(第7步)。
然后为每个输入split创建一个map任务, 根据mapreduce.job.reduces创建reduce任务对象。

（3）任务分配
如果作业很小, 应用管理器会选择在其自己的JVM中运行任务。
如果不是小作业, 那么应用管理器向资源管理器请求container来运行所有的map和reduce任务(第8步)。这些请求是通过心跳来传输的, 包括每个map任务的数据位置, 比如存放输入split的主机名和机架(rack)。调度器利用这些信息来调度任务, 尽量将任务分配给存储数据的节点, 或者分配给和存放输入split的节点相同机架的节点。

（4）任务运行
当一个任务由资源管理器的调度器分配给一个container后, 应用管理器通过联系节点管理器来启动container(第9步)。任务由一个主类为YarnChild的Java应用执行。在运行任务之前首先本地化任务需要的资源, 比如作业配置, JAR文件, 以及分布式缓存的所有文件(第10步)。最后, 运行map或reduce任务(第11步)。
YarnChild运行在一个专用的JVM中, 但是YARN不支持JVM重用。

（5）进度和状态更新
YARN中的任务将其进度和状态(包括counter)返回给应用管理器, 客户端每秒(通过mapreduce.client.progressmonitor.pollinterval设置)向应用管理器请求进度更新, 展示给用户。
（6）作业完成
除了向应用管理器请求作业进度外, 客户端每5分钟都会通过调用waitForCompletion()来检查作业是否完成。时间间隔可以通过mapreduce.client.completion.pollinterval来设置。作业完成之后, 应用管理器和container会清理工作状态, OutputCommiter的作业清理方法也会被调用。作业的信息会被作业历史服务器存储以备之后用户核查。
八、任务的推测执行
1）作业完成时间取决于最慢的任务完成时间
一个作业由若干个Map任务和Reduce任务构成。因硬件老化、软件Bug等，某些任务可能运行非常慢。
典型案例：系统中有99%的Map任务都完成了，只有少数几个Map老是进度很慢，完不成，怎么办？
2）推测执行机制：
发现拖后腿的任务，比如某个任务运行速度远慢于任务平均速度。为拖后腿任务启动一个备份任务，同时运行。谁先运行完，则采用谁的结果。
3）执行推测任务的前提条件
（1）每个task只能有一个备份任务；
（2）当前job已完成的task必须不小于0.05（5%）
（3）开启推测执行参数设置。Hadoop2.7.2 mapred-site.xml文件中默认是打开的。
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
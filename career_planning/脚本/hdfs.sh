 1、 -- 节点数据均衡 
# -- 提高迁移速度
hdfs dfsadmin -setBalancerBandwidth 104857600
# -- 执行均衡  最后面的参数，要计算各个节点的数据存储的差异是否达标,只有大于参数才会执行，低于参数不会执行
start-balancer.sh -threshold 1

# 2、-- hdfs ha模式 需要安装启动 先zk,apache集群,需要写定时启动的脚本，确保集群的稳定
  -- 写脚本,然后定时执行

	*/60  * * * * source ~/.bash_profile;/bin/sh /data/program/hadoop-2.7.2/bin/process.sh
	*/60  * * * * source ~/.bash_profile;/bin/sh /data/program/hadoop-2.7.2/bin/namenode.sh
	*/60  * * * * source ~/.bash_profile;/bin/sh /data/program/hadoop-2.7.2/bin/resourcemanager.sh


	# -- zkfc.sh  判断zkfc的进程
	#!/bin/bash
	ps -ef |grep DFSZKFailoverController|grep -v grep|awk -F " " '{print$2}'
	if [ $? -ne 0 ]
	then
	echo "ZKFC进程在运行中....."
	else
	/data/program/hadoop-2.7.2/sbin/hadoop-daemon.sh  start zkfc
	fi

	# -- namenode.sh 判断namenode的进程

	#!/bin/bash
	ps -ef |grep NameNode|grep -v grep|awk -F " " '{print$2}'
	if [ $? -ne 0 ]
	then
	echo "namenode进程在运行中....."
	else
	/data/program/hadoop-2.7.2/sbin/hadoop-daemon.sh  start namenode
	fi

	-- resourcemanager 判断resourcemanager进程

	#!/bin/bash
	ps -ef |grep ResourceManager|grep -v grep|awk -F " " '{print$2}'
	if [ $? -ne 0 ]
	then
	echo "ResourceManager进程在运行中....."
	else
	/data/program/hadoop-2.7.2/sbin/yarn-daemon.sh start resourcemanager
	fi

 






-- 获取mysql 增量数据 

canal

maxwell

flinkcdc

dbziemn


读取mysql-binlog 

权限需要：
	flinkcdc 需要的权限：
						SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT 



同步工具：
		CloudCanal




修改副本数量 (不建议)

hdfs dfs -setrep -w 2 -R /tmp/hive/root/af3e81c8-c785-48c8-8ef5-ce7710eaa25d/

副本修复(建议)
hdfs debug recoverLease -path /tmp/hive/root/4e9a3f68-7e61-4383-923b-5077098cebf5/hive_2022-03-21_15-12-15_894_502023812735813800-1/-mr-10004/4a331e12-7741-4485-af71-8c355d84093f/map.xml  -retries 2



hdfs debug recoverLease -path /tmp/hive/root/4e9a3f68-7e61-4383-923b-5077098cebf5/hive_2022-03-21_15-12-15_894_502023812735813800-1/-mr-10004/4a331e12-7741-4485-af71-8c355d84093f/reduce.xml  -retries 2 



查看异常的块 
			hdfs fsck / -files -blocks -locations | grep Under 




hadoop 机架感知

缺省(概念) ：系统默认状态
		

	      缺省情况下，hadoop的replication为3，3个副本的存放策略为：
							      	第一个block副本放在和client所在的datanode里。
									第二个副本放置在与第一个节点不同的机架中的datanode中（随机选择）。 
									第三个副本放置在与第二个副本所在节点同一机架的另一个节点上。
									当然，这个随机也不是真的随机，而是考虑了负载均衡的随机。多实验几次后，可以发现还是优先考虑负载较少的datanode写数据。


改变，永远不嫌晚，无论你是几岁，也无论你目前所处的境况有多糟，只要立定目标、一步一步往前走，人生随时都有翻盘的可能性。
- ------------------

实时项目
	业务数据
	行为数据
离线项目
	业务数据
	行为数据
	爬虫数据



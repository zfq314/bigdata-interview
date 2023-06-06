设置副本个数
  hadoop fs -setrep -R 2 /

core-site.xml
# 开启垃圾回收，如果误删可以找回数据
   <property>
        <name>fs.trash.interval</name>
        <value>1440</value>
    </property>
    <property>
        <name>fs.trash.checkpoint.interval</name>
        <value>1440</value>
    </property>

hdfs-site.xml

大数据节点均衡数据
设置迁移的速度
hdfs dfsadmin -setBalancerBandwidth 104857600

设置负载因子
start-balancer.sh -threshold 1

查看节点状态

 hdfs dfsadmin -report
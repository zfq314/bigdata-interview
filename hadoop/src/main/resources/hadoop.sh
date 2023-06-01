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

hdfs-site.xm
    连接hadoop
-- 检查各个端口
netstat -aplnt |grep java 

-- 检查mysql是否启动成功
ps -aux|grep mysql 
netstat -aplnt|grep 3306

-- 安装hive 
-- 先将文件上传
tar -zxvf hive.tar.gz
-- 目录改名

mv hive-xx-bin hive

# 进入配置文件目录
cd /opt/soft/hive3/conf

# 复制配置文件
cp hive-env.sh.template  hive-env.sh
cp hive-default.xml.template  hive-site.xml
# 编辑环境配置文件
vim hive-env.sh
# 编辑配置文件
vim hive-site.xml

hive-site.xml 
- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
<configuration>
    <!-- 记录HIve中的元数据信息  记录在mysql中 -->
    <property>
        <name>javax.jdo.option.ConnectionURL</name>
        <value>jdbc:mysql://spark03:3306/hive?useUnicode=true&amp;createDatabaseIfNotExist=true&amp;characterEncoding=UTF8&amp;useSSL=false&amp;serverTimeZone=Asia/Shanghai</value>
    </property>
 
    <!-- jdbc mysql驱动 -->
    <property>
        <name>javax.jdo.option.ConnectionDriverName</name>
        <value>com.mysql.cj.jdbc.Driver</value>
    </property>
 
    <!-- mysql的用户名和密码 -->
    <property>
        <name>javax.jdo.option.ConnectionUserName</name>
        <value>root</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionPassword</name>
        <value>Lihaozhe!!@@1122</value>
    </property>
 
    <property>
        <name>hive.metastore.warehouse.dir</name>
        <value>/user/hive/warehouse</value>
    </property>
 
    <property>
        <name>hive.exec.scratchdir</name>
        <value>/user/hive/tmp</value>
    </property>
    
    </property>
 
    <property>
        <name>hive.exec.local.scratchdir</name>
        <value>/user/hive/local</value>
        <description>Local scratch space for Hive jobs</description>
    </property>
 
    <property>
        <name>hive.downloaded.resources.dir</name>
        <value>/user/hive/resources</value>
        <description>Temporary local directory for added resources in the remote file system.</description>
    </property>
 
    <!-- 日志目录 -->
    <property>
        <name>hive.querylog.location</name>
        <value>/user/hive/log</value>
    </property>
 
    <!-- 设置metastore的节点信息 -->
    <property>
        <name>hive.metastore.uris</name>
        <value>thrift://spark01:9083</value>
    </property>
 
    <!-- 客户端远程连接的端口 -->
    <property> 
        <name>hive.server2.thrift.port</name> 
        <value>10000</value>
    </property>
    <property> 
        <name>hive.server2.thrift.bind.host</name> 
        <value>0.0.0.0</value>
    </property>
    <property>
        <name>hive.server2.webui.host</name>
        <value>0.0.0.0</value>
    </property>
 
    <!-- hive服务的页面的端口 -->
    <property>
        <name>hive.server2.webui.port</name>
        <value>10002</value>
    </property>
 
    <property> 
        <name>hive.server2.long.polling.timeout</name> 
        <value>5000</value>                               
    </property>
 
    <property>
        <name>hive.server2.enable.doAs</name>
        <value>true</value>
    </property>
    <!--
<property>
<name>datanucleus.autoCreateSchema</name>
<value>false</value>
</property>
 
<property>
<name>datanucleus.fixedDatastore</name>
<value>true</value>
</property>
-->
    <property>
        <name>hive.execution.engine</name>
        <value>mr</value>
    </property>
    <property>
        <name>hive.metastore.schema.verification</name>
        <value>false</value>
        <description>
          Enforce metastore schema version consistency.
          True: Verify that version information stored in is compatible with one from Hive jars.  Also disable automatic
                schema migration attempt. Users are required to manually migrate schema after Hive upgrade which ensures
                proper metastore schema migration. (Default)
         </description>
      </property>
</configuration>
- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

初始化hive的元数据库


schematool -initSchema -dbType  mysql


远程模式

# 启动服务端
hive --service metastore &
hive --service hiveserver2 &
 
# 后台运行
nohup hive --service metastore > /dev/null 2>&1 &
nohup hive --service hiveserver2 > /dev/null 2>&1 &
 
hiveserver2 start
nohup hiveserver2 >/dev/null 2>&1 &

# 客户端连接
hive
beeline -u jdbc:hive2://spark01:10000 -n root
beeline jdbc:hive2://spark01:10000> show databases;


create table person(id int,
    phonenum bigint,
    salary double,
    name string
);

1	、 什么叫hive 
	hive是一个构建在Hadoop上的数据仓库工具(框架)。
	可以将结构化的数据文件映射成一张数据表，并可以使用类sql的方式来对这样的数据文件进行读，写以及管理（包括元数据）。
	这套HIVE SQL 简称HQL。hive的执行引擎可以是MR、spark、tez

	Hive的本质是将HQL转换成MapReduce任务，完成整个数据的分析查询，减少编写MapReduce的复杂度

	原理：

	用户提交查询等任务给Driver。
	驱动程序将Hql发送编译器，检查语法和生成查询计划。
	编译器Compiler根据用户任务去MetaStore中获取需要的Hive的元数据信息。
	编译器Compiler得到元数据信息，对任务进行编译，先将HiveQL转换为抽象语法树，然后将抽象语法树 转换成查询块，将查询块转化为逻辑的查询计划，重写逻辑查询计划，将逻辑计划转化为物理的计划 （MapReduce）, 最后选择最佳的策略。
	将最终的计划提交给Driver。到此为止，查询解析和编译完成。
	Driver将计划Plan转交给ExecutionEngine去执行。
	在内部，执行作业的过程是一个MapReduce工作。执行引擎发送作业给JobTracker，在名称节点并把它 分配作业到TaskTracker，这是在数据节点。在这里，查询执行MapReduce工作。
	与此同时,在执行时,执行引擎可以通过Metastore执行元数据操作。


	执行引擎接收来自数据节点的结果。
	执行引擎发送这些结果值给驱动程序。
	驱动程序将结果发送给Hive接口。
	
	hive本身其实没有多少功能，hive就相当于在hadoop上面包了一个壳子，就是对hadoop进行了一次封 装。
    hive的存储是基于hdfs/hbase的，hive的计算是基于mapreduce。



2	、内部表 外部表 
	  内部表，删除元数据-原始数据 自己使用
	  外部表  删除元数据 大部分都是外部表




3	、 刷题网址
	http://forum.atguigu.cn/interview.html




4	、 hive-site.xml
	<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<configuration>
    <!-- jdbc连接的URL -->
    <property>
        <name>javax.jdo.option.ConnectionURL</name>
        <value>jdbc:mysql://hadoop102:3306/metastore?useSSL=false</value>
    </property>
    
    <!-- jdbc连接的Driver-->
    <property>
        <name>javax.jdo.option.ConnectionDriverName</name>
        <value>com.mysql.jdbc.Driver</value>
    </property>
    
	<!-- jdbc连接的username-->
    <property>
        <name>javax.jdo.option.ConnectionUserName</name>
        <value>root</value>
    </property>

    <!-- jdbc连接的password -->
    <property>
        <name>javax.jdo.option.ConnectionPassword</name>
        <value>123456</value>
    </property>

    <!-- Hive默认在HDFS的工作目录 -->
    <property>
        <name>hive.metastore.warehouse.dir</name>
        <value>/user/hive/warehouse</value>
    </property>

    <!-- 指定hiveserver2连接的host -->
<property>
	<name>hive.server2.thrift.bind.host</name>
	<value>hadoop102</value>
</property>

<!-- 指定hiveserver2连接的端口号 -->
<property>
	<name>hive.server2.thrift.port</name>
	<value>10000</value>
</property>

</configuration>




5	、元数据初始化
	schematool -dbType mysql -initSchema -verbose



6	、hive相关服务脚本

			#!/bin/bash

			HIVE_LOG_DIR=$HIVE_HOME/logs
			if [ ! -d $HIVE_LOG_DIR ]
			then
				mkdir -p $HIVE_LOG_DIR
			fi

			#检查进程是否运行正常，参数1为进程名，参数2为进程端口
			function check_process()
			{
			    pid=$(ps -ef 2>/dev/null | grep -v grep | grep -i $1 | awk '{print $2}')
			    ppid=$(netstat -nltp 2>/dev/null | grep $2 | awk '{print $7}' | cut -d '/' -f 1)
			    echo $pid
			    [[ "$pid" =~ "$ppid" ]] && [ "$ppid" ] && return 0 || return 1
			}

			function hive_start()
			{
			    metapid=$(check_process HiveMetastore 9083)
			    cmd="nohup hive --service metastore >$HIVE_LOG_DIR/metastore.log 2>&1 &"
			    [ -z "$metapid" ] && eval $cmd || echo "Metastroe服务已启动"
			    server2pid=$(check_process HiveServer2 10000)
			    cmd="nohup hive --service hiveserver2 >$HIVE_LOG_DIR/hiveServer2.log 2>&1 &"
			    [ -z "$server2pid" ] && eval $cmd || echo "HiveServer2服务已启动"
			}

			function hive_stop()
			{
			metapid=$(check_process HiveMetastore 9083)
			    [ "$metapid" ] && kill $metapid || echo "Metastore服务未启动"
			    server2pid=$(check_process HiveServer2 10000)
			    [ "$server2pid" ] && kill $server2pid || echo "HiveServer2服务未启动"
			}

			case $1 in
			"start")
			    hive_start
			    ;;
			"stop")
			    hive_stop
			    ;;
			"restart")
			    hive_stop
			    sleep 2
			    hive_start
			    ;;
			"status")
			    check_process HiveMetastore 9083 >/dev/null && echo "Metastore服务运行正常" || echo "Metastore服务运行异常"
			    check_process HiveServer2 10000 >/dev/null && echo "HiveServer2服务运行正常" || echo "HiveServer2服务运行异常"
			    ;;
			*)
			    echo Invalid Args!
			    echo 'Usage: '$(basename $0)' start|stop|restart|status'
			    ;;
			esac




7	、 hive -e "select * from mst;" 
      hive -f "目录/文件"
      参数获取 set 
      设置参数 set mapreduce.job.reduces=10;
      获取参数 set mapreduce.job.reduces；
      配置文件 < 命令行参数 < 参数声明
      在yarn-site.xml中关闭虚拟内存检查（虚拟内存校验，如果已经关闭了，就不需要配了）。
		    <property>
		    <name>yarn.nodemanager.vmem-check-enabled</name>
		    <value>false</value>
		   </property> 

		（1）删除空数据库
		hive> drop database db_hive2;
		（2）删除非空数据库
		hive> drop database db_hive3 cascade;


8	、 建表
		CREATE [TEMPORARY] [EXTERNAL] TABLE [IF NOT EXISTS] [db_name.]table_name
		[LIKE exist_table_name]
		[ROW FORMAT row_format] 
		[STORED AS file_format] 
		[LOCATION hdfs_path]
		[TBLPROPERTIES (property_name=property_value, ...)]


		数据装载
		LOAD DATA [LOCAL] INPATH 'filepath' [OVERWRITE] INTO TABLE tablename [PARTITION (partcol1=val1, partcol2=val2 ...)];



9	、 基本查询
 		SELECT [ALL | DISTINCT] select_expr, select_expr, ...
		FROM table_reference       -- 从什么表查
		[WHERE where_condition]   -- 过滤
		[GROUP BY col_list]        -- 分组查询
   		[HAVING col_list]          -- 分组后过滤
		[ORDER BY col_list]        -- 排序
		[CLUSTER BY col_list
		| [DISTRIBUTE BY col_list] [SORT BY col_list]
		]
        [LIMIT number]                -- 限制输出的行数



10	、	
		计算emp表每个部门的平均工资  
		select 
		    t.deptno, 
		    avg(t.sal) avg_sal 
		from emp t 
		group by t.deptno;
		（2）计算emp每个部门中每个岗位的最高薪水。
		select 
			    t.deptno, 
			    t.job, 
			    max(t.sal) max_sal 
		from emp t 
		group by t.deptno, t.job;
		1）having与where不同点
	（1）where后面不能写分组聚合函数，而having后面可以使用分组聚合函数。
	（2）having只用于group by分组统计语句。

	（1）求每个部门的平均薪水大于2000的部门

			select 
				    deptno, 
				    avg(sal) avg_sal 
			from emp 
			group by deptno  
			having avg_sal > 2000;

		内连接：只有进行连接的两个表中都存在与连接条件相匹配的数据才会被保留下来。
		左外连接：join操作符左边表中符合where子句的所有记录将会被返回。
		右外连接：join操作符右边表中符合where子句的所有记录将会被返回。
		满外连接：将会返回所有表中符合where语句条件的所有记录。如果任一表的指定字段没有符合条件的值的话，那么就使用null值替代。

		union和union all都是上下拼接sql的结果，这点是和join有区别的，join是左右关联，union和union all是上下拼接。union去重，union all不去重。
		union和union all在上下拼接sql结果时有两个要求：
		（1）两个sql的结果，列的个数必须相同
		（2）两个sql的结果，上下所对应列的类型必须一致	

		Order By：全局排序，只有一个Reduce。
		Sort By：对于大规模的数据集order by的效率非常低。在很多情况下，并不需要全局排序，此时可以使用Sort by。
		Sort by为每个reduce产生一个排序文件。每个Reduce内部进行排序，对全局结果集来说不是排序。

		Distribute By：在有些情况下，我们需要控制某个特定行应该到哪个Reducer，通常是为了进行后续的聚集操作。distribute by子句可以做这件事。distribute by类似MapReduce中partition（自定义分区），进行分区，结合sort by使用。 
	    distribute by的分区规则是根据分区字段的hash码与reduce的个数进行相除后，余数相同的分到一个区。
		Hive要求distribute by语句要写在sort by语句之前。
		演示完以后mapreduce.job.reduces的值要设置回-1，否则下面分区or分桶表load跑MapReduce的时候会报错。

		分区排序（Cluster By）
		当distribute by和sort by字段相同时，可以使用cluster by方式。
		cluster by除了具有distribute by的功能外还兼具sort by的功能。但是排序只能是升序排序，不能指定排序规则为asc或者desc。
		等价
			select 
			    * 
			from emp 
			cluster by deptno;

			===================
			 
			select 
			    * 
			from emp 
			distribute by deptno 
			sort by deptno;

			查看系统函数
			show functions;

			查看函数详细信息
			desc function extended upper;

			substring：截取字符串
			（1）获取第二个字符以后的所有字符
 			 select substring("zfqdeeee",2);
 			 获取倒数第三个字符以后的所有字符
			 select substring("zfqdeeee",-3);

			 从第3个字符开始，向后获取2个字符
			  select substring("zfqdeeee",3,2);

			replace ：替换
			语法：replace(string A, string B, string C) 
			返回值：string
			说明：将字符串A中的子字符串B替换为C。

			regexp_replace(string A, string B, string C) 

			repeat：重复字符串

			split ：字符串切割 语法：split(string str, string pat) 

			nvl ：替换null值 语法：nvl(A,B) 

			concat ：拼接字符串 语法：concat(string A, string B, string C, ……) 

			concat_ws：以指定分隔符拼接字符串或者字符串数组 	语法：concat_ws(string A, string…| array(string)) 

			get_json_object：解析json字符串 语法：get_json_object(string json_string, string path) 


			from_unixtime：转化UNIX时间戳（从 1970-01-01 00:00:00 UTC 到指定时间的秒数）到当前时区的时间格式
			current_date：当前日期     
			current_timestamp：当前的日期加时间，并且精确的毫秒 
			month：获取日期中的月
			day：获取日期中的日
			hour：获取日期中的小时
			datediff：两个日期相差的天数（结束日期减去开始日期的天数）
			date_add：日期加天数
			date_sub：日期减天数
			date_format:将标准日期解析成指定格式字符串 select date_format('2022-08-08','yyyy年-MM月-dd日') 

			流程控制函数

			case when：条件判断函数 语法一：case when a then b [when c then d]* [else e] end
		    if: 条件判断，类似于Java中三元运算符 语法：if（boolean testCondition, T valueTrue, T valueFalseOrNull）

		    集合
		    size：集合中元素的个数
		    map：创建map集合
		    map_keys： 返回map中的key
		    map_values: 返回map中的value

		    array_contains: 判断array中是否包含某个元素
		    sort_array：将array中的元素排序

		    -- 根据月份正负决定年龄

			select
			  name,
			  concat(if(month>=0,year,year-1),'年',if(month>=0,month,12+month),'月') age
			from
			  (
			    select
			      name,
			      year(current_date())-year(t1.birthday) year,
			      month(current_date())-month(t1.birthday) month
			    from
			      (
			        select
			          name,
			          replace(birthday,'/','-') birthday
			        from
			          employee
			    )t1
			)t2 

	collect_set 收集并形成set集合，结果去重
	collect_list 收集并形成list集合，结果不去重

			每个月的入职人数以及姓名
			select
				  month(replace(hiredate,'/','-')) as month,
				  count(*) as cn,
				  Collect_list(name) as name_list
			from
			  employee
			group by
			  month(replace(hiredate,'/','-'))


	select
    cate,
    count(*)
from
(
    select
        movie,
        cate
    from
    (
        select
            movie,
            split(category,',') cates
        from movie_info
    )t1 lateral view explode(cates) tmp as cate
)t2
group by cate;	


		1）数值函数
		（1）round：四舍五入；（2）ceil：向上取整；（3）floor：向下取整
		2）字符串函数
		（1）substring：截取字符串；（2）replace：替换；（3）regexp_replace：正则替换
		（4）regexp：正则匹配；（5）repeat：重复字符串；（6）split：字符串切割
		（7）nvl：替换null值；（8）concat：拼接字符串；
		（9）concat_ws：以指定分隔符拼接字符串或者字符串数组；
		（10）get_json_object：解析JSON字符串
		3）日期函数
		（1）unix_timestamp：返回当前或指定时间的时间戳
		（2）from_unixtime：转化UNIX时间戳（从 1970-01-01 00:00:00 UTC 到指定时间的秒数）到当前时区的时间格式
		（3）current_date：当前日期
		（4）current_timestamp：当前的日期加时间，并且精确的毫秒
		（5）month：获取日期中的月；（6）day：获取日期中的日
		（7）datediff：两个日期相差的天数（结束日期减去开始日期的天数）
		（8）date_add：日期加天数；（9）date_sub：日期减天数
		（10）date_format：将标准日期解析成指定格式字符串
		4）流程控制函数
		（1）case when：条件判断函数
		（2）if：条件判断，类似于Java中三元运算符
		5）集合函数
		（1）array：声明array集合
		（2）map：创建map集合
		（3）named_struct：声明struct的属性和值
		（4）size：集合中元素的个数
		（5）map_keys：返回map中的key
		（6）map_values：返回map中的value
		（7）array_contains：判断array中是否包含某个元素
		（8）sort_array：将array中的元素排序
		6）聚合函数
		（1）collect_list：收集并形成list集合，结果不去重
		（2）collect_set：收集并形成set集合，结果去重
		1.6.6 自定义UDF、UDTF函数
		1）在项目中是否自定义过UDF、UDTF函数，以及用他们处理了什么问题，及自定义步骤？
		（1）目前项目中逻辑不是特别复杂就没有用自定义UDF和UDTF
		（2）自定义UDF：继承G..UDF，重写核心方法evaluate
			（3）自定义UDTF：继承自GenericUDTF，重写3个方法：initialize（自定义输出的列名和类型），process（将结果返回forward（result）），close
		2）企业中一般什么场景下使用UDF/UDTF？
		（1）因为自定义函数，可以将自定函数内部任意计算过程打印输出，方便调试。
		（2）引入第三方jar包时，也需要。
		1.6.7 窗口函数
		一般在场景题中出现手写：分组TopN、行转列、列转行。	

		聚合函数 max min sum avg count
		跨行函数 lead lag 
		first_value和last_value
		rank 、1 2 3 3 5 6 7
		dense_rank、1 2 3 4 4 5 6
		row_number 1 2 3 4 5 6 7
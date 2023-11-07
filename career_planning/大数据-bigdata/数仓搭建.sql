-- 省市区数据库.sql 下面link
-- https://github.com/leoparddne/Areas/blob/master/%E7%9C%81%E5%B8%82%E5%8C%BA%E6%95%B0%E6%8D%AE%E5%BA%93.sql

-- 统计这些表是视图的

select  table_name from information_schema.tables where table_schema = 'decent_cloud'  and table_name    in (
 select  table_name from information_schema.tables where table_schema = 'decent_cloud'  and table_name
not in (select table_name from information_schema.tables where table_schema = 'decent_cloud' and table_rows <>0) 
 ) 
and table_name not in (select table_name from information_schema.tables where table_schema = 'decent_cloud'  and table_rows=0 )
;

-- 表中有实际有数据的表
select table_name from information_schema.tables where table_schema = 'decent_cloud'  and table_rows<>0

-- githup检索技巧 in:name flink stars:>1000 language:scala



1、根据star，fork数筛选
    1, 大于等于
      语法： 关键字 stars:>= 数量 forks:>=数量 
      例子： springboot stars:>=5000 //搜索springboot有关star数>=5000的内容
            springboot stars:>=5000 forks:>=5000//搜索springboot 的star>=5000，且fork数>=5000的内容
        可单独搜索，也可组合搜索，中间用空格隔开，是&（且）的关系。

    2，范围查询
      语法： 关键字 stars:范围1..范围2
      例子： springboot stars:4000..5000 
        //搜索star数在 4000到500的springboot相关内容，..相当于mysql中between and 的作用。    

2、 关键字 in        
    
    搜索关键字在github上发布的位置 ，主要以下3个位置
    name （发布的仓库名称）
    description（指的是文章的摘要部分）
    Readme (说明文档)
    语法 ：关键字 in:
    例子 ：netty in:name //查找名称中包含netty的内容
          netty in:name,description
          //逗号分隔，是 || (或)的关系，指的是查询名称，或者描述中包含netty的内容

3、awesome + 关键字
一般是指的学习，书籍，工具类，插件类相关的系列的集合。可以有效节约时间，找到别人收集好的内容。

awesome 指的是了不起的，碉堡了。
awesome springboot

4、搜索某个语言，某个地区的大佬
例如： location:Beijing language:java           


5、user
查询某位用户的相关内容，比如某位大佬

语法：user:名称

例子：user:zfq314




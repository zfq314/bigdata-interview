-- 基础数据准备
-- 创建学生表
DROP TABLE IF EXISTS hivesql.student;
create table if not exists hivesql.student_info(
    stu_id string COMMENT '学生id',
    stu_name string COMMENT '学生姓名',
    birthday string COMMENT '出生日期',
    sex string COMMENT '性别'
) 
row format delimited fields terminated by ',' 
stored as textfile;

-- 创建课程表
DROP TABLE IF EXISTS hivesql.course;
create table if not exists hivesql.course_info(
    course_id string COMMENT '课程id',
    course_name string COMMENT '课程名',
    tea_id string COMMENT '任课老师id'
) 
row format delimited fields terminated by ',' 
stored as textfile;

-- 创建老师表
DROP TABLE IF EXISTS hivesql.teacher;
create table if not exists hivesql.teacher_info(
    tea_id string COMMENT '老师id',
    tea_name string COMMENT '老师姓名'
) 
row format delimited fields terminated by ',' 
stored as textfile;

-- 创建分数表
DROP TABLE IF EXISTS hivesql.score;
create table if not exists hivesql.score_info(
    stu_id string COMMENT '学生id',
    course_id string COMMENT '课程id',
    score int COMMENT '成绩'
) 
row format delimited fields terminated by ',' 
stored as textfile;


-- 数据 student_info.txt
001,彭于晏,1995-05-16,男
002,胡歌,1994-03-20,男
003,周杰伦,1995-04-30,男
004,刘德华,1998-08-28,男
005,唐国强,1993-09-10,男
006,陈道明,1992-11-12,男
007,陈坤,1999-04-09,男
008,吴京,1994-02-06,男
009,郭德纲,1992-12-05,男
010,于谦,1998-08-23,男
011,潘长江,1995-05-27,男
012,杨紫,1996-12-21,女
013,蒋欣,1997-11-08,女
014,赵丽颖,1990-01-09,女
015,刘亦菲,1993-01-14,女
016,周冬雨,1990-06-18,女
017,范冰冰,1992-07-04,女
018,李冰冰,1993-09-24,女
019,邓紫棋,1994-08-31,女
020,宋丹丹,1991-03-01,女


-- 数据 course_info.txt
01,语文,1003
02,数学,1001
03,英语,1004
04,体育,1002
05,音乐,1002



-- 数据 teacher_info.txt

1001,张高数
1002,李体音
1003,王子文
1004,刘丽英


--score_info.txt 
001,01,94
002,01,74
004,01,85
005,01,64
006,01,71
007,01,48
008,01,56
009,01,75
010,01,84
011,01,61
012,01,44
013,01,47
014,01,81
015,01,90
016,01,71
017,01,58
018,01,38
019,01,46
020,01,89
001,02,63
002,02,84
004,02,93
005,02,44
006,02,90
007,02,55
008,02,34
009,02,78
010,02,68
011,02,49
012,02,74
013,02,35
014,02,39
015,02,48
016,02,89
017,02,34
018,02,58
019,02,39
020,02,59
001,03,79
002,03,87
004,03,89
005,03,99
006,03,59
007,03,70
008,03,39
009,03,60
010,03,47
011,03,70
012,03,62
013,03,93
014,03,32
015,03,84
016,03,71
017,03,55
018,03,49
019,03,93
020,03,81
001,04,54
002,04,100
004,04,59
005,04,85
007,04,63
009,04,79
010,04,34
013,04,69
014,04,40
016,04,94
017,04,34
020,04,50
005,05,85
007,05,63
009,05,79
015,05,59
018,05,87


load data local inpath '/root/hive_data/student_info.txt' into table student_info;
load data local inpath '/root/hive_data/course_info.txt' into table course_info;
load data local inpath '/root/hive_data/teacher_info.txt' into table teacher_info
load data local inpath '/root/hive_data/score_info.txt' into table score_info;


-- hivesql的执行顺序  
1、from
2、join on 或 lateral view explode(需炸裂的列) tbl as 炸裂后的列名
3、where
4、group by （开始使用select中的别名，从group 开始往后都可用）
5、聚合函数 如Sum() avg() count(1)等
6、having
7、select 中若包含over（）开窗函数，执行完非开窗函数后select等待执行完开窗函数，然后执行select完，开窗函数通过表数据进行分区和排序，跟select查询中的字段是平行关系，不依赖查询字段。
8、distinct
9、order by
10、limit

-- 用count统计明细的行数
 select 
            -- a.showroom_counter_identity,
            IFNULL(SUM(b.net_weight),0) as jz,
            COUNT(1) as js,
            IFNULL(SUM(label_price),0) as bqje,
            IFNULL(SUM(label_price_discount),0) as dsje
from t_fast_package a 
inner join t_fast_package_i_product b on a.fast_package_identity=b.fast_package_identity
left join t_showroom_counter c on a.showroom_counter_identity=c.counter_identity
where DATE(create_date)= v_rq  and kdsj is null 
and c.counter_name=v_counter_name
group by a.showroom_counter_identity;


-- case when 要结合聚合函数使用

为什么要加聚合函数max（），min()等等，是因为分组函数导致的，跟case when没有很大关系，分组函数一定和聚合函数一同存在，要不然你想，比如上述数据，按照名字分组后，每个组内都有三个数据，而展示的时候就只展示一条，所以必须从中选择一条展示所以才出现了上述数据不完全正确状况，所以以后大家在使用分组函数时一定要使用聚合函数SQL分组和聚合
 

查询姓名中带“冰”的学生名单

select 
     *
from student_info
where stu_name like '%冰%';


查询姓“王”老师的个数

select 
     count(*)
from teacher_info
where tea_name like '王%';


检索课程编号为“04”且分数小于60的学生的课程信息，结果按分数降序排列


select 
    *
from score_info
where course_id='04' and score<60
order by score desc
;

查询数学成绩不及格的学生和其对应的成绩，按照学号升序排序

select
    s.stu_id,
    stu_name,
    score
from score_info s 
left join course_info c on s.course_id=c.course_id
left join student_info stu on s.stu_id=stu.stu_id
where course_name='数学' and score<60
order by s.stu_id 
;





查询编号为“02”的课程的总成绩

select
    course_id,
    sum(score) as totalScore
from score_info
where course_id='02'
group by course_id
;



查询参加考试的学生个数

select
    count(DISTINCT stu_id) as cnt
from score_info
;


查询各科成绩最高和最低的分，以如下的形式显示：课程号，最高分，最低分

select
    course_id,
    max(score) as maxScore,
    min(score) as minScore
from score_info 
group by course_id;


查询每门课程有多少学生参加了考试（有考试成绩）

select
     course_id,
     count(DISTINCT stu_id) as cnt 
from score_info
group by course_id 
;


查询男生、女生人数

select
     sex,
     count(*) as cnt 
from student_info
group by sex;


查询平均成绩大于60分的学生的学号和平均成绩


select
     stu_id,
     avg(score) as avgScore
from score_info
group by stu_id
having avg(score)>60;


查询至少选修四门课程的学生学号
select 
      stu_id
from score_info
group by stu_id
having count(course_id)>=4;


查询同姓（假设每个学生姓名的第一个字为姓）的学生名单并统计同姓人数大于2的姓

select
     firstName,
     count(firstName) as cnt
from(
    select
      stu_id,
      stu_name,
      substr(stu_name,0,1) as firstName
from student_info
)t
group by firstName
having cnt>=2
;


查询每门课程的平均成绩，结果按平均成绩升序排序，平均成绩相同时，按课程号降序排列

select
     course_id,
     avg(score) avg
from score_info
group by course_id
order by avg asc ,course_id desc
;


统计参加考试人数大于等于15的学科


select
      course_id,
      count(course_id) as cnt
from score_info
group by course_id
having count(course_id)>=15
;

查询学生的总成绩并按照总成绩降序排序

select 
     stu_id,
     sum(score) as sm
from score_info
group by stu_id
order by sm desc
;



按照如下格式显示学生的语文、数学、英语三科成绩，没有成绩的输出为0，按照学生的有效平均成绩降序显示

-- case when 
select
      stu_id,
      sum(case ci.course_name when '语文' then score  else 0 end) as chi,
      sum(case ci.course_name when '数学' then score  else 0 end) as mat,
      sum(case ci.course_name when '英语' then score  else 0 end) as eng,
      count(*) as cnt,
      avg(score) as avg
from course_info ci
left join score_info si on ci.course_id=si.course_id
group by stu_id
order by avg desc
;
-- 此处的max和上面的sum使用的效果是一样的
select
      stu_id,
      max(case ci.course_name when '语文' then score  else 0 end) as chi,
      max(case ci.course_name when '数学' then score  else 0 end) as mat,
      max(case ci.course_name when '英语' then score  else 0 end) as eng,
      count(*) as cnt,
      avg(score) as avg
from course_info ci
left join score_info si on ci.course_id=si.course_id
group by stu_id
order by avg desc
;

-- 此处不能用min
select
      stu_id,
      min(case ci.course_name when '语文' then score  else 0 end) as chi,
      min(case ci.course_name when '数学' then score  else 0 end) as mat,
      min(case ci.course_name when '英语' then score  else 0 end) as eng,
      count(*) as cnt,
      avg(score) as avg
from course_info ci
left join score_info si on ci.course_id=si.course_id
group by stu_id
order by avg desc
;




-- sum if 
select
      stu_id,
      sum(if(ci.course_name='语文',score,0)) as chi,
      sum(if(ci.course_name='数学',score,0)) as mat,
      sum(if(ci.course_name='英语',score,0)) as eng,
      count(*) as cnt,
      avg(score) as avg
from course_info ci
left join score_info si on ci.course_id=si.course_id
group by stu_id
order by avg desc
;


查询一共参加三门课程且其中一门为语文课程的学生的id和姓名
-- right join 
select 
     si.stu_id,
     si.stu_name
from student_info si right join
(select
    m.stu_id
    from (select
    stu_id,
    course_id
    from score_info s 
    where stu_id in (select stu_id from score_info where course_id='01')
    )m 
    group by stu_id
    having  count(m.course_id)=3
)t on si.stu_id=t.stu_id;

-- inner join 
select 
     si.stu_id,
     si.stu_name
from student_info si join
(select
    m.stu_id
    from (select
    stu_id,
    course_id
    from score_info s 
    where stu_id in (select stu_id from score_info  where course_id='01')
    )m 
    group by stu_id
    having  count(m.course_id)=3
)t on si.stu_id=t.stu_id;


-- left join  此场景不能用

select 
     si.stu_id,
     si.stu_name
from student_info si left join
(select
    m.stu_id
    from (select
    stu_id,
    course_id
    from score_info s 
    where stu_id in (select stu_id from score_info where course_id='01')
    )m 
    group by stu_id
    having  count(m.course_id)=3
)t on si.stu_id=t.stu_id;

查询所有课程成绩均小于60分的学生的学号、姓名

select 
    s.stu_id,
    s.stu_name,
    t.maxScore
from student_info s
join (
select
   stu_id,
   max(score) as maxScore
from score_info
group by stu_id
having maxScore<60
)t on s.stu_id=t.stu_id ;


查询没有学全所有课的学生的学号、姓名

-- hive 1.2.1  having不支持子查询，高版本可以
select 
    s.stu_id,
    s.stu_name
from student_info s
join (
 select
     stu_id,
     count(course_id) as cnt
from score_info
group by stu_id
having cnt<(select count(course_id) from course_info) -- 子查询 语法不通过
)t on s.stu_id=t.stu_id ;


 select 
    s.stu_id,
    s.stu_name
from student_info s
join (
 select
     stu_id,
     count(course_id) as cnt
from score_info
group by stu_id
having cnt<5 -- 写死 非子查询
)t on s.stu_id=t.stu_id ;


查询出只选修了三门课程的全部学生的学号和姓名


select 
     t.stu_id,
     si.stu_name
from (
select
    stu_id,
    count(course_id) as cnt
from score_info 
group by stu_id 
having cnt=3
)t left join student_info si on t.stu_id=si.stu_id;


查询有两门以上的课程不及格的同学的学号及其平均成绩
-- ---------------------------------------
select 
      stu_id,
      avg(score) as avg
 from score_info
where score < 60
group by stu_id
having count(course_id)>=2 
;
-- ---------------------------------------

select
    t1.stu_id,
    t2.avg_score
from (
    -- 根据条件找id 
         select
             stu_id,
             sum(if(score < 60,1,0)) flage
         from score_info
         group by stu_id
         having flage >= 2
) t1
join (
    -- 获取平均成绩
    select
        stu_id,
        avg(score) avg_score
    from score_info
    group by stu_id
) t2 on t1.stu_id = t2.stu_id;


询所有学生的学号、姓名、选课数、总成绩

select 
     s1.stu_id,
     stu_name,
     count(course_id) as cnt,
     sum(s2.score) as smn
from student_info s1 
left join score_info s2 on s1.stu_id=s2.stu_id
group by s1.stu_id,stu_name
;

查询平均成绩大于85的所有学生的学号、姓名和平均成绩

select 
    s1.stu_id,
    stu_name,
    avg(score) as avg 
from score_info s1 
left join student_info s2 on s1.stu_id=s2.stu_id
group by s1.stu_id,stu_name
having avg >85;


查询学生的选课情况：学号，姓名，课程号，课程名称

select 
      s1.stu_id,
      s2.stu_name,
      s1.course_id,
      s3.course_name
from score_info s1 
left join student_info s2 on s1.stu_id=s2.stu_id
left join course_info s3 on s1.course_id=s3.course_id

查询出每门课程的及格人数和不及格人数

select 
      t.course_id,
      c.course_name,
      good,
      bad
from course_info c 
join (
select 
      course_id,
      sum(if(score>=60,1,0)) as good,
      sum(if(score<60,1,0)) as bad
from score_info
group by course_id 
)t on t.course_id=c.course_id;


查询课程编号为03且课程成绩在80分以上的学生的学号和姓名及课程信息


select 
      s1.stu_id,
      s2.stu_name,
      s1.course_id,
      c.course_name
from score_info s1 
left join student_info s2 on s1.stu_id=s2.stu_id
left join course_info c on s1.course_id=c.course_id
where s1.course_id='03' and score>=80;


课程编号为"01"且课程分数小于60，按分数降序排列的学生信息

select 
     s2.*,
     score
from score_info  s1 
left join student_info s2 on s1.stu_id=s2.stu_id
where course_id='01' and score<60
order by score desc;


查询所有课程成绩在70分以上的学生的姓名、课程名称和分数，按分数升序排列



select
    s.stu_id,
    s.stu_name,
    c.course_name,
    s2.score
from student_info s
join(
select 
      stu_id,
      sum(if(score>=70,0,1)) as flag -- 这块容易出问题,注意
from score_info
group by stu_id
having flag=0
)t
on s.stu_id=t.stu_id
left join score_info s2 on s2.stu_id=s.stu_id
left join course_info c on c.course_id=s2.course_id
order by score asc;



 查询该学生不同课程的成绩相同的学生编号、课程编号、学生成绩---------------------------

Both left and right aliases encountered in JOIN 'course_id'
错误原因：两个表join的时候，不支持两个表的字段的 非相等 操作。

-- -------------------------------------------------------------------------------------------------------------------------------
 select
    sc1.stu_id,
    sc1.course_id,
    sc1.score
from score_info sc1 join score_info sc2 on sc1.stu_id = sc2.stu_id and sc1.course_id <> sc2.course_id and sc1.score = sc2.score;
-- -------------------------------------------------------------------------------------------------------------------------------


 select
    sc1.stu_id,
    sc1.course_id,
    sc1.score
from score_info sc1 join score_info sc2 on sc1.stu_id = sc2.stu_id where sc1.course_id <> sc2.course_id and sc1.score = sc2.score;

查询课程编号为“01”的课程比“02”的课程成绩高的所有学生的学号 多表连接 + 条件

select 
      m.stu_id
from (
      select
            stu_id,
            score
      from score_info   
      where course_id='01'
) m 
join (
      select
            stu_id,
            score
      from score_info   
      where course_id='02'
)n on m.stu_id=n.stu_id
 where m.score>n.score;



查询学过编号为“01”的课程并且也学过编号为“02”的课程的学生的学号、姓名

-- 这里不能用in，in是有问题的， 01 or 02 or 01-02
select 
      s.stu_id,
      s.stu_name
from student_info s
left join (
      select
      stu_id
from score_info
where course_id ='01'
and stu_id in (
          select
              stu_id
          from score_info sc2
          where sc2.course_id='02'
          )
)t on s.stu_id=t.stu_id;


 
查询学过“李体音”老师所教的所有课的同学的学号、姓名



select
    course_id
from course_info c 
join teacher_info s on s.tea_id=c.tea_id
where s.tea_name='李体音';

-- ------------------------------------------------------------------------------
select
      t.stu_id,
      s.stu_name
from (
select 
      stu_id
 from score_info 
where course_id in (
                    select
                        course_id
                    from course_info c 
                    join teacher_info s on s.tea_id=c.tea_id
                    where s.tea_name='李体音'
)
group by stu_id
having count(*)=(select -- 此语法不支持,建议通过变量传入参数
                        count(course_id)
                    from course_info c 
                    join teacher_info s on s.tea_id=c.tea_id 
                    where s.tea_name='李体音')
)t left join student_info s on t.stu_id=s.stu_id;
-- ------------------------------------------------------------------------------


select
      t.stu_id,
      s.stu_name
from (
select 
      stu_id
 from score_info 
where course_id in (
                    select
                        course_id
                    from course_info c 
                    join teacher_info s on s.tea_id=c.tea_id
                    where s.tea_name='李体音'
)
group by stu_id
having count(*)=2
)t left join student_info s on t.stu_id=s.stu_id;


查询学过“李体音”老师所讲授的任意一门课程的学生的学号、姓名


select
      t.stu_id,
      s.stu_name
from (
select 
      stu_id
 from score_info 
where course_id in (
                    select
                        course_id
                    from course_info c 
                    join teacher_info s on s.tea_id=c.tea_id
                    where s.tea_name='李体音')
        group by stu_id
)t left join student_info s on t.stu_id=s.stu_id;                    


查询没学过"李体音"老师讲授的任一门课程的学生姓名
-- not in 语法不通过  
-- 对于hive-sql里的子查询不支持not in或in ,目前测试，应该是一个hive语句里只能支持一个not in 或in语句，多了不支持，对not in的替换用 left join id(关联字段)is null ,in的替换用left join id is not null替换，或者用left semi join(更优化)


 
select
      stu_id,
      stu_name
from  student_info 
where stu_id not in(  -- hive 1.1版本支持in，但是不支持in的子查询。 Nested SubQuery 嵌套子查询
select 
      stu_id
 from score_info 
where course_id in(
                    select
                        course_id
                    from course_info c 
                    join teacher_info s on s.tea_id=c.tea_id
                    where s.tea_name='李体音')
        group by stu_id
);  


查询至少有一门课与学号为“001”的学生所学课程相同的学生的学号和姓名



select 
     si.stu_id,
     si.stu_name
from score_info sc
join student_info si on sc.stu_id=si.stu_id
where sc.course_id in 
(
select course_id from score_info where stu_id='001'  -- 筛选课程
) and sc.stu_id<>'001' -- 排查学号
group by si.stu_id,si.stu_name;

 
 按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩

select
    si.stu_name,
    ci.course_name,
    sc.score,
    t1.avg_score
from score_info sc
join student_info si on sc.stu_id=si.stu_id
join course_info ci on sc.course_id=ci.course_id
join
(
    select
        stu_id,
        avg(score) avg_score
    from score_info
    group by stu_id
)t1
on sc.stu_id=t1.stu_id
order by t1.avg_score desc;
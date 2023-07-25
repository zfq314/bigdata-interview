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
    tea_name string COMMENT '学生姓名'
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


from score_info 

group by course_id;
-- 查询订单明细表（order_detail）中销量（下单件数）排名第二的商品id，如果不存在返回null，如果存在多个排名第二的商品则需要全部返回。

订单明细表：order_detail

order_detail_id
(订单明细id)	order_id
(订单id)	sku_id
(商品id)	create_date
(下单日期)	price
(商品单价)	sku_num
(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5


select distinct sku_id from (
  select sku_id , sum_sku, rank() over(order by sum_sku desc) ord
  from (
    select sku_id,sum(sku_num) sum_sku
    from order_detail
    group by sku_id ) t1
  ) t2
where ord = 2;


--查询订单信息表(order_info)中最少连续3天下单的用户id，
订单信息表：order_info

order_id
(订单id)	user_id
(用户id)	create_date
(下单日期)	total_amount
(订单金额)
1	101	2021-09-30	29000.00
10	103	2020-10-02	28000.00


--方法一

select distinct user_id from 
(select *, datediff(next2,create_date) dd
from(
select user_id, create_date, 
  lead(create_date,2,'1990-01-01') over (partition by user_id order by user_id) next2
from order_info
  ) t1
 ) t2
 where dd >= 2




--方法二：50道题完成后再温故知新

with t1 as (
	select user_id, create_date, row_number() over(partition by user_id order by create_date desc) rn
  	from order_info
),t2 as (
	select user_id,date_add(create_date, cast(rn as int)) dateadd
  	from t1
), t3 as (
	select distinct user_id, count(1) over(partition by user_id, dateadd) cnt
  	from t2
), t4 as (
	select distinct user_id
  	from t3
  	where cnt >= 3
)
select * from t4


-- 从订单明细表(order_detail)统计各品类销售出的商品种类数及累积销量最好的商品，
订单明细表：order_detail

order_detail_id
(订单明细id)	order_id
(订单id)	sku_id
(商品id)	create_date
(下单日期)	price
(商品单价)	sku_num
(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5
商品信息表：sku_info

sku_id
(商品id)	name
(商品名称)	category_id
(分类id)	from_date
(上架日期)	price
(商品价格)
1	xiaomi 10	1	2020-01-01	2000
6	洗碗机	2	2020-02-01	2000
9	自行车	3	2020-01-01	1000
商品分类信息表：category_info

category_id
(分类id)	category_name
(分类名称)
1	数码
2	厨卫
3	户外

select sku_id,name,category_id,category_name,sku_num as order_num, sku_cnt
from (
  select sku_id,name,category_id,category_name,sku_num, 
      rank() over (partition by category_id order by sku_num desc) rk,
      count(category_id) over (partition by category_id) sku_cnt
  from (
      select sku_id,name,category_id,category_name,sum(sku_num) sku_num
      from (
        select od.sku_id, si.name, od.sku_num, ci.category_id, ci.category_name
        from order_detail od join sku_info si on od.sku_id = si.sku_id
        join category_info ci on si.category_id = ci.category_id
        ) t1
      group by sku_id,name,category_id,category_name
      order by category_id, sku_id
  ) t2
) t3
where rk = 1




-- 方法二 温故知新 2.13
with t1 as (
	select od.sku_id, si.name, od.sku_num, ci.category_id, ci.category_name
    from order_detail od join sku_info si on od.sku_id = si.sku_id
    join category_info ci on si.category_id = ci.category_id
), t2 as (
	select   category_id, category_name, sku_id,name,  
  		sum(sku_num) over(partition by category_id,sku_id)  order_num,
  		count(distinct sku_id) over(partition by category_id) sku_cnt
  	from t1
), t3 as (
	select category_id, category_name, sku_id,name,order_num,sku_cnt,
  		row_number() over(partition by category_id order by order_num desc) rn
  	from t2
), t4 as (
	select category_id, category_name, sku_id,name,order_num,sku_cnt
  	from t3
  	where rn = 1
)
select * from t4



-- 从订单信息表(order_info)中统计每个用户截止其每个下单日期的累积消费金额，以及每个用户在其每个下单日期的VIP等级。
用户vip等级根据累积消费金额计算，计算规则如下：
设累积消费总额为X，
若0=<X<10000,则vip等级为普通会员
若10000<=X<30000,则vip等级为青铜会员
若30000<=X<50000,则vip等级为白银会员
若50000<=X<80000,则vip为黄金会员
若80000<=X<100000,则vip等级为白金会员
若X>=100000,则vip等级为钻石会员


订单信息表：order_info

order_id
(订单id)	user_id
(用户id)	create_date
(下单日期)	total_amount
(订单金额)
1	101	2021-09-30	29000.00
10	103	2020-10-02	28000.00


select  user_id, create_date, sum_so_far,
	case when sum_so_far >= 100000 then '钻石会员'
    	 when sum_so_far >= 80000  then '白金会员'
         when sum_so_far >= 50000  then '黄金会员'
         when sum_so_far >= 30000  then '白银会员'
         when sum_so_far >= 10000  then '青铜会员' else '普通会员' end vip_level
from (
select DISTINCT user_id, create_date, sum_so_far from 
(  select *, sum(total_amount) over (partition by user_id order by create_date) sum_so_far
  from order_info ) t1
) t2






-- 方法：温故知新
with t1 as (
	select distinct user_id, create_date, sum(total_amount) over (partition by user_id order by create_date) sum_so_far
  	from order_info
), t2 as (
	select  user_id, create_date, sum_so_far,
	   case when sum_so_far >= 100000 then '钻石会员'
    	 	when sum_so_far >= 80000  then '白金会员'
         	when sum_so_far >= 50000  then '黄金会员'
         	when sum_so_far >= 30000  then '白银会员'
         	when sum_so_far >= 10000  then '青铜会员' else '普通会员' end vip_level
  	from t1
)
select * from t2


-- 从订单信息表(order_info)中查询首次下单后第二天仍然下单的用户占所有下单用户的比例，结果保留一位小数，使用百分数显示，
期望结果如下：
percentage
<string>
70.0%
需要用到的表：
订单信息表：order_info

order_id (订单id)	user_id (用户id)	create_date (下单日期)	total_amount (订单金额)
1	101	2021-09-30	29000.00
10	103	2020-10-02	28000.00


with t0 as (
  select user_id, create_date, sum(total_amount) total_amount
  from order_info
  group by user_id, create_date
),t1 as (
  select *,lead(create_date,1,'2000-01-01') over (partition by user_id order by create_date) next_date,
  row_number() over(partition by user_id order by create_date) first_date
  from t0
), t2 as (
  select user_id, create_date, next_date,datediff(next_date, create_date) dd,first_date
  from t1
  where first_date = 1
), t3 as (
  select 
	concat(cast(
      (select count(1) from t2 where dd=1)  / (select count(1) from t2)*100 as decimal(10,1)
    ),'%') percentage
), t4 as (
	  select 
	concat(round(
      (select count(1) from t2 where dd=1)  / (select count(1) from t2),3) *100,'%') percentage
)
select * from t4




-- 方法二：温故知新
with t1 as (
	select distinct user_id , create_date 
  	from order_info
), t2 as (
	select user_id, create_date,  row_number() over(partition by user_id order by create_date) rn,
  			lead(create_date,1,create_date) over(partition by user_id order by create_date) next_day
	from t1
), t3 as (
	select distinct user_id,
  			sum(case when rn=1 then 1 else 0 end) over() order_num,
  			sum(case when rn = 1 and datediff(next_day,create_date)=1 then 1 else 0 end) over(partition by user_id) sencond_num 
  	from t2
  	where rn <= 2
), t4 as (
	select distinct round(sum(sencond_num/order_num) over()*100,1) percentage
  	from t3
), t5 as (
	select concat(percentage,'%') percentage
  	from t4
)
select * from t5




-- 从订单明细表(order_detail)统计每个商品销售首年的年份，销售数量和销售总额。

订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5


with t1 as (
	select *, date_format(create_date,'Y') as years from order_detail 
), t2 as (
	select sku_id, years, price, sku_num, 
  	rank () over(partition by sku_id order by years) rod
  	from t1
), t3 as (
	select sku_id,years,price, sum(sku_num) order_num
  	from t2
  	where rod = 1
  	group by sku_id,years,price
), t4 as (
	select sku_id,years as year, order_num, order_num*price as order_amount
  	from t3
  	order by sku_id
)
select * from t4



-- 从订单明细表(order_detail)中筛选出去年总销量小于100的商品及其销量，假设今天的日期是2022-01-10，不考虑上架时间小于一个月的商品
商品信息表：sku_info

sku_id(商品id)	name(商品名称)	category_id(分类id)	from_date(上架日期)	price(商品价格)
1	xiaomi 10	1	2020-01-01	2000
6	洗碗机	2	2020-02-01	2000
9	自行车	3	2020-01-01	1000
订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5

with t1 as (
  select od.sku_id, od.sku_num, si.name, si.from_date, date('2022-01-10') today
  from order_detail od join sku_info si on od.sku_id = si.sku_id
  where date_format(od.create_date,'Y') = 2021
), t2 as (
	select sku_id,name, sum(sku_num) order_num
  	from t1
  	where datediff(today,from_date) >=30
  	group by sku_id,name
  	order by sku_id
), t3 as (
	select * from t2 where order_num < 100
)
select * from t3

-- 从用户登录明细表（user_login_detail）中查询每天的新增用户数，若一个用户在某天登录了，且在这一天之前没登录过，则任务该用户为这一天的新增用户。

用户登录明细表：user_login_detail

user_id(用户id)	ip_address(ip地址)	login_ts(登录时间)	logout_ts(登出时间)
101	180.149.130.161	2021-09-21 08:00:00	2021-09-27 08:30:00
102	120.245.11.2	2021-09-22 09:00:00	2021-09-27 09:30:00
103	27.184.97.3	2021-09-23 10:00:00	2021-09-27 10:30:00



with t1 as (
select user_id,date_format(login_ts, 'yyyy-MM-dd') login_ts from user_login_detail
), t2 as (
	select user_id, login_ts, rank() over(partition by user_id order by login_ts) rk
  	from t1
), t3 as (
	select distinct user_id as user_count, login_ts
  	from t2
  	where rk =1
), t4 as (
	select login_ts as login_date_first, count(user_count) user_count
  	from t3
  	group by login_ts
)
select * from t4

-- 从订单明细表（order_detail）中统计出每种商品销售件数最多的日期及当日销量，如果有同一商品多日销量并列的情况，取其中的最小日期。
订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5


with t1 as (
	select sku_id,  create_date, sum(sku_num) sum_num
 	from order_detail 
  	group by sku_id,create_date
), t2 as (
	select sku_id, create_date, sum_num,
  		rank() over(partition by sku_id order by sum_num desc) rk
 	from t1
), t3 as (
	select sku_id,create_date,sum_num from t2 where rk = 1
)
select * from t3

-- 从订单明细表（order_detail）中查询累积销售件数高于其所属品类平均数的商品

商品信息表：sku_info

sku_id(商品id)	name(商品名称)	category_id(分类id)	from_date(上架日期)	price(商品价格)
1	xiaomi 10	1	2020-01-01	2000
6	洗碗机	2	2020-02-01	2000
9	自行车	3	2020-01-01	1000
订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5


with t1 as (
  select od.sku_id, si.name, si.category_id,
  		sum(od.sku_num) over (partition by od.sku_id, si.name order by od.sku_id) sum_num,
  		sum(od.sku_num) over (partition by si.category_id order by si.category_id) cat_num,
--  		dense_rank() over (partition by si.category_id order by od.sku_id) dr,
  		count(distinct name) over (partition by si.category_id) cnt
  from order_detail od join sku_info si on od.sku_id = si.sku_id
  order by si.category_id
), t2 as (
	select distinct sku_id, name, sum_num, floor(cat_num/cnt) cate_avg_num
  	from t1
), t3 as (
  	select  sku_id,name, sum_num, cate_avg_num
  	from t2
  	where sum_num > cate_avg_num
)
select * from t3

-- 从用户登录明细表（user_login_detail）和订单信息表（order_info）中查询每个用户的注册日期（首次登录日期）、总登录次数以及其在2021年的登录次数、订单数和订单总额。


用户登录明细表：user_login_detail

user_id(用户id)	ip_address(ip地址)	login_ts(登录时间)	logout_ts(登出时间)
101	180.149.130.161	2021-09-21 08:00:00	2021-09-27 08:30:00
102	120.245.11.2	2021-09-22 09:00:00	2021-09-27 09:30:00
103	27.184.97.3	2021-09-23 10:00:00	2021-09-27 10:30:00
订单信息表：order_info

order_id (订单id)	user_id (用户id)	create_date (下单日期)	total_amount (订单金额)
1	101	2021-09-30	29000.00
10	103	2020-10-02	28000.00


with t1 as (
  select oi.user_id, uld.login_ts,  oi.create_date, oi.total_amount, oi.order_id ,

  	count(distinct uld.login_ts) over(partition by oi.user_id) total_login_count,
  	year(login_ts) login_2021, year(create_date) order_2021
  from order_info oi join user_login_detail uld on oi.user_id = uld.user_id
), t2 as (
	select distinct user_id,  total_login_count, order_id , order_2021,login_2021,
  		min(date_format(login_ts, 'yyyy-MM-dd')) over(partition by user_id order by login_ts) register_date,
  		count(distinct login_ts) over(partition by user_id, login_2021) login_count_2021,
  		count(distinct order_id) over(partition by user_id, order_2021) order_count_2021,
  		total_amount
  	from t1
), t3 as (
	select user_id, register_date,total_login_count,login_count_2021,order_count_2021,order_2021,login_2021,
  			sum(total_amount) over(partition by user_id, order_2021) order_amount_2021
  	from t2
), t4 as (
	select distinct user_id,register_date,total_login_count,login_count_2021,order_count_2021 ,order_amount_2021
  	from t3
  	where order_2021=2021 and login_2021 =2021
)
select * from t4


-- 查询所有商品（sku_info表）截至到2021年10月01号的最新商品价格（需要结合价格修改表进行分析）


商品信息表：sku_info

sku_id(商品id)	name(商品名称)	category_id(分类id)	from_date(上架日期)	price(商品价格)
1	xiaomi 10	1	2020-01-01	2000
6	洗碗机	2	2020-02-01	2000
9	自行车	3	2020-01-01	1000
商品价格变更明细表：sku_price_modify_detail

sku_id(商品id)	new_price(本次变更之后的价格)	change_date(变更日期)
1	1900.00	2021-09-25
1	2000.00	2021-09-26
2	80.00	2021-09-29
2	10.00	2021-09-30


with t1 as (
  select si.sku_id, sp.new_price,sp.change_date, datediff('2021-10-01', sp.change_date) dd
  from sku_price_modify_detail sp join sku_info si on sp.sku_id = si.sku_id
), t2 as (
	select sku_id, new_price, change_date,
  		rank() over(partition by sku_id order by change_date desc) rk
  	from t1
  	where dd >=0 
), t3 as (
	select sku_id, new_price as price
  	from t2
  	where rk = 1
)
select * from t3



-- 订单配送中，如果期望配送日期和下单日期相同，称为即时订单，如果期望配送日期和下单日期不同，称为计划订单。
-- 请从配送信息表（delivery_info）中求出每个用户的首单（用户的第一个订单）中即时订单的比例，保留两位小数，以小数形式显示。



配送信息表：delivery_info

delivery_id （运单 id ）	order_id （订单id）	user_id （用户 id ）	order_date （下单日期）	custom_date （期望配送日期）
1	1	101	2021-09-27	2021-09-29
2	2	101	2021-09-28	2021-09-28
3	3	101	2021-09-29	2021-09-30

-- 求出用户首单的数量
-- 首单是即时订单的比例
with t1 as (
select user_id , order_date , custom_date, 
	rank() over(partition by user_id order by order_date) rk
from delivery_info
), t2 as (
	select distinct user_id, order_date, custom_date
	from t1
  	where rk = 1
), t3 as (
	select 
  	cast((select count(1) from t2 where order_date = custom_date)/(select count(1) from t2)as decimal(10,2)) percentage
)
select * from t3


-- 现需要请向所有用户推荐其朋友收藏但是用户自己未收藏的商品，请从好友关系表（friendship_info）和收藏表（favor_info）中查询出应向哪位用户推荐哪些商品。
好友关系表：friendship_info

user1_id（用户1 id）	user2_id（用户2 id）
101	1010
101	108
101	106
收藏表：favor_info

user_id(用户id)	sku_id(商品id)	create_date(收藏日期)
101	3	2021-09-23
101	12	2021-09-23
101	6	2021-09-25

-- 以用户101为例
-- 找出用户101的朋友的全部收藏品
-- 在上面这堆收藏品中剔除自己已拥有的，就是用户101所缺的，即题目所求

with t1 as (
  select distinct fr.user1_id as user_id, fa.sku_id
  from friendship_info fr join favor_info fa on fr.user2_id = fa.user_id
), t2 as (
	select user_id, sku_id
  	from t1
  	where sku_id not in (select sku_id from favor_info fi where t1.user_id = fi.user_id)
)
select * from t2
t1输出：用户及他的朋友所对应的全部收藏品

user_id	sku_id
1	101	1
2	101	10
3	101	11
4	101	12
5	101	2
6	101	3
7	101	4
8	101	5
9	101	6
10	101	7
11	101	8
12	101	9
t2： 在上面这堆收藏品中剔除自己已拥有的，就是用户101所缺的，即题目所求

关键在于 where sku_id not in (select sku_id from favor_info fi where t1.user_id = fi.user_id)


-- 从登录明细表（user_login_detail）中查询出，所有用户的连续登录两天及以上的日期区间，以登录时间（login_ts）为准。

需要用到的表：
登录明细表：user_login_detail

user_id(用户id)	ip_address(ip地址)	login_ts(登录时间)	logout_ts(登出时间)
101	180.149.130.161	2021-09-21 08:00:00	2021-09-27 08:30:00
102	120.245.11.2	2021-09-22 09:00:00	2021-09-27 09:30:00
103	27.184.97.3	2021-09-23 10:00:00	2021-09-27 10:30:00


with t1 as (
	select distinct user_id, date_format(login_ts,'yyyy-MM-dd') login_ts
  	from user_login_detail
), t2 as (
	select user_id, login_ts, lead(login_ts,1,login_ts) over(partition by user_id order by login_ts) login_next
  	from t1
), t3 as (
	select user_id, login_ts, login_next, datediff(login_next, login_ts) dd
  	from t2
), t4 as (
	select user_id,login_ts,login_next from t3 where dd = 1
), t5 as (
	select distinct user_id, min(login_ts) over (partition by user_id order by login_ts) start_date,
  				max(login_next) over (partition by user_id) end_date
  	from t4
)
select * from t5
t1输出：找出用户及登录时间，进行简单的去重，格式转换

user_id	login_ts
1	101	2021-09-21
2	101	2021-09-27
3	101	2021-09-28
4	101	2021-09-29
5	101	2021-09-30
6	1010	2021-09-27
7	1010	2021-10-09
8	102	2021-09-22
9	102	2021-10-01
10	102	2021-10-02
11	103	2021-09-23
12	103	2021-10-03
13	104	2021-09-24
t2输出：lead()窗口函数找出相邻的登录日期

user_id	login_ts	login_next
1	101	2021-09-21	2021-09-27
2	101	2021-09-27	2021-09-28
3	101	2021-09-28	2021-09-29
4	101	2021-09-29	2021-09-30
5	101	2021-09-30	2021-09-30
t3输出：dd---相邻登录日期之差

dd	user_id	login_ts	login_next
1	6	101	2021-09-21	2021-09-27
2	1	101	2021-09-27	2021-09-28
3	1	101	2021-09-28	2021-09-29
4	1	101	2021-09-29	2021-09-30
5	0	101	2021-09-30	2021-09-30
6	12	1010	2021-09-27	2021-10-09
7	0	1010	2021-10-09	2021-10-09
8	9	102	2021-09-22	2021-10-01
9	1	102	2021-10-01	2021-10-02
10	0	102	2021-10-02	2021-10-02
11	10	103	2021-09-23	2021-10-03
12	0	103	2021-10-03	2021-10-03
13	9	104	2021-09-24	2021-10-03
14	0	104	2021-10-03	2021-10-03
15	0	105	2021-10-04	2021-10-04
16	1	106	2021-10-04	2021-10-05
17	0	106	2021-10-05	2021-10-05
18	10	107	2021-09-25	2021-10-05
19	1	107	2021-10-05	2021-10-06
20	0	107	2021-10-06	2021-10-06
21	0	108	2021-10-06	2021-10-06
22	10	109	2021-09-26	2021-10-06
23	2	109	2021-10-06	2021-10-08
24	0	109	2021-10-08	2021-10-08
t4输出：取出dd=1的数据，到这里就容易看出如何输出了。最小的登录日期和最大的next日期，去重。

user_id	login_ts	login_next
1	101	2021-09-27	2021-09-28
2	101	2021-09-28	2021-09-29
3	101	2021-09-29	2021-09-30
4	102	2021-10-01	2021-10-02
5	106	2021-10-04	2021-10-05
6	107	2021-10-05	2021-10-06
t5输出如题目所示

-- 从订单信息表（order_info）和用户信息表（user_info）中，分别统计每天男性和女性用户的订单总金额，如果当天男性或者女性没有购物，则统计结果为0。

订单信息表：order_info

order_id (订单id)	user_id (用户id)	create_date (下单日期)	total_amount (订单金额)
1	101	2021-09-30	29000.00
10	103	2020-10-02	28000.00
用户信息表：user_info

user_id(用户id)	gender(性别)	birthday(生日)
101	男	1990-01-01
102	女	1991-02-01
103	女	1992-03-01
104	男	1993-04-01

with t0 as (
	select user_id, create_date , sum(total_amount) as total_amount 
  	from order_info
  	group by user_id, create_date 
), t1 as (
	select t0.user_id , t0.create_date , t0.total_amount, ui.gender
  	from t0  join user_info ui on t0.user_id = ui.user_id
), t2 as (
	select create_date, case when gender='男' then total_amount else 0 end total_amount_male,
  			case when gender='女' then total_amount else 0 end total_amount_female
  	from t1
), t3 as (
	select create_date, sum(total_amount_male) total_amount_male, sum(total_amount_female) total_amount_female
  	from t2
  	group by create_date
)
select * from t3
t0输出：合并同用户同一天的消费

user_id	total_amount	create_date
1	101	29000.00	2021-09-27
2	101	70500.00	2021-09-28
3	101	43300.00	2021-09-29
4	101	860.00	2021-09-30
5	1010	51950.00	2020-10-08
6	102	171680.00	2021-10-01
7	102	6170.00	2021-10-02
t1输出：join链接两表，取出性别一字段

gender	user_id	total_amount	create_date
1	男	1010	51950.00	2020-10-08
2	女	102	171680.00	2021-10-01
3	女	102	6170.00	2021-10-02
4	女	105	120100.00	2021-10-04
5	女	109	24020.00	2020-10-08
6	女	109	129480.00	2021-10-07
t2输出：通过case when把数据转成字段名，可以和t1表合并，代码没那么臃肿

total_amount_male	create_date	total_amount_female
1	51950.00	2020-10-08	0.00
2	0.00	2021-10-01	171680.00
3	0.00	2021-10-02	6170.00
4	0.00	2021-10-04	120100.00
5	0.00	2020-10-08	24020.00
6	0.00	2021-10-07	129480.00
7	0.00	2021-10-05	69850.00
8	0.00	2021-10-06	54300.00
9	0.00	2021-10-02	69980.00
10	0.00	2021-10-03	5910.00
11	101070.00	2021-10-06	0.00
12	54700.00	2021-10-07	0.00
13	29000.00	2021-09-27	0.00
14	70500.00	2021-09-28	0.00
15	43300.00	2021-09-29	0.00
16	860.00	2021-09-30	0.00
17	9390.00	2021-10-04	0.00
18	109760.00	2021-10-05	0.00
19	89880.00	2021-10-03	0.00
t3输出如题目所示

-- 查询截止每天的最近3天内的订单金额总和以及订单金额日平均值，保留两位小数，四舍五入。

订单信息表：order_info

order_id (订单id)	user_id (用户id)	create_date (下单日期)	total_amount (订单金额)
1	101	2021-09-30	29000.00
10	103	2020-10-02	28000.00


with t1 as (
	select create_date , sum(total_amount)as total_amount
  	from order_info
  	group by create_date
), t2 as (
	select create_date, total_amount,
  		lag(total_amount,2,0) over() total_amount2,
  		lag(total_amount,1,0) over() total_amount1,
  		lag(create_date,2,'2000-01-01') over() next2, datediff(create_date,lag(create_date,2,'2000-01-01') over()) dd2,
  		lag(create_date,1,'2000-01-01') over() next1, datediff(create_date,lag(create_date,1,'2000-01-01') over()) dd1
  		
  	from t1 
), t3 as (
	select create_date, total_amount,total_amount2,total_amount1,
  		case when dd2 = 2 then dd2 
  			when dd1 = 1 and dd2 != 2 then dd1 else 0 end dd
  	from t2
), t4 as (
	select create_date, 
  		case when dd=0 then total_amount
  			when dd = 1 then total_amount + total_amount1
  			when dd =2 then total_amount + total_amount1 + total_amount2 end total_3d,
		case when dd=0 then round(total_amount,2)
			when dd=1 then round((total_amount + total_amount1)/2,2)
			when dd=2 then round((total_amount + total_amount1 + total_amount2)/3,2) end avg_3d
	from t3
)
select * from t4

本人的思路比较直接，你说截止到今天的近3天，那我就找出来近3天的金额，有就有，没就没。我不怎么用join自连接，感觉会占用空间以及降低效率，喜欢用窗口函数解决。

t1输出：对下单日期进行金额求和，变相去重

total_amount	create_date
1	75970.00	2020-10-08
2	29000.00	2021-09-27
3	70500.00	2021-09-28
4	43300.00	2021-09-29
5	860.00	2021-09-30
6	171680.00	2021-10-01
7	76150.00	2021-10-02
8	95790.00	2021-10-03
9	129490.00	2021-10-04
10	179610.00	2021-10-05
11	155370.00	2021-10-06
12	184180.00	2021-10-07
t2输出：dd1为1，即截止为今天，昨天有销售金额；dd2为2，即截止为今天，前天，昨天都有销售金额

next1,next2不重要，可省略，仅供中间参考。

total_amount1:相对下单日期来说，"昨天"(上一条记录)的销售金额，不存在统一为0

total_amount2:相对下单日期来说，"前天"(上两条记录)的销售金额，不存在统一为0

dd1	next2	dd2	next1	total_amount	total_amount1	total_amount2	create_date
1	7586	2000-01-01	7586	2000-01-01	75970.00	0.00	0.00	2020-10-08
2	354	2000-01-01	7940	2020-10-08	29000.00	75970.00	0.00	2021-09-27
3	1	2020-10-08	355	2021-09-27	70500.00	29000.00	75970.00	2021-09-28
4	1	2021-09-27	2	2021-09-28	43300.00	70500.00	29000.00	2021-09-29
5	1	2021-09-28	2	2021-09-29	860.00	43300.00	70500.00	2021-09-30
6	1	2021-09-29	2	2021-09-30	171680.00	860.00	43300.00	2021-10-01
7	1	2021-09-30	2	2021-10-01	76150.00	171680.00	860.00	2021-10-02
8	1	2021-10-01	2	2021-10-02	95790.00	76150.00	171680.00	2021-10-03
9	1	2021-10-02	2	2021-10-03	129490.00	95790.00	76150.00	2021-10-04
10	1	2021-10-03	2	2021-10-04	179610.00	129490.00	95790.00	2021-10-05
11	1	2021-10-04	2	2021-10-05	155370.00	179610.00	129490.00	2021-10-06
12	1	2021-10-05	2	2021-10-06	184180.00	155370.00	179610.00	2021-10-07
t3输出：这个表就是我脑海里一致构思（大概）的表，这样就清楚了，

dd=0,这个下单日期在库里没有昨天和前天的数据，直接套用total_amount即可

dd=1,这个下单日期在库里有昨天的数据，那么用到total_amount 和 total_amount1 两个字段

dd=2,这个下单日期在库里有近3天的全部数据，那么total_amount，total_amount1，total_amount2都用上

dd	total_amount	total_amount1	total_amount2	create_date
1	0	75970.00	0.00	0.00	2020-10-08
2	0	29000.00	75970.00	0.00	2021-09-27
3	1	70500.00	29000.00	75970.00	2021-09-28
4	2	43300.00	70500.00	29000.00	2021-09-29
5	2	860.00	43300.00	70500.00	2021-09-30
6	2	171680.00	860.00	43300.00	2021-10-01
7	2	76150.00	171680.00	860.00	2021-10-02
8	2	95790.00	76150.00	171680.00	2021-10-03
9	2	129490.00	95790.00	76150.00	2021-10-04
10	2	179610.00	129490.00	95790.00	2021-10-05
11	2	155370.00	179610.00	129490.00	2021-10-06
12	2	184180.00	155370.00	179610.00	2021-10-07
t4输出如题目所示


-- 从订单明细表(order_detail)中查询出所有购买过商品1和商品2，但是没有购买过商品3的用户，

订单信息表：order_info

order_id (订单id)	user_id (用户id)	create_date (下单日期)	total_amount (订单金额)
1	101	2021-09-30	29000.00
10	103	2020-10-02	28000.00
订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5

with t1 as (
	select oi.user_id , od.sku_id
	from  order_info oi join order_detail od on oi.order_id = od.order_id 
),	t2 as (
	select user_id, sku_id,
  		sum(case when sku_id = 1 or sku_id = 2 then 1
            	when sku_id = 3 then -1000 else 0 end) over (partition by user_id ) num
  	from t1
), t3 as (
	select distinct user_id
  	from t2
  	where num = 2
)
select * from t3
t1输出：连接两表，得到用户id和商品id

user_id	sku_id
1	101	4
2	101	5
3	101	1
4	101	3
5	101	12
6	101	7
7	101	8
8	101	9
9	1010	6
10	1010	7
11	1010	8
12	1010	10
13	1010	11
14	1010	12
15	1010	1
16	1010	2
17	1010	3
18	102	1
19	102	2
20	102	3
21	102	7
22	102	8
23	102	9
24	102	10
25	102	11
26	102	12
27	102	4
28	102	6
29	103	10
30	103	11
31	103	12
32	103	1
33	103	2
34	103	8
35	103	4
36	103	5
37	103	6
38	104	1
39	104	3
40	104	7
41	104	10
42	104	11
43	104	12
44	104	4
45	104	5
46	104	6
47	105	4
48	105	5
49	105	6
50	105	1
51	105	2
52	105	7
53	105	8
54	105	9
55	105	11
56	105	12
57	106	4
58	106	5
59	106	7
60	106	8
61	106	9
62	106	1
63	106	2
64	106	3
65	106	10
66	106	11
67	106	12
68	107	10
69	107	11
70	107	12
71	107	4
72	107	5
73	107	6
74	107	7
75	107	8
76	107	9
77	107	1
78	107	2
79	107	3
80	108	4
81	108	5
82	108	6
83	108	1
84	108	2
85	108	3
86	108	10
87	108	11
88	108	8
89	108	9
90	109	4
91	109	5
92	109	6
93	109	10
94	109	11
95	109	12
96	109	8
97	109	1
98	109	2
99	109	3
t2输出：窗口函数-对用户分组，累加商品,id为1或2的时候，1， id为3时，我设置为-1000，以证明这是异类，其他值为0

user_id	num	sku_id
1	101	-999	8
2	101	-999	5
3	101	-999	4
4	101	-999	12
5	101	-999	9
6	101	-999	1
7	101	-999	3
8	101	-999	7
9	1010	-998	12
10	1010	-998	2
11	1010	-998	10
12	1010	-998	11
13	1010	-998	3
14	1010	-998	6
15	1010	-998	1
16	1010	-998	7
17	1010	-998	8
18	102	-998	10
19	102	-998	4
20	102	-998	7
21	102	-998	8
22	102	-998	2
23	102	-998	3
24	102	-998	9
25	102	-998	6
26	102	-998	1
27	102	-998	12
28	102	-998	11
29	103	2	12
30	103	2	6
31	103	2	8
32	103	2	5
33	103	2	4
34	103	2	10
35	103	2	1
36	103	2	2
37	103	2	11
38	104	-999	1
39	104	-999	4
40	104	-999	11
41	104	-999	10
42	104	-999	12
43	104	-999	3
44	104	-999	5
45	104	-999	6
46	104	-999	7
47	105	2	9
48	105	2	5
49	105	2	6
50	105	2	12
51	105	2	11
52	105	2	4
53	105	2	1
54	105	2	2
55	105	2	7
56	105	2	8
t3输出如题目所示


-- 从订单明细表（order_detail）中统计每天商品1和商品2销量（件数）的差值（商品1销量-商品2销量）


订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5

with t1 as (
    select create_date, sku_id, sum(sku_num) sku_num
    from order_detail
    where sku_id = 1 or sku_id = 2
    group by create_date,sku_id
), t2 as (
	select create_date, sku_id, sku_num, case when sku_id = 1 then sku_num else 0 end num1,
  		case when sku_id = 2 then sku_num else 0 end num2
 	from t1
), t3 as (
	select distinct create_date, sum(num1) over(partition by create_date) num1,
  		sum(num2) over(partition by create_date) num2
  	from t2
), t4 as (
	select create_date, num1-num2 diff
  	from t3
)
select * from t4
t1输出：合并数量、筛选1,2

sku_num	sku_id	create_date
1	2	1	2020-10-08
2	26	2	2020-10-08
3	2	1	2021-09-27
4	8	1	2021-10-01
5	18	2	2021-10-01
6	9	1	2021-10-02
7	5800	2	2021-10-02
8	4	1	2021-10-03
9	5	1	2021-10-04
10	60	2	2021-10-04
t2输出：case when取出商品1和商品2的数量，各成一列

sku_num	num1	sku_id	create_date	num2
1	2	2	1	2020-10-08	0
2	26	0	2	2020-10-08	26
3	2	2	1	2021-09-27	0
4	8	8	1	2021-10-01	0
5	18	0	2	2021-10-01	18
6	9	9	1	2021-10-02	0
7	5800	0	2	2021-10-02	5800
8	4	4	1	2021-10-03	0
9	5	5	1	2021-10-04	0
10	60	0	2	2021-10-04	60
11	5	5	1	2021-10-05	0
12	35	0	2	2021-10-05	35
13	8	8	1	2021-10-06	0
14	57	0	2	2021-10-06	57
15	8	8	1	2021-10-07	0
16	48	0	2	2021-10-07	48
t3输出：求和即所得

num1	create_date	num2
1	2	2020-10-08	26
2	2	2021-09-27	0
3	8	2021-10-01	18
4	9	2021-10-02	5800
5	4	2021-10-03	0
6	5	2021-10-04	60
7	5	2021-10-05	35
8	8	2021-10-06	57
9	8	2021-10-07	48


-- 从订单信息表（order_info）中查询出每个用户的最近三个下单日期的所有订单

需要用到的表：
订单信息表：order_info

order_id (订单id)	user_id (用户id)	create_date (下单日期)	total_amount (订单金额)
1	101	2021-09-30	29000.00
10	103	2020-10-02	28000.00

-- 理解题目：最近三个下单日期，没要求日期连续
-- 理解题目：所有订单，没说三个订单，题目所示期望结果实属误导

with t1 as (
	select distinct order_id , user_id , create_date 
  	from order_info
  	order by create_date
), t2 as (
	select order_id,user_id,create_date,
  		dense_rank() over(partition by user_id order by create_date desc) drk
  	from t1
), t3 as (
	select user_id, order_id, create_date
  	from t2
  	where drk<=3
)
select * from t3
t1输出:整理好数据

user_id	create_date	order_id
1	101	2021-09-27	1
2	101	2021-09-28	2
3	101	2021-09-29	3
4	101	2021-09-30	4
5	1010	2020-10-08	37
6	1010	2020-10-08	38
7	1010	2020-10-08	39
8	1010	2020-10-08	40
t2输出：开窗，dense_rank（不占位）,按用户分组，按日期倒序，前3就是最近3个下单日期

user_id	create_date	drk	order_id
1	101	2021-09-30	1	4
2	101	2021-09-29	2	3
3	101	2021-09-28	3	2
4	101	2021-09-27	4	1
5	1010	2020-10-08	1	37
6	1010	2020-10-08	1	38
7	1010	2020-10-08	1	39
8	1010	2020-10-08	1	40





-- 从登录明细表（user_login_detail）中查询每个用户两个登录日期（以login_ts为准）之间的最大的空档期。统计最大空档期时，用户最后一次登录至今的空档也要考虑在内，假设今天为2021-10-10。


用户登录明细表：user_login_detail

user_id(用户id)	ip_address(ip地址)	login_ts(登录时间)	logout_ts(登出时间)
101	180.149.130.161	2021-09-21 08:00:00	2021-09-27 08:30:00
102	120.245.11.2	2021-09-22 09:00:00	2021-09-27 09:30:00
103	27.184.97.3	2021-09-23 10:00:00	2021-09-27 10:30:00

with t1 as (
	select distinct user_id, date_format(login_ts,'yyyy-MM-dd') login_ts
  	from user_login_detail
), t2  as (
	select user_id, login_ts,
  		lead(login_ts,1,date('2021-10-10')) over(partition by user_id order by login_ts) next_login
  	from t1
), t3 as (
	select user_id, datediff(next_login, login_ts) diff
  	from t2
), t4 as (
	select user_id, diff, row_number() over(partition by user_id order by diff desc) rk
  	from t3
), t5 as (
	select user_id, diff as max_diff
  	from t4
  	where rk = 1
)
select * from t5
比较简单，看输出

t1:

user_id	login_ts
1	101	2021-09-21
2	101	2021-09-27
3	101	2021-09-28
4	101	2021-09-29
5	101	2021-09-30
6	1010	2021-09-27
7	1010	2021-10-09
t2:

user_id	login_ts	next_login
1	101	2021-09-21	2021-09-27
2	101	2021-09-27	2021-09-28
3	101	2021-09-28	2021-09-29
4	101	2021-09-29	2021-09-30
5	101	2021-09-30	2021-10-10
6	1010	2021-09-27	2021-10-09
7	1010	2021-10-09	2021-10-10
t3:

user_id	diff
1	101	6
2	101	1
3	101	1
4	101	1
5	101	10
6	1010	12
7	1010	1
t4:

user_id	rk	diff
1	101	1	10
2	101	2	6
3	101	3	1
4	101	4	1
5	101	5	1
6	1010	1	12
7	1010	2	1


-- 从登录明细表（user_login_detail）中查询在相同时刻，多地登陆（ip_address不同）的用户


用户登录明细表：user_login_detail

user_id(用户id)	ip_address(ip地址)	login_ts(登录时间)	logout_ts(登出时间)
101	180.149.130.161	2021-09-21 08:00:00	2021-09-27 08:30:00
102	120.245.11.2	2021-09-22 09:00:00	2021-09-27 09:30:00
103	27.184.97.3	2021-09-23 10:00:00	2021-09-27 10:30:00


--理解题目：相同时刻---同一天内
--理解题目：异地登录---两个不同ip登录

with t1 as (
	select distinct user_id, date_format(login_ts,'yyyy-MM-dd') login_ts, ip_address
  	from user_login_detail
), t2 as (
	select user_id, login_ts, ip_address,
  		row_number() over(partition by user_id, login_ts order by ip_address) rn
  	from t1
	
), t3 as (
	select user_id
  	from t2
  	where rn = 2
)
select * from t3
t1

user_id	login_ts	ip_address
1	101	2021-09-21	180.149.130.161
2	101	2021-09-27	180.149.130.161
3	101	2021-09-28	180.149.130.161
4	101	2021-09-29	180.149.130.161
5	101	2021-09-30	180.149.130.161
6	1010	2021-09-27	119.180.192.10
7	1010	2021-10-09	119.180.192.10
8	102	2021-09-22	120.245.11.2
9	102	2021-10-01	120.245.11.2
10	102	2021-10-01	180.149.130.174
11	102	2021-10-02	120.245.11.2
12	103	2021-09-23	27.184.97.3
13	103	2021-10-03	27.184.97.3
14	104	2021-09-24	27.184.97.34
15	104	2021-10-03	120.245.11.89
16	104	2021-10-03	27.184.97.34
17	105	2021-10-04	119.180.192.212
18	106	2021-10-04	119.180.192.66
19	106	2021-10-05	119.180.192.66
20	107	2021-09-25	219.134.104.7
21	107	2021-10-05	219.134.104.7
22	107	2021-10-06	219.134.104.7
23	107	2021-10-06	27.184.97.46
24	108	2021-10-06	101.227.131.22
25	109	2021-09-26	101.227.131.29
26	109	2021-10-06	101.227.131.29
27	109	2021-10-08	101.227.131.29
t2

user_id	login_ts	ip_address	rn
1	101	2021-09-21	180.149.130.161	1
2	101	2021-09-27	180.149.130.161	1
3	101	2021-09-28	180.149.130.161	1
4	101	2021-09-29	180.149.130.161	1
5	101	2021-09-30	180.149.130.161	1
6	1010	2021-09-27	119.180.192.10	1
7	1010	2021-10-09	119.180.192.10	1
8	102	2021-09-22	120.245.11.2	1
9	102	2021-10-01	120.245.11.2	1
10	102	2021-10-01	180.149.130.174	2
11	102	2021-10-02	120.245.11.2	1
12	103	2021-09-23	27.184.97.3	1
13	103	2021-10-03	27.184.97.3	1
14	104	2021-09-24	27.184.97.34	1
15	104	2021-10-03	120.245.11.89	1
16	104	2021-10-03	27.184.97.34	2
17	105	2021-10-04	119.180.192.212	1
18	106	2021-10-04	119.180.192.66	1
19	106	2021-10-05	119.180.192.66	1
20	107	2021-09-25	219.134.104.7	1
21	107	2021-10-05	219.134.104.7	1
22	107	2021-10-06	219.134.104.7	1
23	107	2021-10-06	27.184.97.46	2
24	108	2021-10-06	101.227.131.22	1
25	109	2021-09-26	101.227.131.29	1
26	109	2021-10-06	101.227.131.29	1
27	109	2021-10-08	101.227.131.29	1




-- 商家要求每个商品每个月需要售卖出一定的销售总额
假设1号商品销售总额大于21000，2号商品销售总额大于10000，其余商品没有要求
请写出SQL从订单详情表中（order_detail）查询连续两个月销售总额大于等于任务总额的商品

订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5


with t1 as (
	select sku_id,sum(price * sku_num) amount, date_format(create_date,'yyyy-MM-01') month_date
  	from order_detail
	group by sku_id,date_format(create_date,'yyyy-MM-01')
), t2 as (
	select sku_id,amount, 
  		case when sku_id = 1 and amount > 21300 then month_date
  			when sku_id = 2 and amount > 10000 then month_date else -1 end comp
  	from t1							
), t3 as (
	select sku_id, comp, lead(comp,1,comp) over(partition by sku_id order by comp) next_month
  	from t2
  	where comp != -1
)
select * from t3
莫名其妙就通过了，还没实现我的最终幻想

t1输出：日期通过改为同月的第一天，以便分组求和销售金额

amount	sku_id	month_date
1	4000.00	1	2020-10-01
2	4000.00	1	2021-09-01
3	94000.00	1	2021-10-01
4	9400.00	10	2020-10-01
5	20500.00	10	2021-10-01
6	4750.00	11	2020-10-01
7	11250.00	11	2021-10-01
t2输出：筛选商品1销售金额大于21000，商品2销售金额大于10000，

comp	amount	sku_id
1	-1	4000.00	1
2	-1	4000.00	1
3	2021-10-01	94000.00	1
4	-1	9400.00	10
5	-1	20500.00	10
6	-1	4750.00	11
7	-1	11250.00	11
8	-1	1660.00	12
9	-1	860.00	12
10	-1	411120.00	12
11	-1	260.00	2
12	2021-10-01	60180.00	2
13	-1	5000.00	3
14	-1	25000.00	3
15	-1	150000.00	3
16	-1	54000.00	4
17	-1	264000.00	4
18	-1	16500.00	5
19	-1	104500.00	5
20	-1	12000.00	6
21	-1	52000.00	6
22	-1	3500.00	7
23	-1	3700.00	7
24	-1	18000.00	7
25	-1	35400.00	8
26	-1	27600.00	8
27	-1	88800.00	8
28	-1	12000.00	9
29	-1	182000.00	9
t3输出：本想继续解决连续两个月的问题，结果ton过了，crazy!!!!!!


-- 从订单详情表中（order_detail）对销售件数对商品进行分类，0-5000为冷门商品，5001-19999位一般商品，20000往上为热门商品，并求出不同类别商品的数量

订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5


with t1 as (
	select sku_id,  sum(sku_num) sku_num
  	from order_detail
  	group by sku_id
),  t2 as (
	select sku_id,sku_num, case when sku_num >= 20000 then "热门商品"
  								when sku_num >= 5001  then "一般商品"  else "冷门商品" end category
  	from t1
), t3 as (
	select  distinct category, count(sku_id) over(partition by category) cn 
  	from t2
)
select * from t3
t1输出 

sku_num	sku_id
1	51	1
2	299	10
3	320	11
4	20682	12
5	6044	2
6	36	3
7	53	4
8	242	5
9	32	6
10	252	7
11	253	8
12	194	9
t2输出

sku_num	sku_id	category
1	51	1	冷门商品
2	299	10	冷门商品
3	320	11	冷门商品
4	20682	12	热门商品
5	6044	2	一般商品
6	36	3	冷门商品
7	53	4	冷门商品
8	242	5	冷门商品
9	32	6	冷门商品
10	252	7	冷门商品
11	253	8	冷门商品
12	194	9	冷门商品


-- 从订单详情表中（order_detail）和商品（sku_info）中查询各个品类销售数量前三的商品。如果该品类小于三个商品，则输出所有的商品销量。

订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5
商品信息表：sku_info

sku_id(商品id)	name(商品名称)	category_id(分类id)	from_date(上架日期)	price(商品价格)
1	xiaomi 10	1	2020-01-01	2000
6	洗碗机	2	2020-02-01	2000
9	自行车	3	2020-01-01	1000


-- 各个品类 category_id -- sku_info表
-- 销售数量 sku_num  --  order_detail 表
-- 商品 sku_id  -- 共有
with t0 as (
	select sku_id, sum(sku_num) sku_num
  	from order_detail
  	group by sku_id
), t1 as (
	select t0.sku_id, si.category_id, t0.sku_num,
  		rank() over(partition by category_id order by sku_num desc) rk
  	from t0 join sku_info si on t0.sku_id = si.sku_id
),  t2 as (
	select sku_id, category_id
  	from t1
  	where rk <= 3
)
select * from t2
t0输出：分商品统计数量

sku_num	sku_id
1	51	1
2	299	10
3	320	11
4	20682	12
5	6044	2
6	36	3
7	53	4
8	242	5
9	32	6
10	252	7
11	253	8
12	194	9
t1输出：合并两表并开窗，销量倒序排

category_id	sku_num	rk	sku_id
1	1	6044	1	2
2	1	53	2	4
3	1	51	3	1
4	1	36	4	3
5	2	253	1	8
6	2	252	2	7
7	2	242	3	5
8	2	32	4	6
9	3	20682	1	12
10	3	320	2	11
11	3	299	3	10
12	3	194	4	9




-- 从商品信息表（sku_info）求出各分类商品价格的中位数，如果一个分类下的商品个数为偶数则输出中间两个值的平均值，如果是奇数，则输出中间数即可

需要用到的表：
商品信息表：sku_info

sku_id(商品id)	name(商品名称)	category_id(分类id)	from_date(上架日期)	price(商品价格)
1	xiaomi 10	1	2020-01-01	2000
6	洗碗机	2	2020-02-01	2000
9	自行车	3	2020-01-01	1000


with t1 as (
	select category_id,  price, 
  		lead(price,1,price) over(partition by category_id order by price) next_price,
  		row_number() over(partition by category_id order by price) rn,
  		count(category_id) over(partition by category_id) cnt
  	from sku_info
), t2 as (
	select category_id,  price, 
  		case when rn = cnt / 2 then (price + next_price) / 2 		
  			when rn = (cnt + 1) / 2 then price else -1 end medprice
  	from t1
), t3 as (
	select category_id , cast(medprice as decimal(16,2)) medprice
  	from t2
  	where medprice != -1
)
select * from t3

t1输出：next_price：按商品归类分组，价格排序，取其下一个价格，主要是计算平均值

rn：按商品归类分组，价格排序的名次，正序

cnt:按商品归类分组,统计该类个数

category_id	price	next_price	cnt	rn
1	1	10.0	2000.0	4	1
2	1	2000.0	5000.0	4	2
3	1	5000.0	6000.0	4	3
4	1	6000.0	6000.0	4	4
5	2	100.0	500.0	4	1
6	2	500.0	600.0	4	2
7	2	600.0	2000.0	4	3
8	2	2000.0	2000.0	4	4
9	3	20.0	50.0	4	1
10	3	50.0	100.0	4	2
11	3	100.0	1000.0	4	3
12	3	1000.0	1000.0	4	4
t2输出：如代码所示，重点是求中位数的算法，-1就是无效值

category_id	medprice	price
1	1	-1.0	10.0
2	1	3500.0	2000.0
3	1	-1.0	5000.0
4	1	-1.0	6000.0
5	2	-1.0	100.0
6	2	550.0	500.0
7	2	-1.0	600.0
8	2	-1.0	2000.0
9	3	-1.0	20.0
10	3	75.0	50.0
11	3	-1.0	100.0
12	3	-1.0	1000.0



-- 从订单详情表（order_detail）中找出销售额连续3天超过100的商品

订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5


-- 销售额超过100  price*sku_num
-- 连续三天 create_date

with t1 as (
	select sku_id,create_date,sum(price*sku_num) amount
  	from order_detail
  	group by sku_id,create_date
), t2 as (
	select sku_id,create_date,
  		lead(create_date,2,create_date) over(partition by sku_id order by create_date) ld_date
  	from t1
	where amount > 100
), t3 as (
	select sku_id, datediff(ld_date, create_date) dd
  	from t2
), t4 as (
	select distinct sku_id
  	from t3
  	where dd = 2
)
select * from t4
t1输出：按商品id,下单日期分组，求用户每天的销售额

amount	sku_id	create_date
1	4000.00	1	2020-10-08
2	4000.00	1	2021-09-27
3	16000.00	1	2021-10-01
4	18000.00	1	2021-10-02
5	8000.00	1	2021-10-03
6	10000.00	1	2021-10-04
7	10000.00	1	2021-10-05
8	16000.00	1	2021-10-06
9	16000.00	1	2021-10-07
t2输出：销售额>100

    lead(下单日期)取出当前日期的后两条日期，如果存在连续三天，那么必定为有相差2天的

sku_id	ld_date	create_date
1	1	2021-10-01	2020-10-08
2	1	2021-10-02	2021-09-27
3	1	2021-10-03	2021-10-01
4	1	2021-10-04	2021-10-02
5	1	2021-10-05	2021-10-03
6	1	2021-10-06	2021-10-04
7	1	2021-10-07	2021-10-05
8	1	2021-10-06	2021-10-06
9	1	2021-10-07	2021-10-07
t3输出：只要日期相差有2，说明该商品id必定存在“连续三天”，提出来即可

dd	sku_id
1	358	1
2	5	1
3	2	1
4	2	1
5	2	1
6	2	1
7	2	1
8	0	1
9	0	1


-- 从用户登录明细表（user_login_detail）中首次登录算作当天新增，第二天也登录了算作一日留存

用户登录明细表：user_login_detail

user_id(用户id)	ip_address(ip地址)	login_ts(登录时间)	logout_ts(登出时间)
101	180.149.130.161	2021-09-21 08:00:00	2021-09-27 08:30:00
102	120.245.11.2	2021-09-22 09:00:00	2021-09-27 09:30:00
103	27.184.97.3	2021-09-23 10:00:00	2021-09-27 10:30:00

-- 时间单位 精准到天即可 date_format(日期,'yyyy-MM-dd')
-- 首次登录 最小的登录日期 row_number() 按登陆日期排序取1即可
-- 一日留存 首次登录后第二天也登录 

with t1 as (
	select distinct user_id, date_format(login_ts,'yyyy-MM-dd') login_ts
  	from user_login_detail
),  t2 as (
	select user_id,login_ts, row_number() over(partition by user_id order by login_ts) first_login,
  		lead(login_ts,1,login_ts) over(partition by user_id order by login_ts) second_login
  	from t1
), t3 as (
	select user_id,login_ts,datediff(second_login,login_ts) dd
  	from t2
  	where first_login = 1
), t4 as (
	select login_ts, count(user_id) over(partition by login_ts) register, 
  		case when dd = 1 then 1 else 0 end retention_num
  	from t3
), t5 as (
	select distinct login_ts as first_login, register, 
  		cast((sum(retention_num) over(partition by login_ts,register) / register) as decimal(16,2)) as retention
  	from t4
)
select * from t5
t1输出：调整格式，取出关键字段

user_id	login_ts
1	101	2021-09-21
2	101	2021-09-27
3	101	2021-09-28
4	101	2021-09-29
5	101	2021-09-30
6	1010	2021-09-27
7	1010	2021-10-09
t2输出：first_login=1，也就是该用户该日期是首日登录，

second_login,也就是该用户首日登录的下一个日期

second_login	user_id	login_ts	first_login
1	2021-09-27	101	2021-09-21	1
2	2021-09-28	101	2021-09-27	2
3	2021-09-29	101	2021-09-28	3
4	2021-09-30	101	2021-09-29	4
5	2021-09-30	101	2021-09-30	5
6	2021-10-09	1010	2021-09-27	1
7	2021-10-09	1010	2021-10-09	2
8	2021-10-01	102	2021-09-22	1
9	2021-10-02	102	2021-10-01	2
t3输出：dd,就是用户首日登录后的下次登录日期与首日登录日期之差，明显当dd=1就是就是两天连续

dd	user_id	login_ts
1	6	101	2021-09-21
2	12	1010	2021-09-27
3	9	102	2021-09-22
4	10	103	2021-09-23
5	9	104	2021-09-24
6	0	105	2021-10-04
7	1	106	2021-10-04
8	10	107	2021-09-25
9	0	108	2021-10-06
t4输出：retention_num，也就是留存数，register就是该日期的新增数量

login_ts	retention_num	register
1	2021-09-21	0	1
2	2021-09-22	0	1
3	2021-09-23	0	1
4	2021-09-24	0	1
5	2021-09-25	0	1
6	2021-09-26	0	1
7	2021-09-27	0	1
8	2021-10-04	0	2
9	2021-10-04	1	2
10	2021-10-06	0	1

-- 从订单详情表（order_detail）中，求出商品连续售卖的时间区间

订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5


-- 连续的时间区间：同一用户按下单日期倒序排序，下单日期加上它本身的序号，得到的结果若一样，那么这几天就是连续的

with t1 as (
	select distinct sku_id,create_date
  	from order_detail
), t2 as (
	select sku_id, create_date, row_number() over(partition by sku_id  order by create_date desc) rn
  	from t1
), t3 as (
	select sku_id, create_date, date_add(create_date, cast(rn as int)) dadd
  	from t2
), t4 as (
	select sku_id,  dadd,
  		min(create_date) over(partition by sku_id,dadd order by create_date) start_date,
--  		max(create_date) over(partition by sku_id,dadd order by create_date) end_date
  		count(dadd) over(partition by sku_id,dadd) cnt
  	from t3
), t5 as (
	select distinct sku_id, start_date, date_add(start_date, cast(cnt as int)-1)  end_date
  	from t4
)
select * from t5
-------不知道为何max窗口函数返回的结果有问题，

t1输出：把数据打扮成成功人士的模样

sku_id	create_date
1	1	2020-10-08
2	1	2021-09-27
3	1	2021-10-01
4	1	2021-10-02
5	1	2021-10-03
6	1	2021-10-04
7	1	2021-10-05
8	1	2021-10-06
9	1	2021-10-07
t2输出：逐个数数点名批评，从最大的开始

sku_id	create_date	rn
1	1	2021-10-07	1
2	1	2021-10-06	2
3	1	2021-10-05	3
4	1	2021-10-04	4
5	1	2021-10-03	5
6	1	2021-10-02	6
7	1	2021-10-01	7
8	1	2021-09-27	8
9	1	2020-10-08	9
t3输出：日期自身与顺序相加，结果一样的就是连续的

dadd	sku_id	create_date
1	2021-10-08	1	2021-10-07
2	2021-10-08	1	2021-10-06
3	2021-10-08	1	2021-10-05
4	2021-10-08	1	2021-10-04
5	2021-10-08	1	2021-10-03
6	2021-10-08	1	2021-10-02
7	2021-10-08	1	2021-10-01
8	2021-10-05	1	2021-09-27
9	2020-10-17	1	2020-10-08
t4输出：max开窗函数失效，只能用start_date + 连续日期数(cnt-1) 这样迂回的方法求end_date

dadd	cnt	sku_id	start_date
1	2020-10-17	1	1	2020-10-08
2	2021-10-05	1	1	2021-09-27
3	2021-10-08	7	1	2021-10-01
4	2021-10-08	7	1	2021-10-01
5	2021-10-08	7	1	2021-10-01
6	2021-10-08	7	1	2021-10-01
7	2021-10-08	7	1	2021-10-01
8	2021-10-08	7	1	2021-10-01
9	2021-10-08	7	1	2021-10-01

-- 分别从登陆明细表（user_login_detail）和配送信息表中用户登录时间和下单时间统计登陆次数和交易次数

用户登录明细表：user_login_detail

user_id(用户id)	ip_address(ip地址)	login_ts(登录时间)	logout_ts(登出时间)
101	180.149.130.161	2021-09-21 08:00:00	2021-09-27 08:30:00
102	120.245.11.2	2021-09-22 09:00:00	2021-09-27 09:30:00
103	27.184.97.3	2021-09-23 10:00:00	2021-09-27 10:30:00
配送信息表：delivery_info

delivery_id （运单 id ）	order_id （订单id）	user_id （用户 id ）	order_date （下单日期）	custom_date （期望配送日期）
1	1	101	2021-09-27	2021-09-29
2	2	101	2021-09-28	2021-09-28
3	3	101	2021-09-29	2021-09-30

-- 登录时间 → 登录次数  login_ts → count(login_ts)
-- 下单时间 → 交易次数  order_date  → count(order_date)
-- 分别

with t1 as (
	select user_id, date_format(login_ts,'yyyy-MM-dd') login_date
  	from user_login_detail
), t2 as (
	select user_id,login_date ,count(1) as login_count, 0 as order_count
  	from t1
  	group by login_date,user_id
), t3 as (
	select  user_id, order_date login_date,  0 as login_count, count(1) as order_count
  	from delivery_info
  	group by user_id, order_date
), t4 as (
	select * from t2
  	union all
  	select * from t3
), t5 as (
	select user_id, login_date, sum(login_count) login_count, sum(order_count) order_count
  	from t4
  	group by user_id, login_date
), t6 as (
	select *
  	from t5
  	where login_count != 0
)
select * from t6
t1输出：处理user_login_detail表

user_id	login_date
1	101	2021-09-21
2	101	2021-09-27
3	101	2021-09-28
4	101	2021-09-29
5	101	2021-09-30
6	102	2021-09-22
7	102	2021-10-01
8	102	2021-10-01
9	102	2021-10-02
t2输出：统一格式，准备union all

login_count	order_count	user_id	login_date
1	1	0	101	2021-09-21
2	1	0	101	2021-09-27
3	1	0	101	2021-09-28
4	1	0	101	2021-09-29
5	1	0	101	2021-09-30
6	1	0	1010	2021-09-27
7	1	0	1010	2021-10-09
t3输出:整理delivery_info表，统一格式

login_count	order_count	user_id	login_date
1	0	1	101	2021-09-27
2	0	1	101	2021-09-28
3	0	1	101	2021-09-29
4	0	1	101	2021-09-30
5	0	4	1010	2021-10-08
t4输出：t2和t3联合

login_count	order_count	user_id	login_date
1	1	0	101	2021-09-21
2	1	0	101	2021-09-27
3	1	0	101	2021-09-28
4	1	0	101	2021-09-29
5	1	0	101	2021-09-30
6	0	1	101	2021-09-27
7	0	1	101	2021-09-28
8	0	1	101	2021-09-29
9	0	1	101	2021-09-30
10	1	0	1010	2021-09-27
11	1	0	1010	2021-10-09
12	0	4	1010	2021-10-08
t5输出：去重，最后输出注意去除login_count=0

login_count	order_count	user_id	login_date
1	1	0	101	2021-09-21
2	1	1	101	2021-09-27
3	1	1	101	2021-09-28
4	1	1	101	2021-09-29
5	1	1	101	2021-09-30
6	1	0	1010	2021-09-27
7	0	4	1010	2021-10-08
8	1	0	1010	2021-10-09


-- 从订单明细表（order_detail）中列出每个商品每个年度的购买总额


订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5

with t1 as (
	select sku_id, date_format(create_date,'yyyy') year_date, price*sku_num sku_sum
  	from order_detail
), t2 as (
	select sku_id, sum(sku_sum) sku_sum, year_date
  	from t1
  	group by sku_id,year_date
)
select * from t2
t1输出

sku_sum	sku_id	year_date
1	4000.00	1	2021
2	16000.00	1	2021
3	18000.00	1	2021
4	8000.00	1	2021
5	6000.00	1	2021
6	4000.00	1	2021
7	10000.00	1	2021
8	16000.00	1	2021
9	16000.00	1	2021
10	4000.00	1	2020


-- 从订单详情表（order_detail）中查询2021年9月27号-2021年10月3号这一周所有商品每天销售情况。
订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5


with t1 as (
	select  sku_id, create_date, sum(sku_num) sku_num
  	from order_detail
  	group by sku_id, create_date
), t2 as (
	select sku_id, sku_num,
  		case when create_date = date('2021-09-27') then 1
  			when create_date = date('2021-09-28') then 2
  			when create_date = date('2021-09-29') then 3
  			when create_date = date('2021-09-30') then 4
  			when create_date = date('2021-10-01') then 5
  			when create_date = date('2021-10-02') then 6
  			when create_date = date('2021-10-03') then 7  else 0 end days
  	from t1
), t3 as (
	select sku_id, sku_num, days
  	from t2
  	where days != 0 
), t4 as (
	select sku_id,  case when days = 1 then sku_num else 0 end monday,
  					case when days = 2 then sku_num else 0 end tuesday,
  					case when days = 3 then sku_num else 0 end wednesday,
  					case when days = 4 then sku_num else 0 end thursday,
  					case when days = 5 then sku_num else 0 end friday,
  					case when days = 6 then sku_num else 0 end saturday,
  					case when days = 7 then sku_num else 0 end sunday
  	from t3
), t5 as (
	select sku_id, sum(monday) monday,sum(tuesday) tuesday,sum(wednesday) wednesday,sum(thursday) thursday,sum(friday) friday,sum(saturday) saturday,sum(sunday) sunday
  	from t4 
  	group by sku_id
)
select * from t5


-- 从商品价格变更明细表（sku_price_modify_detail），得到最近一次价格的涨幅情况，并按照涨幅升序排序。


需要用到的表：
商品价格变更明细表：sku_price_modify_detail

sku_id(商品id)	new_price(本次变更之后的价格)	change_date(变更日期)
1	1900.00	2021-09-25
1	2000.00	2021-09-26
2	80.00	2021-09-29
2	10.00	2021-09-30

with t1 as (
	select sku_id, new_price,change_date,
  		row_number() over(partition by sku_id order by change_date desc) rn
  	from sku_price_modify_detail
), t2 as (
	select sku_id, lead(new_price,1,new_price) over(partition by sku_id order by change_date desc)ld_price,change_date,new_price,rn
  	from t1
  	where rn <=2
), t3 as (
	select sku_id, (new_price- ld_price) as price_change
  	from t2
  	where rn = 1
)
select * from t3
t1输出：rn --分商品按日期倒序排序，取前两个就可以

change_date	sku_id	new_price	rn
1	2021-09-26	1	2000.00	1
2	2021-09-25	1	1900.00	2
3	2021-10-02	10	100.00	1
4	2021-10-01	10	90.00	2
5	2021-10-02	11	50.00	1
6	2021-10-01	11	66.00	2
7	2021-09-29	12	20.00	1
8	2021-09-28	12	35.00	2
t2输出：取出最新价格的下一个价格，下一个计算涨幅，rn=1是一个重要条件

change_date	ld_price	sku_id	new_price	rn
1	2021-09-26	1900.00	1	2000.00	1
2	2021-09-25	1900.00	1	1900.00	2
3	2021-10-02	90.00	10	100.00	1
4	2021-10-01	90.00	10	90.00	2
5	2021-10-02	66.00	11	50.00	1
6	2021-10-01	66.00	11	66.00	2
7	2021-09-29	35.00	12	20.00	1
8	2021-09-28	35.00	12	35.00	2

-- 通过商品信息表（sku_info）订单信息表（order_info）订单明细表（order_detail）分析如果有一个用户成功下单两个及两个以上的购买成功的手机订单（购买商品为xiaomi 10，apple 12，小米13）那么输出这个用户的id及第一次成功购买手机的日期和第二次成功购买手机的日期，以及购买手机成功的次数。

订单信息表：order_info

order_id (订单id)	user_id (用户id)	create_date (下单日期)	total_amount (订单金额)
1	101	2021-09-30	29000.00
10	103	2020-10-02	28000.00
订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5
商品信息表：sku_info

sku_id(商品id)	name(商品名称)	category_id(分类id)	from_date(上架日期)	price(商品价格)
1	xiaomi 10	1	2020-01-01	2000
6	洗碗机	2	2020-02-01	2000
9	自行车	3	2020-01-01	1000


-- 用户 uesr_id 表 order_info
-- 下单 order_id 

with t1 as (
	select oi.order_id , oi.user_id, od.sku_id, od.create_date
  	from  order_detail od join order_info oi on oi.order_id  = od.order_id 
  					   join sku_info si on od.sku_id = si.sku_id
  	where si.name in ('xiaomi 10', 'apple 12', 'xiaomi 13')

), t2 as (
	select distinct user_id,create_date,
  		count(order_id) over(partition by user_id) cn,
  		dense_rank() over(partition by user_id order by create_date) dr
--  		lead(create_date,1,create_date)  over(partition by user_id order by create_date) ld_date
  	from t1
), t3 as (
	select distinct user_id,cn, 
  		min(create_date) over(partition by user_id) first_date,
  		max(create_date) over(partition by user_id) last_date
  	from t2
  	where dr <=2
)
select * from t3
t1输出：

user_id	sku_id	create_date	order_id
1	101	4	2021-09-28	2
2	101	1	2021-09-27	1
3	101	3	2021-09-27	1
4	1010	1	2020-10-08	37
5	1010	3	2020-10-08	37
6	102	4	2021-10-01	6
7	102	1	2021-10-01	5
8	102	3	2021-10-01	5
t2输出：

user_id	cn	create_date	dr
1	101	3	2021-09-27	1
2	101	3	2021-09-28	2
3	1010	2	2020-10-08	1
4	102	3	2021-10-01	1
5	103	2	2021-10-02	1
6	104	3	2021-10-03	1
7	105	2	2021-10-04	1
8	106	3	2021-10-04	1
9	106	3	2021-10-05	2

-- 从订单明细表（order_detail）中。
求出同一个商品在2021年和2022年中同一个月的售卖情况对比。



订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5



-- 售卖情况 sku_num

with t1 as (
	select sku_id, sku_num, date_format(create_date,'yyyy-MM-01') create_date
  	from order_detail
), t2 as (
	select sku_id, create_date, sum(sku_num) sku_num, date_format(create_date,'MM') month, date_format(create_date,'yyyy') year
  	from t1
  	group by sku_id, create_date
), t3 as (
	select distinct sku_id, cast(month as int) month, 
  		sum(case when year = 2020 then sku_num else 0 end) over(partition by sku_id,month) 2020_skusum,
  		sum(case when year = 2021 then sku_num else 0 end) over(partition by sku_id,month) 2021_skusum
  	from t2
)
select * from t3
t1输出：简单的格式化

sku_num	sku_id	create_date
1	2	1	2021-09-01
2	8	1	2021-10-01
3	9	1	2021-10-01
4	4	1	2021-10-01
5	3	1	2021-10-01
6	2	1	2021-10-01
7	5	1	2021-10-01
8	8	1	2021-10-01
9	8	1	2021-10-01
10	2	1	2020-10-01
t2输出：根据年-月汇总售卖数量，然后提取年份、月份，后面直接行转列

sku_num	month	year	sku_id	create_date
1	2	10	2020	1	2020-10-01
2	2	09	2021	1	2021-09-01
3	47	10	2021	1	2021-10-01
4	94	10	2020	10	2020-10-01
5	205	10	2021	10	2021-10-01
6	95	10	2020	11	2020-10-01
7	225	10	2021	11	2021-10-01
8	83	10	2020	12	2020-10-01
9	43	09	2021	12	2021-09-01
10	20556	10	2021	12	2021-10-01



-- 从订单明细表（order_detail）和收藏信息表（favor_info）统计2021国庆期间，每个商品总收藏量和购买量


订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5
收藏信息表：favor_info

user_id(用户id)	sku_id(商品id)	create_date(收藏日期)
101	3	2021-09-23
101	12	2021-09-23
101	6	2021-09-25


--  2021国庆期间指2021-10-01至2021-10-07

with t1 as (
	select sku_id, count(user_id) favor_cn
  	from favor_info
  	where create_date between date('2021-10-01') and date('2021-10-07')
  	group by sku_id
), t2 as (
	select sku_id, sum(sku_num) sku_num
  	from order_detail
  	where create_date between date('2021-10-01') and date('2021-10-07')
  	group by sku_id
), t3 as (
	select sku_id, 0 sku_num, favor_cn from t1
  	union all
  	select sku_id, sku_num, 0 favor_cn from t2
), t4 as (
	select sku_id, sum(sku_num) sku_sum, sum(favor_cn) favor_cn
  	from t3
  	group by sku_id
)
select * from t4
t1输出：处理收藏表

sku_id	favor_cn
1	1	1
2	10	2
3	11	2
4	2	1
5	4	2
6	5	1
7	6	1
8	7	1
9	9	1
t2输出：处理购买信息表

sku_num	sku_id
1	47	1
2	205	10
3	225	11
4	20556	12
5	6018	2
6	30	3
7	44	4
8	209	5
9	26	6
10	180	7
11	148	8
12	182	9
t3输出：各凭空捏造一个字段，然后union 合并去重即可

sku_num	sku_id	favor_cn
1	0	1	1
2	47	1	0
3	0	10	2
4	205	10	0
5	0	11	2
6	225	11	0
7	20556	12	0
8	0	2	1
9	6018	2	0
10	30	3	0
11	0	4	2
12	44	4	0
13	0	5	1
14	209	5	0
15	0	6	1
16	26	6	0
17	0	7	1
18	180	7	0
19	148	8	0
20	0	9	1
21	182	9	0

-- 用户等级：
忠实用户：近7天活跃且非新用户
新晋用户：近7天新增
沉睡用户：近7天未活跃但是在7天前活跃
流失用户：近30天未活跃但是在30天前活跃
假设今天是数据中所有日期的最大值，从用户登录明细表中的用户登录时间给各用户分级，求出各等级用户的人数


用户登录明细表：user_login_detail

user_id(用户id)	ip_address(ip地址)	login_ts(登录时间)	logout_ts(登出时间)
101	180.149.130.161	2021-09-21 08:00:00	2021-09-27 08:30:00
102	120.245.11.2	2021-09-22 09:00:00	2021-09-27 09:30:00
103	27.184.97.3	2021-09-23 10:00:00	2021-09-27 10:30:00


-- 理解题目：想求近7天，必须知道今夕是何年
-- 口径：从用户登录明细表中的   用户登录时间   给各用户分级
-- 理解：近N天活跃 = 近N天内有登录

with t1 as (
	select distinct user_id, date_format(login_ts,'yyyy-MM-dd') login_ts
  	from user_login_detail
), t2 as (
	select user_id,login_ts, max(login_ts) over() today, min(login_ts) over(partition by user_id) born_day,
  		max(login_ts) over(partition by user_id) last_day
  	from t1 
), t3 as (
	select user_id,login_ts,today, born_day,last_day, date_add(today,-7) 7_days, date_add(today,-30) 30_days
  	from t2 
), t4 as (
	select distinct user_id, case when last_day >= 7_days and born_day <= 7_days then "忠实用户"
  						 when born_day >= 7_days then "新增用户"
  						 when last_day <= 7_days and last_day >= 30_days then "沉睡用户" else "流失用户" end level
  	from t3
), t5 as (
	select level,count(user_id) cn
  	from t4
  	group by level
)
select * from t5
t1输出：看清数据的本质

user_id	login_ts
1	101	2021-09-21
2	101	2021-09-27
3	101	2021-09-28
4	101	2021-09-29
5	101	2021-09-30
6	1010	2021-09-27
7	1010	2021-10-09
8	102	2021-09-22
9	102	2021-10-01
10	102	2021-10-02
t2输出：获得今天、用户登录的第一天、最后一天

user_id	login_ts	today	last_day	born_day
1	101	2021-09-21	2021-10-09	2021-09-30	2021-09-21
2	101	2021-09-27	2021-10-09	2021-09-30	2021-09-21
3	101	2021-09-28	2021-10-09	2021-09-30	2021-09-21
4	101	2021-09-29	2021-10-09	2021-09-30	2021-09-21
5	101	2021-09-30	2021-10-09	2021-09-30	2021-09-21
6	1010	2021-09-27	2021-10-09	2021-10-09	2021-09-27
7	1010	2021-10-09	2021-10-09	2021-10-09	2021-09-27
8	102	2021-09-22	2021-10-09	2021-10-02	2021-09-22
9	102	2021-10-01	2021-10-09	2021-10-02	2021-09-22
10	102	2021-10-02	2021-10-09	2021-10-02	2021-09-22
t3输出：获得近7天，近30天，都准备好了

user_id	login_ts	today	30_days	last_day	7_days	born_day
1	101	2021-09-21	2021-10-09	2021-09-09	2021-09-30	2021-10-02	2021-09-21
2	101	2021-09-27	2021-10-09	2021-09-09	2021-09-30	2021-10-02	2021-09-21
3	101	2021-09-28	2021-10-09	2021-09-09	2021-09-30	2021-10-02	2021-09-21
4	101	2021-09-29	2021-10-09	2021-09-09	2021-09-30	2021-10-02	2021-09-21
5	101	2021-09-30	2021-10-09	2021-09-09	2021-09-30	2021-10-02	2021-09-21
6	1010	2021-09-27	2021-10-09	2021-09-09	2021-10-09	2021-10-02	2021-09-27
7	1010	2021-10-09	2021-10-09	2021-09-09	2021-10-09	2021-10-02	2021-09-27
8	102	2021-09-22	2021-10-09	2021-09-09	2021-10-02	2021-10-02	2021-09-22
9	102	2021-10-01	2021-10-09	2021-09-09	2021-10-02	2021-10-02	2021-09-22
10	102	2021-10-02	2021-10-09	2021-09-09	2021-10-02	2021-10-02	2021-09-22
t4输出：按要求分类然后统计即可

user_id	level
1	101	沉睡用户
2	1010	忠实用户
3	102	忠实用户
4	103	忠实用户
5	104	忠实用户
6	105	新增用户
7	106	新增用户
8	107	忠实用户
9	108	新增用户
10	109	忠实用户


/*
用户每天签到可以领1金币，并可以累计签到天数，连续签到的第3、7天分别可以额外领2和6金币。
每连续签到7天重新累积签到天数。
从用户登录明细表中求出每个用户金币总数，并按照金币总数倒序排序
*/


用户登录明细表：user_login_detail

user_id(用户id)	ip_address(ip地址)	login_ts(登录时间)	logout_ts(登出时间)
101	180.149.130.161	2021-09-21 08:00:00	2021-09-27 08:30:00
102	120.245.11.2	2021-09-22 09:00:00	2021-09-27 09:30:00
103	27.184.97.3	2021-09-23 10:00:00	2021-09-27 10:30:00


-- 当天登录记当天已签到
-- 查询出连续签到几天
-- 假设连续签到N天,那么获得N + floor(N/7) *6 + floor((N+4)/7) *2枚金币

with t1 as (
	select distinct user_id, date_format(login_ts, 'yyyy-MM-dd') login_ts
  	from user_login_detail
), t2 as (
	select user_id, login_ts, row_number() over(partition by user_id order by login_ts desc) rn
  	from t1
), t3 as (
	select user_id, date_add(login_ts, cast(rn as int)) seri_days
  	from t2
), t4 as (
	select distinct user_id, seri_days, count(1) over(partition by user_id,seri_days) days
  	from t3
), t5 as (
	select user_id , sum(days + floor(days/7) *6 + floor((days+4)/7) *2) sum_coin_cn
  	from t4
  	group by user_id
)
select * from t5
t1输出：看清数据的本质

user_id	login_ts
1	101	2021-09-21
2	101	2021-09-27
3	101	2021-09-28
4	101	2021-09-29
5	101	2021-09-30
6	1010	2021-09-27
7	1010	2021-10-09
8	102	2021-09-22
9	102	2021-10-01
10	102	2021-10-02
11	103	2021-09-23
12	103	2021-10-03
t2输出：按用户倒序排序登录时间，然后表上序号row_number

user_id	login_ts	rn
1	101	2021-09-30	1
2	101	2021-09-29	2
3	101	2021-09-28	3
4	101	2021-09-27	4
5	101	2021-09-21	5
6	1010	2021-10-09	1
7	1010	2021-09-27	2
8	102	2021-10-02	1
9	102	2021-10-01	2
10	102	2021-09-22	3
11	103	2021-10-03	1
12	103	2021-09-23	2
t3输出：登录日期+序号，得到结果一样的日期说明这几天连续签到的

user_id	seri_days
1	101	2021-10-01
2	101	2021-10-01
3	101	2021-10-01
4	101	2021-10-01
5	101	2021-09-26
6	1010	2021-10-10
7	1010	2021-09-29
8	102	2021-10-03
9	102	2021-10-03
10	102	2021-09-25
11	103	2021-10-04
12	103	2021-09-25
t4输出：现在知道各用户连续签到了几天了，最后一步求金币数

连续签到N天本身就有N个金币，

连续满3天额外奖励 floor((N+4)/7) *2枚金币

连续满7天额外奖励 floor(N/7) *6枚金币



签到天数转换为金币的公式为以下所示：

N + floor(N/7) *6 + floor((N+4)/7) *2



user_id	days	seri_days
1	101	1	2021-09-26
2	101	4	2021-10-01
3	1010	1	2021-09-29
4	1010	1	2021-10-10
5	102	1	2021-09-25
6	102	2	2021-10-03
7	103	1	2021-09-25
8	103	1	2021-10-04
9	104	1	2021-09-26
10	104	1	2021-10-04
11	105	1	2021-10-05
12	106	2	2021-10-06
13	107	1	2021-09-28
14	107	2	2021-10-07
15	108	1	2021-10-07
16	109	1	2021-09-29
17	109	1	2021-10-08
18	109	1	2021-10-09



/*
动销率定义为品类商品中一段时间内有销量的商品占当前已上架总商品数的比例（有销量的商品/已上架总商品数）。
滞销率定义为品类商品中一段时间内没有销量的商品占当前已上架总商品数的比例。（没有销量的商品 / 已上架总商品数）。
只要当天任一店铺有任何商品的销量就输出该天的结果
从订单明细表（order_detail）和商品信息表（sku_info）表中求出国庆7天每天每个品类的商品的动销率和滞销率
*/


订单明细表：order_detail

order_detail_id(订单明细id)	order_id(订单id)	sku_id(商品id)	create_date(下单日期)	price(商品单价)	sku_num(商品件数)
1	1	1	2021-09-30	2000.00	2
2	1	3	2021-09-30	5000.00	5
22	10	4	2020-10-02	6000.00	1
23	10	5	2020-10-02	500.00	24
24	10	6	2020-10-02	2000.00	5
商品信息表：sku_info

sku_id(商品id)	name(商品名称)	category_id(分类id)	from_date(上架日期)	price(商品价格)
1	xiaomi 10	1	2020-01-01	2000
6	洗碗机	2	2020-02-01	2000
9	自行车	3	2020-01-01	1000



-- 国庆7天： 10月1日-10月7日

with t1 as (
	select od.order_id, od.sku_id, od.create_date, si.category_id
  	from order_detail od right join sku_info si on od.sku_id = si.sku_id
  	where create_date between date('2021-10-01') and date('2021-10-07')
), t2 as (
	select distinct category_id, create_date,
  			count(distinct sku_id) over(partition by category_id) cate_all,
  			count(distinct sku_id) over(partition by category_id, create_date) sale_cnt
  	from t1 
), t3 as (
	select category_id, create_date,
  		case when create_date = date('2021-10-01') then cast(sale_cnt/cate_all as decimal(16,2)) else 0 end first_sale_rate,
  		case when create_date = date('2021-10-01') then cast((cate_all-sale_cnt)/cate_all as decimal(16,2)) else 0 end first_unsale_rate,
  		case when create_date = date('2021-10-02') then cast(sale_cnt/cate_all as decimal(16,2)) else 0 end second_sale_rate,  
  		case when create_date = date('2021-10-02') then cast((cate_all-sale_cnt)/cate_all as decimal(16,2)) else 0 end second_unsale_rate, 
  		case when create_date = date('2021-10-03') then cast(sale_cnt/cate_all as decimal(16,2)) else 0 end third_sale_rate,
  		case when create_date = date('2021-10-03') then cast((cate_all-sale_cnt)/cate_all as decimal(16,2)) else 0 end third_unsale_rate,
  		case when create_date = date('2021-10-04') then cast(sale_cnt/cate_all as decimal(16,2)) else 0 end fourth_sale_rate,
  		case when create_date = date('2021-10-04') then cast((cate_all-sale_cnt)/cate_all as decimal(16,2)) else 0 end fourth_unsale_rate,
		case when create_date = date('2021-10-05') then cast(sale_cnt/cate_all as decimal(16,2)) else 0 end fifth_sale_rate,
  		case when create_date = date('2021-10-05') then cast((cate_all-sale_cnt)/cate_all as decimal(16,2)) else 0 end fifth_unsale_rate,
		case when create_date = date('2021-10-06') then cast(sale_cnt/cate_all as decimal(16,2)) else 0 end sixth_sale_rate,
  		case when create_date = date('2021-10-06') then cast((cate_all-sale_cnt)/cate_all as decimal(16,2)) else 0 end sixth_unsale_rate,
		case when create_date = date('2021-10-07') then cast(sale_cnt/cate_all as decimal(16,2)) else 0 end seventh_sale_rate,
  		case when create_date = date('2021-10-07') then cast((cate_all-sale_cnt)/cate_all as decimal(16,2)) else 0 end seventh_unsale_rate
  	from t2
), t4 as (
	select category_id, 
  		sum(first_sale_rate)  first_sale_rate, 
  		sum(first_unsale_rate) first_unsale_rate,
  		sum(second_sale_rate)  second_sale_rate,
  		sum(second_unsale_rate) second_unsale_rate,
  		sum(third_sale_rate)  third_sale_rate, 
  		sum(third_unsale_rate) third_unsale_rate,
  		sum(fourth_sale_rate)  fourth_sale_rate, 
		sum(fourth_unsale_rate) fourth_unsale_rate, 
  		sum(fifth_sale_rate)  fifth_sale_rate,
  		sum(fifth_unsale_rate) fifth_unsale_rate,
  		sum(sixth_sale_rate)  sixth_sale_rate,
		sum(sixth_unsale_rate) sixth_unsale_rate,  
  		sum(seventh_sale_rate)  seventh_sale_rate,
  		sum(seventh_unsale_rate) seventh_unsale_rate
  	from t3
  	group by category_id
)
select * from t4
解析前吐槽一句，最后的输出太苦了，明明数据都一样，一直运行错误，我检查了输出的字段的字母是否一致，然后又改了下中间代码，最后发现只是输出字段的顺序问题，最后将select的列按顺序第first 到seven排好才没有报错，真无语。

t1输出：看清数据的本质，筛选国庆七天

category_id	sku_id	create_date	order_id
1	1	2	2021-10-01	5
2	1	2	2021-10-07	33
3	1	2	2021-10-06	29
4	1	2	2021-10-05	25
5	1	2	2021-10-04	21
6	1	2	2021-10-04	17
7	1	2	2021-10-02	9
8	1	1	2021-10-07	33
9	1	1	2021-10-06	29
10	1	1	2021-10-05	25
11	1	1	2021-10-04	21
12	1	1	2021-10-04	17
t2输出：得出每个商品分类的上架数量和当天的销售数量

category_id	sale_cnt	create_date	cate_all
1	1	4	2021-10-01	4
2	1	3	2021-10-02	4
3	1	3	2021-10-03	4
4	1	4	2021-10-04	4
5	1	4	2021-10-05	4
6	1	4	2021-10-06	4
7	1	4	2021-10-07	4
8	2	3	2021-10-01	4
9	2	3	2021-10-02	4
10	2	3	2021-10-03	4
11	2	4	2021-10-04	4
12	2	4	2021-10-05	4
13	2	4	2021-10-06	4
14	2	3	2021-10-07	4
15	3	1	2021-10-01	4
16	3	3	2021-10-02	4
17	3	3	2021-10-03	4
18	3	3	2021-10-04	4
19	3	4	2021-10-05	4
20	3	4	2021-10-06	4
21	3	3	2021-10-07	4
t3输出：行转列

third_unsale_rate	first_unsale_rate	fourth_unsale_rate	sixth_unsale_rate	fourth_sale_rate	fifth_sale_rate	seventh_unsale_rate	first_sale_rate	third_sale_rate	category_id	fifth_unsale_rate	seventh_sale_rate	sixth_sale_rate	second_unsale_rate	create_date	second_sale_rate
1	0.00	0.00	0.00	0.00	0.00	0.00	0.00	1.00	0.00	1	0.00	0.00	0.00	0.00	2021-10-01	0.00
2	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	1	0.00	0.00	0.00	0.25	2021-10-02	0.75
3	0.25	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.75	1	0.00	0.00	0.00	0.00	2021-10-03	0.00
4	0.00	0.00	0.00	0.00	1.00	0.00	0.00	0.00	0.00	1	0.00	0.00	0.00	0.00	2021-10-04	0.00
5	0.00	0.00	0.00	0.00	0.00	1.00	0.00	0.00	0.00	1	0.00	0.00	0.00	0.00	2021-10-05	0.00
6	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	1	0.00	0.00	1.00	0.00	2021-10-06	0.00
7	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	1	0.00	1.00	0.00	0.00	2021-10-07	0.00
8	0.00	0.25	0.00	0.00	0.00	0.00	0.00	0.75	0.00	2	0.00	0.00	0.00	0.00	2021-10-01	0.00
9	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	2	0.00	0.00	0.00	0.25	2021-10-02	0.75
10	0.25	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.75	2	0.00	0.00	0.00	0.00	2021-10-03	0.00
11	0.00	0.00	0.00	0.00	1.00	0.00	0.00	0.00	0.00	2	0.00	0.00	0.00	0.00	2021-10-04	0.00
12	0.00	0.00	0.00	0.00	0.00	1.00	0.00	0.00	0.00	2	0.00	0.00	0.00	0.00	2021-10-05	0.00
13	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	2	0.00	0.00	1.00	0.00	2021-10-06	0.00
14	0.00	0.00	0.00	0.00	0.00	0.00	0.25	0.00	0.00	2	0.00	0.75	0.00	0.00	2021-10-07	0.00
15	0.00	0.75	0.00	0.00	0.00	0.00	0.00	0.25	0.00	3	0.00	0.00	0.00	0.00	2021-10-01	0.00
16	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	3	0.00	0.00	0.00	0.25	2021-10-02	0.75
17	0.25	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.75	3	0.00	0.00	0.00	0.00	2021-10-03	0.00
18	0.00	0.00	0.25	0.00	0.75	0.00	0.00	0.00	0.00	3	0.00	0.00	0.00	0.00	2021-10-04	0.00
19	0.00	0.00	0.00	0.00	0.00	1.00	0.00	0.00	0.00	3	0.00	0.00	0.00	0.00	2021-10-05	0.00
20	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	3	0.00	0.00	1.00	0.00	2021-10-06	0.00
21	0.00	0.00	0.00	0.00	0.00	0.00	0.25	0.00	0.00	3	0.00	0.75	0.00	0.00	2021-10-07	0.00

/*
根据用户登录明细表（user_login_detail），求出平台同时在线最多的人数。

*/

用户登录明细表：user_login_detail

user_id(用户id)	ip_address(ip地址)	login_ts(登录时间)	logout_ts(登出时间)
101	180.149.130.161	2021-09-21 08:00:00	2021-09-27 08:30:00
102	120.245.11.2	2021-09-22 09:00:00	2021-09-27 09:30:00
103	27.184.97.3	2021-09-23 10:00:00	2021-09-27 10:30:00

-- 同时在线,登录一人加一人,登出一人减一人
-- 登入、登出时间按序排成一列，累加即可

with t1 as (
	select login_ts log,  1 flag
  	from user_login_detail
), t2 as (
	select logout_ts log, -1 flag
  	from user_login_detail
), t3 as (
	select * from t1
  	union all
  	select * from t2
), t4 as (
	select log,flag, sum(flag) over(order by log) online_num
  	from t3
), t5 as (
	select max(online_num) cn
  	from t4
)
select * from t5
t1输出：登入一次，用户加一个

flag	log
1	1	2021-09-21 08:00:00
2	1	2021-09-22 09:00:00
3	1	2021-09-23 10:00:00
4	1	2021-09-24 11:00:00
5	1	2021-09-25 12:00:00
6	1	2021-09-26 13:00:00
7	1	2021-09-27 08:00:00
8	1	2021-09-27 14:00:00
9	1	2021-09-28 09:00:00
10	1	2021-09-29 13:30:00
t2输出：登出一次，用户减一个

flag	log
1	-1	2021-09-27 08:30:00
2	-1	2021-09-27 08:30:00
3	-1	2021-09-27 09:30:00
4	-1	2021-09-27 10:30:00
5	-1	2021-09-27 11:30:00
6	-1	2021-09-27 12:30:00
7	-1	2021-09-27 13:30:00
8	-1	2021-09-27 14:30:00
9	-1	2021-09-28 09:10:00
10	-1	2021-09-29 13:50:00
t3输出：union all上两个表

flag	log
1	1	2021-09-21 08:00:00
2	1	2021-09-22 09:00:00
3	1	2021-09-23 10:00:00
4	1	2021-09-24 11:00:00
5	1	2021-09-25 12:00:00
6	1	2021-09-26 13:00:00
7	1	2021-09-27 08:00:00
8	-1	2021-09-27 08:30:00
9	-1	2021-09-27 08:30:00
10	-1	2021-09-27 09:30:00
11	-1	2021-09-27 10:30:00
12	-1	2021-09-27 11:30:00
13	-1	2021-09-27 12:30:00
14	-1	2021-09-27 13:30:00
t4输出：累加flag,可以看到在线人员的变化趋势(online_num)

flag	online_num	log
1	1	1	2021-09-21 08:00:00
2	1	2	2021-09-22 09:00:00
3	1	3	2021-09-23 10:00:00
4	1	4	2021-09-24 11:00:00
5	1	5	2021-09-25 12:00:00
6	1	6	2021-09-26 13:00:00
7	1	7	2021-09-27 08:00:00
8	-1	5	2021-09-27 08:30:00
9	-1	5	2021-09-27 08:30:00
10	-1	4	2021-09-27 09:30:00
11	-1	3	2021-09-27 10:30:00

-- 现有各直播间的用户访问记录表（live_events）如下，表中每行数据表达的信息为，一个用户何时进入了一个直播间，又在何时离开了该直播间。

user_id
(用户id)	live_id
(直播间id)	in_datetime
(进入直播间的时间)	out_datetime
(离开直播间的时间)
100	1	2021-12-1 19:30:00	2021-12-1 19:53:00
100	2	2021-12-1 21:01:00	2021-12-1 22:00:00
101	1	2021-12-1 19:05:00	2021-12-1 20:55:00
现要求统计各直播间最大同时在线人数，期望结果如下：

live_id
<int>
(直播id)	max_user_count
<int>
(最大人数)
1	4
2	3
3	2

with t1 as (
	select live_id, in_datetime log, 1 flag
	from live_events
), t2 as (
	select live_id, out_datetime log, -1 flag
  	from live_events
), t3 as (
	select * from t1
  	union all 
  	select * from t2
), t4 as (
	select live_id, sum(flag) over(partition by live_id order by log) online_num
  	from t3
), t5 as (
	select distinct live_id, max(online_num) over(partition by live_id) max_user_count
  	from t4
)
select * from t5
和40题差不多，这里只是多了一个直播间分类

t1输出：登入+·1

live_id	flag	log
1	1	1	2021-12-01 19:00:00
2	1	1	2021-12-01 19:30:00
3	1	1	2021-12-01 19:05:00
4	1	1	2021-12-01 19:10:00
5	1	1	2021-12-01 19:00:00
6	2	1	2021-12-01 21:01:00
7	2	1	2021-12-01 21:05:00
8	2	1	2021-12-01 19:55:00
9	2	1	2021-12-01 21:57:00
10	2	1	2021-12-01 19:10:00
11	3	1	2021-12-01 21:05:00
t2输出：登出-1

live_id	flag	log
1	1	-1	2021-12-01 19:28:00
2	1	-1	2021-12-01 19:53:00
3	1	-1	2021-12-01 20:55:00
4	1	-1	2021-12-01 19:25:00
5	1	-1	2021-12-01 20:59:00
6	2	-1	2021-12-01 22:00:00
7	2	-1	2021-12-01 21:58:00
8	2	-1	2021-12-01 21:00:00
9	2	-1	2021-12-01 22:56:00
10	2	-1	2021-12-01 19:18:00
11	3	-1	2021-12-01 22:05:00
t3输出：合并上两表，出出入入

live_id	flag	log
1	1	1	2021-12-01 19:00:00
2	1	1	2021-12-01 19:30:00
3	1	1	2021-12-01 19:05:00
4	1	1	2021-12-01 19:10:00
5	1	1	2021-12-01 19:00:00
6	1	-1	2021-12-01 19:28:00
7	1	-1	2021-12-01 19:53:00
8	1	-1	2021-12-01 20:55:00
9	1	-1	2021-12-01 19:25:00
10	1	-1	2021-12-01 20:59:00
11	2	1	2021-12-01 21:01:00
t4输出：求和累计在线人数

live_id	online_num
1	1	2
2	1	2
3	1	3
4	1	4
5	1	3
6	1	2
7	1	3
8	1	2
9	1	1
10	1	0


-- 现有页面浏览记录表（page_view_events）如下，表中有每个用户的每次页面访问记录。


user_id	page_id	view_timestamp
100	home	1659950435
100	good_search	1659950446
100	good_list	1659950457
100	home	1659950541
100	good_detail	1659950552
100	cart	1659950563
101	home	1659950435
101	good_search	1659950446
101	good_list	1659950457
101	home	1659950541
101	good_detail	1659950552
101	cart	1659950563
102	home	1659950435
102	good_search	1659950446
102	good_list	1659950457
103	home	1659950541
103	good_detail	1659950552
103	cart	1659950563
规定若同一用户的相邻两次访问记录时间间隔小于60s，则认为两次浏览记录属于同一会话。现有如下需求，为属于同一会话的访问记录增加一个相同的会话id字段，会话id格式为"user_id-number"，其中number从1开始，用于区分同一用户的不同会话，期望结果如下：

user_id
<int>
(用户id)	page_id
<string>
(页面id)	view_timestamp
<bigint>
(浏览时间戳)	session_id
<string>
(会话id)
100	home	1659950435	100-1
100	good_search	1659950446	100-1
100	good_list	1659950457	100-1
100	home	1659950541	100-2
100	good_detail	1659950552	100-2
100	cart	1659950563	100-2
101	home	1659950435	101-1
101	good_search	1659950446	101-1
101	good_list	1659950457	101-1
101	home	1659950541	101-2
101	good_detail	1659950552	101-2
101	cart	1659950563	101-2
102	home	1659950435	102-1
102	good_search	1659950446	102-1
102	good_list	1659950457	102-1
103	home	1659950541	103-1
103	good_detail	1659950552	103-1



with t1 as (
	select user_id,page_id, 
  		view_timestamp, lag(view_timestamp,1,view_timestamp) over(partition by user_id order by view_timestamp) lg
  	from page_view_events
), t2 as (
	select user_id, page_id, view_timestamp, 
  		case when view_timestamp - lg > 60 then 1 else 0 end flag
  	from t1
), t3 as (
	select user_id, page_id, view_timestamp, 
  		sum(flag) over(partition by user_id order by view_timestamp) + 1 session_num
  	from t2
), t4 as (
	select user_id, page_id, view_timestamp,  concat(user_id,'-',session_num) session_id
  	from t3
)
select * from t4
t1输出：取出timestamp的上一条记录，作差比对是否大于60

page_id	view_timestamp	user_id	lg
1	home	1659950435	100	1659950435
2	good_search	1659950446	100	1659950435
3	good_list	1659950457	100	1659950446
4	home	1659950541	100	1659950457
5	good_detail	1659950552	100	1659950541
6	cart	1659950563	100	1659950552
7	home	1659950435	101	1659950435
8	good_search	1659950446	101	1659950435
9	good_list	1659950457	101	1659950446
10	home	1659950541	101	1659950457
11	good_detail	1659950552	101	1659950541
12	cart	1659950563	101	1659950552
t2输出：用flag表示前后timestamp相差大于60，然后通过累加即可计算

page_id	flag	view_timestamp	user_id
1	home	0	1659950435	100
2	good_search	0	1659950446	100
3	good_list	0	1659950457	100
4	home	1	1659950541	100
5	good_detail	0	1659950552	100
6	cart	0	1659950563	100
7	home	0	1659950435	101
8	good_search	0	1659950446	101
9	good_list	0	1659950457	101
10	home	1	1659950541	101
11	good_detail	0	1659950552	101
12	cart	0	1659950563	101
t3输出：sum开窗后记得+1.....

page_id	session_num	view_timestamp	user_id
1	home	1	1659950435	100
2	good_search	1	1659950446	100
3	good_list	1	1659950457	100
4	home	2	1659950541	100
5	good_detail	2	1659950552	100
6	cart	2	1659950563	100
7	home	1	1659950435	101
8	good_search	1	1659950446	101
9	good_list	1	1659950457	101
10	home	2	1659950541	101
11	good_detail	2	1659950552	101
12	cart	2	1659950563	101


现有各用户的登录记录表（login_events）如下，表中每行数据表达的信息是一个用户何时登录了平台。

user_id	login_datetime
100	2021-12-01 19:00:00
100	2021-12-01 19:30:00
100	2021-12-02 21:01:00
现要求统计各用户最长的连续登录天数，间断一天也算作连续，例如：一个用户在1,3,5,6登录，则视为连续6天登录。期望结果如下：

user_id
<int>
(用户id)	max_day_count
<int>
(最大连续天数)
100	3
101	6
102	3
104	3
105	1



with t1 as (
	select distinct user_id, date_format(login_datetime, 'yyyy-MM-dd') login_datetime
	from login_events
), t2 as (
	select user_id,login_datetime, lag(login_datetime,1,login_datetime) over(partition by user_id order by login_datetime) lg_date
  	from t1
), t3 as (
	select user_id, datediff(login_datetime, lg_date) dd
  	from t2
), t4 as (           
	select distinct user_id, sum(case when dd <= 2 then dd else 0 end) over(partition by user_id)+1 max_day_count
  	from t3
)
select * from t4
开始写了一个虽然通过但是不通用的SQL，后来经过认真思考改良了一下。

t1输出：t1看透数据的本质

login_datetime	user_id
1	2021-12-01	100
2	2021-12-02	100
3	2021-12-03	100
4	2021-12-01	101
5	2021-12-03	101
6	2021-12-05	101
7	2021-12-06	101
8	2021-12-01	102
9	2021-12-02	102
10	2021-12-03	102
11	2021-12-02	104
12	2021-12-04	104
13	2021-12-01	105
t2输出：按用户分类，取当前登入日期的上一次登入日期（没有的话就是本身）

login_datetime	user_id	lg_date
1	2021-12-01	100	2021-12-01
2	2021-12-02	100	2021-12-01
3	2021-12-03	100	2021-12-02
4	2021-12-01	101	2021-12-01
5	2021-12-03	101	2021-12-01
6	2021-12-05	101	2021-12-03
7	2021-12-06	101	2021-12-05
8	2021-12-01	102	2021-12-01
9	2021-12-02	102	2021-12-01
10	2021-12-03	102	2021-12-02
11	2021-12-02	104	2021-12-02
12	2021-12-04	104	2021-12-02
13	2021-12-01	105	2021-12-01
t3输出：用本身的登入日期-上次的登入日期，求出两天的日期之差，这时候可以看透问题的本质了。

直接说结论：对用户分组，将dd值不大于2的值相加，最后加上1，就是该用户的最大连续签到天数。

dd	user_id
1	0	100
2	1	100
3	1	100
4	0	101
5	2	101
6	2	101
7	1	101
8	0	102
9	1	102
10	1	102
11	0	104
12	2	104
13	0	105


现有各品牌优惠周期表（promotion_info）如下，其记录了每个品牌的每个优惠活动的周期，其中同一品牌的不同优惠活动的周期可能会有交叉。

promotion_id	brand	start_date	end_date
1	oppo	2021-06-05	2021-06-09
2	oppo	2021-06-11	2021-06-21
3	vivo	2021-06-05	2021-06-15
现要求统计每个品牌的优惠总天数，若某个品牌在同一天有多个优惠活动，则只按一天计算。期望结果如下：

brand
<string>
(品牌)	promotion_day_count
<int>
(优惠天数)
vivo	17
oppo	16
redmi	22
huawei	22


with t1 as (
	select brand, start_date, end_date, datediff(end_date, start_date)+1 dd,
  			min(start_date) over(partition by brand) min_start,
  			max(end_date) over(partition by brand) max_end
  	from promotion_info
), t2 as (
  	select distinct brand, datediff(max_end, min_start)+1 max_min,
  		sum(dd) over(partition by brand) dd_sum
  	from t1
), t3 as (
	select brand, case when max_min >= dd_sum then dd_sum else max_min end promotion_day_count
  	from t2
)
select * from t3
t1输出：原表的列brand, start_date, end_date.然后加上最小的开始日期，最大的结束日期，以及每次优惠活动之间的日期天数dd

end_date	dd	max_end	min_start	brand	start_date
1	2021-06-26	22	2021-06-26	2021-06-05	huawei	2021-06-05
2	2021-06-15	7	2021-06-26	2021-06-05	huawei	2021-06-09
3	2021-06-21	5	2021-06-26	2021-06-05	huawei	2021-06-17
4	2021-06-09	5	2021-06-21	2021-06-05	oppo	2021-06-05
5	2021-06-21	11	2021-06-21	2021-06-05	oppo	2021-06-11
6	2021-06-21	17	2021-06-26	2021-06-05	redmi	2021-06-05
7	2021-06-15	7	2021-06-26	2021-06-05	redmi	2021-06-09
8	2021-06-26	10	2021-06-26	2021-06-05	redmi	2021-06-17
9	2021-06-15	11	2021-06-21	2021-06-05	vivo	2021-06-05
10	2021-06-21	13	2021-06-21	2021-06-05	vivo	2021-06-09
t2输出：重点来了，用最大的结束日期-最小的开始日期（max_min）

同一个品牌多次优惠日期天数dd之和dd_sum

结论：如果max_min不大于dd_sum，那么优惠最长max_min天，否则是dd_sum天。

max_min	brand	dd_sum
1	22	huawei	34
2	17	oppo	16
3	22	redmi	34
4	17	vivo	24


现有电商订单表（order_detail）如下。

order_id
(订单id)	user_id
(用户id)	product_id
(商品id)	price
（售价）	cnt
（数量）	order_date
（下单时间）
1	1	1	5000	1	2022-01-01
2	1	3	5500	1	2022-01-02
3	1	7	35	2	2022-02-01
4	2	2	3800	3	2022-03-03
注：复购率指用户在一段时间内对某商品的重复购买比例，复购率越大，则反映出消费者对品牌的忠诚度就越高，也叫回头率

此处我们定义：某商品复购率 = 近90天内购买它至少两次的人数 ÷ 购买它的总人数

近90天指包含最大日期（以订单详情表(order_detail)中最后的日期）在内的近90天。结果中复购率保留2位小数，并按复购率倒序、商品ID升序排序。

期望结果如下：

product_id
<int>
(商品id)	crp
<decimal(16,2)>
(复购率)
3	1.00
9	1.00
8	0.50
5	0.33
7	0.25
1	0.00
2	0.00
6	0.00


with t1 as (
	select order_date, user_id, product_id,order_id,
  			max(order_date) over() today,
  			date_add(max(order_date) over(), -90) today_90
  	from order_detail
), t2 as (
	select order_date, user_id, product_id,order_id
  	from t1
  	where order_date > today_90
), t3 as (
	select distinct user_id, product_id, count(1) over(partition by product_id, user_id order by product_id) user_buy_cnt
  	from t2
), t4 as (
	select user_id, product_id, user_buy_cnt, count(1) over(partition by product_id order by product_id) people_all,
  		sum(case when user_buy_cnt >= 2 then 1 else 0 end) over(partition by product_id order by product_id) people_buy_twice
  	from t3
), t5 as (
	select distinct product_id, cast(people_buy_twice/people_all as decimal(16,2)) cpr 
  	from t4
), t6 as (
	select product_id,cpr
  	from t5
  	order by cpr desc, product_id
)
select * from t6
t1输出：

order_date	user_id	product_id	today	today_90	order_id
1	2022-01-01	1	1	2022-04-05	2022-01-05	1
2	2022-02-04	1	1	2022-04-05	2022-01-05	16
3	2022-03-03	2	2	2022-04-05	2022-01-05	4
4	2022-01-04	4	2	2022-04-05	2022-01-05	10
5	2022-03-03	1	2	2022-04-05	2022-01-05	17
6	2022-01-07	4	2	2022-04-05	2022-01-05	25
7	2022-01-02	1	3	2022-04-05	2022-01-05	2
8	2022-02-04	3	3	2022-04-05	2022-01-05	7
9	2022-02-08	3	3	2022-04-05	2022-01-05	22
t2输出：

order_date	user_id	product_id	today	today_90	order_id
1	2022-01-01	1	1	2022-04-05	2022-01-05	1
2	2022-02-04	1	1	2022-04-05	2022-01-05	16
3	2022-03-03	2	2	2022-04-05	2022-01-05	4
4	2022-01-04	4	2	2022-04-05	2022-01-05	10
5	2022-03-03	1	2	2022-04-05	2022-01-05	17
6	2022-01-07	4	2	2022-04-05	2022-01-05	25
7	2022-01-02	1	3	2022-04-05	2022-01-05	2
8	2022-02-04	3	3	2022-04-05	2022-01-05	7
9	2022-02-08	3	3	2022-04-05	2022-01-05	22
t3输出：

user_buy_cnt	user_id	product_id
1	1	1	1
2	1	1	2
3	1	2	2
4	1	4	2
5	2	3	3
t4输出：

user_buy_cnt	user_id	people_all	product_id	people_buy_twice
1	1	1	1	1	0
2	1	1	3	2	0
3	1	4	3	2	0
4	1	2	3	2	0
5	2	3	1	3	1


现有用户出勤表（user_login）如下。

user_id
(用户id)	course_id
(课程id)	login_in
（登录时间）	login_out
（登出时间）
1	1	2022-06-02 09:08:24	2022-06-02 10:09:36
1	1	2022-06-02 11:07:24	2022-06-02 11:44:21
1	2	2022-06-02 13:50:24	2022-06-02 14:21:50
2	2	2022-06-02 13:50:10	2022-06-02 15:30:20
课程报名表（course_apply）如下。

course_id
(课程id)	course_name
(课程名称)	user_id
(用户id)
1	java	[1,2,3,4,5,6]
2	大数据	[1,2,3,6]
3	前端	[2,3,4,5]
注：出勤率指用户看直播时间超过40分钟，求出每个课程的出勤率（结果保留两位小数）。

期望结果如下：

course_id
<int>
(课程id)	adr
<decimal(16,2)>
(出勤率)
1	0.33
2	0.50
3	0.25






-- 今天学会一个函数： size()求数组长度

with t1 as (
	select course_id,course_name,size(user_id) user_num
  	from course_apply 
), t2 as (
	select ul.user_id, ul.course_id, ul.login_in, ul.login_out, t1.user_num
 	from user_login ul join t1 on ul.course_id = t1.course_id
), t3 as (
	select user_id, course_id, user_num,unix_timestamp(login_in)  login, unix_timestamp(login_out) logout, 
  			unix_timestamp(login_out) - unix_timestamp(login_in) dd
  	from t2
), t4 as (
	select distinct user_id, course_id, user_num,sum(dd) over(partition by user_id, course_id) watch_times
	from t3
), t5 as (
	select  user_id, course_id, user_num, 
  		sum(case when watch_times >= 2400 then 1 else 0 end) over(partition by course_id) pass_num
  	from t4
), t6 as (
	select distinct course_id, cast(pass_num/user_num as decimal(16,2)) adr
  	from t5
)
select * from t6
t1输出：size()求出用户总数量

user_num	course_id	course_name
1	6	1	java
2	4	2	大数据
3	4	3	前端
t2输出：join

user_num	course_id	login_out	user_id	login_in
1	6	1	2022-06-02 10:09:36	1	2022-06-02 09:08:24
2	6	1	2022-06-02 11:44:21	1	2022-06-02 11:07:24
3	6	1	2022-06-02 11:09:36	3	2022-06-02 09:07:24
4	4	2	2022-06-02 14:21:50	1	2022-06-02 13:50:24
5	4	2	2022-06-02 15:30:20	2	2022-06-02 13:50:10
6	4	2	2022-06-02 15:20:26	3	2022-06-02 14:00:00
7	4	2	2022-06-02 14:11:50	6	2022-06-02 13:50:24
8	4	3	2022-06-02 18:30:40	2	2022-06-02 18:10:10
9	4	3	2022-06-02 18:59:40	4	2022-06-02 18:10:10
10	4	3	2022-06-02 18:59:40	5	2022-06-02 18:30:10
t3输出：转换为时间戳

user_num	dd	course_id	logout	user_id	login
1	6	3672	1	1654164576	1	1654160904
2	6	2217	1	1654170261	1	1654168044
3	6	7332	1	1654168176	3	1654160844
4	4	1886	2	1654179710	1	1654177824
5	4	6010	2	1654183820	2	1654177810
6	4	4826	2	1654183226	3	1654178400
7	4	1286	2	1654179110	6	1654177824
8	4	1230	3	1654194640	2	1654193410
9	4	2970	3	1654196380	4	1654193410
10	4	1770	3	1654196380	5	1654194610
t4输出：统计用户观看总秒数

user_num	course_id	watch_times	user_id
1	6	1	5889	1
2	6	1	7332	3
3	4	2	1886	1
4	4	2	6010	2
5	4	2	4826	3
6	4	2	1286	6
7	4	3	1230	2
8	4	3	2970	4
9	4	3	1770	5
t5输出：统计观看超过40分钟的人数

user_num	course_id	user_id	pass_num
1	6	1	1	2
2	6	1	3	2
3	4	2	1	2
4	4	2	2	2
5	4	2	3	2
6	4	2	6	2
7	4	3	2	1
8	4	3	4	1
9	4	3	5	1


现有用户下单表（get_car_record）如下。

uid
(用户id)	city
(城市)	event_time
（下单时间）	end_time
(结束时间:取消或者接单)	order_id
(订单id)
107	北京	2021-09-20 11:00:00	2021-09-20 11:00:30	9017
108	北京	2021-09-20 21:00:00	2021-09-20 21:00:40	9008
108	北京	2021-09-20 18:59:30	2021-09-20 19:01:00	9018
102	北京	2021-09-21 08:59:00	2021-09-21 09:01:00	9002
司机订单信息表（get_car_order）如下。

order_id
(课程id)	uid
(用户id)	driver_id
(用户id)	order_time
(接单时间)	start_time
(开始时间)	finish_time
(结束时间)	fare
(费用)	grade
(评分)
9017	107	213	2021-09-20 11:00:30	2021-09-20 11:02:10	2021-09-20 11:31:00	38	5
9008	108	204	2021-09-20 21:00:40	2021-09-20 21:03:00	2021-09-20 21:31:00	38	4
9018	108	214	2021-09-20 19:01:00	2021-09-20 19:04:50	2021-09-20 19:21:00	38	5
统计周一到周五各时段的叫车量、平均等待接单时间和平均调度时间。全部以event_time-开始打车时间为时段划分依据，平均等待接单时间和平均调度时间均保留2位小数，平均调度时间仅计算完成了的订单，结果按叫车量升序排序。

注：不同时段定义：早高峰 [07:00:00 , 09:00:00)、工作时间 [09:00:00 , 17:00:00）、晚高峰 [17:00:00 ,20:00:00）、休息时间 [20:00:00 , 07:00:00） 时间区间左闭右开（即7:00:00算作早高峰，而9:00:00不算做早高峰）

从开始打车到司机接单为等待接单时间，从司机接单到上车为调度时间




with t1 as (
	select uid, date_format(event_time,'HH') event_time,
  		unix_timestamp(event_time) call_stamp,
  		unix_timestamp(end_time) wait_order_stamp
  	from get_car_record
), t2 as (
	select uid, unix_timestamp(order_time) order_stamp,
  		unix_timestamp(start_time) start_stamp,
  		unix_timestamp(finish_time) finish_stamp
  	from get_car_order
), t3 as (
	select t1.uid, cast(t1.event_time as int) event_time, t1.call_stamp, t1.wait_order_stamp, t2.start_stamp, t2.finish_stamp
  	from t1 join t2 on t1.uid = t2.uid and t1.wait_order_stamp = t2.order_stamp
), t4 as (
	select uid,event_time,call_stamp,wait_order_stamp,start_stamp,finish_stamp,
  		case when event_time =7 or event_time = 8 then "早高峰"
  			 when event_time >=9  and event_time <= 16 then "工作时间"
  			 when event_time >=17  and event_time <= 19 then "晚高峰" else "休息时间" end period
  	from t3
), t5 as (
	select uid, period, (wait_order_stamp - call_stamp) wait_time, (start_stamp - wait_order_stamp) dispatch_time,
  		count(1) over(partition by period) get_car_num
  	from t4
), t6 as (
	select distinct period, get_car_num, cast((avg(wait_time) over(partition by period)/60) as decimal(16,2))  wait_time,
  			cast((avg(dispatch_time) over(partition by period)/60) as decimal(16,2))  dispatch_time
  	from t5
)
select * from t6
t1输出：

uid	call_stamp	wait_order_stamp	event_time
1	107	1632135600	1632135630	11
2	108	1632171600	1632171640	21
3	108	1632164370	1632164460	18
4	102	1632214740	1632214860	08
5	106	1632247080	1632247260	17
6	103	1632297480	1632297660	07
7	104	1632383940	1632384060	07
8	103	1632513560	1632513660	19
9	101	1632472090	1632472200	08
t2输出：

uid	start_stamp	finish_stamp	order_stamp
1	107	1632135730	1632137460	1632135630
2	108	1632171780	1632173460	1632171640
3	108	1632164690	1632165660	1632164460
4	102	1632215160	1632216660	1632214860
5	106	1632247740	1632249060	1632247260
6	107	1632308820	1632310260	1632308460
7	103	1632298500	1632299460	1632297660
8	104	1632384780	1632385860	1632384060
9	105	1632391980	1632393060	1632391260
10	103	1632514260	1632516660	1632513660
11	101	1632472260	1632473640	1632472200
t3输出：

uid	start_stamp	call_stamp	wait_order_stamp	finish_stamp	event_time
1	102	1632215160	1632214740	1632214860	1632216660	8
2	106	1632247740	1632247080	1632247260	1632249060	17
3	101	1632472260	1632472090	1632472200	1632473640	8
4	103	1632514260	1632513560	1632513660	1632516660	19
5	104	1632384780	1632383940	1632384060	1632385860	7
6	108	1632171780	1632171600	1632171640	1632173460	21
7	103	1632298500	1632297480	1632297660	1632299460	7
8	108	1632164690	1632164370	1632164460	1632165660	18
9	107	1632135730	1632135600	1632135630	1632137460	11
t4输出：

uid	period	start_stamp	call_stamp	wait_order_stamp	finish_stamp	event_time
1	102	早高峰	1632215160	1632214740	1632214860	1632216660	8
2	106	晚高峰	1632247740	1632247080	1632247260	1632249060	17
3	101	早高峰	1632472260	1632472090	1632472200	1632473640	8
4	103	晚高峰	1632514260	1632513560	1632513660	1632516660	19
5	104	早高峰	1632384780	1632383940	1632384060	1632385860	7
6	108	休息时间	1632171780	1632171600	1632171640	1632173460	21
7	103	早高峰	1632298500	1632297480	1632297660	1632299460	7
8	108	晚高峰	1632164690	1632164370	1632164460	1632165660	18
9	107	工作时间	1632135730	1632135600	1632135630	1632137460	11
t5输出：

uid	period	dispatch_time	get_car_num	wait_time
1	108	休息时间	140	1	40
2	107	工作时间	100	1	30
3	102	早高峰	300	4	120
4	101	早高峰	60	4	110
5	104	早高峰	720	4	120
6	103	早高峰	840	4	180
7	106	晚高峰	480	3	180
8	103	晚高峰	600	3	100
9	108	晚高峰	230	3	90


现有球队表（team）如下。

team_name
(球队名称)
湖人
骑士
灰熊
勇士
拿到所有球队比赛的组合 每个队只比一次

期望结果如下：

team_name_1
<string>
(队名)	team_name_2
<string>
(队名)
勇士	湖人
湖人	骑士
灰熊	骑士
勇士	骑士
湖人	灰熊
勇士	灰熊


with t1 as (
	select team_name, 
  		case when team_name = "湖人" then 1
  			 when team_name = "骑士" then 11
  			 when team_name = "灰熊" then 22
    		 when team_name = "勇士" then 33 else 0 end rn
  	from team
),  t2 as (
	select a.team_name team_a, a.rn rna, b.team_name team_b, b.rn rnb
  	from t1 a join t1 b on a.team_name != b.team_name
), t3 as (
	select team_a, team_b, (rna+rnb) team_num , row_number() over(partition by rna+rnb order by team_a) rn
  	from t2
), t4 as (
	select team_a team_name_1, team_b team_name_2
  	from t3
  	where rn = 1
)
select * from t4
t1输出：

rn	team_name
1	1	湖人
2	11	骑士
3	22	灰熊
4	33	勇士
t2输出：

team_a	rna	rnb	team_b
1	湖人	1	33	勇士
2	湖人	1	22	灰熊
3	湖人	1	11	骑士
4	骑士	11	1	湖人
5	骑士	11	33	勇士
6	骑士	11	22	灰熊
7	灰熊	22	1	湖人
8	灰熊	22	33	勇士
9	灰熊	22	11	骑士
10	勇士	33	1	湖人
11	勇士	33	22	灰熊
12	勇士	33	11	骑士
t3输出：筛选rn=1的即可

team_a	team_num	rn	team_b
1	湖人	12	1	骑士
2	骑士	12	2	湖人
3	湖人	23	1	灰熊
4	灰熊	23	2	湖人
5	灰熊	33	1	骑士
6	骑士	33	2	灰熊
7	勇士	34	1	湖人
8	湖人	34	2	勇士
9	勇士	44	1	骑士
10	骑士	44	2	勇士
11	勇士	55	1	灰熊
12	灰熊	55	2	勇士


现有用户视频表（user_video_log）如下。

uid
(球队名称)	video_id
(视频id)	start_time
(开始时间)	end_time
(结束时间)	if_like
(是否点赞)	if_retweet
(是否喜欢)	comment_id
(评论id)
101	2001	2021-09-24 10:00:00	2021-09-24 10:00:20	1	0	null
105	2002	2021-09-25 11:00:00	2021-09-25 11:00:30	0	1	null
102	2002	2021-09-25 11:00:00	2021-09-25 11:00:30	1	1	null
101	2002	2021-09-26 11:00:00	2021-09-26 11:00:30	0	1	null
视频信息表(video_info) 如下：

video_id
(视频id)	author
(作者id)	tag
(标签)	duration
(视频时长)
2001	901	旅游	30
2002	901	旅游	60
2003	902	影视	90
2004	902	美女	90
找出近一个月发布的视频中热度最高的top3视频。

注：热度=(a*视频完播率+b*点赞数+c*评论数+d*转发数)*新鲜度；

新鲜度=1/(最近无播放天数+1)；

当前配置的参数a,b,c,d分别为100、5、3、2。

最近播放日期以 end_time-结束观看时间 为准，假设为T，则最近一个月按 [T-29, T] 闭区间统计。

当天日期使用视频中最大的end_time

结果中热度保留为整数，并按热度降序排序。





-- 1、这就是语言的力量：
-- 当天日期使用视频中最大的end_time 
-- 最近播放的一天也是使用视频中最大的end_time
-- 因此在本题中最近无播放天数 = 0
-- 新鲜度 = 1/(最近无播放天数+1) = 1
-- 2、视频完播 = 观看时长 > 视频时长
-- 视频完播率 = 观看时长 > 视频时长 的观看次数 / 总观看次数
-- 3、retweet就是转发的意思，并非"是否喜欢"
-- 4、热度最高的top3


with t1 as (
  	select uid, video_id, start_time, end_time,if_like, if_retweet, case when comment_id is null then 0 else 1 end comments,
  		max(date_format(end_time,'yyyy-MM-dd')) over(partition by video_id)  today,   date_add( max(date_format(end_time,'yyyy-MM-dd')) over(partition by video_id),-29) begin
  	from user_video_log
), t2 as (
	select t1.uid, t1.video_id,  t1.if_like, t1.if_retweet, t1.comments, vi.duration,
  		unix_timestamp(t1.end_time) - unix_timestamp(t1.start_time) watch_duration,
  		datediff(today,  today) no_play_days
  	from t1 join video_info vi on t1.video_id = vi.video_id
  	where date_format(t1.start_time,'yyyy-MM-dd') > t1.begin
), t3 as (
	select distinct video_id,  no_play_days,
  		sum(case when watch_duration >= duration then 1 else 0 end) over(partition by video_id) / count(1) over(partition by video_id) complete_pay_rate,
  		sum(if_like) over(partition by video_id) like_num,
  		sum(comments) over(partition by video_id) comments,
  		sum(if_retweet) over(partition by video_id) retweet_num
  	from t2
), t4 as (
	select video_id, ceil( (100*complete_pay_rate + 5*like_num + 3*comments + 2*retweet_num)/(1/(no_play_days + 1)) ) heat
  	from t3
), t5 as (
	select video_id, heat, row_number() over(order by heat desc) rn
  	from t4
), t6 as (
	select video_id, cast(heat as decimal(16,1)) heat
  	from t5
  	where rn <= 3
  	order by rn
)
select * from t6
t1输出：看清数据的本质

uid	start_time	if_retweet	if_like	comments	today	end_time	begin	video_id
1	101	2021-10-01 10:00:00	0	1	0	2021-10-01	2021-10-01 10:00:20	2021-09-02	2001
2	102	2021-10-01 10:00:00	1	0	0	2021-10-01	2021-10-01 10:00:15	2021-09-02	2001
3	103	2021-10-01 11:00:50	0	1	1	2021-10-01	2021-10-01 11:01:15	2021-09-02	2001
4	101	2021-09-24 10:00:00	0	1	0	2021-10-01	2021-09-24 10:00:20	2021-09-02	2001
5	102	2021-09-30 11:00:00	1	1	0	2021-10-03	2021-09-30 11:00:30	2021-09-04	2002
6	105	2021-09-25 11:00:00	1	0	0	2021-10-03	2021-09-25 11:00:30	2021-09-04	2002
7	102	2021-09-25 11:00:00	1	1	0	2021-10-03	2021-09-25 11:00:30	2021-09-04	2002
8	101	2021-09-26 11:00:00	1	0	0	2021-10-03	2021-09-26 11:00:30	2021-09-04	2002
9	101	2021-09-27 11:00:00	0	1	0	2021-10-03	2021-09-27 11:00:30	2021-09-04	2002
t2输出：筛选【T-29,T】的时间区间，完成数据的清洗和join到所需的字段，基于下表准备开干

duration	uid	if_retweet	if_like	comments	watch_duration	no_play_days	video_id
1	30	101	0	1	0	20	0	2001
2	30	102	1	0	0	15	0	2001
3	30	103	0	1	1	25	0	2001
4	30	101	0	1	0	20	0	2001
5	60	102	1	1	0	30	0	2002
6	60	105	1	0	0	30	0	2002
7	60	102	1	1	0	30	0	2002
8	60	101	1	0	0	30	0	2002
9	60	101	0	1	0	30	0	2002
t3输出：解释字段：

no_play_days：最近无播放天数

complete_pay_rate：视频完播率

like_num：点赞数

comments：评论数

retweet_num：转发数

like_num	comments	complete_pay_rate	retweet_num	no_play_days	video_id
1	3	1	0.0	1	0	2001
2	5	0	0.36363636363636365	9	0	2002
t4输出：还要处理最后一个要求：热度最高的top3，热度倒序排序

heat	video_id
1	20	2001
2	80	2002
t5输出：如下表，下一步取前3个rn（倒序）即可，heat保留一位小数

heat	rn	video_id
1	20	2	2001
2	80	1	2002


现有用户表（emp）如下。

id
(员工id)	en_dt
(入职日期)	start_time
(离职日期)
1001	2020-01-02	null
1002	2020-01-02	2020-03-05
1003	2020-02-02	2020-02-15
1004	2020-02-12	2020-03-08
日历表(cal) 如下：

dt
(日期)
2020-01-01
2020-01-02
2020-01-03
2020-01-04
统计2020年每个月实际在职员工数量(只统计2020-03-31之前)，如果1个月在职天数只有1天，数量计算方式：1/当月天数。

如果一个月只有一天的话，只算30分之1个人

期望结果如下：

mnt
<int>
(月份)	ps
<decimal(16,2)>
(在职人数)
1	1.94
2	3.62
3	2.23



-- 用户表enpd的离职日期字段是le_dt，参考报错原因


with t1 as (
  	select id, en_dt, case when le_dt is null then date('2020-03-31')
  						   when le_dt > date('2020=03-31') then date('2020-03-31') else le_dt end le_dt
  	from emp
), t2 as (
	select id, en_dt,le_dt, dt, date_format(dt,'MM') months
  	from t1 join cal on t1.en_dt <= cal.dt and t1.le_dt >= cal.dt
  	where date_format(en_dt,'yyyy') = 2020
), t3 as (
	select distinct id, cast(months as int) mth,
  		count(dt) over(partition by id, en_dt, months) work_days,
  		case when months = '01' then 31 
  			 when months = '02' then 29
  			 when months = '03' then 31 else 0 end month_days
  	from t2
), t4 as (
 	select distinct mth, cast( (sum(work_days) over(partition by mth) / month_days) as decimal(16,2) ) ps
  	from t3
)
select * from t4
t1输出：

en_dt	le_dt	id
1	2020-01-02	2020-03-31	1001
2	2020-01-02	2020-03-05	1002
3	2020-02-02	2020-02-15	1003
4	2020-02-12	2020-03-08	1004
5	2020-02-15	2020-03-05	1005
6	2020-03-13	2020-03-16	1006
7	2020-03-16	2020-03-31	1007
t2输出：

dt	months	en_dt	le_dt	id
1	2020-01-02	01	2020-01-02	2020-03-31	1001
2	2020-01-02	01	2020-01-02	2020-03-05	1002
3	2020-01-03	01	2020-01-02	2020-03-31	1001
4	2020-01-03	01	2020-01-02	2020-03-05	1002
5	2020-01-04	01	2020-01-02	2020-03-31	1001
6	2020-01-04	01	2020-01-02	2020-03-05	1002
7	2020-01-05	01	2020-01-02	2020-03-31	1001
8	2020-01-05	01	2020-01-02	2020-03-05	1002
9	2020-01-06	01	2020-01-02	2020-03-31	1001
10	2020-01-06	01	2020-01-02	2020-03-05	1002
t3输出：

mth	month_days	id	work_days
1	1	31	1001	30
2	2	29	1001	29
3	3	31	1001	31
4	1	31	1002	30
5	2	29	1002	29
6	3	31	1002	5
7	2	29	1003	14
8	2	29	1004	18
9	3	31	1004	8
10	2	29	1005	15
11	3	31	1005	5
12	3	31	1006	4
13	3	31	1007	16

1、 -- 查询订单明细表（order_detail）中销量（下单件数）排名第二的商品id，如果不存在返回null，如果存在多个排名第二的商品则需要全部返回。
-- nullif 函数是接受2个参数的控制流函数之一。如果第一个参数等于第二个参数，则NULLIF函数返回NULL，否则返回第一个参数。
		-- 1、 if（表达式，值1，值2） 如果表达式成立，则返回值1，否则返回值2
		-- 2、 ifnull（字段名称，值1） 如果字段值为空，则返回值1，否则返回字段本身的值
		-- 3 、nullif（值1，值2） 如果值1=值2，则返回null，否则返回值1
select
nullif((
select
    distinct sku_id
from (select
        sku_id,
        rank() over (order by sum(sku_num) desc ) rk
    from order_detail
    group by sku_id) t1
where rk=2),null) sku_id;


2、 -- 查询订单信息表(order_info)中最少连续3天下单的用户id：
 -- lead 往下
 -- lag 往上
select distinct user_id 
from (select *, datediff(next2,create_date) diff
from(
select user_id, create_date, 
  lead(create_date,2,'1990-01-01') over (partition by user_id order by user_id) next2 from order_info
  ) t1
 ) t2
 where diff >= 2;
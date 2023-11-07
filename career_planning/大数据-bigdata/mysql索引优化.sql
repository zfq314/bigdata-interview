# like '%zj' 这样的话不走索引，索引失效，% 表示全匹配 % 在前，就代表，我前面的内容不确定。不确定，我们怎么比较？只能一个一个的比较，那就相当于，全匹配了，全匹配就不需要索引，还不如直接全表扫描。
explain select * from t_ka_splsz where rq = '2022-11-07' and djh   like '%zj';

# like '%zj%' 这样的话不走索引，索引失效

explain select * from t_ka_splsz where rq = '2022-11-07' and djh   like '%zj%';

# like 'zj%' 这样的话走索引，索引有效

explain select * from t_ka_splsz where rq = '2022-11-07' and djh   like 'zj%';


# like 'zj%' 这样的话不走索引全表扫描
explain select * from t_ka_splsz where rq = '2022-11-07' and djh  not  like 'zj%';

#使用复合索引中的wdmc走索引，效率明显提升
explain select * from t_ka_splsz where rq = '2022-11-07' and wdmc='深圳展厅' and djh  not  like 'zj%';




CREATE TABLE `user` (

`id` int(5) unsigned NOT NULL AUTO_INCREMENT,

`create_time` datetime NOT NULL,

`name` varchar(5) NOT NULL,

`age` tinyint(2) unsigned zerofill NOT NULL,

`sex` char(1) NOT NULL,

`mobile` char(12) NOT NULL DEFAULT '',

`address` char(120) DEFAULT NULL,

`height` varchar(10) DEFAULT NULL,

PRIMARY KEY (`id`),

KEY `idx_createtime` (`create_time`) USING BTREE,

KEY `idx_name_age_sex` (`name`,`sex`,`age`) USING BTREE,

KEY `idx_ height` (`height`) USING BTREE,

KEY `idx_address` (`address`) USING BTREE,

KEY `idx_age` (`age`) USING BTREE

) ENGINE=InnoDB AUTO_INCREMENT=261 DEFAULT CHARSET=utf8;

INSERT INTO `bingfeng`.`user`(`id`, `create_time`, `name`, `age`, `sex`, `mobile`, `address`, `height`) VALUES (1, '2019-09-02 10:17:47', '冰峰', 22, '男', '1', '陕西省咸阳市彬县', '175');

INSERT INTO `bingfeng`.`user`(`id`, `create_time`, `name`, `age`, `sex`, `mobile`, `address`, `height`) VALUES (2, '2020-09-02 10:17:47', '松子', 13, '女', '1', NULL, '180');

INSERT INTO `bingfeng`.`user`(`id`, `create_time`, `name`, `age`, `sex`, `mobile`, `address`, `height`) VALUES (3, '2020-09-02 10:17:48', '蚕豆', 20, '女', '1', NULL, '180');

INSERT INTO `bingfeng`.`user`(`id`, `create_time`, `name`, `age`, `sex`, `mobile`, `address`, `height`) VALUES (4, '2020-09-02 10:17:47', '冰峰', 20, '男', '17765010977', '陕西省西安市', '155');

INSERT INTO `bingfeng`.`user`(`id`, `create_time`, `name`, `age`, `sex`, `mobile`, `address`, `height`) VALUES (255, '2020-09-02 10:17:47', '竹笋', 22, '男', '我测试下可以储存几个中文', NULL, '180');

INSERT INTO `bingfeng`.`user`(`id`, `create_time`, `name`, `age`, `sex`, `mobile`, `address`, `height`) VALUES (256, '2020-09-03 10:17:47', '冰峰', 21, '女', '', NULL, '167');

INSERT INTO `bingfeng`.`user`(`id`, `create_time`, `name`, `age`, `sex`, `mobile`, `address`, `height`) VALUES (257, '2020-09-02 10:17:47', '小红', 20, '', '', NULL, '180');

INSERT INTO `bingfeng`.`user`(`id`, `create_time`, `name`, `age`, `sex`, `mobile`, `address`, `height`) VALUES (258, '2020-09-02 10:17:47', '小鹏', 20, '', '', NULL, '188');

INSERT INTO `bingfeng`.`user`(`id`, `create_time`, `name`, `age`, `sex`, `mobile`, `address`, `height`) VALUES (259, '2020-09-02 10:17:47', '张三', 20, '', '', NULL, '180');

INSERT INTO `bingfeng`.`user`(`id`, `create_time`, `name`, `age`, `sex`, `mobile`, `address`, `height`) VALUES (260, '2020-09-02 10:17:47', '李四', 22, '', '', NULL, '165');



单个索引
1、使用!= 或者 <> 导致索引失效 (5.0版本，!=、<>都会造成索引失效)(8.0版本的mysql，的确是!=、<>都走索引，其中!=、<>表示范围查询。)

SELECT * FROM `user` WHERE `name` != '冰峰';

我们给name字段建立了索引，但是如果!= 或者 <> 这种都会导致索引失效，进行全表扫描，所以如果数据量大的话，谨慎使用
可以通过分析SQL看到，type类型是ALL，扫描了10行数据，进行了全表扫描。<>也是同样的结果。



2、类型不一致导致的索引失效

在说这个之前，一定要说一下设计表字段的时候，千万、一定、必须要保持字段类型的一致性，啥意思？比如user表的id是int自增，到了用户的账户表user_id这个字段，一定、必须也是int类型，千万不要写成varchar、char什么的骚操作。

SELECT * FROM `user` WHERE height= 175;

这个SQL诸位一定要看清楚，height表字段类型是varchar，但是我查询的时候使用了数字类型，因为这个中间存在一个隐式的类型转换，所以就会导致索引失效，进行全表扫描。

现在明白我为啥说设计字段的时候一定要保持类型的一致性了不，如果你不保证一致性，一个int一个varchar，在进行多表联合查询(eg: 1 = '1')必然走不了索引。
 

 3、函数导致的索引失效

SELECT * FROM `user` WHERE DATE(create_time) = '2020-09-03';

如果你的索引字段使用了索引，对不起，他是真的不走索引的。



4、运算符导致的索引失效

SELECT * FROM `user` WHERE age - 1 = 20;

如果你对列进行了(+，-，*，/，!), 那么都将不会走索引。



5、OR引起的索引失效 (8.x index_merge 对多个索引分别进行条件扫描，然后将它们各自的结果进行合并(intersect/union)。5.x or的非同类型的数据索引会失效)

SELECT * FROM `user` WHERE `name` = '张三' OR height = '175' ;

OR导致索引是在特定情况下的，并不是所有的OR都是使索引失效，如果OR连接的是同一个字段，那么索引不会失效，反之索引失效。


6、模糊搜索导致的索引失效

SELECT * FROM `user` WHERE `name` LIKE '%冰';

这个我相信大家都明白，模糊搜索如果你前缀也进行模糊搜索，那么不会走索引。(不确定开头,所以会全表扫描)


7、NOT IN（5.x 《不走索引》和8.x《走索引》也是不一样的）、NOT EXISTS导致索引失效

SELECT s.* FROM `user` s WHERE NOT EXISTS (SELECT * FROM `user` u WHERE u.name = s.`name` AND u.`name` = '冰峰')

SELECT * FROM `user` WHERE `name` NOT IN ('冰峰');
 

 这两种用法，也将使索引失效。但是NOT IN 还是走索引的，千万不要误解为 IN 全部是不走索引的。


8、IS NULL不走索引，IS NOT NULL走索引

SELECT * FROM `user` WHERE address IS NULL 不走索引。

SELECT * FROM `user` WHERE address IS NOT NULL; 走索引

根据这个情况，建议大家这设计字段的时候，如果没有必要的要求必须为NULL，那么最好给个默认值空字符串


复合索引

1、最左匹配原则

EXPLAIN SELECT * FROM `user` WHERE sex = '男';

EXPLAIN SELECT * FROM `user` WHERE name = '冰峰' AND sex = '男';

测试之前，删除其他的单列索引。

啥叫最左匹配原则，就是对于复合索引来说，它的一个索引的顺序是从左往右依次进行比较的，像第二个查询语句，name走索引，接下来回去找age，结果条件中没有age那么后面的sex也将不走索引。


注意：

SELECT * FROM `user` WHERE sex = '男' AND age = 22 AND `name` = '冰峰';

可能有些搬砖工可能跟我最开始有个误解，我们的索引顺序明明是name、sex、age，你现在的查询顺序是sex、age、name，这肯定不走索引啊，你要是自己没测试过，也有这种不成熟的想法，那跟我一样还是太年轻了，它其实跟顺序是没有任何关系的，因为mysql的底层会帮我们做一个优化，它会把你的SQL优化为它认为一个效率最高的样子进行执行。所以千万不要有这种误解。

2、如果使用了!=会导致后面的索引全部失效

SELECT * FROM `user` WHERE sex = '男' AND `name` != '冰峰' AND age = 22;

我们在name字段使用了 != ，由于name字段是最左边的一个字段，根据最左匹配原则，如果name不走索引，后面的字段也将不走索引。


1.复合索引绑定的第一个列,没有出现在查询条件中;（全部失效）
2.复合索引绑定的多个列是有顺序的,某一个列没有出现在查询条件中,存储引擎不能使用索引中该列及其后的所有列。


在实际开发中，对sql语句进行调优，就要尽量避免出现以上索引失效的情况。

对于单键索引，尽量选择针对当前查询过滤性更好的索引，
能选择复合索引的尽量选择复合索引。

在选择复合索引的时候，当前查询中过滤性最好的字段在索引字段顺序中，位置越靠前越好。

在选择复合索引的时候，尽量选择可以能够包含当前query中的where字句中更多字段的索引。

在选择复合索引的时候，如果某个字段可能出现范围查询时，尽量把这个字段放在索引次序的最后面。
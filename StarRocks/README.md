ClickHouse  
join 不好
适合建宽表
通过拼宽表避免聚合操作



StarRocks

			StarRocks 对于 join 的能力更强，可以建立星型或者雪花模型应对维度数据的变更。

			在 StarRocks 中提供了三种不同类型的 join：			当小表与大表关联时，可以使用 boardcast join，小表会以广播的形式加载到不同节点的内存中
			当大表与大表关联式，可以使用 shuffle join，两张表值相同的数据会 shuffle 到相同的机器上
			为了避免 shuffle 带来的网络与 I/O 的开销，也可以在创建表示就将需要关联的数据存储在同一个 colocation group 中，使用 colocation join

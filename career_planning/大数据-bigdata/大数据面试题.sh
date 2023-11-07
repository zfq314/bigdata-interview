flinkcdc 全称：
 			
				flink-cdc-connectors

flinkCDC 能不能监控 mg？ 可以 还支持其他类型数据库
		例如： db2
			  debezium
			  mongodb
			  mysql
			  oceanbase
			  oracle
			  postgres
			  sqlserver
			  tidb

flink 怎么保证精准一次?
 	分三块:	 
 			Source 端精准一次处理
 					数据从上一阶段进入到 Flink 时，需要保证消息精准一次消费
 		    flink 应用端精准一次处理
 		    		利用 Checkpoint 机制，把状态存盘，发生故障的时候可以恢复，保证内部的状态一致性
 		    Sink 端精准一次处理
 		    		将处理完的数据发送到下一阶段时，需要保证数据能够准确无误发送到下一阶段。

			在 Flink 1.4 版本正式引入了一个里程碑式的功能：两阶段提交 Sink，即 TwoPhaseCommitSinkFunction 函数。该 SinkFunction 提取并封装了两阶段提交协议中的公共逻辑，自此 Flink 搭配特定 Source 和 Sink（如 Kafka 0.11 版）实现精确一次处理语义(英文简称：EOS，即 Exactly-Once Semantics)。

			对于 Source 端：Source 端的精准一次处理比较简单，毕竟数据是落到 Flink 中，所以 Flink 只需要保存消费数据的偏移量即可， 如消费 Kafka 中的数据，Flink 将 Kafka Consumer 作为 Source，可以将偏移量保存下来，如果后续任务出现了故障，恢复的时候可以由连接器重置偏移量，重新消费数据，保证一致性。

			对于 Sink 端：Sink 端是最复杂的，因为数据是落地到其他系统上的，数据一旦离开 Flink 之后，Flink 就监控不到这些数据了，所以精准一次处理语义必须也要应用于 Flink 写入数据的外部系统，故这些外部系统必须提供一种手段允许提交或回滚这些写入操作，同时还要保证与 Flink Checkpoint 能够协调使用（Kafka 0.11 版本已经实现精确一次处理语义）。

			我们以 Flink 与 Kafka 组合为例，Flink 从 Kafka 中读数据，处理完的数据在写入 Kafka 中。

			为什么以Kafka为例，第一个原因是目前大多数的 Flink 系统读写数据都是与 Kafka 系统进行的。第二个原因，也是最重要的原因 Kafka 0.11 版本正式发布了对于事务的支持，这是与Kafka交互的Flink应用要实现端到端精准一次语义的必要条件。

			当然，Flink 支持这种精准一次处理语义并不只是限于与 Kafka 的结合，可以使用任何 Source/Sink，只要它们提供了必要的协调机制。


			Flink 的两阶段提交思路：

			我们从 Flink 程序启动到消费 Kafka 数据，最后到 Flink 将数据 Sink 到 Kafka 为止，来分析 Flink 的精准一次处理
			当 Checkpoint 启动时，JobManager 会将检查点分界线（checkpoint battier）注入数据流，checkpoint barrier 会在算子间传递下去
			Source 端：Flink Kafka Source 负责保存 Kafka 消费 offset，当 Chckpoint 成功时 Flink 负责提交这些写入，否则就终止取消掉它们，当 Chckpoint 完成位移保存，它会将 checkpoint barrier（检查点分界线） 传给下一个 Operator，然后每个算子会对当前的状态做个快照，保存到状态后端（State Backend）。
			对于 Source 任务而言，就会把当前的 offset 作为状态保存起来。下次从 Checkpoint 恢复时，Source 任务可以重新提交偏移量，从上次保存的位置开始重新消费数据
			Slink 端：从 Source 端开始，每个内部的 transform 任务遇到 checkpoint barrier（检查点分界线）时，都会把状态存到 Checkpoint 里。数据处理完毕到 Sink 端时，Sink 任务首先把数据写入外部 Kafka，这些数据都属于预提交的事务（还不能被消费），此时的 Pre-commit 预提交阶段下 Data Sink 在保存状态到状态后端的同时还必须预提交它的外部事务，
			当所有算子任务的快照完成（所有创建的快照都被视为是 Checkpoint 的一部分），也就是这次的 Checkpoint 完成时，JobManager 会向所有任务发通知，确认这次 Checkpoint 完成，此时 Pre-commit 预提交阶段才算完成。才正式到两阶段提交协议的第二个阶段：commit 阶段。该阶段中 JobManager 会为应用中每个 Operator 发起 Checkpoint 已完成的回调逻辑。

			本例中的 Data Source 和窗口操作无外部状态，因此在该阶段，这两个 Opeartor 无需执行任何逻辑，但是 Data Sink 是有外部状态的，此时我们必须提交外部事务，当 Sink 任务收到确认通知，就会正式提交之前的事务，Kafka 中未确认的数据就改为“已确认”，数据就真正可以被消费了，


			Flink 端到端精准一次处理语义总结：
			1. Flink 消费到 Kafka 数据之后，就会开启一个 Kafka 的事务，正常写入 Kafka 分区日志但标记为未提交，这就是 Pre - commit （预提交）
			2．一旦所有的 Operator 完成各自的 Pre - commit ，它们会发起一个 commit 操作。
			3．如果有任意一个 Pre - commit 失败，所有其他的 Pre - commit 必须停止，井且 Flink 会回滚到最近成功完成的 Checkpoint 。
			4．当所有的 Operator 完成任务时， Slink 端就收到
			 checkpoint barrier （检查点分界线）, Sink 保存当前状态，存入 Checkpoint ，通知 JobManager ，并提交外部事务，用于提交外部检查点的数据。
			5. JobManager 收到所有任务的通知，发出确认信息，表示 Checkpoint 已完成， Slink 收到 JobManager 的确认信息，正式 commit （提交）
			这段时间的数据。
			6．外部系统（ Kafka ）关闭事务，提交的数据可以正常消费了
			从以上过程中我们也能发现，一旦 Pre - commit 完成，必须要确保 commit 也要成功， Operator 和外部系统都需要对此进行保证。如果 commit 失败（如网络故障等）, Flink 应用就会崩溃，然后根据用户重启策略进行重启，之后在重试
			 commit 。这个过程非常重要，因为如果 commit 无法顺利执行，就可能出现数据丢失情况，因此，所有的 Operator 必须对 Checkpoint 最终结果达成共识：即所有的 Operator 都必须认定数据提交要么成功执行，要么被终止然后回滚。正好两阶段提交协议（2PC）就是解决分布式的事务问题，所以才能有如今 Flink 可以端到端精准一次处理。


hive 怎么对 JSON 解析 ： get_json_object
	 select get_json_object('{"name":"zhangsan","age":18}','$.name'); 

	Hive SQL中的 lateral view 与 explode（列转行）以及行转列
			 select movie,category_name
		from  movies 
		lateral view explode(category) table_tmp as category_name;

	 
		多列炸裂 Posexplode(https://zhuanlan.zhihu.com/p/115918587)
		可以进行两次posexplode，姓名和成绩都保留对应的序号，即使变成了9行，也通过where条件只保留序号相同的行即可。
			select 
		class,student_name,student_score
	from 
		default.classinfo
	    lateral view posexplode(split(student,',')) sn as student_index_sn,student_name
	    lateral view posexplode(split(score,',')) sc as student_index_sc,student_score
	where
	    student_index_sn = student_index_sc;
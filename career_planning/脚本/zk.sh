# zkCli.sh 进 退
进 zkCLi.sh  退 quit
# 注册信息
cluster
controller
brokers
zookeeper
yarn-leader-election
hadoop-ha
dolphinscheduler
admin
isr_change_notification
controller_epoch
rmstore
consumers
latest_producer_id_block
config

DELETE 删除节点 如delete /zknode1

删除节点命令，此命令与delete命令不同的是delete不可删除有子节点的节点，但是rmr命令可以删除，注意路径为绝对路径。
如rmr 
/zookeeper/znode
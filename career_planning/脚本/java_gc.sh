jvisualvm远程监控 visualgc

第一步： 添加远程代理文件
jstatd.all.policy

jstatd.all.policy 文件的具体内容

grant codebase "file:/data/program/jdk1.8.0_144/lib/tools.jar" {
   permission java.security.AllPermission;
};

第二步 ： 启动相关进程



jstatd -J-Djava.security.policy=/root/jstatd.all.policy -J-Djava.rmi.server.hostname=10.10.80.31 -J-Djava.rmi.server.logCalls=true &

第三步： jvisualvm 远程启动

第四步： 在远程上添加监听的主机和端口
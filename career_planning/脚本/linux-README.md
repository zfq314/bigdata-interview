##### linux命令

```shell
查看进程占用：ps -ef |grep 30598

根据端口号获取进程号并杀掉：netstat -tunlp |grep 10000|awk -F " " '{print$7}'|awk -F "/" '{print$1}'|xargs kill -9 

rpm批量卸载： sudo rpm -qa |grep -i jdk|grep -v grep | xargs -n1 rpm -e --nodeps

当前目录文件夹磁盘占用：du -sh ./

当前目录下的大小各个目录的大小(常用)：du -h --max-depth=1

linux脚本执行java -jar: cd /data/program/project/applog; java -jar gmall2020-mock-log-2021-10-10.jar >/dev/null 2>&1 & 


if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

-f ~/.bashrc 判断home目录的.bashrc是普通文件的话 返回真
. ~/.bashrc 等于source ~/.bashrc 让home目录下的.bashrc里的设置生效

环境变量嵌套：.bash_profile -> . ~/.bashrc -> ./etc/bashrc 里面有一段：for i in /etc/profile.d/*.sh;  所以自定义环境脚本放在/etc/profile.d 下面的即可

awk 获取某一行 ifconfig |awk 'NR==2' 
linux ip 获取 : 
                ifconfig|awk 'NR==2'|awk -F " " '{print$2}'
                'NR==2' 指定行数,这个方式不太靠谱
                ifconfig |grep -i "inet"|grep -i "netmask"|awk -F " " '{print$2}'|grep -v '^127' -- grep -v 正则匹配忽略某个字符串开头的
         
        [root@hadoop31 ~]# ifconfig |grep -i "inet"|grep -i "netmask"|cut -d " " -f10|awk 'NR==1'
				10.10.80.31
				[root@hadoop31 ~]# ifconfig |grep -i "inet"|grep -i "netmask"|cut -d " " -f10|grep -v '127'
				10.10.80.31
				[root@hadoop31 ~]# ifconfig |grep -i "inet"|grep -i "netmask"|cut -d " " -f10|grep -v '^127'
				10.10.80.31
                
                sed -i 's/原字符串/替换字符串/g' filename 
                sed -i 's/cc/CC/g' sed.txt
                cut -d "自定义分隔符" -f1 第几列
                awk 'NR==2' -F "分隔符" '{print$2}'获取第几列


修改权限的属于者：chown -R root:root /data/progream/datax

统计目录文件个数
ll -l ./|grep "^-"|wc -l
```

```
系统负载
uptime

内存使用
free -mh 
```

##### 检查某个进程是否正常运行，便于后续的操作

```shell
#!/bin/sh
ps -ef |grep DFSZKFailoverController|grep -v grep|awk -F " " '{print$2}'
if [ $? -ne 0 ]
then
echo "ZKFC进程在运行中....."
else
/data/program/hadoop-2.7.2/sbin/hadoop-daemon.sh  start zkfc
fi
```

##### 定时任务，crontab里配置脚本不生效,手动执行生效的一个问题

```shell
定时调度 每60分钟执行下面的脚本

原始版本： */60  * * * * /bin/sh /data/program/hadoop-2.7.2/bin/process.sh -- 脚本不生效
修改版本：需要制定环境变量  */60  * * * * source ~/.bash_profile;/bin/sh /data/program/hadoop-2.7.2/bin/namenode.sh -- 生效脚本
```

##### CentOS 静态ip指定

```shell
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="static"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="ens33"
UUID="096602c2-21f6-4f62-996e-5eeb200013a9"
DEVICE="ens33"
ONBOOT="yes"
IPADDR=192.168.27.50
GATEWAY=192.168.27.2
DNS1=114.114.114.114
DNS2=8.8.8.8
```

##### if [-f ]

```
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi
-f 存在且是一个普通文件则为真
```

#####  CentOS的/tmp清除规则

```
vim /usr/lib/tmpfiles.d/tmp.conf 目录
/tmp/sqoop-root/* 忽略这个目录中的清除规则
```




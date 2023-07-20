
1、静态ip切换目录：cd /etc/sysconfig/network-scripts

2、解压目录 tar -zxvf xxx.tar.gz -C /指定目录

3、vim  yy 复制 p粘贴

4、改主机名 sudo hostnamectl set-hostname node3

5、生成密钥 ssh-keygen -t rsa  免费登录,密钥拷贝 ssh-copy-id node3

6、添加主机列表 sudo vim /etc/hosts 

7、xcall.sh 的脚本
	#!/bin/bash
	params=$@
	i=1
	for (( i=1 ; i <= 3 ; i = $i + 1 )) ; do
	    echo ============= node$i $params =============
	    ssh node$i "$params"
	done

8、xsync.sh 的脚本	
	
	#!/bin/sh

	# 获取输入参数个数，如果没有参数，直接退出
	#!/bin/sh
	# 获取输入参数个数，如果没有参数，直接退出
	pcount=$#
	if((pcount==0)); then
	        echo no args...;
	        exit;
	fi

	# 获取文件名称
	p1=$1
	fname=`basename $p1`
	echo fname=$fname
	# 获取上级目录到绝对路径
	pdir=`cd -P $(dirname $p1); pwd`
	echo pdir=$pdir
	# 获取当前用户名称
	user=`whoami`
	# 循环
	for((host=1; host<=3; host++)); do
	        echo $pdir/$fname $user@node$host:$pdir
	        echo ==================node$host==================
	        rsync -rvl $pdir/$fname $user@node$host:$pdir
	done
	#Note:这里的slave对应自己主机名，需要做相应修改。另外，for循环中的host的边界值由自己的主机编号决定。



9、 安装 lrzsz yum -y install lrzsz 





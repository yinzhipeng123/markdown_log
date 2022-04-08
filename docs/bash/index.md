# Bash 介绍



##### 使用bash脚本的原因

- 功能比较强大，可以移植
- 节省时间，提高工作效率，可以重复执行命令

##### Bash脚本的好处

- 减少重复性工作，提升效率

##### 组成bash脚本的元素   即bash脚本基本格式

`#!/bin/bash`      ——  sha-bang，也称为幻数，用来指明脚本中的命令是由什么环境来解析的

一行到多行的注释行    以#开头的，注释里面写：作者、编写时间、更新时间、脚本的功能等

[变量]   ——  变量的定义，可以用到的时候定义，也可以事先定义

命令、流程控制语句等 

##### Bash脚本的调试

1）对脚本整体进行调试

​     sh -x 脚本的名字         //  -x：会将脚本执行过程中每一行都打印到标准输出

 2）对脚本的局部调试

​      set -x     //开启调试功能

​      set +x    //关闭调试功能

```bash
[root@shell ~]# cd /script/
[root@shell script]#  sc1.sh
#!/bin/bash
for i in $(seq 5)
do
echo $i
done
[root@shell script]# sh -x sc1.sh
[root@shell script]#  sc1.sh
#!/bin/bash
for i in $(seq 5)
do
set -x
echo $i
echo hello $i
set +x
done
[root@shell script]# sh sc1.sh
```

##### 脚本的运行

​    1）脚本编写完成，添加执行权限，使用相对路径或者绝对路径的方式运行脚本
​        [root@shell script]# ./sc1.sh
​            bash: ./sc1.sh: Permission denied
​        [root@shell script]# chmod +x sc1.sh 
​        [root@shell script]# ./sc1.sh 
​    2）编写完成，使用sh或者bash命令运行脚本(可以没有执行权限)
​        [root@shell script]# sh sc1.sh      //有无执行权限均可
​    3）计划任务(系统自动执行)
​        注意：脚本一定要有执行权限，而且在计划任务中一定要写脚本的绝对路径
​        [root@shell script]# crontab -e
​            0 * * * * /script/sc1.sh

想要不论当前目录在哪，我都可以直接敲脚本的名字就执行脚本，怎么做？
改PATH

```bash
[root@shell scripts]#  /root/.bash_profile
PATH=$PATH:$HOME/bin:/script   //修改，将自己路径加入
[root@shell scripts]# . /root/.bash_profile
[root@shell scripts]# cd
[root@shell ~]# sc1.sh  
```

一个脚本在终端可以运行，但是在计划任务中可能不能运行，原因可能是子shell的问题，在终端和在计划任务中运行继承的PATH值不同，导致脚本中某些命令可能不能执行。
解决办法：在你脚本中添加一行

```bash
export PATH=/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/root/bin
```

测试crontab中的PATH值

```bash
[root@shell script]#  sc2.sh 
#!/bin/bash
echo $PATH 
[root@shell script]# chmod +x sc2.sh 
[root@shell script]# crontab -e
* * * * * /script/sc2.sh
[root@shell script]# mail
/usr/bin:/bin        
  	
重现错误
[root@server scripts]# cat test.sh 
#!/bin/bash
ipaddr=$(ifconfig eth0 | grep Bcast  | cut -d: -f2 | cut -d" " -f1)
echo $ipaddr
[root@server scripts]#  crontab -e
* * * * * /scripts/test.sh
[root@server scripts]# ./test.sh 
172.16.254.200
[root@server scripts]# mail
/scripts/test.sh: line 2: ifconfig: command not found
[root@server scripts]# cat test.sh 
#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
ipaddr=$(ifconfig eth0 | grep Bcast  | cut -d: -f2 | cut -d" " -f1)
echo $ipaddr
[root@server scripts]# mail  
172.16.254.200
```
​       
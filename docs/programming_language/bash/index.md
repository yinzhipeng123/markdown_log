# Bash 介绍



**Bash**，[Unix shell](https://zh.wikipedia.org/wiki/Unix_shell)的一种，在1987年由[布莱恩·福克斯](https://zh.wikipedia.org/wiki/布萊恩·福克斯)为了[GNU计划](https://zh.wikipedia.org/wiki/GNU計劃)而编写。1989年发布第一个正式版本，原先是计划用在[GNU](https://zh.wikipedia.org/wiki/GNU)操作系统上，但能运行于大多数[类Unix系统](https://zh.wikipedia.org/wiki/类Unix系统)的操作系统之上，包括[Linux](https://zh.wikipedia.org/wiki/Linux)与[Mac OS X v10.4](https://zh.wikipedia.org/wiki/Mac_OS_X_v10.4)起至[macOS Mojave](https://zh.wikipedia.org/wiki/MacOS_Mojave)都将它作为默认shell，而自[macOS Catalina](https://zh.wikipedia.org/wiki/MacOS_Catalina)，默认Shell以[zsh](https://zh.wikipedia.org/wiki/Zsh)取代。

Bash是[Bourne shell](https://zh.wikipedia.org/wiki/Bourne_shell)的后继兼容版本与开放源代码版本，它的名称来自[Bourne shell](https://zh.wikipedia.org/wiki/Bourne_shell)（sh）的一个双关语（*Bourne again* / born again）：**B**ourne-**A**gain **SH**ell。

Bash是一个命令处理器，通常运行于文本窗口中，并能执行用户直接输入的命令。Bash还能从文件中读取命令，这样的文件称为脚本。和其他Unix shell 一样，它支持文件名替换（通配符匹配）、[管道](https://zh.wikipedia.org/wiki/管道_(Unix))、[here文档](https://zh.wikipedia.org/wiki/Here文档)、命令替换、变量，以及条件判断和循环遍历的结构控制语句。包括关键字、语法在内的基本特性全部是从[sh](https://zh.wikipedia.org/wiki/Bourne_shell)借鉴过来的。其他特性，例如历史命令，是从[csh](https://zh.wikipedia.org/wiki/C_Shell)和[ksh](https://zh.wikipedia.org/wiki/Korn_shell)借鉴而来。总的来说，Bash虽然是一个满足[POSIX](https://zh.wikipedia.org/wiki/POSIX)规范的shell，但有很多扩展。

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
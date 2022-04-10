# 重定向



改变你命令输出结果的位置

文件描述符
`0`：标准输入

`1`：标准输出，默认输出到屏幕上

`2`：错误输出，默认输出到屏幕上

`>`：标准输出覆盖重定向

`>>`：标准输出追加重定向

`2>`：错误输出覆盖重定向

 2>>`：错误输出追加重定向`

`<`：输入重定向，常用于脚本中

```bash
while 
do
command
done < /test/list.txt         //从文件中读取变量

[root@shell tmp]# echo y > b.txt
[root@shell tmp]# rm douniwan 
rm: remove regular empty file `douniwan'? ^C
[root@shell tmp]# rm douniwan  < b.txt 
rm: remove regular empty file `douniwan'? [root@shell tmp]# ls douniwan
ls: cannot access douniwan: No such file or directory          
```

`<<` :   打开临时缓冲区，一般在编辑或者修改文件时用，但我们一般用它来生成文件。

```bash
[root@shell tmp]# cat << EOF > /tmp/dhcpd.conf 
> subnet 172.16.0.0 netmask 255.255.0.0 {
> range 172.16.254.100 172.16.254.200;
> }
> EOF
[root@shell tmp]# cat /tmp/dhcpd.conf 
subnet 172.16.0.0 netmask 255.255.0.0 {
range 172.16.254.100 172.16.254.200;
}
```

EOF：文件结束标志，成对出现的，写在他们之间的内容会被写入文件中

可用于：

1）系统初始化时候，生成yum客户端配置文件

```bash
[root@shell tmp]#  init.sh
cat << EOF > /tmp/local.repo
[base]
name=base
baseurl=file:///mnt/cdrom
enabled=1
gpgcheck=0
EOF
[root@shell tmp]# chmod +x init.sh      //给脚本添加执行权限
[root@shell tmp]# ./init.sh 
[root@shell tmp]# cat local.repo         //生成的文件
[base]
name=base
baseurl=file:///mnt/cdrom
enabled=1
gpgcheck=0
```

2）在安装配置服务时，生成服务的配置文件等，例如dhcp的安装配置脚本

```bash
[root@shell tmp]# cat dhcp.sh 
#!/bin/bash
yum install dhcp -y
cat << EOF > /etc/dhcp/dhcpd.conf 
subnet 172.16.0.0 netmask 255.255.0.0 {
range 172.16.254.100 172.16.254.200;
}
EOF
/etc/init.d/dhcpd start   
[root@shell ~]# sh dhcp.sh     //运行脚本
```

3）编写脚本时，写多行注释

```bash
[root@shell scripts]#  multi_comm.sh
#!/bin/sh
<<COMMENT
This is comment
line 2

line 4
date
COMMENT
echo "hello"
[root@shell scripts]# sh multi_comm.sh 
hello 
```

1>&2 ：  正确的按照错误的输出

```bash
[root@shell ~]# touch /tmp/douniwan
[root@shell ~]# ls /tmp/douniwan 
/tmp/douniwan
[root@shell ~]# ls /tmp/douniwan  > a.txt
[root@shell ~]# cat a.txt 
/tmp/douniwan
[root@shell ~]# ls /tmp/douniwan /tmp/shui > haha.txt      //正确的放到haha.txt
ls: cannot access /tmp/shui: No such file or directory
[root@shell ~]# ls /tmp/douniwan /tmp/shui > haha.txt 2> cry.txt  
//正确的放到haha.txt，错误的放到cry.txt中
[root@shell ~]# cat haha.txt 
/tmp/douniwan
[root@shell ~]# cat cry.txt 
ls: cannot access /tmp/shui: No such file or directory
[root@shell ~]# ls /tmp/douniwan /tmp/shui > haha.txt 2>&1 
//正确的放在haha.txt，错误的也放在这里面
[root@shell ~]# cat haha.txt 
ls: cannot access /tmp/shui: No such file or directory
/tmp/douniwan
```

2>&1：错误的按照正确的输出

&> ：不论对错都重定向，一般在脚本中，写法 &>/dev/null

```bash
[root@shell ~]# ls /tmp/douniwan /tmp/shui &> haha.txt
[root@shell ~]# cat haha.txt 
ls: cannot access /tmp/shui: No such file or directory
/tmp/douniwan
```

重定向可以定向到文件或者设备。

重定向到设备：

第一个标签：查看当前终端的设备名

```bash
[root@shell ~]# tty
/dev/pts/1
```

第二个标签：

```bash
[root@shell ~]# echo hello pts1 > /dev/pts/1
```


第一个标签：会看到hello pts1 

```
[root@shell ~]# hello pts1
```

向所有登录到系统的终端发消息：
```bash
[root@shell ~]# wall "go out"     --- write all
```


 都甩到空里的两种模式

| 命令            | 标准输出 | 错误输出 |
| --------------- | -------- | -------- |
| >/dev/null 2>&1 | 丢弃     | 丢弃     |
| 2>&1 >/dev/null | 丢弃     | 屏幕     |

其他

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204100245834.png" style="zoom:67%;" />

Tee

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204100245663.png" style="zoom:67%;" />
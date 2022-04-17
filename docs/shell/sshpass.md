# Sshpass

sshpass命令用于非交互的 ssh 密码验证。可以在命令行直接使用密码来进行远程连接和远程拉取文件。使用前提：对于未连接过的主机。而又不输入yes进行确认，需要进行sshd服务的优化。

## 语法

**语法格式：**sshpass [参数]

**常用参数：**

| -p   | 指定密码 |
| ---- | -------- |
| -f   | 指定文件 |

**参考实例**

安装sshpass：

```
[root@linuxcool ~]# yum install -y epel-release
[root@linuxcool ~]# yum install -y sshpass
[root@linuxcool ~]# sshpass -V
```

基本使用方法：

```
[root@linuxcool ~]# sshpass -p "password" ssh username@ip
```

当远程主机端口不再是22默认端口时候：

```
[root@linuxcool ~]# sshpass -p "password" ssh -p 8443 username@ip
```

直接远程连接某台主机：

```
[root@linuxcool ~]# sshpass -p xxx ssh root@192.168.11.11
```

本地执行远程机器的命令：

```
[root@linuxcool ~]# sshpass -p xxx ssh root@192.168.11.11 "ethtool eth0"
```

远程连接指定ssh的端口：

```
[root@linuxcool ~]# sshpass -p 123456 ssh -p 1000 root@192.168.11.11
```

从密码文件读取文件内容作为密码去远程连接主机：

```
[root@linuxcool ~]# sshpass -f xxx.txt ssh root@192.168.11.11
```

从远程主机上拉取文件到本地：

```
[root@linuxcool ~]# sshpass -p '123456' scp root@host_ip:/home/test/t ./tmp/
```



## 批量登录服务器

```bash
#!/bin/bash
#把IP地址放在同级目录下ip.txt中，一行放一个
#使用方法 sh ssh.sh ip.txt
#执行脚本的机器系统内先安装sshpass,yum安装即可,把123456换成集群的统一密码
for i in `grep -v "#" $1`
do
sshpass -p "123456" ssh $i "ls" > /dev/null 2>&1
if [ $? -eq 0 ];then 
echo "$i" >> sucess.txt
else
echo "$i" >> error.txt
fi
done
```


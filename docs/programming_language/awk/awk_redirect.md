## 1、awk与重定向

### 输出重定向

将uid>100的用户名及uid保存到/tmp/uidup100文件中

```bash
 [root@shell shelldoc]# awk -F: '$3 > 100{print $1,$3 > "/tmp/uidup100"}' /etc/passwd 
```

### 输入重定向

getline 接收来自于标准输入、管道和文件（非当前处理文件）的数据，存入到一个变量中，再给awk使用

```bash
[root@shell shelldoc]# awk 'BEGIN{"date" | getline a}{print $0}END{print a}' pass

[root@shell shelldoc]# tty
```

从标准输入读取一个数据

传给变量username，判断passwd文件中是否有这样的用户名，如果有，打印行号和用户名

```bash
[root@shell shelldoc]#  sc2.awk
BEGIN{
FS=":"
printf "请输入一个用户名： "
getline username < "/dev/pts/10"
}
{
if($1==username)        判断
{
print NR,$1
}
}
[root@shell shelldoc]# awk -f sc2.awk /etc/passwd
请输入一个用户名： root
1 root
```

## 2、awk与管道

```bash
[root@shell shelldoc]# awk -F: '$3 > 100{print $1,$3 | "sort -nr -k2"}' /etc/passwd
```

## 3、使用awk执行系统命令

```bash
[root@shell shelldoc]# awk 'BEGIN{print "today is ";system("date")}' 
today is 
Mon Sep  7 12:26:03 CST 2015
```


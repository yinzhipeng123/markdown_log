# 数组

数组是使用一个变量名 来保存一组数据，通常这些数据的类型是一样的

数组中的数据(元素) 是与数组下标一一对应的

如果想要取出数组中的某个元素，就会使用到数组名和下标

awk中的数组也成为关联数组，是因为它的下标可以是数值，也可以是字符串

## 一、数组的定义

数组名[下标]=值

## 二、数组的遍历

### for循环遍历数组

语法：

​		1）for (i=0;i<NR;i++)

​		2） for (下标 in 数组名) {print 数组名[下标]}

```bash
定义数组及给数组中元素赋值
[root@shell shelldoc]#  arr.awk
BEGIN{
a[1]="aa"
a[2]="bb"
a[3]="cc"
for(i=1;i<=3;i++)
{
print a[i]
}
}      
[root@shell shelldoc]# awk -f arr.awk 
aa
bb
cc
```

###  删除数组元素

![Untitled](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204141945833.png)

### awk支持的下标的类型

#### 1）使用数字或变量作为下标

name[1]		name[x++]		name[NR]

```bash
[root@shell shelldoc]# awk '{name[x++]=$1}END{for(i=0;i<NR;i++){print i,name[i]}}' employees
0 Tom
1 Mary
2 Sally
3 Billy
4 Tom
```

#### 2）使用字符串做下标

name["tom"]++     

```bash
[root@shell shelldoc]#  datafile4   
cat
dog
pig
cat
dog
dog
bird
dog
rabbit
统计文件中每种动物有几只？
[root@shell shelldoc]# awk '{count[$1]++}END{for(i in count){print i,count[i]}}' datafile4
cat 2
bird 1
rabbit 1
dog 4
pig 1
统计apache日志中每个IP的访问次数，显示访问次数最多的五个IP及访问次数    /var/log/httpd/access_log
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk '{count[$1]++}END{for(i in count){print count[i],i}}'  /var/log/httpd/access_log | sort -k1nr | head -n 10 
统计/root/.bash_history文件中执行次数最多的十条命令
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk '{count[$0]++}END{for(i in count){print count[i],i}}' /root/.bash_history | sort -k1nr | head -n 10   
71 sh 4.sh 
64 vim 4.sh 
38 ll
统计系统中使用每种shell的有几个人？
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk -F: '{count[$NF]++}END{for(i in count){print count[i],i}}' /etc/passwd | sort -k1nr | head -n 10
18 /sbin/nologin
1 /bin/bash
1 /bin/sync
1 /sbin/halt
1 /sbin/shutdown
统计服务器上tcp连接情况(每种监听状态有几个？)
如：
LISTEN 10
ESTABLISHED 30
[root@iZbp1ealzv6zqhd71bns8sZ ~]# netstat -tan4p |grep -v Active| grep -v Proto| awk '{count[$6]++}END{for(i in count){print count[i],i}}' | sort -k1nr 
5 ESTABLISHED
1 LISTEN
```



          


​    
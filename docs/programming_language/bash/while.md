# while

while语法：

```bash
变量初始值
while 条件表达式或者命令(read)
do  
		循环体
		变量的更新       //一定要有变量的更新，否则死循环
done
说明：while循环，当判断条件为真时，执行循环体中的操作；当判断条件为假时退出循环。
```

```bash
[root@shell script]#  while1.sh
#!/bin/bash
i=1
while [ $i -le 5 ]
do
		echo $i
		let i++
done
[root@shell script]# sh while1.sh 
1
2
3
4
5


#i++：先使用，再加1
#++i：先加1，再使用
#let i++
#let ++i
#i--
#--i
```

#### while与输入重定向结合使用

添加用户的脚本，要求用户的信息来自于文本文件

1）创建用户列表文件

```bash
[root@shell script]#  cat userlist
tom:passtom:2015
jack:passjack:2016
mary:passmary:2022
kite:passkite:2000
```

2）写添加用户的脚本

```bash
[root@shell script]#  cat while2.sh
#!/bin/bash
while read line
do
	username=`echo $line | cut -d: -f1`	
	password=`echo $line | cut -d: -f2`
	uid=`echo $line | cut -d: -f3`
	if id $username &>/dev/null
		then
		echo "user $username exists."
	else
		useradd -u $uid $username && echo $password | passwd --stdin $username    
	fi
done < /script/userlist
[root@shell script]# sh while2.sh 
Changing password for user tom.
passwd: all authentication tokens updated successfully.
Changing password for user jack.
passwd: all authentication tokens updated successfully.
Changing password for user mary.
passwd: all authentication tokens updated successfully.
Changing password for user kite.
passwd: all authentication tokens updated successfully.
```

#### while 死循环 

- while :
- while true
                  

```bash
捕捉信号
trap  动作 信号
[root@shell script]#   while3.sh
#!/bin/bash
trap "echo You can not kill me." 15
while :
do
	echo hello
	sleep 2
done
标签一
[root@shell script]# sh while3.sh 
hello
hello
hello
hello
标签二
[root@shell script]# ps -ef | grep while
root     22305 15580  0 14:50 pts/3    00:00:00 sh while3.sh
root     22334 18500  0 14:51 pts/4    00:00:00 grep while
[root@shell script]# kill -15 22305    //无法杀死进程
标签一
hello
hello
You can not kill me.
hello
```
```bash
[root@shell 20160902]#  while_useradd.sh 
#!/bin/bash
while :
do
	read -p "user: " username
	if [ $username = "q" ]
	then
		exit
	fi
	if id $username &>/dev/null
	then
		echo "exists"
	else
		useradd $username && echo "user $username added"
	fi   
done
```



​       

	#!/bin/bash
	#99乘法表
	i=1
	while [ $i -le 9 ]
	do
		j=1
		while [ $j -le $i ]
		do
		    echo -n "${i}x${j}="$[${i}*${j}]" "
		    j=$[$j+1]
		done
		echo
		let i++
	done
# For

1、语法结构

```bash
for 变量 in 变量列表
do
	循环体    //可以重复执行n次的
done
```

说明：

 变量列表中的值的数量，决定了循环的次数

```bash
[root@shell script]#  cat for1.sh
#!/bin/bash
for i in 1 2 3 4 5 haha hehe nishuia woshita b
do
	echo $i
done
```

变量列表的常见写法：
1、直观

```
a b c d  1 3 5  ... ...
nihao alalei ... ...
```

2、使用系统命令

```bash
seq 等
[root@shell script]#  cat for2.sh
#!/bin/bash
# seq
for i in `seq 10`
do
	echo $i
done
#系统命令
for i in `ls /`
do
	echo $i
done
-------------------
seq 10
seq 0 10
seq 1 2 10
seq -w 01 09    //等宽显示
seq -w 10
[root@shell script]# seq 5 -1 1    //倒序打印
5
4
3
2
1
-------------------
```

3、"$

```bash
列表       输出    
"$*"      a b c d      "a b c d"
"$@"      a b c d      "a" "b" "c" "d"
[root@shell script]#  for3.sh
#!/bin/bash
for i in "$*"
do
echo $i
done
echo
echo
for i in "$@"
do
echo $i
done
[root@shell script]# chmod +x for3.sh 
[root@shell script]# ./for3.sh a b c d
a b c d

a
b
c
d
```

4、使用变量

```bash
[root@shell script]#  for4.sh
#!/bin/bash
WORD="q w e r t y u i o p"
for i in $WORD
do
echo $i
done
```

嵌套循环

打印99乘法口诀表

```bash
[root@shell script]#  99.sh
#!/bin/bash
for i in `seq 9`
do
	for j in `seq $i`
	do
		echo -n "  $i*$j=$[$i*$j]  "
	done
echo
done
```

shell中for模拟c语言中的 写法  

```bash
[root@shell 20160902]# cat for.sh 
#!/bin/bash
for ((i=1;i<=5;i++))
do
echo $i
done
```


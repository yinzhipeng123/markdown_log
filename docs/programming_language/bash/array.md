# 数组

数组是用数组的名字保存一组值的变量

数组中的术语：
	数组元素    值

​	数组下标    跟元素对应的

 1、定义数组   declare -a 数组名=(值)

```bash
[root@shell script]# name=(tom mary jack)
```

 2、查看数组中的某个元素的值

```bash
[root@shell script]# echo ${name[1]}    //中括号里面的叫做下标
mary
[root@shell script]# echo ${name[0]}
tom
[root@shell script]# echo ${name[2]}
jack
```

 3、给数组中的某个元素赋值

```bash
[root@shell script]# name[1]=rose
[root@shell script]# echo ${name[1]}
rose
```

 4、数组的遍历

```bash
[root@shell script]# echo ${name[*]}
tom rose jack
[root@shell script]# echo ${name[@]}
```

 5、显示数组元素的个数

```bash
[root@shell script]# echo ${#name[*]}
3
[root@shell script]# echo ${#name[@]}
3
```

 6、取消数组

```bash
 [root@shell script]# unset name
```

例子：双色球

red：33选6           //6个红球，需要保存到数组中

blue：16选1

```bash
[root@shell script]# echo $RANDOM      //打印随机数
12712
红球：  [root@shell script]# echo $[$RANDOM%33+1]
蓝球：  [root@shell script]# echo $[$RANDOM%16+1]
```

最简单的彩票，但是红球可能会重复

```bash
[root@shell script]#  lottery.sh
#!/bin/bash
for i in `seq 6`
do
	red[$i]=$[$RANDOM%33+1]
	echo -n "${red[$i]}  "
done
echo
echo "$[$RANDOM%16+1]"
```


​    彩色输出：

```bash
#!/bin/bash
for i in `seq 6`
do
	red[$i]=$[$RANDOM%33+1]
	echo -n -e "\e[1;31m ${red[$i]} \e[0m"
done
echo
echo -e "\e[1;34m $[$RANDOM%16+1]\e[0m"
```

颜色设定代码：

前景色：

​	重置=0；黑色=30；红色=31；绿色=32；黄色=33；蓝色=34；洋红=35；青色=36；白色=37

背景色：

​	重置=0；黑色=40；红色=41；绿色=42；黄色=43；蓝色=44；洋红=45；青色=46；白色=47
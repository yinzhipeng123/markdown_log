# if

if判断的语法结构

if和fi要成对出现，脚本里有几个if就要有几个fi

1）最简单的语法

```bash
if 条件表达式或者命令
then
命令;
fi
```

例子：

```bash
[root@shell script]#  if1.sh
#!/bin/bash
if [ -e /etc/passwd ]
then
echo "file exists"
fi
[root@shell script]# sh if1.sh 
file exists
        
[root@shell script]# cat if2.sh 
#!/bin/bash
ping -c3 172.16.254.254 &>/dev/null
if [ $? -eq 0 ]     //if后面跟表达式
then
echo "172.16.254.254 is alive."
fi

if ping -c3 172.16.4.254 &>/dev/null    //if后面直接跟命令
then
echo "172.16.4.254 is alive."
fi
[root@shell script]# sh if2.sh 
172.16.254.254 is alive.
172.16.4.254 is alive.
        
if ! ping -c3 172.16.4.254 &>/dev/null         //命令前面是可以加!，取非的意思
```

2）分支的if结构语法

```bash
if 条件表达式或者命令           
then
	命令;
else
	命令;
fi
```

​    例子：
```bash
[root@shell script]#  if3.sh
#!/bin/bash
read -p "Please input a filename: " filename
if [ -e $filename ]
then
	echo "file $filename exists."
else
	echo "file $filename not exists."
fi
[root@shell script]# sh if3.sh 
Please input a filename: /etc/passwd
file /etc/passwd exists.
[root@shell script]# sh if3.sh 
Please input a filename: /etc/douniwan
file /etc/douniwan not exists.
```
3）多分支if结构语法

```bash
if 条件表达式或者命令
	then
	命令；
elif 条件表达式或者命令        //elif可以有多个
	then
	命令；
else
	命令；
fi
```

例子：
要求用户输入的分数为空的话，直接退出脚本
要求如果输入的分数大于100或者小于0，直接退出脚本
根据用户输入的分数来判断，优秀(>=90)、良好（>=80）、一般（>=60）等

```bash
[root@shell script]#  if4.sh
#!/bin/bash
read -p "请输入分数：" score
if [ -z $score ]
then
echo "分数不能为空"
exit
fi
if [ $score -gt 100 -o $score -lt 0 ]

if [[ $score -gt 100 || $score -lt 0 ]]

then
echo "非法的分数值"
exit
fi
if [ $score -ge 90 ]
then
echo "优秀"
elif [ $score -ge 80 ]
then
echo "良好"
elif [ $score -ge 60 ]
then
echo "一般"   
else
echo "不及格"
fi
[root@shell script]# sh if4.sh 
请输入分数：-2
非法的分数值
[root@shell script]# sh if4.sh 
请输入分数：20
不及格
[root@shell script]# sh if4.sh 
请输入分数：77
一般
[root@shell script]# sh if4.sh 
请输入分数：88
良好
[root@shell script]# sh if4.sh 
请输入分数：99
优秀    
```

4） 多重条件判断

```bash
条件表达式1 选项 条件表达式2
选项：
-a：并且    &&
-o：或者    ||
 ！条件表达式    ：取反，非
if [ $score -gt 100 -o $score -lt 0 ]
if [ $score -gt 100 ] || [ $score -lt 0 ]       
if [[ $score -gt 100 || $score -lt 0 ]]
```
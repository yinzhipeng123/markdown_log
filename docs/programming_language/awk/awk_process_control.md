# Awk的流程控制

##  一、三元操作符

？:
<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204141823752.png" alt="Untitled" style="zoom: 67%;" />

判断条件?输出结果1:输出结果2

如果条件为真，输出问号后面的结果，否则输出冒号后面的结果

```bash
[root@shell shelldoc]# awk -F: '{print $1":"($3>$4?"uid:"$3:"gid:"$4)}' pass
```

## 二、分支判断结构   

### if

#### 1、语法格式：

```bash
if(条件表达式)
{
动作    
}
else
{
动作        
}
```

```bash
[root@shell shelldoc]#  if1.awk
BEGIN{
FS=":"
}
{
if($3>$4)
{
print $1":uid:"$3
}
else
{
print $1":gid:"$4
}
}
[root@shell shelldoc]# awk -f if1.awk pass
```

####     2、多分支判断语法结构

```bash
if(条件表达式)
{
动作        
}
else if(条件表达式)
{
动作        
}
... ...
else
{
动作        
}
[root@shell shelldoc]# cat score 
mike 83
rose 60
john 99
larry 65
[root@shell shelldoc]# cat if2.awk
#!/bin/awk -f           //shabang，指定文件中的命令的解析环境是awk
NR>0{
if($2>=90)
{
print $1": A"
}
else if($2>=80)
{
print $1": B"
}
else 
{
print $1": C"
}
}
[root@shell shelldoc]# chmod +x if2.awk 
[root@shell shelldoc]# ./if2.awk score
mike: B
rose: C
john: A
larry: C
```

## 三、循环

功能：

1）从行中取出每个字段，主要用于循环字段

2）遍历数组元素

### 1、while循环

语法：

```bash
变量初始值
while （条件）
{
动作
变量的更新            
}   
```

```bash
[root@shell shelldoc]# cat score
mike 85 80 90
[root@shell shelldoc]#  while1.awk
/mike/{
i=1
while(i<=NF)
{
print $i
i++
}
}   
[root@shell shelldoc]# awk -f while1.awk score 
mike
85
80
90
```

### 2、do循环

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204141845240.png" alt="Untitled" style="zoom: 67%;" />


​               
### 3、for循环

语法：

```bash
for(变量初始值;判断条件;变量的更新)
{
动作            
}
[root@shell shelldoc]#  for1.awk
/mike/{
for(i=1;i<=NF;i++)
{
print $i
}
}
```

统计单词的次数

```bash
awk '{for(i=1;i<=NF;i++){print $i}}' | sort | uniq -c
```

## 四、判断加循环

例子：

输出每行的最大值       

```bash
[root@shell shelldoc]# cat number 
90 10 70
70 49 33
22 82 91
88 100 33
[root@shell shelldoc]#  if-for.awk
{
max=$1
for (i=1;i<=NF;i++)
{
if($i>max)
{
max=$i
}
}
print max 
}
[root@shell shelldoc]# awk -f if-for.awk number 
90
70
91
100
```

## 五、双重循环   (嵌套循环)

打印99乘法口诀表

```bash
[root@shell shelldoc]#  for-for.awk
BEGIN{
for(i=1;i<=9;i++)
{
for(j=1;j<=i;j++)
{
printf j"*"i"="i*j"\t"
}
printf "\n"
}
}
[root@shell shelldoc]# awk -f for-for.awk 
1*1=1	
1*2=2	2*2=4	
1*3=3	2*3=6	3*3=9	
1*4=4	2*4=8	3*4=12	4*4=16	
1*5=5	2*5=10	3*5=15	4*5=20	5*5=25	
1*6=6	2*6=12	3*6=18	4*6=24	5*6=30	6*6=36	
1*7=7	2*7=14	3*7=21	4*7=28	5*7=35	6*7=42	7*7=49	
1*8=8	2*8=16	3*8=24	4*8=32	5*8=40	6*8=48	7*8=56	8*8=64	
1*9=9	2*9=18	3*9=27	4*9=36	5*9=45	6*9=54	7*9=63	8*9=72	9*9=81
```

## 六、循环控制语句

### continue		跳出本次循环

```bash
[root@shell shelldoc]# cat for-for.awk
BEGIN{
for(i=1;i<=9;i++)
{
for(j=1;j<=i;j++)
{
if (j==4) {continue}
else
{ 
printf j"*

"i"="i*j"\t"
}
}
printf "\n"
}
}
```

### break		跳出当前循环

```bash
[root@shell shelldoc]# cat for-for.awk
BEGIN{
for(i=1;i<=9;i++)
{
for(j=1;j<=i;j++)
{
if (j==4) {break}
else
{ 
printf j"*"i"="i*j"\t"
}
}
printf "\n"
}
}
```

### exit		退出脚本

```bash
[root@shell shelldoc]# cat for-for.awk
BEGIN{
for(i=1;i<=9;i++)
{
for(j=1;j<=i;j++)
{
if (j==4) {exit}
else
{ 
printf j"*"i"="i*j"\t"
}
}
printf "\n"
}
} 
```

### next		跳过本行，读取下一行

```bash
[root@shell shelldoc]# awk '/name/{next};{print $0}' score   
```

​     
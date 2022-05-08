# Awk函数

## 一、内置函数

man awk   //搜索Function

### 1、查找并替换

sub(正则表达式，替换字符串)		——		查找并替换

```bash
[root@shell shelldoc]# awk '{sub(/NW/,"NorthWest");print}' datafile
northwest	NorthWest  	Charles Main		3.0	.98	3	34
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk '{sub(/a/,"NorthWest");print}' 1.txt   
NorthWest:9:0 b c d e f
g:0:p h i j k l
[root@iZbp1ealzv6zqhd71bns8sZ ~]# cat 1.txt 
a:9:0 b c d e f
g:0:p h i j k l
```

### 2、大小写转换

tolower(字符串)		——		转换成小写

toupper(字符串)		——		转换成大写

```bash
[root@shell shelldoc]# awk '{print toupper($1)}' datafile
[root@shell shelldoc]# awk '{print tolower($2)}' datafile
```

### 3、查找

index(原字符串，子串)    ——  输出子串在原字符串中的位置

```bash
[root@shell shelldoc]# awk '{print index($1,"o"),$1}' datafile
2 northwest
0 western
2 southwest
2 southern
2 southeast
0 eastern
2 northeast
0 western
2 north
0 central
```

### 4、len

length(字符串)     ——  显示字符串的长度   

```bash
[root@shell shelldoc]# awk '{print length($1),$1}' datafile
9 northwest
7 western
9 southwest
8 southern
9 southeast
7 eastern
9 northeast
7 western
5 north
7 central
```

### 5、split

![Untitled](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142042721.png)

    [root@iZbp1ealzv6zqhd71bns8sZ ~]# cat 1.txt 
    a:9:0 b c d e f
    g:0:p h i j k l
    [root@iZbp1ealzv6zqhd71bns8sZ ~]# awk  '{z=split($1,array,":");for(i=1;i<=z;i++){print i,array[i]}}' 1.txt 
    1 a
    2 9
    3 0
    1 g
    2 0
    3 p

### 6、其他部分函数

![Untitled](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142043287.png)

![Untitled](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142043156.png)

### 7、随机函数

rand()

![Untitled](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142044023.png)

每次使用的时候 必须调用srand()函数，rand()才会随机，不然就一直都是一个

```bash
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk 'END{print srand(),rand()}' 1.txt 
1 0.024876
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk 'END{print srand(),rand()}' 1.txt 
1 0.024876
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk 'END{print srand(),rand()}' 1.txt 
1 0.732423   
不调用srand
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk 'END{print rand()}' 1.txt         
0.237788
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk 'END{print rand()}' 1.txt 
0.237788
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk 'END{print rand()}' 1.txt 
0.237788   
```



### 8、getline函数

![Untitled](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142055251.png)

当getline大于0代表读取到了下一行

```bash
[root@iZbp1ealzv6zqhd71bns8sZ ~]# cat 1.txt 
a:9:0 b c d e f
g:0:p h i j k l
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk '/g:0:p/{if(getline>0){print "have"}else{print "GG"}}' 1.txt 
GG
```

### 9、system()函数

​       可以执行一个系统命令

```bash
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk 'BEGIN{if(system("mkdir dale")!=0){print "faile"}else{print "ok"}}' 1.txt 
ok
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk 'BEGIN{if(system("mkdir dale")!=0){print "faile"}else{print "ok"}}' 1.txt 
mkdir: cannot create directory ‘dale’: File exists
faile
```

### 10、时间函数

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142057584.png)



## 二、自定义函数

格式

```bash
function 函数名(参数1，参数2，... ... ，参数n) {
函数体
return value   //返回值       
}              //参数也是可有可无的
```

```bash
[root@shell shelldoc]# awk 'function hello(){print "shell is over"}{hello()}' pass
```
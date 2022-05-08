# Awk

**AWK**是一种优良的[文本处理](https://zh.wikipedia.org/w/index.php?title=文本处理&action=edit&redlink=1)工具，[Linux](https://zh.wikipedia.org/wiki/Linux)及[Unix](https://zh.wikipedia.org/wiki/Unix)环境中现有的功能最强大的[数据处理](https://zh.wikipedia.org/wiki/数据处理)引擎之一。这种编程及数据操作语言（其名称得自于它的创始人[阿尔佛雷德·艾侯](https://zh.wikipedia.org/wiki/阿尔佛雷德·艾侯)、[彼得·温伯格](https://zh.wikipedia.org/wiki/彼得·溫伯格)和[布莱恩·柯林汉](https://zh.wikipedia.org/wiki/布萊恩·柯林漢)姓氏的首个字母）的最大功能取决于一个人所拥有的知识。AWK提供了极其强大的功能：可以进行正则表达式的匹配，样式装入、流控制、数学运算符、进程控制语句甚至于内置的变量和函数。它具备了一个完整的语言所应具有的几乎所有精美特性。实际上AWK的确拥有自己的语言：AWK[程序设计语言](https://zh.wikipedia.org/wiki/程序设计语言)，三位创建者已将它正式定义为“样式扫描和处理语言”。它允许创建简短的程序，这些程序读取输入文件、为数据排序、处理数据、对输入执行计算以及生成报表，还有无数其他的功能。gawk是AWK的GNU版本。

最简单地说，AWK是一种用于处理文本的编程语言工具。AWK在很多方面类似于[Unix shell](https://zh.wikipedia.org/wiki/Unix_shell)编程语言，尽管AWK具有完全属于其本身的语法。它的设计思想来源于[SNOBOL4](https://zh.wikipedia.org/wiki/SNOBOL4)、[sed](https://zh.wikipedia.org/wiki/Sed)、Marc Rochkind设计的有效性语言、语言工具[yacc](https://zh.wikipedia.org/wiki/Yacc)和[lex](https://zh.wikipedia.org/wiki/Lex)，当然还从[C语言](https://zh.wikipedia.org/wiki/C语言)中获取了一些优秀的思想。在最初创造AWK时，其目的是用于文本处理，并且这种语言的基础是，只要在输入数据中有模式匹配，就执行一系列指令。该实用工具扫描文件中的每一行，查找与命令行中所给定内容相匹配的模式。如果发现匹配内容，则进行下一个编程步骤。如果找不到匹配内容，则继续处理下一行。

[AWK - 维基百科，自由的百科全书 (wikipedia.org)](https://zh.wikipedia.org/wiki/AWK)

功能：处理文本文件，对文本数据进行汇总和处理，生成报告，对文件进行排版

```bash
[root@shell shelldoc]# which awk
/bin/awk
[root@shell shelldoc]# ll /bin/awk 
lrwxrwxrwx. 1 root root 4 Jul 22 15:36 /bin/awk -> gawk
[root@shell shelldoc]# ll /bin/gawk 
-rwxr-xr-x. 1 root root 382456 Jul  4  2012 /bin/gawk
```

awk工作过程，一行一行处理

将文本文件的内容逐行扫描，将整行的内容保存到变量$0中

按照指定的分隔符将输入的行切成若干的列(字段)，存入$1，$2，$3....变量中，再使用命令(print/printf)将变量打印输出，再读取下一行，直到文件都读取完毕，awk结束。

默认的输入分隔符：空白

```bash
取出本机的IP地址
[root@shell shelldoc]# ifconfig eth0 | grep -i bcast | awk '{print $2}'
addr:172.16.254.200
[root@shell shelldoc]# ifconfig eth0 | grep -i bcast | awk '{print $2}' | awk -F: '{print $2}'
172.16.254.200
```

	
## 一、awk 语法

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132209823.png" style="zoom:67%;" />

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132213416.png)

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132211276.png)

awk [选项] '/模式匹配(定址)/{动作1；动作2；....}' 文件列表

-f：指定执行的awk脚本的

-F：指定字段分隔符

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132209046.png)

### 分隔符

分隔符可以是字母、数字、符号和空白，可以同时指定多个分隔符

#### 1）单个符号作为分隔符

```bash
[root@shell shelldoc]# awk -F ":" '{print $1}' pass 
```

#### 2）复合分隔符  多个字符看成一个

:/

```bash
[root@shell shelldoc]# awk -F":/" '{print $1}' pass  | head -3
root:x:0:0:root
bin:x:1:1:bin
daemon:x:2:2:daemon
```

#### 3）同时指定多个分隔符

：   /

```bash
[root@shell shelldoc]# awk -F"[:/]" '{print $8}' pass 
```

#### 4）以空为分隔符，打印每行的第一个字符和第二个字符

```bash
[root@shell shelldoc]# awk -F "" '{print $1,$2}' pass
```

-F和双引号之间必有空格

## 二、awk输出

#### 1）print

- print输出时有换行
- 打印字段时，如果用逗号分隔多个字段，输出的时候就是以空白为分隔符
- print时候，后面不加字段，默认打印整行

​	打印内容的，打印的内容可以是文件中的，也可以和文件毫无关系

```bash
[root@shell shelldoc]# awk '{print}' pass
1 2 3 4
[root@shell shelldoc]# awk '{print $0}' pass
1 2 3 4
[root@shell shelldoc]# awk '{print "helloha"}' pass
helloha
[root@shell shelldoc]# awk '{print "你好"}' pass
你好
```


​	注意：字符串用双引号引起来，但是变量不要引($1)

```bash
例子：在每行的下一行打印一个空行
\n：换行
[root@shell shelldoc]# awk '{print $0"\n"}' pass
1 2 3 4 

[root@shell shelldoc]# head -1 pass | awk '{print "class\nis\nover"}'
class
is
over

\t：tab
[root@shell shelldoc]# awk -F: '{print $1"\t"$3}' pass   
root    0
bin     1
daemon  2
adm     3
lp      4
sync	5
shutdown	6
halt    7
mail    8
uucp    10
```

#### 2）printf

- 默认输出时候没有换行，想换行，指定"\n"
- 输出时默认没有输出字段分隔符
- printf一般情况下需要指定输出格式

printf "输出的字符串(format)",item1,item2,......,itemn 

format的指示符是以%开头的，后面跟一个字符，如：

- %s：字符串    string
- %d：十进制数   digital
- %f：浮点数，小数    float
- %%：表示%本身
- %x：十六进制数
- %o：八进制数
- %c：字符 
- ![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132206495.png)

```bash
[root@shell shelldoc]# awk -F: '{printf "%s %d",$1,$3}' pass 
root 0bin 1daemon 2adm 3lp 4sync 5shutdown 6halt 7mail 8uucp 10[root@shell shelldoc]# awk -F: '{printf "%s %d\n",$1,$3}' pass   
root 0
bin 1
daemon 2
adm 3
lp 4
sync 5
shutdown 6
halt 7
mail 8
uucp 10	
[root@shell shelldoc]# awk -F: '{printf "用户名：%s  uid:%d\n",$1,$3}' pass
```


在%和字符之间可以有修饰符

修饰符：

N：代表数字，指定输出时的显示宽度

注意：显示宽度的时候大于或者等于要打印的字段中最长的那个值

-：左对齐，默认右对齐 

%-s    %-5s    %5s

```bash
[root@shell shelldoc]# awk -F: '{printf "username:%10s  uid:%d\n",$1,$3}' pass
[root@shell shelldoc]# awk -F: '{printf "username:%-10s  uid:%d\n",$1,$3}' pass
[root@shell shelldoc]# awk -F: '{printf "%s%s",$1,$3}' pass     
root0bin1daemon2adm3lp4sync5shutdown6halt7mail8uucp10
```

对于%f

%7.2f		显示宽度为7，保留2位小数

%-7.2f		左对齐，显示宽度为7，保留2位小数

%.2f		保留2位小数

```bash
[root@shell shelldoc]# echo "12.345 23.56" 
12.345 23.56
[root@shell shelldoc]# echo "12.345 23.56"  | awk '{printf "%d %d\n",$1,$2}'    //取整不四舍五入
12 23

[root@shell shelldoc]# echo "12.345 23.56"  | awk '{printf "%-6.2f%.1f\n",$1,$2}'		 //取小数时候四舍五入
12.35 23.6
```



​			

## 三、awk的运算符

#### 1、算数运算符

  ` -x`：负数   ` (+)x`：正数

   `+ - * / `     `%`：取模   `^`：取幂     <img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132219598.png" alt="Untitled" style="zoom: 50%;" />

```bash
[root@shell shelldoc]# awk '{print $3,$5,$3+$5,$3-$5,$3*$5,$5/$3,$5%$3,2^16}' employees
```

#### 2、关系运算符

##### 1）数值之间的关系运算符

 <    >=   <=   ==  !=

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132220049.png" alt="Untitled" style="zoom: 67%;" />

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132221802.png" alt="Untitled" style="zoom:50%;" />

```bash
打印passwd文件中uid小于5的行
[root@shell shelldoc]# awk -F: '$3<5{print}' /etc/passwd
[root@shell shelldoc]# awk -F: '$3<5' /etc/passwd
//有定址，无动作，默认就是打印符合条件的行

打印系统中gid大于等于500的组名和gid
[root@shell shelldoc]# awk -F: '$3>=500{print $1,$3}' /etc/group

```

##### 2）字符串之间的关系运算

==    !=

```bash
打印用户名是bin的行
[root@shell shelldoc]# awk -F: '$1=="bin"' pass 
bin:x:1:1:bin:/bin:/sbin/nologin
打印用户名不是bin的行
[root@shell shelldoc]# awk -F: '$1!="bin"' pass
```

x ~ /y/   匹配正则
x !~ /y/  不匹配的

```bash
打印pass文件中名字中带o的用户名
[root@shell shelldoc]# awk -F: '$1~/o/{print $1}' pass 
root
daemon
shutdown
打印pass文件中名字以ro开头的用户名
[root@shell shelldoc]# awk -F: '$1~/^ro/{print $1}' pass   
root
```



#### 3、逻辑运算符

​	&&   ||   !

```bash
uid大于8或者uid小于3的用户的名字和uid
[root@shell shelldoc]# awk -F: '$3>8 || $3<3 {print $1,$3}' pass 
root 0
bin 1
daemon 2
uucp 10

1）打印/etc/fstab中含有boot的行
[root@shell shelldoc]# awk '/boot/' /etc/fstab 
UUID=ab73b6db-6cfd-43dd-af99-9848973c7689 /boot                   ext4    defaults        1 2
[root@shell shelldoc]# awk '/boot/{print}' /etc/fstab 
UUID=ab73b6db-6cfd-43dd-af99-9848973c7689 /boot                   ext4    defaults        1 2
[root@shell shelldoc]# awk '/boot/{print $0}' /etc/fstab 
UUID=ab73b6db-6cfd-43dd-af99-9848973c7689 /boot                   ext4    defaults        1 2
2）打印pass文件中uid在5到8之间的用户的用户名和uid
[root@shell shelldoc]# awk -F: '$3>=5 && $3<=8{print $1,$3}' pass
3）打印passwd文件中uid为10的人的用户名，uid、家目录及shell
'$3==10{print $1,$3,$6,$7}' 
4）打印用户shell是登录shell的用户名及其shell
'/sh$/{print $1,$7}'
'$7 ~ /sh$/{print $1,$7}'
5）打印uid不大于5的用户名
'!($3>5){print $1}'
[root@shell shelldoc]# awk -F: '!($3>5){print $1}' pass
注意：括号改变运算的优先级
6）使用awk交换输出pass文件的第一个字段和第二个字段(其他字段正常输出)
[root@shell shelldoc]# awk -F: '{print $2":"$1":"$3":"$4":"$5":"$6":"$7}' pass
7）打印uid和gid不相同的用户的用户名、uid和gid
'$3!=$4{print $1,$3,$4}'
8）打印100以内能够被7整除，及包含7的数 （面试题）
[root@shell shelldoc]# seq 100 | awk '$1%7==0 || $1 ~ /7/'
[root@shell shelldoc]# seq 100 | awk '$1%7==0 || /7/'
[root@shell shelldoc]# seq 100 | awk '$0%7==0 || $0 ~ /7/'
[root@shell shelldoc]# seq 100 | awk '$0%7==0 || /7/'
```

​				



#### 4、赋值运算符			

![Untitled](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132229056.png)

## 四、awk的模式匹配（定址）

默认情况下，awk不支持行号定址

常见的模式

#### 1、空模式 ：每行都做动作的模式

```bash
[root@shell shelldoc]# awk '{print}' pass
```

#### 2、正则表达式

单一的正则

```bash
[root@shell shelldoc]# awk '/^root/{print}' pass
```

范围定址

```bash
[root@shell shelldoc]# awk '/^root/,/login$/{print}' pass 
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
```

#### 3、表达式

​		$3 < 10
​		$1 ~ /7/

#### 4、特殊模式

​		BEGIN{}   读取文件之前做，只做一次
​		END{}	  读取了所有文件内容之后才做，只做一次

#### 5、NR变量

​		Number of Record   可以代替行号的变量

```bash
[root@shell shelldoc]# awk '2{print}' pass   //反例
[root@shell shelldoc]# awk 'NR==2{print}' pass  //打印第2行
bin:x:1:1:bin:/bin:/sbin/nologin
```

​		打印奇数行

```bash
[root@shell shelldoc]# awk 'NR%2==1' pass
```

​		打印偶数行

```bash
[root@shell shelldoc]# awk 'NR%2==0' pass
```

​		从第一行开始，每3行打印一次

```bash
[root@shell shelldoc]# awk 'NR%3==1' pass
```

​			
​			
​			

## 五、awk的内置变量

#### NR变量

Number of Record   可以代替行号的变量

```bash
[root@shell shelldoc]# awk '2{print}' pass   //反例
[root@shell shelldoc]# awk 'NR==2{print}' pass  //打印第2行
bin:x:1:1:bin:/bin:/sbin/nologin
```

打印奇数行

```bash
[root@shell shelldoc]# awk 'NR%2==1' pass
```

打印偶数行

```bash
[root@shell shelldoc]# awk 'NR%2==0' pass
```

从第一行开始，每3行打印一次

```bash
[root@shell shelldoc]# awk 'NR%3==1' pass
```

#### NF变量 代表列数

```bash
[root@iZm5e4bxrlofss5j30ztx2Z ~]# awk -F: '{print $NF}' passwd    
/bin/bash
/sbin/nologin
```

#### FS变量 代表分隔符

```bash
[root@iZm5e4bxrlofss5j30ztx2Z ~]# awk  'BEGIN{FS="[:\t]"} {print $1}' passwd 
root
bin
```

#### OFS变量 输出分割符号

```bash
[root@iZm5e4bxrlofss5j30ztx2Z ~]# awk  'BEGIN{FS="[:\t]";OFS="@"} {print $1,$2}' passwd   
root@x
bin@x
```

#### RS：Record Separator，记录分隔符

一般是\n

```bash
[root@iZm5e4bxrlofss5j30ztx2Z ~]# echo a b oo c d |awk  'BEGIN{RS="oo"} {print $1,$2}'     \\oo用来区分记录
a b
c d
```

#### ORS：Output Record Separate，输出当前记录分隔符

一般是\n

```bash
[root@iZm5e4bxrlofss5j30ztx2Z ~]# echo a b oo c d |awk  'BEGIN{ ORS="PP"} {print $1,$2}'
a bPP[root@iZm5e4bxrlofss5j30ztx2Z ~]#
```

#### ARGV 命令行参数 

ARGC代表命令行第几个

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132244531.png" alt="Untitled" style="zoom: 67%;" />    

```bash
[root@iZbp1ealzv6zqhd71bns8sZ ~]# cat 1.txt
1 2 3 4
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk 'BEGIN{for(x=0;x<=ARGC;x++)print x,ARGC,ARGV[x]}' 1.txt 88 99
0 4 awk
1 4 1.txt
2 4 88
3 4 99
4 4 
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk 'BEGIN{for(x=1;x<=ARGC;x++)print x,ARGC,ARGV[x]}' 1.txt 88 99 
1 4 1.txt
2 4 88
3 4 99
4 4
```



#### ENVIRON 环境变量

```bash
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk 'BEGIN{for(env in ENVIRON)print env,ENVIRON[env]}'                      
AWKPATH .:/usr/share/awk
LANG en_US.UTF-8
HISTSIZE 1000
XDG_RUNTIME_DIR /run/user/0
USER root

或者直接访问某个变量
[root@iZbp1ealzv6zqhd71bns8sZ ~]# awk 'END{print ENVIRON["HOSTNAME"]}' 1.txt 
iZbp1ealzv6zqhd71bns8sZ
```

![Untitled](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132311039.png)

#### awk的变量

```bash
[root@iZm5e4bxrlofss5j30ztx2Z ~]# echo a b c d | awk 'BEGIN{one=1;two=2}{print $(one + two)}' 
c
```

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132313420.png" alt="Untitled" style="zoom:50%;" />

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132314775.png" alt="Untitled" style="zoom: 80%;" />



![Untitled](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204132315614.png)

#### 设置退出码

```bash
[root@iZbp1ealzv6zqhd71bns8sZ ~]# cat my_flask.py |awk '{print $0;exit 5}' 
# -*- coding: utf-8 -*
[root@iZbp1ealzv6zqhd71bns8sZ ~]# echo $?
5
[root@iZbp1ealzv6zqhd71bns8sZ ~]# cat my_flask.py |awk 'NR==1{print $0}END{exit 6}'  
# -*- coding: utf-8 -*
[root@iZbp1ealzv6zqhd71bns8sZ ~]# echo $?
6
[root@iZbp1ealzv6zqhd71bns8sZ ~]# 
```




​			
​			
​			
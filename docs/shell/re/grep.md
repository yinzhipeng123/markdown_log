# Grep

**grep**是一个最初用于[Unix](https://zh.wikipedia.org/wiki/Unix)操作系统的[命令行](https://zh.wikipedia.org/wiki/命令行)工具。在给出文件列表或[标准输入](https://zh.wikipedia.org/wiki/标准输入)后，grep会对匹配一个或多个[正则表达式](https://zh.wikipedia.org/wiki/正则表达式)的文本进行搜索，并只输出匹配（或者不匹配）的行或文本。

grep这个应用程序最早由[肯·汤普逊](https://zh.wikipedia.org/wiki/肯·汤普逊)写成。grep原先是ed下的一个应用程序，名称来自于g/re/p（globally search a regular expression and print，以正则表达式进行全局查找以及打印）。在ed下，输入g/re/p这个命令后，会将所有符合先定义样式的字符串，以行为单位打印出来。

在1973年，Unix第四版中，grep首次出现在man页面中。

[grep - 维基百科，自由的百科全书 (wikipedia.org)](https://zh.wikipedia.org/wiki/Grep)

不影响原文件内容，目的就是过滤出用户感兴趣的内容

grep处理的文件来源：文本文件、管道、标准输入

grep家族：grep、fgrep(grep -F)、egrep(grep -E)

## 命令格式

```bash
grep [选项] "正则表达式" 文件列表    
```

## grep执行状态三种返回值

0：该文件中搜索到了匹配行

1：该文件中未搜索到匹配行

2： 搜索的文件不存在

```bash
[root@shell shelldoc]# grep "root" /etc/passwd
root:x:0:0:root:/root:/bin/bash
operator:x:11:0:operator:/root:/sbin/nologin
[root@shell shelldoc]# echo $?
0
[root@shell shelldoc]# grep "roooot" /etc/passwd
[root@shell shelldoc]# echo $?
1
[root@shell shelldoc]# grep "root" /etc/passwd1
grep: /etc/passwd1: No such file or directory
[root@shell shelldoc]# echo $?
2
```

## grep基本使用

1、--color    带颜色显示匹配到的关键字

```bash
[root@shell shelldoc]# grep --color "root" /etc/passwd
root:x:0:0:root:/root:/bin/bash
operator:x:11:0:operator:/root:/sbin/nologin
```

2、-i   忽略大小写

```bash
[root@shell shelldoc]# cat pass 
Root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
uucp:x:10:14:uucp:/var/spool/uucp:/sbin/nologin
[root@shell shelldoc]# grep "root" pass --color
Root:x:0:0:root:/root:/bin/bash
[root@shell shelldoc]# grep -i "root" pass --color
Root:x:0:0:root:/root:/bin/bash
```

3、-v   取反

```bash
[root@shell shelldoc]# grep -v "nologin" /etc/passwd    //打印不包含nologin的行
```

4、^

```bash
打印/root/.bashrc文件中的注释行    
[root@shell shelldoc]# grep ^# /root/.bashrc
打印/etc/inittab文件中的非注释行 
[root@shell shelldoc]# grep -v ^# /etc/inittab 
id:5:initdefault:
```

5、$

```bash
显示passwd文件中以bash结尾的行
[root@shell shelldoc]# grep bash$ /etc/passwd
```

6、^$     空行

```bash
[root@shell shelldoc]# grep -v ^$ /etc/rc.local
```

7、-c   count   统计匹配到的行数

```bash
统计非空行的数量
[root@shell shelldoc]# grep -cv ^$ /etc/rc.local  
7
统计空行的数量
[root@shell shelldoc]# grep -c ^$ /etc/rc.local  
1        
```

8、-r  递归检索

9、-l       一般与-r联用，只显示包含关键字的文件名，而不是显示文件内容

```bash
[root@shell shelldoc]# grep -rl "if" /script/       
/script/adduser1.sh
/script/if7.sh
/script/for9.sh
/script/fuwu.sh
/script/if1.sh
```

10、-q      quiet    静默输出    一般在写脚本时候用

```bash
[root@shell shelldoc]# grep -q root /etc/passwd 
[root@shell shelldoc]# echo $?
0
```

11、-n   显示匹配行的行号

```bash
[root@shell shelldoc]# grep -n root /etc/passwd
1:root:x:0:0:root:/root:/bin/bash
11:operator:x:11:0:operator:/root:/sbin/nologin
```

12、其他选项
-A是显示匹配后和它后面的n行。

-B是显示匹配行和它前面的n行。

-C是匹配行和它前后各n行。  

```bash
grep -A  4 wike 密码文件.txt 
```

就是搜索  密码文件.txt，找到匹配“wike”字串的行，显示该行后后面紧跟的4行
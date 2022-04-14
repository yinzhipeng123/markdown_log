# sed

流编辑器    stream editor

是一种非交互式文本编辑器，默认是不会修改原文件的

工作原理：

一行一行处理，从文件的第一行开始读取，放到模式空间中进行相应处理，处理完将结果输出到屏幕上，然后继续读取下一行，直到所有的行都处理完毕，sed结束。

语法：

sed [选项] 'AddressCommand'  文件列表

#### 1、常用的选项

-n：静默输出，关闭模式空间的输出，一般与p一起用

-e：允许进行多项编辑，也就是说对同一行做多次处理、也可以做多点编辑  

```bash
-e '动作' -e '动作'   等价于  '动作1;动作2'

也可以{动作1;动作2}
```

-f：sed脚本：指定运行的sed脚本的

-r：允许使用扩展正则

```bash
[root@shell shelldoc]# sed -r 's/[0-9]+//' pass
```

-i：直接修改原文件

-i.后缀名：在修改之前先备份  -i.bak 

```bash
[root@shell shelldoc]# sed -i '/SELINUX/s/disabled/permissive/' /etc/selinux/config 
[root@shell shelldoc]# cat /etc/selinux/config                  
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=permissive
# SELINUXTYPE= can take one of these two values:
#     targeted - Targeted processes are protected,
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted 

在修改文件之前先备份	
[root@shell shelldoc]# sed -i.bak '/SELINUX/s/permissive/disabled/' /etc/selinux/config 
[root@shell shelldoc]# ls /etc/selinux/config*
/etc/selinux/config  /etc/selinux/config.bak
[root@shell shelldoc]# cat /etc/selinux/config

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of these two values:
#     targeted - Targeted processes are protected,
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
```

#### 2、Address ：  定址、地址

##### 1）单独的行号

​			如：1   就表示要处理第一行

​			$   表示最后一行

##### 2）起始行,结束行

​            如：  1,5         处理第一行到第五行

##### 3）/正则表达式/

​			如：/^root/     处理以root开头的行

##### 4）/正则表达式1/，/正则表达式2/        最小匹配

​			表示处理从匹配到正则表达式1的行开始，到第一次匹配到正则表达式2之间的所有行

​            如果正则表达式1匹配到了，正则表达式2未匹配到，那么就从匹配到正则表达式1的行开始，一直处理到文件结束

​            如果正则表达式1未匹配到，那么就不对文件做处理。

```bash
如：/^bin/,/bash$/
binsdadaddaddass
dsfasidsfdhfj09bash
dasdasdasdf--bash
```

##### 5）起始位置，+N     不是特别常用

​            表示从起始位置开始，后面的N行都处理

​			如：3,+5 	处理3-8行

##### 6）sed的分组命令，可以将一个地址嵌套另一个地址中

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204131352908.png" style="zoom:67%;" />

#### 3、命令 

常用的：d   p   s   y   q

其他的：a   c   i   r   w   

​			  h   H   g   G

##### 1）d：删除

```bash
[root@shell shelldoc]# sed '/UUID/d' /etc/fstab    
[root@shell shelldoc]# sed '1,5d' /etc/fstab
[root@shell shelldoc]# sed '$d' /etc/fstab
[root@shell shelldoc]# sed '/tmp/,/sfs/d' /etc/fstab
[root@shell shelldoc]# sed '/UUID/,+5d' /etc/fstab 
删除从第5行开始到最后一行的所有内容
[root@shell shelldoc]# sed '5,$d' /etc/passwd
```

##### 2）p：打印

```bash
[root@shell shelldoc]# cat -n /etc/passwd | head > pass
[root@shell shelldoc]# sed 'p' pass    //每行会打印两遍，一遍是处理结果，一遍是模式空间的输出
[root@shell shelldoc]# sed -n 'p' pass      //只会打印一遍，因为模式空间的输出被关闭了
[root@shell shelldoc]# sed -n '3,5p' pass   // 打印文件的3到5行
3	daemon:x:2:2:daemon:/sbin:/sbin/nologin
4	adm:x:3:4:adm:/var/adm:/sbin/nologin
5	lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin     
[root@shell shelldoc]# sed -n '3p' pass
3	daemon:x:2:2:daemon:/sbin:/sbin/nologin
```


​	! 非

```bash
[root@shell shelldoc]# sed '3!d' pass     //第三行不删除，其他行删除  不加-i等价于打印第3行
3	daemon:x:2:2:daemon:/sbin:/sbin/nologin
```

##### 3）r   读取

```bash
[root@shell shelldoc]# sed '/root/r /etc/issue' pass
1	root:x:0:0:root:/root:/bin/bash
Red Hat Enterprise Linux Server release 6.4 (Santiago)
Kernel \r on an \m

2	bin:x:1:1:bin:/bin:/sbin/nologin
3	daemon:x:2:2:daemon:/sbin:/sbin/nologin
4	adm:x:3:4:adm:/var/adm:/sbin/nologin
5	lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
6	sync:x:5:0:sync:/sbin:/bin/sync
7	shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
8	halt:x:7:0:halt:/sbin:/sbin/halt
9	mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
10	uucp:x:10:14:uucp:/var/spool/uucp:/sbin/nologin
```

##### 4）w 写

```bash
[root@shell shelldoc]# sed '/root/w /tmp/douni' pass  //将匹配到的行另存到文件中
[root@shell shelldoc]# cat /tmp/douni      
1	root:x:0:0:root:/root:/bin/bash   
```

##### 5）a   追加   在匹配到的行的下一行插入内容

```bash
[root@shell shelldoc]# sed '/root/a hello root' pass | head -5
1	root:x:0:0:root:/root:/bin/bash
hello root
2	bin:x:1:1:bin:/bin:/sbin/nologin
3	daemon:x:2:2:daemon:/sbin:/sbin/nologin
4	adm:x:3:4:adm:/var/adm:/sbin/nologin
```

​		在文件的最后一行插入新内容

```bash
[root@shell shelldoc]# sed '$a The End' pass 
1	root:x:0:0:root:/root:/bin/bash
2	bin:x:1:1:bin:/bin:/sbin/nologin
3	daemon:x:2:2:daemon:/sbin:/sbin/nologin
4	adm:x:3:4:adm:/var/adm:/sbin/nologin
5	lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
6	sync:x:5:0:sync:/sbin:/bin/sync
7	shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
8	halt:x:7:0:halt:/sbin:/sbin/halt
9	mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
10	uucp:x:10:14:uucp:/var/spool/uucp:/sbin/nologin
The End
```

##### 6）i  插入     在匹配行的上一行插入内容

```bash
[root@shell shelldoc]# sed '/daemon/i SO COOL' pass | head -5
1	root:x:0:0:root:/root:/bin/bash
2	bin:x:1:1:bin:/bin:/sbin/nologin
SO COOL
3	daemon:x:2:2:daemon:/sbin:/sbin/nologin
4	adm:x:3:4:adm:/var/adm:/sbin/nologin
[root@shell shelldoc]# sed '1i BEGINNING' pass  | head -5   //在第一行插入内容
BEGINNING
1	root:x:0:0:root:/root:/bin/bash
2	bin:x:1:1:bin:/bin:/sbin/nologin
3	daemon:x:2:2:daemon:/sbin:/sbin/nologin
4	adm:x:3:4:adm:/var/adm:/sbin/nologin
```

##### 7）c  修改       本行替换，将匹配到的行的内容替换成新内容

```bash
[root@shell shelldoc]# sed '/root/c ROOT' pass    
ROOT
2	bin:x:1:1:bin:/bin:/sbin/nologin
3	daemon:x:2:2:daemon:/sbin:/sbin/nologin
4	adm:x:3:4:adm:/var/adm:/sbin/nologin
5	lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
[root@shell shelldoc]# sed '/IPADDR/c IPADDR=172.16.254.201' /etc/sysconfig/network-scripts/ifcfg-eth0 
DEVICE=eth0
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=static
IPADDR=172.16.254.201
NETMASK=255.255.0.0
GATEWAY=172.16.254.1  
```

##### 8）y      转换的命令，对应替换

```bash
[root@shell shelldoc]# sed 'y/1234/ABCF/' pass
A	root:x:0:0:root:/root:/bin/bash
B	bin:x:A:A:bin:/bin:/sbin/nologin
C	daemon:x:B:B:daemon:/sbin:/sbin/nologin
F	adm:x:C:F:adm:/var/adm:/sbin/nologin
5	lp:x:F:7:lp:/var/spool/lpd:/sbin/nologin
6	sync:x:5:0:sync:/sbin:/bin/sync
7	shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
8	halt:x:7:0:halt:/sbin:/sbin/halt
9	mail:x:8:AB:mail:/var/spool/mail:/sbin/nologin
A0	uucp:x:A0:AF:uucp:/var/spool/uucp:/sbin/nologin
```

​		将文件中所有的小写字母转换成大写字母

```bash
[root@shell shelldoc]# sed 'y/qwertyuiopasdfghjklzxcvbnm/QWERTYUIOPASDFGHJKLZXCVBNM/' pass 
```

##### 9）n     next     处理匹配行的下一行，用的较少

```bash
[root@shell shelldoc]# sed -n '/root/p' pass
1	root:x:0:0:root:/root:/bin/bash
[root@shell shelldoc]# sed -n '/root/{n;p}' pass    //{}里面写多个命令，之间用分号分隔
2	bin:x:1:1:bin:/bin:/sbin/nologin
[root@iZbp1ealzv6zqhd71bns8sZ ~]# sed  '1{n;d}' passwd    //对第一行的下一行执行删除动作
1   root:x:0:0:root:/root:/bin/bash
3  daemon:x:2:2:daemon:/sbin:/sbin/nologin
4  adm:x:3:4:adm:/var/adm:/sbin/nologin
```

​       N 追加下一行

```bash
[root@iZbp1ealzv6zqhd71bns8sZ ~]# sed  '1{N;d}' passwd          //在第一行的基础上，在追加一行，再删除
3  daemon:x:2:2:daemon:/sbin:/sbin/nologin
4  adm:x:3:4:adm:/var/adm:/sbin/nologin                 
```

#####  10）q   退出       不再向模式空间读入新行

```bash
[root@shell shelldoc]# sed '/^bin/q' /etc/passwd   
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
[root@shell shelldoc]# sed '1q' pass    //head -1的又一种方法
1	root:x:0:0:root:/root:/bin/bash
```

##### 11）s   查找替换

定址s/模式匹配(旧的内容)/新的内容/[修饰符]

- s@@@
- s###
- s%%%

修饰符：

- g：全局替换，一行中的多个
- n：n为数字，1-512     替换第n个匹配到的内容
- p：打印
- w：另存为，写

```bash
[root@shell shelldoc]# sed 's/root/ROOT/' pass | head -3      //默认只替换第一次匹配到的
1	ROOT:x:0:0:root:/root:/bin/bash
2	bin:x:1:1:bin:/bin:/sbin/nologin
3	daemon:x:2:2:daemon:/sbin:/sbin/nologin
[root@shell shelldoc]# sed 's/root/ROOT/2' pass | head -3    //替换每行中第2个匹配到的
1	root:x:0:0:ROOT:/root:/bin/bash
2	bin:x:1:1:bin:/bin:/sbin/nologin
3	daemon:x:2:2:daemon:/sbin:/sbin/nologin
[root@shell shelldoc]# sed 's/root/ROOT/g' pass | head -3    //全部替换
1	ROOT:x:0:0:ROOT:/ROOT:/bin/bash
2	bin:x:1:1:bin:/bin:/sbin/nologin
3	daemon:x:2:2:daemon:/sbin:/sbin/nologin
[root@iZbp1ealzv6zqhd71bns8sZ ~]# cat /etc/passwd | head -n 2 | sed -e 's/root/yinzhipeng/g' -e 's/bin/uuu/g'   //多重替换
yinzhipeng:x:0:0:yinzhipeng:/yinzhipeng:/uuu/bash
uuu:x:1:1:uuu:/uuu:/suuu/nologin
```

删除文件中所有的数字

```bash
[root@shell shelldoc]# sed 's/[0-9]//g' pass
```

模式匹配时的特殊符号

^：每行的开头

```bash
给全文加注释
[root@shell shelldoc]# sed 's/^/#/' pass
在第8到10行的开头每行加上###
[root@shell shelldoc]# sed '8,10s/^/###/' pass
```

$：每行的结尾

```bash
在匹配到root的行的末尾添加###    
[root@shell shelldoc]# sed '/root/s/$/###/' pass
1	root:x:0:0:root:/root:/bin/bash###
```

&：引用  用来代替匹配到的模式的

```bash
将每一行的行号加上括号
[root@shell shelldoc]# sed -r 's/[0-9]+/(&)/' pass

[root@shell shelldoc]# cat vtest
hello, i like you
hi, my love


like ==> liker
love ==> lover
[root@shell shelldoc]# sed 's/l..e/&r/' test 
hello, i liker you
hi, my lover
[root@shell shelldoc]# sed -r 's/(l..e)/\1r/' test 
hello, i liker you
hi, my lover


like ==> Like
love ==> Love
[root@shell shelldoc]# sed -r 's/l(..e)/L\1/' test 
hello, i Like you
hi, my Love
```

​            

#### 每多少行操作一次

​	first~step

​		first：起始行号

​		step：步长

​		打印偶数行

```bash
[root@shell shelldoc]# sed -n '2~2p' pass
2	bin:x:1:1:bin:/bin:/sbin/nologin
4	adm:x:3:4:adm:/var/adm:/sbin/nologin
6	sync:x:5:0:sync:/sbin:/bin/sync
8	halt:x:7:0:halt:/sbin:/sbin/halt
10	uucp:x:10:14:uucp:/var/spool/uucp:/sbin/nologin
```

​		每3行打印一次

```bash
[root@shell shelldoc]# sed -n '1~3p' pass 
1	root:x:0:0:root:/root:/bin/bash
4	adm:x:3:4:adm:/var/adm:/sbin/nologin
7	shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
10	uucp:x:10:14:uucp:/var/spool/uucp:/sbin/nologin
```

​		=    打印当前行行号
```bash
[root@shell shelldoc]# wc -l pass 
10 pass
打印文件的行数
[root@shell shelldoc]# wc -l pass | cut -d" " -f1
10
[root@shell shelldoc]# sed -n '$=' pass 
10
```

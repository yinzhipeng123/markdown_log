# 分支判断

#### 命令执行是否成功

$？

#### shell内置的判断命令

test 条件表达式    test 5 -gt 3
[]   [ 5 -gt 3 ]     //表达式两边一定要有空格
[[]]  //支持正则表达，更加严谨


字符串判断

```bash
-n STRING    —— 字符串非空时结果为真
-z STRING    —— 字符串为空时结果为真
判断字符串为空的方法有三种：
if [ "$str" =  "" ]
if [ x"$str" = x ]
if [ -z "$str" ] （-n 为非空）
```

注意：都要代双引号，否则有些命令会报错，养成好习惯吧!
STRING1=STRING2  ——  两个字符串相同时为真
==双等于号和=单等于号作用相同，在做字符串比较时，作用相同
STRING1!=STRING2 —— 两个字符串不相同时为真

数值比较

```bash
ge   le  gt  lt   eq  ne
INTEGER1 -eq INTEGER2     —— 判断两个值是否相等
INTEGER1 -ge INTEGER2    —— 大于等于
INTEGER1 -gt INTEGER2      —— 大于
INTEGER1 -le INTEGER2       —— 小于等于
INTEGER1 -lt INTEGER2       ——  小于
INTEGER1 -ne INTEGER2     —— 不等于
```

```bash
(())  ——  数值比较
可以使用>   <  >=  <=  == != 
但是在这里==表示相等判断，=表示赋值
[root@bj docs]# ((5>3))
[root@bj docs]# echo $?
0
[root@bj docs]# ((5<3))
[root@bj docs]# echo $?
1
```


文件的判断

```bash
-d FILE     ——  判断目录是否存在
-e FILE     —— 判断文件是否存在
-f FILE     —— 判断文件是否是普通文件
-s FILE     —— 判断文件是否为空的
-b 文件 判断该文件是否存在， 并且是否为块设备文件（是块设备文件为真）
-c文件 判断该文件是否存在， 并且是否为字符设备文件（是字符设备文件为真）
-d 文件 判断该文件是否存在， 并且是否为目录文件（是目录为真）
-e 文件 判断该文件是否存在（存在为真）
-f 文件 判断该文件是否存在， 并且是否为普通文件（是普通文件为真）
-L 文件 判断该文件是否存在， 并且是否为符号链接文件（是符号链接文件为真）
-p 文件 判断该文件是否存在， 并且是否为管道文件（是管道文件为真）
-s 文件 判断该文件是否存在， 并且是否为非空（非空为真）
-S 文件 判断该文件是否存在， 并且是否为套接字文件（是套接字文件为真）
-r 文件 判断该文件是否存在， 并且是否该文件拥有读权限（ 有读权限为真）
-w文件 判断该文件是否存在， 并且是否该文件拥有写权限（ 有写权限为真）
-x 文件 判断该文件是否存在， 并且是否该文件拥有执行权限（ 有执行权限为真）
-u 文件 判断该文件是否存在， 并且是否该文件拥有SUID权限（ 有SUID权限为真）
-g 文件 判断该文件是否存在， 并且是否该文件拥有SGID权限（ 有SGID权限为真）
-k 文件 判断该文件是否存在， 并且是否该文件拥有SBit权限（ 有SBit权限为真）            
文件1 -nt 文件2  判断文件1的修改时间是否比文件2的新（ 如果新则为真）
文件1 -ot 文件2  判断文件1的修改时间是否比文件2的旧（ 如果旧则为真）
文件1 -ef 文件2  判断文件1是否和文件2的Inode号一致， 可以理解为两个文件是否为同一个文件。 这个判断用于判断硬链接是很好的方法
        
[root@shell script]# test -e /etc/passwd
[root@shell script]# echo $?
0
[root@shell script]# [ -e /etc/passwd ]    //注意空格
[root@shell script]# echo $?
0            
[root@shell script]# [ -d /douniwan ]
[root@shell script]# echo $?
1       
[root@shell script]# [ "abcd" = "abcd" ]     //字符串两边用双引号引上
[root@shell script]# echo $?
0
[root@shell script]# [ "abcd" = "abcde" ]
[root@shell script]# echo $?
1
[root@shell script]# name=haha
[root@shell script]# [ "$name" = "haha" ]
[root@shell script]# echo $?
0
[root@shell script]# [ "$name" = "hahaha" ]
[root@shell script]# echo $?
1
[root@shell script]# [ 1 -eq 2 ]
[root@shell script]# echo $?
1
[root@shell script]# [ 1 -le 2 ]
[root@shell script]# echo $?
0
```

命令的逻辑运算

```bash
逻辑与： &&
逻辑或： ||
逻辑非： !
判断1 -a 判断2  逻辑与， 判断1和判断2都成立， 最终的结果才为真
判断1 -o 判断2  逻辑或， 判断1和判断2有一个成立， 最终的结果就为真
```

​    如果用户不存在，就添加该用户
```bash
[root@shell script]# ! id user1 && useradd user1
uid=500(user1) gid=500(user1) groups=500(user1)
[root@shell script]# ! id user10 && useradd user10 
id: user10: No such user
[root@shell script]# id user10
uid=509(user10) gid=509(user10) groups=509(user10)     
[root@shell script]# ! id user11 &>/dev/null && useradd user11
[root@shell script]# id user11
uid=510(user11) gid=510(user11) groups=510(user11)
```
   如果用户不存在，就添加该用户；否则就打印用户已经存在的信息

```bash
[root@shell script]# ! id user11 && useradd user11 || echo "user user11 already exists"
uid=510(user11) gid=510(user11) groups=510(user11)
user user11 already exists
```

 
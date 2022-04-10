# 特殊字符

\   —— 表示转义

```bash
[root@shell ~]# echo $PATH
/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/root/bin
[root@shell ~]# echo \$PATH   //打印普通的$字符
$PATH
```

&  —— 后台运行

```bash
[root@shell ~]# sleep 100 &
```

;   —— 用来分隔多条命令(多条命令之间可以没有关系，即各个命令的结果互不影响)  

```bash
[root@shell ~]# cd /tmp;touch douniwan
[root@shell tmp]# ls douniwan 
douniwan
[root@shell tmp]# cd /douniwan;touch suibian
bash: cd: /douniwan: No such file or directory
[root@shell tmp]# ls suibian 
suibian 
```

&& —— 连接两条命令，前面的命令执行成功，才执行后面的命令(并且)

```bash
[root@shell tmp]# ls douniwan && pwd
douniwan
/tmp
[root@shell tmp]# ls doushuiwan && pwd
ls: cannot access doushuiwan: No such file or directory    
[root@shell tmp]# make && make install    //后面会用到的，只有make成功了，才执行make install
```

||  —— 连接两条命令，前面的命令执行失败，才会执行后面的命令(或者)

```bash
[root@shell tmp]# ls douniwan || pwd
douniwan
[root@shell tmp]# ls doushuiwan || pwd
ls: cannot access doushuiwan: No such file or directory
/tmp    
```

(cmds)   —— 开启子shell
在shell环境中再开启一个shell，新开启的shell被称为子shell，原来的shell被称为父shell。

```bash
[root@shell script]# cd /tmp ; touch shadouxing      //在当前shell中执行的，会影响当前的shell
[root@shell tmp]# pwd
/tmp
[root@shell tmp]# (cd /root ; touch shenmexing)    //在当前shell开启子shell去执行，命令执行结束，子shell终止，不会影响父shell的运行的。
[root@shell tmp]# pwd       //父shell的路径并未发生改变
/tmp
[root@shell tmp]# ls /root/shenmexing 
/root/shenmexing
```

子shell能够继承父shell中的环境变量
{cmds}  —— 不开启子shell，直接在当前shell中运行

引用：即屏蔽特殊符号的含义
'   '  —— 单引号，完全引用，也叫强引用。能够屏蔽除了自己以外的所有的特殊字符
"  "  ——  双引号，非完全引用，也叫弱引用。能够屏蔽大部分的特殊字符，屏蔽不了$和`

```bash
[root@shell tmp]# echo '$PATH'
$PATH
[root@shell tmp]# echo "$PATH"
/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/root/bin
```

命令的引用(也叫命令的替换)

``  —— 反引号  使用的是命令的执行结果
$() —— 也是命令的引用

注意：默认的情况下，反引号是不支持嵌套的。

```bash
[root@shell tmp]# rpm -qf `which `
-enhanced-7.2.411-1.8.el6.x86_64
[root@shell tmp]# rpm -qf $(which )
-enhanced-7.2.411-1.8.el6.x86_64
```

嵌套：

```bash
[root@shell tmp]# dir_name=`basename `pwd``     //嵌套会报错
basename: missing operand
Try `basename --help' for more information.
[root@shell tmp]# dir_name=$(basename $(pwd))   //支持嵌套
[root@shell tmp]# echo $dir_name
tmp   
```
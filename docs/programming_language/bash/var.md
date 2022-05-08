Bash变量

用来存储信息的，其实是内存中的空间，一个变量保存一个值

#### 变量的命名规则

变量的名字一定是由字母、数字和下划线组成，不能以数字开头，变量名不能使用关键字
合法的：a2   PRONAME    _name     a_3
非法的：2a   a@b
引用变量：$a2

```bash
[root@node0 ~]# env	--查看所有的环境变量
[root@node0 ~]# set	--查看所有的变量  
```

#### shell中变量的类型

1. 本地变量(局部变量)
2. 环境变量(全局变量)
3. 位置变量
4. 特殊变量

​    

##### 本地变量  ——  局部变量

也叫自定义变量，用户根据自己的需求自己定义的变量
作用域(作用范围)：在整个shell脚本中生效；如果是在命令行定义的变量，作用范围就是当前shell。
定义变量： 变量名=变量值       //注意：等号两边一定不能有空格

```bash
[root@shell tmp]# name=mary        
[root@shell tmp]# echo $name
mary
[root@shell tmp]# echo $SHLVL     //查看当前在第几级shell
2
[root@shell tmp]# bash            //开启一个子shell
[root@shell tmp]# echo $SHLVL     //查看当前在第几级shell
3
[root@shell tmp]# echo $name      //在子shell中是看不到父shell中的本地变量
[root@shell tmp]# exit
exit
[root@shell tmp]# echo $SHLVL 
2
```

##### 环境变量 —— 全局变量

作用范围：当前shell及其子shell

```bash
定义环境变量：
1）将已经定义的本地变量导出成环境变量   export
[root@shell tmp]# export name
[root@shell tmp]# echo $name
mary
[root@shell tmp]# bash
[root@shell tmp]# echo $name      //在子shell中可以看到name的值了
mary
2）在定义变量时，直接将其定义为环境变量
[root@shell tmp]# echo $SHLVL
2
[root@shell tmp]# export age=88
[root@shell tmp]# bash
[root@shell tmp]# echo $age
88 
注意：在子shell中修改变量的值，不影响父shell中的变量的值。
[root@shell tmp]# echo $SHLVL
3
[root@shell tmp]# age=66
[root@shell tmp]# echo $age
66
[root@shell tmp]# exit
exit
[root@shell tmp]# echo $age
88     
父变子也变，子变父不变。
如果想让环境变量永久生效，那么就写在环境变量配置文件中即可。
取消变量的值
[root@shell tmp]# unset name
[root@shell tmp]# echo $name    
```

##### 位置变量

$0  —— 表示当前运行的脚本或者命令本身
$1 ~ ${10} —— 表示脚本的位置参数，$1表示第一个参数，依此类推
$# —— 表示参数的个数
$* 这个变量代表命令行中所有的参数， $*把所有的参数看成一个整体
$@ 这个变量也代表命令行中所有的参数， 不过$@把每个参数区分对待
$@和$* —— 表示参数的列表

```bash
[root@shell tmp]# ls /root /tmp
ls  ——  $0
/root  —— $1
/tmp  —— $2
[root@shell tmp]# cd /script/
[root@shell script]# cat position.sh
#!/bin/bash
echo '$0='$0     
echo '$1='$1     
echo '$2='$2     
echo '$3='$3     
echo '$4='$4     
echo '$5='$5     
echo '$6='$6     
echo '$7='$7     
echo '$8='$8     
echo '$9='$9     
echo '$10='$10     
echo '$11='${11}     
echo '$#='$#
echo '$*='$*
echo '$@='$@
[root@shell script]# chmod +x position.sh 
[root@shell script]# ./position.sh a b c d e f g h i j k l m
$0=./position.sh
$1=a
$2=b
$3=c
$4=d
$5=e
$6=f
$7=g
$8=h
$9=i
$10=a0
$11=k
$#=13      // 参数的个数
$*=a b c d e f g h i j k l m      //打印参数列表
$@=a b c d e f g h i j k l m
```

$*和$@是Shell的特殊变量，作用都是获取传递给脚本或函数的所有参数。在没有被双引号包围时，两者没有区别，都是将接受到的每个参数都是独立的，用空格分隔。也就是说下面两段代码是等效的。

```bash
[root@localhost code]# cat test
for var in $@
do
	echo ${var}
done
[root@localhost code]#
[root@localhost code]# ./test a b c d e
a
b
c
d
e
[root@localhost code]#
[root@localhost code]# chmod a+x test1
[root@localhost code]# cat test1
for var in $*
do
	echo ${var}
done
[root@localhost code]# ./test1 a b c d
a
b
c
d
```

当被双引号包围时，$@与没有被双引号包围时没有变化，每个参数依然是独立的。但是$*被双引号包围时，会将所有参数看作一个整体。下面两段代码的结果是不同的。

```bash
[root@localhost code]# cat test
for var in "$@"
do
	echo ${var}
done

[root@localhost code]# ./test a b c d
a
b
c
d
[root@localhost code]#
[root@localhost code]# cat test1
for var in "$*"
do
	echo ${var}
done
[root@localhost code]#
[root@localhost code]# ./test1 a b c d
a b c d
[root@localhost code]#
```

##### 特殊变量

$$   ——  查看当前shell的pid

```bash
[root@shell script]# echo $$
8015 
```


!$和$_    —— 上一条命令的最后一个参数

```bash
[root@shell yum.repos.d]#  cd /etc/yum.repos.d/  
[root@shell yum.repos.d]#  cat local.repo
[root@shell yum.repos.d]#  cat !$
或者  alt+.(点)  也可以
```

$?：上一条命令的执行状态的返回值  —— 写脚本时有用
执行状态返回值(0-255)，分两类

```bash
0：表示上一条命令执行成功
非0：表示上一条命令执行失败
[root@shell ~]# ls /tmp/douniwan &>/dev/null
[root@shell ~]# echo $?
0
[root@shell ~]# ls /tmp/nidoushui &>/dev/null
[root@shell ~]# echo $?
2
```

#### 变量的引用

1、$变量名

```bash
 echo $变量名
```

2、${变量名} —— 为了防止歧义

```bash
[root@shell ~]# fruit=banana
[root@shell ~]# echo "There are some $fruits."
There are some .
[root@shell ~]# echo "There are some ${fruit}s."
There are some bananas.      
```

#### local关键字

作用：一般用于shell内局部变量的定义，多使用在函数内部

（1）shell脚本中定义的变量是global的，其作用域从被定义的地方开始，到shell结束或被显示删除的地方为止。

（2）shell函数定义的变量默认是global的，其作用域从`函数被调用时执行变量定义的地方`开始，到shell结束或被显示删除处为止。函数定义的变量可以被显示定义成local的，其作用域局限于函数内。但请注意，函数的参数是local的。

（3）如果同名，Shell函数定义的local变量会屏蔽脚本定义的global变量。

```bash
#!/bin/bash
function Hello()
{
local text="Hello World!!!" #局部变量
echo $text
}

Hello
```
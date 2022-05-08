# case

多分支判断

```bash
语法结构：
case 变量 in
值1）
命令1
;;
值2）
命令2
;;
... ...
... ...
值n）
命令n
;;
*）
命令
;;
esac
如果变量的值满足的是 值1，执行命令1；如果不满足，继续向下匹配值2，执行命令2，... ...
```

  `*` 表示的通配，除了上面所有的值以外的值

  注意：分号和esac

```bash
变量常见的
$name
$1  $2  ...  ...
```
例子1：

```bash
[root@shell script]#  case1.sh
#!/bin/bash
read -p "Please input a username: " username
case $username in
root)
echo "You are super user."
;;
oracle)
echo "You are oracle account."
;;
*)
echo "You are nothing."
;;
esac
[root@shell script]# sh case1.sh 
Please input a username: root
You are super user.
[root@shell script]# sh case1.sh 
Please input a username: oracle
You are oracle account.
[root@shell script]# sh case1.sh 
Please input a username: douniwan
You are nothing.
```

例子2：判断成绩

```bash
[root@shell script]#  case2.sh
#!/bin/bash
read -p "Please input your score: " score
case $score in
9[0-9]|100)
echo "excellent"
;;
8[0-9])
echo "good"
;;
[67][0-9])
echo "just so so"
;;
[0-9]|[1-5][0-9])
echo "you must work hard"
;;
*)
echo "error"
;;
esac
```

```bash
[0-9] : 表示数字
|  : 或者
```

同时匹配两个变量的方法：

1、将两个变量看成一个整体

```bash
[root@shell script]#  case3.sh
#!/bin/bash
read -p "Please input your username: " username
read -s -p "Please input your password: " password
echo
case "$username $password" in
"root redhat")
echo "You are right."
;;
"oracle ora")
echo "You are right for oracle."
;;
*)
echo "You are wrong."
;;
esac
```

 2、用任意符号分隔两个变量

```bash
case $username,$password in 
root,redhat)
```



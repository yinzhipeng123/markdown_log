read
================================================================================

能够从标准输入读取用户输入的值，然后传递给脚本中的变量，以供使用

预制件：

```bash
echo：打印变量值、打印字符串等
-e：让echo支持以下符号
\t：tab
\n：换行
[root@shell script]# echo -e "hello\tworld\nhello everyone"
hello	world
hello everyone
-n：不换行
[root@shell script]# echo -n "xxx"
xxx[root@shell script]# 
```



#### 1、read   读取用户输入

```bash
[root@shell script]# cat sc4.sh
#!/bin/bash
echo -n "Please input the username you want to add: "
read username     //read 变量名
useradd $username && echo "user $username added."
[root@shell script]# sh sc4.sh 
Please input the username you want to add: jiujiu
user jiujiu added.
```

#### 2、read   自身显示提示信息    

`-p`		打印提示的    ——   prompt：提示   

```bash
[root@shell script]# cp sc4.sh sc5.sh
[root@shell script]# cat sc5.sh
#!/bin/bash
read -p "Please input the username you want to add: " username  //read -p 提示信息 变量名
useradd $username && echo "user $username added."              //提示信息和变量名之间必有空格
[root@shell script]# sh sc5.sh 
Please input the username you want to add: doushuine
user doushuine added.
```

#### 3、read 不回显用户输入的信息     

`-s`		不显示用户输入的信息

```bash
[root@shell script]# cp sc5.sh sc6.sh
[root@shell script]# cat sc6.sh
#!/bin/bash
read -p "Please input the username you want to add: " username
read -s -p "Please input the password you want to set: " password
echo   //换行
useradd $username && echo "user $username added."
echo $password | passwd --stdin $username &>/dev/null && echo "password set successfully."
[root@shell script]# sh sc6.sh 
Please input the username you want to add: taa
Please input the password you want to set: 
user taa added.
password set successfully.
echo：可以用来打印空行或者换行。
```

#### 4、限制读取时间   

`-t`		秒数

```bash
[root@shell script]# cp sc6.sh sc7.sh
[root@shell script]# cat sc7.sh
#!/bin/bash
read -p "Please input the username you want to add: " -t 5 username   //单位是秒
read -s -p "Please input the password you want to set: " password
echo "***"
useradd $username && echo "user $username added."
echo $password | passwd --stdin $username &>/dev/null && echo "password set successfully."
```

read： 

​    -p：打印提示信息

​    -s：不回显用户输入的信息

​    -t 时间：限制读取输入的等待时间


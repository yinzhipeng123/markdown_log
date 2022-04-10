# 函数


函数就是完成某个特定功能的一段脚本

函数本身不能独立运行，需要时通过函数名调用它。

说明：使用函数，一定要先定义，再去使用。

脚本中函数的作用，就是把 命令模块化 ，缩减命令的输入次数

## 一、函数的定义

第一种方法

```bash
function FUNCTION_NAME{
函数体 
}
```

第二种方法：

```bash
函数名(){
函数体            
}
```

## 二、函数的调用

直接使用函数名即可调用函数

showmenu

## 三、自定义函数状态返回值

return 数字        //  数字范围：0-255

```bash
[root@shell script]#  cat  adduser.sh
#!/bin/bash
USERADD(){
username=douniwanba
if ! id $username &> /dev/null
then
	useradd $username
	return 0
else
	return 1
fi
}
USERADD
if [ $? -eq 0 ]     //比较函数状态返回值是否为0
then
	echo "user $username added successfully."
else
	echo "user $username already exists."
fi
```

## 四、带参数的函数

调用带参数的函数的时候，需要加参数

函数名 参数1 参数2 ... ...

```bash
[root@shell script]# cp adduser.sh adduser1.sh
[root@shell script]#  adduser1.sh    
[root@shell script]# cat adduser1.sh 
#!/bin/bash
USERADD(){
username=$1
if ! id $username &> /dev/null
then
	useradd $username
	return 0
else
	return 1
fi
}
for i in `seq 10`
do
	USERADD user$i     //添加用户user1~user10
	if [ $? -eq 0 ]
	then
		echo "user $username added successfully."
	else
		echo "user $username already exists."
	fi
done
for i in `seq 10`
do
	USERADD test$i   //添加用户test1~test10
	if [ $? -eq 0 ]
	then
		echo "user $username added successfully."
	else
		echo "user $username already exists."
	fi
done     
```
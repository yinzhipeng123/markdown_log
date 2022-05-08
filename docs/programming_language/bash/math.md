# Shell 中的运算

```bash
+ - * /  % (取余) **(幂运算)
```

运算符

| 优先级 | 运算符                                     | 运算符                                |
| ------ | ------------------------------------------ | ------------------------------------- |
| 13     | -，+                                       | 单目负、 单目正                       |
| 12     | !，~                                       | 逻辑非、 按位取反或补码               |
| 11     | *，/，%                                    | 乘、 除、 取模                        |
| 10     | +，-                                       | 加、 减                               |
| 9      | <<，>>                                     | 按位左移、 按位右移                   |
| 8      | <=，>=，<，>                               | 小于或等于、 大于或等于、 小于、 大于 |
| 7      | ==，!=                                     | 等于、 不等于                         |
| 6      | &                                          | 按位与                                |
| 5      | ^                                          | 按位异或                              |
| 4      | \|                                         | 按位或                                |
| 3      | &&                                         | 逻辑与                                |
| 2      | \|\|                                       | 逻辑或                                |
| 1      | =，+=，-=，*=，/=，%=，&=，^=，=，<<=，>>= | 赋值、 运算且赋值                     |

#### 1、 $((运算式))   或  $[运算式]

```bash
$[]和$(())
[root@shell ~]# echo $[1+2]
3
[root@shell ~]# echo $((1+2))
3
[root@shell ~]# echo $[2**16]
65536
```

#### 2、expr   数值运算工具

```bash
[root@localhost ~]# aa=11
[root@localhost ~]# bb=22
#给变量aa和变量bb赋值
[root@localhost ~]# dd=$(expr $aa + $bb)
#dd的值是aa和bb的和。注意“+”号左右两侧必须有空格 
```

#### 3、let

常用于while循环变量更新

let 变量=值，运算公式里面不能有空格

```bash
[root@shell ~]# let sum=1+2
[root@shell ~]# echo $sum
3
[root@shell ~]# a=8
[root@shell ~]# b=5
[root@shell ~]# let ji=$a*$b
[root@shell ~]# echo $ji
40
[root@shell ~]# let i++     //在循环中更新变量值常用的，每次i的值加1
```

#### 4、Linux计算器

```bash
[root@shell ~]# bc
bc 1.06.95
Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006 Free Software Foundation, Inc.
This is free software with ABSOLUTELY NO WARRANTY.
For details type `warranty'. 
5/6
0
6/5
1
9/8
1
scale=3    //指定精度，精度就是小数点后保留几位小数
9/8
1.125
1/3
0.333
ctrl + d 退出
```

####  4、 declare命令

选项：
-： 给变量设定类型属性

+：取消变量的类型属性

-i：将变量声明为整数型（integer）

-x：将变量声明为环境变量

-p：显示指定变量的被声明的类型a : 将变量声明为数组型

r：将变量声明为只读变量

p：显示指定变量的被声明的类型

```bash
[root@localhost ~]# aa=11
[root@localhost ~]# bb=22
#给变量aa和bb赋值
[root@localhost ~]# declare -i cc=$aa+$bb
```

1、变量声明为数值型

```bash
declare -i num=12
也可以查看变量类型
declare -p num
得到的结果如下
declare -i num="12"
```

2、声明数组变量

（1）定义数组

```bash
arr[0]=x
arr[1]=y
declare -a arr[2]=z
```

（2）查看数组

```bash
echo ${arr} ---结果x
echo ${arr[2]} ---结果z
echo ${arr[8]} ---结果x y z
和普通变量区别是使用大括号，同时使用下标，若没有下标，则默认使用0。
```

3、声明环境变量

```bash
declare -x t=123
export命令调用的也是上面declare -x 的命令
```

4、声明变量只读属性

```bash
declare -r a=123
重新赋值会报错，不能修改，不能删除
```


5、查看变量属性

```bash
declare -p     查看所有变量属性
declare -p  变量名  查看指定变量的属性
```


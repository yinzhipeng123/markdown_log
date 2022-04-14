# awk使用变量

如果第四列匹配  :加变量，就打印

![Untitled](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142101270.png)

```bash
netstat -tan4p | awk '{if($4~/:'''$a'''$/){print $0}}'
```



## awk中使用bash中的变量

### 一 用特殊符号

```bash
"'$var'"
```

这种写法大家无需改变用`'`括起awk程序的习惯,是老外常用的写法.如:

```bash
var="test"
awk 'BEGIN{print "'$var'"}'
```

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142156686.png" alt="Untitled" style="zoom:67%;" />



如果var中含空格,为了shell不把空格作为分格符,便应该如下使用:

```bash
var="this is a test"
awk 'BEGIN{print "'"$var"'"}'
```

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142159270.png" alt="Untitled" style="zoom:67%;" />

### 二 使用环境变量

```bash
export 变量,使用ENVIRON["var"]形式,获取环境变量的值
```

例如:

```bash
var="this is a test"; export var;
awk 'BEGIN{print ENVIRON["var"]}'
```

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142201957.png" alt="Untitled" style="zoom:67%;" />



### 三 awk的-v

可以使用awk的-v选项  （如果变量个数不多，个人偏向于这种写法）

例如:

```bash
var="this is a test"
awk -v awk_var="$var" 'BEGIN {print awk_var}'
```

这样便把系统变量var传递给了awk变量awk_var.

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142202176.png" alt="Untitled" style="zoom:67%;" />

##  awk向bash变量传递值

由awk向shell传递变量，其思想无非是用awk(sed/perl等也是一样)输出若干条shell命令，然后再用shell去执行这些命令。

```bash
eval $(awk 'BEGIN{print "var1='str1';var2='str2'"}')
```

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142203834.png" alt="Untitled"  />

或者

```bash
eval $(awk '{printf("var1=%s; var2=%s; var3=%s;",$1,$2,$3)}' abc.txt)
```

![Untitled](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142205425.png)

之后可以在当前shell中使用var1,var2等变量了。

```bash
echo "var1=$var1 ----- var2=$var2"
```

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142207427.png" alt="Untitled" style="zoom:67%;" />

 指定行号

![Untitled](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204142208451.png)

 

参考资料：

http://developer.51cto.com/art/200509/3781.htm

http://www.ixpub.net/thread-1457438-1-1.html

https://blog.csdn.net/xiaolang85/article/details/79884535


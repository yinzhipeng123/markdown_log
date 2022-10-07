# 循环

循环语句，而[循环语句]由[循环体]及循环的判定[条件]两部分组成



```
while_stmt ::=  "while" assignment_expression ":" suite
                ["else" ":" suite]
```



### while 循环

Python 中 while 语句的一般形式：

```
while 判断条件(condition)：
    执行语句(statements)……
```



<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202209191855903.png" alt="image-20220919185210016" style="zoom:33%;" />

例：

```python
counter = 0

while counter <= 10:
    counter += 1
    print(counter)
```

运行结果：

```
1
2
3
4
5
6
7
8
9
10
11
```



#### wile死循环

```python
from time import sleep
var = 1
while var == 1:  # 表达式永远为 true
    sleep(1) # 睡一秒
    print(var)
```

运行结果：

```
1
1
1
1
。。。 （直到按下ctrl+1才结束）
```



### while 循环使用 else 语句

如果 while 后面的条件语句为 false 时，则执行 else 的语句块。

语法格式如下：

```
while <expr>:
    <statement(s)>
else:
    <additional_statement(s)>
```

expr 条件语句为 true 则执行 statement(s) 语句块，如果为 false，则执行 additional_statement(s)。

循环输出数字，并判断大小：



```python
count = 0
while count < 5:
   print (count, " 小于 5")
   count = count + 1
else:
   print (count, " 大于或等于 5")
```

运行结果：

```
0  小于 5
1  小于 5
2  小于 5
3  小于 5
4  小于 5
5  大于或等于 5
```



### while 循环使用 break 语句

```
n = 5
while n > 0:
    n -= 1
    if n == 2:
        break
    print(n)
print('循环结束。')
```

运行结果：

```
4
3
循环结束。
```

### while 循环使用 continue 语句

```python
n = 5
while n > 0:
    n -= 1
    if n == 2:
        continue
    print(n)
print('循环结束。')
```

运行结果：

```
4
3
1
0
循环结束。
```



ß[8. 复合语句 — Python 3.10.7 文档](https://docs.python.org/zh-cn/3.10/reference/compound_stmts.html#the-while-statement)




# 循环

循环语句，而[循环语句]由[循环体]及循环的判定[条件]两部分组成  



```python
for_stmt ::=  "for" target_list "in" expression_list ":" suite
              ["else" ":" suite]
```



## for 语句

Python for 循环可以遍历任何可迭代对象，如一个列表或者一个字符串。

for循环的一般格式如下：

```
for <variable> in <sequence>:
    <statements>
else:
    <statements>
```



<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202209192027552.png" alt="image-20220919202748489" style="zoom:33%;" />

例：

```pyßthon
for i in range(5,8):
    print(i)
```

运行结果：

```
5
6
7
```



#### `break`、`continue` 语句及 `else` 子句

[`break`](https://docs.python.org/zh-cn/3.10/reference/simple_stmts.html#break) 语句，用于跳出最近的 [`for`](https://docs.python.org/zh-cn/3.10/reference/compound_stmts.html#for) 或 [`while`](https://docs.python.org/zh-cn/3.10/reference/compound_stmts.html#while) 循环。

循环语句支持 `else` 子句；[`for`](https://docs.python.org/zh-cn/3.10/reference/compound_stmts.html#for) 循环中，可迭代对象中的元素全部循环完毕，或 [`while`](https://docs.python.org/zh-cn/3.10/reference/compound_stmts.html#while) 循环的条件为假时，执行该子句；[`break`](https://docs.python.org/zh-cn/3.10/reference/simple_stmts.html#break) 语句终止循环时，不执行该子句。 请看下面这个查找素数的循环示例：

```
for n in range(2, 10):
    for x in range(2, n):
        if n % x == 0:
            print(n, 'equals', x, '*', n // x)
            break
    else:
        print(n, 'is a prime number')
```

运行结果：

```
2 is a prime number
3 is a prime number
4 equals 2 * 2
5 is a prime number
6 equals 2 * 3
7 is a prime number
8 equals 2 * 4
9 equals 3 * 3
```



[`continue`](https://docs.python.org/zh-cn/3.10/reference/simple_stmts.html#continue) 语句，表示继续执行循环的下一次迭代

```
for num in range(2, 10):
    if num % 2 == 0:
        print("Found an even number", num)
        continue
    print("Found an odd number", num)
```

运行结果：

```
Found an even number 2
Found an odd number 3
Found an even number 4
Found an odd number 5
Found an even number 6
Found an odd number 7
Found an even number 8
Found an odd number 9
```


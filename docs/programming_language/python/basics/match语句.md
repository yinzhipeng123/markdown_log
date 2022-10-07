# match语句

Switch 语句存在于很多编程语言中，早在 2016 年，PEP 3103 就被提出，建议 Python 支持 switch-case 语句。

时间在推到 2020 年，Python的创始人Guido van Rossum，提交了显示 switch 语句的第一个文档，命名为 Structural Pattern Matching。

如今，随着 Python 3.10 beta 版的发布，终于将 switch-case 语句纳入其中。

在 Python 中，这一功能由 match 关键词和 case 语句组成。

#### 最简单的例子

一个值，即主词，被匹配到几个字面值，即模式。在下面的例子中，`status` 是匹配语句的主词。模式是每个 case 语句，字面值代表请求状态代码。匹配后，将执行与该 case 相关的动作

```python
def http_error(status):
    match status:
        case 400:
            return "Bad request"
        case 404:
            return "Not found"
        case 418:
            return "I'm a teapot"
        case 401 | 403 | 404:
            return "Not allowed"
        case _:
            return "Something's wrong with the internet"


mystr = http_error(500)
print(mystr)
```

运行结果：

```
Something's wrong with the internet
```



直接使用

```python
coordinate = (0, 6)
match coordinate:
    case (0, 0):
        print("Origin")
    case (0, y):
        print(f"Y={y}")
    case (x, 0):
        print(f"X={x}")
    case (x, y):
        print(f"X={x}, Y={y}")
    case _:
        raise ValueError("Not a coordinate")
```

运行结果：

```
Y=6
```



#### 类中使用

如果你使用类来结构化你的数据，你可以使用类的名字，后面跟一个类似构造函数的参数列表，作为一种模式。这种模式可以将类的属性捕捉到变量中:

```
class Point:
    def __init__(self, a, b):
        self.a = a
        self.b = b


def location(point):
    match point:
        case Point(a=0, b=0):
            print("Origin is the point's location.")
        case Point(a=0, b=b):
            print(f"Y={b} and the point is on the y-axis.")
        case Point(a=a, b=0):
            print(f"a={a} and the point is on the x-axis.")
        case Point():
            print("The point is located somewhere else on the plane.")
        case _:
            print("Not a point")


point = Point(0, 1)
location(point)
```

运行结果：

```
Y=1 and the point is on the y-axis.
```



我们可以向一个模式添加 `if` 子句，称为“约束项”。 如果约束项为假值，则 `match` 将继续尝试下一个 case 语句块。 请注意值的捕获发生在约束项被求值之前。:

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y


point = Point(x=0, y=0)
match point:
    case Point(x=x, y=y) if x == y:
        print(f"The point is located on the diagonal Y=X at {x}.")
    case Point(x=x, y=y):
        print(f"Point is not on the diagonal.")

```

运行结果：

```
The point is located on the diagonal Y=X at 0.
```



例：

```python
from enum import Enum
class Color(Enum):
    RED = 0
    GREEN = 1
    BLUE = 2

match color:
    case Color.RED:
        print("I see red!")
    case Color.GREEN:
        print("Grass is green")
    case Color.BLUE:
        print("I'm feeling the blues :(")
```

运行结果：

```python
Enter your choice of 'red', 'blue' or 'green': red
I see red!
```



#### 复杂一点的例子



```python
def func(person):
    match person:
        case (name, "teacher"):
            print(f"{name} is a teacher.")
        case (name, _, "male"):
            print(f"{name} is male.")
        case (name, _, "female"):
            print(f"{name} is female.")
        case (name, age, gender):
            print(f"{name} is {age} old.")
```

运行结果：

```
Sam is a teacher.
John is male.
John is female.
John is 25 old.
```



官方文档：

[4. 其他流程控制工具 — Python 3.10.7 文档](https://docs.python.org/zh-cn/3.10/tutorial/controlflow.html#match-statements)

[Python 3.10 有什么新变化 — Python 3.10.7 文档](https://docs.python.org/zh-cn/3.10/whatsnew/3.10.html)
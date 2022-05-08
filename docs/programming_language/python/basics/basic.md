python3.9.6

## map函数



```python
def sq(x):
    return x * x


print(list(map(sq, [1, 2, 3, 4, 5])))
```

结果：

```bash
[1, 4, 9, 16, 25]
```



## lambda函数

例1：

```python
def sq(x):
    return x * x


print(list(map(lambda x: x*x,[y for y in range(6)])))
```

结果：

```bash
[0, 1, 4, 9, 16, 25]
```

例2：

```python
funca = lambda x, y, z: (x + 8) * y - z
print(funca(5, 6, 8))
```

结果：

```bash
70
```

## -> 的用法

`->`常常出现在python函数定义的函数名后面，为函数添加`元数据`,描述函数的返回类型

```python
def add(a: int, b: int) -> int:
   return a + b


print(add.__annotations__)

result = add(8, 8)

print(result)
```

结果：

```bash
{'a': <class 'int'>, 'b': <class 'int'>, 'return': <class 'int'>}
64
```



##   ______annotations______  的用法

以字典的形式存放在函数的 `__annotations__` 属性中，并且不会影响函数的任何其他部，打印函数的标注

https://docs.python.org/zh-cn/3/tutorial/controlflow.html

```python
def f(ham: str, eggs: str = 'eggs') -> str:
    print("Annotations:", f.__annotations__)
    print("Arguments:", ham, eggs)
    return ham + ' and ' + eggs


g = f('spam')
print(g)
```

结果：

```
Annotations: {'ham': <class 'str'>, 'eggs': <class 'str'>, 'return': <class 'str'>}
Arguments: spam eggs
spam and eggs
```

## import * 的问题

```
>>> from fibo import *
>>> fib(500)
0 1 1 2 3 5 8 13 21 34 55 89 144 233 377
```

这种方式会导入所有不以下划线（`_`）开头的名称。大多数情况下，不要用这个功能，这种方式向解释器导入了一批未知的名称，可能会覆盖已经定义的名称。

注意，一般情况下，不建议从模块或包内导入 `*`， 因为，这项操作经常让代码变得难以理解。不过，为了在交互式编译器中少打几个字，这么用也没问题。

另外从包导入*，有个索引问题 https://docs.python.org/zh-cn/3/tutorial/modules.html#importing-from-a-package



## with关键字



```
>>> with open('workfile') as f:
...     read_data = f.read()

>>> # We can check that the file has been automatically closed.
>>> f.closed
True
```

如果没有使用 [`with`]关键字，则应调用 `f.close()` 关闭文件，即可释放文件占用的系统资源。

调用 `f.write()` 时，未使用 `with` 关键字，或未调用 `f.close()`，即使程序正常退出，也**可能** 导致 `f.write()` 的参数没有完全写入磁盘。

通过 [`with`] 语句，或调用 `f.close()` 关闭文件对象后，再次使用该文件对象将会失败。

\>>>

```
>>> f.close()
>>> f.read()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: I/O operation on closed file.
```

## 文件读取多行

从文件中读取多行时，可以用循环遍历整个文件对象。这种操作能高效利用内存，快速，且代码简单：

\>>>

```
>>> for line in f:
...     print(line, end='')
...
This is the first line of the file.
Second line of the file
```

如需以列表形式读取文件中的所有行，可以用 `list(f)` 或 `f.readlines()`。



## 操作文本seek

`f.seek(offset, whence)` 可以改变文件对象的位置。通过向参考点添加 *offset* 计算位置；参考点由 *whence* 参数指定。 *whence* 值为 0 时，表示从文件开头计算，1 表示使用当前文件位置，2 表示使用文件末尾作为参考点。省略 *whence* 时，其默认值为 0，即使用文件开头作为参考点。

\>>>

```
>>> f = open('workfile', 'rb+')
>>> f.write(b'0123456789abcdef')
16
>>> f.seek(5)      # Go to the 6th byte in the file
5
>>> f.read(1)
b'5'
>>> f.seek(-3, 2)  # Go to the 3rd byte before the end
13
>>> f.read(1)
b'd'
```

在文本文件（模式字符串未使用 `b` 时打开的文件）中，只允许相对于文件开头搜索（使用 `seek(0, 2)` 搜索到文件末尾是个例外），唯一有效的 *offset* 值是能从 `f.tell()` 中返回的，或 0。其他 *offset* 值都会产生未定义的行为。

文件对象还支持 `isatty()` 和 `truncate()` 等方法，但不常用；文件对象的完整指南详见库参考。



## 操作json

Python 支持 [JSON (JavaScript Object Notation)](http://json.org/) 这种流行数据交换格式，用户无需没完没了地编写、调试代码，才能把复杂的数据类型保存到文件。[`json`] 标准模块采用 Python 数据层次结构，并将之转换为字符串表示形式；这个过程称为 *serializing* （序列化）。从字符串表示中重建数据称为 *deserializing* （解序化）。在序列化和解序化之间，表示对象的字符串可能已经存储在文件或数据中，或通过网络连接发送到远方 的机器。

注解

 

JSON 格式通常用于现代应用程序的数据交换。程序员早已对它耳熟能详，可谓是交互操作的不二之选。

只需一行简单的代码即可查看某个对象的 JSON 字符串表现形式：

\>>>

```
>>> import json
>>> x = [1, 'simple', 'list']
>>> json.dumps(x)
'[1, "simple", "list"]'
```

[`dumps()`] 函数还有一个变体， [`dump()`]，它只将对象序列化为 [text file](https://docs.python.org/zh-cn/3/glossary.html#term-text-file) 。因此，如果 `f` 是 [text file](https://docs.python.org/zh-cn/3/glossary.html#term-text-file) 对象，可以这样做：

```
json.dump(x, f)
```

要再次解码对象，如果 `f` 是已打开、供读取的 [text file](https://docs.python.org/zh-cn/3/glossary.html#term-text-file) 对象：

```
x = json.load(f)
```

这种简单的序列化技术可以处理列表和字典，但在 JSON 中序列化任意类的实例，则需要付出额外努力。[`json`] 模块的参考包含对此的解释。

## 句法错误

句法错误又称解析错误，是学习 Python 时最常见的错误：

\>>>

```
>>> while True print('Hello world')
  File "<stdin>", line 1
    while True print('Hello world')
                   ^
SyntaxError: invalid syntax
```

解析器会复现出现句法错误的代码行，并用小“箭头”指向行里检测到的第一个错误。错误是由箭头 *上方* 的 token 触发的（至少是在这里检测出的）：本例中，在 [`print()`]函数中检测到错误，因为，在它前面缺少冒号（`':'`） 。错误信息还输出文件名与行号，在使用脚本文件时，就可以知道去哪里查错。



## 触发异常

[`raise`] 语句支持强制触发指定的异常。例如：

\>>>

```
>>> raise NameError('HiThere')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: HiThere
```

[`raise`] 唯一的参数就是要触发的异常。这个参数必须是异常实例或异常类（派生自 [`Exception`] 类）。如果传递的是异常类，将通过调用没有参数的构造函数来隐式实例化：

```
raise ValueError  # shorthand for 'raise ValueError()'
```

如果只想判断是否触发了异常，但并不打算处理该异常，则可以使用更简单的 [`raise`]语句重新触发异常：

\>>>

```
>>> try:
...     raise NameError('HiThere')
... except NameError:
...     print('An exception flew by!')
...     raise
...
An exception flew by!
Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
NameError: HiThere
```



## 异常链

[`raise`] 语句支持可选的 [`from`]子句，该子句用于启用链式异常。 例如：

```
# exc must be exception instance or None.
raise RuntimeError from exc
```

转换异常时，这种方式很有用。例如：

\>>>

```
>>> def func():
...     raise ConnectionError
...
>>> try:
...     func()
... except ConnectionError as exc:
...     raise RuntimeError('Failed to open database') from exc
...
Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
  File "<stdin>", line 2, in func
ConnectionError

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "<stdin>", line 4, in <module>
RuntimeError: Failed to open database
```

异常链会在 [`except`]或 [`finally`] 子句内部引发异常时自动生成。 这可以通过使用 `from None` 这样的写法来禁用:

\>>>

```
>>> try:
...     open('database.sqlite')
... except OSError:
...     raise RuntimeError from None
...
Traceback (most recent call last):
  File "<stdin>", line 4, in <module>
RuntimeError
```

异常链机制详见 [内置异常](https://docs.python.org/zh-cn/3/library/exceptions.html#bltin-exceptions)。

## 类的构造函数

当然，`__init__()` 方法还可以有额外参数以实现更高灵活性。 在这种情况下，提供给类实例化运算符的参数将被传递给 `__init__()`。 例如，:

\>>>

```python
>>> class Complex:
...     def __init__(self, realpart, imagpart):
...         self.r = realpart
...         self.i = imagpart
...
>>> x = Complex(3.0, -4.5)
>>> x.r, x.i
(3.0, -4.5)
```

## 类中私有变量

```python
class A(object):
    def __init__(self):
        self.__data = []  # 翻译成 self._A__data=[]

    def add(self, item):
        self.__data.append(item)  # 翻译成 self._A__data.append(item)

    def printData(self):
        print(self.__data)  # 翻译成 self._A__data


a = A()
a.add('hello')
a.add('python')
a.printData()
# print a.__data  #外界不能访问私有变量 AttributeError: 'A' object has no attribute '__data'
print(a._A__data)  # 通过这种方式，在外面也能够访问“私有”变量；这一点在调试中是比较有用的！
```

结果：

```bash
['hello', 'python']
['hello', 'python']
```

## 迭代器

到目前为止，您可能已经注意到大多数容器对象都可以使用 [`for`] 语句:

```
for element in [1, 2, 3]:
    print(element)
for element in (1, 2, 3):
    print(element)
for key in {'one':1, 'two':2}:
    print(key)
for char in "123":
    print(char)
for line in open("myfile.txt"):
    print(line, end='')
```

这种访问风格清晰、简洁又方便。 迭代器的使用非常普遍并使得 Python 成为一个统一的整体。 在幕后，[`for`]语句会在容器对象上调用 [`iter()`]。 该函数返回一个定义了 [`__next__()`] 方法的迭代器对象，此方法将逐一访问容器中的元素。 当元素用尽时，[`__next__()`] 将引发 [`StopIteration`] 异常来通知终止 `for` 循环。 你可以使用 [`next()`] 内置函数来调用 [`__next__()`]方法；这个例子显示了它的运作方式:

\>>>

```
>>> s = 'abc'
>>> it = iter(s)
>>> it
<iterator object at 0x00A1DB50>
>>> next(it)
'a'
>>> next(it)
'b'
>>> next(it)
'c'
>>> next(it)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
    next(it)
StopIteration
```

看过迭代器协议的幕后机制，给你的类添加迭代器行为就很容易了。 定义一个 `__iter__()` 方法来返回一个带有 [`__next__()`] 方法的对象。 如果类已定义了 `__next__()`，则 `__iter__()` 可以简单地返回 `self`:

```
class Reverse:
    """Iterator for looping over a sequence backwards."""
    def __init__(self, data):
        self.data = data
        self.index = len(data)

    def __iter__(self):
        return self

    def __next__(self):
        if self.index == 0:
            raise StopIteration
        self.index = self.index - 1
        return self.data[self.index]
```

\>>>

```
>>> rev = Reverse('spam')
>>> iter(rev)
<__main__.Reverse object at 0x00A1DB50>
>>> for char in rev:
...     print(char)
...
m
a
p
s
```

## 生成器

[生成器](https://docs.python.org/zh-cn/3/glossary.html#term-generator) 是一个用于创建迭代器的简单而强大的工具。 它们的写法类似于标准的函数，但当它们要返回数据时会使用 [`yield`]语句。 每次在生成器上调用 [`next()`] 时，它会从上次离开的位置恢复执行（它会记住上次执行语句时的所有数据值）。 一个显示如何非常容易地创建生成器的示例如下:

```
def reverse(data):
    for index in range(len(data)-1, -1, -1):
        yield data[index]
```

\>>>

```
>>> for char in reverse('golf'):
...     print(char)
...
f
l
o
g
```

可以用生成器来完成的操作同样可以用前一节所描述的基于类的迭代器来完成。 但生成器的写法更为紧凑，因为它会自动创建 `__iter__()` 和 [`__next__()`] 方法。

另一个关键特性在于局部变量和执行状态会在每次调用之间自动保存。 这使得该函数相比使用 `self.index` 和 `self.data` 这种实例变量的方式更易编写且更为清晰。

除了会自动创建方法和保存程序状态，当生成器终结时，它们还会自动引发 [`StopIteration`]。 这些特性结合在一起，使得创建迭代器能与编写常规函数一样容易。

## 性能测量

一些Python用户对了解同一问题的不同方法的相对性能产生了浓厚的兴趣。 Python提供了一种可以立即回答这些问题的测量工具。

例如，元组封包和拆包功能相比传统的交换参数可能更具吸引力。[`timeit`]模块可以快速演示在运行效率方面一定的优势:

\>>>

```
>>> from timeit import Timer
>>> Timer('t=a; a=b; b=t', 'a=1; b=2').timeit()
0.57535828626024577
>>> Timer('a,b = b,a', 'a=1; b=2').timeit()
0.54962537085770791
```

与 [`timeit`]的精细粒度级别相反， [`profile`] 模块提供了用于在较大的代码块中识别时间关键部分的工具。

## 查看包内对象

```python
import flask
print(dir(flask))
```

## 单元测试



```python
def average(values):
    """Computes the arithmetic mean of a list of numbers.

    >>> print(average([20, 30, 70]))
    45.0
    """
    return sum(values) / len(values)


result = average([20, 30, 70])
print(result)

import doctest
doctest.testmod()
```



在引号中，单元测试想让这个方法结果等于45

运行结果：

```bash
40.0
**********************************************************************
File "D:\idea\infra-web\tar\test\flask_learn\unit_test.py", line 4, in __main__.average
Failed example:
    print(average([20, 30, 70]))
Expected:
    45.0
Got:
    40.0
**********************************************************************
1 items had failures:
   1 of   1 in __main__.average
***Test Failed*** 1 failures.
```

由于运行结果为40，不符合预期，所以报错





## 方法设置默认参数

```python
>>> x = 42
>>> def spam(a, b=x):
...     print(a, b)
...
>>> spam(1)
1 42
>>> x = 23 # Has no effect
>>> spam(1)
1 42
>>>
```



## classmethod 的使用方法



```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
class A(object):
    bar = 1
    def func1(self):  
        print ('foo') 
    @classmethod
    def func2(cls):
        print ('func2')
        print (cls.bar)
        cls().func1()   # 调用 foo 方法
 
A.func2()               # 不需要实例化
```

结果：

```
func2
1
foo
```



Python有3种方法，静态方法（staticmethod），类方法（classmethod）和实例方法。下面用代码举例。

对于一般的函数foo(x)，它跟类和类的实例没有任何关系，直接调用foo(x)即可。

```
# -*- coding:utf-8 -*-
def foo(x):
    print("running foo(%s)" % x)

foo("test")
```

在类A里面的实例方法foo(self, x)，**第一个参数是self**，我们需要有一个A的实例，才可以调用这个函数。



```
# -*- coding:utf-8 -*-
class A:
    def foo(self, x):
        print("running foo(%s, %s)" % (self, x))

# A.foo(x) 这样会报错
a = A()
a.foo("test")
```



当我们需要和类直接进行交互，而不需要和实例进行交互时，类方法是最好的选择。类方法与实例方法类似，但是传递的不是类的实例，而是类本身，**第一个参数是cls**。**我们可以用类的实例调用类方法，也可以直接用类名来调用。**



```
# -*- coding:utf-8 -*-
class A:
    class_attr = "attr"
    
    def __init__(self):
        pass
        
    @classmethod
    def class_foo(cls):
        print("running class_foo(%s)" % (cls.class_attr))

a = A()
a.class_foo()
A.class_foo()
```



静态方法类似普通方法，参数里面不用self。这些方法和类相关，但是又不需要类和实例中的任何信息、属性等等。如果把这些方法写到类外面，这样就把和类相关的代码分散到类外，使得之后对于代码的理解和维护都是巨大的障碍。而静态方法就是用来解决这一类问题的。

比如我们检查是否开启了日志功能，这个和类相关，但是跟类的属性和实例都没有关系。



```
# -*- coding:utf-8 -*-
log_enabled = True

class A:
    class_attr = "attr"
    
    def __init__(self):
        pass
        
    @staticmethod
    def static_foo():
        if log_enabled:
            print("log is enabled")
        else:
            print("log is disabled")
        

A.static_foo()
```

- @staticmethod不需要表示自身对象的self和自身类的cls参数，就跟使用函数一样。

- @classmethod也不需要self参数，但第一个参数需要是表示自身类的cls参数。

  如果在@staticmethod中要调用到这个类的一些属性方法，只能直接类名.属性名或类名.方法名。
  而@classmethod因为持有cls参数，可以来调用类的属性，类的方法，实例化对象等，避免硬编码。








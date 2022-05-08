# 通过继承实现多线程



## 一，实现run方法

先看不带init方法的

```python
import time
import threading

class MyThread(threading.Thread):

    def run(self):
        time.sleep(1)
        a = 1 + 1
        print(a)

for _ in range(5):
    th = MyThread()
    th.start()
```

结果：

```
2
2
2
2
2
```



- 定义一个类，继承`threading.Thread`类，里面只需要定义`run`方法
- `run`方法相当于之前传入`Thread`的那个函数，注意只能用`run`这个名字，不用显式调用，线程`start()`时会自动调用`run`
- 创建类的实例时不需要传入参数，得到的结果就可以调用`start join`等方法
- `Thread`对象可以调用`start join run`等方法，其实当时调用`start`就是自动调用了`run`。这里只不过是在新类中重写了`run`方法，线程调用`start`时就会自动执行这个`run`





## 二，用初始化方法实现传参

带初始化方法的，上面每次运行的`run`都是一样的，真正使用时很少会这样用，有时会需要传入一些区别性的参数，这就需要定义类的`__init__`了

```python
import threading
import requests
from bs4 import BeautifulSoup

class MyThread(threading.Thread):

  def __init__(self, i):
    threading.Thread.__init__(self)
    self.i = i

  def run(self):
    print(self.i)

for i in range(10):
  th = MyThread(i)
  th.start()
```

结果：

```sh
0
1
2
3
4
5
6
7
8
9
```



## 三，调用Thrad对象的方法

- `Thread`函数的参数。初始化线程时传入一些参数，这里也可以在`__init__`中定义
- `Thread`对象的方法。这里可以用`self`直接调用这些方法
- `threading.activeCount()`等直接调用的变量。在这里依然可以调用

所以用类的方法不会有任何限制，下面来看一个例子

```
import time
import threading


class MyThread(threading.Thread):
    def __init__(self, name):
        threading.Thread.__init__(self)
        self.name = name  # 这样就相当于Thread中的name参数了

    def run(self):
        a = 1 + 1
        print(threading.currentThread().name)
        time.sleep(1)
        print(self.name)
        time.sleep(1)
        print(self.is_alive())  # 未显式定义过就可以直接用


t = time.time()

ths = [MyThread('thread {}'.format(i)) for i in range(3)]

print("len(ths):"+str(len(ths)))

for th in ths:
    th.start()

print("threading.activeCount:"+str(threading.activeCount()))

for th in ths:
    th.join()

print(time.time() - t)
```



## 四，给run方法传入写好的方法

之前是直接用`run`定义计算函数，如果已经有一个计算函数，也可以用传入的方式而不是改写成`run`

```python
import threading
def gettitle(page):
  print("page:"+str(page))

class MyThread(threading.Thread):

  def __init__(self, target, **args):
    threading.Thread.__init__(self)
    self.target = target
    self.args = args

  def run(self):
    self.target(**self.args)

for i in range(10):
  th = MyThread(gettitle, page = i)
  th.start()
```

结果：

```
page:0
page:1
page:2
page:3
page:4
page:5
page:6
page:7
page:8
page:9
```










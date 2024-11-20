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

```python
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







## 继承 `threading.Thread` 类来实现多线程

在 Python 中，可以通过继承 `threading.Thread` 类来实现多线程。这种方法通过定义一个子类并重写其 `run()` 方法，将线程执行的逻辑放入 `run()` 方法中。

---

### **1. 基本实现步骤**

1. 创建一个子类继承自 `threading.Thread`。
2. 在子类中重写 `run()` 方法。
3. 创建子类实例，调用 `start()` 方法启动线程。
   - `start()` 会自动调用 `run()` 方法，执行线程逻辑。

---

### **2. 示例代码**

以下是一个简单的示例，展示如何通过继承实现多线程：

```python
import threading
import time

# 定义一个继承自 threading.Thread 的子类
class MyThread(threading.Thread):
    def __init__(self, name, sleep_time):
        super().__init__()  # 调用父类的构造方法
        self.name = name
        self.sleep_time = sleep_time

    def run(self):
        print(f"Thread {self.name} is starting...")
        for i in range(5):
            print(f"Thread {self.name} is running, iteration {i}")
            time.sleep(self.sleep_time)
        print(f"Thread {self.name} is finished.")

# 创建线程实例
thread1 = MyThread(name="A", sleep_time=1)
thread2 = MyThread(name="B", sleep_time=2)

# 启动线程
thread1.start()
thread2.start()

# 等待线程结束
thread1.join()
thread2.join()

print("All threads are completed.")
```

#### **运行结果示例：**
```plaintext
Thread A is starting...
Thread B is starting...
Thread A is running, iteration 0
Thread B is running, iteration 0
Thread A is running, iteration 1
Thread B is running, iteration 1
...
Thread A is finished.
Thread B is finished.
All threads are completed.
```

---

### **3. 代码解读**

1. **`__init__()` 方法：**
   - 用于初始化线程对象，并传递线程所需参数。
   - 调用 `super().__init__()` 初始化父类。

2. **`run()` 方法：**
   - 包含线程逻辑的核心代码。
   - `start()` 方法会自动调用 `run()`，无需手动调用。

3. **线程启动与结束：**
   - 使用 `start()` 启动线程。
   - 使用 `join()` 主线程等待子线程完成。

---

### **4. 优点与注意事项**

#### **优点：**
- 继承方式使得线程逻辑可以通过类封装，便于复用和扩展。
- 能与类的其他方法和属性无缝结合，适合复杂的线程逻辑。

#### **注意事项：**
1. **不要直接调用 `run()` 方法：**
   调用 `run()` 不会启动新线程，而是同步执行其逻辑。正确方法是调用 `start()` 方法。
   ```python
   thread.run()  # 错误，run() 会直接在主线程中运行
   thread.start()  # 正确，start() 会启动新线程
   ```

2. **线程安全问题：**
   多线程访问共享资源时，需要使用线程锁（`threading.Lock`）或其他同步机制避免竞争。

3. **资源开销：**
   Python 的线程基于全局解释器锁（GIL），在 I/O 密集型任务中表现优异，但在 CPU 密集型任务中可能效率受限。

---

### **5. 示例：多线程处理共享资源**

通过继承实现线程，同时使用锁保护共享资源。

```python
import threading

class CounterThread(threading.Thread):
    def __init__(self, name, lock, counter):
        super().__init__()
        self.name = name
        self.lock = lock
        self.counter = counter

    def run(self):
        for _ in range(1000):
            # 加锁保护共享资源
            self.lock.acquire()
            try:
                self.counter[0] += 1
            finally:
                self.lock.release()

# 初始化共享资源
counter = [0]
lock = threading.Lock()

# 创建线程
thread1 = CounterThread(name="Thread-1", lock=lock, counter=counter)
thread2 = CounterThread(name="Thread-2", lock=lock, counter=counter)

# 启动线程
thread1.start()
thread2.start()

# 等待线程结束
thread1.join()
thread2.join()

print(f"Final counter value: {counter[0]}")
```

---

### **6. 小结**

- **实现多线程：** 继承 `threading.Thread` 并重写 `run()` 方法。
- **启动线程：** 使用 `start()` 方法。
- **线程同步：** 使用锁等机制保护共享资源，避免数据竞争。
- **适用场景：** 继承方式适合需要复杂逻辑和类封装的场景，是实现多线程的经典方式之一。





---

### **具体解读**
```python
self.name = name
self.lock = lock
self.counter = counter
```

#### **1. `self` 的作用**
- **`self`** 是类的方法中用来引用当前实例的变量。
- 通过 `self` 可以访问当前实例的属性和方法。
- 在类的构造方法（`__init__`）中，`self` 用来定义实例属性。

#### **2. 定义实例属性**
- `self.name` 是类实例的属性，`name` 是传入的参数。
- `self.lock` 和 `self.counter` 同理。
- 通过赋值语句，实例属性与传入参数建立了联系。

#### **3. 保存为实例属性的目的**
- 一旦赋值给 `self` 的属性，它将可以在类的其他方法中通过 `self` 使用，方便代码结构化。

---

### **参数解释**

```python
def __init__(self, name, lock, counter):
    super().__init__()
    self.name = name        # 把 name 参数保存为实例属性 self.name
    self.lock = lock        # 把 lock 参数保存为实例属性 self.lock
    self.counter = counter  # 把 counter 参数保存为实例属性 self.counter
```

1. **`name`:**
   - 是传入的线程名称。
   - 被赋值给 `self.name` 后，可以在 `run()` 方法或其他地方使用 `self.name` 来引用线程名称。

2. **`lock`:**
   - 是线程之间共享的锁对象，用于同步。
   - 被赋值给 `self.lock` 后，可以在 `run()` 方法中通过 `self.lock` 使用这个锁，避免局部变量的限制。

3. **`counter`:**
   - 是共享的计数器（例如 `counter=[0]`）。
   - 赋值后，通过 `self.counter` 引用它，供 `run()` 方法进行更新操作。

---

### **类的完整运行过程**

1. **初始化实例：**
   ```python
   thread1 = CounterThread(name="Thread-1", lock=lock, counter=counter)
   ```
   - `name="Thread-1"` 会被赋值给 `self.name`。
   - `lock` 是一个锁对象，被赋值给 `self.lock`。
   - `counter` 是一个可变对象（例如列表），被赋值给 `self.counter`。

2. **使用实例属性：**
   - 在 `run()` 方法中可以直接用 `self.lock`、`self.counter` 和 `self.name`，不需要额外传参。
   ```python
   def run(self):
       for _ in range(1000):
           self.lock.acquire()      # 使用 self.lock 进行加锁
           try:
               self.counter[0] += 1  # 更新共享计数器 self.counter
           finally:
               self.lock.release()  # 解锁
   ```

---

### **示例**

为了更直观理解，以下是一个完整的类的流程。

#### **示例：定义和使用实例属性**

```python
class Example:
    def __init__(self, name, value):
        # 把参数保存为实例属性
        self.name = name
        self.value = value
    
    def display(self):
        # 使用实例属性
        print(f"Name: {self.name}, Value: {self.value}")

# 创建类的实例，并传入参数
obj = Example(name="Alice", value=42)

# 调用实例方法
obj.display()  # 输出：Name: Alice, Value: 42
```

1. `__init__` 中的 `self.name = name` 将 `name` 参数赋值给实例属性 `self.name`。
2. `display()` 方法通过 `self.name` 和 `self.value` 访问实例属性。
3. 传递参数时，用户传入的值会保存在实例属性中，供类的其他方法使用。

---

### **总结**
`self.name = name` 这类赋值操作的目的在于：
1. 将传入参数保存为实例属性，以供类中的其他方法调用。
2. 这种设计让数据与行为封装在同一个对象中，符合面向对象编程的原则。
3. 是类实例化和方法间共享数据的基础写法。

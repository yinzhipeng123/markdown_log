

# **threading.Event()**

通过threading.Event()可以创建一个事件管理标志，该标志（event）默认为False，event对象主要有四种方法可以调用：

- event.wait(timeout=None)：调用该方法的线程会被阻塞，如果设置了timeout参数，超时后，线程会停止阻塞继续执行；

- event.set()：将event的标志设置为True，调用wait方法的所有线程将被唤醒；
- event.clear()：将event的标志设置为False，调用wait方法的所有线程将被阻塞；
- event.isSet()：判断event的标志是否为True。

```python
import threading
import time
event = threading.Event()
def func():
    # 等待事件，进入等待阻塞状态
    print('%s wait for event...' % threading.currentThread().getName())
    print("event.is_set():"+str(event.is_set()))
    event.wait()
    # 收到事件后进入运行状态
    print('%s recv event.' % threading.currentThread().getName())
    print("event.is_set():"+str(event.is_set()))
t1 = threading.Thread(target=func)
t2 = threading.Thread(target=func)
t1.start()
t2.start()

time.sleep(2)

# 发送事件通知
print('MainThread set event..............')
event.set()
```

结果：

```
Thread-1 wait for event...
event.is_set():False
Thread-2 wait for event...
event.is_set():False
MainThread set event..............
Thread-2 recv event.
event.is_set():True
Thread-1 recv event.
event.is_set():True

进程已结束，退出代码为 0
```

### 用继承方式实现

```python
import threading
import time

class MyThread(threading.Thread):
    event = threading.Event()

    def run(self):
        # 等待事件，进入等待阻塞状态
        print('%s wait for event...' % threading.currentThread().getName())
        print("event.is_set():" + str(MyThread.event.is_set()))
        MyThread.event.wait()

        # 收到事件后进入运行状态
        print('%s recv event.' % threading.currentThread().getName())
        print("event.is_set():" + str(MyThread.event.is_set()))


t1 = MyThread()
t2 = MyThread()
t1.start()
t2.start()

time.sleep(2)

# 发送事件通知
print('MainThread set event..............')
MyThread.event.set()
```

结果：

```python
Thread-1 wait for event...
event.is_set():False
Thread-2 wait for event...
event.is_set():False
MainThread set event..............
Thread-2 recv event.
event.is_set():True
Thread-1 recv event.
event.is_set():True

进程已结束，退出代码为 0
```


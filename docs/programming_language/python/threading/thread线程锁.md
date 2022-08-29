# Python线程锁

### 正常上锁的情况

三个线程对num进行增减，对num操作部分进行上锁，进入锁之后，线程串行运行

```python
# -*- coding: utf-8 -*-
import time, threading, ctypes

num = 0
lock = threading.Lock()


def task_thread(n):
    global num
    print("-----开始线程时间" + time.asctime(time.localtime(time.time())))
    lock.acquire()
    print("进入线程锁时间" + time.asctime(time.localtime(time.time())))
    for i in range(10000000):
        num = num + n
        num = num - n
    lock.release()


t1 = threading.Thread(target=task_thread, args=(6,))
t2 = threading.Thread(target=task_thread, args=(17,))
t3 = threading.Thread(target=task_thread, args=(11,))

t1.start()
t2.start()
t3.start()
t1.join()
t2.join()
t3.join()
print(num)
```

运行结果：

```bash
-----开始线程时间Tue Aug 23 19:29:29 2022
进入线程锁时间Tue Aug 23 19:29:29 2022
-----开始线程时间Tue Aug 23 19:29:29 2022
-----开始线程时间Tue Aug 23 19:29:29 2022
进入线程锁时间Tue Aug 23 19:29:31 2022
进入线程锁时间Tue Aug 23 19:29:32 2022
0
```

### 不上锁的情况

去掉线程锁后，线程都开始同时进行操作，算出来的数字也是错误的

```python
# -*- coding: utf-8 -*-
import time, threading, ctypes

num = 0


def task_thread(n):
    global num
    print("-----开始线程时间" + time.asctime(time.localtime(time.time())))
    print("进入线程时间" + time.asctime(time.localtime(time.time())))
    for i in range(10000000):
        num = num + n
        num = num - n


t1 = threading.Thread(target=task_thread, args=(6,))
t2 = threading.Thread(target=task_thread, args=(17,))
t3 = threading.Thread(target=task_thread, args=(11,))

t1.start()
t2.start()
t3.start()
t1.join()
t2.join()
t3.join()
print(num)
```

运行结果：

```python
-----开始线程时间Tue Aug 23 19:37:09 2022
进入线程时间Tue Aug 23 19:37:09 2022
-----开始线程时间Tue Aug 23 19:37:09 2022
进入线程时间Tue Aug 23 19:37:09 2022
-----开始线程时间Tue Aug 23 19:37:09 2022
进入线程时间Tue Aug 23 19:37:09 2022
10
```


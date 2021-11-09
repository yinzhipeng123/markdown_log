# join的作用



## **总结**

1. join方法的作用是阻塞主进程（挡住，无法执行join以后的语句），专注执行多线程。  
2. 多线程多join的情况下，依次执行各线程的join方法，前头一个结束了才能执行后面一个。
3. 无参数，则等待到该线程结束，才开始执行下一个线程的join。
4. 设置参数后，则等待该线程这么长时间就不管它了（而该线程并没有结束）。不管的意思就是可以执行后面的主进程了。



**Join & Daemon**
 主线程A中，创建了子线程B，并且在主线程A中调用了B.setDaemon(),这个的意思是，把主线程A设置为守护线程，这时候，要是主线程A执行结束了，就不管子线程B是否完成,一并和主线程A退出.这就是setDaemon方法的含义，这基本和join是相反的。此外，还有个要特别注意的：必须在start() 方法调用之前设置，如果不设置为守护线程，程序会被无限挂起。





Python多线程与多进程中join()方法的效果是相同的。

下面仅以多线程为例：

首先需要明确几个概念：

知识点一：
当一个进程启动之后，会默认产生一个主线程，因为线程是程序执行流的最小单元，当设置多线程时，主线程会创建多个子线程，在python中，默认情况下（其实就是setDaemon(False)），主线程执行完自己的任务以后，就退出了，此时子线程会继续执行自己的任务，直到自己的任务结束，例子见下面一。

知识点二：
当我们使用setDaemon(True)方法，设置子线程为守护线程时，主线程一旦执行结束，则全部线程全部被终止执行，可能出现的情况就是，子线程的任务还没有完全执行结束，就被迫停止，例子见下面二。

知识点三：
此时join的作用就凸显出来了，join所完成的工作就是线程同步，即主线程任务结束之后，进入阻塞状态，一直等待其他的子线程执行结束之后，主线程在终止，例子见下面三。

#### 一：Python多线程的默认情况

```python
import threading
import time

def run():
    time.sleep(2)
    print('当前线程的名字是： ', threading.current_thread().name)
    time.sleep(2)


if __name__ == '__main__':

    start_time = time.time()

    print('这是主线程：', threading.current_thread().name)
    thread_list = []
    for i in range(5):
        t = threading.Thread(target=run)
        thread_list.append(t)

    for t in thread_list:
        t.start()

    print('主线程结束！' , threading.current_thread().name)
    print('一共用时：', time.time()-start_time)
```

其执行结果如下
![img](https://images2017.cnblogs.com/blog/1203446/201709/1203446-20170911141534407-1287489554.png)

关键点：

1. 我们的计时是对主线程计时，主线程结束，计时随之结束，打印出主线程的用时。
2. 主线程的任务完成之后，主线程随之结束，子线程继续执行自己的任务，直到全部的子线程的任务全部结束，程序结束。

#### 二：设置守护线程

```
import threading
import time

def run():

    time.sleep(2)
    print('当前线程的名字是： ', threading.current_thread().name)
    time.sleep(2)


if __name__ == '__main__':

    start_time = time.time()

    print('这是主线程：', threading.current_thread().name)
    thread_list = []
    for i in range(5):
        t = threading.Thread(target=run)
        thread_list.append(t)

    for t in thread_list:
        t.setDaemon(True)
        t.start()

    print('主线程结束了！' , threading.current_thread().name)
    print('一共用时：', time.time()-start_time)
```

其执行结果如下，注意请确保setDaemon()在start()之前。
![img](https://images2017.cnblogs.com/blog/1203446/201709/1203446-20170911143032641-1967021221.png)

关键点：

1. 非常明显的看到，主线程结束以后，子线程还没有来得及执行，整个程序就退出了。

#### 三：join的作用

```
import threading
import time

def run():

    time.sleep(2)
    print('当前线程的名字是： ', threading.current_thread().name)
    time.sleep(2)


if __name__ == '__main__':

    start_time = time.time()

    print('这是主线程：', threading.current_thread().name)
    thread_list = []
    for i in range(5):
        t = threading.Thread(target=run)
        thread_list.append(t)

    for t in thread_list:
        t.setDaemon(True)
        t.start()

    for t in thread_list:
        t.join()

    print('主线程结束了！' , threading.current_thread().name)
    print('一共用时：', time.time()-start_time)
```

其执行结果如下：
![img](https://images2017.cnblogs.com/blog/1203446/201709/1203446-20170911144052203-746545220.png)

关键点：

1. 可以看到，主线程一直等待全部的子线程结束之后，主线程自身才结束，程序退出。
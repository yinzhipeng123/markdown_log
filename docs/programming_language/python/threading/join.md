# join的作用

&nbsp;

## **总结**

&nbsp;

1. join方法的作用是阻塞主进程（挡住，无法执行join以后的语句），专注执行多线程。  
2. 多线程多join的情况下，依次执行各线程的join方法，前头一个结束了才能执行后面一个。
3. 无参数，则等待到该线程结束，才开始执行下一个线程的join。
4. 设置参数后，则等待该线程这么长时间就不管它了（而该线程并没有结束）。不管的意思就是可以执行后面的主进程了。

&nbsp;

<center><font face="黑体" color=red size=10>Join & Daemon</font></center>

`join`字面意思：**联合**

`daemon`字面意思：**守护**

正常的多线程，A开启了B，A和B是两个独立的线程，互不干扰

主线程A中，创建了子线程B，并且在主线程A中调用了`B.setDaemon()`，我的理解就是让B守护A，A进程结束了，就不管子线程B是否完成，一并和主线程A退出。这就是`setDaemon`方法的含义

主线程A中，创建了子线程B，并且在主线程A中调用了`B.join()`，我的理解就是让B联合A，A进程结束了，就会进入阻塞状态等待B，等待B结束，A才退出

&nbsp;

下面仅以多线程为例：

首先需要明确几个概念：

&nbsp;

1. 当一个进程启动之后，会默认产生一个主线程，因为线程是程序执行流的最小单元，当设置多线程时，主线程会创建多个子线程，在python中，默认情况下（其实就是`setDaemon(False)`，主线程执行完自己的任务以后，就退出了，此时子线程会继续执行自己的任务，直到自己的任务结束，例子见下面一。
2. 
   当我们使用`setDaemon(True)`方法，设置子线程为守护线程时，主线程一旦执行结束，则全部线程全部被终止执行，可能出现的情况就是，子线程的任务还没有完全执行结束，就被迫停止，例子见下面二。
3. 
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

其执行结果如下：

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/join1.png?raw=true)

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
![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/join2.png?raw=true)

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
![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/join.png?raw=true)

关键点：

1. 可以看到，主线程一直等待全部的子线程结束之后，主线程自身才结束，程序退出。
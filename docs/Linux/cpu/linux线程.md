

## Linux线程



Linux的线程实则为轻量级进程

轻量级进程，可见其本质仍然是进程，与普通进程相比，LWP与其它进程共享所有（或大部分）逻辑地址空间和系统资源，一个进程可以创建多个LWP，这样它们共享大部分资源；LWP有它自己的进程标识符，并和其他进程有着父子关系；这是和类Unix操作系统的系统调用vfork()生成的进程一样的。LWP由内核管理并像普通进程一样被调度。Linux内核是支持LWP的典型例子。Linux内核在 2.0.x版本就已经实现了轻量进程，应用程序可以通过一个统一的clone()系统调用接口，用不同的参数指定创建轻量进程还是普通进程，通过参数决定子进程和父进程共享的资源种类和数量，这样就有了轻重之分。在内核中， clone()调用经过参数传递和解释后会调用do_fork()，这个核内函数同时也是fork()、vfork()系统调用的最终实现。

在大多数系统中，LWP与普通进程的区别也在于它只有一个最小的执行上下文和调度程序所需的统计信息，而这也是它之所以被称为轻量级的原因。
因为LWP之间共享它们的大部分资源，所以它在某些应用程序就不适用了；这个时候就要使用多个普通的进程了。例如，为了避免内存泄漏（a process can be replaced by another one）和实现特权分隔（processes can run under other credentials and have other permissions）。



我们可以把LWP看成是一个线程。就因为这个使得线程和进程的概念混淆了，有人说系统调度单位是进程，又有人说是线程，其实系统调度的单位一直就没有改变，只是后来部分线程和进程的界限模糊了

参考文档：

1. http://www.uml.org.cn/embeded/202011244.asp
2. https://www.daimajiaoliu.com/daima/485a207729003f8
3. https://www.daimajiaoliu.com/daima/4795933fc9003ec
4. https://www.modb.pro/db/15191


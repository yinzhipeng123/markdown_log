# perf命令



**perf**是一个Linux系统中的性能分析工具，它支持硬件性能计数、软件性能计数和动态侦测。

- `perf stat`: 测量运行单个程序或是系统运行一段时间内的性能计数
- `perf top`: 动态查看当前系统的热点函数
- `perf record`: 测量和保存单个程序的采样数据
- `perf report`: 分析由perf record产生的数据文件
- `perf list`: 列举出perf支持的性能计数事件

```bash
$ mkdir test
$ cd test
$ perf record -g -a  # -a 收集所有CPU  -g开启调用关系分析
$ ll
total 5624
-rw------- 1 root root 5755668 Apr 13 16:49 perf.data
$ perf report  #查看报告
```



```bash
# -g开启调用关系分析，-p指定php-fpm的进程号21515
$ perf top -g -p 21515
```

按方向键切换到 php-fpm，再按下回车键展开 php-fpm 的调用关系，你会发现，调用关系最终到了 sqrt 和 add_function。

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202205200032913.png" alt="img" style="zoom:67%;" />





相关链接：

https://www.brendangregg.com/perf.html

https://perf.wiki.kernel.org/index.php/Tutorial

https://zh.wikipedia.org/wiki/Perf

https://man7.org/linux/man-pages/man1/perf.1.html
# Python 内存分析

项目地址：https://github.com/pythonprofilers/memory_profiler

示例代码

```Python
from memory_profiler import profile


@profile
def my_func():
    print("hello")


if __name__ == '__main__':
    my_func()
```

运行结果

```bash
hello
Filename: D:\idea\one\test\mem.py

Line #    Mem usage    Increment  Occurences   Line Contents
============================================================
     4     26.6 MiB     26.6 MiB           1   @profile
     5                                         def my_func():
     6     26.6 MiB      0.0 MiB           1       print("hello")
```



内存占用一目了然

该模块还提供了命令行性能工具 mprof

```
(venv) D:\idea\one\test>mprof run mem.py
mprof: Sampling memory every 0.1s
running new process
running as a Python program...
hello
Filename: mem.py

Line #    Mem usage    Increment  Occurences   Line Contents
============================================================
     4     27.3 MiB     27.3 MiB           1   @profile
     5                                         def my_func():
     6     27.3 MiB      0.0 MiB           1       print("hello")
```


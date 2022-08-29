# iotop命令



iotop监视Linux内核（需要2.6.20或更高版本）输出的I/O使用情况信息，并显示系统上进程或线程的当前I/O使用情况表。

**语法格式**：iotop [参数]

### **常用参数：**﻿

选项

- --version  显示版本号并退出
- -h, --help  显示使用信息并退出
- -o, --only  只显示实际执行I/O的进程或线程，而不显示所有进程或线程。这可以通过按o来动态切换。
- -b, --batch  打开非交互模式。用于记录随时间变化的I/O使用情况。
- -n NUM, --iter=NUM  设置退出前的迭代次数（默认情况下从不退出）。这在非交互模式下最有用。
- -d SEC, --delay=SEC   以秒为单位设置迭代之间的延迟（默认情况下为1秒）。接受非整数值，如1.1秒。
- -p PID, --pid=PID   要监视的进程/线程的列表（默认情况下全部）。
- -u USER，--user=USER  要监视的用户列表（默认为全部）
- -P， --processes   只显示进程。通常iotop显示所有线程。
- -a， --accumulated   显示累计I/O而不是带宽。在此模式下，iotop显示自iotop启动以来已完成的I/O进程数。
- -k， --kilobytes   使用千字节而不是人类友好的单位。在编写iotop的批处理模式脚本时，此模式非常有用。iotop将以千字节为单位显示所有大小，而不是选择最合适的单位。
- -t， --time   在每行上添加一个时间戳（暗示--batch）。每行的前缀都是当前时间。
- -q， --quiet  抑制标题的某些行（暗示--batch）。此选项最多可以指定三次以删除标题行。
- -q  列名只在第一次时打印
- -qq  列名不打印
- -qqq  不打印IO摘要



### 常用使用方法

```
[root@VM-0-16-centos ~]# iotop -otqqq
   TIME   TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO>    COMMAND
16:57:42  6788 be/4 root        0.00 B/s    3.97 K/s  0.00 %  0.00 % barad_agent
16:57:43 12982 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.02 % [kworker/2:0]
16:57:46 12982 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.02 % [kworker/2:0]
16:57:47   291 be/3 root        0.00 B/s   23.80 K/s  0.00 %  0.28 % [jbd2/vda1-8]
```

-o 只显示有IO的进程

-t 显示时间

-qqq 不打印摘要

TID 线程号 -P选项可以以进程显示

DISK READ 和 DISK WRITE 是IO速度

SWAPIN就是   进程或者线程花费在交换内存时间的百分比

IO 进程或者线程花费在IO时间的百分比

PRIO 是I/O优先级 通过ionice -p 也可以查看



#### I/O优先级

Class1(RTreal-time)：实时														

子优级0-7，数字越小0（最高），越大7（最低）

Real time 

这个调度级别的进程产生的IO被优先处理，这个调度类型应小心使用，防止饿死其他进程IO, 它也有8个优先级，数字越大分的的IO时间片越长    	    		    
																					        	
Class2(BE best-effort): 最佳效果，都能访问 默认				    	

子优级0-7，数字越小0（最高），越大7（最低）

Best-effort 

这个类型共有 8 个优先级，分别为 0-7，数字越低，优先级越高，相同级别的优先级使用轮询的方式处理。适用于普通的进程。

在2.6.26之前，没有指定调度类型的进程使用"none" 调度类型，IO调度器将其视作Best-effort进行处理，这个类别中进程优先级由CPU优先级计算得来：io_priority = (cpu_nice + 20) / 5 

2.6.26之后，没有指定调度类型的进程将从CPU调度类型继承而来，这个类别的优先级仍按照CPU优先级计算而来：io_priority = (cpu_nice + 20) / 5			            
																						        
Class3(idle)：空闲

idle 

只有在没有更高优先级的进程产生 IO 时，idle 才可以使用磁盘 IO，适用于哪些不重要的程序（如 updatedb），让它们在磁盘空闲时再产生 IO	
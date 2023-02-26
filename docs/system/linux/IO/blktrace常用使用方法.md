blktrace命令

mount -t debugfs debugfs /sys/kernel/debug 

例如对sda：找个不是sda的目录，新建个目录，进入新目录测试。blktrace -d /dev/sda，执行20秒， 然后crtl+c中断掉，然后会生成一堆文件，然后执行命令blkparse -i sda -d sda.blktrace.bin ，然后执行btt -i sda.blktrace.bin > report.txt  查看报告

D2C高就不行

源代码地址
https://git.kernel.dk/cgit/blktrace/

Q2I：生成IO请求

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207200035475.png)
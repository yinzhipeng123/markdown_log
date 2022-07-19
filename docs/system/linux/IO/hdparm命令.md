# hdparm命令



Linux hdparm命令用于显示与设定硬盘的参数。

hdparm可检测，显示与设定IDE或SCSI硬盘的参数。

### 语法

```bash
hdparm [-CfghiIqtTvyYZ][-a <快取分区>][-A <0或1>][-c <I/O模式>][-d <0或1>][-k <0或1>][-K <0或1>][-m <分区数>][-n <0或1>][-p <PIO模式>][-P <分区数>][-r <0或1>][-S <时间>][-u <0或1>][-W <0或1>][-X <传输模式>][设备]
```

**参数说明**：

- -a<快取分区> 设定读取文件时，预先存入块区的分区数，若不加上<快取分区>选项，则显示目前的设定。
- -A<0或1> 启动或关闭读取文件时的快取功能。
- -c<I/O模式> 设定IDE32位I/O模式。
- -C 检测IDE硬盘的电源管理模式。
- -d<0或1> 设定磁盘的DMA模式。
- -f 将内存缓冲区的数据写入硬盘，并清楚缓冲区。
- -g 显示硬盘的磁轨，磁头，磁区等参数。
- -h 显示帮助。
- -i 显示硬盘的硬件规格信息，这些信息是在开机时由硬盘本身所提供。
- -I 直接读取硬盘所提供的硬件规格信息。
- -k<0或1> 重设硬盘时，保留-dmu参数的设定。
- -K<0或1> 重设硬盘时，保留-APSWXZ参数的设定。
- -m<磁区数> 设定硬盘多重分区存取的分区数。
- -n<0或1> 忽略硬盘写入时所发生的错误。
- -p<PIO模式> 设定硬盘的PIO模式。
- -P<磁区数> 设定硬盘内部快取的分区数。
- -q 在执行后续的参数时，不在屏幕上显示任何信息。
- -r<0或1> 设定硬盘的读写模式。
- -S<时间> 设定硬盘进入省电模式前的等待时间。
- -t 评估硬盘的读取效率。
- -T 评估硬盘快取的读取效率。
- -u<0或1> 在硬盘存取时，允许其他中断要求同时执行。
- -v 显示硬盘的相关设定。
- -W<0或1> 关闭/开启磁盘的写入缓存，每个盘都有读取缓存和写入缓存，有时我们关闭磁盘写入缓存的效率高于开启磁盘写入缓存的效率，那当然选择前者了。
- -X<传输模式> 设定硬盘的传输模式。
- -y 使IDE硬盘进入省电模式。
- -Y 使IDE硬盘进入睡眠模式。
- -Z 关闭某些Seagate硬盘的自动省电功能。



### 实例

显示硬盘的相关设置：

```bash
# hdparm /dev/sda
 /dev/sda:
 IO_support = 0 (default 16-bit)
 readonly = 0 (off)
 readahead = 256 (on)
 geometry = 19929［柱面数］/255［磁头数］/63［扇区数］, sectors = 320173056［总扇区数］, start = 0［起始扇区数］
```

显示硬盘的柱面、磁头、扇区数

```bash
# hdparm -g /dev/sda
 /dev/sda:
 geometry = 19929［柱面数］/255［磁头数］/63［扇区数］, sectors = 320173056［总扇区数］, start = 0［起始扇区数］
```

评估硬盘的读取效率

```bash
 hdparm -t /dev/sda
 /dev/sda:
 Timing buffered disk reads: 166 MB in 3.03 seconds = 54.85 MB/sec
 [root@linuxso.com ~]# hdparm -t /dev/sda
 /dev/sda:
 Timing buffered disk reads: 160 MB in 3.01 seconds = 53.11 MB/sec
 [root@linuxso.com ~]# hdparm -t /dev/sda
 /dev/sda:
 Timing buffered disk reads: 166 MB in 3.00 seconds = 55.31 MB/sec
```
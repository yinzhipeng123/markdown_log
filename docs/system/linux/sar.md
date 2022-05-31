# sar命令

sar工具将对系统当前的状态进行取样，然后通过计算数据和比例来表达系统的当前运行状态。它的特点是可以连续对系统取样，获得大量的取样数据。取样数据和分析的结果都可以存入文件，使用它时消耗的系统资源很小。

**语法格式**：sar [ 选项 ] [ <时间间隔> [ <次数> ] ]

**常用参数：**﻿

sar -h 显示：

-A：所有报告的总和
-e：设置显示报告的结束时间
-f：从制定的文件读取报告
-i：设置状态信息刷新的间隔时间
-P：报告每个CPU的状态
-x：显示给定进程的装

```bash
[root@VM-0-16-centos ~]# sar -h
用法: sar [ 选项 ] [ <时间间隔> [ <次数> ] ]
主选项和报告：
	-b	I/O 和传输速率信息状况
	-B	分页状况
	-d	块设备状况
	-F [ MOUNT ]
		Filesystems statistics
	-H	交换空间利用率
	-I { <中断> | SUM | ALL | XALL }
		中断信息状况
	-m { <关键词> [,...] | ALL }
		电源管理统计信息
		关键字:
		CPU	CPU 频率
		FAN	风扇速度
\t\tFREQ\tCPU 平均时钟频率
		IN	输入电压
		TEMP	设备温度
\t\tUSB\t连接的USB 设备
	-n { <关键词> [,...] | ALL }
		网络统计信息
		关键词可以是：
		DEV	网卡
		EDEV	网卡 (错误)
		NFS	NFS 客户端
		NFSD	NFS 服务器
		SOCK	Sockets (套接字)	(v4)
		IP	IP 流	(v4)
		EIP	IP 流	(v4) (错误)
		ICMP	ICMP 流	(v4)
		EICMP	ICMP 流	(v4) (错误)
		TCP	TCP 流	(v4)
		ETCP	TCP 流	(v4) (错误)
		UDP	UDP 流	(v4)
		SOCK6	Sockets (套接字)	(v6)
		IP6	IP 流	(v6)
		EIP6	IP 流	(v6) (错误)
		ICMP6	ICMP 流	(v6)
		EICMP6	ICMP 流	(v6) (错误)
		UDP6	UDP 流	(v6)
	-q	队列长度和平均负载
	-r	内存利用率
	-R	内存状况
	-S	交换空间利用率
	-u [ ALL ]
		CPU 利用率
	-v	Kernel table 状况
	-w	任务创建与系统转换统计信息
	-W	交换信息
	-y	TTY 设备状况
	
$ sar --help
用法: sar [ 选项 ] [ <时间间隔> [ <次数> ] ]
Options are:
[ -A ] [ -B ] [ -b ] [ -C ] [ -d ] [ -F [ MOUNT ] ] [ -H ] [ -h ] [ -p ] [ -q ] [ -R ]
[ -r ] [ -S ] [ -t ] [ -u [ ALL ] ] [ -V ] [ -v ] [ -W ] [ -w ] [ -y ]
[ -I { <int> [,...] | SUM | ALL | XALL } ] [ -P { <cpu> [,...] | ALL } ]
[ -m { <keyword> [,...] | ALL } ] [ -n { <keyword> [,...] | ALL } ]
[ -j { ID | LABEL | PATH | UUID | ... } ]
[ -f [ <filename> ] | -o [ <filename> ] | -[0-9]+ ]
[ -i <interval> ] [ -s [ <hh:mm:ss> ] ] [ -e [ <hh:mm:ss> ] ]
```

## 一些常用的具体解释

### 1.查看CPU使用情况

sar 1 3  或 sar -u 1 3

```bash
$ sar 1 3
Linux 3.10.0-1160.45.1.el7.x86_64 (VM-0-16-centos) 	05/31/2022 	_x86_64_	(4 CPU)

12:48:15 AM     CPU     %user     %nice   %system   %iowait    %steal     %idle
12:48:16 AM     all      0.00      0.00      0.25      0.00      0.00     99.75
12:48:17 AM     all      0.00      0.00      0.00      0.00      0.00    100.00
12:48:18 AM     all      0.00      0.00      0.25      0.25      0.00     99.50
Average:        all      0.00      0.00      0.17      0.08      0.00     99.75
```

- %user   用户空间的CPU使用
- %nice   改变过优先级的进程的CPU使用率
- %system   内核空间的CPU使用率
- %iowait   CPU等待IO的百分比 
- %steal   虚拟机的虚拟机CPU使用的CPU
- %idle   空闲的CPU



### 2.查看平均负载

sar -q 1 3

```bash
$ sar -q 1 3
Linux 3.10.0-1160.45.1.el7.x86_64 (VM-0-16-centos) 	05/31/2022 	_x86_64_	(4 CPU)

12:52:45 AM   runq-sz  plist-sz   ldavg-1   ldavg-5  ldavg-15   blocked
12:52:46 AM         0       233      0.00      0.01      0.05         0
12:52:47 AM         0       233      0.00      0.01      0.05         0
12:52:48 AM         0       233      0.00      0.01      0.05         0
Average:            0       233      0.00      0.01      0.05         0
```

- runq-sz   R状态的进程或者线程数
- plist-sz   进程列表中的进程（processes）和线程数（threads）的数量
- ldavg-1  最后1分钟的CPU平均负载，即将多核CPU过去一分钟的负载相加再除以核心数得出的平均值，5分钟和15分钟以此类推
- ldavg-5   最后5分钟的CPU平均负载
- ldavg-15  最后15分钟的CPU平均负载
- blocked   因IO不可中断的进程或者线程数

### 3.查看内存使用情况 

sar -r 1 3

```bash
$ sar -r 1 3
Linux 3.10.0-1160.45.1.el7.x86_64 (VM-0-16-centos) 	05/31/2022 	_x86_64_	(4 CPU)

12:55:29 AM kbmemfree kbmemused  %memused kbbuffers  kbcached  kbcommit   %commit  kbactive   kbinact   kbdirty
12:55:30 AM   4646840   3361792     41.98    296276   2403396   2122468     26.50   1791748   1167196       228
12:55:31 AM   4646840   3361792     41.98    296276   2403396   2122468     26.50   1791752   1167196       228
12:55:32 AM   4646840   3361792     41.98    296276   2403396   2122468     26.50   1791752   1167196       232
Average:      4646840   3361792     41.98    296276   2403396   2122468     26.50   1791751   1167196       229
```

- kbmemfree   空闲的物理内存大小
- kbmemused   使用中的物理内存大小
- %memused  物理内存使用率
- kbbuffers  内核中作为缓冲区使用的物理内存大小，kbbuffers和kbcached:这两个值就是free命令中的buffer和cache. 
- kbcached  缓存的文件大小
- kbcommit   当前工作负载所需的内存量（KB）。这是一个估计需要多少RAM和swap来保证永远不会出现内存不足的情况
- commit   当前工作负载所需内存占内存总量（RAM+交换）的百分比。这个数字可能大于100%。**就是kbcommit除以(当前的物理内存+swap总量)** 低于100%说明内存无压力，高于100%，说明内存不够，需要升配置



### 4.查看系统swap分区统计情况

sar -W 1 3

```bash
[root@VM-0-16-centos ~]# sar -W 1 3
Linux 3.10.0-1160.45.1.el7.x86_64 (VM-0-16-centos) 	05/31/2022 	_x86_64_	(4 CPU)

12:59:47 AM  pswpin/s pswpout/s
12:59:48 AM      0.00      0.00
12:59:49 AM      0.00      0.00
12:59:50 AM      0.00      0.00
Average:         0.00      0.00
```

- pswpin/s    每秒从交换分区到系统的交换页面（swap page）数量
- pswpott/s   每秒从系统交换到swap的交换页面（swap page）的数量

sar -B

```bash
$ sar -B 1 3
Linux 3.10.0-1160.45.1.el7.x86_64 (VM-0-16-centos) 	05/31/2022 	_x86_64_	(4 CPU)

01:00:44 AM  pgpgin/s pgpgout/s   fault/s  majflt/s  pgfree/s pgscank/s pgscand/s pgsteal/s    %vmeff
01:00:45 AM      0.00      0.00     29.00      0.00     72.00      0.00      0.00      0.00      0.00
01:00:46 AM      0.00      0.00     28.00      0.00     28.00      0.00      0.00      0.00      0.00
01:00:47 AM      0.00      0.00     18.00      0.00     25.00      0.00      0.00      0.00      0.00
Average:         0.00      0.00     25.00      0.00     41.67      0.00      0.00      0.00      0.00
```

- pgpgin/s ：系统每秒从磁盘调入的总KB数。

- pgpgout/s ：系统每秒分页到磁盘的总KB数。
- fault/s：系统每秒产生的页面失效(major + minor)数量
- majflt/s：系统每秒产生的页面失效(major)数量
- pgscank/s：每秒被kswapd扫描的页个数
- pgscand/s：每秒直接被扫描的页个数
- %vmeff：每秒清除的页(pgsteal)占总扫描页(pgscank + pgscand)的百分比 

### 5.查看IO和传递速率

sar -b 1 3

```bash
$ sar -b 1 3
Linux 3.10.0-1160.45.1.el7.x86_64 (VM-0-16-centos) 	05/31/2022 	_x86_64_	(4 CPU)

01:17:46 AM       tps      rtps      wtps   bread/s   bwrtn/s
01:17:47 AM      0.00      0.00      0.00      0.00      0.00
01:17:48 AM      2.00      0.00      2.00      0.00     24.00
01:17:49 AM      0.00      0.00      0.00      0.00      0.00
Average:         0.67      0.00      0.67      0.00      8.00
```

- tps  磁盘每秒钟的IO总数，等于iostat中的tps

- rtps  每秒钟从磁盘读取的IO总数
- wtps  每秒钟从写入到磁盘的IO总数
- bread/s  每秒钟从磁盘读取的块总数
- bwrtn/s  每秒钟此写入到磁盘的块总数

### 6.查看磁盘使用情况

sar -d

```bash
$ sar -d -p 1 1
Linux 3.10.0-1160.45.1.el7.x86_64 (VM-0-16-centos) 	05/31/2022 	_x86_64_	(4 CPU)

01:20:54 AM       DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz  avgqu-sz     await     svctm     %util
01:20:55 AM       vda      2.00      0.00     24.00     12.00      0.00      1.00      1.50      0.30
01:20:55 AM       vdb      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
01:20:55 AM       sr0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00

Average:          DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz  avgqu-sz     await     svctm     %util
Average:          vda      2.00      0.00     24.00     12.00      0.00      1.00      1.50      0.30
Average:          vdb      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:          sr0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
```

- DEV  磁盘设备的名称，如果不加-p，会显示dev253-0类似的设备名称，因此加上-p显示的名称更直接
- tps  每秒I/O的传输总数
- rd_sec/s  每秒读取的扇区的总数
- wr_sec/s  每秒写入的扇区的总数
- avgrq-sz  平均每次次磁盘I/O操作的数据大小（扇区）
- avgqu-sz  磁盘请求队列的平均长度
- await  从请求磁盘操作到系统完成处理，每次请求的平均消耗时间，包括请求队列等待时间，单位是毫秒（1秒等于1000毫秒），等于寻道时间+队列时间+服务时间
- svctm  I/O的服务处理时间，即不包括请求队列中的时间
- %util  I/O请求占用的CPU百分比，值越高，说明I/O越慢





### 7.网络接口信息

sar -n DEV 1 1

```bash
$ sar -n DEV  1  1
Linux 3.10.0-1160.45.1.el7.x86_64 (VM-0-16-centos) 	05/31/2022 	_x86_64_	(4 CPU)

01:23:50 AM     IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s   rxcmp/s   txcmp/s  rxmcst/s
01:23:51 AM veth664db5a      0.00      0.00      0.00      0.00      0.00      0.00      0.00
01:23:51 AM      eth0      3.00      1.00      0.17      0.21      0.00      0.00      0.00
01:23:51 AM        lo      0.00      0.00      0.00      0.00      0.00      0.00      0.00
01:23:51 AM br-be5dce24fae2      0.00      0.00      0.00      0.00      0.00      0.00      0.00
01:23:51 AM   docker0      0.00      0.00      0.00      0.00      0.00      0.00      0.00

Average:        IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s   rxcmp/s   txcmp/s  rxmcst/s
Average:    veth664db5a      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:         eth0      3.00      1.00      0.17      0.21      0.00      0.00      0.00
Average:           lo      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:    br-be5dce24fae2      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:      docker0      0.00      0.00      0.00      0.00      0.00      0.00      0.00
```

- IFACE  本地网卡接口的名称

- rxpck/s  每秒钟接受的数据包
- txpck/s  每秒钟发送的数据库
- rxKB/S  每秒钟接受的数据包大小，单位为KB
- txKB/S  每秒钟发送的数据包大小，单位为KB
- rxcmp/s  每秒钟接受的压缩数据包
- txcmp/s  每秒钟发送的压缩包
- rxmcst/s  每秒钟接收的多播数据包    

网络设备通信失败信息 

sar -n EDEV 1 1

```bash
$ sar -n EDEV 1 1
Linux 3.10.0-1160.45.1.el7.x86_64 (VM-0-16-centos) 	05/31/2022 	_x86_64_	(4 CPU)

01:24:56 AM     IFACE   rxerr/s   txerr/s    coll/s  rxdrop/s  txdrop/s  txcarr/s  rxfram/s  rxfifo/s  txfifo/s
01:24:57 AM veth664db5a      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
01:24:57 AM      eth0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
01:24:57 AM        lo      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
01:24:57 AM br-be5dce24fae2      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
01:24:57 AM   docker0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00

Average:        IFACE   rxerr/s   txerr/s    coll/s  rxdrop/s  txdrop/s  txcarr/s  rxfram/s  rxfifo/s  txfifo/s
Average:    veth664db5a      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:         eth0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:           lo      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:    br-be5dce24fae2      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:      docker0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
```

- IFACE 网卡名称
- rxerr/s  每秒钟接收到的损坏的数据包
- txerr/s  每秒钟发送的数据包错误数
- coll/s  当发送数据包时候，每秒钟发生的冲撞（collisions）数，这个是在半双工模式下才有
- rxdrop/s  当由于缓冲区满的时候，网卡设备接收端每秒钟丢掉的网络包的数目
- txdrop/s 当由于缓冲区满的时候，网络设备发送端每秒钟丢掉的网络包的数目
- txcarr/s  当发送数据包的时候，每秒钟载波错误发生的次数
- rxfram/s   在接收数据包的时候，每秒钟发生的帧对其错误的次数
- rxfifo/s    在接收数据包的时候，每秒钟缓冲区溢出的错误发生的次数
- txfifo/s    在发生数据包 的时候，每秒钟缓冲区溢出的错误发生的次数

统计socket连接信息

sar -n SOCK 1 1

```bash
$ sar -n SOCK
Linux 3.10.0-1160.45.1.el7.x86_64 (VM-0-16-centos) 	05/31/2022 	_x86_64_	(4 CPU)

12:00:01 AM    totsck    tcpsck    udpsck    rawsck   ip-frag    tcp-tw
12:10:01 AM       266         6         3         0         0         0
12:20:01 AM       265         5         3         0         0         0
12:30:01 AM       265         5         3         0         0         0
12:40:01 AM       267         6         3         0         0         0
12:50:01 AM       268         7         3         0         0         0
01:00:01 AM       267         6         3         0         0         1
01:10:01 AM       267         6         3         0         0         0
01:20:01 AM       267         6         3         0         0         0
01:30:01 AM       267         6         3         0         0         0
Average:          267         6         3         0         0         0
```

- totsck  当前被使用的socket总数
- tcpsck  当前正在被使用的TCP的socket总数
- udpsck   当前正在被使用的UDP的socket总数
- rawsck  当前正在被使用于RAW的skcket总数
- if-frag   当前的IP分片的数目
- tcp-tw  TCP套接字中处于TIME-WAIT状态的连接数量

### 8.TCP连接的统计

sar -n TCP 1 1

```bash
$ sar -n TCP  1 1
Linux 3.10.0-1160.45.1.el7.x86_64 (VM-0-16-centos) 	05/31/2022 	_x86_64_	(4 CPU)

01:38:36 AM  active/s passive/s    iseg/s    oseg/s
01:38:37 AM      0.00      0.00      2.00      1.00
Average:         0.00      0.00      2.00      1.00
```

- active/s  新的主动连接
- passive/s  新的被动连接
- iseg/s  接受的段
- oseg/s  输出的段

## 常用集合

1. 默认监控: sar 1 1       CPU和IOWAIT统计状态 
2. sar -b 1 1         IO传送速率
3. sar -B 1 1        页交换速率
4.  sar -c 1 1          进程创建的速率
5. sar -d 1 1          块设备的活跃信息
6. sar -n DEV  1 1          网路设备的状态信息
7. sar -n EDVE 1  1       网络设备通信失败信息 
8. sar -n SOCK 1 1     SOCK的使用情况
9. sar -n TCP    TCP连接的统计
10. sar -n ALL 1 1      所有的网络状态信息
11. sar -P ALL 1 1      每颗CPU的使用状态信息和IOWAIT统计状态 
12. sar -q 1 1          队列的长度（等待运行的进程数）和负载的状态
13. sar -r 1 1        内存和swap空间使用情况
14. sar -R 1 1         内存的统计信息（内存页的分配和释放、系统每秒作为BUFFER使用内存页、每秒被cache到的内存页）
15. sar -u 1 1         CPU的使用情况和IOWAIT信息（同默认监控）
16. sar -v 1 1         inode, file and other kernel tablesd的状态信息
17. sar -w 1 1         每秒上下文交换的数目
18. sar -W 1 1         SWAP交换的统计信息(监控状态同iostat 的si so)
19. sar -x 2906 1 1    显示指定进程(2906)的统计信息，信息包括：进程造成的错误、用户级和系统级用户CPU的占用情况、运行在哪颗CPU上
20. sar -y 1 1         TTY设备的活动状态



### sar的man手册：

[sar(1) - Linux manual page (man7.org)](https://man7.org/linux/man-pages/man1/sar.1.html)

### sar官网（上面有sar的具体解释）：

[系统统计局 (pagesperso-orange.fr)](http://sebastien.godard.pagesperso-orange.fr/documentation.html)



## 一段查询sar历史记录的脚本：

查找最近一天的sar历史在保存

```bash
sar_history() {
    if [ ! -d '/var/log/sa' ];then
        echo "sar数据目录未找到" 
    fi
    sa_file=$(find /var/log/sa/* -ctime -1 -name "sa*" ! -name "sar*")
    for i in ${sa_file};do 
        sar -p -A -f ${i} >> sar_history_data.txt
    done
}
sar_history &
```


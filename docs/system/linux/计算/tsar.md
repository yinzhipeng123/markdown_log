# tsar命令



```bash
[root@VM-0-16-centos ~]# tsar -help
Usage: tsar [options]
Options:
    -check         显示警报的最后一条记录
    --check/-C     显示警报的最后一条记录.例如:tsar --check / tsar --check --cpu --io
    --watch/-w     以N分钟为单位显示最后记录。 例如:tsar --watch 30 / tsar --watch 30 --cpu --io
    --cron/-c      以cron模式运行，将数据输出到文件
    --interval/-i  指定间隔数，以分钟为单位，如果使用--live，则以秒为单位
    --list/-L      列出启用的模块
    --live/-l      运行打印实时模式，哪个模块将打印
    --file/-f      指定文件路径作为输入
    --ndays/-n     显示过去几天的值（默认值：1）
    --date/-d      显示指定日期的值或者几天前(n or YYYYMMDD)
    --merge/-m     将多项合并为一
    --detail/-D    不将数据转换为K/M/G  1024进制
    --spec/-s      显示规范字段数据, tsar --cpu -s sys,util
    --item/-I      显示规范项数据, tsar --io -I sda
    --help/-h      帮助
Modules Enabled:
    --cpu               CPU 数据 (user, system, interrupt, nice, & idle)
    --mem               物理内存。share (active, inactive, cached, free, wired)
    --swap              swap 使用
    --tcp               TCP 流量     (v4)
    --udp               UDP 流量     (v4)
    --traffic           净流量统计
    --io                Linux I/O performance
    --pcsw              流程（任务）创建和上下文切换
    --partition         磁盘和分区使用情况
    --tcpx              TCP connection data
    --load              系统运行队列和平均负载
```



安装后，您可能会看到以下文件：

- `/etc/tsar/tsar.conf`，这是tsar的主配置文件;
- `/etc/cron.d/tsar`，用于运行tsar每分钟收集信息;
- `/etc/logrotate.d/tsar`将每月轮换tsar的日志文件;
- `/usr/local/tsar/modules`是所有模块库 （*.so） 所在的目录;





## 常用命令

#### 查看网卡是否丢包

```bash
#tsar --live -i 1  --traffic
Time              ---------------------traffic-------------------- 
Time               bytin  bytout   pktin  pktout  pkterr  pktdrp   
12/10/23-17:17:15 174.00  160.00    3.00    2.00    0.00    0.00   
12/10/23-17:17:16 672.00    2.8K    8.00    9.00    0.00    0.00   
12/10/23-17:17:17 968.00    2.5K   12.00   11.00    0.00    0.00   
12/10/23-17:17:18 618.00    1.0K    7.00    7.00    0.00    0.00   
12/10/23-17:17:19  66.00  182.00    1.00    1.00    0.00    0.00   
12/10/23-17:17:20 150.00  278.00    3.00    3.00    0.00    0.00   
12/10/23-17:17:21   1.9K    2.3K   16.00   14.00    0.00    0.00   
12/10/23-17:17:22   1.9K    1.8K   13.00   13.00    0.00    0.00   
12/10/23-17:17:23   2.1K    3.3K   14.00   13.00    0.00    0.00   
12/10/23-17:17:24 984.00    1.4K   10.00   10.00    0.00    0.00   
12/10/23-17:17:25 452.00  584.00    6.00    6.00    0.00    0.00   
12/10/23-17:17:26   1.0K    1.9K   12.00   12.00    0.00    0.00   
12/10/23-17:17:27 884.00    2.2K   10.00   10.00    0.00    0.00
```

#### 显示过去5天每一分钟的网络信息

```
tsar -n 5 -i i  --traffic
```



#### cpu 字段含义

- user: 表示CPU执行用户进程的时间,通常期望用户空间CPU越高越好.
- sys: 表示CPU在内核运行时间,系统CPU占用率高,表明系统某部分存在瓶颈.通常值越低越好.
- wait: CPU在等待I/O操作完成所花费的时间.系统不应该花费大量时间来等待I/O操作,否则就说明I/O存在瓶颈.
- hirq: 系统处理硬中断所花费的时间百分比
- sirq: 系统处理软中断所花费的时间百分比
- util: CPU总使用的时间百分比
- nice: 系统调整进程优先级所花费的时间百分比
- steal: 被强制等待（involuntary wait）虚拟CPU的时间,此时hypervisor在为另一个虚拟处理器服务
- ncpu: CPU的总个数

#### mem 字段含义

- free: 空闲的物理内存的大小
- used: 已经使用的内存大小
- buff: buff使用的内存大小,buffer is something that has yet to be "written" to disk.
- cach: 操作系统会把经常访问的东西放在cache中加快执行速度,A cache is something that has been "read" from the disk and stored for later use
- total: 系统总的内存大小
- util: 内存使用率

#### load 字段含义

- load1: 一分钟的系统平均负载
- load5: 五分钟的系统平均负载
- load15:十五分钟的系统平均负载
- runq: 在采样时刻,运行队列的任务的数目,与/proc/stat的procs_running表示相同意思
- plit: 在采样时刻,系统中活跃的任务的个数（不包括运行已经结束的任务）

#### traffic 字段含义

- bytin: 入口流量byte/s
- bytout: 出口流量byte/s
- pktin: 入口pkt/s
- pktout: 出口pkt/s

#### tcp 字段含义

- active:主动打开的tcp连接数目
- pasive:被动打开的tcp连接数目
- iseg: 收到的tcp报文数目
- outseg:发出的tcp报文数目
- EstRes:Number of resets that have occurred at ESTABLISHED
- AtmpFa:Number of failed connection attempts
- CurrEs:当前状态为ESTABLISHED的tcp连接数
- retran:系统的重传率

#### udp 字段含义

- idgm: 收到的udp报文数目
- odgm: 发送的udp报文数目
- noport:udp协议层接收到目的地址或目的端口不存在的数据包
- idmerr:udp层接收到的无效数据包的个数

#### tcpx 字段含义

- recvq :  tcprecvq
- sendq :  tcpsendq
-  est :   tcpest
- twait:  tcptimewait
- fwait1 :  tcpfinwait1
- fwait2 :  tcpfinwait2
- lisq :  tcplistenq
- lising : tcplistenincq
- lisove : tcplistenover
- cnest :  tcpnconnest
- ndrop :  tcpnconndrop
- edrop :   tcpembdrop
- rdrop :  tcprexmitdrop
- pdrop :  tcppersistdrop
- kdrop :  tcpkadrop
                

#### paritition 字段含义

- bfree: 分区空闲的字节
- bused: 分区使用中的字节
- btotl: 分区总的大小
- util: 分区使用率

#### pcsw 字段含义

- cswch: 进程切换次数
- proc: 新建的进程数



#### proc 字段含义

- user: 某个进程用户态cpu消耗
- sys: 某个进程系统态cpu消耗
- total:某个进程总的cpu消耗
- mem: 某个进程的内存消耗百分比
- RSS: 某个进程的虚拟内存消耗,这是驻留在物理内存的一部分.它没有交换到硬盘.它包括代码,数据和栈
- read: 进程io读字节
- write:进程的io写字节



#### nginx 字段含义

- Accept:总共接收的新连接数目
- Handle:总共处理的连接数目
- Reqs:总共产生请求数目
- Active:活跃的连接数,等于read+write+wait
- Read:读取请求数据的连接数目
- Write:向用户写响应数据的连接数目
- Wait:长连接等待的连接数目
- Qps:每秒处理的请求数
- Rt:平均响应时间ms

#### squid 字段含义

- qps: 每秒请求数
- rt: 访问平均相应时间
- r_hit: 请求命中率
- b_hit: 字节命中率
- d_hit: 磁盘命中率
- m_hit: 内存命中率
- fdused: Number of file desc currently in use
- fdque: Files queued for open
- objs: StoreEntries
- inmem: StoreEntries with MemObjects
- hot: Hot Object Cache Items
- size: Mean Object Size

haproxy 字段含义

- stat: 状态,1正常
- uptime:启动持续时间
- conns: 总的连接数
- qps: 每秒请求数
- hit: haproxy开启cache时的命中率
- rt: 平均响应时间ms

#### lvs 字段含义

- stat: lvs状态,1正常
- conns: 总的连接数
- pktin: 收到的包数
- pktout:发出的包数
- bytin: 收到的字节数
- bytout:发出的字节数



### 相关链接

[能不能对mysql表内的一些字段进行一下注释说明 · Issue #19 · alibaba/tsar · GitHub](https://github.com/alibaba/tsar/issues/19)

[tsar使用说明 - sidesky - 博客园 (cnblogs.com)](https://www.cnblogs.com/sidesky/p/11904384.html)

[GitHub - alibaba/tsar: Taobao System Activity Reporter](https://github.com/alibaba/tsar)

[关于traffic中的单位问题。 · Issue #106 · alibaba/tsar · GitHub](https://github.com/alibaba/tsar/issues/106)

[tsar命令 – 收集服务器系统信息 – Linux命令大全(手册) (linuxcool.com)](https://www.linuxcool.com/tsar)
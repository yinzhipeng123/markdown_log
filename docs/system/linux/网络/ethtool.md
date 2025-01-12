# ethtool命令



ethtool是用于查询及设置网卡参数的命令。

[ethtool（8） - Linux 手册页 (die.net)](https://linux.die.net/man/8/ethtool)

[ethtool linux 命令 在线中文手册 (51yip.com)](http://linux.51yip.com/search/ethtool)

[ethtool 命令，Linux ethtool 命令详解：显示或修改以太网卡的配置信息 - Linux 命令搜索引擎 (wangchujiang.com)](https://wangchujiang.com/linux-command/c/ethtool.html)





[Linux下ethtool指令详解 CSDN博客](https://blog.csdn.net/AnChenliang_1002/article/details/131466920)

[ethtool 原理介绍和解决网卡丢包排查思路_CSDN博客](https://blog.csdn.net/alex_yangchuansheng/article/details/106953394?utm_medium=distribute.pc_relevant.none-task-blog-2~default~BlogCommendFromMachineLearnPai2~default-1.control&dist_request_id=&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2~default~BlogCommendFromMachineLearnPai2~default-1.control)

[Linux命令之ethtool命令（查看光模块信息） - 码农教程 (manongjc.com)](http://www.manongjc.com/detail/42-xpxucgjppyjgazz.html)



#### 查看网卡信息

```
#ethtool eth0
Settings for eth0:
        Supported ports: [ TP ]
        Supported link modes:   10baseT/Half 10baseT/Full 
                                100baseT/Half 100baseT/Full 
                                1000baseT/Full 
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Advertised link modes:  1000baseT/Full 
        Advertised pause frame use: Symmetric
        Advertised auto-negotiation: Yes
        Speed: 1000Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: internal
        Auto-negotiation: on
        MDI-X: on (auto)
        Supports Wake-on: pumbg
        Wake-on: g
        Current message level: 0x00000007 (7)
                               drv probe link
        Link detected: yes
```



Mb/s是 Mbps的缩写，这个卡是GE卡，即是1000Mbps，也是1Gbps. 最大下载速度为125MB/s。

10GE卡，即是10000Mbps，也是10Gbps.最大下载速度为1250MB/s。有的机器ethtool查询网卡时，网卡是不可见的，需要登陆到物理机带外系统进行查看

`ethtool eth0` 输出的内容是关于网卡 `eth0` 的详细信息，具体解释如下：

### 1. **Supported ports: [ TP ]**
   - **TP (Twisted Pair)**: 这是网卡支持的端口类型，表示该网卡支持通过双绞线连接的网络接口。

### 2. **Supported link modes:**
   这些是网卡支持的速率和双工模式：
   - **10baseT/Half**: 支持 10 Mbps 速率的半双工模式（即数据可以在同一时间传输或接收，但不能同时进行）。
   - **10baseT/Full**: 支持 10 Mbps 速率的全双工模式（即数据可以同时进行传输和接收）。
   - **100baseT/Half**: 支持 100 Mbps 速率的半双工模式。
   - **100baseT/Full**: 支持 100 Mbps 速率的全双工模式。
   - **1000baseT/Full**: 支持 1000 Mbps（即 1 Gbps）速率的全双工模式。

### 3. **Supported pause frame use: Symmetric**
   - 该网卡支持**对称暂停帧**，意味着它能够处理流量控制信号（暂停帧）。对称表示可以同时支持发送和接收方向的流量控制。

### 4. **Supports auto-negotiation: Yes**
   - 该网卡支持**自动协商**，意味着它可以自动选择最佳的连接模式（速率和双工模式）。

### 5. **Advertised link modes:**
   这是网卡所宣传的、它可以提供给连接设备的连接模式：
   - **1000baseT/Full**: 该网卡宣传支持 1000 Mbps（1 Gbps）速率的全双工模式。

### 6. **Advertised pause frame use: Symmetric**
   - 该网卡向其他设备宣传支持对称的暂停帧（即流量控制）。

### 7. **Advertised auto-negotiation: Yes**
   - 该网卡向其他设备宣传支持自动协商模式，允许对端设备和该网卡共同决定最佳连接速率和模式。

### 8. **Speed: 1000Mb/s**
   - 当前网卡的连接速率为 **1000 Mbps**（即 1 Gbps），这是网络连接的实际速率。

### 9. **Duplex: Full**
   - 当前网卡的工作模式是 **全双工**（Full Duplex），表示它可以同时进行数据的发送和接收。

### 10. **Port: Twisted Pair**
   - 这是网卡所使用的物理连接类型，表示它通过双绞线（TP）进行数据传输。

### 11. **PHYAD: 1**
   - 这是物理层（PHY）设备的地址，通常是网卡硬件的一部分。PHY 是用于处理实际物理连接的硬件。

### 12. **Transceiver: internal**
   - 这是指网卡使用的是**内部收发器**，即网卡自带了网络收发模块，而不是外部模块。

### 13. **Auto-negotiation: on**
   - 自动协商已启用，表示网卡会自动与对端设备协商最佳连接模式。

### 14. **MDI-X: on (auto)**
   - **MDI-X**（Medium Dependent Interface Crossover）表示网卡支持自动交换网线连接模式（自动交叉线）。如果连接设备的网络接口是直连的，网卡会自动调整为交叉模式，反之亦然。这项功能自动启用。

### 15. **Supports Wake-on: pumbg**
   - 这表示网卡支持通过**特定的网络活动唤醒计算机**。具体来说，支持以下几种唤醒方式：
     - **p**: 通过活动包唤醒。
     - **u**: 通过唤醒请求（MagicPacket）唤醒。
     - **m**: 通过移动数据唤醒。
     - **b**: 通过广播数据唤醒。
     - **g**: 通过标准的“MagicPacket”唤醒。

### 16. **Wake-on: g**
   - 当前网卡的唤醒模式设置为 **MagicPacket** 唤醒（即接收到特定的 MagicPacket 包时唤醒设备）。

### 17. **Current message level: 0x00000007 (7)**
   - 这是网卡的日志消息级别。日志消息级别设置为 `7`，表示详细的日志记录（包含驱动、探测、链接等信息）。

### 18. **Link detected: yes**
   - 网卡当前检测到网络连接已建立，并且连接是有效的。

### 总结：
这条输出显示了 `eth0` 网卡的连接速率、双工模式、自动协商、支持的端口类型、是否启用了唤醒功能等重要信息。该网卡目前工作在 1000 Mbps 全双工模式下，并支持自动协商和唤醒功能。





```bash
[root@VM-0-16-centos ~]# ethtool -S eth0
NIC statistics:
     rx_queue_0_packets: 47005476
     rx_queue_0_bytes: 14962987265
     rx_queue_0_drops: 0
     rx_queue_0_xdp_packets: 0
     rx_queue_0_xdp_tx: 0
     rx_queue_0_xdp_redirects: 0
     rx_queue_0_xdp_drops: 0
     rx_queue_0_kicks: 0
     rx_queue_1_packets: 37051154
     rx_queue_1_bytes: 10928810819
     rx_queue_1_drops: 0
     rx_queue_1_xdp_packets: 0
     rx_queue_1_xdp_tx: 0
     rx_queue_1_xdp_redirects: 0
     rx_queue_1_xdp_drops: 0
     rx_queue_1_kicks: 0
     tx_queue_0_packets: 35729574
     tx_queue_0_bytes: 5439469063
     tx_queue_0_xdp_tx: 0
     tx_queue_0_xdp_tx_drops: 0
     tx_queue_0_kicks: 0
     tx_queue_0_tx_timeouts: 0
     tx_queue_1_packets: 36553329
     tx_queue_1_bytes: 5619620674
     tx_queue_1_xdp_tx: 0
     tx_queue_1_xdp_tx_drops: 0
     tx_queue_1_kicks: 0
     tx_queue_1_tx_timeouts: 0
```

`ethtool -S eth0` 命令显示了关于网络接口 `eth0` 的详细统计信息，具体涵盖了接收队列（`rx_queue`）和发送队列（`tx_queue`）的相关数据。下面是每个字段的解释：

### 接收队列（rx_queue）
1. **`rx_queue_0_packets`** 和 **`rx_queue_1_packets`**  
   这些字段表示在队列 0 和队列 1 中接收到的数据包数。  
   - `rx_queue_0_packets: 47005476` 表示接收队列 0 已接收的包的总数为 47,005,476 个。
   - `rx_queue_1_packets: 37051154` 表示接收队列 1 已接收的包的总数为 37,051,154 个。

2. **`rx_queue_0_bytes`** 和 **`rx_queue_1_bytes`**  
   这些字段表示在队列 0 和队列 1 中接收到的字节总数。  
   - `rx_queue_0_bytes: 14962987265` 表示接收队列 0 已接收的总字节数为 14,962,987,265 字节（约 14.96 GB）。
   - `rx_queue_1_bytes: 10928810819` 表示接收队列 1 已接收的总字节数为 10,928,810,819 字节（约 10.93 GB）。

3. **`rx_queue_0_drops`** 和 **`rx_queue_1_drops`**  
   这些字段表示在接收队列中丢弃的数据包数。  
   - `rx_queue_0_drops: 0` 和 `rx_queue_1_drops: 0` 表示在这两个队列中没有发生数据包丢弃。

4. **`rx_queue_0_xdp_packets`** 和 **`rx_queue_1_xdp_packets`**  
   这些字段显示启用了 XDP（eXpress Data Path）时，接收到的 XDP 数据包的数量。  
   - `rx_queue_0_xdp_packets: 0` 和 `rx_queue_1_xdp_packets: 0` 表示没有启用或没有接收到 XDP 数据包。

5. **`rx_queue_0_xdp_drops`** 和 **`rx_queue_1_xdp_drops`**  
   显示 XDP 数据包丢弃的次数。  
   - `rx_queue_0_xdp_drops: 0` 和 `rx_queue_1_xdp_drops: 0` 表示没有丢弃 XDP 数据包。

6. **`rx_queue_0_kicks`** 和 **`rx_queue_1_kicks`**  
   显示接收队列的“唤醒”次数，指的是在接收队列数据包处理完之后，队列被操作系统或驱动重新启用的次数。  
   - `rx_queue_0_kicks: 0` 和 `rx_queue_1_kicks: 0` 表示没有发生接收队列的唤醒。

### 发送队列（tx_queue）
1. **`tx_queue_0_packets`** 和 **`tx_queue_1_packets`**  
   这些字段表示在发送队列 0 和队列 1 中发送的数据包数。  
   - `tx_queue_0_packets: 35729574` 表示发送队列 0 已发送的包的总数为 35,729,574 个。
   - `tx_queue_1_packets: 36553329` 表示发送队列 1 已发送的包的总数为 36,553,329 个。

2. **`tx_queue_0_bytes`** 和 **`tx_queue_1_bytes`**  
   这些字段表示在发送队列 0 和队列 1 中发送的字节总数。  
   - `tx_queue_0_bytes: 5439469063` 表示发送队列 0 已发送的总字节数为 5,439,469,063 字节（约 5.44 GB）。
   - `tx_queue_1_bytes: 5619620674` 表示发送队列 1 已发送的总字节数为 5,619,620,674 字节（约 5.62 GB）。

3. **`tx_queue_0_xdp_tx`** 和 **`tx_queue_1_xdp_tx`**  
   这些字段表示启用了 XDP 的情况下，发送到 XDP 数据包的数量。  
   - `tx_queue_0_xdp_tx: 0` 和 `tx_queue_1_xdp_tx: 0` 表示没有启用或没有发送 XDP 数据包。

4. **`tx_queue_0_tx_timeouts`** 和 **`tx_queue_1_tx_timeouts`**  
   显示发送队列的超时次数。  
   - `tx_queue_0_tx_timeouts: 0` 和 `tx_queue_1_tx_timeouts: 0` 表示没有发生发送超时的情况。

5. **`tx_queue_0_xdp_tx_drops`**  
   显示 XDP 发送队列丢包的次数。  
   - `tx_queue_0_xdp_tx_drops: 0` 表示没有丢弃任何 XDP 数据包。

6. **`tx_queue_0_kicks`** 和 **`tx_queue_1_kicks`**  
   显示发送队列的“唤醒”次数，指的是发送队列被操作系统或驱动重新启用的次数。  
   - `tx_queue_0_kicks: 0` 和 `tx_queue_1_kicks: 0` 表示没有发生发送队列的唤醒。

### 
这些统计信息帮助了解每个接收和发送队列的流量、丢包情况、超时、XDP 数据包的处理情况等。通常，`drops` 为 0 表示网卡正常工作，没有丢失数据。如果这些值变大，可能需要优化系统或硬件性能。











```bash
[root ~]# ethtool p1
Settings for p1:  # 显示接口p1的设置
	Supported ports: [ FIBRE ]  # 支持的端口类型：光纤（FIBRE）
	Supported link modes:   1000baseT/Full  # 支持的链路模式：千兆以太网（1000baseT），全双工模式（Full）
	                        1000baseKX/Full  # 支持的链路模式：千兆以太网KX（1000baseKX），全双工模式（Full）
	                        10000baseT/Full  # 支持的链路模式：万兆以太网（10000baseT），全双工模式（Full）
	                        10000baseKR/Full  # 支持的链路模式：万兆以太网KR（10000baseKR），全双工模式（Full）
	                        40000baseKR4/Full  # 支持的链路模式：40Gb以太网KR4（40000baseKR4），全双工模式（Full）
	                        40000baseCR4/Full  # 支持的链路模式：40Gb以太网CR4（40000baseCR4），全双工模式（Full）
	                        40000baseSR4/Full  # 支持的链路模式：40Gb以太网SR4（40000baseSR4），全双工模式（Full）
	                        40000baseLR4/Full  # 支持的链路模式：40Gb以太网LR4（40000baseLR4），全双工模式（Full）
	                        25000baseCR/Full  # 支持的链路模式：25Gb以太网CR（25000baseCR），全双工模式（Full）
	                        25000baseKR/Full  # 支持的链路模式：25Gb以太网KR（25000baseKR），全双工模式（Full）
	                        25000baseSR/Full  # 支持的链路模式：25Gb以太网SR（25000baseSR），全双工模式（Full）
	                        50000baseCR2/Full  # 支持的链路模式：50Gb以太网CR2（50000baseCR2），全双工模式（Full）
	                        50000baseKR2/Full  # 支持的链路模式：50Gb以太网KR2（50000baseKR2），全双工模式（Full）
	                        100000baseKR4/Full  # 支持的链路模式：100Gb以太网KR4（100000baseKR4），全双工模式（Full）
	                        100000baseSR4/Full  # 支持的链路模式：100Gb以太网SR4（100000baseSR4），全双工模式（Full）
	                        100000baseCR4/Full  # 支持的链路模式：100Gb以太网CR4（100000baseCR4），全双工模式（Full）
	                        100000baseLR4_ER4/Full  # 支持的链路模式：100Gb以太网LR4/ER4（100000baseLR4_ER4），全双工模式（Full）
	                        50000baseSR2/Full  # 支持的链路模式：50Gb以太网SR2（50000baseSR2），全双工模式（Full）
	                        1000baseX/Full  # 支持的链路模式：千兆以太网X（1000baseX），全双工模式（Full）
	                        10000baseCR/Full  # 支持的链路模式：万兆以太网CR（10000baseCR），全双工模式（Full）
	                        10000baseSR/Full  # 支持的链路模式：万兆以太网SR（10000baseSR），全双工模式（Full）
	                        10000baseLR/Full  # 支持的链路模式：万兆以太网LR（10000baseLR），全双工模式（Full）
	                        10000baseER/Full  # 支持的链路模式：万兆以太网ER（10000baseER），全双工模式（Full）
	Supported pause frame use: Symmetric  # 支持的暂停帧使用：对称（Symmetric），指双方可以发送暂停帧
	Supports auto-negotiation: Yes  # 支持自动协商：是（Yes），自动协商允许设备协商最佳连接速率
	Supported FEC modes: None BaseR RS  # 支持的前向纠错（FEC）模式：无（None），BaseR，RS
	Advertised link modes:  1000baseT/Full  # 广告的链路模式：千兆以太网（1000baseT），全双工模式（Full）
	                        1000baseKX/Full  # 广告的链路模式：千兆以太网KX（1000baseKX），全双工模式（Full）
	                        10000baseT/Full  # 广告的链路模式：万兆以太网（10000baseT），全双工模式（Full）
	                        10000baseKR/Full  # 广告的链路模式：万兆以太网KR（10000baseKR），全双工模式（Full）
	                        40000baseKR4/Full  # 广告的链路模式：40Gb以太网KR4（40000baseKR4），全双工模式（Full）
	                        40000baseCR4/Full  # 广告的链路模式：40Gb以太网CR4（40000baseCR4），全双工模式（Full）
	                        40000baseSR4/Full  # 广告的链路模式：40Gb以太网SR4（40000baseSR4），全双工模式（Full）
	                        40000baseLR4/Full  # 广告的链路模式：40Gb以太网LR4（40000baseLR4），全双工模式（Full）
	                        25000baseCR/Full  # 广告的链路模式：25Gb以太网CR（25000baseCR），全双工模式（Full）
	                        25000baseKR/Full  # 广告的链路模式：25Gb以太网KR（25000baseKR），全双工模式（Full）
	                        25000baseSR/Full  # 广告的链路模式：25Gb以太网SR（25000baseSR），全双工模式（Full）
	                        50000baseCR2/Full  # 广告的链路模式：50Gb以太网CR2（50000baseCR2），全双工模式（Full）
	                        50000baseKR2/Full  # 广告的链路模式：50Gb以太网KR2（50000baseKR2），全双工模式（Full）
	                        100000baseKR4/Full  # 广告的链路模式：100Gb以太网KR4（100000baseKR4），全双工模式（Full）
	                        100000baseSR4/Full  # 广告的链路模式：100Gb以太网SR4（100000baseSR4），全双工模式（Full）
	                        100000baseCR4/Full  # 广告的链路模式：100Gb以太网CR4（100000baseCR4），全双工模式（Full）
	                        100000baseLR4_ER4/Full  # 广告的链路模式：100Gb以太网LR4/ER4（100000baseLR4_ER4），全双工模式（Full）
	                        50000baseSR2/Full  # 广告的链路模式：50Gb以太网SR2（50000baseSR2），全双工模式（Full）
	                        1000baseX/Full  # 广告的链路模式：千兆以太网X（1000baseX），全双工模式（Full）
	                        10000baseCR/Full  # 广告的链路模式：万兆以太网CR（10000baseCR），全双工模式（Full）
	                        10000baseSR/Full  # 广告的链路模式：万兆以太网SR（10000baseSR），全双工模式（Full）
	                        10000baseLR/Full  # 广告的链路模式：万兆以太网LR（10000baseLR），全双工模式（Full）
	                        10000baseER/Full  # 广告的链路模式：万兆以太网ER（10000baseER），全双工模式（Full）
	Advertised pause frame use: No  # 广告的暂停帧使用：无（No），表示不使用暂停帧
	Advertised auto-negotiation: Yes  # 广告的自动协商：是（Yes）
	Advertised FEC modes: RS  # 广告的前向纠错（FEC）模式：RS
	Speed: 100000Mb/s  # 当前链路速率：100000 Mb/s（100Gbps）
	Duplex: Full  # 双工模式：全双工（Full），可以同时发送和接收数据
	Port: FIBRE  # 端口类型：光纤（FIB

```


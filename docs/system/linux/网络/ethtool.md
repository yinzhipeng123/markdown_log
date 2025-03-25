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
Settings for eth0:                           # 针对网络接口 eth0 的配置信息：
        Supported ports: [ TP ]              # 支持的物理端口类型：[双绞线 (Twisted Pair)]
        Supported link modes:   10baseT/Half 10baseT/Full   # 支持的链路速率和模式：10 Mbps 半双工和全双工
                                100baseT/Half 100baseT/Full   # 支持的链路速率和模式：100 Mbps 半双工和全双工
                                1000baseT/Full              # 支持的链路速率和模式：1000 Mbps（1 Gbps）全双工
        Supported pause frame use: Symmetric  # 支持对称的暂停帧功能，用于流量控制
        Supports auto-negotiation: Yes         # 支持自动协商功能（自动选择最佳链路参数）
        Advertised link modes:  1000baseT/Full   # 广告（启用）的链路模式：仅1000 Mbps全双工
        Advertised pause frame use: Symmetric  # 广告的暂停帧使用方式：对称（双方都支持暂停帧）
        Advertised auto-negotiation: Yes       # 广告自动协商功能：启用
        Speed: 1000Mb/s                        # 当前链路速度：1000 Mbps（1 Gbps）
        Duplex: Full                           # 当前工作模式：全双工
        Port: Twisted Pair                     # 使用的端口类型：双绞线
        PHYAD: 1                               # PHY设备地址：1（物理层芯片的地址）
        Transceiver: internal                  # 收发器类型：内置（集成在设备内部）
        Auto-negotiation: on                   # 自动协商状态：开启
        MDI-X: on (auto)                       # MDI-X状态：开启（自动切换，避免交叉线问题）
        Supports Wake-on: pumbg                 # 支持的唤醒模式：p (PHY)，u (Unicast)，m (Multicast)，b (Broadcast)，g (MagicPacket)
        Wake-on: g                             # 当前唤醒模式：仅支持 MagicPacket 唤醒
        Current message level: 0x00000007 (7)    # 当前日志消息级别：0x00000007（数值7，控制驱动输出的详细程度）
                               drv probe link        # 日志详细级别包括：驱动（drv）、探测（probe）和链路（link）相关信息
        Link detected: yes                     # 当前链路检测状态：检测到有效网络连接
```



Mb/s是 Mbps的缩写，这个卡是GE卡，即是1000Mbps，也是1Gbps. 最大下载速度为125MB/s。

10GE卡，即是10000Mbps，也是10Gbps.最大下载速度为1250MB/s。有的机器ethtool查询网卡时，网卡是不可见的，需要登陆到物理机带外系统进行查看

这条输出显示了 `eth0` 网卡的连接速率、双工模式、自动协商、支持的端口类型、是否启用了唤醒功能等重要信息。该网卡目前工作在 1000 Mbps 全双工模式下，并支持自动协商和唤醒功能。



```bash
NIC statistics:                                       # 网络接口卡统计信息：
     rx_queue_0_packets: 47005476                     # 接收队列0接收到的数据包数量为47005476
     rx_queue_0_bytes: 14962987265                    # 接收队列0接收到的字节数为14962987265
     rx_queue_0_drops: 0                              # 接收队列0丢弃的数据包数量为0
     rx_queue_0_xdp_packets: 0                        # 接收队列0经过XDP处理的数据包数量为0
     rx_queue_0_xdp_tx: 0                             # 接收队列0通过XDP发送的数据包数量为0
     rx_queue_0_xdp_redirects: 0                      # 接收队列0通过XDP重定向的数据包数量为0
     rx_queue_0_xdp_drops: 0                          # 接收队列0通过XDP丢弃的数据包数量为0
     rx_queue_0_kicks: 0                              # 接收队列0被唤醒处理（kick）的次数为0
     rx_queue_1_packets: 37051154                     # 接收队列1接收到的数据包数量为37051154
     rx_queue_1_bytes: 10928810819                    # 接收队列1接收到的字节数为10928810819
     rx_queue_1_drops: 0                              # 接收队列1丢弃的数据包数量为0
     rx_queue_1_xdp_packets: 0                        # 接收队列1经过XDP处理的数据包数量为0
     rx_queue_1_xdp_tx: 0                             # 接收队列1通过XDP发送的数据包数量为0
     rx_queue_1_xdp_redirects: 0                      # 接收队列1通过XDP重定向的数据包数量为0
     rx_queue_1_xdp_drops: 0                          # 接收队列1通过XDP丢弃的数据包数量为0
     rx_queue_1_kicks: 0                              # 接收队列1被唤醒处理（kick）的次数为0
     tx_queue_0_packets: 35729574                     # 发送队列0发送的数据包数量为35729574
     tx_queue_0_bytes: 5439469063                     # 发送队列0发送的字节数为5439469063
     tx_queue_0_xdp_tx: 0                             # 发送队列0通过XDP发送的数据包数量为0
     tx_queue_0_xdp_tx_drops: 0                       # 发送队列0通过XDP发送时丢弃的数据包数量为0
     tx_queue_0_kicks: 0                              # 发送队列0被唤醒处理（kick）的次数为0
     tx_queue_0_tx_timeouts: 0                        # 发送队列0发生传输超时的次数为0
     tx_queue_1_packets: 36553329                     # 发送队列1发送的数据包数量为36553329
     tx_queue_1_bytes: 5619620674                     # 发送队列1发送的字节数为5619620674
     tx_queue_1_xdp_tx: 0                             # 发送队列1通过XDP发送的数据包数量为0
     tx_queue_1_xdp_tx_drops: 0                       # 发送队列1通过XDP发送时丢弃的数据包数量为0
     tx_queue_1_kicks: 0                              # 发送队列1被唤醒处理（kick）的次数为0
     tx_queue_1_tx_timeouts: 0                        # 发送队列1发生传输超时的次数为0
```

`ethtool -S eth0` 命令显示了关于网络接口 `eth0` 的详细统计信息，具体涵盖了接收队列（`rx_queue`）和发送队列（`tx_queue`）的相关数据。

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



```bash
NIC statistics:  # NIC统计信息：
     rx_packets: 1226  # 接收到的数据包数量：1226
     rx_bytes: 74420  # 接收到的数据字节数：74420
     tx_packets: 6  # 发送的数据包数量：6
     tx_bytes: 516  # 发送的数据字节数：516
     tx_tso_packets: 0  # 发送的TSO（TCP分段卸载）数据包数量：0
     tx_tso_bytes: 0  # 发送的TSO数据字节数：0
     tx_tso_inner_packets: 0  # 发送的内部TSO数据包数量（嵌套封装时）：0
     tx_tso_inner_bytes: 0  # 发送的内部TSO数据字节数：0
     tx_added_vlan_packets: 0  # 发送时添加VLAN标签的数据包数量：0
     tx_nop: 0  # 发送时无操作（NOP）数据包数量：0
     tx_mpwqe_blks: 6  # 发送多包队列工作块（MPWQE）数量：6
     tx_mpwqe_pkts: 6  # 发送多包队列中的数据包数量：6
     rx_lro_packets: 0  # 接收时通过大包合并（LRO）处理的数据包数量：0
     rx_lro_bytes: 0  # 接收时大包合并后处理的数据字节数：0
     rx_ecn_mark: 0  # 接收时标记了ECN（显式拥塞通知）的数据包数量：0
     rx_removed_vlan_packets: 0  # 接收时移除VLAN标签的数据包数量：0
     rx_csum_unnecessary: 0  # 接收时认为校验和计算不必要的数据包数量：0
     rx_csum_none: 1213  # 接收时没有进行校验和计算的数据包数量：1213
     rx_csum_complete: 13  # 接收时校验和已经完成的数据包数量：13
     rx_csum_complete_tail: 0  # 接收时尾部校验和完成的数据包数量：0
     rx_csum_complete_tail_slow: 0  # 接收时慢速尾部校验和完成的数据包数量：0
     rx_csum_unnecessary_inner: 0  # 接收内部数据包中无需校验和的数据包数量：0
     rx_xdp_drop: 0  # XDP处理时丢弃的数据包数量：0
     rx_xdp_redirect: 0  # XDP处理时重定向的数据包数量：0
     rx_xdp_tx_xmit: 0  # XDP处理时通过TX传输的数据包数量：0
     rx_xdp_tx_mpwqe: 0  # XDP处理时通过多包队列传输的数据包数量：0
     rx_xdp_tx_inlnw: 0  # XDP处理时内联传输的数据包数量：0
     rx_xdp_tx_nops: 0  # XDP处理时无操作传输的数据包数量：0
     rx_xdp_tx_full: 0  # XDP处理时因队列满而无法传输的数据包数量：0
     rx_xdp_tx_err: 0  # XDP处理时传输出错的数据包数量：0
     rx_xdp_tx_cqe: 0  # XDP处理时TX完成队列事件数量：0
     tx_csum_none: 6  # 发送时没有校验和处理的数据包数量：6
     tx_csum_partial: 0  # 发送时部分校验和处理的数据包数量：0
     tx_csum_partial_inner: 0  # 发送内部数据包部分校验和处理数量：0
     tx_queue_stopped: 0  # 发送队列因某种原因停止的次数：0
     tx_queue_dropped: 0  # 发送队列丢弃的数据包数量：0
     tx_xmit_more: 0  # 发送时批量传输（xmit_more）的调用次数：0
     tx_recover: 0  # 发送队列恢复操作的次数：0
     tx_cqes: 6  # 发送完成队列事件（CQE）数量：6
     tx_queue_wake: 0  # 发送队列被唤醒的次数：0
     tx_cqe_err: 0  # 发送完成队列中发生错误的事件数量：0
     tx_xdp_xmit: 0  # 通过XDP传输发送的数据包数量：0
     tx_xdp_mpwqe: 0  # XDP多包队列发送的数据包数量：0
     tx_xdp_inlnw: 0  # XDP内联传输发送的数据包数量：0
     tx_xdp_nops: 0  # XDP无操作发送的数据包数量：0
     tx_xdp_full: 0  # XDP发送时因队列满而无法传输的数据包数量：0
     tx_xdp_err: 0  # XDP发送时发生错误的数据包数量：0
     tx_xdp_cqes: 0  # XDP发送完成队列事件数量：0
     tx_cqe_compress_blks: 0  # 发送完成队列压缩块的数量：0
     tx_cqe_compress_pkts: 0  # 发送完成队列压缩数据包的数量：0
     rx_wqe_err: 0  # 接收工作队列（WQE）错误的数量：0
     rx_mpwqe_filler_cqes: 0  # 接收多包队列填充时的完成队列事件数量：0
     rx_mpwqe_filler_strides: 0  # 接收多包队列填充时的步长计数：0
     rx_oversize_pkts_sw_drop: 0  # 接收时因数据包超大而被软件丢弃的数量：0
     rx_buff_alloc_err: 0  # 接收缓冲区分配错误的次数：0
     rx_cqe_compress_blks: 0  # 接收完成队列压缩块的数量：0
     rx_cqe_compress_pkts: 0  # 接收完成队列压缩数据包的数量：0
     rx_cache_reuse: 1152  # 接收缓存被重复使用的次数：1152
     rx_cache_full: 0  # 接收缓存满的次数：0
     rx_cache_empty: 0  # 接收缓存为空的次数：0
     rx_cache_busy: 0  # 接收缓存忙碌的次数：0
     rx_cache_ext: 0  # 扩展接收缓存使用的次数：0
     rx_cache_rdc: 0  # 接收缓存远程直接缓存（RDC）命中次数：0
     rx_cache_alloc: 60480  # 接收缓存分配的次数：60480
     rx_cache_waive: 0  # 放弃使用接收缓存的次数：0
     rx_congst_umr: 0  # 接收中发生拥塞UMR事件的数量（UMR通常与内存注册有关）：0
     rx_arfs_err: 0  # 接收时ARFS（加速接收流规则）错误的数量：0
     rx_recover: 0  # 接收过程中恢复操作的次数：0
     rx_pet_hdr_lookup_drop: 0  # 接收时因PET头查找失败而丢弃的数据包数量：0
     rx_pet_mdata_lookup_drop: 0  # 接收时因PET元数据查找失败而丢弃的数据包数量：0
     ch_events: 1367  # 通道（channel）事件的总数量：1367
     ch_poll: 1367  # 通道轮询（poll）操作的次数：1367
     ch_arm: 1367  # 通道使能（arm）的次数：1367
     ch_aff_change: 0  # 通道亲和性（affinity）变更的次数：0
     ch_force_irq: 0  # 通道中强制中断（IRQ）的次数：0
     ch_eq_rearm: 0  # 通道事件队列（EQ）重新使能的次数：0
     rx_xsk_packets: 0  # 通过AF_XDP套接字（XSK）接收到的数据包数量：0
     rx_xsk_bytes: 0  # 通过XSK接收到的数据字节数：0
     rx_xsk_csum_complete: 0  # XSK接收时校验和完成的数据包数量：0
     rx_xsk_csum_unnecessary: 0  # XSK接收时认为校验和不必要的数据包数量：0
     rx_xsk_csum_unnecessary_inner: 0  # XSK接收内部无需校验和的数据包数量：0
     rx_xsk_csum_none: 0  # XSK接收时未做校验和处理的数据包数量：0
     rx_xsk_ecn_mark: 0  # XSK接收时带有ECN标记的数据包数量：0
     rx_xsk_removed_vlan_packets: 0  # XSK接收时移除VLAN标签的数据包数量：0
     rx_xsk_xdp_drop: 0  # XSK接收时因XDP处理丢弃的数据包数量：0
     rx_xsk_xdp_redirect: 0  # XSK接收时XDP重定向的数据包数量：0
     rx_xsk_wqe_err: 0  # XSK接收工作队列错误的数量：0
     rx_xsk_mpwqe_filler_cqes: 0  # XSK接收多包队列填充时的完成队列事件数量：0
     rx_xsk_mpwqe_filler_strides: 0  # XSK接收多包队列填充时的步长计数：0
     rx_xsk_oversize_pkts_sw_drop: 0  # XSK接收时因超大数据包而被软件丢弃的数量：0
     rx_xsk_buff_alloc_err: 0  # XSK接收缓冲区分配错误的次数：0
     rx_xsk_cqe_compress_blks: 0  # XSK接收完成队列压缩块的数量：0
     rx_xsk_cqe_compress_pkts: 0  # XSK接收完成队列压缩数据包的数量：0
     rx_xsk_congst_umr: 0  # XSK接收中发生拥塞UMR事件的数量：0
     rx_xsk_arfs_err: 0  # XSK接收时ARFS错误的数量：0
     tx_xsk_xmit: 0  # 通过XSK发送的数据包数量：0
     tx_xsk_mpwqe: 0  # 通过XSK多包队列发送的数据包数量：0
     tx_xsk_inlnw: 0  # XSK内联发送的数据包数量：0
     tx_xsk_full: 0  # XSK发送时因队列满导致失败的数据包数量：0
     tx_xsk_err: 0  # XSK发送错误的数据包数量：0
     tx_xsk_cqes: 0  # XSK发送完成队列事件的数量：0
     rx_out_of_buffer: 0  # 接收时因缓冲区不足而丢弃的数据包数量：0
     rx_if_down_packets: 0  # 接口关闭时仍接收到的数据包数量：0
     rx_steer_missed_packets: 194  # 数据包流量重定向（steering）时错过的数据包数量：194
     dev_internal_queue_oob: 0  # 设备内部队列越界（out-of-band）事件的次数：0
     rx_vport_unicast_packets: 11935233  # 虚拟端口接收到的单播数据包数量：11935233
     rx_vport_unicast_bytes: 1704131709  # 虚拟端口接收到的单播数据字节数：1704131709
     tx_vport_unicast_packets: 6680386  # 虚拟端口发送的单播数据包数量：6680386
     tx_vport_unicast_bytes: 789549074  # 虚拟端口发送的单播数据字节数：789549074
     rx_vport_multicast_packets: 2110625  # 虚拟端口接收到的多播数据包数量：2110625
     rx_vport_multicast_bytes: 248541960  # 虚拟端口接收到的多播数据字节数：248541960
     tx_vport_multicast_packets: 542205  # 虚拟端口发送的多播数据包数量：542205
     tx_vport_multicast_bytes: 46629694  # 虚拟端口发送的多播数据字节数：46629694
     rx_vport_broadcast_packets: 959871  # 虚拟端口接收到的广播数据包数量：959871
     rx_vport_broadcast_bytes: 74533128  # 虚拟端口接收到的广播数据字节数：74533128
     tx_vport_broadcast_packets: 2  # 虚拟端口发送的广播数据包数量：2
     tx_vport_broadcast_bytes: 120  # 虚拟端口发送的广播数据字节数：120
     rx_vport_rdma_unicast_packets: 0  # 虚拟端口接收到的RDMA单播数据包数量：0
     rx_vport_rdma_unicast_bytes: 0  # 虚拟端口接收到的RDMA单播数据字节数：0
     tx_vport_rdma_unicast_packets: 0  # 虚拟端口发送的RDMA单播数据包数量：0
     tx_vport_rdma_unicast_bytes: 0  # 虚拟端口发送的RDMA单播数据字节数：0
     rx_vport_rdma_multicast_packets: 0  # 虚拟端口接收到的RDMA多播数据包数量：0
     rx_vport_rdma_multicast_bytes: 0  # 虚拟端口接收到的RDMA多播数据字节数：0
     tx_vport_rdma_multicast_packets: 0  # 虚拟端口发送的RDMA多播数据包数量：0
     tx_vport_rdma_multicast_bytes: 0  # 虚拟端口发送的RDMA多播数据字节数：0
     tx_packets_phy: 7222595  # 物理层发送的数据包数量：7222595
     rx_packets_phy: 15005729  # 物理层接收的数据包数量：15005729
     rx_crc_errors_phy: 386  # 物理层接收时CRC校验错误的数量：386 #持续上涨需要换网卡
     tx_bytes_phy: 865069388  # 物理层发送的数据字节数：865069388
     rx_bytes_phy: 2027206797  # 物理层接收的数据字节数：2027206797
     tx_multicast_phy: 542205  # 物理层发送的多播数据包数量：542205
     tx_broadcast_phy: 2  # 物理层发送的广播数据包数量：2
     rx_multicast_phy: 2110625  # 物理层接收的多播数据包数量：2110625
     rx_broadcast_phy: 959871  # 物理层接收的广播数据包数量：959871
     rx_in_range_len_errors_phy: 0  # 物理层接收时长度在允许范围内但发生错误的数据包数量：0
     rx_out_of_range_len_phy: 0  # 物理层接收时数据包长度超出允许范围的数量：0
     rx_oversize_pkts_phy: 0  # 物理层接收的超大数据包数量：0
     rx_symbol_err_phy: 386  # 物理层接收时的符号错误数量：386
     tx_mac_control_phy: 2  # 物理层发送的MAC控制帧数量：2
     rx_mac_control_phy: 0  # 物理层接收的MAC控制帧数量：0
     rx_unsupported_op_phy: 0  # 物理层接收的不支持操作的数量：0
     rx_pause_ctrl_phy: 0  # 物理层接收的暂停控制帧数量：0
     tx_pause_ctrl_phy: 2  # 物理层发送的暂停控制帧数量：2
     rx_discards_phy: 0  # 物理层丢弃的数据包数量：0
     tx_discards_phy: 0  # 物理层发送丢弃的数据包数量：0
     tx_errors_phy: 0  # 物理层发送错误的数量：0
     rx_undersize_pkts_phy: 0  # 物理层接收的过小数据包数量：0
     rx_fragments_phy: 0  # 物理层接收的碎片数据包数量：0
     rx_jabbers_phy: 0  # 物理层接收的抖动或严重损坏的数据包数量：0
     rx_64_bytes_phy: 990544  # 物理层接收的64字节数据包数量：990544
     rx_65_to_127_bytes_phy: 6478858  # 物理层接收的65到127字节数据包数量：6478858
     rx_128_to_255_bytes_phy: 7100507  # 物理层接收的128到255字节数据包数量：7100507
     rx_256_to_511_bytes_phy: 263939  # 物理层接收的256到511字节数据包数量：263939
     rx_512_to_1023_bytes_phy: 244  # 物理层接收的512到1023字节数据包数量：244
     rx_1024_to_1518_bytes_phy: 78892  # 物理层接收的1024到1518字节数据包数量：78892
     rx_1519_to_2047_bytes_phy: 92745  # 物理层接收的1519到2047字节数据包数量：92745
     rx_2048_to_4095_bytes_phy: 0  # 物理层接收的2048到4095字节数据包数量：0
     rx_4096_to_8191_bytes_phy: 0  # 物理层接收的4096到8191字节数据包数量：0
     rx_8192_to_10239_bytes_phy: 0  # 物理层接收的8192到10239字节数据包数量：0
     link_down_events_phy: 0  # 物理层链路断开事件的数量：0
     rx_pcs_symbol_err_phy: 386  # 物理层接收PCS（物理编码子系统）符号错误数量：386
     rx_corrected_bits_phy: 17750739  # 物理层接收后纠正的错误比特总数：17750739
     rx_err_lane_0_phy: 28116  # 物理层通道0接收错误的数量：28116
     rx_err_lane_1_phy: 0  # 物理层通道1接收错误的数量：0
     rx_err_lane_2_phy: 0  # 物理层通道2接收错误的数量：0
     rx_err_lane_3_phy: 17722623  # 物理层通道3接收错误的数量：17722623
     rx_buffer_passed_thres_phy: 0  # 物理层接收缓冲超过阈值的次数：0
     rx_pci_signal_integrity: 0  # PCI接收信号完整性错误的数量：0
     tx_pci_signal_integrity: 2  # PCI发送信号完整性错误的数量：2
     outbound_pci_stalled_rd: 0  # 出站PCI读操作阻塞的次数：0
     outbound_pci_stalled_wr: 0  # 出站PCI写操作阻塞的次数：0
     outbound_pci_stalled_rd_events: 0  # 出站PCI读阻塞事件的数量：0
     outbound_pci_stalled_wr_events: 0  # 出站PCI写阻塞事件的数量：0
     rx_prio0_bytes: 2027206797  # 优先级0接收数据字节数：2027206797
     rx_prio0_packets: 15005729  # 优先级0接收数据包数量：15005729
     rx_prio0_discards: 0  # 优先级0接收时丢弃的数据包数量：0
     tx_prio0_bytes: 865069260  # 优先级0发送数据字节数：865069260
     tx_prio0_packets: 7222593  # 优先级0发送数据包数量：7222593
     tx_pause_storm_warning_events: 0  # 发送暂停风暴警告事件的数量：0
     tx_pause_storm_error_events: 0  # 发送暂停风暴错误事件的数量：0
     module_unplug: 0  # 模块被拔出事件的数量：0
     module_bus_stuck: 0  # 模块总线卡住事件的数量：0
     module_high_temp: 0  # 模块高温事件的数量：0
     module_bad_shorted: 0  # 模块短路错误的数量：0
     ch0_events: 1230  # 通道0的事件总数量：1230
     ch0_poll: 1230  # 通道0的轮询次数：1230
     ch0_arm: 1230  # 通道0使能（arm）的次数：1230
     ch0_aff_change: 0  # 通道0亲和性变更事件的数量：0
     ch0_force_irq: 0  # 通道0强制中断事件的数量：0
     ch0_eq_rearm: 0  # 通道0事件队列重新使能的次数：0
     rx0_packets: 1213  # 通道0接收数据包数量：1213
     rx0_bytes: 72780  # 通道0接收数据字节数：72780
     rx0_csum_complete: 0  # 通道0接收时校验和完成的数据包数量：0
     rx0_csum_complete_tail: 0  # 通道0接收时尾部校验和完成的数据包数量：0
     rx0_csum_complete_tail_slow: 0  # 通道0接收时慢速尾部校验和完成的数据包数量：0
     rx0_csum_unnecessary: 0  # 通道0接收时无需校验和处理的数据包数量：0
     rx0_csum_unnecessary_inner: 0  # 通道0内部数据包无需校验和处理的数量：0
     rx0_csum_none: 1213  # 通道0接收时未做校验和处理的数据包数量：1213
     rx0_xdp_drop: 0  # 通道0XDP处理时丢弃的数据包数量：0
     rx0_xdp_redirect: 0  # 通道0XDP处理时重定向的数据包数量：0
     rx0_lro_packets: 0  # 通道0接收时大包合并（LRO）处理的数据包数量：0
     rx0_lro_bytes: 0  # 通道0接收时大包合并处理后的数据字节数：0
     rx0_ecn_mark: 0  # 通道0接收时标记了ECN的数据包数量：0
     rx0_removed_vlan_packets: 0  # 通道0接收时移除VLAN标签的数据包数量：0
     rx0_wqe_err: 0  # 通道0接收工作队列（WQE）错误的数量：0
     rx0_mpwqe_filler_cqes: 0  # 通道0接收多包队列填充时的完成队列事件数量：0
     rx0_mpwqe_filler_strides: 0  # 通道0接收多包队列填充时的步长计数：0
     rx0_oversize_pkts_sw_drop: 0  # 通道0接收时因数据包超大而被软件丢弃的数量：0
     rx0_buff_alloc_err: 0  # 通道0接收缓冲区分配错误的次数：0
     rx0_cqe_compress_blks: 0  # 通道0接收完成队列压缩块的数量：0
     rx0_cqe_compress_pkts: 0  # 通道0接收完成队列压缩数据包的数量：0
     rx0_cache_reuse: 1152  # 通道0接收缓存重用的次数：1152
     rx0_cache_full: 0  # 通道0接收缓存满的次数：0
     rx0_cache_empty: 0  # 通道0接收缓存为空的次数：0
     rx0_cache_busy: 0  # 通道0接收缓存忙碌的次数：0
     rx0_cache_waive: 0  # 通道0放弃使用接收缓存的次数：0
     rx0_cache_ext: 0  # 通道0扩展接收缓存使用的次数：0
     rx0_cache_rdc: 0  # 通道0接收缓存远程直接缓存（RDC）命中次数：0
     rx0_cache_alloc: 960  # 通道0接收缓存分配的次数：960
     rx0_congst_umr: 0  # 通道0接收中发生拥塞UMR事件的数量：0
     rx0_arfs_err: 0  # 通道0接收时ARFS错误的数量：0
     rx0_recover: 0  # 通道0接收过程中恢复操作的次数：0
     rx0_pet_hdr_lookup_drop: 0  # 通道0接收时因PET头查找失败而丢弃的数据包数量：0
     rx0_pet_mdata_lookup_drop: 0  # 通道0接收时因PET元数据查找失败而丢弃的数据包数量：0
     rx0_xdp_tx_xmit: 0  # 通道0XDP发送时通过TX传输的数据包数量：0
     rx0_xdp_tx_mpwqe: 0  # 通道0XDP发送时通过多包队列传输的数据包数量：0
     rx0_xdp_tx_inlnw: 0  # 通道0XDP发送时内联传输的数据包数量：0
     rx0_xdp_tx_nops: 0  # 通道0XDP发送时无操作的数据包数量：0
     rx0_xdp_tx_full: 0  # 通道0XDP发送时因队列满而传输失败的数据包数量：0
     rx0_xdp_tx_err: 0  # 通道0XDP发送时出错的数据包数量：0
     rx0_xdp_tx_cqes: 0  # 通道0XDP发送完成队列事件的数量：0
     tx0_packets: 6  # 通道0发送的数据包数量：6
     tx0_bytes: 516  # 通道0发送的数据字节数：516
     tx0_tso_packets: 0  # 通道0发送的TSO数据包数量：0
     tx0_tso_bytes: 0  # 通道0发送的TSO数据字节数：0
     tx0_tso_inner_packets: 0  # 通道0发送的内部TSO数据包数量：0
     tx0_tso_inner_bytes: 0  # 通道0发送的内部TSO数据字节数：0
     tx0_csum_partial: 0  # 通道0发送时部分校验和处理的数据包数量：0
     tx0_csum_partial_inner: 0  # 通道0发送时内部部分校验和处理的数据包数量：0
     tx0_added_vlan_packets: 0  # 通道0发送时添加VLAN标签的数据包数量：0
     tx0_nop: 0  # 通道0发送时无操作（NOP）数据包数量：0
     tx0_mpwqe_blks: 6  # 通道0发送多包队列工作块的数量：6
     tx0_mpwqe_pkts: 6  # 通道0发送多包队列中的数据包数量：6
     tx0_csum_none: 6  # 通道0发送时未进行校验和处理的数据包数量：6
     tx0_stopped: 0  # 通道0发送队列停止的次数：0
     tx0_dropped: 0  # 通道0发送队列丢弃的数据包数量：0
     tx0_xmit_more: 0  # 通道0发送时批量传输调用的次数：0
     tx0_recover: 0  # 通道0发送队列恢复操作的次数：0
     tx0_cqes: 6  # 通道0发送完成队列事件的数量：6
     tx0_cqe_compress_blks: 0  # 通道0发送完成队列压缩块的数量：0
     tx0_cqe_compress_pkts: 0  # 通道0发送完成队列压缩数据包的数量：0
     tx0_wake: 0  # 通道0发送队列被唤醒的次数：0
     tx0_cqe_err: 0  # 通道0发送完成队列中出现错误的数量：0
     tx0_xdp_xmit: 0  # 通道0XDP发送的数据包数量：0
     tx0_xdp_mpwqe: 0  # 通道0XDP多包队列发送的数据包数量：0
     tx0_xdp_inlnw: 0  # 通道0XDP内联发送的数据包数量：0
     tx0_xdp_nops: 0  # 通道0XDP无操作发送的数据包数量：0
     tx0_xdp_full: 0  # 通道0XDP发送时因队列满而失败的数据包数量：0
     tx0_xdp_err: 0  # 通道0XDP发送时出错的数据包数量：0
     tx0_xdp_cqes: 0  # 通道0XDP发送完成队列事件的数量：0
     rx_prio0_buf_discard: 0  # 优先级0接收时因缓冲区问题丢弃的数据包数量：0
     rx_prio0_cong_discard: 0  # 优先级0接收时因拥塞丢弃的数据包数量：0
     rx_prio0_marked: 0  # 优先级0接收时被标记的数据包数量（例如ECN标记）：0
```


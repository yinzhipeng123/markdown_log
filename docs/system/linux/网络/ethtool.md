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
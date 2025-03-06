

lldptool 使用

```bash
[root@~]# rpm -ql lldpad-1.0.1-5.git036e314.el7.x86_64 
/etc/bash_completion.d
/etc/bash_completion.d/lldpad
/etc/bash_completion.d/lldptool
/usr/lib/systemd/system/lldpad.service
/usr/lib/systemd/system/lldpad.socket
/usr/lib64/liblldp_clif.so.1
/usr/lib64/liblldp_clif.so.1.0.0
/usr/sbin/dcbtool
/usr/sbin/lldpad
/usr/sbin/lldptool
/usr/sbin/vdptool
/usr/share/doc/lldpad-1.0.1
/usr/share/doc/lldpad-1.0.1/COPYING
/usr/share/doc/lldpad-1.0.1/ChangeLog
/usr/share/doc/lldpad-1.0.1/README
/usr/share/man/man3/liblldp_clif-vdp22.3.gz
/usr/share/man/man8/dcbtool.8.gz
/usr/share/man/man8/lldpad.8.gz
/usr/share/man/man8/lldptool-app.8.gz
/usr/share/man/man8/lldptool-dcbx.8.gz
/usr/share/man/man8/lldptool-ets.8.gz
/usr/share/man/man8/lldptool-evb.8.gz
/usr/share/man/man8/lldptool-evb22.8.gz
/usr/share/man/man8/lldptool-med.8.gz
/usr/share/man/man8/lldptool-pfc.8.gz
/usr/share/man/man8/lldptool-vdp.8.gz
/usr/share/man/man8/lldptool.8.gz
/usr/share/man/man8/vdptool.8.gz
/var/lib/lldpad
```



启动 `lldpad` 服务：

为了让 `lldptool` 正常工作，需要先启动 `lldpad` 服务。可以通过以下命令启动 `lldpad`：

```bash
sudo systemctl start lldpad
```

如果需要确保它在系统启动时自动启动：

```bash
sudo systemctl enable lldpad
```

- **`lldpad`** 必须运行，才能让 **`lldptool`** 正常工作。
- 如果 `lldpad` 没有启动，`lldptool` 会无法获取或修改 LLDP 信息。





```bash
[root@~]# lldptool -t -n -i eth0 
Chassis ID TLV
    MAC: 5c:f7:96:93:18:45               # 设备的 MAC 地址，用于唯一标识设备
Port ID TLV
    Ifname: FourHundredGigE1/0/127      # 网络接口的名称，表示具体的端口
Time to Live TLV
    121                                   # LLDP 数据包的生存时间，单位是秒
Port Description TLV
    FourHundredGigE1/0/127 Interface      # 端口描述信息，说明该端口的功能或名称
System Name TLV
    ZWLTH3P04-IBG-10A-S9827-128DH    # 系统名称，通常是设备的主机名或标识符
System Description TLV
    H3C Comware Platform Software, Software Version 9.1.058, Ess 9320P01   # 系统描述，包括设备的软件平台和版本信息
    H3C S9827-128DH
    Copyright (c) 2004-2024 New H3C Technologies Co., Ltd. All rights reserved.
System Capabilities TLV
    System capabilities:  Bridge, Router    # 系统的功能能力，表示设备是否能作为桥接器、路由器等
    Enabled capabilities: Bridge, Router    # 启用的功能能力，列出当前启用的功能
Management Address TLV
    IPv4: 100.110.3.105                   # 设备的管理 IP 地址
    Ifindex: 129                           # 网络接口的索引 ID，标识具体的接口
Port VLAN ID TLV
    PVID: 100                              # 端口的默认 VLAN ID，表示该端口所属的 VLAN
Link Aggregation TLV
    Aggregation capable                    # 支持链路聚合
    Currently not aggregated               # 当前未进行链路聚合
    Aggregated Port ID: 0                  # 聚合端口的 ID，若未聚合则为 0
MAC/PHY Configuration Status TLV
    Auto-negotiation supported and enabled # 自动协商功能是否支持并启用
    PMD auto-negotiation capabilities: 0x0000  # PMD (物理媒介依赖) 的自动协商能力
    MAU type: Unknown [0x0000]             # MAU (多路访问单元) 类型，未知
Power via MDI TLV
    Port class PD                          # 端口的电力类别，表示该端口是否支持 PoE (Power over Ethernet)
    PSE MDI power not supported            # PSE (供电设备) 不支持 MDI 电力
    PSE pairs not controllable             # PSE 无法控制电力对
    PSE Power pair: signal                 # PSE 电力对为信号对
    Power class 2                          # 电力类别 2，指示支持的电力范围
Maximum Frame Size TLV
    9216                                  # 该端口支持的最大帧大小，单位是字节
End of LLDPDU TLV                         # LLDP 数据单元的结束标志
```




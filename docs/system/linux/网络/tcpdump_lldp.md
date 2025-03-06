s抓包查看网口连接的交换机信息

```bash
#tcpdump -i p0 -env ether proto 0x88cc 
```

### 参数解析：

- `tcpdump`：网络数据包抓取工具。
- `-i p0`：指定接口 `p0` 进行抓包。
- `-e`：显示链路层头部信息（包括源 MAC、目的 MAC 等）。
- `-n`：不解析 IP 地址和端口号为主机名。
- `-v`：增加输出的详细信息。
- `ether proto 0x88cc`：仅抓取 **以太网协议类型为 `0x88cc`** 的数据包，`0x88cc` 对应 **LLDP（Link Layer Discovery Protocol）**。



```bash
#tcpdump -i p0 -env ether proto 0x88cc 
16:07:14.929849 40:73:4d:2c:2f:7e > 01:80:c2:00:00:0e, ethertype LLDP (0x88cc), length 364: LLDP, length 350  # 时间戳：数据包捕获时间；源MAC -> 目标MAC；LLDP协议数据包，总长度350字节
	Chassis ID TLV (1), length 7  # 设备标识TLV（类型1），长度7字节
	  Subtype MAC address (4): 40:73:4d:2c:2f:20  # 子类型为MAC地址，标识设备的MAC（交换机背板MAC）
	Port ID TLV (2), length 18  # 端口标识TLV（类型2），长度18字节
	  Subtype Interface Name (5): HundredGigE1/0/12  # 子类型为接口名称，标识物理端口名（100G接口1/0/12）
	Time to Live TLV (3), length 2: TTL 121s  # 存活时间TLV（类型3），该LLDP信息有效期121秒
	Port Description TLV (4), length 27: HundredGigE1/0/12 Interface  # 端口描述TLV（类型4），描述接口信息
	System Name TLV (5), length 28: NX-ZWLTC2P07-IB-03A-S985032H  # 系统名称TLV（类型5），交换机主机名
	System Description TLV (6), length 161  # 系统描述TLV（类型6），长度161字节
	  H3C Comware Platform Software, Software Version 7.1.070, Release 6715\0x0d\0x0aH3C S9850-32H\0x0d\0x0aCopyright (c) 2004-2024 New H3C Technologies Co., Ltd. All rights reserved.  # 系统软件版本（H3C Comware V7）、设备型号（S9850-32H）
	System Capabilities TLV (7), length 4  # 系统能力TLV（类型7），长度4字节
	  System  Capabilities [Bridge, Router] (0x0314)  # 设备支持桥接（二层）和路由（三层）功能
	  Enabled Capabilities [Bridge, Router] (0x0114)  # 当前启用了桥接和路由功能
	Management Address TLV (8), length 12  # 管理地址TLV（类型8），长度12字节
	  Management Address length 5, AFI IPv4 (1): 100.110.13.231  # IPv4管理地址：100.110.13.231
	  Interface Index Interface Numbering (2): 2146  # 关联接口索引号2146（对应端口逻辑标识）
	Management Address TLV (8), length 24  # 另一个管理地址TLV
	  Management Address length 17, AFI IPv6 (2): 240c:4044:2207:500::defa  # IPv6管理地址：240c:4044:2207:500::defa
	  Interface Index Interface Numbering (2): 2152  # 关联接口索引号2152
	Organization specific TLV (127), length 6: OUI Ethernet bridged (0x0080c2)  # 厂商自定义TLV（类型127），OUI标识厂商
	  Port VLAN Id Subtype (1)  # 子类型1（端口VLAN ID）
	    port vlan id (PVID): 100  # 端口PVID（Native VLAN）为100
	Organization specific TLV (127), length 9: OUI Ethernet bridged (0x0080c2)  # 另一个自定义TLV
	  unknown Subtype (7)  # 未知子类型7，可能为厂商私有扩展
	  0x0000:  0080 c207 0300 0008 74  # 原始十六进制数据（具体含义需厂商文档）
	Organization specific TLV (127), length 9: OUI IEEE 802.3 Private (0x00120f)  # IEEE 802.3私有扩展TLV
	  MAC/PHY configuration/status Subtype (1)  # 子类型1（MAC/PHY配置状态）
	    autonegotiation [supported, enabled] (0x03)  # 自动协商已启用且支持
	    PMD autoneg capability [unknown] (0x0000)  # 物理介质相关自动协商能力未知
	    MAU type unknown (0x004d)  # 介质相关单元类型未知（0x004d为H3C私有值）
	Organization specific TLV (127), length 7: OUI IEEE 802.3 Private (0x00120f)  # 另一个IEEE 802.3扩展TLV
	  Power via MDI Subtype (2)  # 子类型2（通过MDI供电）
	    MDI power support [none], power pair signal, power class class0  # 不支持PoE供电
	Organization specific TLV (127), length 6: OUI IEEE 802.3 Private (0x00120f)  # 最大帧长TLV
	  Max frame size Subtype (4)  # 子类型4（最大帧尺寸）
	    MTU size 9416  # 接口支持的最大MTU为9416字节（巨型帧）
	End TLV (0), length 0  # 结束TLV（类型0），标识LLDP报文结束
```





```bash
#tcpdump -i p1 -env ether proto 0x88cc 
16:31:53.137222 bc:31:e2:02:43:86 > 01:80:c2:00:00:0e, ethertype LLDP (0x88cc), length 338: LLDP, length 324  # 时间戳：数据包捕获时间；源MAC -> 目标MAC；LLDP协议数据包，总长度324字节
	Chassis ID TLV (1), length 7  # 设备标识TLV（类型1），长度7字节
	  Subtype MAC address (4): bc:31:e2:02:43:28  # 子类型为MAC地址，标识设备的MAC（交换机背板MAC）
	Port ID TLV (2), length 18  # 端口标识TLV（类型2），长度18字节
	  Subtype Interface Name (5): HundredGigE1/0/12  # 子类型为接口名称，标识物理端口名（100G接口1/0/12）
	Time to Live TLV (3), length 2: TTL 121s  # 存活时间TLV（类型3），该LLDP信息有效期121秒
	Port Description TLV (4), length 27: HundredGigE1/0/12 Interface  # 端口描述TLV（类型4），描述接口信息
	System Name TLV (5), length 28: NX-ZWLTC2P07-IB-03B-S985032H  # 系统名称TLV（类型5），交换机主机名（与前一设备编号03A不同，应为集群节点B）
	System Description TLV (6), length 161  # 系统描述TLV（类型6），长度161字节
	  H3C Comware Platform Software, Software Version 7.1.070, Release 6710\0x0d\0x0aH3C S9850-32H\0x0d\0x0aCopyright (c) 2004-2022 New H3C Technologies Co., Ltd. All rights reserved.  # 系统软件版本（H3C Comware V7，Release 6710，比前一设备低）、设备型号相同但版权年份较早
	System Capabilities TLV (7), length 4  # 系统能力TLV（类型7），长度4字节
	  System  Capabilities [Bridge, Router] (0x0314)  # 设备支持桥接（二层）和路由（三层）功能
	  Enabled Capabilities [Bridge, Router] (0x0114)  # 当前启用了桥接和路由功能
	Management Address TLV (8), length 12  # 管理地址TLV（类型8），长度12字节
	  Management Address length 5, AFI IPv4 (1): 100.110.13.232  # IPv4管理地址：100.110.13.232（比前一设备地址+1，可能是HA双机地址）
	  Interface Index Interface Numbering (2): 2146  # 关联接口索引号2146（与前一设备相同，可能为堆叠端口）
	Organization specific TLV (127), length 6: OUI Ethernet bridged (0x0080c2)  # 厂商自定义TLV（类型127），OUI标识厂商
	  Port VLAN Id Subtype (1)  # 子类型1（端口VLAN ID）
	    port vlan id (PVID): 100  # 端口PVID（Native VLAN）为100（与前一设备一致）
	Organization specific TLV (127), length 9: OUI Ethernet bridged (0x0080c2)  # 另一个自定义TLV
	  unknown Subtype (7)  # 未知子类型7，可能为厂商私有扩展
	  0x0000:  0080 c207 0300 0008 75  # 原始十六进制数据（末尾75可能与设备序列相关）
	Organization specific TLV (127), length 9: OUI IEEE 802.3 Private (0x00120f)  # IEEE 802.3私有扩展TLV
	  MAC/PHY configuration/status Subtype (1)  # 子类型1（MAC/PHY配置状态）
	    autonegotiation [supported, enabled] (0x03)  # 自动协商已启用且支持
	    PMD autoneg capability [unknown] (0x0000)  # 物理介质相关自动协商能力未知
	    MAU type unknown (0x004d)  # 介质相关单元类型未知（与前一设备相同，H3C私有定义）
	Organization specific TLV (127), length 7: OUI IEEE 802.3 Private (0x00120f)  # 另一个IEEE 802.3扩展TLV
	  Power via MDI Subtype (2)  # 子类型2（通过MDI供电）
	    MDI power support [none], power pair signal, power class class0  # 不支持PoE供电（与前一设备一致）
	Organization specific TLV (127), length 6: OUI IEEE 802.3 Private (0x00120f)  # 最大帧长TLV
	  Max frame size Subtype (4)  # 子类型4（最大帧尺寸）
	    MTU size 9416  # 接口支持的最大MTU为9416字节（巨型帧配置与前一设备相同）
	End TLV (0), length 0  # 结束TLV（类型0），标识LLDP报文结束
```


**网卡绑定（NIC Bonding 或 Network Bonding）**是指将多块网络接口卡（NIC）绑定在一起，以实现更高的网络吞吐量、更好的冗余性和可靠性。常见于Linux系统中的网卡绑定通过内核支持的多种模式来实现。

### **网卡绑定的常见模式**
1. **mode=0（balance-rr，轮询模式）**  
   - 数据包按顺序轮流发送到所有绑定的网卡上。
   - 优点：负载均衡，能提高带宽利用率。
   - 缺点：需要交换机的支持（通常需要配置链路聚合），容易导致数据包乱序。

2. **mode=1（active-backup，主备模式）**  
   - 一个网卡处于活跃状态，另一个网卡处于备用状态。
   - 优点：高可靠性，冗余性强，不需要交换机支持。
   - 缺点：无法提升带宽。

3. **mode=2（balance-xor，异或负载均衡）**  
   - 根据MAC地址或IP地址的哈希值选择网卡发送数据。
   - 优点：负载均衡，可以和普通交换机配合使用。
   - 缺点：需要均匀分布的流量源才有效果。

4. **mode=3（broadcast，广播模式）**  
   - 所有数据包通过所有绑定的网卡发送。
   - 优点：高可靠性，适合需要高容错的场景。
   - 缺点：带宽浪费，不适合高性能场景。

5. **mode=4（802.3ad，动态链路聚合）**  
   - 基于IEEE 802.3ad标准的链路聚合。
   - 优点：支持负载均衡和故障切换，吞吐量大，适合需要高性能的场景。
   - 缺点：交换机必须支持并配置802.3ad链路聚合。

6. **mode=5（balance-tlb，自适应传输负载均衡）**  
   - 出站流量根据当前的负载自动选择网卡，入站流量由被动ARP协商实现。
   - 优点：不需要特殊交换机支持。
   - 缺点：对入站流量的优化有限。

7. **mode=6（balance-alb，自适应负载均衡）**  
   - 提供出站和入站的负载均衡，入站通过ARP协商。
   - 优点：不需要交换机支持，负载均衡效果好。
   - 缺点：需要客户端支持ARP协商。

---

### **网卡绑定的优点**
1. **高可用性（HA）：**  
   - 如果一块网卡或连接线路发生故障，流量会自动切换到其他网卡，保证网络不中断。
   
2. **负载均衡：**  
   - 提高网络带宽利用率，分散流量压力，提升整体性能。
   
3. **简单的配置管理：**  
   - 将多块网卡绑定后对外表现为一个逻辑网卡，方便管理和使用。

---

### **网卡绑定的配置**
在Linux系统中，网卡绑定通常通过`bonding`内核模块和配置文件来实现。

#### 1. **加载bonding模块**
```bash
modprobe bonding
```

#### 2. **配置绑定**
假设绑定的网卡为`eth0`和`eth1`，配置文件路径为 `/etc/sysconfig/network-scripts/`：

- 编辑`ifcfg-bond0`：
  ```bash
  DEVICE=bond0
  BOOTPROTO=none
  ONBOOT=yes
  BONDING_OPTS="mode=1 miimon=100"
  IPADDR=192.168.1.100
  NETMASK=255.255.255.0
  GATEWAY=192.168.1.1
  ```

- 编辑`ifcfg-eth0`和`ifcfg-eth1`：
  ```bash
  DEVICE=eth0
  BOOTPROTO=none
  ONBOOT=yes
  MASTER=bond0
  SLAVE=yes
  ```

  ```bash
  DEVICE=eth1
  BOOTPROTO=none
  ONBOOT=yes
  MASTER=bond0
  SLAVE=yes
  ```

#### 3. **重启网络服务**
```bash
systemctl restart network
```

---

### **验证绑定状态**
可以使用以下命令查看绑定状态：
```bash
cat /proc/net/bonding/bond0
```

**输出示例：**
```
Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)

Bonding Mode: fault-tolerance (active-backup)
Primary Slave: None
Currently Active Slave: eth0
MII Status: up
MII Polling Interval (ms): 100
Up Delay (ms): 0
Down Delay (ms): 0

Slave Interface: eth0
MII Status: up
Link Failure Count: 0
Permanent HW addr: xx:xx:xx:xx:xx:xx

Slave Interface: eth1
MII Status: up
Link Failure Count: 0
Permanent HW addr: xx:xx:xx:xx:xx:xx
```

通过这种方式，可以确认网卡绑定模式和各网卡的运行状态。





```
[root@~]# cat /proc/net/bonding/bond0
Ethernet Channel Bonding Driver: v5.10.0-3.0.0.0_rc1  # 以太网通道绑定驱动程序的版本号。

Bonding Mode: IEEE 802.3ad Dynamic link aggregation  # 绑定模式为 IEEE 802.3ad 动态链路聚合（LACP 协议）。
Transmit Hash Policy: layer3+4 (1)  # 负载均衡策略，基于三层（IP）和四层（端口）的哈希算法。
MII Status: up  # 链路总体状态为 up，表示活跃且正常运行。
MII Polling Interval (ms): 100  # 链路状态检查的时间间隔，单位为毫秒。
Up Delay (ms): 0  # 链路恢复后延迟多长时间（毫秒）才被认为状态为 up。
Down Delay (ms): 0  # 链路失败后延迟多长时间（毫秒）才被认为状态为 down。
Peer Notification Delay (ms): 0  # 链路状态变化后向对端发送通知的延迟时间，单位为毫秒。

802.3ad info  # IEEE 802.3ad 协议的相关信息部分。
LACP rate: slow  # LACP 报文的发送速率，slow 表示每 30 秒发送一次。
Min links: 0  # 设定的最小活跃链路数，此处为 0 表示未配置。
Aggregator selection policy (ad_select): stable  # 聚合器的选择策略，此处为稳定模式（stable）。
System priority: 65535  # 本系统的优先级，数值越低优先级越高。
System MAC address: 9c:63:c0:b8:ff:0a  # 绑定接口使用的系统 MAC 地址。
Active Aggregator Info:  # 当前活跃的聚合器信息。
	Aggregator ID: 1  # 聚合器 ID，为 1。
	Number of ports: 1  # 当前聚合器中活跃的端口数量为 1。
	Actor Key: 29  # 本端的密钥，用于与对端配对。
	Partner Key: 50027  # 对端的密钥，用于配对。
	Partner Mac Address: 00:00:5e:00:01:01  # 对端的 MAC 地址。

Slave Interface: p0  # 子接口 p0 的信息。
MII Status: up  # p0 接口的链路状态为 up，表示活跃。
Speed: 100000 Mbps  # 接口的速度为 100 Gbps。
Duplex: full  # 双工模式为全双工。
Link Failure Count: 0  # 链路失败的次数为 0。
Permanent HW addr: 9c:63:c0:b8:ff:0a  # 该接口的永久硬件地址。
Slave queue ID: 0  # 该接口的队列 ID。
Aggregator ID: 1  # 该接口属于聚合器 ID 为 1。
Actor Churn State: none  # 本端的抖动状态为无。
Partner Churn State: none  # 对端的抖动状态为无。
Actor Churned Count: 0  # 本端的抖动计数为 0。
Partner Churned Count: 0  # 对端的抖动计数为 0。
details actor lacp pdu:  # 本端 LACP PDU 的详细信息。
    system priority: 65535  # 系统优先级。
    system mac address: 9c:63:c0:b8:ff:0a  # 系统 MAC 地址。
    port key: 29  # 端口密钥。
    port priority: 255  # 端口优先级。
    port number: 1  # 端口编号。
    port state: 61  # 端口状态，十六进制 61 表示活跃且聚合。
details partner lacp pdu:  # 对端 LACP PDU 的详细信息。
    system priority: 200  # 对端系统优先级。
    system mac address: 00:00:5e:00:01:01  # 对端系统 MAC 地址。
    oper key: 50027  # 对端操作密钥。
    port priority: 32768  # 对端端口优先级。
    port number: 16403  # 对端端口编号。
    port state: 61  # 对端端口状态，十六进制 61 表示活跃且聚合。

Slave Interface: p1  # 子接口 p1 的信息。
MII Status: down  # p1 接口的链路状态为 down，表示不活跃。
Speed: Unknown  # 链路速度未知。
Duplex: Unknown  # 双工模式未知。
Link Failure Count: 0  # 链路失败的次数为 0。
Permanent HW addr: 9c:63:c0:b8:ff:0b  # 该接口的永久硬件地址。
Slave queue ID: 0  # 该接口的队列 ID。
Aggregator ID: 2  # 该接口属于聚合器 ID 为 2。
Actor Churn State: churned  # 本端的抖动状态为 churned（有抖动）。
Partner Churn State: churned  # 对端的抖动状态为 churned（有抖动）。
Actor Churned Count: 1  # 本端的抖动计数为 1。
Partner Churned Count: 1  # 对端的抖动计数为 1。
details actor lacp pdu:  # 本端 LACP PDU 的详细信息。
    system priority: 65535  # 系统优先级。
    system mac address: 9c:63:c0:b8:ff:0a  # 系统 MAC 地址。
    port key: 0  # 端口密钥。
    port priority: 255  # 端口优先级。
    port number: 2  # 端口编号。
    port state: 69  # 端口状态，十六进制 69 表示失效但未聚合。
details partner lacp pdu:  # 对端 LACP PDU 的详细信息。
    system priority: 65535  # 对端系统优先级。
    system mac address: 00:00:00:00:00:00  # 对端系统 MAC 地址为空。
    oper key: 1  # 对端操作密钥。
    port priority: 255  # 对端端口优先级。
    port number: 1  # 对端端口编号。
    port state: 1  # 对端端口状态，十六进制 1 表示无效。

```



**Aggregator ID 可以被视为 bond 接口的"身份证"**：

- **Aggregator ID** 是用于标识属于同一个聚合组的物理接口（Slave Interfaces）的标识符。
- **一个 bond 的所有 Slave Interfaces 的 Aggregator ID 通常应该一致**，这表明这些物理接口确实被正确地聚合在同一个逻辑接口（bond）中。

如果某些 Slave Interfaces 的 Aggregator ID 与其他接口不同，可能是以下原因：

- 该接口未成功加入到 LACP 聚合组。
- 对端设备（交换机）配置不匹配，导致链路协商失败。
- 接口物理状态（如链路断开或速度/双工模式不匹配）异常。
- 系统或网络配

**Aggregator ID** 通常是由系统自动分配的
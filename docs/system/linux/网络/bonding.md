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
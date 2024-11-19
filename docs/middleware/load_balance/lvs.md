**LVS（Linux Virtual Server）** 是一个开源的负载均衡解决方案，用于实现高性能、高可用性的服务集群。它是 Linux 操作系统的一部分，由中国开发者章文嵩博士开发。LVS 基于 IP 层工作，利用 IP 路由机制将客户端的请求分发到后端的真实服务器上，从而提升系统的处理能力和服务稳定性。

### LVS 的核心概念
1. **负载均衡调度器**（Director Server）：运行 LVS 的服务器，负责接收客户端请求，并根据调度算法将请求分发给后端真实服务器。
2. **真实服务器**（Real Server）：实际处理客户端请求的服务器。
3. **VIP（Virtual IP Address）**：负载均衡器的虚拟 IP，用户通过它访问服务。
4. **DIP（Director IP Address）**：负载均衡器的内部 IP。
5. **RIP（Real Server IP Address）**：真实服务器的 IP 地址。

### LVS 的工作模式
1. **NAT 模式**（Network Address Translation）：调度器通过 NAT 将请求和响应流量转发，适合小规模网络。
2. **DR 模式**（Direct Routing）：调度器只处理请求流量，响应流量直接从真实服务器返回客户端，性能更高。
3. **TUN 模式**（IP Tunneling）：用于广域网场景，通过隧道转发请求。

---

### 在 CentOS 7 上部署 LVS
以下是基于 DR 模式的简单部署步骤：

#### 1. 环境准备
- 一台 LVS 调度器（Director Server）
- 多台真实服务器（Real Servers）
- 确保所有服务器可以相互通信

#### 2. 安装必要的软件
```bash
sudo yum install -y ipvsadm
```

#### 3. 配置 LVS 调度器
编辑 LVS 配置文件，设置 VIP 和调度规则。
```bash
ip addr add 192.168.1.100/24 dev eth0  # 配置 VIP
```

设置转发规则：
```bash
echo 1 > /proc/sys/net/ipv4/ip_forward  # 开启 IP 转发
ipvsadm -A -t 192.168.1.100:80 -s rr    # 添加虚拟服务，设置为轮询调度
ipvsadm -a -t 192.168.1.100:80 -r 192.168.1.101:80 -g  # 添加后端真实服务器
ipvsadm -a -t 192.168.1.100:80 -r 192.168.1.102:80 -g
```

#### 4. 配置真实服务器
真实服务器需要配置为支持 ARP 抑制，以避免网络冲突。
在每台真实服务器上执行以下步骤：

1. 配置 loopback 接口：
```bash
ip addr add 192.168.1.100/32 dev lo
ifconfig lo up
```

2. 禁用 ARP 响应：
```bash
echo 1 > /proc/sys/net/ipv4/conf/lo/arp_ignore
echo 2 > /proc/sys/net/ipv4/conf/lo/arp_announce
echo 1 > /proc/sys/net/ipv4/conf/all/arp_ignore
echo 2 > /proc/sys/net/ipv4/conf/all/arp_announce
```

#### 5. 验证 LVS 配置
- 在客户端访问 `http://192.168.1.100`，请求会被分发到后端的真实服务器。
- 使用 `ipvsadm -L -n` 查看 LVS 状态和流量分布。

---





如果 **LVS 调度器的 `eth0` 网络接口已经配置了一个 IP 地址**（通常是 DIP，即调度器自己的 IP 地址），可以通过以下方式为 `eth0` 添加一个虚拟 IP 地址（VIP），以避免覆盖现有的 IP 配置，同时确保负载均衡正常工作。

---

### 方法 1：使用 `ip addr` 添加 VIP

1. **查看现有 IP 配置**：
   ```bash
   ip addr show eth0
   ```
   假设现有的 IP 地址为 `192.168.1.50/24`。

2. **为 `eth0` 添加虚拟 IP 地址 (VIP)**：
   ```bash
   ip addr add 192.168.1.100/24 dev eth0 label eth0:0
   ```
   - `192.168.1.100` 是 VIP。
   - `eth0:0` 是虚拟接口的别名（非必需，但便于管理）。

3. **验证 VIP 是否成功添加**：
   ```bash
   ip addr show eth0
   ```
   输出中应该包含类似以下内容：
   ```
   inet 192.168.1.50/24 scope global eth0
   inet 192.168.1.100/24 scope global secondary eth0:0
   ```

4. **永久生效（可选）**：
   编辑网络配置文件：
   ```bash
   sudo vi /etc/sysconfig/network-scripts/ifcfg-eth0:0
   ```
   内容如下：
   ```bash
   DEVICE=eth0:0
   BOOTPROTO=static
   IPADDR=192.168.1.100
   NETMASK=255.255.255.0
   ONBOOT=yes
   ```
   重启网络服务：
   ```bash
   sudo systemctl restart network
   ```

---

### 方法 2：直接绑定 VIP 而不使用别名

如果不需要 `eth0:0` 别名，直接用 `ip addr` 添加 VIP：
```bash
ip addr add 192.168.1.100/24 dev eth0
```

这种方法直接将 VIP 添加到 `eth0` 接口下，不影响已有的 IP 地址。

---

### 配置 LVS 时的注意事项

1. **确保 VIP 配置优先级正确**：
   LVS 负载均衡工作时会监听 VIP，如果 VIP 的配置被修改或删除，可能导致负载均衡失效。因此，确保 VIP 配置正确且不会冲突。

2. **禁用 ARP 响应（防止 ARP 冲突）**：
   LVS 调度器和真实服务器都可能需要禁用 ARP 对 VIP 的响应，以避免网络混乱。
   ```bash
   echo 1 > /proc/sys/net/ipv4/conf/all/arp_ignore
   echo 2 > /proc/sys/net/ipv4/conf/all/arp_announce
   echo 1 > /proc/sys/net/ipv4/conf/eth0/arp_ignore
   echo 2 > /proc/sys/net/ipv4/conf/eth0/arp_announce
   ```

3. **测试负载均衡**：
   配置 LVS 后，用客户端访问 VIP，确认请求是否正常分发到后端服务器。

---

### 验证与调试

- 查看 LVS 配置状态：
  ```bash
  ipvsadm -L -n
  ```

- 查看 VIP 是否能正确接收流量：
  使用工具如 `tcpdump` 检查流量是否到达调度器：
  ```bash
  tcpdump -i eth0 host 192.168.1.100
  ```

- 确保防火墙规则允许流量：
  ```bash
  sudo firewall-cmd --add-service=http --permanent
  sudo firewall-cmd --reload
  ```

按照以上步骤处理后，`eth0` 原有的 IP 地址不会被覆盖，且 LVS 调度器可以正常工作。





## LVS 提供了三种工作模式的工作原理

LVS 提供了三种工作模式，分别是 **NAT 模式（Network Address Translation）**、**DR 模式（Direct Routing）** 和 **TUN 模式（IP Tunneling）**。每种模式在实现原理和适用场景上各有特点。以下是详细讲解：

---

### **1. NAT 模式（Network Address Translation）**
#### **工作原理**：
- 客户端请求首先到达 LVS 负载均衡器。
- LVS 通过网络地址转换（NAT）将请求转发到后端服务器（Real Server）。
- 后端服务器处理请求后，将响应数据通过 LVS 负载均衡器再返回给客户端。

#### **数据流方向**：
1. **客户端 → LVS**（请求）  
   LVS 修改目标 IP 地址为后端服务器的 IP，并转发。
2. **后端服务器 → LVS → 客户端**（响应）  
   LVS 修改源 IP 地址为虚拟 IP（VIP），再发给客户端。

#### **优点**：
- 简单易用，后端服务器可以使用私有 IP，隐藏在 LVS 后面。
- 无需额外网络配置，适合内网环境。

#### **缺点**：
- LVS 需要处理双向流量（请求和响应），性能瓶颈可能出现在 LVS。
- 适用于流量较小的场景。

#### **适用场景**：
- 后端服务器在内网，客户端无法直接访问。
- 需要对后端服务器 IP 做隐蔽处理。

---

### **2. DR 模式（Direct Routing）**
#### **工作原理**：
- 客户端请求首先到达 LVS 负载均衡器。
- LVS 将请求的目标 MAC 地址修改为目标后端服务器的 MAC 地址，并通过本地网络直接发给后端服务器。
- 后端服务器直接将响应数据返回给客户端，而无需经过 LVS。

#### **数据流方向**：
1. **客户端 → LVS → 后端服务器**（请求）  
   LVS 修改目标 MAC 地址，并通过二层网络（同网段）将请求发给后端服务器。
2. **后端服务器 → 客户端**（响应）  
   响应数据不经过 LVS，直接从后端服务器返回客户端。

#### **优点**：
- LVS 仅处理请求流量，响应流量直接由后端服务器返回客户端，性能高。
- 适合高流量场景。

#### **缺点**：
- LVS 和后端服务器需要在同一二层网络（同网段）。
- 后端服务器需要绑定虚拟 IP（VIP）并配置特殊的网络设置。

#### **适用场景**：
- 高流量、大规模分布式系统。
- LVS 和后端服务器在同一局域网中。

---

### **3. TUN 模式（IP Tunneling）**
#### **工作原理**：
- 客户端请求到达 LVS 负载均衡器。
- LVS 使用 IP 隧道（IP-in-IP）将请求封装并转发到远程的后端服务器。
- 后端服务器解封装请求并处理后，直接将响应数据返回给客户端。

#### **数据流方向**：
1. **客户端 → LVS → 后端服务器**（请求）  
   LVS 使用 IP 隧道将请求转发给后端服务器。
2. **后端服务器 → 客户端**（响应）  
   响应数据直接返回客户端，无需经过 LVS。

#### **优点**：
- LVS 仅处理请求流量，响应流量直接返回，性能高。
- 后端服务器可以在不同的地理位置或网络中，扩展性强。

#### **缺点**：
- 后端服务器必须支持 IP 隧道协议（通常需要开启 Linux 的 TUN/TAP 模块）。
- 网络配置相对复杂。

#### **适用场景**：
- 后端服务器分布在不同的网络中（跨地域负载均衡）。
- 需要支持跨广域网的请求分发。

---

### **对比总结**
| 特性           | **NAT 模式**       | **DR 模式**              | **TUN 模式**             |
| -------------- | ------------------ | ------------------------ | ------------------------ |
| **性能**       | 受 LVS 性能限制    | LVS 只处理请求，性能较高 | LVS 只处理请求，性能较高 |
| **网络要求**   | 后端服务器可在内网 | 必须在同一二层网络       | 后端服务器可分布在广域网 |
| **配置复杂度** | 简单               | 中等                     | 较高                     |
| **适用场景**   | 内网小规模负载均衡 | 局域网内高流量场景       | 跨网络、跨地域场景       |

---

### **选择建议**
- **NAT 模式**：适合小型内网应用，配置简单。
- **DR 模式**：适合局域网内高性能负载均衡，推荐大部分场景使用。
- **TUN 模式**：适合需要地理分布的服务器或跨网络的复杂场景。

根据实际需求选择合适的模式，可以最大化 LVS 的性能和可用性。
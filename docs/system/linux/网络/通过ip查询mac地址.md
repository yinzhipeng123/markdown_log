



前提，在同一局域网下：

```\
[root@myserver ~]#arp -n 192.168.1.11   #通过arp命令查询ip对应的mac地址
192.168.1.11 (192.168.1.11) -- no entry  # 无结果


[root@myserver ~]#ping 192.168.1.11  #ping目标机器
PING 192.168.1.11 (192.168.1.11) 56(84) bytes of data.
64 bytes from 192.168.1.11: icmp_seq=1 ttl=63 time=0.806 ms
64 bytes from 192.168.1.11: icmp_seq=2 ttl=63 time=0.184 ms
^C
--- 192.168.1.11 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1016ms
rtt min/avg/max/mdev = 0.184/0.495/0.806/0.311 ms


[root@myserver ~]#arp -n 192.168.1.11  # 查询出来结果了
Address                  HWtype  HWaddress           Flags Mask            Iface
192.168.1.11             ether   00:00:5e:00:01:01   C                     bond0
```



arp -n 结果展示：

**Address**：这是目标主机的IP地址（在你的例子中是 `10.29.124.24`）。

**HWtype**：表示硬件类型，通常是 `ether`，表示以太网（Ethernet）设备。

**HWaddress**：这是目标主机的MAC地址（在你的例子中是 `00:00:5e:00:01:01`）。它是与IP地址相关联的物理地址。

**Flags**：标志字段，通常是 `C`，表示该地址是“已连接”状态的（Connection）。还可能有其他标志，例如：

- `C`：表示该地址是当前连接的地址。
- `M`：表示这个地址是一个临时的（manually set）地址。

**Mask**：这是子网掩码。通常在ARP表中不会显示子网掩码，因此它为空。

**Iface**：表示该条ARP记录所在的网络接口（在你的例子中是 `bond0`，即一个绑定的网卡接口）。







```bash
  arp [-vn]  [<HW>] [-i <if>] [-a] [<hostname>]             <-显示ARP缓存
  arp [-v]          [-i <if>] -d  <host> [pub]               <-删除ARP条目
  arp [-vnD] [<HW>] [-i <if>] -f  [<filename>]            <-从文件添加条目
  arp [-v]   [<HW>] [-i <if>] -s  <host> <hwaddr> [temp]            <-添加条目
  arp [-v]   [<HW>] [-i <if>] -Ds <host> <if> [netmask <nm>] pub          <-''-

        -a                       以替代样式 (BSD) 显示（所有）主机
        -e                       以默认样式 (Linux) 显示（所有）主机
        -s, --set                设置一个新的ARP条目
        -d, --delete             删除指定的ARP条目
        -v, --verbose            显示详细信息
        -n, --numeric            不解析主机名
        -i, --device             指定网络接口（例如 eth0）
        -D, --use-device         从指定设备读取 <hwaddr>
        -A, -p, --protocol       指定协议族
        -f, --file               从文件或 /etc/ethers 中读取新条目

  <HW>=使用 '-H <hw>' 指定硬件地址类型。默认值：ether
  支持ARP的可能硬件类型列表:
    ash (Ash) ether (以太网) ax25 (AMPR AX.25) 
    netrom (AMPR NET/ROM) rose (AMPR ROSE) arcnet (ARCnet) 
    dlci (帧中继DLCI) fddi (光纤分布式数据接口) hippi (HIPPI) 
    irda (IrLAP) x25 (通用X.25) infiniband (InfiniBand) 
    eui64 (通用EUI-64)
```





`arp`（Address Resolution Protocol）是用于管理ARP缓存的命令工具。它常用于在网络中解析IP地址和MAC地址之间的映射关系。以下是一些常用的`arp`命令用法：

### 1. 查看ARP缓存

```bash
arp -a
```

- 显示ARP缓存中所有的IP地址与MAC地址的映射。

```bash
arp -e
```

- 以Linux默认样式显示ARP缓存。

### 2. 添加ARP条目

```bash
arp -s <host> <hwaddr>
```

- 手动添加一个静态的ARP条目。
  - `<host>`：目标IP地址。
  - `<hwaddr>`：对应的MAC地址。

例如：

```bash
arp -s 192.168.1.100 00:11:22:33:44:55
```

### 3. 删除ARP条目

```bash
arp -d <host>
```

- 删除指定主机的ARP条目。

例如：

```bash
arp -d 192.168.1.100
```

### 4. 从文件中批量添加ARP条目

```bash
arp -f <filename>
```

- 从指定的文件中读取ARP条目并添加到ARP缓存。

例如：

```bash
arp -f /etc/ethers
```

### 5. 显示详细信息

```bash
arp -v
```

- 显示命令的详细输出。

### 6. 不解析主机名

```bash
arp -n
```

- 以数字格式显示IP和MAC地址，而不进行DNS名称解析。

### 7. 指定网络接口

```bash
arp -i <if>
```

- 指定网络接口（例如 `eth0`）来显示与该接口相关的ARP条目。

例如：

```bash
arp -i eth0 -a
```

### 8. 使用指定硬件地址类型

```bash
arp -H <hwtype>
```

- 使用指定的硬件地址类型，常见的有 `ether`（以太网）等。

例如：

```bash
arp -H ether -a
```

这些是`arp`工具的一些常用用法，可以根据需要管理网络中的ARP缓存。











```bash
[root@VM-0-16-centos ~]# docker ps -q | xargs -I {} docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' {}  #查看容器ip地址
/gracious_archimedes - 172.17.0.3
/nifty_golick - 172.17.0.5
/registry - 172.17.0.2



[root@VM-0-16-centos ~]# arp -n
Address                  HWtype  HWaddress           Flags Mask            Iface
172.17.0.2               ether   02:42:ac:11:00:02   C                     docker0
172.17.0.5               ether   02:42:ac:11:00:05   C                     docker0
172.17.0.3               ether   02:42:ac:11:00:03   C                     docker0
10.206.0.1               ether   fe:ee:bf:f1:aa:f1   C                     eth0

[root@VM-0-16-centos ~]# ifconfig | grep docker0 -C 5
docker0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        inet6 fe80::42:7ff:fea7:3e8b  prefixlen 64  scopeid 0x20<link>
        ether 02:42:07:a7:3e:8b  txqueuelen 0  (Ethernet)
        RX packets 14623  bytes 916311 (894.8 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
[root@VM-0-16-centos ~]# 
```


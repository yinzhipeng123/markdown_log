`ip` 命令是 Linux 系统中用于配置和查看网络接口、路由、隧道等网络相关设置的工具。它是 `ifconfig` 命令的现代替代品，提供了更多功能和更强大的灵活性。以下是一些常用的 `ip` 命令及其作用：

### 1. **查看网络接口信息**
```bash
ip addr
```
这个命令用于查看所有网络接口的详细信息，包括 IP 地址、MAC 地址、网络接口状态等。

如果你只想查看某个特定接口的信息，比如 `eth0`，可以使用：
```bash
ip addr show eth0
```

### 2. **配置 IP 地址**
```bash
ip addr add <ip_address>/<subnet_mask> dev <interface>
```
该命令用于为某个网络接口添加一个 IP 地址。例如：
```bash
ip addr add 192.168.1.10/24 dev eth0
```
这个命令给 `eth0` 网络接口添加了 `192.168.1.10` 的 IP 地址，子网掩码是 `/24`。

### 3. **删除 IP 地址**
```bash
ip addr del <ip_address>/<subnet_mask> dev <interface>
```
如果你想删除某个 IP 地址，可以使用这个命令。例如：
```bash
ip addr del 192.168.1.10/24 dev eth0
```

### 4. **查看路由表**
```bash
ip route
```
这个命令用于查看系统的路由表。你可以看到系统如何根据目标地址选择路由。

例如，查看默认路由：
```bash
ip route show default
```

### 5. **添加路由**
```bash
ip route add <destination_network> via <gateway> dev <interface>
```
例如，向路由表添加一个新路由：
```bash
ip route add 10.1.1.0/24 via 192.168.1.1 dev eth0
```
这个命令添加了一个路由，使得到 `10.1.1.0/24` 网段的流量通过网关 `192.168.1.1` 来转发。

### 6. **删除路由**
```bash
ip route del <destination_network> via <gateway> dev <interface>
```
如果你想删除某个路由，可以使用这个命令。例如：
```bash
ip route del 10.1.1.0/24 via 192.168.1.1 dev eth0
```

### 7. **查看邻居表（ARP缓存）**
```bash
ip neigh
```
这个命令显示邻居缓存（ARP表），列出系统已知的 IP 地址与对应的 MAC 地址。

### 8. **启用/禁用网络接口**
```bash
ip link set dev <interface> up
ip link set dev <interface> down
```
这些命令分别用于启用或禁用某个网络接口。例如：
```bash
ip link set dev eth0 up
ip link set dev eth0 down
```

### 总结
`ip` 命令是非常强大且灵活的，涵盖了网络管理的方方面面。它可以配置和查看网络接口、路由、IP 地址、隧道、邻居缓存等信息，并且替代了许多老旧的命令，如 `ifconfig` 和 `route`。



https://wangchujiang.com/linux-command/c/ip.html
Zebra 是一款开源的路由管理软件，最初由 Kunihiro Ishiguro 和 Yoshinari Yoshikawa 开发，后来成为 **GNU Zebra** 项目的一部分。它主要用于 Unix/Linux 系统，提供动态路由协议的支持，允许将 Linux 设备转变为功能丰富的路由器。

### 主要特点：

**1.模块化设计**：

- Zebra 采用客户端-服务器架构，核心进程（`zebra`）负责内核路由表的管理，而其他守护进程（如 `ripd`, `ospfd`, `bgpd`）实现具体路由协议。
- 这种设计使得不同路由协议可以独立运行和配置。

**2.支持的路由协议**：

- **RIP**（RIPv1/v2）：通过 `ripd` 守护进程实现。
- **OSPF**（OSPFv2/v3）：通过 `ospfd` 和 `ospf6d` 支持 IPv4/IPv6。
- **BGP**（BGP-4）：通过 `bgpd` 实现，适合复杂网络环境（如 ISP）。
- 还支持 IS-IS、MPLS 等高级功能（部分需额外配置）。

**3.配置方式**：

- 提供类似 Cisco IOS 的 CLI 界面（通过 `vtysh` 工具），方便网络管理员操作。
- 配置文件通常位于 `/usr/local/etc/` 目录下（如 `zebra.conf`, `bgpd.conf`）。

**4.应用场景**：

- 将 Linux 服务器转换为路由器。
- 网络实验室或教育环境中模拟路由协议。
- 小型到中型网络的动态路由部署。

### 发展现状：

- Zebra 已停止维护，但其分支项目 **Quagga**（2003年分叉）和 **FRRouting**（FRR，2016年从 Quagga 分叉）继承了其代码并持续更新。
- **FRRouting** 是目前最活跃的分支，支持更现代的特性（如 BGP EVPN、Segment Routing）。

### 示例用途：

```bash
# 启动 Zebra 守护进程（需 root 权限）
zebra -d
bgpd -d  # 启动 BGP 守护进程

# 使用 vtysh 配置
vtysh
configure terminal
router bgp 65001
network 192.168.1.0/24
neighbor 10.0.0.1 remote-as 65002
```

如果你需要部署生产环境的路由功能，建议使用 **FRRouting**（FRR）以获得更好的性能和更新支持。Zebra 更适合学习传统路由协议的工作原理。
## 🧠 什么是 Keepalived？

**Keepalived** 是一个高可用性（High Availability, HA）软件，主要用于在 Linux 系统中实现 **虚拟 IP 漂移（VIP漂移）**，从而提供服务的高可用性。它经常与 **LVS（Linux Virtual Server）** 配合使用，但也可以独立使用。

它的核心功能包括：

- **VRRP（Virtual Router Redundancy Protocol）协议实现**：通过主备模式确保服务可用；
- **健康检查（health check）机制**：可以监控服务状态，如果主节点服务失败会自动漂移 VIP；
- **脚本调用**：可以根据需要运行用户定义的脚本实现复杂的高可用逻辑。

------

## 🧱 Keepalived 的核心组成

1. **VRRP 实现**（最核心功能）：
   - 类似于路由器的冗余协议。
   - 定义主备角色（MASTER/BACKUP），并设置优先级（priority）。
   - 同一个 VRRP 实例拥有一个 VIP（虚拟 IP），只有当前 MASTER 拥有这个 IP。
2. **健康检查（Health Check）**：
   - 可以对服务、端口、脚本等进行检查。
   - 一旦检测到失败，可以触发故障切换。
3. **脚本执行机制**：
   - 提供 `vrrp_script`，在状态变化时执行用户自定义脚本。

------

## 📦 实际工作流程（简单理解）

假设你有两台服务器，分别为：

- **A**（主节点，优先级高）
- **B**（备节点，优先级低）

两者运行 Keepalived，并配置相同的 VRRP 实例（同一个虚拟路由）。

工作过程：

1. **A 是 MASTER**，它绑定了 VIP（例如 192.168.1.100）；
2. 如果 A 崩溃或失联（例如服务宕机、网络断开）；
3. B 检测到 A 不再发送 VRRP 心跳；
4. B 自动接管 VIP，成为新的 MASTER；
5. 服务恢复后，视配置而定是否抢占（preempt）。

------

## 📄 Keepalived 示例配置

```bash

vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1234
    }
    virtual_ipaddress {
        192.168.1.100
    }
}
```

这段配置的意思：

- `state MASTER`：当前为主节点；
- `interface eth0`：绑定网卡；
- `virtual_router_id 51`：虚拟路由器 ID，主备必须相同；
- `priority 100`：优先级（备机可设为 90）；
- `advert_int 1`：心跳间隔为 1 秒；
- `virtual_ipaddress`：设定的虚拟 IP。

------

## 🔧 常见用途

- Nginx、HAProxy 前端负载均衡器的高可用；
- 数据库主备切换辅助；
- LVS 后端管理；
- 服务自动容灾切换。

------

## ✅ 优点

- 简单易用，配置直观；
- 支持自定义脚本，灵活；
- 社区活跃，文档丰富；
- 轻量级，不需要额外服务。

**LVS 和 Keepalived 联合部署的完整步骤**，从 0 到 1 搭建一个**高可用的四层负载均衡集群**，适用于 CentOS 或 Ubuntu 等常见 Linux 系统。

------

## 一、架构假设

| 角色           | 主机 IP       | 说明                    |
| -------------- | ------------- | ----------------------- |
| MASTER         | 192.168.1.10  | Keepalived + LVS 主节点 |
| BACKUP         | 192.168.1.11  | Keepalived + LVS 备节点 |
| RealServer1    | 192.168.1.101 | 后端服务器 1            |
| RealServer2    | 192.168.1.102 | 后端服务器 2            |
| VIP（虚拟 IP） | 192.168.1.100 | 提供访问入口            |

------

## 二、安装 LVS 和 Keepalived

### 在 MASTER 和 BACKUP 上都执行：

#### CentOS：

```bash
sudo yum install ipvsadm keepalived -y
```

#### Ubuntu：

```bash
sudo apt update
sudo apt install ipvsadm keepalived -y
```

------

## 三、配置 Keepalived（含 LVS 规则）

### 主节点（192.168.1.10）配置 `/etc/keepalived/keepalived.conf`：

```bash
global_defs {
    router_id LVS_MASTER
}

vrrp_instance VI_1 {
    state MASTER
    interface eth0                      # 改成你的网卡名
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1234
    }
    virtual_ipaddress {
        192.168.1.100                   # VIP
    }
}

virtual_server 192.168.1.100 80 {
    delay_loop 6
    lb_algo rr
    lb_kind DR
    persistence_timeout 60
    protocol TCP

    real_server 192.168.1.101 80 {
        weight 1
        TCP_CHECK {
            connect_timeout 3
            nb_get_retry 3
            delay_before_retry 3
        }
    }

    real_server 192.168.1.102 80 {
        weight 1
        TCP_CHECK {
            connect_timeout 3
            nb_get_retry 3
            delay_before_retry 3
        }
    }
}
```

------

### 备节点（192.168.1.11）配置类似，改动如下：

```bash
global_defs {
    router_id LVS_BACKUP
}

vrrp_instance VI_1 {
    state BACKUP
    priority 90
    # 其余相同
}
```

------

## 四、配置 Real Server（后端）支持 LVS-DR 模式

在 **192.168.1.101** 和 **192.168.1.102** 上都执行：

```bash
# 绑定 VIP 到 lo 口（注意掩码必须是 /32）
sudo ip addr add 192.168.1.100/32 dev lo
sudo ip link set lo up

# 禁止 lo 回应 ARP，防止冲突
echo 1 > /proc/sys/net/ipv4/conf/all/arp_ignore
echo 2 > /proc/sys/net/ipv4/conf/all/arp_announce
```

为使其永久生效，建议写入 `/etc/sysctl.conf`：

```conf
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.all.arp_announce = 2
```

并执行：

```bash
sysctl -p
```

------

## 五、启动并验证

### 在主备节点启动 Keepalived：

```bash
sudo systemctl start keepalived
sudo systemctl enable keepalived
```

### 检查 VIP 是否绑定成功（主节点）：

```bash
ip addr | grep 192.168.1.100
```

应看到 VIP 绑定成功。

### 检查 LVS 转发规则：

```bash
ipvsadm -Ln
```

应显示真实服务器 192.168.1.101 和 192.168.1.102 被加入负载池。

### 测试 VIP：

在另一台机器（客户端）访问：

```bash
curl http://192.168.1.100
```

应能访问到后端返回的网页（两个 Real Server 可设置不同内容做区分）。

------

## 六、模拟故障切换

停止主节点的 Keepalived：

```bash
sudo systemctl stop keepalived
```

然后在备节点运行：

```bash
ip addr | grep 192.168.1.100
```

如果 VIP 已漂移到备机，说明高可用切换生效。

------

## 总结

| 步骤 | 内容                         |
| ---- | ---------------------------- |
| 1    | 安装 LVS + Keepalived        |
| 2    | 主备配置 VRRP + LVS 服务规则 |
| 3    | 后端配置 VIP 绑定和禁止 ARP  |
| 4    | 启动服务，测试访问与切换     |


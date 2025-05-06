Keepalived 的部署其实非常简单，下面是一个完整的部署步骤，包括安装、配置和启动服务。我们以两台 CentOS / Ubuntu 系统的 Linux 服务器为例：一台作为主节点（MASTER），一台作为备节点（BACKUP），共同管理一个虚拟 IP。

------

## 🚀 一、环境准备

假设：

- 主节点 IP：192.168.1.10
- 备节点 IP：192.168.1.11
- 虚拟 IP（VIP）：192.168.1.100
- 网卡名：`eth0`（你实际的网卡可能是 `ens33`, `enp0s3` 等，可用 `ip a` 查看）

------

## 🧩 二、安装 Keepalived

### ✅ CentOS / RHEL：

```bash
sudo yum install keepalived -y
```

### ✅ Ubuntu / Debian：

```bash
sudo apt update
sudo apt install keepalived -y
```

------

## 🛠️ 三、配置 Keepalived

编辑主配置文件：

```bash
sudo vim /etc/keepalived/keepalived.conf
```

### 主节点（MASTER）配置：

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

### 备节点（BACKUP）配置：

```bash
vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    virtual_router_id 51
    priority 90
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

> ⚠️ 注意：
>
> - `state`：主为 MASTER，备为 BACKUP；
> - `priority`：主节点值必须高于备节点；
> - `virtual_router_id`：主备必须一致；
> - `auth_pass`：主备必须一致。

------

## 🔄 四、启动服务

```bash
# 启动 keepalived
sudo systemctl start keepalived

# 设置开机自启
sudo systemctl enable keepalived

# 查看状态
sudo systemctl status keepalived
```

------

## 🧪 五、验证是否成功

1. 在主节点执行：

```bash
ip addr | grep 192.168.1.100
```

应看到 VIP 已绑定。

1. 停止主节点 keepalived 服务：

```bash
sudo systemctl stop keepalived
```

1. 在备节点执行相同命令，应看到 VIP 自动漂移到备节点。

------

## 🧱 六、常用故障排查命令

```bash
journalctl -u keepalived    # 查看日志
tail -f /var/log/messages   # 监控系统日志（CentOS）
ip a                        # 查看网卡绑定的 IP
```

------

## ✅ 提示

- Keepalived 的 VIP 通常用于前端服务（如 Nginx、HAProxy）监听；
- 如果网卡为 `ens33` 或 `enp0s3`，请记得将 `interface eth0` 改成你的网卡名；
- Keepalived 支持健康检查脚本 `vrrp_script`，可进一步增强容错性。




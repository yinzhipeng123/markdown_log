一个 **LVS + Keepalived 高可用架构一键部署脚本**，包含：

- 🧠 主节点（MASTER）
- 👥 备节点（BACKUP）
- 🧱 Real Server（真实后端）

我将为每个角色提供独立脚本，按你的实际服务器角色运行对应的脚本即可。

------

## 🧠 1. MASTER 节点脚本（如：192.168.1.10）

保存为 `setup_master.sh`：

```bash
#!/bin/bash
set -e

# 基础安装
yum install -y ipvsadm keepalived

# 配置 Keepalived
cat > /etc/keepalived/keepalived.conf <<EOF
global_defs {
    router_id LVS_MASTER
}

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
EOF

# 启动服务
systemctl enable keepalived --now
```

------

## 👥 2. BACKUP 节点脚本（如：192.168.1.11）

保存为 `setup_backup.sh`：

```bash
#!/bin/bash
set -e

# 基础安装
yum install -y ipvsadm keepalived

# 配置 Keepalived
cat > /etc/keepalived/keepalived.conf <<EOF
global_defs {
    router_id LVS_BACKUP
}

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
EOF

# 启动服务
systemctl enable keepalived --now
```

------

## 🧱 3. Real Server 脚本（192.168.1.101 和 192.168.1.102）

保存为 `setup_real_server.sh`：

```bash
#!/bin/bash
set -e

# 绑定 VIP 到 lo 接口
ip addr add 192.168.1.100/32 dev lo
ip link set lo up

# 设置 ARP 策略，避免冲突
cat >> /etc/sysctl.conf <<EOF
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.all.arp_announce = 2
EOF

sysctl -p
```

------

## 🧪 4. 使用说明

- 修改脚本中的网卡名（默认为 eth0），根据你的实际网络接口替换。
- `192.168.1.100` 是 VIP，可以替换成你自己的业务 IP。
- 后端服务器需部署好 Web 服务（如 nginx、httpd 或 Python 简易 HTTP 服务器）监听 80 端口供测试。
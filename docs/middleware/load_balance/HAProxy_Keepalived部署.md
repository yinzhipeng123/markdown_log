# 一、最终架构

假设有：

| 角色  | IP                  |
| ----- | ------------------- |
| LB01  | `192.168.1.10`      |
| LB02  | `192.168.1.11`      |
| VIP   | `192.168.1.100`     |
| Web01 | `192.168.1.20:8080` |
| Web02 | `192.168.1.21:8080` |

架构：

```
                       用户
                        │
                        ↓
                VIP 192.168.1.100
                        │
               ┌────────┴────────┐
               ↓                 ↓
        LB01 192.168.1.10   LB02 192.168.1.11
        HAProxy + Keepalived HAProxy + Keepalived
               MASTER             BACKUP
               │                     │
               └─────────┬───────────┘
                         ↓
                 ┌───────┴───────┐
                 ↓               ↓
            Web01:8080       Web02:8080
```

正常情况下：

```
VIP → LB01
```

LB01 挂掉：

```
VIP → LB02
```

**用户始终访问 `192.168.1.100`。**

------

# 二、第一步：两台 LB 安装软件

两台机器都执行。

### Rocky / Alma / CentOS

```
dnf install -y haproxy keepalived
```

Ubuntu：

```
apt update
apt install -y haproxy keepalived
```

检查：

```
haproxy -v
keepalived --version
```

------

# 三、第二步：配置 HAProxy

两台机器都配置 HAProxy。

编辑：

```
vim /etc/haproxy/haproxy.cfg
```

配置：

```
global
    log /dev/log local0
    log /dev/log local1 notice


    maxconn 4096


    user haproxy
    group haproxy


    daemon




defaults
    mode http


    log global
    option httplog
    option dontlognull


    timeout connect 5s
    timeout client 30s
    timeout server 30s


    retries 3




frontend http_front
    bind *:80


    default_backend web_servers




backend web_servers
    balance roundrobin


    option httpchk GET /health


    server web01 192.168.1.20:8080 check
    server web02 192.168.1.21:8080 check
```

这里的逻辑非常简单：

```
VIP:80
   ↓
HAProxy
   ↓
192.168.1.20:8080
192.168.1.21:8080
```

------

# 四、第三步：检查 HAProxy

两台机器分别执行：

```
haproxy -c -f /etc/haproxy/haproxy.cfg
```

必须看到：

```
Configuration file is valid
```

然后：

```
systemctl enable --now haproxy
```

检查：

```
systemctl status haproxy
```

确认 80 端口：

```
ss -lntp | grep :80
```

------

# 五、第四步：配置 Keepalived

这一步才是整个架构的关键。

Keepalived负责：

> **让 VIP 在 LB01 和 LB02 之间漂移。**

------

# 六、LB01 配置 Keepalived

编辑：

```
vim /etc/keepalived/keepalived.conf
```

假设网卡叫：

```
eth0
```

配置：

```
global_defs {
    router_id LB01
}


vrrp_script check_haproxy {
    script "/etc/keepalived/check_haproxy.sh"
    interval 2
    weight -20
    fall 2
    rise 2
}


vrrp_instance VI_1 {
    state MASTER


    interface eth0


    virtual_router_id 51


    priority 150


    advert_int 1


    authentication {
        auth_type PASS
        auth_pass 123456
    }


    virtual_ipaddress {
        192.168.1.100/24
    }


    track_script {
        check_haproxy
    }
}
```

这里最重要的是：

```
state MASTER
priority 150
```

LB01 是主节点。

------

# 七、LB02配置

LB02 同样编辑：

```
vim /etc/keepalived/keepalived.conf
```

配置：

```
global_defs {
    router_id LB02
}


vrrp_script check_haproxy {
    script "/etc/keepalived/check_haproxy.sh"
    interval 2
    weight -20
    fall 2
    rise 2
}


vrrp_instance VI_1 {
    state BACKUP


    interface eth0


    virtual_router_id 51


    priority 100


    advert_int 1


    authentication {
        auth_type PASS
        auth_pass 123456
    }


    virtual_ipaddress {
        192.168.1.100/24
    }


    track_script {
        check_haproxy
    }
}
```

注意：

```
LB01 priority = 150
LB02 priority = 100
```

所以正常情况下：

```
LB01 → MASTER
LB02 → BACKUP
```

VIP：

```
192.168.1.100
```

会在 LB01 上。

------

# 八、为什么还要检测 HAProxy？

这是生产环境非常重要的一点。

如果只检测 Keepalived：

```
Keepalived ✅
HAProxy ❌
VIP仍然在LB01
```

那么：

```
用户
 ↓
VIP
 ↓
LB01
 ↓
HAProxy ❌
```

服务还是挂了。

所以们让 Keepalived 检查 HAProxy。

创建：

```
vim /etc/keepalived/check_haproxy.sh
```

写：

```
#!/bin/bash


if systemctl is-active --quiet haproxy; then
    exit 0
else
    exit 1
fi
```

增加执行权限：

```
chmod +x /etc/keepalived/check_haproxy.sh
```

测试：

```
/etc/keepalived/check_haproxy.sh


echo $?
```

正常应该：

```
0
```

------

# 九、启动 Keepalived

两台机器分别：

```
systemctl enable --now keepalived
```

查看：

```
systemctl status keepalived
```

------

# 十、检查 VIP

在 LB01：

```
ip addr
```

应该看到：

```
192.168.1.100
```

LB02：

```
ip addr
```

正常情况下**不会**看到 VIP。

也就是：

```
LB01
192.168.1.10
192.168.1.100 ← VIP


LB02
192.168.1.11
```

------

# 十一、测试故障转移

这是部署完成以后**必须测试的东西**。

## 测试一：停止 HAProxy

在 LB01：

```
systemctl stop haproxy
```

等待几秒。

然后：

```
ip addr
```

LB01 的 VIP 应该消失。

再去 LB02：

```
ip addr
```

应该出现：

```
192.168.1.100
```

架构从：

```
VIP
 ↓
LB01
```

变成：

```
VIP
 ↓
LB02
```

------

# 十二、测试 LB01 整台服务器故障

甚至可以直接：

```
reboot
```

LB01 重启后：

```
LB01 ❌
  ↓
Keepalived发现MASTER消失
  ↓
LB02成为MASTER
  ↓
VIP漂移到LB02
```

用户仍然访问：

```
192.168.1.100
```

后面的业务继续工作。

------

# 十三、测试后端服务器故障

假设：

```
Web01 ❌
Web02 ✅
```

HAProxy 会通过：

```
check
```

发现 Web01 不可用。

然后：

```
                 HAProxy
                 /     \
                ❌      ↓
             Web01    Web02
```

请求自动全部发送到 Web02。

------

# 十四、生产环境最终效果

最终得到的是：

```
                         Client
                           │
                           ↓
                    VIP 192.168.1.100
                           │
                ┌──────────┴──────────┐
                ↓                     ↓
        LB01 192.168.1.10      LB02 192.168.1.11
        HAProxy + Keepalived    HAProxy + Keepalived
             MASTER                  BACKUP
                │                     │
                └──────────┬──────────┘
                           ↓
                  ┌────────┴────────┐
                  ↓                 ↓
             Web01:8080        Web02:8080
```

对应关系可以记成：

```
Keepalived
    ↓
解决 LB 自己的高可用
    ↓
VIP 漂移


HAProxy
    ↓
解决后端服务的负载均衡
    ↓
流量分发 + 健康检查


Web01/Web02
    ↓
解决业务服务的高可用
```

### 最重要的一句话

**HAProxy 本身不负责 VIP 高可用，Keepalived 负责 VIP 漂移；HAProxy 负责流量转发。**

所以生产环境经常看到：

```
HAProxy + Keepalived
```

两者是配合关系，而不是二选一。
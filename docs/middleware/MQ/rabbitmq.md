# RabbitMQ 3 节点集群部署手册

## 一、架构

假设准备 3 台服务器：

| 主机名     | IP             | 角色            |
| ---------- | -------------- | --------------- |
| rabbitmq01 | 192.168.10.101 | RabbitMQ Node 1 |
| rabbitmq02 | 192.168.10.102 | RabbitMQ Node 2 |
| rabbitmq03 | 192.168.10.103 | RabbitMQ Node 3 |

最终：

```
                    业务客户端
                        │
                  LB / VIP / DNS
                        │
          ┌─────────────┼─────────────┐
          │             │             │
          ▼             ▼             ▼
     rabbitmq01    rabbitmq02    rabbitmq03
       Node 1        Node 2        Node 3
          │             │             │
          └─────────────┼─────────────┘
                        │
                  RabbitMQ Cluster
```

这里有一个很重要的概念：

> **RabbitMQ Cluster 主要解决节点和服务的高可用；真正需要保证消息数据高可用时，应使用 Quorum Queue。**

------

# 二、部署前准备

## 1. 三台机器设置 hostname

分别执行：

### rabbitmq01

```
hostnamectl set-hostname rabbitmq01
```

### rabbitmq02

```
hostnamectl set-hostname rabbitmq02
```

### rabbitmq03

```
hostnamectl set-hostname rabbitmq03
```

检查：

```
hostname
```

------

## 2. 配置 `/etc/hosts`

三台机器都配置：

```
cat >> /etc/hosts <<EOF
192.168.10.101 rabbitmq01
192.168.10.102 rabbitmq02
192.168.10.103 rabbitmq03
EOF
```

测试：

```
ping rabbitmq01
ping rabbitmq02
ping rabbitmq03
```

一定要保证三台机器之间能够通过 hostname 互相访问。

------

# 三、安装 Erlang

RabbitMQ 是基于 Erlang/OTP 的，所以需要先安装 Erlang。

这里**不要随便 `yum install erlang`**。

生产环境最好提前确认：

```
RabbitMQ版本
        ↓
对应支持的 Erlang/OTP版本
```

例如：

```
erl -version
```

确认 Erlang 版本。

然后安装 RabbitMQ。

> 实际生产部署时，建议把 RabbitMQ 和 Erlang 的 RPM 包提前放到自己的软件仓库或离线安装目录，避免生产环境临时访问公网。

------

# 四、安装 RabbitMQ

三台机器安装相同版本 RabbitMQ。

例如 RPM：

```
rpm -ivh rabbitmq-server-*.rpm
```

启动：

```
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
```

检查：

```
systemctl status rabbitmq-server
```

查看版本：

```
rabbitmqctl version
```

------

# 五、配置 Erlang Cookie

这是 RabbitMQ 集群非常关键的一步。

RabbitMQ 节点之间使用 Erlang Cookie 进行认证。

查看：

```
cat /var/lib/rabbitmq/.erlang.cookie
```

例如：

```
RABBITMQ_CLUSTER_COOKIE_2026
```

**三台机器必须完全一致。**

例如：

```
echo 'RABBITMQ_CLUSTER_COOKIE_2026' > /var/lib/rabbitmq/.erlang.cookie
```

权限：

```
chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
chmod 400 /var/lib/rabbitmq/.erlang.cookie
```

三台都做。

然后重启：

```
systemctl restart rabbitmq-server
```

------

# 六、配置 RabbitMQ 节点名称

建议使用：

```
rabbit@rabbitmq01
rabbit@rabbitmq02
rabbit@rabbitmq03
```

检查：

```
rabbitmqctl status
```

里面应该能够看到：

```
rabbit@rabbitmq01
```

如果发现节点名称不对，需要检查 RabbitMQ 的 hostname / nodename 配置。

生产环境建议统一使用：

```
rabbit@主机名
```

不要一台用 IP，一台用 hostname。

------

# 七、配置防火墙

RabbitMQ 集群常用端口：

| 端口        | 用途                  |
| ----------- | --------------------- |
| 4369        | Erlang Port Mapper    |
| 5672        | AMQP                  |
| 15672       | Management Web        |
| 25672       | RabbitMQ 节点通信     |
| 35672-35682 | Erlang 分布式通信相关 |

如果使用 firewalld，可以根据实际网络策略开放。

例如：

```
firewall-cmd --permanent --add-port=5672/tcp
firewall-cmd --permanent --add-port=15672/tcp
firewall-cmd --permanent --add-port=25672/tcp
firewall-cmd --permanent --add-port=4369/tcp
firewall-cmd --reload
```

**生产环境不要简单地把这些端口对整个互联网开放。**

最好限制：

```
业务网段 → 5672
RabbitMQ节点之间 → 集群通信端口
运维网段 → 15672
```

------

# 八、创建 RabbitMQ 集群

假设：

```
rabbitmq01
rabbitmq02
rabbitmq03
```

们让 `rabbitmq01` 作为第一个节点。

### rabbitmq01

直接启动即可：

```
systemctl start rabbitmq-server
```

查看：

```
rabbitmqctl cluster_status
```

应该类似：

```
Cluster name: rabbit@rabbitmq01


Running Nodes:
rabbit@rabbitmq01
```

------

# 九、rabbitmq02 加入集群

在 `rabbitmq02`：

```
systemctl stop rabbitmq-server
```

重置节点：

```
rabbitmqctl reset
```

然后加入：

```
rabbitmqctl join_cluster rabbit@rabbitmq01
```

启动：

```
systemctl start rabbitmq-server
```

检查：

```
rabbitmqctl cluster_status
```

应该看到：

```
Running Nodes:


rabbit@rabbitmq01
rabbit@rabbitmq02
```

------

# 十、rabbitmq03 加入集群

同样：

```
systemctl stop rabbitmq-server
rabbitmqctl reset
rabbitmqctl join_cluster rabbit@rabbitmq01
```

然后：

```
systemctl start rabbitmq-server
```

检查：

```
rabbitmqctl cluster_status
```

最终：

```
Running Nodes:


rabbit@rabbitmq01
rabbit@rabbitmq02
rabbit@rabbitmq03
```

至此，**RabbitMQ 三节点 Cluster 就建立起来了。**

------

# 十一、开启 Web 管理界面

三台都可以执行：

```
rabbitmq-plugins enable rabbitmq_management
```

然后：

```
http://192.168.10.101:15672
```

就可以进入管理页面。

------

# 十二、创建管理员用户

例如：

```
rabbitmqctl add_user admin 'StrongPassword'
```

设置管理员：

```
rabbitmqctl set_user_tags admin administrator
```

设置权限：

```
rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
```

然后就可以使用：

```
admin
StrongPassword
```

登录管理页面。

**生产环境不要继续使用默认 guest 用户。**

------

# 十三、这里开始是最重要的：Queue 怎么做高可用？

很多人部署 RabbitMQ 集群到这里就结束了。

其实还没完。

假设：

```
rabbitmq01
rabbitmq02
rabbitmq03
```

创建了一个普通 Queue：

```
order_queue
```

**并不代表这个 Queue 的消息自动在三个节点保存三份。**

所以生产环境需要考虑 Queue 的复制策略。

现在更推荐：

## Quorum Queue

例如：

```
                 order_queue
                     │
          ┌──────────┼──────────┐
          ▼          ▼          ▼
       Node01      Node02      Node03
        Leader      Replica     Replica
```

正常情况下：

```
Producer
   ↓
Node01
   ↓
消息复制
 ┌─┴──────┐
 ↓        ↓
Node02  Node03
```

Node01 挂掉：

```
Node01 ❌


Node02
  ↓
成为新的 Leader
```

这才是真正意义上比较完整的 RabbitMQ 高可用方案。

------

# 十四、创建 Quorum Queue

可以通过管理页面创建。

或者使用 CLI：

```
rabbitmqadmin declare queue \
  name=order_queue \
  type=quorum \
  durable=true
```

然后检查：

```
rabbitmqctl list_queues name type durable
```

应该能够看到：

```
order_queue quorum true
```

------

# 十五、生产架构再往前走一步

如果业务系统直接连接：

```
业务系统
   │
   ├──→ rabbitmq01
   ├──→ rabbitmq02
   └──→ rabbitmq03
```

其实也可以。

很多 RabbitMQ 客户端支持配置多个节点地址：

```
rabbitmq01:5672
rabbitmq02:5672
rabbitmq03:5672
```

客户端自动进行故障转移。

也可以使用：

```
业务
 ↓
HAProxy
 ↓
RabbitMQ Cluster
```

例如：

```
                  ┌─ rabbitmq01
                  │
业务 → HAProxy ───┼─ rabbitmq02
                  │
                  └─ rabbitmq03
```

不过这里需要注意：

> **RabbitMQ 客户端自身的连接恢复/故障转移能力，和前面放一个负载均衡器，是两个不同层面的事情。**

生产环境要根据客户端能力和业务连接模型来设计。

------

# 十六、最终可以形成这样一套标准架构

```
                         ┌──────────────┐
                         │   Producer   │
                         └──────┬───────┘
                                │
                                ▼
                         ┌──────────────┐
                         │ HAProxy/LB   │
                         └──────┬───────┘
                                │
              ┌─────────────────┼─────────────────┐
              │                 │                 │
              ▼                 ▼                 ▼
        ┌──────────┐      ┌──────────┐      ┌──────────┐
        │RabbitMQ01│      │RabbitMQ02│      │RabbitMQ03│
        │  Leader  │◄────►│ Replica  │◄────►│ Replica  │
        └────┬─────┘      └────┬─────┘      └────┬─────┘
             │                 │                 │
             └─────────────────┼─────────────────┘
                               │
                         Quorum Queue
                               │
                               ▼
                         ┌────────────┐
                         │ Consumer   │
                         └────────────┘
```

## 十七、部署完成后的检查清单

可以以后直接照这个检查：

```
# 1. 查看RabbitMQ状态
systemctl status rabbitmq-server


# 2. 查看版本
rabbitmqctl version


# 3. 查看集群
rabbitmqctl cluster_status


# 4. 查看节点
rabbitmqctl status


# 5. 查看队列
rabbitmqctl list_queues


# 6. 查看连接
rabbitmqctl list_connections


# 7. 查看Channel
rabbitmqctl list_channels


# 8. 查看用户
rabbitmqctl list_users


# 9. 查看插件
rabbitmq-plugins list
```

最终重点确认：

```
✓ 三个节点正常运行
✓ Erlang Cookie一致
✓ hostname解析正常
✓ 节点之间网络正常
✓ Cluster状态正常
✓ Management正常
✓ 用户权限正常
✓ Quorum Queue正常
✓ Producer能够发送消息
✓ Consumer能够消费消息
✓ ACK正常
✓ 模拟一个节点故障后业务仍然正常
```

------

### 真正部署的时候，建议再做一次“故障演练”

比如：

```
systemctl stop rabbitmq-server
```

直接把 `rabbitmq01` 干掉。

然后观察：

```
rabbitmq01 ❌


rabbitmq02
rabbitmq03
    ↓
Quorum Queue继续工作
    ↓
业务继续生产/消费
```


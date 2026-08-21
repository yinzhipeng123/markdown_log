

# MinIO 生产环境标准部署手册

## 1. 架构

采用：

```
                        ┌──────────────┐
                        │ 业务系统/用户  │
                        └──────┬───────┘
                               │
                            HTTPS/S3
                               │
                        ┌──────▼───────┐
                        │  DNS / VIP   │
                        └──────┬───────┘
                               │
                        ┌──────▼───────┐
                        │  HAProxy/LB  │
                        └──────┬───────┘
                               │
          ┌────────────────────┼────────────────────┐
          │                    │                    │
          ▼                    ▼                    ▼
      minio01              minio02              minio03       minio04
      10.0.0.11            10.0.0.12            10.0.0.13     10.0.0.14
          │                    │                    │              │
      4 × SSD              4 × SSD              4 × SSD        4 × SSD
          └────────────────────┼────────────────────┘
                               │
                        MinIO Distributed
                         Erasure Coding
```

### 推荐规划

| 项目         | 配置                        |
| ------------ | --------------------------- |
| MinIO 节点   | 4                           |
| 每节点数据盘 | 4                           |
| 总数据盘     | 16                          |
| API          | 9000                        |
| Console      | 9001                        |
| LB           | 443                         |
| API 域名     | `minio.example.com`         |
| Console 域名 | `minio-console.example.com` |

------

# 2. 服务器准备

4 台服务器：

```
minio01  10.0.0.11
minio02  10.0.0.12
minio03  10.0.0.13
minio04  10.0.0.14
```

建议：

```
CPU：8C+
内存：16G+
系统盘：100G+
数据盘：4 × SSD
网络：10Gbps 优先
```

### 注意

MinIO 是存储系统，**数据盘尽量使用独立本地盘**，不要简单地在一个系统盘上创建四个目录冒充四块盘。

------

# 3. 设置主机名

分别执行：

### minio01

```
hostnamectl set-hostname minio01
```

### minio02

```
hostnamectl set-hostname minio02
```

### minio03

```
hostnamectl set-hostname minio03
```

### minio04

```
hostnamectl set-hostname minio04
```

------

# 4. 配置 `/etc/hosts`

4 台机器全部配置：

```
vim /etc/hosts
```

加入：

```
10.0.0.11 minio01
10.0.0.12 minio02
10.0.0.13 minio03
10.0.0.14 minio04
```

测试：

```
ping -c 3 minio01
ping -c 3 minio02
ping -c 3 minio03
ping -c 3 minio04
```

------

# 5. 数据盘准备

假设每台服务器：

```
/dev/sdb
/dev/sdc
/dev/sdd
/dev/sde
```

分别对应：

```
/data/disk1
/data/disk2
/data/disk3
/data/disk4
```

例如：

```
mkfs.xfs /dev/sdb
mkfs.xfs /dev/sdc
mkfs.xfs /dev/sdd
mkfs.xfs /dev/sde
```

创建目录：

```
mkdir -p /data/disk{1..4}
```

挂载：

```
mount /dev/sdb /data/disk1
mount /dev/sdc /data/disk2
mount /dev/sdd /data/disk3
mount /dev/sde /data/disk4
```

检查：

```
df -h
```

应该看到类似：

```
/dev/sdb   500G   /data/disk1
/dev/sdc   500G   /data/disk2
/dev/sdd   500G   /data/disk3
/dev/sde   500G   /data/disk4
```

------

# 6. 配置开机自动挂载

先获取 UUID：

```
blkid
```

例如：

```
/dev/sdb UUID="xxxx-1111"
/dev/sdc UUID="xxxx-2222"
/dev/sdd UUID="xxxx-3333"
/dev/sde UUID="xxxx-4444"
```

编辑：

```
vim /etc/fstab
```

加入：

```
UUID=xxxx-1111 /data/disk1 xfs defaults,noatime 0 0
UUID=xxxx-2222 /data/disk2 xfs defaults,noatime 0 0
UUID=xxxx-3333 /data/disk3 xfs defaults,noatime 0 0
UUID=xxxx-4444 /data/disk4 xfs defaults,noatime 0 0
```

测试：

```
umount /data/disk1
mount -a
df -h
```

**这一步非常重要。**

否则服务器重启以后数据盘没挂载，MinIO 可能出现严重问题。

------

# 7. 创建 MinIO 用户

4 台机器都执行：

```
useradd -r -s /sbin/nologin minio
```

授权：

```
chown -R minio:minio /data
```

检查：

```
ls -ld /data/disk*
```

------

# 8. 安装 MinIO

建议生产环境**固定版本**，不要直接使用：

```
latest
```

先从官方获取当前需要部署的版本，然后安装对应二进制。

Linux x86_64 示例：

```
wget https://dl.min.io/server/minio/release/linux-amd64/minio
```

安装：

```
chmod +x minio
mv minio /usr/local/bin/minio
```

检查：

```
minio --version
```

4 台机器版本必须一致。

------

# 9. 配置 MinIO 环境变量

创建：

```
mkdir -p /etc/minio
vim /etc/minio/minio.env
```

例如：

```
MINIO_ROOT_USER=minioadmin
MINIO_ROOT_PASSWORD='修改成复杂密码'


MINIO_VOLUMES="http://minio{1...4}/data/disk{1...4}"


MINIO_OPTS="--address :9000 --console-address :9001"
```

生产环境密码必须自己生成，**不要使用示例密码**。

例如：

```
openssl rand -base64 32
```

------

# 10. 配置 systemd

创建：

```
vim /etc/systemd/system/minio.service
```

写入：

```
[Unit]
Description=MinIO Object Storage
Documentation=https://min.io/docs/
Wants=network-online.target
After=network-online.target


[Service]
User=minio
Group=minio


EnvironmentFile=/etc/minio/minio.env


ExecStart=/usr/local/bin/minio server \
  $MINIO_VOLUMES \
  $MINIO_OPTS


Restart=always
RestartSec=5


LimitNOFILE=65536
LimitNPROC=65536


[Install]
WantedBy=multi-user.target
```

------

# 11. 启动 MinIO

4 台机器都执行：

```
systemctl daemon-reload
```

设置开机启动：

```
systemctl enable minio
```

启动：

```
systemctl start minio
```

检查：

```
systemctl status minio
```

------

# 12. 查看日志

```
journalctl -u minio -f
```

如果启动失败：

```
journalctl -u minio --no-pager -n 100
```

重点检查：

```
磁盘是否挂载
权限是否正确
hosts 是否正确
节点之间网络是否通
MinIO 版本是否一致
启动参数是否一致
```

------

# 13. 防火墙

节点之间至少确保 MinIO API 端口可以互通：

```
9000
```

Console：

```
9001
```

如果使用 LB：

```
客户端 → LB:443
LB → MinIO:9000
```

生产环境不要为了省事直接：

```
systemctl stop firewalld
```

而应该按照实际网络规划放行所需端口。

------

# 14. 验证集群

安装 MinIO Client `mc`。

然后配置：

```
mc alias set minio \
http://minio01:9000 \
minioadmin \
'的密码'
```

查看集群：

```
mc admin info minio
```

正常应该能看到：

```
minio01
minio02
minio03
minio04
```

以及对应的 Drives。

------

# 15. 创建测试 Bucket

```
mc mb minio/test
```

查看：

```
mc ls minio
```

创建测试文件：

```
echo "hello minio" > test.txt
```

上传：

```
mc cp test.txt minio/test/
```

查看：

```
mc ls minio/test/
```

下载：

```
mc cp minio/test/test.txt /tmp/
```

验证：

```
cat /tmp/test.txt
```

------

# 16. 配置生产访问域名

不要让业务使用：

```
10.0.0.11:9000
```

配置 DNS：

```
minio.example.com
        ↓
       LB
```

Console：

```
minio-console.example.com
        ↓
       LB
```

最终：

```
S3 API：
https://minio.example.com


Console：
https://minio-console.example.com
```

------

# 17. 配置负载均衡

例如使用 HAProxy。

核心思想：

```
                     minio.example.com
                            │
                            ▼
                         HAProxy
                            │
             ┌──────────────┼──────────────┐
             ▼              ▼              ▼
          minio01        minio02        minio03        minio04
```

HAProxy 后端：

```
minio01:9000
minio02:9000
minio03:9000
minio04:9000
```

生产环境建议至少两台 LB：

```
             VIP
              │
       ┌──────┴──────┐
       ▼             ▼
   HAProxy01      HAProxy02
      MASTER        BACKUP
```

使用 Keepalived 提供 VIP。

------

# 18. HTTPS

生产环境使用：

```
https://minio.example.com
```

不要直接：

```
http://minio.example.com
```

可以让 LB 负责 TLS：

```
客户端
  │
 HTTPS
  ↓
LB
  │
 HTTP/HTTPS
  ↓
MinIO
```

Console 同理：

```
https://minio-console.example.com
```

------

# 19. 创建业务账号

**不要让业务程序使用 Root 用户。**

例如：

```
Root
 │
 ├── 创建 Policy
 │
 └── 创建业务账号
          │
          ├── Access Key
          └── Secret Key
```

业务系统配置：

```
Endpoint:
https://minio.example.com


AccessKey:
业务自己的 Access Key


SecretKey:
业务自己的 Secret Key


Bucket:
业务自己的 Bucket
```

例如：

```
mc admin user add minio app-user '复杂密码'
```

然后根据业务需求配置 Policy。

------

# 20. 故障测试

生产部署完成以后**必须测试**。

### 测试节点故障

在 `minio01`：

```
systemctl stop minio
```

然后测试：

```
mc ls minio/test
mc cp test.txt minio/test/
mc cp minio/test/test.txt /tmp/
```

确认业务仍然可以访问。

然后恢复：

```
systemctl start minio
```

------

### 测试磁盘故障

模拟某个数据盘不可用，观察：

```
mc admin info minio
```

以及：

```
journalctl -u minio -f
```

确认：

```
故障被发现
集群仍能工作
监控能够告警
恢复后节点重新正常
```

**不要直接在生产环境物理拔盘做第一次测试，先在测试环境演练。**

------

# 21. 监控

标准生产环境建议：

```
MinIO
  ↓
Prometheus
  ↓
Grafana
  ↓
Alertmanager
```

重点监控：

```
节点状态
磁盘状态
磁盘容量
CPU
内存
网络
S3 请求
S3 错误
请求延迟
```

尤其关注：

```
磁盘容量
```

对象存储最怕磁盘空间耗尽。

------

# 22. 备份/灾备

最后一定要记住：

> **MinIO 集群高可用 ≠ 数据备份。**

的架构：

```
              生产 MinIO
                   │
                   │
            备份 / Replication
                   │
                   ▼
              灾备 MinIO
                   │
                   ▼
                异地机房
```

至少要考虑：

```
误删除
误操作
程序 BUG
勒索软件
整个集群故障
机房故障
```

------

# 23. 上线前检查表

以后真正部署的时候，可以按照这个检查：

```
[ ] 4 台服务器准备完成
[ ] 4 台服务器时间同步
[ ] hostname 配置
[ ] /etc/hosts 配置
[ ] 数据盘格式化
[ ] 数据盘挂载
[ ] /etc/fstab 配置
[ ] MinIO 用户创建
[ ] 数据目录权限正确
[ ] 4 台 MinIO 版本一致
[ ] MinIO 配置完成
[ ] systemd 配置完成
[ ] MinIO 启动成功
[ ] 9000 端口互通
[ ] 9001 端口可访问
[ ] mc admin info 正常
[ ] Bucket 创建成功
[ ] 上传测试成功
[ ] 下载测试成功
[ ] DNS 配置
[ ] LB 配置
[ ] HTTPS 配置
[ ] Console 可以访问
[ ] 业务账号创建
[ ] 权限配置
[ ] 监控配置
[ ] 告警配置
[ ] 备份/灾备方案
[ ] 节点故障测试
[ ] 磁盘故障测试
```

## 最终生产架构

以后面试或者实际部署，脑子里就记这张：

```
                         业务系统
                            │
                         HTTPS/S3
                            │
                            ▼
                    ┌───────────────┐
                    │   DNS / VIP   │
                    └───────┬───────┘
                            │
                    ┌───────▼───────┐
                    │ HAProxy / F5  │
                    │  + Keepalived │
                    └───────┬───────┘
                            │
          ┌─────────────────┼─────────────────┐
          ▼                 ▼                 ▼
      MinIO-01          MinIO-02          MinIO-03          MinIO-04
          │                 │                 │                 │
      4 × SSD            4 × SSD            4 × SSD           4 × SSD
          └─────────────────┼─────────────────┘
                            │
                    MinIO Distributed
                     Erasure Coding
                            │
             ┌──────────────┴──────────────┐
             ▼                             ▼
        Prometheus                    Backup/DR
             │                             │
          Grafana                    灾备 MinIO
```

**这套就是比较完整的生产部署模板。**

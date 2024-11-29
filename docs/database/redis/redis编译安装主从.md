

### 1. **编译安装 Redis**

#### 步骤 1: 安装必要的依赖

Redis 编译安装需要一些开发工具和库，首先确保系统中已安装这些依赖。

- **在 Ubuntu/Debian 上**：

  ```bash
  sudo apt update
  sudo apt install build-essential tcl
  ```

- **在 CentOS/RHEL 上**：

  ```bash
  sudo yum groupinstall "Development Tools"
  sudo yum install tcl
  ```

#### 步骤 2: 下载 Redis 源码

去 Redis 官网下载最新版的源码，或者使用 `wget` 命令从 GitHub 获取。

```bash
cd /usr/local/src
sudo wget http://download.redis.io/redis-stable.tar.gz
```

解压下载的源码包：

```bash
sudo tar xzf redis-stable.tar.gz
cd redis-stable
```

#### 步骤 3: 编译 Redis

执行以下命令来编译 Redis：

```bash
sudo make
```

在编译过程中，您可以看到编译的输出信息。如果没有错误，编译完成后，可以使用以下命令进行测试：

```bash
sudo make test  # 测试Redis功能是否正常
```

如果一切正常，执行以下命令来安装 Redis：

```bash
sudo make install
```

#### 步骤 4: 配置 Redis

Redis 默认配置文件通常位于 `/usr/local/src/redis-stable/redis.conf`。您可以将此文件复制到 `/etc/redis/redis.conf` 进行修改。

```bash
sudo cp redis.conf /etc/redis/redis.conf
```

#### 步骤 5: 启动 Redis

您可以通过以下命令启动 Redis 服务：

```bash
redis-server /etc/redis/redis.conf
```

这样，您就成功安装并启动了 Redis。接下来，我们继续配置主从复制。

------

### 2. **配置 Redis 主从复制**

在 Redis 配置文件中，我们需要做一些简单的配置来启用主从复制。

#### 步骤 1: 配置主节点

主节点通常不需要做太多额外配置，您只需要确保主节点的配置文件中没有启用从节点功能。

- [ ] 打开主节点的 `redis.conf` 配置文件（路径通常是 `/etc/redis/redis.conf`）：

  ```bash
  sudo nano /etc/redis/redis.conf
  ```

- [ ] 确保配置文件中没有 `slaveof` 或 `replicaof` 配置项（这通常是用于从节点配置）。如果有，删除或注释掉这一行。

- [ ] 配置监听 IP，确保 Redis 服务器能接受来自其他服务器的连接：

  ```bash
  bind 0.0.0.0
  protected-mode no
  ```

- [ ] 配置密码（可选）以增强安全性：

  ```bash
  requirepass yourpassword
  ```

- [ ] 启动主节点 Redis：

  ```bash
  redis-server /etc/redis/redis.conf
  ```

#### 步骤 2: 配置从节点

接下来，您需要在从节点的配置文件中指定主节点的信息。

1. 在从节点机器上，复制 Redis 配置文件并进行修改：

   ```bash
   sudo cp /etc/redis/redis.conf /etc/redis/redis_slave.conf
   sudo nano /etc/redis/redis_slave.conf
   ```

2. 在配置文件中找到 `slaveof` 或 `replicaof` 相关配置并取消注释：

   ```bash
   replicaof <master-ip> <master-port>
   ```

   例如：

   ```bash
   replicaof 192.168.1.100 6379
   ```

3. 如果主节点设置了密码，您需要在从节点配置文件中设置 `masterauth`：

   ```bash
   masterauth yourpassword
   ```

4. 配置监听 IP，确保 Redis 能够接受来自其他服务器的连接：

   ```bash
   bind 0.0.0.0
   protected-mode no
   ```

5. 启动 Redis 从节点：

   ```bash
   redis-server /etc/redis/redis_slave.conf
   ```

#### 步骤 3: 验证主从复制

验证主从复制是否正常工作：

1. 在主节点上执行以下命令，设置一个键值对：

   ```bash
   redis-cli -h <master-ip> -p 6379
   set foo bar
   ```

2. 在从节点上执行：

   ```bash
   redis-cli -h <slave-ip> -p 6379
   get foo
   ```

   如果从节点返回了 `bar`，说明主从复制配置成功。

#### 步骤 4: 监控主从复制状态

您可以使用以下命令检查主从复制的状态：

- 在主节点上查看：

  ```bash
  redis-cli -h <master-ip> -p 6379 info replication
  ```

- 在从节点上查看：

  ```bash
  redis-cli -h <slave-ip> -p 6379 info replication
  ```

如果复制正常，您应该看到类似下面的信息：

```
role:master (主节点) 或 slave (从节点)
master_host:192.168.1.100
master_port:6379
connected_slaves:1
```

### 3. **自动化启动 Redis**

为了让 Redis 在系统重启时自动启动，您可以为 Redis 创建 `systemd` 服务文件。具体步骤如下：

#### 步骤 1: 创建 Redis 服务文件

创建 `redis.service` 文件：

```bash
sudo nano /etc/systemd/system/redis.service
```

将以下内容粘贴到文件中：

```ini
[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-server /etc/redis/redis.conf shutdown
Restart=always
User=redis
Group=redis

[Install]
WantedBy=multi-user.target
```

#### 步骤 2: 启动并启用 Redis 服务

启用 Redis 服务并使其在系统启动时自动启动：

```bash
sudo systemctl daemon-reload
sudo systemctl start redis
sudo systemctl enable redis
```

#### 步骤 3: 验证 Redis 服务

确认 Redis 服务正在运行：

```bash
sudo systemctl status redis
```

### 总结

通过编译安装 Redis，并配置主从复制，您可以在生产环境中搭建一个高可用的 Redis 缓存系统。主节点处理写请求，多个从节点可以分担读请求，从而提升性能和容错能力。
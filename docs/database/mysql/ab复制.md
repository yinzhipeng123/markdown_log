MySQL 的 AB 复制（主从复制）是一种常见的数据同步机制，用于在主服务器（A）和从服务器（B）之间复制数据，以实现高可用性和负载均衡。以下是部署 MySQL AB 复制的详细步骤：

---

### **1. 环境准备**
- 两台服务器：主服务器（A）和从服务器（B）。
- 已安装并运行 MySQL 数据库。
- 确保两台服务器可以通过网络相互通信。

---

### **2. 主服务器配置（A）**

#### **修改 MySQL 配置文件**
编辑主服务器的 MySQL 配置文件（一般位于 `/etc/my.cnf` 或 `/etc/mysql/my.cnf`），添加以下内容：

```ini
[mysqld]
server-id=1                 # 唯一ID，主从服务器必须不同
log-bin=mysql-bin           # 开启二进制日志
binlog-do-db=your_database  # 需要复制的数据库
binlog-ignore-db=mysql      # 不需要复制的数据库（可选）
```

#### **重启 MySQL 服务**
```bash
sudo systemctl restart mysqld
```

#### **创建复制用户**
登录 MySQL，创建一个用户用于复制：

```sql
CREATE USER 'replica_user'@'%' IDENTIFIED BY 'password';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';
FLUSH PRIVILEGES;
```

#### **获取主服务器的二进制日志信息**
```sql
SHOW MASTER STATUS;
```
记下以下信息：
- `File`（二进制日志文件名）
- `Position`（二进制日志位置）

---

### **3. 从服务器配置（B）**

#### **修改 MySQL 配置文件**
编辑从服务器的 MySQL 配置文件，添加以下内容：

```ini
[mysqld]
server-id=2                 # 唯一ID，与主服务器不同
relay-log=relay-log         # 开启中继日志（可选）
read-only=1                 # 设置只读（可选，确保从库不会被意外写入）
```

#### **重启 MySQL 服务**
```bash
sudo systemctl restart mysqld
```

#### **配置复制**
登录从服务器的 MySQL，执行以下命令：

```sql
CHANGE MASTER TO
  MASTER_HOST='主服务器IP地址',
  MASTER_USER='replica_user',
  MASTER_PASSWORD='password',
  MASTER_LOG_FILE='主服务器的File',
  MASTER_LOG_POS=主服务器的Position;
```

#### **启动复制**
```sql
START SLAVE;
```

#### **检查复制状态**
```sql
SHOW SLAVE STATUS\G;
```
确保以下两项显示为 `Yes`：
- `Slave_IO_Running: Yes`
- `Slave_SQL_Running: Yes`

---

### **4. 测试主从复制**
- 在主服务器上向 `your_database` 插入数据。
- 在从服务器上查询 `your_database`，确保数据同步成功。

---

### **注意事项**
1. **数据一致性**：在设置从库前，确保从库和主库数据一致，可通过备份恢复。
2. **防火墙设置**：确保 3306 端口开放，允许从库访问主库。
3. **高可用性**：为避免单点故障，可以结合 MHA、Keepalived 或其他工具实现故障自动切换。





## 配置多个从服务器



在 MySQL AB 复制中，添加多个从服务器非常简单。从库之间没有直接关系，都是独立连接到主服务器的，主服务器会向所有从服务器同步二进制日志。以下是配置两台从服务器的步骤：

---

### **1. 环境说明**
- **主服务器 (A)**：负责处理写操作和提供二进制日志。
- **从服务器 (B 和 C)**：负责从主服务器同步数据。

假设：
- 主服务器 IP：`192.168.1.100`
- 从服务器 B IP：`192.168.1.101`
- 从服务器 C IP：`192.168.1.102`
- 复制用户：`replica_user`，密码：`password`

---

### **2. 主服务器配置**

主服务器的配置与单从库时相同，无需额外调整：
1. 确保主服务器的 `server-id` 唯一。
2. 开启二进制日志：
   ```ini
   [mysqld]
   server-id=1
   log-bin=mysql-bin
   ```
3. 创建一个复制用户（如之前所述）。

如果之前已完成主从复制，只需要确保主库已正常运行。

---

### **3. 从服务器 B 和 C 配置**

#### **3.1 修改配置文件**
在每个从服务器（B 和 C）的 MySQL 配置文件（`/etc/my.cnf` 或 `/etc/mysql/my.cnf`）中，设置各自的 `server-id` 和必要的参数：

从服务器 B 配置：
```ini
[mysqld]
server-id=2                 # 从库 B 的唯一 ID
relay-log=relay-log         # 中继日志文件
read-only=1                 # 设置只读（可选）
```

从服务器 C 配置：
```ini
[mysqld]
server-id=3                 # 从库 C 的唯一 ID
relay-log=relay-log         # 中继日志文件
read-only=1                 # 设置只读（可选）
```

#### **3.2 重启 MySQL 服务**
重启每个从服务器的 MySQL 服务以加载新配置：

```bash
sudo systemctl restart mysqld
```

#### **3.3 设置从库同步**

在每个从服务器（B 和 C）中登录 MySQL，并配置同步：

1. **通过主服务器的备份初始化从库**
   如果从库未初始化数据，需通过主库备份恢复数据一致性：

   - 在主库执行备份：
     ```bash
     mysqldump -u root -p --all-databases --master-data > backup.sql
     ```
   - 将 `backup.sql` 拷贝到从库，导入数据：
     ```bash
     mysql -u root -p < backup.sql
     ```

2. **设置复制参数**
   登录从库 B 和从库 C，分别执行以下命令：
   ```sql
   CHANGE MASTER TO
     MASTER_HOST='192.168.1.100',
     MASTER_USER='replica_user',
     MASTER_PASSWORD='password',
     MASTER_LOG_FILE='mysql-bin.000001', -- 主库日志文件名
     MASTER_LOG_POS=12345;              -- 主库日志位置
   ```

   以上 `MASTER_LOG_FILE` 和 `MASTER_LOG_POS` 可通过在主库运行 `SHOW MASTER STATUS;` 获取。

3. **启动复制**
   在从库 B 和从库 C 上分别执行：
   ```sql
   START SLAVE;
   ```

4. **检查复制状态**
   在从库 B 和从库 C 上分别执行：
   ```sql
   SHOW SLAVE STATUS\G;
   ```

   确认以下两项均为 `Yes`：
   - `Slave_IO_Running: Yes`
   - `Slave_SQL_Running: Yes`

---

### **4. 测试多从库复制**

1. 在主库（A）执行写操作：
   ```sql
   USE test_db;
   INSERT INTO test_table (name, value) VALUES ('test', 123);
   ```

2. 在从库 B 和从库 C 查询数据，确保同步成功：
   ```sql
   USE test_db;
   SELECT * FROM test_table;
   ```

---

### **5. 注意事项**
1. **从库的 server-id 唯一**：每个从库必须有唯一的 `server-id`。
2. **负载均衡**：
   - 读操作可以分发到多个从库，避免某一从库过载。
   - 使用中间件（如 ProxySQL 或 Mycat）管理多个从库。
3. **数据一致性**：主从复制存在延迟，重要读操作可强制从主库读取。
4. **从库只读模式**：开启 `read_only` 参数，防止误写从库。
5. **半同步复制（可选）**：提高数据一致性，可在主从之间启用半同步复制。





## 半同步复制

主从之间启用 **半同步复制** 是一种增强 MySQL 数据一致性的方法，用于减少主从复制中的数据丢失风险。

---

### **什么是半同步复制？**

在默认的 MySQL 主从复制中，采用的是**异步复制**模式：
- 主库执行事务提交后，会立即向客户端返回“提交成功”。
- 主库随后将二进制日志 (`binlog`) 发送给从库，但主库并不等待从库确认是否收到或应用这些日志。

这种方式虽然效率高，但有潜在风险：
1. **数据丢失**：如果主库崩溃，部分已经提交的事务可能尚未传输到从库，导致数据丢失。
2. **数据不一致**：主从库之间可能短暂处于不同步状态。

**半同步复制** 是为了解决这些问题的一种改进：
- 主库在提交事务时，不仅写入本地的二进制日志，还需等待至少一个从库确认接收到该日志。
- 只有当至少一个从库确认接收后，主库才会向客户端返回“提交成功”。
- 如果从库未及时响应，主库会切回异步复制模式以保证性能。

---

### **半同步复制的优缺点**

#### **优点**：
1. **数据一致性**：主从复制的事务日志在提交时已传输到从库，减少了主库崩溃时的数据丢失。
2. **高可靠性**：适合对数据一致性要求较高的业务场景，如金融、电商等关键系统。

#### **缺点**：
1. **性能影响**：主库需要等待从库确认，会增加事务延迟。
2. **依赖网络质量**：如果主从之间网络不稳定，可能导致事务处理速度显著下降。

---

### **半同步复制的工作流程**

1. **客户端提交事务**：
   - 主库将事务日志写入二进制日志 (`binlog`)。
2. **发送日志给从库**：
   - 主库将 `binlog` 推送到从库。
3. **等待从库确认**：
   - 至少一个从库接收到 `binlog` 并写入中继日志后，向主库发送确认 (`ACK`)。
4. **主库返回提交成功**：
   - 主库收到确认后，向客户端返回“提交成功”。
   - 如果超时未收到确认，主库切换回异步模式。

---

### **如何启用半同步复制**

以下是配置主从库启用半同步复制的步骤：

#### **1. 检查并安装插件**

在主库和从库上确保已安装 `rpl_semi_sync_master` 和 `rpl_semi_sync_slave` 插件：

在主库上：
```sql
INSTALL PLUGIN rpl_semi_sync_master SONAME 'semisync_master.so';
```

在从库上：
```sql
INSTALL PLUGIN rpl_semi_sync_slave SONAME 'semisync_slave.so';
```

---

#### **2. 配置主库**

在主库的 MySQL 配置文件（`/etc/my.cnf`）中添加以下内容：
```ini
[mysqld]
plugin-load-add=rpl_semi_sync_master=semisync_master.so
rpl_semi_sync_master_enabled=1
rpl_semi_sync_master_timeout=1000   # 设置超时时间 (毫秒)
```

重启 MySQL 服务：
```bash
sudo systemctl restart mysqld
```

在主库启用半同步复制：
```sql
SET GLOBAL rpl_semi_sync_master_enabled = 1;
```

---

#### **3. 配置从库**

在从库的 MySQL 配置文件中添加以下内容：
```ini
[mysqld]
plugin-load-add=rpl_semi_sync_slave=semisync_slave.so
rpl_semi_sync_slave_enabled=1
```

重启从库 MySQL 服务：
```bash
sudo systemctl restart mysqld
```

在从库启用半同步复制：
```sql
SET GLOBAL rpl_semi_sync_slave_enabled = 1;
```

---

#### **4. 验证配置**

在主库执行以下命令，查看是否启用了半同步复制：
```sql
SHOW VARIABLES LIKE 'rpl_semi%';
```

检查是否有以下变量启用：
- `rpl_semi_sync_master_enabled`：是否启用了主库的半同步。
- `rpl_semi_sync_master_status`：当前是否使用半同步复制。

---

### **适用场景**
1. **对数据一致性要求高的系统**：
   - 金融交易、库存管理、在线支付等场景。
2. **对性能要求相对次要的环境**：
   - 如果系统性能要求高，可能需要权衡事务延迟问题。

---

### **注意事项**
1. **从库数量建议**：即使启用半同步复制，建议配置多个从库，提高可靠性。
2. **网络质量要求**：主从之间网络需要稳定，否则可能频繁回退到异步模式。
3. **适当调整超时时间**：通过参数 `rpl_semi_sync_master_timeout` 设置主库等待从库确认的超时时间。

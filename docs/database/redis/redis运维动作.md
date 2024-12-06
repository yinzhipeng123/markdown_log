 Redis 进行日常运维管理。以下是一些检查 Redis 状态是否正常的常见方法，以及一些常见的运维动作

### 1. **查看 Redis 状态是否正常**

可以通过多种方式检查 Redis 服务的健康状态，下面列出了一些常见的命令和工具。

```bash
redis-cli 6.2.16

用法: redis-cli [选项] [cmd [arg [arg ...]]]
  -h <hostname>      服务器主机名（默认：127.0.0.1）。
  -p <port>          服务器端口（默认：6379）。
  -s <socket>        服务器套接字（覆盖主机名和端口）。
  -a <password>      连接服务器时使用的密码。
                     你也可以使用 REDISCLI_AUTH 环境变量更安全地传递密码
                     （如果两者都使用，则优先使用此参数）。
  --user <username>  用于发送 ACL 样式的 'AUTH username pass'。需要 -a。
  --pass <password>  与 -a 一样，保持与新 --user 选项一致性。
  --askpass          强制用户通过 STDIN 输入密码并进行掩码处理。
                     如果使用此参数，则 '-a' 和 REDISCLI_AUTH 环境变量将被忽略。
  -u <uri>           服务器 URI。
  -r <repeat>        执行指定命令 N 次。
  -i <interval>      当使用 -r 时，每个命令等待 <interval> 秒。
                     可以指定亚秒时间，例如 -i 0.1。
  -n <db>            数据库编号。
  -3                 启动会话并使用 RESP3 协议模式。
  -x                 从 STDIN 读取最后一个参数。
  -d <delimiter>     原始格式中响应数据的分隔符（默认：\n）。
  -D <delimiter>     响应数据的分隔符（默认：\n）。
  -c                 启用集群模式（跟随 -ASK 和 -MOVED 重定向）。
  -e                 当命令执行失败时返回退出错误代码。
  --tls              建立安全的 TLS 连接。
  --sni <host>       用于 TLS 的服务器名称指示。
  --cacert <file>    用于验证的 CA 证书文件。
  --cacertdir <dir>  存储受信任的 CA 证书的目录。
                     如果未指定 cacert 或 cacertdir，则将使用默认的系统范围受信任根证书配置。
  --insecure         允许不安全的 TLS 连接，跳过证书验证。
  --cert <file>      客户端证书用于身份验证。
  --key <file>       用于身份验证的私钥文件。
  --tls-ciphers <list> 设置首选密码算法列表（TLSv1.2 及以下）。
                     按首选顺序从最高到最低用冒号（":"）分隔。有关此字符串语法的更多信息，请参见 ciphers(1ssl) 手册页。
  --tls-ciphersuites <list> 设置首选的密码套件列表（TLSv1.3）。
                     按首选顺序从最高到最低用冒号（":"）分隔。有关此字符串语法的更多信息，请参见 ciphers(1ssl) 手册页，尤其是 TLSv1.3 密码套件。
  --raw              使用原始格式返回回复（默认情况下，STDOUT 不是 tty 时）。
  --no-raw           强制格式化输出，即使 STDOUT 不是 tty。
  --quoted-input     强制将输入作为引号字符串处理。
  --csv              以 CSV 格式输出。
  --show-pushes <yn> 是否打印 RESP3 PUSH 消息。默认情况下，当 STDOUT 是 tty 时启用，但可以使用 --show-pushes no 来覆盖。
  --stat             打印有关服务器的滚动统计信息：内存、客户端等。
  --latency          进入特殊模式，持续采样延迟。
                     如果在交互式会话中使用此模式，它将永远运行并显示实时统计信息。否则，如果指定了 --raw 或 --csv，或者将输出重定向到非 TTY，它会在 1 秒内采样延迟（你可以使用 -i 更改间隔），然后产生单个输出并退出。
  --latency-history  类似于 --latency，但跟踪延迟随时间的变化。
                     默认时间间隔为 15 秒。使用 -i 可以更改。
  --latency-dist     显示延迟的频谱，要求使用 xterm 256 色。
                     默认时间间隔为 1 秒。使用 -i 可以更改。
  --lru-test <keys>  模拟带有 80-20 分布的缓存工作负载。
  --replica          模拟副本，显示从主节点接收的命令。
  --rdb <filename>   将 RDB 转储从远程服务器传输到本地文件。
                     使用文件名 "-" 将数据写入标准输出。
  --pipe             从 STDIN 将原始 Redis 协议传输到服务器。
  --pipe-timeout <n> 在 --pipe 模式下，如果在发送完所有数据后，
                     在 <n> 秒内没有收到回复，则中止并报错。
                     默认超时：30。使用 0 可以永久等待。
  --bigkeys          使用 SCAN 命令列出所有键并查找具有大量元素的键（复杂性）。
  --memkeys          使用 SCAN 命令列出所有键并查找消耗大量内存的键。
  --memkeys-samples <n> 使用 SCAN 命令列出所有键并查找消耗大量内存的键。
                     并定义要采样的键元素数量。
  --hotkeys          使用 SCAN 命令列出所有键并查找热点键。
                     仅在 maxmemory-policy 为 *lfu 时有效。
  --scan             使用 SCAN 命令列出所有键。
  --pattern <pat>    使用 --scan、--bigkeys 或 --hotkeys 选项时的键模式（默认：*）。
  --quoted-pattern <pat> 与 --pattern 相同，但指定的字符串可以用引号括起来，
                         以传递一个非二进制安全字符串。
  --intrinsic-latency <sec> 运行一个测试来测量内在的系统延迟。
                     测试将在指定的秒数内运行。
  --eval <file>      使用 <file> 中的 Lua 脚本发送 EVAL 命令。
  --ldb              与 --eval 一起使用时，启用 Redis Lua 调试器。
  --ldb-sync-mode    与 --ldb 一起使用时，启用同步 Lua 调试器模式，
                     在此模式下，服务器会被阻塞，脚本更改不会从服务器内存中回滚。
  --cluster <command> [args...] [opts...]
                     集群管理命令和参数（见下文）。
  --verbose          启用详细模式。
  --no-auth-warning  不显示使用命令行密码时的警告信息。
  --help             输出此帮助并退出。
  --version          输出版本并退出。

集群管理命令：
  使用 --cluster help 列出所有可用的集群管理命令。

示例：
  cat /etc/passwd | redis-cli -x set mypasswd
  redis-cli get mypasswd
  redis-cli -r 100 lpush mylist x
  redis-cli -r 100 -i 1 info | grep used_memory_human:
  redis-cli --quoted-input set '"null-\x00-separated"' value
  redis-cli --eval myscript.lua key1 key2 , arg1 arg2 arg3
  redis-cli --scan --pattern '*:12345*'

  （注意：使用 --eval 时，逗号用于分隔 KEYS[] 和 ARGV[] 项）

当未提供命令时，redis-cli 进入交互模式。
在交互模式下输入 "help" 获取可用命令和设置的信息。

```



#### 1.1 使用 `redis-cli` 查看基本状态

- **查看 Redis 运行状态**： 通过 `INFO` 命令获取 Redis 实例的详细运行信息：

  ```bash
  redis-cli -h <redis-ip> -p 6379 info
  ```

  输出会包含各种信息，如内存使用情况、客户端连接数、持久化状态、CPU 占用等。

  ```bash
  # Server
  redis_version:6.2.16  # Redis 版本
  redis_git_sha1:00000000  # Redis Git提交ID（版本信息）
  redis_git_dirty:0  # 是否有未提交的修改（0表示没有）
  redis_build_id:85a2e85bf3a77649  # Redis 构建ID
  redis_mode:standalone  # Redis模式，standalone表示单实例模式
  os:Linux 5.14.0-202.el9.x86_64 x86_64  # 操作系统和架构信息
  arch_bits:64  # Redis使用的架构位数
  monotonic_clock:POSIX clock_gettime  # 使用的单调时钟类型
  multiplexing_api:epoll  # 多路复用API（epoll表示使用Linux的epoll）
  atomicvar_api:c11-builtin  # 使用的原子变量API
  gcc_version:11.5.0  # 使用的GCC版本
  process_id:777504  # Redis进程ID
  process_supervised:systemd  # Redis进程是否由systemd监控
  run_id:5ccd9c38e3330b7a0245a212967907805f85604c  # Redis运行ID
  tcp_port:6379  # Redis使用的TCP端口
  server_time_usec:1733407104291797  # 服务器当前时间（微秒）
  uptime_in_seconds:621268  # Redis运行时间（秒）
  uptime_in_days:7  # Redis运行时间（天数）
  hz:10  # Redis的心跳频率（每秒多少次）
  configured_hz:10  # 配置文件中的hz值
  lru_clock:5353856  # LRU时钟，用于管理LRU缓存
  executable:/usr/bin/redis-server  # Redis可执行文件路径
  config_file:/etc/redis/redis.conf  # 配置文件路径
  io_threads_active:0  # 活动的I/O线程数
  
  # Clients
  connected_clients:1  # 当前连接的客户端数量
  cluster_connections:0  # 集群连接数量
  maxclients:10000  # 最大客户端连接数
  client_recent_max_input_buffer:0  # 最近客户端的最大输入缓冲区大小
  client_recent_max_output_buffer:0  # 最近客户端的最大输出缓冲区大小
  blocked_clients:0  # 被阻塞的客户端数量
  tracking_clients:0  # 追踪的客户端数量
  clients_in_timeout_table:0  # 超时表中的客户端数量
  
  # Memory
  used_memory:876080  # 已使用的内存（字节）
  used_memory_human:855.55K  # 已使用内存的可读格式
  used_memory_rss:14688256  # Redis进程的RSS（驻留内存集）
  used_memory_rss_human:14.01M  # Redis进程的RSS的可读格式
  used_memory_peak:934224  # 最大内存使用量（字节）
  used_memory_peak_human:912.33K  # 最大内存使用量的可读格式
  used_memory_peak_perc:93.78%  # 最大内存使用量的百分比
  used_memory_overhead:812184  # 内存开销（额外的内存开销，如数据结构）
  used_memory_startup:812184  # 启动时的内存使用量
  used_memory_dataset:63896  # 数据集占用的内存
  used_memory_dataset_perc:100.00%  # 数据集内存占用的百分比
  allocator_allocated:956248  # 分配的内存量
  allocator_active:1253376  # 活动内存量
  allocator_resident:3817472  # 常驻内存量
  total_system_memory:7792852992  # 系统总内存
  total_system_memory_human:7.26G  # 系统总内存的可读格式
  used_memory_lua:30720  # Lua脚本使用的内存
  used_memory_lua_human:30.00K  # Lua脚本内存的可读格式
  used_memory_scripts:0  # 脚本占用的内存
  used_memory_scripts_human:0B  # 脚本内存的可读格式
  number_of_cached_scripts:0  # 缓存脚本的数量
  maxmemory:0  # 最大内存限制（0表示没有限制）
  maxmemory_human:0B  # 最大内存限制的可读格式
  maxmemory_policy:noeviction  # 最大内存策略（noeviction表示不驱逐数据）
  allocator_frag_ratio:1.31  # 分配器碎片率
  allocator_frag_bytes:297128  # 分配器碎片的字节数
  allocator_rss_ratio:3.05  # 分配器RSS比率
  allocator_rss_bytes:2564096  # 分配器RSS的字节数
  rss_overhead_ratio:3.85  # RSS开销比率
  rss_overhead_bytes:10870784  # RSS开销的字节数
  mem_fragmentation_ratio:18.08  # 内存碎片化比率
  mem_fragmentation_bytes:13875888  # 内存碎片的字节数
  mem_not_counted_for_evict:0  # 未计入驱逐的数据内存
  mem_replication_backlog:0  # 复制积压内存
  mem_clients_slaves:0  # 客户端从服务器内存
  mem_clients_normal:0  # 客户端正常内存
  mem_aof_buffer:0  # AOF缓冲区内存
  mem_allocator:jemalloc-5.1.0  # 使用的内存分配器（jemalloc）
  active_defrag_running:0  # 是否正在运行主动碎片整理
  lazyfree_pending_objects:0  # 待释放对象的数量
  lazyfreed_objects:0  # 已释放的对象数量
  
  # Persistence
  loading:0  # 是否正在加载持久化文件
  current_cow_size:0  # 当前写时复制（COW）的大小
  current_cow_size_age:0  # 当前写时复制的年龄
  current_fork_perc:0.00  # 当前fork的百分比
  current_save_keys_processed:0  # 当前保存过程中处理的键数
  current_save_keys_total:0  # 当前保存过程中总的键数
  rdb_changes_since_last_save:0  # 自上次保存以来的RDB变化次数
  rdb_bgsave_in_progress:0  # 是否正在进行后台保存
  rdb_last_save_time:1732846804  # 上次RDB保存时间（Unix时间戳）
  rdb_last_bgsave_status:ok  # 上次后台保存的状态
  rdb_last_bgsave_time_sec:0  # 上次后台保存的时间（秒）
  rdb_current_bgsave_time_sec:-1  # 当前后台保存的时间（秒）
  rdb_last_cow_size:180224  # 上次写时复制的大小
  aof_enabled:0  # 是否启用了AOF持久化
  aof_rewrite_in_progress:0  # 是否正在进行AOF重写
  aof_rewrite_scheduled:0  # 是否已安排AOF重写
  aof_last_rewrite_time_sec:-1  # 上次AOF重写的时间（秒）
  aof_current_rewrite_time_sec:-1  # 当前AOF重写的时间（秒）
  aof_last_bgrewrite_status:ok  # 上次AOF后台重写的状态
  aof_last_write_status:ok  # 上次AOF写入的状态
  aof_last_cow_size:0  # 上次AOF写时复制的大小
  module_fork_in_progress:0  # 是否正在进行模块fork
  module_fork_last_cow_size:0  # 上次模块fork的写时复制大小
  
  # Stats
  total_connections_received:19  # 接收的总连接数
  total_commands_processed:33  # 处理的总命令数
  instantaneous_ops_per_sec:0  # 每秒执行的命令数量
  total_net_input_bytes:1340  # 网络输入字节总数
  total_net_output_bytes:176930  # 网络输出字节总数
  instantaneous_input_kbps:0.00  # 每秒输入数据（KB/s）
  instantaneous_output_kbps:0.00  # 每秒输出数据（KB/s）
  rejected_connections:0  # 被拒绝的连接数
  sync_full:0  # 完全同步的次数
  sync_partial_ok:0  # 部分同步成功的次数
  sync_partial_err:0  # 部分同步错误的次数
  expired_keys:1  # 过期的键数
  expired_stale_perc:0.00  # 过期键所占百分比
  expired_time_cap_reached_count:0  # 达到过期时间上限的次数
  expire_cycle_cpu_milliseconds:6550  # 过期周期的CPU时间（毫秒）
  evicted_keys:0  # 被驱逐的键数
  keyspace_hits:2  # 命中键空间的次数
  keyspace_misses:1  # 键空间未命中的次数
  pubsub_channels:0  # 发布订阅频道数
  pubsub_patterns:0  # 发布订阅模式数
  latest_fork_usec:321  # 上次fork的时间（微秒）
  total_forks:2  # 总fork次数
  migrate_cached_sockets:0  # 迁移缓存套接字数
  slave_expires_tracked_keys:0  # 追踪的过期键数
  active_defrag_hits:0  # 主动碎片整理的命中次数
  active_defrag_misses:0  # 主动碎片整理的未命中次数
  active_defrag_key_hits:0  # 主动碎片整理的键命中次数
  active_defrag_key_misses:0  # 主动碎片整理的键未命中次数
  tracking_total_keys:0  # 追踪的总键数
  tracking_total_items:0  # 追踪的总项目数
  tracking_total_prefixes:0  # 追踪的总前缀数
  unexpected_error_replies:0  # 未预期的错误回复数
  total_error_replies:16  # 总错误回复数
  dump_payload_sanitizations:0  # 处理的转储负载消毒数
  total_reads_processed:64  # 处理的读取次数
  total_writes_processed:45  # 处理的写入次数
  io_threaded_reads_processed:0  # 处理的I/O线程读取次数
  io_threaded_writes_processed:0  # 处理的I/O线程写入次数
  
  # Replication
  role:master  # Redis角色（主节点）
  connected_slaves:0  # 连接的从节点数
  master_failover_state:no-failover  # 主节点故障转移状态
  master_replid:0cab78c51791cc4da6a6894e37e87edcd15cd452  # 主节点的复制ID
  master_replid2:0000000000000000000000000000000000000000  # 第二个复制ID
  master_repl_offset:0  # 主节点的复制偏移量
  second_repl_offset:-1  # 第二个复制偏移量
  repl_backlog_active:0  # 是否启用了复制积压
  repl_backlog_size:1048576  # 复制积压的大小
  repl_backlog_first_byte_offset:0  # 复制积压的第一个字节偏移
  repl_backlog_histlen:0  # 复制积压历史长度
  
  # CPU
  used_cpu_sys:321.607443  # 系统模式下的CPU使用时间（秒）
  used_cpu_user:300.817814  # 用户模式下的CPU使用时间（秒）
  used_cpu_sys_children:0.000000  # 子进程的系统模式CPU使用时间
  used_cpu_user_children:0.003032  # 子进程的用户模式CPU使用时间
  used_cpu_sys_main_thread:321.605497  # 主线程的系统模式CPU使用时间
  used_cpu_user_main_thread:300.816868  # 主线程的用户模式CPU使用时间
  
  # Modules
  # 没有启用模块
  
  # Errorstats
  errorstat_ERR:count=2  # 错误统计：ERR 错误的次数
  errorstat_NOAUTH:count=14  # 错误统计：NOAUTH 错误的次数
  
  # Cluster
  cluster_enabled:0  # 是否启用了集群模式
  
  # Keyspace
  # 表示数据库中的键的空间情况，通常用来分析当前数据库的键的分布和状态
  ```
  
  查看输出中的部分关键信息：
  
  - [ ] **role**: 显示当前节点是主节点还是从节点。
  - [ ] **connected_clients**: 当前连接的客户端数量。
  - [ ] **used_memory**: Redis 使用的内存。
  - [ ] **total_commands_processed**: 已处理的总命令数。
  - [ ] **uptime_in_seconds**: Redis 启动以来经过的时间。
  - [ ] **rdb_last_bgsave_status**: RDB 持久化状态，检查是否有任何备份失败。
  - [ ] **connected_slaves**: 从节点的数量。
  
  例如，如果查看主从复制状态：
  
  ```bash
  redis-cli -h <master-ip> -p 6379 info replication
  ```
  
  如果主从复制正常，会显示以下信息：
  
  ```bash
  role:master
  connected_slaves:1
  ```

```bashs
# Replication  # 复制信息部分
role:master  # 当前节点的角色是“主节点”
connected_slaves:0  # 当前没有连接的从节点
master_failover_state:no-failover  # 主节点没有进行故障转移（即没有故障转移的状态）
master_replid:0cab78c51791cc4da6a6894e37e87edcd15cd452  # 主节点的复制ID
master_replid2:0000000000000000000000000000000000000000  # 第二个复制ID（通常用于保存备份的复制ID）
master_repl_offset:0  # 主节点的复制偏移量，表示当前已复制的字节数
second_repl_offset:-1  # 第二个复制偏移量（没有第二个复制源，所以显示为-1）
repl_backlog_active:0  # 复制积压缓冲区是否处于活动状态，0表示没有活动的积压
repl_backlog_size:1048576  # 复制积压缓冲区的大小（字节），此处为 1 MB
repl_backlog_first_byte_offset:0  # 复制积压缓冲区的第一个字节偏移量
repl_backlog_histlen:0  # 复制积压历史的长度，即历史上有多少字节的积压数据
```



#### 1.2 使用 `ps` 或 `systemctl` 查看 Redis 服务是否正常运行

- **检查 Redis 服务状态（systemd）**： 如果 Redis 是通过 `systemd` 管理的服务，您可以使用以下命令检查 Redis 服务的状态：

  ```bash
  sudo systemctl status redis
  ```

  如果 Redis 正常运行，应该看到类似于以下输出：

  ```bash
  ● redis.service - Redis In-Memory Data Store
     Loaded: loaded (/etc/systemd/system/redis.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2024-11-28 13:45:00 CST; 1h 5min ago
   Main PID: 12345 (redis-server)
     CGroup: /system.slice/redis.service
             └─12345 /usr/local/bin/redis-server 127.0.0.1:6379
  ```

- **检查 Redis 进程**： 使用 `ps` 命令查看 Redis 是否在运行：

  ```bash
  ps aux | grep redis
  ```

  如果 Redis 正常运行，您将看到类似于以下的输出：

  ```bash
  redis     12345  0.1  0.5 130000 2560 ?        Ssl  13:45   0:00 /usr/local/bin/redis-server 127.0.0.1:6379
  ```

#### 1.3 使用 `redis-server` 查看日志

Redis 也会记录一些运行时日志，您可以查看日志文件以诊断问题。通常，Redis 的日志位置可以在 `redis.conf` 配置文件中找到，或者使用默认路径 `/var/log/redis/redis-server.log`。

查看日志：

```bash
tail -f /var/log/redis/redis-server.log
```

#### 1.4 检查 Redis 响应时间

可以通过运行 `ping` 命令来快速检查 Redis 是否响应：

```bash
redis-cli -h 127.0.0.1 -p 6379 ping
```

如果 Redis 正常工作，将返回：

```bash
PONG
```

### 2. **常见运维动作**

在 Redis 部署成功后，以下是一些常见的运维动作，可以帮助您保持 Redis 的稳定性和高效性。

#### 2.1 定期检查 Redis 内存使用情况

Redis 是基于内存的数据库，因此，内存管理非常重要。可以定期检查 Redis 使用的内存是否超过了预定的限制。

查看内存使用情况：

```bash
redis-cli info memory
```

```bash
# Memory  # 内存信息部分
used_memory:874336  # Redis 已使用的内存（字节），此处为 874,336 字节（约 853.84 KB）
used_memory_human:853.84K  # Redis 已使用的内存（以可读格式显示）
used_memory_rss:14680064  # Redis 在操作系统中占用的物理内存（包括所有内存分配的物理页面），此处为 14,680,064 字节（约 14 MB）
used_memory_rss_human:14.00M  # Redis 在操作系统中占用的物理内存（以可读格式显示）
used_memory_peak:934224  # Redis 在过去使用的最大内存量，峰值内存（字节），此处为 934,224 字节（约 912.33 KB）
used_memory_peak_human:912.33K  # Redis 在过去使用的最大内存量（以可读格式显示）
used_memory_peak_perc:93.59%  # 当前内存使用量占峰值内存的百分比，93.59% 表示目前已接近最大使用内存
used_memory_overhead:812184  # 内存管理开销，指分配内存用于 Redis 的数据结构和管理功能，而不是存储实际数据
used_memory_startup:812184  # Redis 启动时的内存使用量（字节）
used_memory_dataset:62152  # Redis 存储数据的内存（字节），此处为 62,152 字节（约 61 KB）
used_memory_dataset_perc:100.00%  # 存储数据的内存占 Redis 总内存的比例，100% 表示几乎所有内存都用于存储数据
allocator_allocated:968536  # 分配器分配的内存量（字节），此处为 968,536 字节（约 948 KB）
allocator_active:1265664  # 当前分配器活跃的内存量（字节），此处为 1,265,664 字节（约 1.2 MB）
allocator_resident:3784704  # 分配器实际使用的物理内存量（字节），此处为 3,784,704 字节（约 3.6 MB）
total_system_memory:7792852992  # 系统的总内存（字节），此处为 7,792,852,992 字节（约 7.26 GB）
total_system_memory_human:7.26G  # 系统的总内存（以可读格式显示）
used_memory_lua:30720  # Lua 脚本执行时所使用的内存（字节），此处为 30,720 字节（约 30 KB）
used_memory_lua_human:30.00K  # Lua 脚本执行时所使用的内存（以可读格式显示）
used_memory_scripts:0  # 存储已缓存的 Lua 脚本的内存，当前为 0 字节
used_memory_scripts_human:0B  # 存储已缓存的 Lua 脚本的内存（以可读格式显示）
number_of_cached_scripts:0  # 缓存的 Lua 脚本数量，当前为 0 个脚本
maxmemory:0  # 配置的最大内存限制，0 表示没有限制
maxmemory_human:0B  # 配置的最大内存限制（以可读格式显示）
maxmemory_policy:noeviction  # 当内存超过配置的最大值时的处理策略，"noeviction" 表示不驱逐任何数据
allocator_frag_ratio:1.31  # 分配器的内存碎片比例，1.31 表示当前的碎片比率
allocator_frag_bytes:297128  # 内存碎片的字节数，297,128 字节（约 290 KB）
allocator_rss_ratio:2.99  # 分配器实际使用的物理内存与分配内存的比例，2.99 表示分配器在物理内存中占用了接近三倍的内存
allocator_rss_bytes:2519040  # 分配器实际使用的物理内存（字节），2,519,040 字节（约 2.4 MB）
rss_overhead_ratio:3.88  # Redis 内存使用的物理内存相对于实际数据的比例，3.88 表示每存储一字节的数据，Redis 会使用接近 4 字节的物理内存
rss_overhead_bytes:10895360  # 内存开销的字节数，10,895,360 字节（约 10.4 MB）
mem_fragmentation_ratio:18.07  # 内存碎片比例，18.07 表示内存碎片非常严重
mem_fragmentation_bytes:13867696  # 内存碎片的字节数，13,867,696 字节（约 13.2 MB）
mem_not_counted_for_evict:0  # 不会被驱逐的内存量，0 表示没有此类内存
mem_replication_backlog:0  # 复制积压的内存，0 表示没有积压
mem_clients_slaves:0  # 客户端从节点占用的内存，0 表示没有
mem_clients_normal:0  # 客户端普通连接占用的内存，0 表示没有
mem_aof_buffer:0  # AOF 缓冲区占用的内存，0 表示没有
mem_allocator:jemalloc-5.1.0  # 使用的内存分配器类型，jemalloc 版本为 5.1.0
active_defrag_running:0  # 是否正在运行主动碎片整理，0 表示没有
lazyfree_pending_objects:0  # 延迟释放的对象数量，0 表示没有待释放的对象
lazyfreed_objects:0  # 已释放的延迟对象数量，0 表示没有
```



- [ ] **maxmemory**: Redis 的最大内存限制。如果 Redis 达到该限制，您可以配置淘汰策略（如 LRU）。
- [ ] **used_memory**: Redis 已使用的内存大小。
- [ ] **maxmemory_policy**: 设置的淘汰策略，例如 `volatile-lru`（过期键的 LRU 策略）或 `allkeys-lru`。

#### 2.2 设置和调整最大内存限制

为了防止 Redis 使用过多内存，可以通过设置 `maxmemory` 来限制 Redis 使用的最大内存。如果 Redis 达到这个限制，它会按照设定的淘汰策略来处理。

例如，在 `redis.conf` 文件中设置最大内存限制为 2GB：

```bash
maxmemory 2gb
maxmemory-policy allkeys-lru
```

#### 2.3 配置持久化策略

Redis 提供了两种主要的持久化机制：RDB（快照）和 AOF（追加文件）。可以根据业务需求进行适当配置。

- **RDB 持久化**：定期生成快照，存储数据。
- **AOF 持久化**：记录所有写操作，保证数据的持久性。

在 `redis.conf` 中，您可以配置 RDB 和 AOF 的行为：

- RDB 配置示例：

  ```bash
  save 900 1
  save 300 10
  save 60 10000
  ```

- AOF 配置示例：

  ```bash
  appendonly yes
  appendfsync everysec
  ```

#### 2.4 监控 Redis 运行状态

使用 **Redis Sentinel** 或 **其他监控工具**（如 Prometheus + Redis Exporter）来监控 Redis 集群和实例的健康状况。

- **Redis Sentinel**：用来监控 Redis 实例的状态，进行故障转移和高可用性配置。
- **Prometheus 和 Grafana**：通过 Prometheus 的 Redis Exporter 收集 Redis 的指标数据，使用 Grafana 绘制可视化的监控面板。

#### 2.5 设置备份和恢复策略

确保 Redis 数据有备份机制，以便在灾难发生时能恢复数据。您可以定期备份 RDB 文件或 AOF 文件。

- 备份 RDB 文件：

  ```bash
  cp /var/lib/redis/dump.rdb /path/to/backup/dump.rdb
  ```

- 备份 AOF 文件：

  ```bash
  cp /var/lib/redis/appendonly.aof /path/to/backup/appendonly.aof
  ```

#### 2.6 进行容量规划和扩容

随着 Redis 的数据量增加，可能需要进行扩容。您可以通过增加 Redis 从节点来分担负载，或者使用 Redis Cluster 实现分布式部署。

#### 2.7 配置 Redis 日志

Redis 的日志配置位于 `redis.conf` 文件中。可以设置日志级别、日志输出位置等。

例如：

```bash
loglevel notice
logfile /var/log/redis/redis-server.log
```

### 总结

通过以上命令和方法，您可以有效监控 Redis 的状态，并执行常见的运维任务。定期检查内存使用、持久化策略、主从复制状态等是确保 Redis 稳定运行的关键措施。同时，使用 Redis Sentinel 或 Prometheus 进行高效的监控和告警也非常重要。

如果有更具体的运维需求或问题，欢迎继续提问！
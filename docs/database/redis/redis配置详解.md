```bash
[root@VM-0-16-centos ~]# cat /etc/redis/redis.conf | grep -v "^[[:blank:]]*#"  | grep -v '^#' | grep -v '^$'                                                                   
bind 127.0.0.1 -::1                                                                                                                                                            # 绑定 Redis 仅在本地可访问 (IPv4 和 IPv6)
protected-mode yes                                                                                                                                                              # 启用保护模式，限制外部访问，增强安全性
port 6379                                                                                                                                                                      
# 设置 Redis 服务监听的端口，默认是 6379
tcp-backlog 511                                                                                                                                                                
# 设置 TCP backlog 的大小（队列长度），影响连接排队的数量
timeout 0                                                                                                                                                                      
# 客户端超时，0表示不启用超时
tcp-keepalive 300                                                                                                                                                               # 设置 TCP 保活时间，300秒
daemonize yes                                                                                                                                                                  
# 是否以守护进程方式启动 Redis，yes 表示后台运行
pidfile /var/run/redis_6379.pid                                                                                                                                                
# Redis 进程的 PID 文件路径
loglevel notice                                                                                                                                                                
# 设置日志级别，支持 debug、verbose、notice、warning，默认是 notice
logfile /var/log/redis/redis.log                                                                                                                                               
# 设置 Redis 的日志文件路径
databases 16                                                                                                                                                                   
# 设置 Redis 实例支持的数据库数量，默认是 16
always-show-logo no                                                                                                                                                            
# 是否每次启动时显示 Redis 标志
set-proc-title yes                                                                                                                                                             
# 是否设置进程名称
proc-title-template "{title} {listen-addr} {server-mode}"                                                                                                                      
# 设置进程名称模板
stop-writes-on-bgsave-error yes                                                                                                                                                
# 如果后台保存 RDB 文件失败，是否停止写入数据
rdbcompression yes                                                                                                                                                             
# 是否启用 RDB 文件压缩
rdbchecksum yes                                                                                                                                                                
# 启用 RDB 文件校验和检查
dbfilename dump.rdb                                                                                                                                                            
# 设置 RDB 数据库文件的名称
rdb-del-sync-files no                                                                                                                                                          
# 是否删除同步文件
dir /var/lib/redis                                                                                                                                                             
# 设置 Redis 存储数据文件的目录
replica-serve-stale-data yes                                                                                                                                                   
# 设置从节点是否服务过期数据
replica-read-only yes                                                                                                                                                          
# 设置从节点是否只读
repl-diskless-sync no                                                                                                                                                          
# 是否启用无盘同步
repl-diskless-sync-delay 5                                                                                                                                                     
# 设置从节点无盘同步的延迟时间，单位秒
repl-diskless-load disabled                                                                                                                                                    
# 禁用从节点的无盘数据加载
repl-disable-tcp-nodelay no                                                                                                                                                    
# 是否禁用 TCP_NODELAY，减少延迟
replica-priority 100                                                                                                                                                           
# 设置从节点的优先级，优先级越高被选为主节点的可能性越大
acllog-max-len 128                                                                                                                                                             
# 设置访问控制列表（ACL）日志的最大长度
lazyfree-lazy-eviction no                                                                                                                                                      
# 是否启用惰性释放过期的键
lazyfree-lazy-expire no                                                                                                                                                        
# 是否启用惰性释放过期的键值对
lazyfree-lazy-server-del no                                                                                                                                                    
# 是否启用惰性释放服务器删除操作
replica-lazy-flush no                                                                                                                                                          
# 是否启用从节点的惰性刷新
lazyfree-lazy-user-del no                                                                                                                                                      
# 是否启用惰性释放用户删除操作
lazyfree-lazy-user-flush no                                                                                                                                                    
# 是否启用惰性刷新用户操作
oom-score-adj no                                                                                                                                                                
# 是否启用 OOM（内存不足）调整
oom-score-adj-values 0 200 800                                                                                                                                                 
# 配置 OOM 时，Redis 会根据这个设置调整进程的 OOM 优先级
disable-thp yes                                                                                                                                                                
# 禁用透明大页（Transparent Huge Pages），提高内存性能
appendonly no                                                                                                                                                                  
# 是否启用 AOF 持久化，no 表示禁用
appendfilename "appendonly.aof"                                                                                                                                                
# 设置 AOF 文件的文件名
appendfsync everysec                                                                                                                                                           
# 设置 AOF 刷新策略：每秒一次
no-appendfsync-on-rewrite no                                                                                                                                                   
# 在重写 AOF 时是否禁用同步
auto-aof-rewrite-percentage 100                                                                                                                                                
# AOF 文件增长百分比，达到时会触发 AOF 重写
auto-aof-rewrite-min-size 64mb                                                                                                                                                 
# AOF 文件的最小大小，低于此大小不会触发自动重写
aof-load-truncated yes                                                                                                                                                         
# 是否加载截断的 AOF 文件
aof-use-rdb-preamble yes                                                                                                                                                       
# 是否使用 RDB 文件的前导信息来恢复 AOF 文件
lua-time-limit 5000                                                                                                                                                            
# 设置 Lua 脚本的执行最大时间（毫秒）
slowlog-log-slower-than 10000                                                                                                                                                  
# 设置慢查询日志阈值，单位是微秒
slowlog-max-len 128                                                                                                                                                            
# 设置慢查询日志的最大长度
latency-monitor-threshold 0                                                                                                                                                    
# 设置延迟监控的阈值（毫秒），如果为 0，则禁用延迟监控
notify-keyspace-events ""                                                                                                                                                      
# 配置键空间通知的事件类型
hash-max-ziplist-entries 512                                                                                                                                                   
# 设置哈希表压缩列表的最大条目数
hash-max-ziplist-value 64                                                                                                                                                      
# 设置哈希表压缩列表的最大值大小（字节）
list-max-ziplist-size -2                                                                                                                                                       
# 设置列表压缩列表的最大大小，-2 表示禁用
list-compress-depth 0                                                                                                                                                          
# 设置列表压缩的深度
set-max-intset-entries 512                                                                                                                                                     
# 设置集合使用整数集合的最大条目数
zset-max-ziplist-entries 128                                                                                                                                                   
# 设置有序集合使用压缩列表的最大条目数
zset-max-ziplist-value 64                                                                                                                                                      
# 设置有序集合压缩列表的最大值大小（字节）
hll-sparse-max-bytes 3000                                                                                                                                                      
# 设置 HyperLogLog 数据结构的最大字节数
stream-node-max-bytes 4096                                                                                                                                                     
# 设置流数据结构中每个节点的最大字节数
stream-node-max-entries 100                                                                                                                                                    
# 设置流数据结构中每个节点的最大条目数
activerehashing yes                                                                                                                                                            
# 启用哈希表的激活重哈希操作，避免 Redis 在操作期间出现阻塞
client-output-buffer-limit normal 0 0 0                                                                                                                                        
# 设置普通客户端的输出缓冲区限制
client-output-buffer-limit replica 256mb 64mb 60                                                                                                                               
# 设置从节点客户端的输出缓冲区限制
client-output-buffer-limit pubsub 32mb 8mb 60                                                                                                                                  
# 设置发布/订阅客户端的输出缓冲区限制
hz 10                                                                                                                                                                          
# Redis 执行周期性的事件（例如后台保存）频率，单位为 Hz
dynamic-hz yes                                                                                                                                                                 
# 启用动态事件周期，根据负载自动调整 hz 的频率
aof-rewrite-incremental-fsync yes                                                                                                                                              
# 启用 AOF 重写时的增量同步
rdb-save-incremental-fsync yes                                                                                                                                                 
# 启用 RDB 保存时的增量同步
jemalloc-bg-thread yes     
# 启用 jemalloc 内存分配器的后台线程，优化内存管理
```





Redis 作为缓存系统，常见的优化设置包括以下几个方面，旨在提高性能、减少延迟、提升稳定性和扩展性。下面是一些常见的优化配置：

### 1. **内存管理优化**

- **maxmemory**
   设置 Redis 实例的最大内存限制，当内存达到限制时，Redis 会根据 `maxmemory-policy` 策略进行驱逐。

  ```bash
  maxmemory 2gb                # 设置 Redis 最大内存为 2GB
  ```

- **maxmemory-policy**
   控制在达到最大内存限制时，Redis 驱逐键的策略。常见的策略包括：

  - [ ] `volatile-lru`：只驱逐设置了过期时间的键，使用 LRU (Least Recently Used) 算法。
  - [ ] `allkeys-lru`：驱逐所有键，使用 LRU 算法。
  - [ ] `volatile-ttl`：仅驱逐设置了过期时间的键，优先驱逐 TTL 最近到期的键。
  - [ ] `noeviction`：不驱逐任何键，直接返回错误。

  ```bash
  maxmemory-policy allkeys-lru    # 使用 LRU 算法驱逐最久未使用的键
  ```

- **jemalloc 内存分配器**
   Redis 默认使用 jemalloc 作为内存分配器，它优化了内存的使用效率，减少内存碎片，特别是在高并发下表现更好。可以通过 `jemalloc-bg-thread` 来启用后台线程优化内存管理：

  ```bash
  jemalloc-bg-thread yes          # 启用 jemalloc 的后台线程
  ```

### 2. **持久化优化**

- **关闭持久化（仅做缓存使用）**
   如果 Redis 仅作为缓存系统，且不需要持久化数据，可以禁用 AOF 和 RDB 持久化，以减少 I/O 操作，提高性能。

  ```bash
  save ""                        # 禁用 RDB 持久化（不要自动保存）
  appendonly no                  # 禁用 AOF 持久化
  ```

- **AOF 持久化优化**
   如果需要启用 AOF，优化配置如下：

  - [ ] `appendfsync everysec`：每秒将写操作刷入磁盘一次，平衡了性能与数据安全。
  - [ ] `no-appendfsync-on-rewrite`：在 AOF 重写期间不强制刷写磁盘，减少延迟。

  ```bash
  appendonly yes                 # 启用 AOF 持久化
  appendfsync everysec           # 每秒同步一次
  no-appendfsync-on-rewrite yes  # 在 AOF 重写期间不强制同步
  ```

- **RDB 持久化优化**
   配置较低频率的 RDB 快照，减少对磁盘的写入操作。

  ```bash
  save 900 1                     # 每 15 分钟保存一次 RDB 快照
  save 300 10                    # 每 5 分钟保存一次快照（如果有 10 次写操作）
  ```

### 3. **网络配置优化**

- **tcp-keepalive**
   设置 TCP 连接的保持活动时间，减少因长时间空闲导致的连接断开。

  ```bash
  tcp-keepalive 300               # 设置 TCP keepalive 时间为 5 分钟
  ```

- **调整客户端输出缓冲区限制**
   优化客户端的输出缓冲区，以防止由于大量数据返回导致的内存过载。

  ```bash
  client-output-buffer-limit normal 0 0 0       # 不限制普通客户端输出缓冲区
  client-output-buffer-limit replica 256mb 64mb 60 # 设置从节点的输出缓冲区限制
  client-output-buffer-limit pubsub 32mb 8mb 60   # 设置发布/订阅客户端的缓冲区限制
  ```

- **bind 和 protected-mode**
   限制 Redis 仅绑定到本地接口，增强安全性，防止外部攻击。

  ```bash
  bind 127.0.0.1                   # 仅绑定本地接口
  protected-mode yes               # 启用保护模式，禁止外部访问
  ```

### 4. **性能优化**

- **hash-max-ziplist-entries & hash-max-ziplist-value**
   使用压缩列表（Ziplist）存储小的哈希数据，减少内存使用。

  ```bash
  hash-max-ziplist-entries 512    # 哈希表项数目超过 512 时，不使用压缩列表
  hash-max-ziplist-value 64       # 哈希值超过 64 字节时，不使用压缩列表
  ```

- **list-max-ziplist-size & list-compress-depth**
   设置列表使用压缩列表的大小和深度，以减少内存使用。

  ```bash
  list-max-ziplist-size -2        # 禁用列表压缩列表
  list-compress-depth 0           # 禁用列表压缩
  ```

- **zset-max-ziplist-entries & zset-max-ziplist-value**
   设置有序集合使用压缩列表的最大条目数和最大值大小。

  ```bash
  zset-max-ziplist-entries 128    # 有序集合最大条目数为 128
  zset-max-ziplist-value 64       # 有序集合中单个值的最大字节数
  ```

- **client-output-buffer-limit**
   控制客户端的输出缓冲区，防止过多数据积压导致内存占用过高。

  ```bash
  client-output-buffer-limit normal 0 0 0     # 默认没有限制
  client-output-buffer-limit replica 256mb 64mb 60
  ```

### 5. **其他优化**

- **活跃重哈希（active-rehashing）**
   启用哈希表的动态重哈希操作，避免 Redis 在操作期间出现阻塞。

  ```bash
  activerehashing yes               # 启用活跃重哈希
  ```

- **slowlog-log-slower-than**
   配置慢查询日志的阈值，记录超过指定时间的查询操作，帮助识别性能瓶颈。

  ```bash
  slowlog-log-slower-than 10000     # 记录执行时间超过 10 毫秒的查询
  slowlog-max-len 128               # 设置慢查询日志的最大长度
  ```

- **动态调整 `hz` 参数**
   Redis 的 `hz` 参数影响后台任务的频率，动态调整可以根据负载优化性能。

  ```bash
  dynamic-hz yes                    # 根据负载动态调整
  hz 10                             # 设置默认的 hz 值
  ```

### 6. **高可用与集群优化**

- **启用集群模式（Cluster Mode）**
   如果使用 Redis 集群，可以启用集群模式以支持横向扩展。

  ```bash
  cluster-enabled yes               # 启用 Redis 集群模式
  cluster-config-file nodes.conf   # 设置集群配置文件路径
  ```

- **复制优化（replica）**
   在从节点中配置适当的设置以提高数据同步性能，避免影响主节点的性能。

  ```bash
  replica-read-only yes             # 设置从节点为只读模式
  replica-priority 100              # 设置从节点的优先级
  ```

这些设置是 Redis 常见的优化配置，可以根据你的业务需求和 Redis 实际使用情况进行调整。
Redis info信息含义

```bash
127.0.0.1:6379> info
# Server
redis_version:6.2.16  # Redis 的版本号
redis_git_sha1:00000000  # Redis 的 Git 提交 ID
redis_git_dirty:0  # 是否为脏版本，表示是否有未提交的更改
redis_build_id:85a2e85bf3a77649  # Redis 构建 ID
redis_mode:standalone  # Redis 模式（standalone：独立模式）
os:Linux 5.14.0-202.el9.x86_64 x86_64  # Redis 所在操作系统信息
arch_bits:64  # Redis 所在系统的位数（64 位）
monotonic_clock:POSIX clock_gettime  # 使用的单调时钟
multiplexing_api:epoll  # 使用的多路复用 API（epoll：Linux 系统的高效 I/O 复用模型）
atomicvar_api:c11-builtin  # 使用的原子变量 API
gcc_version:11.5.0  # 编译 Redis 所用的 GCC 版本
process_id:777504  # Redis 进程的 ID
process_supervised:systemd  # Redis 是否被系统守护程序管理（如 systemd）
run_id:5ccd9c38e3330b7a0245a212967907805f85604c  # Redis 实例的唯一运行 ID
tcp_port:6379  # Redis 监听的 TCP 端口
server_time_usec:1732785998255662  # Redis 启动时间的精确时间戳
uptime_in_seconds:162  # Redis 已经运行的时间（单位：秒）
uptime_in_days:0  # Redis 已经运行的天数
hz:10  # Redis 的事件循环频率（每秒钟执行多少次事件）
configured_hz:10  # 配置文件中设置的事件循环频率
lru_clock:4732750  # Redis 内部的 LRU 时钟，用于处理过期键
executable:/usr/bin/redis-server  # Redis 可执行文件的路径
config_file:/etc/redis/redis.conf  # Redis 配置文件的路径
io_threads_active:0  # 当前活动的 I/O 线程数（0 表示没有使用 I/O 线程）

# Clients
connected_clients:1  # 当前连接到 Redis 的客户端数量
cluster_connections:0  # Redis 集群模式下的连接数（当前没有启用集群）
maxclients:10000  # Redis 允许的最大客户端连接数
client_recent_max_input_buffer:16  # 最近客户端连接的最大输入缓冲区大小（字节）
client_recent_max_output_buffer:0  # 最近客户端连接的最大输出缓冲区大小（字节）
blocked_clients:0  # 当前被阻塞的客户端数（例如等待阻塞命令的客户端）
tracking_clients:0  # 当前启用键跟踪的客户端数
clients_in_timeout_table:0  # 当前超时客户端的数量

# Memory
used_memory:875952  # Redis 当前使用的内存（字节）
used_memory_human:855.42K  # Redis 当前使用的内存（以人类可读格式显示）
used_memory_rss:14651392  # Redis 使用的 RSS 内存（包括操作系统的缓存）
used_memory_rss_human:13.97M  # Redis 使用的 RSS 内存（以人类可读格式显示）
used_memory_peak:934096  # Redis 曾经使用的最大内存量（字节）
used_memory_peak_human:912.20K  # Redis 曾经使用的最大内存量（以人类可读格式显示）
used_memory_peak_perc:93.78%  # 当前内存使用量占最大内存使用量的百分比
used_memory_overhead:832680  # Redis 内存开销（内部数据结构等占用的内存）
used_memory_startup:812184  # Redis 启动时分配的内存量（字节）
used_memory_dataset:43272  # Redis 存储的数据占用的内存量（字节）
used_memory_dataset_perc:67.86%  # 数据集占总内存的百分比
allocator_allocated:927024  # Redis 内存分配器分配的内存量（字节）
allocator_active:1200128  # Redis 内存分配器当前活跃的内存量（字节）
allocator_resident:3719168  # Redis 内存分配器分配的常驻内存量（字节）
total_system_memory:7792852992  # 系统的总内存量（字节）
total_system_memory_human:7.26G  # 系统的总内存量（以人类可读格式显示）
used_memory_lua:30720  # 用于 Lua 脚本的内存量（字节）
used_memory_lua_human:30.00K  # 用于 Lua 脚本的内存量（以人类可读格式显示）
used_memory_scripts:0  # Lua 脚本的缓存内存
used_memory_scripts_human:0B  # Lua 脚本的缓存内存（以人类可读格式显示）
number_of_cached_scripts:0  # 缓存的 Lua 脚本数量
maxmemory:0  # Redis 配置的最大内存限制（0 表示没有限制）
maxmemory_human:0B  # Redis 配置的最大内存限制（以人类可读格式显示）
maxmemory_policy:noeviction  # Redis 当内存达到最大限制时的行为策略（noeviction：不驱逐任何键）
allocator_frag_ratio:1.29  # 内存分配器碎片化比率（分配内存和活跃内存的比值）
allocator_frag_bytes:273104  # 内存分配器碎片化字节数
allocator_rss_ratio:3.10  # 内存分配器的 RSS 内存比率（RSS 内存和活跃内存的比值）
allocator_rss_bytes:2519040  # 内存分配器的 RSS 内存占用字节数
rss_overhead_ratio:3.94  # Redis 使用的 RSS 内存相对于分配内存的比率
rss_overhead_bytes:10932224  # Redis 使用的 RSS 内存相对于分配内存的字节数
mem_fragmentation_ratio:17.58  # 内存碎片化比率
mem_fragmentation_bytes:13818208  # 内存碎片化的字节数
mem_not_counted_for_evict:0  # 不能计入驱逐操作的内存量
mem_replication_backlog:0  # 复制积压队列占用的内存量
mem_clients_slaves:0  # 从节点的客户端占用的内存量
mem_clients_normal:20496  # 正常客户端占用的内存量
mem_aof_buffer:0  # AOF 缓冲区占用的内存量
mem_allocator:jemalloc-5.1.0  # Redis 使用的内存分配器（jemalloc）
active_defrag_running:0  # 是否正在运行主动碎片整理
lazyfree_pending_objects:0  # 待释放的懒释放对象数量
lazyfreed_objects:0  # 已释放的懒释放对象数量

# Persistence
loading:0  # 是否正在加载 RDB 文件
current_cow_size:0  # 当前写时复制（COW）内存的大小
current_cow_size_age:0  # 当前写时复制内存的年龄
current_fork_perc:0.00  # 当前 fork 操作的百分比
current_save_keys_processed:0  # 当前保存的键的数量
current_save_keys_total:0  # 当前保存的键的总数
rdb_changes_since_last_save:0  # 自上次 RDB 保存以来的键更改数
rdb_bgsave_in_progress:0  # 是否正在进行 RDB 后台保存
rdb_last_save_time:1732785836  # 上次 RDB 保存的时间戳
rdb_last_bgsave_status:ok  # 上次 RDB 后台保存的状态
rdb_last_bgsave_time_sec:-1  # 上次 RDB 后台保存耗时（秒）
rdb_current_bgsave_time_sec:-1  # 当前 RDB 后台保存耗时（秒）
rdb_last_cow_size:0  # 上次写时复制的内存大小
aof_enabled:0  # 是否启用 AOF 持久化
aof_rewrite_in_progress:0  # 是否正在进行 AOF 重写
aof_rewrite_scheduled:0  # 是否有计划进行 AOF 重写
aof_last_rewrite_time_sec:-1  # 上次 AOF 重写的耗时（秒）
aof_current_rewrite_time_sec:-1  # 当前 AOF 重写的耗时（秒）
aof_last_bgrewrite_status:ok  # 上次 AOF 后台重写状态
aof_last_write_status:ok  # 上

次 AOF 写入状态
aof_last_cow_size:0  # 上次写时复制的 AOF 内存大小
module_fork_in_progress:0  # 是否正在进行模块的 fork 操作
module_fork_last_cow_size:0  # 上次模块 fork 的写时复制内存大小

# Stats
total_connections_received:5  # Redis 接收到的总连接数
total_commands_processed:5  # Redis 处理的总命令数
instantaneous_ops_per_sec:0  # 当前每秒处理的命令数
total_net_input_bytes:208  # 自 Redis 启动以来接收到的总字节数
total_net_output_bytes:40801  # 自 Redis 启动以来发送的总字节数
instantaneous_input_kbps:0.00  # 当前输入网络流量（千字节每秒）
instantaneous_output_kbps:0.00  # 当前输出网络流量（千字节每秒）
rejected_connections:0  # 被拒绝的连接数
sync_full:0  # 完成的全量同步操作数
sync_partial_ok:0  # 部分成功的同步操作数
sync_partial_err:0  # 部分失败的同步操作数
expired_keys:0  # 过期的键数
expired_stale_perc:0.00  # 过期键的百分比
expired_time_cap_reached_count:0  # 达到过期时间限制的次数
expire_cycle_cpu_milliseconds:1  # 处理过期键时，Redis 在 CPU 上花费的时间（毫秒）
evicted_keys:0  # 被淘汰的键数
keyspace_hits:0  # 命中的键空间数量
keyspace_misses:0  # 未命中的键空间数量
pubsub_channels:0  # 当前订阅的频道数
pubsub_patterns:0  # 当前订阅的模式数
latest_fork_usec:0  # 最近一次 fork 操作花费的时间（微秒）
total_forks:0  # Redis 执行的 fork 操作总次数
migrate_cached_sockets:0  # 迁移操作缓存的套接字数
slave_expires_tracked_keys:0  # 从节点中跟踪过期键的数量
active_defrag_hits:0  # 主动碎片整理操作命中的键数
active_defrag_misses:0  # 主动碎片整理操作未命中的键数
active_defrag_key_hits:0  # 主动碎片整理操作命中的键数（具体）
active_defrag_key_misses:0  # 主动碎片整理操作未命中的键数（具体）
tracking_total_keys:0  # 跟踪的键总数
tracking_total_items:0  # 跟踪的项总数
tracking_total_prefixes:0  # 跟踪的前缀总数
unexpected_error_replies:0  # 返回的意外错误回复数量
total_error_replies:4  # 总的错误回复数
dump_payload_sanitizations:0  # 反序列化的负载清理次数
total_reads_processed:14  # 读取操作的总次数
total_writes_processed:9  # 写入操作的总次数
io_threaded_reads_processed:0  # 多线程读取操作处理的次数
io_threaded_writes_processed:0  # 多线程写入操作处理的次数
```


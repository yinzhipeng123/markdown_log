 `INFO stats` 输出内容，保留原格式并在每行后面添加注释说明：

```bash
127.0.0.1:6379> INFO stats
# Stats
total_connections_received:13  # Redis 接收到的客户端连接总数
total_commands_processed:22  # Redis 处理的命令总数
instantaneous_ops_per_sec:0  # 当前每秒处理的命令数量
total_net_input_bytes:1049  # 自 Redis 启动以来，接收到的总字节数
total_net_output_bytes:126731  # 自 Redis 启动以来，发送的总字节数
instantaneous_input_kbps:0.00  # 当前输入的网络流量（千字节每秒）
instantaneous_output_kbps:0.00  # 当前输出的网络流量（千字节每秒）
rejected_connections:0  # 被拒绝的连接数
sync_full:0  # 完成的全量同步操作数
sync_partial_ok:0  # 部分成功的同步操作数
sync_partial_err:0  # 部分失败的同步操作数
expired_keys:1  # 过期的键数
expired_stale_perc:0.00  # 过期键的百分比
expired_time_cap_reached_count:0  # 达到过期时间限制的次数
expire_cycle_cpu_milliseconds:623  # 处理过期键时，Redis 在 CPU 上花费的时间（毫秒）
evicted_keys:0  # 被淘汰的键数
keyspace_hits:2  # 命中的键空间数量（缓存命中）
keyspace_misses:1  # 未命中的键空间数量（缓存未命中）
pubsub_channels:0  # 当前订阅的频道数
pubsub_patterns:0  # 当前订阅的模式数
latest_fork_usec:357  # 最近一次 fork 操作花费的时间（微秒）
total_forks:1  # Redis 执行的 fork 操作总次数
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
total_error_replies:13  # 总的错误回复数
dump_payload_sanitizations:0  # 反序列化的负载清理次数
total_reads_processed:44  # 读取操作的总次数
total_writes_processed:31  # 写入操作的总次数
io_threaded_reads_processed:0  # 多线程读取操作处理的次数
io_threaded_writes_processed:0  # 多线程写入操作处理的次数
```
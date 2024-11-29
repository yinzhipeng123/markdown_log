Redis 支持多种数据类型，超越了传统数据库中的基本键值对模型。Redis 的数据类型使其能够高效地存储和处理复杂的数据结构。下面是 Redis 支持的主要数据类型及其特点：

### 1. **字符串（String）**

- **描述**：这是 Redis 中最基本的数据类型，可以存储任何形式的数据，如字符串、整数、浮点数、甚至是二进制数据（如图片、文件等）。

- **常见命令**：

  - `SET key value`：设置字符串值。
  - `GET key`：获取字符串值。
  - `INCR key`：将存储在 key 中的数字值加 1。
  - `DECR key`：将存储在 key 中的数字值减 1。
  - `APPEND key value`：将一个值追加到字符串的末尾。

  **示例**：

  ```bash
  SET user:1234 "John"
  GET user:1234
  ```

### 2. **哈希（Hash）**

- **描述**：哈希是一个键值对集合，可以用来表示对象。每个哈希包含多个字段，每个字段都有自己的值。哈希非常适合存储对象类型的数据。

- **常见命令**：

  - `HSET key field value`：设置哈希表字段的值。
  - `HGET key field`：获取哈希表字段的值。
  - `HGETALL key`：获取哈希表的所有字段和值。
  - `HDEL key field`：删除哈希表中的字段。

  **示例**：

  ```bash
  HSET user:1234 name "John" age 30
  HGET user:1234 name
  HGETALL user:1234
  ```

### 3. **列表（List）**

- **描述**：列表是一种有序的字符串集合，元素按插入顺序排序。Redis 提供了许多命令来操作列表，可以实现队列、栈等数据结构。

- **常见命令**：

  - `LPUSH key value`：在列表的左边插入一个元素。
  - `RPUSH key value`：在列表的右边插入一个元素。
  - `LPOP key`：移除并返回列表左边的元素。
  - `RPOP key`：移除并返回列表右边的元素。
  - `LRANGE key start stop`：返回列表中指定范围的元素。

  **示例**：

  ```bash
  LPUSH mylist "A"
  RPUSH mylist "B"
  LRANGE mylist 0 -1
  ```

### 4. **集合（Set）**

- **描述**：集合是一个无序的字符串集合，不允许重复元素。集合非常适合用来进行交集、并集、差集等操作。

- **常见命令**：

  - `SADD key member`：将元素添加到集合。
  - `SMEMBERS key`：返回集合中所有的成员。
  - `SPOP key`：移除并返回集合中的一个随机元素。
  - `SINTER key1 key2`：返回两个集合的交集。
  - `SUNION key1 key2`：返回两个集合的并集。
  - `SDIFF key1 key2`：返回两个集合的差集。

  **示例**：

  ```bash
  SADD myset "A" "B" "C"
  SMEMBERS myset
  SPOP myset
  ```

### 5. **有序集合（Sorted Set，ZSet）**

- **描述**：有序集合是一个没有重复成员的集合，每个元素都有一个分数（score），根据分数对集合中的元素进行排序。适用于排行榜、计分系统等场景。

- **常见命令**：

  - `ZADD key score member`：将元素添加到有序集合，并指定分数。
  - `ZRANGE key start stop`：返回指定范围的元素，按分数升序排列。
  - `ZREVRANGE key start stop`：返回指定范围的元素，按分数降序排列。
  - `ZREM key member`：从有序集合中移除指定成员。
  - `ZINCRBY key increment member`：增加成员的分数。

  **示例**：

  ```bash
  ZADD leaderboard 100 "Alice" 90 "Bob" 80 "Charlie"
  ZRANGE leaderboard 0 -1
  ```

### 6. **位图（Bitmaps）**

- **描述**：位图是通过操作字符串中的位来存储信息。位图非常适合用于存储大量的布尔值（如是否在线、是否活跃等）。

- **常见命令**：

  - `SETBIT key offset value`：设置字符串中某个偏移量的位值。
  - `GETBIT key offset`：获取字符串中某个偏移量的位值。
  - `BITCOUNT key`：统计字符串中所有的 1 位的个数。

  **示例**：

  ```bash
  SETBIT mybitmap 7 1
  GETBIT mybitmap 7
  BITCOUNT mybitmap
  ```

### 7. **HyperLogLog**

- **描述**：HyperLogLog 是一种概率算法，用于估算集合的基数（即不同元素的数量）。它非常节省内存，适用于统计数据去重、独立计数等场景。

- **常见命令**：

  - `PFADD key element`：将元素添加到 HyperLogLog 中。
  - `PFCOUNT key`：返回 HyperLogLog 中不同元素的估算基数。

  **示例**：

  ```bash
  PFADD myhyperloglog "A" "B" "C"
  PFCOUNT myhyperloglog
  ```

### 8. **地理空间（Geo）**

- **描述**：Redis 提供了地理空间功能，支持存储地理位置（经度、纬度）并进行查询操作。适合存储和查询位置数据。

- **常见命令**：

  - `GEOADD key longitude latitude member`：将地理位置添加到集合中。
  - `GEORADIUS key longitude latitude radius`：根据经纬度查询范围内的成员。
  - `GEODIST key member1 member2`：返回两个地理位置之间的距离。

  **示例**：

  ```bash
  GEOADD mygeospatial 13.361389 38.115556 "Palermo"
  GEORADIUS mygeospatial 15 37 200 km
  ```

### 9. **流（Streams）**

- **描述**：Redis 的流是一个基于日志的存储结构，用于处理消息队列、日志系统等场景，支持自动增量的唯一 ID。

- **常见命令**：

  - `XADD key fields`：向流中添加消息。
  - `XREAD`：从流中读取消息。
  - `XGROUP`：创建和管理消费者组。

  **示例**：

  ```bash
  XADD mystream * name "Alice" action "login"
  XREAD COUNT 2 STREAMS mystream 0
  ```

------

### 总结

Redis 支持的核心数据类型包括：

- **字符串（String）**
- **哈希（Hash）**
- **列表（List）**
- **集合（Set）**
- **有序集合（Sorted Set，ZSet）**
- **位图（Bitmap）**
- **HyperLogLog**
- **地理空间（Geo）**
- **流（Streams）**

这些多样化的数据结构使 Redis 在不同的使用场景中非常灵活，特别适合用作缓存、会话存储、消息队列、实时分析等应用。如果你有特定的数据结构问题或使用场景，欢迎随时提问！
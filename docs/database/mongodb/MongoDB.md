## 什么是 MongoDB？

MongoDB 是一个 **NoSQL 数据库**，与传统的关系型数据库（如 MySQL、PostgreSQL）不同，它使用 **文档模型** 来存储数据。

## 核心特点

### 1. **文档导向**

- 数据以 **BSON**（Binary JSON）格式存储
- 每个文档类似于 JSON 对象
- 示例：

```
Json






{
  "_id": ObjectId("5f9d1b2b3c4d5e6f7a8b9c0d"),
  "name": "张三",
  "age": 25,
  "hobbies": ["篮球", "音乐", "编程"],
  "address": {
    "city": "北京",
    "street": "朝阳路"
  }
}
```

### 2. **无固定模式（Schema-less）**

- 不需要预定义表结构
- 每个文档可以有不同字段
- 灵活性高，适合快速迭代的项目

### 3. **高性能**

- 支持内存映射
- 自动分片（Sharding）
- 水平扩展能力强

## 核心概念对比

| RDBMS（MySQL）   | MongoDB         |
| ---------------- | --------------- |
| 数据库 Database  | 数据库 Database |
| 表 Table         | 集合 Collection |
| 行 Row           | 文档 Document   |
| 列 Column        | 字段 Field      |
| 主键 Primary Key | `_id` 字段      |

## 基本操作示例
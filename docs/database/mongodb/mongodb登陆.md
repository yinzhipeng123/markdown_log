目前官方推荐的工具是 **`mongosh`** (MongoDB Shell)，它是老版本 `mongo` 命令的增强替代品。

------

### 1. 登录本地 MongoDB

如果你已经在电脑上安装并运行了 MongoDB，打开终端直接输入：

Bash

```
mongosh
```

或者（如果是旧版本）：

Bash

```
mongo
```

**注意：** 如果你的数据库启用了权限验证（Auth），这种方式进入后可能无法查看数据，需要用下一种方式。

------

### 2. 使用用户名和密码登录

这是最常见的生产环境登录方式：

Bash

```
mongosh --username <用户名> --password <密码> --authenticationDatabase admin
```

- `--authenticationDatabase admin`：通常用户信息存储在 `admin` 数据库中。

------

### 3. 使用 URI 连接字符串（最推荐）

这种方式最简洁，尤其是连接远程服务器或云端（Atlas）时。

Bash

```
mongosh "mongodb://用户名:密码@主机名:端口/数据库名"
```

**例子：**

Bash

```
mongosh "mongodb://root:123456@localhost:27017/test_db?authSource=admin"
```

------

### 4. 登录 MongoDB Atlas (云端)

在 Atlas 官网上，点击 **"Connect"** 按钮，选择 **"Connect with the MongoDB Shell"**，你会得到一段类似下面的代码，直接复制到终端即可：

Bash

```
mongosh "mongodb+srv://cluster0.example.mongodb.net/myFirstDatabase" --apiVersion 1 --username <你的用户名>
```

------

### 常用操作小贴士

登录成功后，你可能会用到这些“起手式”命令：

| **命令**           | **作用**                     |
| ------------------ | ---------------------------- |
| `show dbs`         | 查看所有数据库               |
| `use <db_name>`    | 切换到指定数据库             |
| `db.getName()`     | 查看当前所在数据库           |
| `show collections` | 查看当前库下的所有集合（表） |
| `exit` 或 `quit()` | 退出 Shell                   |

------

### 常见报错排查

- **"Connection refused"**: 检查 MongoDB 服务是否开启。
- **"Authentication failed"**: 账号密码不对，或者没指定 `--authenticationDatabase`。
- **命令未找到**: 确认是否安装了 `mongosh` 并且已经配置到了系统的环境变量（PATH）中。

在 **HDFS** 中查看文件，可以使用一系列的命令，主要通过 `hdfs dfs` 命令来实现。以下是一些常用的 HDFS 文件查看命令：

### 1. **查看 HDFS 上的文件**

你可以使用 `hdfs dfs -ls` 命令来列出 HDFS 上的文件和目录。命令格式如下：

```bash
hdfs dfs -ls <hdfs_path>
```

#### 示例：

```bash
hdfs dfs -ls /user/data/logs/
```

此命令将列出 `/user/data/logs/` 目录下的所有文件和子目录，包括文件权限、所有者、大小和修改时间等信息。

### 2. **查看 HDFS 上的文件内容**

要查看文件的内容，可以使用 `hdfs dfs -cat` 命令。该命令将显示文件的内容。

```bash
hdfs dfs -cat <hdfs_file_path>
```

#### 示例：

```bash
hdfs dfs -cat /user/data/logs/user_logs.csv
```

此命令将显示 `/user/data/logs/user_logs.csv` 文件的所有内容。

### 3. **查看 HDFS 上的文件内容（分块查看）**

如果文件非常大，可能希望分块查看内容。可以使用 `hdfs dfs -tail` 命令查看文件的最后一部分内容。

```bash
hdfs dfs -tail <hdfs_file_path>
```

#### 示例：

```bash
hdfs dfs -tail /user/data/logs/user_logs.csv
```

此命令将显示 `/user/data/logs/user_logs.csv` 文件的最后 1 KB 内容。

### 4. **查看 HDFS 上的文件大小**

使用 `hdfs dfs -du` 命令查看文件或目录的大小。

```bash
hdfs dfs -du <hdfs_file_or_dir>
```

#### 示例：

```bash
hdfs dfs -du /user/data/logs/user_logs.csv
```

此命令将显示 `/user/data/logs/user_logs.csv` 文件的大小（单位是字节）。

### 5. **查看 HDFS 上文件的详细信息**

可以使用 `hdfs dfs -stat` 命令来获取文件的详细信息，比如文件大小、创建时间等。

```bash
hdfs dfs -stat <hdfs_file_path>
```

#### 示例：

```bash
hdfs dfs -stat %b /user/data/logs/user_logs.csv
```

此命令会显示 `/user/data/logs/user_logs.csv` 文件的块大小。

### 6. **查看 HDFS 上文件的块信息**

使用 `hdfs dfs -fsck` 命令查看 HDFS 上文件的块和健康状态。

```bash
hdfs dfs -fsck <hdfs_file_path> -files -blocks -locations
```

#### 示例：

```bash
hdfs dfs -fsck /user/data/logs/user_logs.csv -files -blocks -locations
```

此命令会列出文件的所有块以及块的位置和健康状态。

### 7. **查看 HDFS 上文件的存储位置**

可以使用 `hdfs dfs -getfacl` 命令查看文件或目录的访问控制列表（ACL）。

```bash
hdfs dfs -getfacl <hdfs_file_path>
```

#### 示例：

```bash
hdfs dfs -getfacl /user/data/logs/user_logs.csv
```

此命令将显示 `/user/data/logs/user_logs.csv` 文件的权限信息。

### 8. **查看 HDFS 上文件的目录结构**

使用 `hdfs dfs -ls -R` 命令可以递归地列出目录及其子目录中的所有文件。

```bash
hdfs dfs -ls -R <hdfs_dir_path>
```

#### 示例：

```bash
hdfs dfs -ls -R /user/data/logs/
```

此命令将递归列出 `/user/data/logs/` 目录及其所有子目录中的文件。

### 总结：

- `hdfs dfs -ls`：列出目录中的文件和子目录。
- `hdfs dfs -cat`：查看文件内容。
- `hdfs dfs -tail`：查看文件的最后部分内容。
- `hdfs dfs -du`：查看文件或目录的大小。
- `hdfs dfs -stat`：查看文件的详细信息。
- `hdfs dfs -fsck`：查看文件的块信息和健康状态。
- `hdfs dfs -getfacl`：查看文件或目录的访问控制列表（ACL）。
- `hdfs dfs -ls -R`：递归列出目录及其子目录中的所有文件。

这些命令帮助你在 **HDFS** 中查看和管理文件。
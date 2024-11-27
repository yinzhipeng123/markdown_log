# find命令

[find linux 命令 在线中文手册 (51yip.com)](http://linux.51yip.com/search/find)

[find 命令，Linux find 命令详解：在指定目录下查找文件 - Linux 命令搜索引擎 (wangchujiang.com)](https://wangchujiang.com/linux-command/c/find.html)

[find(1) — manpages-zh — Debian unstable — Debian Manpages](https://manpages.debian.org/unstable/manpages-zh/find.1.zh_CN.html)





查看系统中大于600M的文件

```bash
# find . -type f -size +600M -print0 2>/dev/null | xargs -0 ls -lh
-rw------- 1 root  root  2.2G Dec 19  2020 ./www
-rw------- 1 root  root  2.3G Dec 19  2020 ./aaa
-rw-r--r-- 1 admin admin 2.2G Oct  9 17:57 ./ccc
```



只保留最近30天数据

```bash
find /home/admin/ -mtime +30 -name "*.*" -exec rm -Rf {} \
```



`find` 命令是 Linux 系统中非常强大的工具，用于查找文件或目录。它可以基于不同的条件，如文件名、大小、修改时间、权限等，来搜索文件或目录。以下是一些常用的 `find` 命令用法：

### 1. 查找某个目录下的所有文件

```bash
find /path/to/directory
```

这个命令会列出指定目录下的所有文件和子目录。

### 2. 查找指定名称的文件

```bash
find /path/to/directory -name "filename"
```

查找目录 `/path/to/directory` 下所有名为 `filename` 的文件。

### 3. 查找指定扩展名的文件

```bash
find /path/to/directory -name "*.txt"
```

查找指定目录下所有扩展名为 `.txt` 的文件。

### 4. 查找文件并执行命令

```bash
find /path/to/directory -name "*.log" -exec rm -f {} \;
```

查找所有 `.log` 文件，并删除它们。`-exec` 后面跟要执行的命令，`{}` 会被替换为找到的文件名，`\;` 用来结束命令。

### 5. 查找修改时间在某个范围内的文件

```bash
find /path/to/directory -mtime -7
```

查找过去 7 天内修改过的文件。`-mtime` 后面跟天数，负数表示最近修改，正数表示更早的时间。

### 6. 查找文件大小大于指定值的文件

```bash
find /path/to/directory -size +100M
```

查找文件大小大于 100MB 的文件。`+` 表示大于，`-` 表示小于，`M` 表示 MB，`G` 表示 GB。

### 7. 查找特定权限的文件

```bash
find /path/to/directory -perm 644
```

查找权限为 `644` 的文件。

### 8. 查找某个用户拥有的文件

```bash
find /path/to/directory -user username
```

查找指定用户 `username` 拥有的所有文件。

### 9. 查找并显示文件的详细信息

```bash
find /path/to/directory -exec ls -l {} \;
```

查找所有文件并使用 `ls -l` 显示详细信息。

### 10. 查找目录而不是文件

```bash
find /path/to/directory -type d
```

只查找目录，忽略文件。

### 11. 查找文件并忽略大小写

```bash
find /path/to/directory -iname "*.txt"
```

查找所有扩展名为 `.txt` 的文件，忽略大小写。

### 12. 查找并排除某些文件夹

```bash
find /path/to/directory -path /path/to/directory/exclude_folder -prune -o -name "*.txt" -print
```

查找 `.txt` 文件，但排除指定的文件夹。

### 13. 查找空文件

```bash
find /path/to/directory -type f -empty
```

查找空的文件。

### 14. 查找并统计符合条件的文件数量

```bash
find /path/to/directory -name "*.txt" | wc -l
```

查找 `.txt` 文件，并显示文件的数量。





要查询最近更新的 10 个文件，可以使用 `find` 命令结合 `-type f`（只查找文件）、`-printf`（输出文件的修改时间），以及 `sort` 和 `head` 命令来完成。

可以使用以下命令：

```bash
find /path/to/directory -type f -printf "%T@ %p\n" | sort -n -r | head -n 10
```

### 解释：

- `find /path/to/directory -type f`：在指定目录下查找所有文件（`-type f`）。
- `-printf "%T@ %p\n"`：输出文件的修改时间（`%T@`），时间戳形式，和文件路径（`%p`）。
- `sort -n -r`：按数字升序（`-n`）逆序（`-r`）排序，即最晚修改的文件排在前面。
- `head -n 10`：显示排序后的前 10 个文件。

这样，输出的结果就是最近更新的 10 个文件，按时间从最新到最旧排序。如果需要按其他方式定制输出，也可以调整命令。

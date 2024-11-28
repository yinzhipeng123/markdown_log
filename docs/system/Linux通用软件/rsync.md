



```bash
rsync 版本 3.2.3 协议版本 31
版权 (C) 1996-2020 由 Andrew Tridgell, Wayne Davison 及其他人提供
官方网站: https://rsync.samba.org/
功能：
    64 位文件，64 位索引节点，64 位时间戳，64 位长整型，
    套接字对，硬链接，硬链接特殊，符号链接，IPv6，访问时间，
    批处理文件，就地，追加，ACLs，扩展属性，选项保护-参数，字符集转换，
    符号时间，预分配，停止-at，无创建时间
优化：
    SIMD，汇编，openssl 加密
校验和列表：
    md5 md4 无
压缩列表：
    zstd lz4 zlibx zlib 无

rsync 不附带任何保证。 这是一个自由软件，您可以在特定条件下重新分发它。详细信息请参阅 GNU 通用公共许可证。

rsync 是一个能够通过快速差异算法高效地进行远程更新的文件传输程序。

用法： rsync [选项]... 源 [源]... 目标
    或  rsync [选项]... 源 [源]... [用户名@]主机:目标
    或  rsync [选项]... 源 [源]... [用户名@]主机::目标
    或  rsync [选项]... 源 [源]... rsync://[用户名@]主机[:端口]/目标
    或  rsync [选项]... [用户名@]主机:源 [目标]
    或  rsync [选项]... [用户名@]主机::源 [目标]
    或  rsync [选项]... rsync://[用户名@]主机[:端口]/源 [目标]
':' 用法通过远程 shell 连接，而 '::' 和 'rsync://' 用法通过 rsync 守护进程连接，需要源或目标以模块名开始。

选项：
--verbose, -v          提高详细信息的输出
--info=FLAGS           更细粒度的信息输出
--debug=FLAGS          更细粒度的调试输出
--stderr=e|a|c         更改标准错误输出模式（默认：错误）
--quiet, -q            抑制非错误消息
--no-motd              抑制守护进程模式的 MOTD（消息）
--checksum, -c         根据校验和跳过文件，而不是根据修改时间和大小
--archive, -a          存档模式；等效于 -rlptgoD（不包括 -H,-A,-X）
--no-OPTION            关闭一个隐含选项（例如 --no-D）
--recursive, -r        递归进入目录
--relative, -R         使用相对路径名
--no-implied-dirs      不随 --relative 发送隐含目录
--backup, -b           创建备份（参见 --suffix 和 --backup-dir）
--backup-dir=DIR       将备份存储在 DIR 目录中
--suffix=SUFFIX        备份的后缀（默认为 ~，如果没有 --backup-dir）
--update, -u           跳过接收端已经更新的文件
--inplace              直接在目标文件上更新
--append               将数据附加到较短的文件末尾
--append-verify        --append 时校验文件内容
--dirs, -d             传输目录而不递归
--mkpath               创建目标路径组件
--links, -l            复制符号链接为符号链接
--copy-links, -L       将符号链接转换为引用文件/目录
--copy-unsafe-links    只转换“危险”符号链接
--safe-links           忽略指向外部目录的符号链接
--munge-links          修改符号链接使其不再有效
--copy-dirlinks, -k    将符号链接的目录转换为引用的目录
--keep-dirlinks, -K    将接收端符号链接的目录当作目录处理
--hard-links, -H       保留硬链接
--perms, -p            保留权限
--executability, -E    保留可执行性
--chmod=CHMOD          修改文件和/或目录权限
--acls, -A             保留 ACL（暗含 --perms）
--xattrs, -X           保留扩展属性
--owner, -o            保留所有者（仅超级用户）
--group, -g            保留组
--devices              保留设备文件（仅超级用户）
--copy-devices         复制设备内容作为常规文件
--specials             保留特殊文件
-D                     等同于 --devices --specials
--times, -t            保留修改时间
--atimes, -U           保留访问（使用）时间
--open-noatime         避免改变访问时间
--crtimes, -N          保留创建时间（新性）
--omit-dir-times, -O   省略目录的 --times
--omit-link-times, -J  省略符号链接的 --times
--super                接收端尝试执行超级用户活动
--fake-super           使用扩展属性存储/恢复特权属性
--sparse, -S           将空块转换为稀疏文件
--preallocate          预分配目标文件空间
--write-devices        以文件形式写入设备（暗含 --inplace）
--dry-run, -n          进行试运行，不做任何修改
--whole-file, -W       完整复制文件（不使用增量传输算法）
--checksum-choice=STR  选择校验和算法（即 --cc）
--one-file-system, -x  不跨越文件系统边界
--block-size=SIZE, -B  强制设置固定的校验和块大小
--rsh=COMMAND, -e      指定远程 shell 使用的命令
--rsync-path=PROGRAM   指定在远程机器上运行的 rsync 程序
--existing             跳过接收端已存在的文件
--ignore-existing      跳过已存在的文件，不更新
--remove-source-files  发送端删除同步的文件（非目录）
--del                  --delete-during 的别名
--delete               删除目标目录中多余的文件
--delete-before        接收端在传输前删除
--delete-during        接收端在传输过程中删除
--delete-delay         在传输过程中查找删除，传输完成后删除
--delete-after         接收端在传输后删除
--delete-excluded      也删除排除的文件
--ignore-missing-args  忽略缺失的源参数而不报错
--delete-missing-args  删除目标中缺失的源文件
--ignore-errors        即使遇到 I/O 错误也进行删除
--force                强制删除非空目录
--max-delete=NUM       删除文件的最大数量
--max-size=SIZE        不传输任何大于 SIZE 的文件
--min-size=SIZE        不传输任何小于 SIZE 的文件
--max-alloc=SIZE       修改与内存分配相关的限制
--partial              保留部分传输的文件
--partial-dir=DIR      将部分传输的文件放入 DIR 目录
--delay-updates        将所有更新的文件放入最终位置
--prune-empty-dirs, -m 剪除文件列表中空的目录链
--numeric-ids          不通过用户/组名称映射 UID/GID 值
--usermap=STRING       自定义用户名映射
--groupmap=STRING      自定义组名映射
--chown=USER:GROUP     简单的用户名/组名映射
--timeout=SECONDS      设置 I/O 超时时间（秒）
--contimeout=SECONDS   设置守护进程连接超时（秒）
--ignore-times, -I     不跳过大小和时间匹配的文件
--size-only            跳过大小匹配的文件
--modify-window=NUM, -@ 设置修改时间比较的精度
--temp-dir=DIR, -T     创建临时文件在 DIR 目录中
--fuzzy, -y            如果目标文件不存在，寻找相似文件
--compare-dest=DIR     将目标文件与 DIR 中的文件进行比较
--copy-dest=DIR        包括复制未更改的文件
--link-dest=DIR        对未更改的文件进行硬链接
--compress, -z         在传输过程中压缩文件数据
--compress-choice=STR  选择压缩算法（即 --zc）
--compress-level=NUM   显式设置压缩级别（即 --zl）
--skip-compress=LIST   跳过压缩后缀为 LIST 的文件
--cvs-exclude, -C      按照 CVS 的方式自动忽略文件
--filter=RULE, -f      添加文件过滤规则
-F                     使用 -f 规则的两倍
--exclude=PATTERN      排除与 PATTERN 匹配的文件
--exclude-from=FILE    从 FILE 中读取排除模式
--include=PATTERN      包含与 PATTERN 匹配的文件
--include-from=FILE    从 FILE 中读取包含模式
--files-from=FILE      从 FILE 中读取源文件列表
--protect-args          启用文件名保护（反对 shell 解释）
--iconv=FROM_CHARSET:TO_CHARSET 字符集转换
--list-only            只列出文件，不传输
--bwlimit=RATE         限制带宽，单位为字节/秒
--write-batch=FILE     写入批量文件
--read-batch=FILE      从批量文件中读取
--checksum-seed=NUM    设置校验和种子

```



### 使用 `rsync` 实现断点续传

`rsync` 是一个非常适合进行大文件传输和同步的工具，特别适合在远程机器间复制文件，并且支持断点续传。

#### 基本命令格式：

```bash
rsync -avz --progress --partial --inplace user@source_host:/path/to/source/file /path/to/destination
```

- `-a`：归档模式，保持文件的权限、时间戳、符号链接等。
- `-v`：显示详细信息。
- `-z`：在传输时进行压缩。
- `--progress`：显示传输进度。
- `--partial`：保留部分传输的文件，以便下一次传输可以从中断处继续。
- `--inplace`：直接在目标文件上更新内容，而不是创建临时文件。

#### 例子：

假设你需要将文件从 **源主机** 的 `/home/user/source_file` 复制到 **目标主机** 的 `/home/user/destination/` 目录，并希望支持断点续传：

```bash
rsync -avz --progress --partial --inplace user@source_host:/home/user/source_file /home/user/destination/
```

效果如下

```bash
[root@VM-0-16-centos ~]# rsync -avz --progress --partial --inplace bigfile /mnt/
sending incremental file list
bigfile
  1,073,741,824 100%  407.79MB/s    0:00:02 (xfr#1, to-chk=0/1)
sent 32,888 bytes  received 35 bytes  5,065.08 bytes/sec
total size is 1,073,741,824  speedup is 32,613.73
[root@VM-0-16-centos ~]# 
[root@VM-0-16-centos ~]# rsync -avz --progress --partial --inplace bigfile /mnt/
sending incremental file list
sent 59 bytes  received 12 bytes  142.00 bytes/sec
total size is 1,073,741,824  speedup is 15,123,124.28
```

第一个命令输出：

```bash
rsync -avz --progress --partial --inplace bigfile /mnt/
sending incremental file list
bigfile
  1,073,741,824 100%  407.79MB/s    0:00:02 (xfr#1, to-chk=0/1)
sent 32,888 bytes  received 35 bytes  5,065.08 bytes/sec
total size is 1,073,741,824  speedup is 32,613.73
```

1. **`sending incremental file list`**：
   - [ ] `rsync` 正在开始传输增量文件列表，这意味着它会检查源和目标目录中有哪些文件需要更新或传输。
2. **`bigfile`**：
   - 这是正在被传输的文件名。
3. **`1,073,741,824 100%  407.79MB/s    0:00:02 (xfr#1, to-chk=0/1)`**：
   - [ ] **`1,073,741,824`**：表示文件的大小，1,073,741,824 字节（约 1 GB）。
   - [ ] **`100%`**：表示文件已经完成了 100% 的传输。
   - [ ] **`407.79MB/s`**：文件传输的速率是 407.79 MB/秒。
   - [ ] **`0:00:02`**：传输文件的时间是 2 秒。
   - [ ] **`(xfr#1, to-chk=0/1)`**：这是第一个文件的传输，目标文件夹中没有剩余文件需要检查。
4. **`sent 32,888 bytes  received 35 bytes  5,065.08 bytes/sec`**：
   - [ ] **`sent 32,888 bytes`**：`rsync` 发送了 32,888 字节的数据（包括文件数据、元数据等）。
   - [ ] **`received 35 bytes`**：`rsync` 接收了 35 字节的数据（这通常是用来确认传输过程中的一些控制信息）。
   - [ ] **`5,065.08 bytes/sec`**：数据传输的平均速率是 5,065.08 字节/秒。
5. **`total size is 1,073,741,824  speedup is 32,613.73`**：
   - [ ] **`total size is 1,073,741,824`**：传输的文件总大小是 1 GB。
   - [ ] **`speedup is 32,613.73`**：这是 `rsync` 的加速比率。加速比率越高，表示相较于完全重新传输，增量传输的效率越高。这里的 32,613.73 表示传输效率比起传统的方式高了大约 3.2 万倍。

第二个命令输出：

```
rsync -avz --progress --partial --inplace bigfile /mnt/
sending incremental file list
sent 59 bytes  received 12 bytes  142.00 bytes/sec
total size is 1,073,741,824  speedup is 15,123,124.28
```

1. **`sending incremental file list`**：
   - [ ] 同样是 `rsync` 开始发送增量文件列表。
2. **`sent 59 bytes  received 12 bytes  142.00 bytes/sec`**：
   - [ ] **`sent 59 bytes`**：这次传输仅发送了 59 字节的数据。说明目标文件已经存在，而且没有变化，所以 `rsync` 只发送了最小的控制信息。
   - [ ] **`received 12 bytes`**：接收了 12 字节的数据（同样是控制信息）。
   - [ ] **`142.00 bytes/sec`**：由于只发送了少量的控制信息，所以速率非常低，为 142 字节/秒。
3. **`total size is 1,073,741,824  speedup is 15,123,124.28`**：
   - [ ] **`total size is 1,073,741,824`**：文件总大小仍然是 1 GB。
   - [ ] **`speedup is 15,123,124.28`**：这次的加速比率为 15,123,124.28，表示增量同步的效率更高。由于文件没有发生变化，`rsync` 只做了极少的操作，所以加速比率极高。

- [ ] 第一次传输是 `rsync` 完全传输了一个大文件，速率较高，耗时较短，且加速比率正常。
- [ ] 第二次传输时，`rsync` 检测到文件没有变化，因此几乎没有数据需要传输，仅发送了一些控制信息，导致速率非常低，但加速比率异常高，显示了增量传输的优势。



### `rsync` 的断点续传机制：

- [ ] 当文件传输中断时，`rsync` 会保存部分传输的文件。
- [ ] 下次传输时，它会比较源文件和目标文件的差异，只传输缺少的部分，而不会重新传输已经传输过的部分。
- [ ] 使用 `--partial` 选项可以保留未完成的部分文件，这样在重新传输时不会丢失已传输的数据。





以下是几个常用的 `rsync` 命令用法：

### 1. 本地文件同步

将本地目录 `/source/` 下的所有文件同步到 `/destination/` 目录：

```bash
rsync -av /source/ /destination/
```

- [ ] `-a`：归档模式，等同于 `-rlptgoD`，表示递归并保留文件属性。
- [ ] `-v`：显示详细输出。

### 2. 从远程主机同步到本地

将远程主机上的文件同步到本地目录 `/local/`：

```bash
rsync -avz user@remote_host:/path/to/source/ /local/
```

- [ ] `-z`：启用压缩传输（适用于网络带宽有限的情况）。

### 3. 从本地同步到远程主机

将本地的文件同步到远程主机 `/remote/path/` 目录：

```bash
rsync -avz /local/path/ user@remote_host:/remote/path/
```

### 4. 删除目标目录中源目录中已经删除的文件

将本地文件同步到远程，并删除目标目录中源目录没有的文件：

```bash
rsync -avz --delete /source/ user@remote_host:/destination/
```

- [ ] `--delete`：删除目标目录中源目录没有的文件。

### 5. 只同步更改过的文件

如果文件在源目录没有变化，则不进行同步：

```bash
rsync -avzu /source/ user@remote_host:/destination/
```

- [ ] `-u`：跳过目标目录中文件比源目录更新的文件。

### 6. 使用 `--dry-run` 模式进行测试

测试同步操作但不做实际更改：

```bash
rsync -avz --dry-run /source/ user@remote_host:/destination/
```

- [ ] `--dry-run`：模拟同步操作，不会做实际更改，只是显示将要同步的文件。

### 7. 忽略某些文件类型（例如 `.log` 文件）

排除某些文件类型，不进行同步：

```bash
rsync -avz --exclude='*.log' /source/ user@remote_host:/destination/
```

- [ ] `--exclude`：排除匹配模式的文件。

### 8. 使用自定义的端口进行远程同步

如果远程主机的 `rsync` 服务运行在非默认端口：

```bash
rsync -avz -e 'ssh -p 2222' /source/ user@remote_host:/destination/
```

- [ ] `-e`：指定使用 `ssh` 连接并指定端口号。

### 9. 显示同步进度

在同步过程中显示进度信息：

```bash
rsync -avz --progress /source/ user@remote_host:/destination/
```

- [ ] `--progress`：显示传输进度信息。

### 10. 将文件同步到具有不同用户名的远程主机

如果目标服务器上使用不同的用户名，可以通过 `rsync` 指定：

```bash
rsync -avz /source/ user2@remote_host:/destination/
```

这些是一些常见的 `rsync` 命令示例，适用于不同的同步场景。如果你有具体的需求，可以根据实际情况调整选项。
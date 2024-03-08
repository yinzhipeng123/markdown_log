

journalctl 命令

[journalctl(1) — manpages-zh — Debian unstable — Debian Manpages](https://manpages.debian.org/unstable/manpages-zh/journalctl.1.zh_CN.html)

显示本次启动后的所有日志：

```bash
journalctl -b
```

显示某个systemctl服务的日志

```bash
journalctl -u docker.service 
```

显示7天内的日志

```bash
journalctl -u docker.service  --since "7 days ago"
```

显示从某个时间开始的消息

```bash
journalctl --since="2012-10-30 18:17:16"
```

显示 Docker 服务自系统启动以来的所有日志，并且会实时更新显示新的日志条目，

```sh
journalctl -u docker.service --no-tail -f -a
```

显示所有内核日志，实时刷新，显示全部格式

```bash
journalctl -k --no-tail -f -a
```

显示某服务最新的100条日志并实时刷新：

```shell
journalctl -u docker.service -n 100 -f
```

清理日志使总大小小于 100M:

```shell
journalctl --vacuum-size=100M
```

清理最早两周前的日志.

```shell
journalctl --vacuum-time=2weeks
```

查看日志占用大小

```bash
[root@VM-0-16-centos 3d870b13f28a4409aaf2781e2f7e68f1]# journalctl --disk-usage
Archived and active journals take up 24.0M on disk.
```



以下是 `journalctl --help` 命令输出的中文翻译：

```
# journalctl --help
journalctl [选项...] [匹配项...]

标志：
     --system              显示系统日志
     --user                显示当前用户的用户日志
  -M --machine=容器         在本地容器上操作
  -S --since=日期          显示不早于指定日期的条目
  -U --until=日期          显示不晚于指定日期的条目
  -c --cursor=游标         从指定游标开始显示条目
     --after-cursor=游标   显示在指定游标之后的条目
     --show-cursor         在所有条目后打印游标
  -b --boot[=ID]           显示当前启动或指定的启动
     --list-boots          显示有关记录启动的简洁信息
  -k --dmesg               显示当前启动的内核消息日志
  -u --unit=单元           显示指定单元的日志
  -t --identifier=字符串   显示具有指定系统日志标识符的条目
  -p --priority=范围       显示具有指定优先级的条目
  -e --pager-end           在分页器中立即跳转到末尾
  -f --follow              跟踪日志
  -n --lines[=整数]        显示的日志条目数量
     --no-tail             即使在跟踪模式下也显示所有行
  -r --reverse             首先显示最新的条目
  -o --output=字符串       更改日志输出模式（short, short-iso,
                                   short-precise, short-monotonic, verbose,
                                   export, json, json-pretty, json-sse, cat）
     --utc                 用协调世界时（UTC）表示时间
  -x --catalog             添加可用的消息解释
     --no-full             省略字段
  -a --all                 显示所有字段，包括长的和不可打印的
  -q --quiet               不显示权限警告
     --no-pager            不将输出导入分页器
  -m --merge               显示所有可用日志的条目
  -D --directory=路径      从目录显示日志文件
     --file=路径           显示日志文件
     --root=根             在根ROOT下操作目录文件
     --interval=时间       更改FSS密封密钥的时间间隔
     --verify-key=密钥      指定FSS验证密钥
     --force               用--setup-keys覆盖FSS密钥对

命令：
  -h --help                显示此帮助文本
     --version             显示包版本
  -F --field=字段          列出指定字段取的所有值
     --new-id128           生成新的128位ID
     --disk-usage          显示所有日志文件的总磁盘使用量
     --vacuum-size=字节    减少磁盘使用量至指定大小以下
     --vacuum-time=时间    删除早于指定日期的日志文件
     --flush               将所有日志数据从/run刷新到/var
     --header              显示日志头部信息
     --list-catalog        显示目录中的所有消息ID
     --dump-catalog        显示消息目录中的条目
     --update-catalog      更新消息目录数据库
     --setup-keys          生成新的FSS密钥对
     --verify              验证日志文件的一致性
```

这是 `journalctl` 命令的帮助信息，提供了该命令的各种选项和命令的详细说明。



这里是一些常用的 `journalctl` 命令组合：

1. **显示所有日志（默认情况下，从本次启动开始）：**
   ```bash
   journalctl
   ```

2. **实时跟踪最新日志：**
   ```bash
   journalctl -f
   ```

3. **显示特定服务（例如 sshd）的日志：**
   ```bash
   journalctl -u sshd
   ```

4. **显示今天的日志：**
   ```bash
   journalctl --since today
   ```

5. **显示最近的 N 条日志条目（例如最近 20 条）：**
   ```bash
   journalctl -n 20
   ```

6. **按时间范围查看日志（例如显示昨天的日志）：**
   ```bash
   journalctl --since yesterday --until now
   ```

7. **查看特定时间段的日志（例如从一个星期前到现在）：**
   ```bash
   journalctl --since "1 week ago" --until "3 days ago"
   ```

8. **显示特定优先级（例如错误及以上级别）的日志：**
   ```bash
   journalctl -p err
   ```

9. **显示内核日志（类似于 dmesg）：**
   ```bash
   journalctl -k
   ```

10. **反向显示日志（显示最新的条目在前）：**
    ```bash
    journalctl -r
    ```

11. **查看特定进程的日志（使用 PID）：**
    ```bash
    journalctl _PID=1234
    ```

12. **查看在特定时间间隔内变化的日志：**
    ```bash
    journalctl --interval=2s
    ```

这些命令组合涵盖了 `journalctl` 的多种用途




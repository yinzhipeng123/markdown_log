

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


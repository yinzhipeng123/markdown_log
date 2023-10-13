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


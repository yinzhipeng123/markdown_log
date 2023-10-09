# du命令





[du(1) — manpages-zh — Debian unstable — Debian Manpages](https://manpages.debian.org/unstable/manpages-zh/du.1.zh_CN.html)

查看当前目录大小进行排行：  du -sh ./*  2>/dev/null | sort -k1rh

```
[root@www /var]# du -sh ./*  2>/dev/null | sort -k1rh
5.5G    ./log
2.1G    ./lib
225M    ./cache
```

查看系统中大目录并排序

```bash
[root@www /]
#du -h / 2>/dev/null| sort -k1rh | head -n 20
191G    /
171G    /dev
170G    /dev/sdfsd
7.9G    /var
5.6G    /sdfsdfsdfsd
```





sort -k 是按照哪列去排序，-h是根据存储容量排序(注意使用大写字母，例如：2K 1G)。-r  逆序输出排序结果

[sort linux 命令 在线中文手册 (51yip.com)](http://linux.51yip.com/search/sort)
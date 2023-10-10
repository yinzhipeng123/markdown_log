# sort命令



### 几个比较关键的选项

-k 是按照哪列去排序

-h是根据存储容量排序(注意使用大写字母，例如：2K 1G)。

-r  逆序输出排序结果

-n, --numeric-sort            根据字符串数值比较





例如：

打印线程占用CPU排序

```bash
[root@VM-0-16-centos /]# ps -Leo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:30,comm | grep -v COMMAND | sort -k8nr
11361 11364 TS       -   0  19   0  0.2 Sl   futex_wait_queue_me            YDService
11361 11367 TS       -   0  19   0  0.2 Sl   futex_wait_queue_me            YDService
11361 11399 TS       -   0  19   0  0.1 Sl   futex_wait_queue_me            YDService
11361 31430 TS       -   0  19   1  0.1 Sl   ep_poll                        YDService
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





在线man手册

[sort linux 命令 在线中文手册 (51yip.com)](http://linux.51yip.com/search/sort)

[find(1) — manpages-zh — Debian unstable — Debian Manpages](https://manpages.debian.org/unstable/manpages-zh/find.1.zh_CN.html)


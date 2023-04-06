

iodump命令

详见：[README.md · 90cc/iodump - Gitee.com](https://gitee.com/90cc/iodump/blob/master/README.md)

```bash
iodump -p vda1 >/tmp/iodump.txt
```

约1分钟后ctrl+c取消（也可以kill $pid，但不可以kill -9）

注意关注/tmp/iodump.txt大小，不要打满磁盘

```bash
[root@VM-0-16-centos x86_64]# cat /tmp/iodump.txt 
datetime                   comm                pid iosize      sector rw rwsec launcher       fullpath
2023-04-04T11:24:22.554278 iodump             2710   4096    18610168  W     S fsync          /tmp/iodump.txt
2023-04-04T11:24:22.557115 jbd2/vda1-8         291   4096     7922192  W    FS ret_from_fork_nospec_end  -
2023-04-04T11:24:22.555355 jbd2/vda1-8         291   4096     7922056  W     S ret_from_fork_nospec_end  -
2023-04-04T11:24:22.579134 YDService         15850  81920    22577408  W     S fsync          /usr/local/qcloud/YunJing/cache/fcache.db-journal
2023-04-04T11:24:22.584122 jbd2/vda1-8         291   4096     7922264  W    FS ret_from_fork_nospec_end  -
2023-04-04T11:24:22.587624 jbd2/vda1-8         291   4096     7922272  W     S ret_from_fork_nospec_end  -
2023-04-04T11:24:22.581911 jbd2/vda1-8         291   4096     7922200  W     S ret_from_fork_nospec_end  -
2023-04-04T11:24:22.585441 YDService         15850   4096    22577408  W     S fsync          /usr/local/qcloud/YunJing/cache/fcache.db-journal
2023-04-04T11:24:22.589702 jbd2/vda1-8         291   4096     7922288  W    FS ret_from_fork_nospec_end  -
2023-04-04T11:24:22.596431 jbd2/vda1-8         291   4096     7922296  W     S ret_from_fork_nospec_end  -
2023-04-04T11:24:22.597513 jbd2/vda1-8         291   4096     7922320  W    FS ret_from_fork_nospec_end  -
2023-04-04T11:24:22.591187 YDService         15850   4096      800968  W     S fsync          /usr/local/qcloud/YunJing/cache/fcache.db
2023-04-04T11:24:22.591200 YDService         15850   8192     3746184  W     S fsync          /usr/local/qcloud/YunJing/cache/fcache.db
2023-04-04T11:24:22.591209 YDService         15850   4096      802560  W     S fsync          /usr/local/qcloud/YunJing/cache/fcache.db
```



读写最多的文件排序

```bash
echo "读写次数 文件名" ; cat /tmp/iodump.txt | awk '{print $9}' | sort -rn | uniq -c | sort -rn | head -n 10 
```

读写最多的进程号排序

```bash
echo "读写次数 进程号 进程名" ; cat /tmp/iodump.txt | awk '{print $3" "$2}' | sort -rn | uniq -c | sort -rn | head -n 10
```

写入最多的文件排序

```bash
echo "写入次数  文件名" ; cat /tmp/iodump.txt | grep 'W' | awk '{print $9}' | sort -rn | uniq -c | sort -rn | head -n 10
```

写入最多的进程号排序

```bash
echo "写入次数 进程号 进程名" ; cat /tmp/iodump.txt | grep 'W' | awk '{print $3" "$2}' | sort -rn | uniq -c | sort -rn | head -n 10
```



通过block_dump抓取使用磁盘io较高的进程

/proc/sys/vm/block_dump   缺省设置：0，禁用Block Debug模式

该文件表示是否打开Block Debug模式，用于记录所有的读写及Dirty Block写回动作。

追踪60秒内，按照读写最多的次数对进程进行排序

```bash
echo 1 > /proc/sys/vm/block_dump ; sleep 60 ; dmesg | awk '/vda/ {print $2}' |sort |uniq -c | sort -rn ; echo 0 > /proc/sys/vm/block_dump
```

追踪60秒内，按照每种读写类型最多的次数对进程进行排序

```bash
echo 1 > /proc/sys/vm/block_dump ; sleep 60 ; dmesg |awk ' /vda/ {print $2 $3}' |sort |uniq -c | sort -rn ; echo 0 > /proc/sys/vm/block_dump
```


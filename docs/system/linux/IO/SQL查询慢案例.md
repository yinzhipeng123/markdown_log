# 一个SQL查询要15秒，这是怎么回事？





```bash

$ curl http://192.168.0.10:10000/products/geektime
Got data: () in 15.364538192749023 sec
```

接口返回的是空数据，而且处理时间超过 15 秒。这么慢的响应速度让人无法忍受，到底出了什么问题呢？

为了避免在分析过程中客户端的请求结束，把 curl 命令放到一个循环里执行。同时，为了避免给系统过大压力，我们设置在每次查询后，都先等待 5 秒，然后再开始新的请求。所以，你可以在终端二中，继续执行下面的命令：

```bash
$ while true; do curl http://192.168.0.10:10000/products/geektime; sleep 5; done
```

接下来，重新回到终端一中，分析接口响应速度慢的原因。不过，重回终端一后，你会发现系统响应也明显变慢了，随便执行一个命令，都得停顿一会儿才能看到输出。这跟上一节的现象很类似，看来，我们还是得观察一下系统的资源使用情况，比如 CPU、内存和磁盘 I/O 等的情况。

```bash

$ top
top - 12:02:15 up 6 days,  8:05,  1 user,  load average: 0.66, 0.72, 0.59
Tasks: 137 total,   1 running,  81 sleeping,   0 stopped,   0 zombie
%Cpu0  :  0.7 us,  1.3 sy,  0.0 ni, 35.9 id, 62.1 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu1  :  0.3 us,  0.7 sy,  0.0 ni, 84.7 id, 14.3 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :  8169300 total,  7238472 free,   546132 used,   384696 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  7316952 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
27458 999       20   0  833852  57968  13176 S   1.7  0.7   0:12.40 mysqld
27617 root      20   0   24348   9216   4692 S   1.0  0.1   0:04.40 python
 1549 root      20   0  236716  24568   9864 S   0.3  0.3  51:46.57 python3
22421 root      20   0       0      0      0 I   0.3  0.0   0:01.16 kworker/u
```



观察 top 的输出，两个 CPU 的 iowait 都比较高，特别是 CPU0，iowait 已经超过 60%。而具体到各个进程， CPU 使用率并不高，最高的也只有 1.7%。既然 CPU 的嫌疑不大，那问题应该还是出在了 I/O 上。

我们仍然在第一个终端，按下 Ctrl+C，停止 top 命令；然后，执行下面的 iostat 命令，看看有没有 I/O 性能问题：

```

# -d选项表示展示进程的I/O情况
$ pidstat -d 1
12:04:11      UID       PID   kB_rd/s   kB_wr/s kB_ccwr/s iodelay  Command
12:04:12      999     27458  32640.00      0.00      0.00       0  mysqld
12:04:12        0     27617      4.00      4.00      0.00       3  python
12:04:12        0     27864      0.00      4.00      0.00       0  systemd-journal
```



从 pidstat 的输出可以看到，PID 为 27458 的 mysqld 进程正在进行大量的读，而且读取速度是 32 MB/s，跟刚才 iostat 的发现一致。两个结果一对比，自然就找到了磁盘 I/O 瓶颈的根源，即 mysqld 进程。

为什么 mysqld 会去读取大量的磁盘数据呢？这有可能是个慢查询问题。慢查询的现象大多是 CPU 使用率高（比如 100% ），但这里看到的却是 I/O 问题，我们有必要分析一下 MySQL 读取的数据。

要分析进程的数据读取，当然还要靠 strace+ lsof 组合。

接下来，还是在终端一中，执行 strace 命令，并且指定 mysqld 的进程号 27458。MySQL 是一个多线程的数据库应用，为了不漏掉这些线程的数据读取情况，执行 stace 命令时，加上 -f 参数：

```

$ strace -f -p 27458
[pid 28014] read(38, "934EiwT363aak7VtqF1mHGa4LL4Dhbks"..., 131072) = 131072
[pid 28014] read(38, "hSs7KBDepBqA6m4ce6i6iUfFTeG9Ot9z"..., 20480) = 20480
[pid 28014] read(38, "NRhRjCSsLLBjTfdqiBRLvN9K6FRfqqLm"..., 131072) = 131072
[pid 28014] read(38, "AKgsik4BilLb7y6OkwQUjjqGeCTQTaRl"..., 24576) = 24576
[pid 28014] read(38, "hFMHx7FzUSqfFI22fQxWCpSnDmRjamaW"..., 131072) = 131072
[pid 28014] read(38, "ajUzLmKqivcDJSkiw7QWf2ETLgvQIpfC"..., 20480) = 20480
```

线程 28014 正在读取大量数据，且读取文件的描述符编号为 38。这儿的 38 又对应着哪个文件呢？我们可以执行下面的 lsof 命令，并且指定线程号 28014 ，具体查看这个可疑线程和可疑文件：

```
$ lsof -p 28014
```

lsof 并没有给出任何输出。查看 lsof 命令的返回值，这个命令的执行失败了。

```

$ echo $?
1
```

-p 参数需要指定进程号，而刚才传入的是线程号，所以 lsof 失败了。

把线程号换成进程号，继续执行 lsof 命令：

```

$ lsof -p 27458
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
...
mysqld  27458      999   38u   REG    8,1 512440000 2601895 /var/lib/mysql/test/products.MYD
```

得到了 lsof 的输出。从输出中可以看到， mysqld 进程确实打开了大量文件，而根据文件描述符（FD）的编号，，描述符为 38 的是一个路径为 /var/lib/mysql/test/products.MYD 的文件。

 38 后面的 u 表示， mysqld 以读写的方式访问文件。：

- MYD 文件，是 MyISAM 引擎用来存储表数据的文件；
- 文件名就是数据表的名字；
- 而这个文件的父目录，也就是数据库的名字。

mysqld 在读取数据库 test 中的 products 表。实际上，可以执行下面的命令，查看 mysqld 在管理数据库 test 时的存储文件。不过要注意，由于 MySQL 运行在容器中，你需要通过 docker exec 到容器中查看：

```
$ docker exec -it mysql ls /var/lib/mysql/test/
db.opt    products.MYD  products.MYI  products.frm
```



从这里你可以发现，/var/lib/mysql/test/ 目录中有四个文件，每个文件的作用分别是：

- MYD 文件用来存储表的数据；
- MYI 文件用来存储表的索引；
- frm 文件用来存储表的元信息（比如表结构）；
- opt 文件则用来存储数据库的元信息（比如字符集、字符校验规则等）。

这些文件到底是不是 mysqld 正在使用的数据库文件呢？有没有可能是不再使用的旧数据呢？其实，这个很容易确认，查一下 mysqld 配置的数据路径即可。你可以在终端一中，继续执行下面的命令：

```
$ docker exec -i -t mysql mysql -e 'show global variables like "%datadir%";'
+---------------+-----------------+
| Variable_name | Value           |
+---------------+-----------------+
| datadir       | /var/lib/mysql/ |
+---------------+-----------------+
```

这里可以看到，/var/lib/mysql/ 确实是 mysqld 正在使用的数据存储目录。刚才分析得出的数据库 test 和数据表 products ，都是正在使用。

既然已经找出了数据库和表，接下来要做的，就是弄清楚数据库中正在执行什么样的 SQL 了。我们继续在终端一中，运行下面的 docker exec 命令，进入 MySQL 的命令行界面：

不过，为了保证 SQL 语句不截断，这里我们可以执行 show full processlist 命令。如果一切正常，你应该可以看到如下输出：



```

mysql> show full processlist;
+----+------+-----------------+------+---------+------+--------------+-----------------------------------------------------+
| Id | User | Host            | db   | Command | Time | State        | Info                                                |
+----+------+-----------------+------+---------+------+--------------+-----------------------------------------------------+
| 27 | root | localhost       | test | Query   |    0 | init         | show full processlist                               |
| 28 | root | 127.0.0.1:42262 | test | Query   |    1 | Sending data | select * from products where productName='geektime' |
+----+------+-----------------+------+---------+------+--------------+-----------------------------------------------------+
2 rows in set (0.00 sec)
```



这个输出中，

- db 表示数据库的名字；
- Command 表示 SQL 类型；
- Time 表示执行时间；
- State 表示状态；
- 而 Info 则包含了完整的 SQL 语句。

多执行几次 show full processlist 命令，你可看到 select * from products where productName=‘geektime’ 这条 SQL 语句的执行时间比较长。



其实，MySQL 内置的 explain 命令，就可以帮你解决这个问题。继续在 MySQL 终端中，运行下面的 explain 命令：

```

# 切换到test库
mysql> use test;
# 执行explain命令
mysql> explain select * from products where productName='geektime';
+----+-------------+----------+------+---------------+------+---------+------+-------+-------------+
| id | select_type | table    | type | possible_keys | key  | key_len | ref  | rows  | Extra       |
+----+-------------+----------+------+---------------+------+---------+------+-------+-------------+
|  1 | SIMPLE      | products | ALL  | NULL          | NULL | NULL    | NULL | 10000 | Using where |
+----+-------------+----------+------+---------------+------+---------+------+-------+-------------+
1 row in set (0.00 sec)
```

观察这次的输出。这个界面中，有几个比较重要的字段需要你注意，我就以这个输出为例，分别解释一下：

- select_type 表示查询类型，而这里的 SIMPLE 表示此查询不包括 UNION 查询或者子查询；
- table 表示数据表的名字，这里是 products；
- type 表示查询类型，这里的 ALL 表示全表查询，但索引查询应该是 index 类型才对；
- possible_keys 表示可能选用的索引，这里是 NULL；
- key 表示确切会使用的索引，这里也是 NULL；
- rows 表示查询扫描的行数，这里是 10000。

根据这些信息，我们可以确定，这条查询语句压根儿没有使用索引，所以查询时，会扫描全表，并且扫描行数高达 10000 行。响应速度那么慢也就难怪了。

```

mysql> CREATE INDEX products_index ON products (productName(64));
Query OK, 10000 rows affected (14.45 sec)
Records: 10000  Duplicates: 0  Warnings: 0
```

现在可以看到，索引已经建好了。能做的都做完了，最后就该检查一下，性能问题是否已经解决了。

我们切换到终端二中，查看还在执行的 curl 命令的结果：

```

Got data: ()in 15.383180141448975 sec
Got data: ()in 15.384996891021729 sec
Got data: ()in 0.0021054744720458984 sec
Got data: ()in 0.003951072692871094 sec
```


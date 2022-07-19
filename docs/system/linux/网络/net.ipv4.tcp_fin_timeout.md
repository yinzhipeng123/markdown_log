**提高Linux应对短连接的负载能力**

在存在大量短连接的情况下，Linux的TCP栈一般都会生成大量的 TIME_WAIT 状态的socket。你可以用下面的命令看到：

```bash
netstat -ant| grep -i time_wait
```

有时候，这个数目是惊人的：

```bash
netstat -ant|grep -i time_wait |wc -l
```

可能会超过三四万。这个时候，我们需要修改 linux kernel 的 tcp time wait的时间，缩短之，有个 sysctl 参数貌似可以使用，它是 /proc/sys/net/ipv4/tcp_fin_timeout，缺省值是 60，也就是60秒，很多网上的资料都说将这个数值设置低一些就可以减少netstat 里面的TIME_WAIT状态，但是这个说法是错误的。经过认真阅读Linux的内核源代码，我们发现这个数值其实是输出用的，修改之后并没有真正的读回内核中进行使用，而内核中真正管用的是一个宏定义，在 $KERNEL/include/net/tcp.h里面，有下面的行：

```bash
#define TCP_TIMEWAIT_LEN (60*HZ)
```

而这个宏是真正控制 TCP TIME_WAIT 状态的超时时间的。如果我们希望减少 TIME_WAIT 状态的数目（从而节省一点点内核操作时间），那么可以把这个数值设置低一些，根据我们的测试，设置为 10 秒比较合适
## Prometheus监控查询例子

例：

```json
# HELP node_procs_running Number of processes in runnable state.
# TYPE node_procs_running gauge
node_procs_running 4
```

该数据表示系统中正在运行和可运行状态的线程数量，通过页面查询发现是4，而且是gauge，是个可增可减的值

在Prometheus上查询

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Prometheus/20210720181107.png?raw=true)

可以查询到一个数据，因为该监控是由node_exporter提供的，所以只能查到一个数据

发现该数据增加了两个标签，猜测是因为Prometheus配置提供的。

然后查询该数据的图谱：

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Prometheus/2021072018140622.png?raw=true)

例：

```json
# HELP node_cpu_seconds_total Seconds the cpus spent in each mode.
# TYPE node_cpu_seconds_total counter
node_cpu_seconds_total{cpu="0",mode="idle"} 12463.13
node_cpu_seconds_total{cpu="0",mode="iowait"} 2.32
node_cpu_seconds_total{cpu="0",mode="irq"} 0
node_cpu_seconds_total{cpu="0",mode="nice"} 0.04
node_cpu_seconds_total{cpu="0",mode="softirq"} 0.21
node_cpu_seconds_total{cpu="0",mode="steal"} 0
node_cpu_seconds_total{cpu="0",mode="system"} 6.16
node_cpu_seconds_total{cpu="0",mode="user"} 3.18
node_cpu_seconds_total{cpu="1",mode="idle"} 12458.04
node_cpu_seconds_total{cpu="1",mode="iowait"} 0.58
node_cpu_seconds_total{cpu="1",mode="irq"} 0
node_cpu_seconds_total{cpu="1",mode="nice"} 0.02
node_cpu_seconds_total{cpu="1",mode="softirq"} 0.37
node_cpu_seconds_total{cpu="1",mode="steal"} 0
node_cpu_seconds_total{cpu="1",mode="system"} 9.62
node_cpu_seconds_total{cpu="1",mode="user"} 1.89
```

CPU在每种状态下的CPU时间，是个counter 类型

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Prometheus/me100000000.png?raw=true)

看来标签会根据配置文件自动加上的。查询其中一个值的2小时的数据图谱

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Prometheus/me2000000000.png?raw=true)


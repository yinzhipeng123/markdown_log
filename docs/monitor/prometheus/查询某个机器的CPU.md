在Prometheus上查询某台机器的CPU状态，可以使用以下查询语法：

```
rate(node_cpu_seconds_total{instance="your_machine_ip", mode="idle"}[5m])
```

这个查询返回指定机器（通过`instance`标签过滤）的CPU空闲时间的速率。你可以根据需要修改`mode`为其他状态，如`user`、`system`、`iowait`等。如果要查看总体的CPU使用率，可以修改为：

```
1 - rate(node_cpu_seconds_total{instance="your_machine_ip", mode="idle"}[5m])
```

这将给出CPU的总使用率。



在Prometheus查询语法中，`5m`（或 `5m`）表示**时间窗口**，即过去的**5分钟**。

在查询中，`[5m]`表示你想要计算过去5分钟内的**速率**或**平均值**。例如：

- `rate(node_cpu_seconds_total{instance="your_machine_ip", mode="idle"}[5m])`：计算过去5分钟内指定机器CPU空闲时间的速率。

这个时间窗口可以根据需要调整，可以是：

- `1m`：过去1分钟
- `15m`：过去15分钟
- `1h`：过去1小时
- `1d`：过去1天



要查询**瞬时**的CPU状态，而不需要计算速率或平均值，可以使用`node_cpu_seconds_total`指标的原始数据，不加`rate()`函数。

例如，如果你想查看某台机器在某一时刻的CPU使用情况，可以使用以下查询：

```
node_cpu_seconds_total{instance="your_machine_ip", mode="idle"}
```

这样，你会得到**当前时刻**的CPU空闲时间。注意，Prometheus会直接返回每个CPU模式（如 `idle`、`user`、`system` 等）在指定机器上的总秒数。

如果你只关心某个时刻的CPU使用率（即不关注速率，只看瞬时值），可以计算出总CPU时间的差值，然后根据以下公式计算瞬时使用率：

```
1 - (node_cpu_seconds_total{instance="your_machine_ip", mode="idle"})
```

这个查询给出了某台机器在某一时刻的**CPU使用率**。
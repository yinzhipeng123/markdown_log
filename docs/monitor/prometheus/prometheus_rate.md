# 为什么rate可以计算CPU的使用率

在计算POD的CPU使用率的时候，官方给出了一个计算公式

```sql
sum (rate (container_cpu_usage_seconds_total{pod_name=~"$Pod",namespace="$namespace"}[1m])) by (pod_name)
```

参考：

1. https://blog.csdn.net/shm19990131/article/details/107162470
2. https://www.cnblogs.com/minseo/p/13367692.html
3. https://blog.csdn.net/qq_35753140/article/details/105121525



总结：

```
increase()函数
increase函数在Prometheus中，是用来针对Counter这种持续增长的数值，截取其中一段时间的增量
increase(node_cpu[1m])=》这样就获取了CPU总使用时间在1分钟内的增量

rate()函数
是专门搭配counter类型数据使用的函数
它的功能是按照设置一个时间段，取counter在这个时间段中的平均每秒的增量


rate(metrice[1m]) == increase(metrice[1m])/1m
rate函数等于 increase的值除以时间

```



在计算机中，CPU使用率是统计CPU的在不同状态下的CPU使用时间占总时间多少

例如：

cpu0 5分钟内处于空闲状态的时间：increase(node_cpu_seconds_total{cpu="0",mode="idle"}[5m])，increase 的意思是表示增量，node_cpu_seconds_total 是单调递增的，这个公式的结果是当前时点的 node_cpu_seconds_total 减去5分钟之前的 node_cpu_seconds_total，也就是这5分钟之内处于idle 状态的 cpu 时间。
cpu0 5分钟内处于空闲状态的时间占比：increase(node_cpu_seconds_total{cpu="0",mode="idle"}[5m]) / increase(node_cpu_seconds_total{cpu="0"}[5m])，分母其实就是5分钟=300秒。

分母和分子都是Counter类型的，都是时间

那么这个时间占比就是idle的使用率，那么就可以用rate(node_cpu_seconds_total{cpu="0",mode="idle"}[5m])来表示



同理：

`container_cpu_usage_seconds_total`代表的是容器占用的CPU时间

1分钟时间内`container_cpu_usage_seconds_total`所增长的的值 `increase(container_cpu_usage_seconds_total[1m])`

那么容器的1分钟CPU使用率应该是`increase(container_cpu_usage_seconds_total[1m])/[1m]`

那么用rate来简化公式那么1分钟CPU使用率就是`rate (container_cpu_usage_seconds_total[1m])`


















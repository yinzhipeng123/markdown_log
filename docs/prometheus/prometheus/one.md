# 函数

## avg_over_time(range-vector)：指定区间内所有点的平均值。

**range-vector**：这个代表一段时间所有的值，比如这种：node_procs_running[1m]

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Prometheus/one1111111.png?raw=true)



然后通过avg_over_time计算1分钟内的平均值，例如：avg_over_time(node_procs_running[1m])



![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Prometheus/two2222222.png?raw=true)

## `max_over_time(range-vector)：指定区间内所有点的最大值。

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Prometheus/three3333333.png?raw=true)

## 

## min_over_time(range-vector)：指定区间内所有点的最小值。

## sum_over_time(range-vector)：指定区间内所有值的总和。

## count_over_time(range-vector)：指定区间内所有值的计数。

## quantile_over_time(scalar, range-vector)：指定区间内值的 φ 分位数 (0 ≤ φ ≤ 1)。

## stddev_over_time(range-vector)：指定区间内值的总体标准差。

## stdvar_over_time(range-vector)：指定区间内值的总体标准方差。

## last_over_time(range-vector)：指定时间间隔内的最近点值。
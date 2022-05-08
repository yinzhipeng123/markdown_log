# recording_rules



RECORDING RULES是 Prometheus的一个功能，在采集侧预先计算

需要些rule_files文件，然后在Prometheus配置文件中进行配置

配置文件详解：https://prometheus.io/docs/prometheus/latest/configuration/configuration/

Prometheus配置文件中：

```
rule_files:
  [ - <filepath_glob> ... ]
```

rule_files书写方法：https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/

 

## rule_files详解

github上的例子：https://github.com/helm/charts/blob/master/stable/prometheus-operator/templates/prometheus/rules/k8s.rules.yaml

```
 rules:
    - expr: sum(rate(container_cpu_usage_seconds_total{job="kubelet", image!="", container_name!=""}[5m])) by (namespace)
      record: namespace:container_cpu_usage_seconds_total:sum_rate
```



`expr`   是Prometheus的计算方法

`record`   是计算方法的结果，并重新定义指标

加载这些规则后，在PromSQL中 `namespace:container_cpu_usage_seconds_total:sum_rate` 等同于 `sum(rate(container_cpu_usage_seconds_total{job="kubelet", image!="", container_name!=""}[5m])) by (namespace)`

可以简化PromSQL的写法



例如，下面的指标，就可以在界面上直接查询到：

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Prometheus/rules/rules.png?raw=true)
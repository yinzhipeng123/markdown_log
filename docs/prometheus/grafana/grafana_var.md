变量定义



*Query*类型的变量允许您查询 Prometheus 以获取指标、标签或标签值列表。Prometheus 数据源插件提供以下功能，您可以在`Query`输入字段中使用。

| 姓名                          | 描述                                         |
| :---------------------------- | :------------------------------------------- |
| `label_names()`               | 返回标签名称列表。                           |
| `label_values(label)`         | 返回`label`每个指标中的标签值列表。          |
| `label_values(metric, label)` | 返回`label`指定指标中 的标签值列表。         |
| `metrics(metric)`             | 返回与指定`metric`正则表达式匹配的指标列表。 |
| `query_result(query)`         | 返回 的 Prometheus 查询结果列表`query`。     |

在面板的设置中，可以设置一些变量，供Grafana大屏中的数据公式调用



例如，获取集群总共的内存大小



本身sum(node_memory_MemTotal_bytes)是句promSQL，需要放进`query_result(query)`中，但是查出来的数据是带标签和时间戳的  `{} 2792702402560 1631610328000`，这时候需要正则/.* ([^\ ]*) .*/来过滤出中间的数字



关于Grafana添加Prometheus数据，官网文档为https://grafana.com/docs/grafana/latest/datasources/prometheus/

个人博客讲解：

1. https://yunlzheng.gitbook.io/prometheus-book/part-ii-prometheus-jin-jie/grafana/templating
2. https://www.jianshu.com/p/aa50419b4ed3


# Grafana Dashboard

Grafana是一个开源的可视化平台，并且提供了对Prometheus的完整支持

Grafana可以独立部署，安装起来比较方便。可以yum直接安装启动

我测试的版本为Grafana v6.6.0 

## 添加数据源

启动后，访问Grafana的地址后，需要添加数据源，如图：



![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Grafana/1059a1fd-b92f-4556-824b-31633064f8af.png?raw=true)

数据源添加比较简单，Grafana可以针对多种数据进行出图，简单的理解就是，你给一段数据，Grafana可以为你把图形画出来，这个数据可以是数据库，文本，API接口，任何可以提供数据的东西。

针对Prometheus的添加比较简单，添加时只需要选择Prometheus，输入Prometheus的地址即可，如下图：

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Grafana/158b4d15-f879-4403-a2a3-f55d32dc2e22.png?raw=true)

添加完成之后，就可以在Grafana创建出我们想要的图表了。


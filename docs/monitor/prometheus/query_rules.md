## 

metric介绍，Prometheus本质上是时序数据库，Prometheus会将所有采集到的样本数据以时间序列的方式保存在内存数据库中，并且定时保存到硬盘上

数据结构如下图：

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Prometheus/metrics.png?raw=true)

   在Prometheus的世界里面，所有的数值都是64 bit的。每条时间序列里面记录的就是64 bit Timestamp（时间戳）和64 bit的Sample Value（采样值）

   在prometheus有两种查询方式，查询一般是不带时间的，该两种方式如下，

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Prometheus/metrics2.png?raw=true)



查询什么数据，只要写好PromQL，在Prometheus暴露的9090端口的页面中查询即可。

相关语法：

## label上的匹配器

匹配器是作用于标签上的，标签匹配器可以对时间序列进行过滤，Prometheus支持完全匹配和正则匹配两种模式。

### 1.相等匹配器（=）

相等匹配器（Equality Matcher），用于选择与提供的字符串完全相同的标签。下面介绍的例子中就会使用相等匹配器按照条件进行一系列过滤。

http_requests_total{job="HelloWorld",status="200",method="POST",handler="/api/comments"}

需要注意的是，如果标签为空或者不存在，那么也可以使用Label=""的形式。对于不存在的标签，比如demo标签，图4-7所示的go_gc_duration_seconds_count和图4-8所示的go_gc_duration_seconds_count{demo=""}效果其实是一样的。

### 2.不相等匹配器（！=）

不相等匹配器（Negative Equality Matcher），用于选择与提供的字符串不相同的标签。它和相等匹配器是完全相反的。举个例子，如果想要查看job并不是HelloWorld的HTTP请求总数，可以使用如下不相等匹配器。

http_requests_total{job!="HelloWorld"}

### 3.正则表达式匹配器（=~）

正则表达式匹配器（Regular Expression Matcher），用于选择与提供的字符串进行正则运算后所得结果相匹配的标签。Prometheus的正则运算是强指定的，比如正则表达式a只会匹配到字符串a，而并不会匹配到ab或者ba或者abc。如果你不想使用这样的强指定功能，可以在正则表达式的前面或者后面加上“.*”。比如下面的例子表示job是所有以Hello开头的HTTP请求总数。
http_requests_total{job=~"Hello.*"}

http_requests_total直接等效于{__name__="http_requests_total"}，后者也可以使用和前者一样的4种匹配器（=，！=，=~，！~）。比如下面的案例可以表示所有以Hello开头的指标。
{__name__=~"Hello.*"}

如果想要查看job是以Hello开头的，且在生产（prod）、测试（test）、预发布（pre）等环境下响应结果不是200的HTTP请求总数，可以使用这样的方式进行查询。
http_requests_total{job=~"Hello.*",env=~"prod|test|pre",code!="200"}

由于所有的PromQL表达式必须至少包含一个指标名称，或者至少有一个不会匹配到空字符串的标签过滤器，因此结合Prometheus官方文档，可以梳理出如下非法示例。
{job=~".*"} # 非法！
{job=""}    # 非法！
{job!=""}   # 非法！

相反，如下表达式是合法的。
{job=~".+"}               # 合法！.+表示至少一个字符
{job=~".*",method="get"}  # 合法！.*表示任意一个字符
{job="",method="post"}    # 合法！存在一个非空匹配
{job=~".+",method="post"} # 合法！存在一个非空匹配



### 4.正则表达式相反匹配器（！~）

正则表达式相反匹配器（Negative Regular Expression Matcher），用于选择与提供的字符串进行正则运算后所得结果不匹配的标签。因为PromQL的正则表达式基于RE2的语法，但是RE2不支持向前不匹配表达式，所以！~的出现是作为一种替代方案，以实现基于正则表达式排除指定标签值的功能。在一个选择器当中，可以针对同一个标签来使用多个匹配器。比如下面的例子，可以实现查找job名是node且安装在/prometheus目录下，但是并不在/prometheus/user目录下的所有文件系统并确定其大小。
node_filesystem_size_bytes{job="node",mountpoint=~"/prometheus/.*", mountpoint!~
  "/prometheus/user/.*"}

PromQL采用的是RE2[1]引擎，支持正则表达式。RE2来源于Go语言，它被设计为一种线性时间的模式，非常适合用于PromQL这种时间序列的方式。但是就像我们前文描述的RE2那样，其不支持向前不匹配表达式（向前断言），也不支持反向引用，同时还缺失很多高级特性。
思考拓展
=、！=、=~、！~这4个匹配器在实战中非常有用，但是如果频繁为标签施加正则匹配器，比如HTTP状态码有1xx、2xx、3xx、4xx、5xx，在统计所有返回值是5xx的HTTP请求时，PromQL语句就会变成http_requests_total{job="HelloWorld"，status=~"500"，status=~"501"，status=~"502"，status=~"503"，status=~"504"，status=~"505"，status=~"506"…}
但是，我们都知道5xx代表服务器错误，这些状态代码表示服务器在尝试处理请求时发生了内部错误。这些错误可能来自服务器本身，而不是请求。
1）500：服务器遇到错误，无法完成请求（服务器内部错误）。
2）501：服务器不具备完成请求的功能。例如，当服务器无法识别请求方法时可能会返回此代码（尚未实施）。
3）502：服务器作为网关或代理，从上游服务器收到无效响应（错误网关）。
4）503：服务器目前无法使用（由于超载或停机维护），通常只是暂时状态（服务不可用）。
5）504：服务器作为网关或代理，但是没有及时从上游服务器收到请求（网关超时）。
6）505：服务器不支持请求中所用的HTTP协议版本（HTTP版本不受支持）。
7）506：由《透明内容协商协议》（RFC 2295）扩展而来，代表服务器存在内部配置错误。
8）507：服务器无法存储完成请求所必需的内容。这个状况被认为是临时的。
9）509：服务器达到带宽限制。这不是一个官方的状态码，但是仍被广泛使用。
10）510：获取资源所需要的策略并没有被满足。
为了消除这样的错误，可以进行如下优化。
优化一　多个表达式之间使用“|”进行分割：http_requests_total{job="HelloWorld"，status=~"500|501|502|503|504|505|506|507|509|510"}。
优化二　将这些返回值包装为5xx，这样就可以直接使用正则表达式匹配器对http_requests_total{job="HelloWorld"，status=~"5xx"}进行优化。
优化三　如果要选择不以4xx开头的所有HTTP状态码，可以使用http_requests_total{status！~"4.."}。



## 区间向量选择器

区间向量选择器返回一组时间序列，每个时间序列包含一段时间范围内的样本数据。和瞬时向量选择器不同的是，它从当前时间向前选择了一定时间范围的样本。区间向量选择器主要在选择器末尾的方括号[]中，通过时间范围选择器进行定义，以指定每个返回的区间向量样本值中提取多长的时间范围。例如，下面的例子可以表示最近5分钟内的所有HTTP请求的样本数据，其中[5m]将瞬时向量选择器转变为区间向量选择器。
http_request_total{}[5m]

时间范围通过整数来表示，可以使用以下单位之一：秒（s）、分钟（m）、小时（h）、天（d）、周（w）、年（y）。需要强调的是，必须用整数来表示时间，比如38 m是正确的，但是2 h 15 m和1.5 h都是错误的。这里的y是忽略闰年的，永远是60×60×24×365秒。


案例一：计算2分钟内系统进程的CPU使用率。
rate(node_cpu[2m])

案例二：计算系统CPU的总体使用率，通过排除系统闲置的CPU使用率即可获得。
1 - avg without(cpu) (rate(node_cpu{mode="idle"}[2m]))

案例三：node_cpu_seconds_total可以获取当前CPU的所有信息，使用avg聚合查询到数据后，再使用by来区分实例，这样就能做到分实例查询各自的数据。
avg(irate(node_cpu_seconds_total{job="node_srv"}[5m])) by (instance)

实战拓展
1）区间向量选择器往往和速率函数rate一起使用。比如子查询，以1次/分钟的速率采集关于http_requests_total指标在过去30分钟内的数据，然后返回这30分钟内距离当前时间最近的5分钟内的采集结果，如下所示。
rate(http_requests_total[5m])[30m:1m]

注意，使用不必要的子查询或者不停地嵌套子查询并不是好的PromQL风格。
2）一个区间向量表达式不能直接展示在Graph中，但是可以展示在Console视图中。



## 偏移量修改器


偏移量修改器可以让瞬时向量选择器和区间向量选择器发生偏移，它允许获取查询计算时间并在每个选择器的基础上将其向前推移。
瞬时向量选择器和区间向量选择器都可获取当前时间基准下的样本数据，如果我们要获取查询计算时间前5分钟的HTTP请求情况，可以使用下面这样的方式。
http_request_total{} offset 5m

偏移向量修改器的关键字必须紧跟在选择器{}后面，如下的表达式分别是正确和错误的示例。
sum(http_requests_total{method="GET"} offset 5m) // 正确
sum(http_requests_total{method="GET"}) offset 5m // 非法

该操作同样适用于区间向量选择器，比如下这个例子，其以指标http_requests_total 5分钟前的时间点为起始高，返回5分钟之内的HTTP请求量的增长速率。
rate(http_requests_total[5m] offset 5m)

偏移向量修改器通过调整计算时间一样可以看到一些历史数据，但是这种方式一般只对调试单条语句的历史数据有帮助。随着新数据的到来，历史数据也会不断发生变化，所以建议在Grafana中直接看历史数据的变化趋势。


Prometheus有4大指标类型（Metrics Type），分别是Counter（计数器）、Gauge（仪表盘）、Histogram（直方图）和Summary（摘要）。这是在Prometheus客户端（目前主要有Go、Java、Python、Ruby等语言版本）中提供的4种核心指标类型，但是Prometheus的服务端并不区分指标类型，而是简单地把这些指标统一视为无类型的时间序列。未来，Prometheus官方应该会做出改变



## 聚合函数：

Prometheus还提供了下列内置的聚合操作符，这些操作符作用域瞬时向量。可以将瞬时表达式返回的样本数据进行聚合，形成一个新的时间序列。

- `sum` (求和)
- `min` (最小值)
- `max` (最大值)
- `avg` (平均值)
- `stddev` (标准差)
- `stdvar` (标准方差)
- `count` (计数)
- `count_values` (对value进行计数)
- `bottomk` (后n条时序)
- `topk` (前n条时序)
- `quantile` (分位数)

使用聚合操作的语法如下：



```
<aggr-op>([parameter,] <vector expression>) [without|by (<label list>)]
```

其中只有`count_values`, `quantile`, `topk`, `bottomk`支持参数(parameter)。

without用于从计算结果中移除列举的标签，而保留其它标签。by则正好相反，结果向量中只保留列出的标签，其余标签则移除。通过without和by可以按照样本的问题对数据进行聚合。

例如：



```
sum(http_requests_total) without (instance)
```

等价于



```
sum(http_requests_total) by (code,handler,job,method)
```

如果只需要计算整个应用的HTTP请求总量，可以直接使用表达式：



```
sum(http_requests_total)
```

count_values用于时间序列中每一个样本值出现的次数。count_values会为每一个唯一的样本值输出一个时间序列，并且每一个时间序列包含一个额外的标签。

例如：



```
count_values("count", http_requests_total)
```

topk和bottomk则用于对样本值进行排序，返回当前样本值前n位，或者后n位的时间序列。

获取HTTP请求数前5位的时序样本数据，可以使用表达式：



```
topk(5, http_requests_total)
```

quantile用于计算当前样本数据值的分布情况quantile(φ, express)其中0 ≤ φ ≤ 1。

例如，当φ为0.5时，即表示找到当前样本数据中的中位数：



```
quantile(0.5, http_requests_total)
```
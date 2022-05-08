

# 

## 基本配置

[Alertmanager](https://github.com/prometheus/alertmanager)    通过命令行和配置文件进行配置。

在 [可视化编辑器](https://www.prometheus.io/webtools/alerting/routing-tree-editor) 可以帮助建立路由树 。这个页面粘贴alertmanager配置文件后，会把告警线路画出来

Alertmanager 可以在运行时重新加载其配置。alertmanager进程发送SIGHUP信号。或者给altermanager创建的http请求发送 -reload

比如这样 curl -X POST "http://10.102.74.90:9090/-/reload"

要指定要加载的配置文件，请使用该  `--config.file `  标志。

```shell
./alertmanager --config.file=alertmanager.yml
```

Alertmanager主要负责对Prometheus产生的告警进行统一处理，因此在Alertmanager配置中一般会包含以下几个主要部分：

- 全局配置（global）：用于定义一些全局的公共参数，如全局的SMTP配置，Slack配置等内容；
- 模板（templates）：用于定义告警通知时的模板，如HTML模板，邮件模板等；
- 告警路由（route）：根据标签匹配，确定当前告警应该如何处理；
- 接收人（receivers）：接收人是一个抽象的概念，它可以是一个邮箱也可以是微信，Slack或者Webhook等，接收人一般配合告警路由使用；
- 抑制规则（inhibit_rules）：合理设置抑制规则可以减少垃圾告警的产生

该文件以[YAML 格式](https://en.wikipedia.org/wiki/YAML)编写：

- `<duration>`: 匹配正则表达式的持续时间`((([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?|0)`，例如`1d`, `1h30m`, `5m`,`10s`
- `<labelname>`: 匹配正则表达式的字符串  `[a-zA-Z_][a-zA-Z0-9_]*`
- `<labelvalue>`: 一串unicode字符
- `<filepath>`: 当前工作目录中的有效路径
- `<boolean>`: 一个布尔值，可以取值`true`或`false`
- `<string>`: 普通字符串
- `<secret>`：作为秘密的常规字符串，例如密码
- `<tmpl_string>`: 使用前模板扩展的字符串
- `<tmpl_secret>`: 一个在使用前被模板扩展的字符串，这是一个密码
- `<int>`: 一个整数值

```yaml
global:
  # 默认的SMTP发件人标头字段。
  [ smtp_from: <tmpl_string> ]

  #用于发送电子邮件的默认SMTP 端口号
  [ smtp_smarthost: <string> ]

  #SMTP的主机名
  [ smtp_hello: <string> | default = "localhost" ]

  #SMTP的主机登录名字
  [ smtp_auth_username: <string> ]

  #SMTP的主机登录密码
  [ smtp_auth_password: <secret> ]

  # SMTP 登录ID
  [ smtp_auth_identity: <string> ]

  # SMTP 登录密码
  [ smtp_auth_secret: <secret> ]
  #默认的SMTP TLS要求。
  #请注意，Go不支持到远程SMTP端点的未加密连接。
  [ smtp_require_tls: <bool> | default = true ]

  #用于延迟通知的API URL。
  [ slack_api_url: <secret> ]
  [ slack_api_url_file: <filepath> ]
  [ victorops_api_key: <secret> ]
  [ victorops_api_url: <string> | default = "https://alert.victorops.com/integrations/generic/20131114/alert/" ]
  [ pagerduty_url: <string> | default = "https://events.pagerduty.com/v2/enqueue" ]
  [ opsgenie_api_key: <secret> ]
  [ opsgenie_api_url: <string> | default = "https://api.opsgenie.com/" ]
  [ wechat_api_url: <string> | default = "https://qyapi.weixin.qq.com/cgi-bin/" ]
  [ wechat_api_secret: <secret> ]
  [ wechat_api_corp_id: <string> ]

  # 默认的HTTP客户端配置
  [ http_config: <http_config> ]

  #ResolveTimeout是alertmanager在警报执行时使用的默认值
  #不包括EndsAt，在此时间过后，如果警报尚未更新，它可以将其声明为已解决。
  #这对来自普罗米修斯的警报没有影响，因为它们总是包含EndsAt。
  [ resolve_timeout: <duration> | default = 5m ]

#从中读取自定义通知模板定义的文件。
#最后一个组件可以使用通配符匹配器，例如“templates/*.tmpl”。
templates:
  [ - <filepath> ... ]

#路由树的根节点。
route: <route>

#通知接收者的列表。
receivers:
  - <receiver> ...

#抑制规则列表。
inhibit_rules:
  [ - <inhibit_rule> ... ]

#静音路由的静音时间间隔列表。
mute_time_intervals:
  [ - <mute_time_interval> ... ]
```

## Route

路由块定义路由树中的一个节点及其子节点。如果未设置，其可选配置参数将从其父节点继承。

每个警报在配置的顶级路由处进入路由树，该路由树必须匹配所有警报（即没有任何配置的匹配器）。然后遍历子节点。如果`continue`设置为 false，它会在第一个匹配的孩子之后停止。如果`continue`在匹配节点上为 true，则警报将继续与后续兄弟节点匹配。如果警报与节点的任何子节点都不匹配（没有匹配的子节点或不存在），则根据当前节点的配置参数处理警报。

翻译自：https://prometheus.io/docs/alerting/latest/configuration/#route

个人认为该解释已经过时

```yaml
[ receiver: <string> ]
#用于将传入警报分组在一起的标签。例如，
#cluster=A和alertname=LatencyHigh将出现多个警报
#分成一组。
#
#要按所有可能的标签进行聚合，请使用特殊值“…”作为唯一的标签名称，例如：
#分组依据：['…']
#这实际上完全禁用了聚合，通过所有
#按原样发出警报。这不可能是你想要的，除非你有
#警报量非常低或上游通知系统执行
#它自己的分组。
[ group_by: '[' <labelname>, ... ']' ]

#警报是否应继续匹配后续同级节点。
[ continue: <boolean> | default = false ]

#不推荐：使用下面的匹配器。
#警报必须满足的一组相等匹配器才能匹配节点。
match:
  [ <labelname>: <labelvalue>, ... ]

#不推荐：使用下面的匹配器。
#警报必须满足的一组正则表达式匹配器才能匹配节点。
match_re:
  [ <labelname>: <regex>, ... ]

#警报必须完成以匹配节点的匹配器列表。
matchers:
  [ - <matcher> ... ]

#发送组通知的初始等待时间
#警报数量。允许等待禁止警报到达或收集
#同一组的更多初始警报(通常是0到几分钟。）
[ group_wait: <duration> | default = 30s ]

#在发送有关新警报的通知之前要等待多长时间
#添加到已发出初始通知的警报组中
#已经发送了(通常约5分钟或以上。）
[ group_interval: <duration> | default = 5m ]



#如果已经发送了通知，在再次发送通知之前要等待多长时间
#已成功发送警报(通常约3小时或以上）。
[ repeat_interval: <duration> | default = 4h ]

#路由应静音的时间。这些必须与
#“静音时间间隔”部分中定义的静音时间间隔。
#此外，根节点不能有任何静音时间。
#当路由被禁用时，它不会发送任何通知，但是
#否则正常动作（包括结束路由匹配过程）
#如果未设置“continue”选项。）
mute_time_intervals:
  [ - <string> ...]

#零个或多个子路由。
routes:
  [ - <route> ... ]
 
```



例子



```yaml
#包含子级继承的所有参数的根路由
#如果未覆盖，则返回路由。
route:
  receiver: 'default-receiver'
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 4h
  group_by: [cluster, alertname]
  #与以下子路由不匹配的所有警报
  #将保留在根节点上并被分派到“default receiver”。
  routes:
  #service=mysql或service=cassandra的所有警报
  - receiver: 'database-pager'
    group_wait: 10s
    matchers:
    - service=~"mysql|cassandra"
  #所有带有team=frontend标签的警报都与此子路由匹配。
  - receiver: 'frontend-pager'
    group_by: [product, environment]
    matchers:
    - team="frontend"
```



接下来看下官方在git库中的例子

https://github.com/prometheus/alertmanager/blob/main/doc/examples/simple.yml
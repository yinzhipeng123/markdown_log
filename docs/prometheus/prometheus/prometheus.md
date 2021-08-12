---

---

Prometheus

## 服务端部署

Prometheus是服务端，默认也监控自己，负责定时轮询采集数据、存储、对外提供数据查询、告警规则检测

服务端：

| 主机名     | prometheus版本 | IP             |
| ---------- | -------------- | -------------- |
| prometheus | v2.15.2        | 192.168.70.130 |

客户端：

| 主机名        | node_exporter版本 | IP             |
| ------------- | ----------------- | -------------- |
| node_exporter | v0.18.1           | 192.168.70.131 |

告警中心：

| 主机名       | node_exporter版本 | IP             |
| ------------ | ----------------- | -------------- |
| alertmanager | v0.20.0           | 192.168.70.133 |



prometheus程序下载地址

https://github.com/prometheus/prometheus/releases/tag/v2.15.2



```bash
[root@prometheus ~]# tar -zxvf prometheus-2.15.2.linux-amd64.tar.gz 
prometheus-2.15.2.linux-amd64/
prometheus-2.15.2.linux-amd64/promtool
prometheus-2.15.2.linux-amd64/consoles/
prometheus-2.15.2.linux-amd64/consoles/node-cpu.html
prometheus-2.15.2.linux-amd64/consoles/index.html.example
prometheus-2.15.2.linux-amd64/consoles/node-overview.html
prometheus-2.15.2.linux-amd64/consoles/prometheus-overview.html
prometheus-2.15.2.linux-amd64/consoles/node-disk.html
prometheus-2.15.2.linux-amd64/consoles/node.html
prometheus-2.15.2.linux-amd64/consoles/prometheus.html
prometheus-2.15.2.linux-amd64/NOTICE
prometheus-2.15.2.linux-amd64/LICENSE
prometheus-2.15.2.linux-amd64/prometheus.yml
prometheus-2.15.2.linux-amd64/prometheus
prometheus-2.15.2.linux-amd64/tsdb
prometheus-2.15.2.linux-amd64/console_libraries/
prometheus-2.15.2.linux-amd64/console_libraries/menu.lib
prometheus-2.15.2.linux-amd64/console_libraries/prom.lib
[root@prometheus ~]# mv prometheus-2.15.2.linux-amd64 /usr/local/prometheus
[root@prometheus prometheus]# cat prometheus.yml | grep -v '^#' | grep -v '^$'
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  # 默认情况下，每15s拉取一次目标采样点数据。
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  #附加目标拉取，每15s拉取一次目标采样点数据
  # scrape_timeout is set to the global default (10s).
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      # - alertmanager:9093
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  # job名称会增加到拉取到的所有采样点上，同时还有一个instance目标服务的host：port标签也会增加到采样点上
  - job_name: 'prometheus'
    # metrics_path defaults to '/metrics'
    # 监控指标路径默认访问localhost:9090/metrics
    # scheme defaults to 'http'.
    # 目标默认为http
    static_configs:
    - targets: ['localhost:9090']
    #默认监控自己
    
    
[root@prometheus prometheus]# nohup ./prometheus --config.file=prometheus.yml > prometheus.log 2>&1 &
[1] 1969
#启动
```



一些启动参数

```
[root@prometheus prometheus]# ./prometheus --help
usage: prometheus [<flags>]

The Prometheus monitoring server

Flags:
  -h, --help                     展示帮助
      --version                  显示版本
      --config.file="prometheus.yml"  
                                 配置文件路径
      --web.listen-address="0.0.0.0:9090"  
                                 用于侦听 UI、API 的地址
      --web.read-timeout=5m      超时读取请求和关闭空闲连接之前的最大持续时间
      --web.max-connections=512  同时连接的最大数量
      --web.external-url=<URL>   外部可访问 Prometheus 的 URL
                                 
      --web.route-prefix=<path>  Prefix for the internal routes of web endpoints. Defaults to path of --web.external-url.
      --web.user-assets=<path>   Path to static asset directory, available at /user.
      --web.enable-lifecycle     通过 HTTP 请求启用关闭和重新加载。.
      配置该选项可以通过命令行   curl -X POST "http://xxx.xxx.xx.xxx:9090/-/reload" 进行重新加载配置
      --web.enable-admin-api     为管理控制操作启用 API 端点
      --web.console.templates="consoles"  
                                 控制台模板目录的路径，位于 /consoles。
      --web.console.libraries="console_libraries"  
                                 Path to the console library directory.
      --web.page-title="Prometheus Time Series Collection and Processing Server"  
                                 Document title of Prometheus instance.
      --web.cors.origin=".*"     Regex for CORS origin. It is fully anchored. Example: 'https?://(domain1|domain2)\.com'
      --storage.tsdb.path="data/"  
                                 tsdb数据存储的目录，默认当前data/
      --storage.tsdb.retention=STORAGE.TSDB.RETENTION  
                                 存储数据保存多长时间的，默认15天，这个选项在这个版本已经弃用，用storage.tsdb.retention.time代替
      --storage.tsdb.retention.time=STORAGE.TSDB.RETENTION.TIME  
                                 保留时间默认为15d。 支持的单位：y、 w、d、h、m、s、ms。
      --storage.tsdb.retention.size=STORAGE.TSDB.RETENTION.SIZE  
                                 [实验] 可以为块存储的最大字节数。 支持的单位：KB、MB、GB、TB、PB。 此标志是实验性的，可以在未来版本中更改。
      --storage.tsdb.no-lockfile  
                                 不要在数据目录中创建锁文件
      --storage.tsdb.allow-overlapping-blocks  
                                 [EXPERIMENTAL] Allow overlapping blocks, which in turn enables vertical compaction and
                                 vertical query merge.
      --storage.tsdb.wal-compression  
                                 Compress the tsdb WAL.
      --storage.remote.flush-deadline=<duration>  
                                 How long to wait flushing sample on shutdown or config reload.
      --storage.remote.read-sample-limit=5e7  
                                 Maximum overall number of samples to return via the remote read interface, in a single query.
                                 0 means no limit. This limit is ignored for streamed response types.
      --storage.remote.read-concurrent-limit=10  
                                 Maximum number of concurrent remote read calls. 0 means no limit.
      --storage.remote.read-max-bytes-in-frame=1048576  
                                 Maximum number of bytes in a single frame for streaming remote read response types before
                                 marshalling. Note that client might have limit on frame size as well. 1MB as recommended by
                                 protobuf by default.
      --rules.alert.for-outage-tolerance=1h  
                                 Max time to tolerate prometheus outage for restoring "for" state of alert.
      --rules.alert.for-grace-period=10m  
                                 Minimum duration between alert and restored "for" state. This is maintained only for alerts
                                 with configured "for" time greater than grace period.
      --rules.alert.resend-delay=1m  
                                 Minimum amount of time to wait before resending an alert to Alertmanager.
      --alertmanager.notification-queue-capacity=10000  
                                 The capacity of the queue for pending Alertmanager notifications.
      --alertmanager.timeout=10s  
                                 Timeout for sending alerts to Alertmanager.
      --query.lookback-delta=5m  The maximum lookback duration for retrieving metrics during expression evaluations.
      --query.timeout=2m         Maximum time a query may take before being aborted.
      --query.max-concurrency=20  
                                 并发执行的最大查询数。
      --query.max-samples=50000000  
                                 Maximum number of samples a single query can load into memory. Note that queries will fail if
                                 they try to load more samples than this into memory, so this also limits the number of samples
                                 a query can return.
      --log.level=info           Only log messages with the given severity or above. One of: [debug, info, warn, error]
      --log.format=logfmt        Output format of log messages. One of: [logfmt, json]
```



这就部署完成了，访问http://192.168.70.130:9090/就能看到监控页面。默认监控自己，那么监控哪些指标，访问http://192.168.70.130:9090/metrics就可以看到了。



## 客户端部署

exporter：以http的方式，暴露收集的metric，然后Prometheus server会定期来拉取数据，可安装在被监控主机

node_exporter是exporter的一种，用来监控Linux主机，如果监控windows主机，用windows_exporter,地址如下

https://github.com/prometheus-community/windows_exporter

部署

node_exporter下载地址：https://github.com/prometheus/node_exporter/releases/tag/v0.18.1

```bash
[root@node_exporter ~]# tar zxvf node_exporter-0.18.1.linux-amd64.tar.gz 
node_exporter-0.18.1.linux-amd64/
node_exporter-0.18.1.linux-amd64/node_exporter
node_exporter-0.18.1.linux-amd64/NOTICE
node_exporter-0.18.1.linux-amd64/LICENSE
[root@node_exporter ~]# mv node_exporter-0.18.1.linux-amd64 /usr/local/node_exporter
[root@node_exporter ~]# cd /usr/local/node_exporter/
[root@node_exporter node_exporter]# nohup ./node_exporter > node_exporter.log 2>&1 &  
[root@node_exporter node_exporter]# ss -tanp | grep node_exporter
LISTEN     0      128       [::]:9100                  [::]:*                   users:(("node_exporter",pid=1846,fd=3))
```

修改服务端Prometheus配置，然后重启使其配置生效

```bash
[root@prometheus prometheus]# cat prometheus.yml 
# my global config
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'
    static_configs:
    - targets: ['localhost:9090']
  - job_name: 'linux'
    static_configs:
    - targets: [ '192.168.70.131:9100' ]
[root@prometheus prometheus]# ps -ef | grep prome
root       1969   1808  0 11:05 pts/0    00:00:02 ./prometheus --config.file=prometheus.yml
root      11775   1808  0 12:45 pts/0    00:00:00 grep --color=auto prome
[root@prometheus prometheus]# kill -9 1969
[root@prometheus prometheus]# ps -ef | grep prome
root      11777   1808  0 12:45 pts/0    00:00:00 grep --color=auto prome
[1]+  已杀死               nohup ./prometheus --config.file=prometheus.yml > prometheus.log 2>&1
[root@prometheus prometheus]# ps -ef | grep prome
root      11779   1808  0 12:45 pts/0    00:00:00 grep --color=auto prome
[root@prometheus prometheus]# nohup ./prometheus --config.file=prometheus.yml > prometheus.log 2>&1 &
[1] 11786
```

然后查看prometheus的监控目标，出现131该机器

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Prometheus/8c374938-a3d5-4bd6-b10a-e28cce9a804c.png?raw=true)



## 告警中心 Alertmanager部署

Alertmanager 用于发送告警， 是真正发送信息给用户的模块。
Alertmanager 会接受Prometheus发送过来的警告信息，再由Alertmanager来发送。

```bash
[root@alertmanager ~]# tar -zxvf alertmanager-0.20.0.linux-amd64.tar.gz 
alertmanager-0.20.0.linux-amd64/
alertmanager-0.20.0.linux-amd64/LICENSE
alertmanager-0.20.0.linux-amd64/alertmanager
alertmanager-0.20.0.linux-amd64/amtool
alertmanager-0.20.0.linux-amd64/NOTICE
alertmanager-0.20.0.linux-amd64/alertmanager.yml
[root@alertmanager ~]# mv alertmanager-0.20.0.linux-amd64 /usr/local/alertmanager
[root@alertmanager ~]# cd /usr/local/alertmanager/
[root@alertmanager alertmanager]# cat alertmanager.yml 
global:
  resolve_timeout: 5m

route:
  group_by: ['alertname']
  group_wait: 10s
  group_interval: 10s
  repeat_interval: 1h
  receiver: 'web.hook'
receivers:
- name: 'web.hook'
  webhook_configs:
  - url: 'http://127.0.0.1:5001/'
inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'dev', 'instance']
    
[root@alertmanager alertmanager]# nohup ./alertmanager --config.file=./alertmanager.yml > alertmanager.log 2>&1 &     
```



然后修改prometheus配置，配置一些告警

```bash
[root@prometheus prometheus]# cat prometheus.yml 
global:
  scrape_interval:     1s
  evaluation_interval: 1s
alerting:
  alertmanagers:
    - static_configs:
        - targets: ['192.168.70.133:9093']
rule_files:
  - rules/*.yml
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
    - targets: ['localhost:9090']
  - job_name: 'linux'
    static_configs:
    - targets: [ '192.168.70.131:9100' ]
    
[root@prometheus prometheus]# cat rules/host.yml 
groups:
- name: Host
  rules:
  - alert: running 
    expr: node_procs_running > 0
    for: 5s
    labels:
      serverity: high
    annotations:
      summary: "{{$labels.instance}}: High running"
      description: "{{$labels.instance}}: running is {{$value}}"

[root@prometheus prometheus]# ps -ef | grep prom
root       1168      1  0 13:49 ?        00:00:00 /sbin/dhclient -1 -q -lf /var/lib/dhclient/dhclient-f52ff6ca-5e7d-4f00-b4f7-679ef47b77da-ens33.lease -pf /var/run/dhclient-ens33.pid -H prometheus ens33
root       1728   1704  0 13:54 pts/0    00:00:03 ./prometheus --config.file=prometheus.yml
root       1847   1704  0 14:55 pts/0    00:00:00 grep --color=auto prom
[root@prometheus prometheus]# kill -9 1728
[root@prometheus prometheus]# 
[1]+  已杀死               nohup ./prometheus --config.file=prometheus.yml > prometheus.log 2>&1
[root@prometheus prometheus]# 
[root@prometheus prometheus]# nohup ./prometheus --config.file=prometheus.yml --web.enable-lifecycle > prometheus.log 2>&1 &
```

 

这里有一些参数需要明确下：

- **evaluation_interval  告警的检测周期，就是告警的触发周期，比如你写了一个检测脚本或者rules，这个时间就是每隔多长时间去调用这个脚本**
- **scrape_interval  监控信息的拉取时间，就是拉取metrics的周期，Prometheus是每隔一段时间去拉取target中的目标的metrics**



在roles中

- **expr 用来触发报警的公式，可以在prom输入这个公式查看当前值**
- **for 这个触发持续了多久，有些指标必须维持一段时间才能算异常，在Prometheus中，告警为3种状态，Inactive、Pending、Firing三种，inactive就是没有触发的告警，Pending就是已经触发的告警，但是没有达到for规定的持续时长，Firing就是已经达到for规定的持续时长的告警，就是有效告警**



上面我监控的是主机内的正在运行或者可运行的线程数大于0就告警，正常这个值是一直大于0的

查看prometheus上的告警：

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Prometheus/alter.png?raw=true)



显示已经成功告警

然后查看altermanager上的告警

访问192.168.70.133:9093

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Prometheus/Prometheus/alertmanager.png?raw=true)

info就是rules中填写的内容，source点击会跳转去显示prometheus中该公式的实时值，silence就是创建一条该告警的静音规则


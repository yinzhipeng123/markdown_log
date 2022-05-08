# Depleyment挂载配置文件

例如prometheus挂载配置文件

配置文件：prometheus.yml 

 以ConfigMap形式存储，如下，在K8S中用 kubectl apply -f prometheus-yml.yaml 命令 发布 

下面内容文件名为： prometheus-yml.yaml 

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: infra-prometheus-yml
  namespace: default
data:
  prometheus.yml: >-
    global:
      scrape_interval: 15s
      evaluation_interval: 15s
    alerting:
      alertmanagers:
        - static_configs:
            - targets:
    rule_files:

    scrape_configs:
      - job_name: 'prometheus'
        consul_sd_configs:
        - server: 'infra-consul-net:8500'
          services: []
        relabel_configs:
          - source_labels: [__meta_consul_service]
            regex: .*prometheus.*
            action: keep
          - regex: __meta_consul_service_metadata_(.+)
            action: labelmap

      - job_name: 'node-exporter'
        consul_sd_configs:
        - server: 'infra-consul-net:8500'
          services: []
        relabel_configs:
          - source_labels: [__meta_consul_service]
            regex: .*node-exporter.*
            action: keep
          - regex: __meta_consul_service_metadata_(.+)
            action: labelmap

      - job_name: 'kube-state-metrics'
        consul_sd_configs:
        - server: 'infra-consul-net:8500'
          services: []
        relabel_configs:
          - source_labels: [ __meta_consul_service ]
            regex: .*kube-state-metrics.*
            action: keep
          - regex: __meta_consul_service_metadata_(.+)
            action: labelmap
```

应用部署文件：prometheus-deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: infra-prometheus
  namespace: default
  labels:
    app: infra-prometheus
    version: infra-prometheus-uat-podname
spec:
  replicas: 1
  progressDeadlineSeconds: 600
  selector:
    matchLabels:
      app: infra-prometheus
  template:
    metadata:
      labels:
        app: infra-prometheus
        version: infra-prometheus-uat-podname
    spec:
      containers:
      - name: infra-prometheus-uat-podname
        image: prom/prometheus:latest
        #挂载下面的configmap
        volumeMounts:
          - mountPath: /etc/prometheus/prometheus.yml
            subPath: prometheus.yml
            name: appconfs
        #设置IP，POD_Name变量
        env:
          - name: MY_POD_NAME
            valueFrom:
              fieldRef:
                fieldPath: metadata.name
          - name: MY_POD_IP
            valueFrom:
              fieldRef:
                fieldPath: status.podIP
          - name: ENV
            value: UAT
        ports:
        - name: requestshttp
          containerPort: 9090
          protocol: TCP
      - name: curl
        image: curlimages/curl:latest
        env:
          - name: MY_POD_NAME
            valueFrom:
              fieldRef:
                fieldPath: metadata.name
          - name: MY_POD_IP
            valueFrom:
              fieldRef:
                fieldPath: status.podIP
          - name: ENV
            value: UAT
        #该命令让容器永久运行
        command: [ '/bin/sh','-c' ]
        args: ['while true;do sleep 1s;done']
        lifecycle:
          postStart:
            exec:
              command: [ '/bin/sh','-c','curl -X PUT -d  "{\"id\": \"prometheus-$MY_POD_IP\",\"name\": \"prometheus\",\"address\":\"$MY_POD_IP\",\"port\": 9090,\"tags\": [\"prometheus\"],\"checks\": [{\"http\": \"http://$MY_POD_IP:9090/metrics\", \"interval\": \"15s\"}]}" http://infra-consul-net:8500/v1/agent/service/register && echo "{\"id\": \"prometheus-$MY_POD_IP\",\"name\": \"prometheus\",\"address\":\"$MY_POD_IP\",\"port\": 9090,\"tags\": [\"prometheus\"],\"checks\": [{\"http\": \"http://$MY_POD_IP:9090/metrics\", \"interval\": \"15s\"}]}" > /tmp/curl.txt' ]
          preStop:
            exec:
              command: [ '/bin/sh','-c','curl -X PUT http://infra-consul-net:8500/v1/agent/service/deregister/prometheus-$MY_POD_IP' ]
      #声明configmap的部分键值
      volumes:
        - name: appconfs
          configMap:
            name: infra-prometheus-yml
            items:
            - key: prometheus.yml
              path: prometheus.yml
```

configMap卷插件中的items字段的值是一个对象列表，可嵌套使用3个字段来组合指定要引用的特定键。
▪key <string>：要引用的键名称，必选字段。
▪path <string>：对应的键在挂载点目录中映射的文件名称，它可不同于键名称，必选字段。
▪mode <integer>：文件的权限模型，可用范围为0～0777。

https://www.jianshu.com/p/762c8ccdb092
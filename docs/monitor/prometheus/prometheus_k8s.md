# K8S环境中部署Prometheus

找一台有kubectl命令的机器，并能连接到K8S集群，然后克隆官方git库，因为我的K8S是1.18，所以我要克隆 release-0.5版本

```bash
[root@centos7 ~]# git clone -b release-0.5 https://github.com/prometheus-operator/kube-prometheus.git
然后直接部署即可
[root@centos7 ~]# kubectl apply -f kube-prometheus/manifests/setup/
[root@centos7 ~]# kubectl apply -f kube-prometheus/manifests/*
然后就部署完成了
```


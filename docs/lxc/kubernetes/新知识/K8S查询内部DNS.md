

查看负责解析DNS的POD

```bash
[root@k8smaster1 ~]# kubectl get pods -n kube-system -l k8s-app=kube-dns
coredns-6d9c4b78f6-49zx2                                           1/1     Running   1 (14d ago)   20d
coredns-6d9c4b78f6-l24gg                                           1/1     Running   1 (14d ago)   20d
coredns-6d9c4b78f6-rflf5                                           1/1     Running   1 (14d ago)   20d
```

查看解析DNS端口

```bash
[root@k8smaster1 ~]#  kubectl get svc -n kube-system -l k8s-app=kube-dns 
NAME       TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)                  AGE
kube-dns   ClusterIP   100.69.0.10   <none>        53/UDP,53/TCP,9153/TCP   20d
```

查看可以解析哪些域名

```bash
kubectl get svc --all-namespaces -o jsonpath='{range .items[*]}{.metadata.name}{"."}{.metadata.namespace}{"."}svc.cluster.local ' | tr ' ' '\n'
```





查看COREDNS配置

```bash
[root@k8smaster1 ~]# kubectl -n kube-system get configmap coredns -o jsonpath='{.data.Corefile}' 
.:53 {   # 定义 CoreDNS 监听所有域名 (.)，使用 53 端口
    errors   # 启用错误日志记录，当解析失败时记录错误
    health   # 启用健康检查接口，方便监控 CoreDNS 状态
    log      # 启用访问日志，记录每次 DNS 请求
    kubernetes cluster.local in-addr.arpa ip6.arpa {   # 启用 Kubernetes 插件，解析 cluster.local 域名及反向 DNS
        pods insecure   # 允许直接读取 Pod 的 DNS 记录（不安全模式）
        fallthrough in-addr.arpa ip6.arpa   # 如果无法解析反向域名请求，继续向下传递
        ttl 30   # DNS 记录缓存时间为 30 秒
    }
   hosts {   # 启用 hosts 插件，用于自定义静态主机名解析
      fallthrough   # 如果 hosts 中没有匹配的记录，则继续使用后续插件解析
    }
    prometheus :9153   # 启用 Prometheus 监控插件，监听 9153 端口，收集指标
    forward . 10.6.10.11   # 将所有 DNS 查询转发到上游 DNS 服务器 10.6.10.11
    cache 30   # 启用缓存插件，将 DNS 结果缓存 30 秒，提高查询效率
    loop   # 检测循环转发，防止 DNS 查询形成死循环
    reload   # 监控 Corefile 文件变化，自动重新加载配置
    loadbalance   # 对多个上游 DNS 服务器请求进行负载均衡（此处只有一个上游）
}
```


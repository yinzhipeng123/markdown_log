

```bash
[root@k8s ~]# kubectl get svc -A  
NAMESPACE         NAME                                          TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                                                                                                                                             AGE
base              base-kafka-global-default                     LoadBalancer   100.69.163.160   10.6.92.198   8959:31451/TCP                                                                                                                                      15d   # base命名空间，服务名，服务类型为外部可访问的负载均衡器，集群内IP，外部访问IP，端口映射（集群端口:节点端口/协议），创建时间
base              base-kafka-global-default-headless            ClusterIP      None             <none>        8959/TCP,9093/TCP                                                                                                                                   15d   # headless服务（无Cluster IP），用于StatefulSet等直接访问Pod，集群内IP为空，无外部IP，提供两个TCP端口，创建时间
base              base-kafka-global-default-metrics             ClusterIP      100.69.17.88     <none>        9308/TCP                                                                                                                                             15d   # ClusterIP类型服务，仅集群内部访问，用于指标监控，集群内IP，未分配外部IP，暴露9308端口，创建时间
base              base-kafka-xian-default                       LoadBalancer   100.69.140.24    10.6.93.181   8959:31395/TCP                                                                                                                                      15d   # LoadBalancer类型服务，集群内IP和外部IP，端口映射为8959集群端口对应31395节点端口，创建时间
base              base-kafka-xian-default-headless              ClusterIP      None             <none>        8959/TCP,9093/TCP                                                                                                                                   15d   # headless服务，无Cluster IP，集群内部访问Pod用，暴露8959和9093端口，创建时间
                                                                     
```





### 1️⃣ **Kubernetes 中的 `TYPE` 字段**

- `kubectl get svc` 输出的 `TYPE`，本质上是 **服务的类型声明**，告诉 Kubernetes **这个服务怎么暴露**。
- 常见类型有：
  - `ClusterIP` → 默认，只能集群内访问。
  - `LoadBalancer` → 外部可访问。
  - `NodePort` → 集群外通过节点端口访问。
  - `ExternalName` → 通过 DNS 名称访问外部服务。

------

### 2️⃣ **Headless 服务为什么 TYPE 还是 ClusterIP**

- Headless 服务本质上也是一种 ClusterIP 服务，只是 **人为把 ClusterIP 设置成 `None`**。

  ```
  spec.clusterIP: None
  ```

- 因为它依然是 Kubernetes 内部的服务对象，只是：

  - 不分配固定 ClusterIP。
  - 不做负载均衡。
  - DNS 查询会返回所有 Pod IP，而不是单个虚拟 IP。

- 所以在 `kubectl get svc` 中，TYPE 显示为 **ClusterIP**，并不会单独显示 “Headless”，这是 Kubernetes 的输出约定。

------

### 3️⃣ 总结一句话

- **ClusterIP = 有虚拟 IP，访问会负载均衡**
- **Headless (ClusterIP=None) = 没虚拟 IP，访问 Pod IP 由客户端控制**
- **TYPE 字段显示 ClusterIP** 是因为它本质还是一种 ClusterIP 服务，只是 ClusterIP 被设为 None。



### svc查询详情

```
[root@k8smaster ~]# kubectl describe svc mydb-global-default -n base  
Name:                     mydb-global-default                     # 服务名称  
Namespace:                base                                   # 所在命名空间  
Labels:                   app=mydb-global-default                  # 服务的标签（用于选择 Pod）  
                          app.kubernetes.io/managed-by=Helm       # 表示该服务由 Helm 管理  
                          app.kubernetes.io/role=cluster-metrics  # 标识服务在集群中的角色  
                          karrier.replaced.com/app=mydb-global-default   # 自定义标签：标识应用名（已替换敏感信息）  
                          karrier.replaced.com/component=mydb            # 自定义标签：标识组件名（已替换敏感信息）  
                          region=xian                             # 所属地域（例如：西安）  
Annotations:              helm.sh/resource-policy: keep           # Helm 注解，表示删除 release 时保留该资源  
                          karrier.replaced.com/lb-controller-vsid-list: base_mydb-global-default_6203,base_mydb-global-default_8500,base_mydb-global-default_9104  
                                                                 # 自定义注解，记录负载均衡控制器关联的虚拟服务 ID 列表（已替换敏感信息）  
                          meta.helm.sh/release-name: mydb-global-default   # Helm release 名称  
                          meta.helm.sh/release-namespace: base           # Helm release 所在命名空间  
                          service.beta.kubernetes.io/stack-load-balancer-health-check-interval: 20  
                                                                 # 健康检查间隔（单位：秒）  
                          service.beta.kubernetes.io/stack-load-balancer-health-check-retry: 3  
                                                                 # 健康检查失败重试次数  
                          service.beta.kubernetes.io/stack-load-balancer-health-check-timeout: 10  
                                                                 # 健康检查超时时间（单位：秒）  
                          service.beta.kubernetes.io/stack-load-balancer-schname: srch  
                                                                 # 负载均衡调度器名称  
                          service.beta.kubernetes.io/stack-load-balancer-vip-region: xian  
                                                                 # VIP 所属地域（例如：西安）  
                          service.beta.kubernetes.io/stack-load-balancer-vip-type: underlay  
                                                                 # VIP 类型（underlay 表示底层网络直连）  
Selector:                 karrier.replaced.com/app=mydb-global-default  
                                                                 # 选择器，决定该 Service 关联哪些 Pod（通过匹配标签）  
Type:                     LoadBalancer                           # Service 类型，创建外部负载均衡器  
IP Family Policy:         SingleStack                            # IP 家族策略（单栈 IPv4）  
IP Families:              IPv4                                   # 使用 IPv4  
IP:                       100.69.75.210                          # ClusterIP（集群内访问地址）  
IPs:                      100.69.75.210                          # 同上，可能列出多个 IP  
LoadBalancer Ingress:     10.6.92.87                             # 外部负载均衡入口地址（供外部访问）  
Port:                     6203-tcp  6203/TCP                     # 暴露的第一个端口（名称与协议）  
TargetPort:               6203/TCP                               # 对应 Pod 中的容器端口  
Endpoints:                10.6.76.130:6203,10.6.76.44:6203,10.6.88.174:6203  
                                                                 # 实际后端 Pod 的 IP 与端口（负载均衡目标）  
Port:                     8500-tcp  8500/TCP                     # 第二个暴露端口  
TargetPort:               8500/TCP                               # 对应容器端口  
Endpoints:                10.6.76.130:8500,10.6.76.44:8500,10.6.88.174:8500  
                                                                 # 后端服务的实际地址  
Port:                     9104-tcp  9104/TCP                     # 第三个暴露端口  
TargetPort:               9104/TCP                               # 对应容器端口  
Endpoints:                10.6.76.130:9104,10.6.76.44:9104,10.6.88.174:9104  
                                                                 # 后端服务的实际地址  
Session Affinity:         None                                   # 无会话亲和性（不固定请求到同一 Pod）  
External Traffic Policy:  Cluster                                # 外部流量策略为集群级（任意节点都可转发）  
Events:                   <none>                                 # 没有相关事件（无错误或状态变更记录）  

```


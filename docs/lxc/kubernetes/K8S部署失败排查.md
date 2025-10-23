



#### 查看POD名称

```bash
 kubectl -n <命名空间> get pods
```

例如：

```bash
kubectl get pods -n business | grep app-vpc-x
 app-vpc-x-0     0/1     ContainerCreating   0          5h51m # Pod 名称为 app-vpc-x-0；当前状态为 “ContainerCreating”，表示容器正在创建中；0/1 表示 1 个容器中有 0 个处于就绪状态；“0” 是重启次数；“5h51m” 表示该 Pod 已经运行（或等待）了 5 小时 51 分钟。
```



#### 查看POD描述

```
kubectl describe pod <pod名字> -n <命名空间>
```

例如：

```yaml
Name:             app-vpc-x-0                                   # Pod 名称
Namespace:        business                                      # 所属命名空间
Priority:         0                                             # Pod 优先级
Service Account:  app-vpc-x                                     # 使用的 ServiceAccount
Node:             node1.dev.cluster.local/10.1.67.20            # 调度到的节点和 IP
Start Time:       Fri, 10 Oct 2025 19:24:10 +0800               # 启动时间
Labels:           app=app-vpc-x                                 # 应用标签
                  apps.kubernetes.io/pod-index=0                # StatefulSet 序号
                  controller-revision-hash=app-vpc-x-68d5b6d6c7 # 控制器修订版本
                  company.cluster.com/app=app-vpc-x             # 自定义标签：应用名
                  company.cluster.com/component=app-vpc         # 自定义标签：组件名
                  lifecycle.apps.kruise.io/state=Normal         # Kruise 管理状态正常
                  statefulset.kubernetes.io/pod-name=app-vpc-x-0 # StatefulSet 管理的 Pod 名称
Annotations:      checksum/configmap: 6af89aa7e0eadb078cd03de4e0860fbdcc0d055f3bc51b30345a67e22b9a07e8 # ConfigMap 变更校验
                  company.cluster.com/app-version: 3.3.34       # 应用版本号
                  lifecycle.apps.kruise.io/timestamp: 2025-10-10T03:24:12Z # Kruise 时间戳
Status:           Pending                                       # Pod 状态为 Pending
IP:                                                             # 尚未分配 IP
IPs:              <none>                                        # 无 IP
Controlled By:    StatefulSet/app-vpc-x                         # 由 StatefulSet 控制
Containers:
  app-vpc:
    Container ID:                                               # 容器 ID（尚未创建）
    Image:          registry.dev.cluster.local:5000/stack/app-vpc:1.0.0.61 # 镜像路径
    Image ID:                                                  # 镜像 ID 未生成
    Port:           8788/TCP                                   # 容器暴露的端口
    Host Port:      0/TCP                                      # 主机端口未映射
    State:          Waiting                                    # 正在等待
      Reason:       ContainerCreating                          # 原因：创建中
    Ready:          False                                      # 未就绪
    Restart Count:  0                                          # 尚未重启
    Limits:
      cpu:     4                                               # 最大 4 CPU
      memory:  8000Mi                                          # 最大 8GB 内存
    Requests:
      cpu:      4                                              # 请求 4 CPU
      memory:   8000Mi                                         # 请求 8GB 内存
    Liveness:   tcp-socket :8788 delay=5s timeout=5s period=30s #success=1 #failure=5 # 存活探针
    Readiness:  tcp-socket :8788 delay=5s timeout=5s period=30s #success=1 #failure=5 # 就绪探针
    Environment:
      APP_NODE_NAME:       (v1:spec.nodeName)                  # 节点名
      APP_POD_NAME:       app-vpc-x-0 (v1:metadata.name)       # Pod 名称
      APP_POD_NAMESPACE:  business (v1:metadata.namespace)     # 命名空间
      APP_POD_IP:          (v1:status.podIP)                   # Pod IP
      APP_NODE_IP:         (v1:status.hostIP)                  # 节点 IP
      APP_NAME:           app-vpc-x                            # 应用名称
      APP_POD_FQDN:       $(APP_POD_NAME).$(APP_NAME)-hs.$(APP_POD_NAMESPACE).svc.cluster.local # Pod 完整域名
      APP_HEADLESS_SVC:   $(APP_NAME)-hs.$(APP_POD_NAMESPACE).svc.cluster.local # 无头服务 DNS 名
      APP_SVC:            $(APP_NAME).$(APP_POD_NAMESPACE).svc.cluster.local # 服务 DNS 名
    Mounts:
      /etc/localtime from app-localtime (rw)                   # 宿主机时区
      /home/app/conf/agent.config from app-vpc-x (rw,path="agent.config") # 配置文件
      /home/app/conf/application.properties from app-vpc-x (rw,path="application.properties") # 配置文件
      /home/app/conf/endpoint.json from app-vpc-x (rw,path="endpoint.json") # 配置文件
      /home/scripts from app-scripts (rw)                      # 脚本目录
      /home/tools from app-tools (rw)                          # 工具目录
      /usr/share/zoneinfo/Asia/Shanghai from app-shanghai (rw) # 时区文件
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-xjvkr (ro) # 服务账号凭证
Readiness Gates:
  Type                 Status
  InPlaceUpdateReady   True                                   # 支持 Kruise 原地更新
  KruisePodReady       True                                   # Kruise Pod 已就绪
Conditions:
  Type                 Status
  Initialized          True                                   # 初始化完成
  Ready                False                                  # Pod 未就绪
  ContainersReady      False                                  # 容器未就绪
  KruisePodReady       True                                   # Kruise 标记为就绪
  PodScheduled         True                                   # 已调度到节点
  InPlaceUpdateReady   True                                   # 支持原地更新
Volumes:
  app-localtime:
    Type:          HostPath (bare host directory volume)      # 挂载宿主机目录
    Path:          /etc/localtime                             # 时区文件
    HostPathType:  
  app-shanghai:
    Type:          HostPath (bare host directory volume)
    Path:          /usr/share/zoneinfo/Asia/Shanghai
    HostPathType:  
  app-tools:
    Type:          HostPath (bare host directory volume)
    Path:          /home/tools
    HostPathType:  
  app-scripts:
    Type:          HostPath (bare host directory volume)
    Path:          /home/scripts
    HostPathType:  
  app-vpc-x:
    Type:      ConfigMap (a volume populated by a ConfigMap)  # 配置挂载
    Name:      app-vpc-x
    Optional:  false
  kube-api-access-xjvkr:
    Type:                    Projected                        # 多来源组合卷
    TokenExpirationSeconds:  3607                             # Token 过期时间
    ConfigMapName:           kube-root-ca.crt                  # 根证书
    ConfigMapOptional:       <nil>
    DownwardAPI:             true                              # 启用 Downward API
QoS Class:                   Guaranteed                        # QoS 保证等级最高
Node-Selectors:              <none>                            # 无节点选择
Tolerations:                 node.kubernetes.io/disk-pressure:NoSchedule op=Exists # 容忍磁盘压力
                             node.kubernetes.io/memory-pressure:NoSchedule op=Exists # 容忍内存压力
                             node.kubernetes.io/not-ready:NoExecute op=Exists for 300s # 节点不就绪宽限
                             node.kubernetes.io/pid-pressure:NoSchedule op=Exists # 容忍 PID 压力
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s # 节点不可达宽限
Events:
  Type     Reason                  Age                                From     Message
  ----     ------                  ----                               ----     -------
  Normal   SandboxChanged          <invalid> (x20536 over <invalid>)  kubelet  Pod sandbox changed, it will be killed and re-created. # Pod 网络沙箱重建
  Warning  FailedCreatePodSandBox  <invalid> (x20840 over <invalid>)  kubelet  (combined from similar events): Failed to create pod sandbox: rpc error: code = Unknown desc = failed to setup network for sandbox "4411a7434efc67ad6af059c30d6dbec7a3b75ebee616ca1087c9364b1a919ff1": plugin type="custom-macvlan" failed (add): failed to find plugin "custom-macvlan" in path [/opt/cni/bin]  # 错误：创建网络 sandbox 失败，找不到 CNI 插件 custom-macvlan

```



#### 查看node节点状态

```bash
kubectl describe node NODEX
```

例如：

```
[root@k8smaster1 ~]# kubectl describe node NODEX       # 描述指定节点的详细信息
Name: NODEX           # 节点名称
Roles: controller     # 节点角色，这里是 controller（控制平面节点）
Labels: LABELX.cloud.network.pod-cidr=    # 自定义标签，定义 Pod 网络 CIDR
        beta.kubernetes.io/arch=amd64            # 节点 CPU 架构
        beta.kubernetes.io/os=linux              # 节点操作系统
        blueprint.karrier.LABELX.acpoc=true      # 自定义蓝图标签，节点是否为 acpoc
        blueprint.karrier.LABELX.controller=true # 自定义蓝图标签，节点是否为 controller
        blueprint.karrier.LABELX.k8sworker=true  # 自定义蓝图标签，节点是否为 k8s worker
        kubernetes.io/arch=amd64                 # Kubernetes 官方标签，CPU 架构
        kubernetes.io/hostname=NODEX             # Kubernetes 官方标签，节点主机名
        kubernetes.io/os=linux                   # Kubernetes 官方标签，节点操作系统
        node-role.kubernetes.io/controller=true  # 节点角色标签，controller
        topology.kubernetes.io/rack=RACKX        # 拓扑标签，节点所在机架
        topology.kubernetes.io/region=REGIONX    # 拓扑标签，节点所在区域
        topology.kubernetes.io/tor=10.1.67.1     # 拓扑标签，节点 Top-of-Rack 交换机 IP
        topology.kubernetes.io/zone=ZONEX         # 拓扑标签，节点所在可用区
Annotations:                                    # 注释信息，存储节点的一些额外信息
  kubernetes.io/cloudbed.instance.annotations: null  # 实例注释为空
  kubernetes.io/cloudbed.instance.labels: {...}     # 节点标签 JSON 信息
  kubernetes.io/cloudbed.instance.taints: null      # 节点污点信息为空
  node.alpha.kubernetes.io/ttl: 0                  # 节点过期时间，0 表示不删除
  volumes.kubernetes.io/controller-managed-attach-detach: true # 卷附加/分离由 controller 管理
CreationTimestamp: Sat, 11 Oct 2025 16:47:13 +0800 # 节点创建时间
Taints: <none>                                    # 节点污点，<none> 表示无污点
Unschedulable: false                               # 节点是否不可调度
Lease:                                             # 节点心跳租约信息
  HolderIdentity: NODEX                             # 当前租约持有者
  AcquireTime: <unset>                              # 租约获取时间
  RenewTime: Tue, 14 Oct 2025 10:52:41 +0800        # 租约最近更新时间
Conditions:                                        # 节点状态条件列表
  Type                 Status  LastHeartbeatTime            LastTransitionTime          Reason                     Message
  ----                 ------  -----------------            ------------------          ------                     -------
  MemoryPressure       False   Tue, 14 Oct 2025 10:52:19     Tue, 14 Oct 2025 10:51:18   KubeletHasSufficientMemory kubelet 有足够内存
  DiskPressure         False   Tue, 14 Oct 2025 10:52:19     Tue, 14 Oct 2025 10:51:18   KubeletHasNoDiskPressure  kubelet 磁盘压力正常
  PIDPressure          False   Tue, 14 Oct 2025 10:52:19     Tue, 14 Oct 2025 10:51:18   KubeletHasSufficientPID   kubelet 有足够进程 ID
  Ready                True    Tue, 14 Oct 2025 10:52:19     Tue, 14 Oct 2025 10:51:18   KubeletReady              kubelet 节点准备就绪
Addresses:                                         # 节点地址
  InternalIP: 10.1.67.21                             # 节点内部 IP
  Hostname: NODEX                                     # 节点主机名
Capacity:                                           # 节点总资源容量
  cpu: 96                                          # CPU 核心数
  ephemeral-storage: 103080888Ki                   # 临时存储容量
  hugepages-1Gi: 0                                 # 1Gi hugepages 数量
  hugepages-2Mi: 0                                 # 2Mi hugepages 数量
  memory: 394471396Ki                              # 内存总量
  pods: 512                                        # 最大可调度 pod 数量
Allocatable:                                       # 节点可分配资源（留出系统使用量）
  cpu: 96                                          # 可分配 CPU
  ephemeral-storage: 104499281043                  # 可分配临时存储
  hugepages-1Gi: 0                                 # 可分配 1Gi hugepages
  hugepages-2Mi: 0                                 # 可分配 2Mi hugepages
  memory: 394368996Ki                              # 可分配内存
  pods: 512                                        # 可分配 Pod 数
System Info:                                       # 系统信息
  Machine ID: 875669c39e4d4d81a59e6500a135cd95     # 节点机器 ID
  System UUID: 213b9f6a-5ca7-04d4-e611-b7cf3c32170b # 系统 UUID
  Boot ID: 9f0c8bc6-0481-4008-8347-617b5357cd29    # 系统启动 ID
  Kernel Version: 4.19.0-1.0.0.14                  # 内核版本
  OS Image: CentOS Linux 7 (Core)                  # 操作系统镜像
  Operating System: linux                           # 操作系统类型
  Architecture: amd64                               # 系统架构
  Container Runtime Version: containerd://1.7.27    # 容器运行时版本
  Kubelet Version: v1.27.16                         # kubelet 版本
  Kube-Proxy Version: v1.27.16                      # kube-proxy 版本
  ProviderID: PROVIDERX://node-10-1-67-21          # 云提供商节点 ID
Non-terminated Pods: (5 in total)                  # 节点上未终止 Pod 列表
Namespace          Name                                         CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
---------          ----                                         ------------  ----------  ---------------  -------------  ---
base               PODX-1                                      100m (0%)     2 (2%)      128Mi (0%)       2Gi (0%)       18h    # Pod 名称及资源使用情况
cangzhu            PODX-2                                      100m (0%)     1 (1%)      256Mi (0%)       2Gi (0%)       2d18h
karrier-system     PODX-3                                      50m (0%)      100m (0%)   128Mi (0%)       256Mi (0%)     2d18h
kube-system        PODX-4                                      150m (0%)     150m (0%)   384Mi (0%)       384Mi (0%)     2d18h
kube-system        PODX-5                                      256m (0%)     512m (0%)   256Mi (0%)       512Mi (0%)     2d18h
Allocated resources: (Total limits may be over 100 percent, i.e., overcommitted.) # 已分配资源总览
Resource  Requests  Limits
--------  --------  ------
cpu       656m (0%) 3762m (3%)                               # 已申请 CPU 与限制 CPU 占比
memory    1152Mi (0%) 5248Mi (1%)                            # 已申请内存与限制内存占比
ephemeral-storage 0 (0%) 0 (0%)                               # 临时存储已申请/限制
hugepages-1Gi     0 (0%) 0 (0%)                               # hugepage 1Gi 已申请/限制
hugepages-2Mi     0 (0%) 0 (0%)                               # hugepage 2Mi 已申请/限制
Events:                                                       # 节点事件列表
Type    Reason                  Age            From       Message
----    ------                  ----           ----       -------
Normal  NodeHasSufficientPID    21m (x580)    kubelet    Node NODEX status is now: NodeHasSufficientPID  # 节点 PID 足够
Normal  NodeHasNoDiskPressure   14m (x581)    kubelet    Node NODEX status is now: NodeHasNoDiskPressure   # 节点磁盘压力正常
Normal  NodeNotReady            105s (x582)   node-controller  Node NODEX status is now: NodeNotReady          # 节点暂时不可用
Normal  NodeHasSufficientMemory 96s (x584)    kubelet    Node NODEX status is now: NodeHasSufficientMemory # 节点内存足够

```



 **精确的事件时间**，可以使用下面命令查询所有事件并显示时间戳：

```
kubectl get events --field-selector involvedObject.name=NODEX -o wide --sort-by='.lastTimestamp'
```

这样可以看到节点所有 `NotReady` / `Ready` 事件的 **精确发生时间**。

例如：

```bash
[root@k8smaster1 ~]# kubectl get events --field-selector involvedObject.name=NODEX.CLUSTERX.REGIONX.com -o wide --sort-by='.lastTimestamp'
LAST SEEN   TYPE     REASON                    OBJECT                                     SUBOBJECT   SOURCE                                         MESSAGE                                                                           FIRST SEEN   COUNT   NAME
98s         Normal   NodeNotReady              node/NODEX.CLUSTERX.REGIONX.com               node-controller                                Node NODEX.CLUSTERX.REGIONX.com status is now: NodeNotReady              2d18h        583     NODEX.CLUSTERX.REGIONX.com.186d639218d301de  # 节点在 98 秒前被标记为 NotReady（暂时不可用）
80s         Normal   NodeHasSufficientMemory   node/NODEX.CLUSTERX.REGIONX.com               kubelet, NODEX.CLUSTERX.REGIONX.com          Node NODEX.CLUSTERX.REGIONX.com status is now: NodeHasSufficientMemory   2d18h        585     NODEX.CLUSTERX.REGIONX.com.186d638066813832  # 节点内存充足，Ready 状态检查通过
80s         Normal   NodeHasNoDiskPressure     node/NODEX.CLUSTERX.REGIONX.com               kubelet, NODEX.CLUSTERX.REGIONX.com          Node NODEX.CLUSTERX.REGIONX.com status is now: NodeHasNoDiskPressure     2d18h        585     NODEX.CLUSTERX.REGIONX.com.186d638066816b60  # 节点磁盘压力正常
80s         Normal   NodeHasSufficientPID      node/NODEX.CLUSTERX.REGIONX.com               kubelet, NODEX.CLUSTERX.REGIONX.com          Node NODEX.CLUSTERX.REGIONX.com status is now: NodeHasSufficientPID      2d18h        585     NODEX.CLUSTERX.REGIONX.com.186d638066818761  # 节点 PID（进程数）充足
80s         Normal   NodeReady                 node/NODEX.CLUSTERX.REGIONX.com               kubelet, NODEX.CLUSTERX.REGIONX.com          Node NODEX.CLUSTERX.REGIONX.com status is now: NodeReady                 2d18h        584     NODEX.CLUSTERX.REGIONX.com.186d6383571063d3  # 节点最终恢复 Ready 状态，可正常调度 Pod
```

每列含义解释

- **LAST SEEN** → 最近一次事件发生距离现在的时间
- **TYPE** → 事件类型，Normal 表示正常状态，Warning 表示异常
- **REASON** → 事件原因，表示触发事件的状态变化
- **OBJECT** → 事件作用对象，这里是节点
- **SUBOBJECT** → 节点的子对象或控制器相关信息
- **SOURCE** → 触发事件的来源组件（如 kubelet 或 node-controller）
- **MESSAGE** → 事件具体描述，节点状态变化信息
- **FIRST SEEN** → 事件第一次发生时间
- **COUNT** → 事件累计次数
- **NAME** → 事件唯一名称
## nodeSelector

我们知道`label`是`kubernetes`中一个非常重要的概念，用户可以非常灵活的利用 label 来管理集群中的资源，比如最常见的一个就是 service 通过匹配 label 去选择 POD 的。而 POD 的调度也可以根据节点的 label 进行特定的部署。

我们可以通过下面的命令查看我们的 node 的 label：

```shell
$ kubectl get nodes --show-labels
NAME            STATUS    ROLES     AGE       VERSION   LABELS
192.168.1.140   Ready     <none>    42d       v1.8.1    beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/hostname=192.168.1.140
192.168.1.161   Ready     <none>    118d      v1.8.1    beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/cluster-service=true,kubernetes.io/hostname=192.168.1.161
192.168.1.170   Ready     <none>    118d      v1.8.1    beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/cluster-service=true,kubernetes.io/hostname=192.168.1.170
192.168.1.172   Ready     <none>    114d      v1.8.1    beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/cluster-service=true,kubernetes.io/hostname=192.168.1.172
```

现在我们先给节点**192.168.1.140**增加一个`source=qikqiak`的标签，命令如下：

```shell
$ kubectl label nodes 192.168.1.140 source=qikqiak
node "192.168.1.140" labeled
```

我们可以通过上面的`--show-labels`参数可以查看上述标签是否生效。当 node 被打上了相关标签后，在调度的时候就可以使用这些标签了，只需要在 POD 的 spec 字段中添加`nodeSelector`字段，里面是我们需要被调度的节点的 label。例如，下面是我们之前的一个默认的 busybox POD 的 YAML 文件：

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: busybox-pod
  name: test-busybox
spec:
  containers:
  - command:
    - sleep
    - "3600"
    image: busybox
    imagePullPolicy: Always
    name: test-busybox
```

然后我需要让上面的 POD 被调度到140的节点上，那么最简单的方法就是去匹配140上面的 label，如下：

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: busybox-pod
  name: test-busybox
spec:
  containers:
  - command:
    - sleep
    - "3600"
    image: busybox
    imagePullPolicy: Always
    name: test-busybox
  nodeSelector:
    source: qikqiak
```

然后我们可以通过 describe 命令查看调度结果：

```shell
$ kubectl describe pod test-busybox
......
Events:
  Type    Reason                 Age   From                    Message
  ----    ------                 ----  ----                    -------
  Normal  Scheduled              49s   default-scheduler       Successfully assigned test-busybox to 192.168.1.140
  Normal  SuccessfulMountVolume  49s   kubelet, 192.168.1.140  MountVolume.SetUp succeeded for volume "default-token-hmpbz"
  Normal  Pulling                49s   kubelet, 192.168.1.140  pulling image "busybox"
  Normal  Pulled                 41s   kubelet, 192.168.1.140  Successfully pulled image "busybox"
  Normal  Created                41s   kubelet, 192.168.1.140  Created container
  Normal  Started                41s   kubelet, 192.168.1.140  Started container
```

我们可以看到 Events 下面的信息，上面的 POD 被正确的调度到了140节点。通过上面的例子我们可以感受到`nodeSelector`的方式比较直观，但是还够灵活，控制粒度偏大





## node affinity

节点亲和性（node affinity）的概念与 `nodeSelector` 相似，可以基于节点的标签来限定 Pod 可以被调度到哪些节点上。

当前支持两种类型的节点亲和性， `requiredDuringSchedulingIgnoredDuringExecution` （hard，目标节点必须满足此条件） 以及 `preferredDuringSchedulingIgnoredDuringExecution` （soft，目标节点最好能满足此条件）。名字中 `IgnoredDuringExecution` 意味着：如果 Pod 已经调度到节点上以后，节点的标签发生改变，使得节点已经不再匹配该亲和性规则了，Pod 仍将继续在节点上执行（这一点与 `nodeSelector` 相似）。将来，Kubernetes 将会提供 `requiredDuringSchedulingRequiredDuringExecution` 这个选项，该选项与 `requiredDuringSchedulingIgnoredDuringExecution` 相似，不同的是，当节点的标签不在匹配亲和性规则之后，Pod 将被从节点上驱逐。

`requiredDuringSchedulingIgnoredDuringExecution` 的一个例子是，`只在 Intel CPU 上运行该 Pod`，`preferredDuringSchedulingIgnoredDuringExecution` 的一个例子是，`尽量在高可用区 XYZ 中运行这个 Pod，但是如果做不到，也可以在其他地方运行该 Pod`。

PodSpec 中通过 `affinity.nodeAffinity` 字段来定义节点亲和性，示例文件如下：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: with-node-affinity
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: kubernetes.io/e2e-az-name
            operator: In
            values:
            - e2e-az1
            - e2e-az2
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
          - key: another-node-label-key
            operator: In
            values:
            - another-node-label-value
  containers:
  - name: with-node-affinity
    image: k8s.gcr.io/pause:2.0
```



此处的亲和性规则表明，该 Pod 只能被调度到包含 key 为 `kubernetes.io/e2e-az-name` 且 value 为 `e2e-az1` 或 `e2e-az2` 的标签的节点上。此外，如果节点已经满足了前述条件，将优先选择包含 key 为 `another-node-label-key` 且 value 为 `another-node-label-value` 的标签的节点。

例子中使用了操作符 `In`。节点亲和性支持如下操作符：`In`、`NotIn`、`Exists`、`DoesNotExist`、`Gt`、`Lt`。使用 `NotIn` 和 `DoesNotExist` 可以实现节点反亲和性（node anti-affinity）的效果，或者也可以使用 [污点](https://kuboard.cn/learning/k8s-intermediate/config/taints-toleration/) 为节点排斥某类 Pod。

- In：label 的值在某个列表中
- NotIn：label 的值不在某个列表中
- Gt：label 的值大于某个值
- Lt：label 的值小于某个值
- Exists：某个 label 存在
- DoesNotExist：某个 label 不存在

如果某个 Pod 同时指定了 `nodeSelector` 和 `nodeAffinity`，则目标节点必须同时满足两个条件，才能将 Pod 调度到该节点上。

如果为 `nodeAffinity` 指定多个 `nodeSelectorTerms`，则目标节点只需要满足任意一个 `nodeSelectorTerms` 的要求，就可以将 Pod 调度到该节点上。

如果为 `nodeSelectorTerms` 指定多个 `matchExpressions`，则目标节点必须满足所有的 `matchExpressions` 的要求，才能将 Pod 调度到该节点上。

当 Pod 被调度到某节点上之后，如果移除或者修改节点的标签，Pod 将仍然继续在节点上运行。换句话说，节点亲和性规则只在调度该 Pod 时发生作用。

`preferredDuringSchedulingIgnoredDuringExecution` 中的 `weight` 字段取值范围为 1-100。对于每一个满足调度要求的节点（资源请求、亲和性/反亲和性规则，等），调度器将遍历该节点匹配的 `preferredDuringSchedulingIgnoredDuringExecution` 中所有的`weight` 并求和。此求和结果将与节点的其他优先级计算的得分合并。得分最高的节点被优先选择。



## Pod亲和性与反亲和性

Pod之间的亲和性与反亲和性（inter-pod affinity and anti-affinity）可以基于已经运行在节点上的 Pod 的标签（而不是节点的标签）来限定 Pod 可以被调度到哪个节点上。此类规则的表现形式是：

- 当 X 已经运行了一个或者多个满足规则 Y 的 Pod 时，待调度的 Pod 应该（或者不应该 - 反亲和性）在 X 上运行

  - 规则 Y 以 LabelSelector 的形式表述，附带一个可选的名称空间列表

    > 与节点不一样，Pod 是在名称空间中的（因此，Pod的标签是在名称空间中的），针对 Pod 的 LabelSelector 必须同时指定对应的名称空间

  - X 是一个拓扑域的概念，例如节点、机柜、云供应商可用区、云供应商地域，等。X 以 `topologyKey` 的形式表达，该 Key代表了节点上代表拓扑域（topology domain）的一个标签。

### pod affinity 的一个例子

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: with-pod-affinity
spec:
  affinity:
    podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchExpressions:
          - key: security
            operator: In
            values:
            - S1
        topologyKey: failure-domain.beta.kubernetes.io/zone
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchExpressions:
            - key: security
              operator: In
              values:
              - S2
          topologyKey: failure-domain.beta.kubernetes.io/zone
  containers:
  - name: with-pod-affinity
    image: k8s.gcr.io/pause:2.0
    
```

该 Pod 的 `affinity` 定义了一个 Pod 亲和性规则和一个 Pod 反亲和性规则，例子中， `podAffinity` 是 `requiredDuringSchedulingIgnoredDuringExecution`，而 `podAntiAffinity` 则是 `preferredDuringSchedulingIgnoredDuringExecution`。

- Pod 亲和性规则要求，该 Pod 可以被调度到的节点所在的可用区 `zone` 必须已经有一个已经运行的 Pod 包含标签 key=security，value=S1，或者更准确地说，节点必须满足如下条件：
  - 节点包含 key 为 `failure-domain.beta.kubernetes.io/zone` 的标签，假设该标签的值为 `V`
  - 至少有一个包含 key 为 `failure-domain.beta.kubernetes.io/zone` 且 value 为 `V` 的标签的节点已经运行了一个包含标签 key 为 `security` 且 value 为 `S1` 的 Pod
- Pod 反亲和性规则要求，该 Pod 最好不要被调度到已经运行了包含 key 为 `security` 且 value 为 `S2` 的标签的 Pod 的节点上，或者更准确地说，必须满足如下条件：
  - 如果 `topologyKey` 是 `failure-domain.beta.kubernetes.io/zone`，则，Pod不能被调度到同一个 zone 中的已经运行了包含标签 `security: S2` 的节点上

参考 [design doc (opens new window)](https://github.com/kubernetes/community/blob/master/contributors/design-proposals/scheduling/podaffinity.md)可以了解更多 Pod 亲和性与反亲和性的例子。

原则上， `topologyKey` 可以是任何合法的标签 key。然而，处于性能和安全的考虑，仍然对 `topologyKey` 有如下限制：

1. 对亲和性以及 `requiredDuringSchedulingIgnoredDuringExecution` Pod 反亲和性，`topologyKey` 不能为空
2. 对 `requiredDuringSchedulingIgnoredDuringExecution` Pod 反亲和性，管理控制器 `LimitPodHardAntiAffinityTopology` 被用来限制 `topologyKey` 必须为 `kubernetes.io/hostname`。如果想要使用其他的自定义 topology，必须修改该管理控制器，或者将其禁用
3. 对 `preferredDuringSchedulingIgnoredDuringExecution` Pod 反亲和性，如果 `topologyKey` 为空，则代表所有的 topology （此时，不局限于 `kubernetes.io/hostname`、`failure-domain.beta.kubernetes.io/zone` 和 `failure-domain.beta.kubernetes.io/region` 的组合）
4. 除了上述的情形以外，`topologyKey` 可以是任何合法的标签 Key

除了 `labelSelector` 和 `topologyKey` 以外，还可以指定一个 `namespaces` 的列表，用作 `labelSelector` 的作用范围（与 `labelSelector` 和 `topologyKey` 的定义为同一个级别）。如果不定义或者该字段为空，默认为 Pod 所在的名称空间。

所有与 `requiredDuringSchedulingIgnoredDuringExecution` 亲和性和反亲和性关联的 `matchExpressions` 必须被满足，Pod 才能被调度到目标节点。



## 什么是topologyKey

顾名思义，`topology` 就是 `拓扑` 的意思，这里指的是一个 `拓扑域`，是指一个范围的概念，比如一个 Node、一个机柜、一个机房或者是一个地区（如杭州、上海）等，实际上对应的还是 Node 上的标签。这里的 `topologyKey` 对应的是 Node 上的标签的 Key（没有Value），可以看出，其实 `topologyKey` 就是用于筛选 Node 的。通过这种方式，我们就可以将各个 Pod 进行跨集群、跨机房、跨地区的调度了。

### 如何使用topologyKey

看下面的例子：

```
apiVersion: v1
kind: Pod
metadata:
  name: with-pod-affinity
spec:
  affinity:
    podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchExpressions:
          - key: security
            operator: In
            values:
            - S1
        topologyKey: failure-domain.beta.kubernetes.io/zone
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchExpressions:
            - key: security
              operator: In
              values:
              - S2
          topologyKey: kubernetes.io/hostname
  containers:
  - name: with-pod-affinity
    image: k8s.gcr.io/pause:2.0
```

这里 Pod 的亲和性规则是：这个 Pod 要调度到的 Node 必须有一个标签为 `security: S1` 的 Pod，且该 Node 必须有一个 Key 为 `failure-domain.beta.kubernetes.io/zone` 的 标签，即 Node 必须属于 `failure-domain.beta.kubernetes.io/zone` 拓扑域。

Pod 的反亲和性规则是：这个 Pod 尽量不要调度到这样的 Node，其包含一个 Key 为 `kubernetes.io/hostname` 的标签，且该 Node 上有标签为 `security: S2` 的 Pod。

### topologyKey详解

既然 `topologyKey` 是拓扑域，那 Pod 之间怎样才是属于同一个拓扑域？

如果使用 `k8s.io/hostname`，则表示拓扑域为 Node 范围，那么 `k8s.io/hostname` 对应的值不一样就是不同的拓扑域。比如 Pod1 在 `k8s.io/hostname=node1` 的 Node 上，Pod2 在 `k8s.io/hostname=node2` 的 Node 上，Pod3 在 `k8s.io/hostname=node1` 的 Node 上，则 Pod2 和 Pod1、Pod3 不在同一个拓扑域，而Pod1 和 Pod3在同一个拓扑域。

如果使用 `failure-domain.k8s.io/zone` ，则表示拓扑域为一个区域。同样，Node 的标签 `failure-domain.k8s.io/zone` 对应的值不一样也不是同一个拓扑域，比如 Pod1 在 `failure-domain.k8s.io/zone=beijing` 的 Node 上，Pod2 在 `failure-domain.k8s.io/zone=hangzhou` 的 Node 上，则 Pod1 和 Pod2 不属于同一个拓扑域。

当然，topologyKey 也可以使用自定义标签。比如可以给一组 Node 打上标签 `custom_topology`，那么拓扑域就是针对这个标签了，则该标签相同的 Node 上的 Pod 属于同一个拓扑域。

### 注意事项

原则上，topologyKey 可以是任何合法的标签 Key。但是出于性能和安全原因，对 topologyKey 有一些限制：

1. 对于亲和性和 `requiredDuringSchedulingIgnoredDuringExecution` 的 Pod 反亲和性，topologyKey 不能为空。
2. 对于 `requiredDuringSchedulingIgnoredDuringExecution` 的 Pod 反亲和性，引入 `LimitPodHardAntiAffinityTopology` 准入控制器来限制 topologyKey 只能是 `kubernetes.io/hostname`。如果要使用自定义拓扑域，则可以修改准入控制器，或者直接禁用它。
3. 对于 `preferredDuringSchedulingIgnoredDuringExecution` 的 Pod 反亲和性，空的 topologyKey 表示所有拓扑域。截止 `v1.12` 版本，所有拓扑域还只能是 `kubernetes.io/hostname`、`failure-domain.beta.kubernetes.io/zone` 和 `failure-domain.beta.kubernetes.io/region` 的组合。
4. 除上述情况外，topologyKey 可以是任何合法的标签 key。



## 更多实用的例子

Pod 亲和性与反亲和性结合高级别控制器（例如 ReplicaSet、StatefulSet、Deployment 等）一起使用时，可以非常实用。此时可以很容易的将一组工作复杂调度到同一个 topology，例如，同一个节点。

### 始终在同一个节点始终在同一个节点

在一个三节点的集群中，部署一个使用 redis 的 web 应用程序，并期望 web-server 尽可能与 redis 在同一个节点上。

下面是 redis deployment 的 yaml 片段，包含三个副本以及 `app=store` 标签选择器。Deployment 中配置了 `PodAntiAffinity`，确保调度器不会将三个副本调度到一个节点上：

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-cache
spec:
  selector:
    matchLabels:
      app: store
  replicas: 3
  template:
    metadata:
      labels:
        app: store
    spec:
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - store
            topologyKey: "kubernetes.io/hostname"
      containers:
      - name: redis-server
        image: redis:3.2-alpine
```

下面是 webserver deployment 的 yaml 片段，配置了 `podAntiAffinity` 以及 `podAffinity`。要求将其副本与 包含 `app=store` 标签的 Pod 放在同一个节点上；同时也要求 web-server 的副本不被调度到同一个节点上。

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-server
spec:
  selector:
    matchLabels:
      app: web-store
  replicas: 3
  template:
    metadata:
      labels:
        app: web-store
    spec:
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - web-store
            topologyKey: "kubernetes.io/hostname"
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - store
            topologyKey: "kubernetes.io/hostname"
      containers:
      - name: web-app
        image: nginx:1.12-alpine
```

如果创建上述两个 deployment，集群将如下所示：

| Node-1       | Node-2      | Node-3      |
| ------------ | ----------- | ----------- |
| web-server-1 | webserver-2 | webserver-3 |
| cache-1      | cache-2     | cache-3     |

`web-server` 的三个副本都自动与 cach 的副本运行在相同的节点上。

```sh
kubectl get pods -o wide
```

输出结果如下所示

```text
NAME                           READY     STATUS    RESTARTS   AGE       IP           NODE
redis-cache-1450370735-6dzlj   1/1       Running   0          8m        10.192.4.2   kube-node-3
redis-cache-1450370735-j2j96   1/1       Running   0          8m        10.192.2.2   kube-node-1
redis-cache-1450370735-z73mh   1/1       Running   0          8m        10.192.3.1   kube-node-2
web-server-1287567482-5d4dz    1/1       Running   0          7m        10.192.2.3   kube-node-1
web-server-1287567482-6f7v5    1/1       Running   0          7m        10.192.4.3   kube-node-3
web-server-1287567482-s330j    1/1       Running   0          7m        10.192.3.2   kube-node-2
```



### 始终不在相同的节点上

上面的例子使用了 `PodAntiAffinity` 规则与 `topologyKey: "kubernetes.io/hostname"` 来部署 redis 集群，因此没有任何两个副本被调度到同一个节点上。参考 [ZooKeeper tutorial (opens new window)](https://kubernetes.io/docs/tutorials/stateful-application/zookeeper/#tolerating-node-failure)了解如何使用相同的方式为 StatefulSet 配置反亲和性以实现高可用。





http://bazingafeng.com/2019/03/31/k8s-affinity-topologykey/

https://kuboard.cn/learning/k8s-intermediate/config/affinity.html
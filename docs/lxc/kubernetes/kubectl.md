kubectl 命令



```
[root@maas1-zwlt bf3_init]# kubectl --help
kubectl 控制 Kubernetes 集群管理器。

  更多信息请参见：https://kubernetes.io/zh/docs/reference/kubectl/overview/

基本命令（初学者）:
  create          从文件或标准输入创建资源
  expose          将副本控制器、服务、部署或 Pod 暴露为一个新的 Kubernetes 服务
  run             在集群中运行一个特定的镜像
  set             在对象上设置特定的功能

基本命令（中级）:
  explain         获取资源的文档说明
  get             显示一个或多个资源
  edit            在服务器上编辑一个资源
  delete          通过文件名、标准输入、资源名称或标签选择器删除资源

部署命令:
  rollout         管理资源的发布
  scale           为部署、ReplicaSet 或副本控制器设置新副本数
  autoscale       为部署、ReplicaSet、StatefulSet 或副本控制器自动扩缩容

集群管理命令:
  certificate     修改证书资源
  cluster-info    显示集群信息
  top             显示资源（CPU/内存）使用情况
  cordon          标记节点为不可调度
  uncordon        标记节点为可调度
  drain           为维护准备节点（驱逐其上的 Pod）
  taint           更新一个或多个节点上的污点

故障排查与调试命令:
  describe        显示特定资源或资源组的详细信息
  logs            打印 Pod 中容器的日志
  attach          附加到正在运行的容器
  exec            在容器中执行命令
  port-forward    将一个或多个本地端口转发到 Pod
  proxy           运行到 Kubernetes API 服务器的代理
  cp              在容器与本地之间复制文件和目录
  auth            检查授权情况
  debug           为工作负载和节点创建调试会话

高级命令:
  diff            对比实际版本与将要应用的版本之间的差异
  apply           通过文件名或标准输入应用配置到资源
  patch           更新资源的字段
  replace         通过文件名或标准输入替换资源
  wait            实验性：等待一个或多个资源达到特定条件
  kustomize       从目录或 URL 构建一个 Kustomization 目标

设置命令:
  label           更新资源上的标签
  annotate        更新资源上的注解
  completion      为指定的 shell（bash、zsh 或 fish）输出命令补全代码

其他命令:
  alpha           Alpha 阶段功能的命令
  api-resources   打印服务器支持的 API 资源
  api-versions    打印服务器支持的 API 版本，格式为 "group/version"
  config          修改 kubeconfig 文件
  plugin          提供与插件交互的实用工具
  version         打印客户端和服务器的版本信息

用法:
  kubectl [flags] [options]

使用 "kubectl <command> --help" 获取某个命令的详细信息。
使用 "kubectl options" 查看适用于所有命令的全局命令行选项。
```



`kubectl` 是 Kubernetes 的命令行工具，用于与集群交互。下面是一些最常用的 `kubectl` 命令，分为几类，适合日常运维、开发调试和集群管理。



------

### 🟢 基础操作命令

| 命令                                       | 说明                                 |
| ------------------------------------------ | ------------------------------------ |
| `kubectl get pods`                         | 查看所有 Pod                         |
| `kubectl get svc`                          | 查看所有 Service                     |
| `kubectl get nodes`                        | 查看所有 Node                        |
| `kubectl get deployments`                  | 查看所有 Deployment                  |
| `kubectl get all`                          | 查看所有资源                         |
| `kubectl describe pod <pod-name>`          | 查看 Pod 详情                        |
| `kubectl logs <pod-name>`                  | 查看 Pod 日志                        |
| `kubectl exec -it <pod-name> -- /bin/bash` | 进入 Pod 容器内部（需要容器有 bash） |

------

### 🟡 资源管理

| 命令                                           | 说明                         |
| ---------------------------------------------- | ---------------------------- |
| `kubectl apply -f <file>.yaml`                 | 应用配置文件，创建或更新资源 |
| `kubectl create -f <file>.yaml`                | 创建资源                     |
| `kubectl delete -f <file>.yaml`                | 删除资源                     |
| `kubectl delete pod <pod-name>`                | 删除某个 Pod                 |
| `kubectl scale deployment <name> --replicas=3` | 扩缩容 Deployment            |

------

### 🔵 命名空间相关

| 命令                                                         | 说明                  |
| ------------------------------------------------------------ | --------------------- |
| `kubectl get ns`                                             | 查看所有命名空间      |
| `kubectl get pods -n <namespace>`                            | 查看某命名空间的 Pods |
| `kubectl config set-context --current --namespace=<namespace>` | 设置默认命名空间      |

------

### 🟣 调试与排错

| 命令                                          | 说明                                           |
| --------------------------------------------- | ---------------------------------------------- |
| `kubectl describe node <node-name>`           | 查看节点详细信息                               |
| `kubectl top pod`                             | 查看 Pod 资源使用情况（需安装 metrics-server） |
| `kubectl get events`                          | 查看事件，排查错误                             |
| `kubectl port-forward pod/<pod-name> 8080:80` | 本地端口转发到 Pod                             |

------

### ⚙️ 配置相关

| 命令                                        | 说明           |
| ------------------------------------------- | -------------- |
| `kubectl config get-contexts`               | 查看所有上下文 |
| `kubectl config use-context <context-name>` | 切换上下文     |
| `kubectl version`                           | 查看版本信息   |
| `kubectl cluster-info`                      | 查看集群信息   |


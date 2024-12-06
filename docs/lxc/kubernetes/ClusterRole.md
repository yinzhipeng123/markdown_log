

### Role 与 ClusterRole

`Role` 对象就是一个角色包含了一套表示一组权限的规则。但是只对一个`namespace`生效，书写规则的时候必须写上针对哪个`namespace`

`ClusterRole` 对象也是一个角色包含了一套表示一组权限的规则，但是对整个 Kubernetes 集群范围内有效。

### RoleBinding 与 ClusterRoleBinding

`RoleBinding ` 就是将一个`Role`绑定给某个用户，也可以绑定`ClusterRole` ，但是只能对一个`namespace`生效，因为`RoleBinding ` 需要指定`namespace`

`ClusterRoleBinding` 就是将一个`ClusterRole` 绑定给某个用户

### Service Account 

ServiceAccount 为 Pod 中的进程提供身份信息。

当您（真人用户）访问集群（例如使用`kubectl`命令）时，apiserver 会将您认证为一个特定的 User Account（目前通常是`admin`，除非您的系统管理员自定义了集群配置）。Pod 容器中的进程也可以与 apiserver 联系。 当它们在联系 apiserver 的时候，它们会被认证为一个特定的 Service Account（例如`default`）。

当您创建 pod 的时候，如果您没有指定一个 service account，系统会自动得在与该pod 相同的 namespace 下为其指派一个`default` service account。如果您获取刚创建的 pod 的原始 json 或 yaml 信息（例如使用`kubectl get pods/podename -o yaml`命令），您将看到`spec.serviceAccountName`字段已经被设置为 `default`。



详解：

https://jimmysong.io/kubernetes-handbook/concepts/serviceaccount.html

https://jimmysong.io/kubernetes-handbook/concepts/rbac.html



`kube-state-metrics-clusterRole.yaml`

```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app.kubernetes.io/name: kube-state-metrics
    app.kubernetes.io/version: v1.9.5
  name: kube-state-metrics
rules:
- apiGroups:
  - ""
  resources:
  - configmaps
  - secrets
  - nodes
  - pods
  - services
  - resourcequotas
  - replicationcontrollers
  - limitranges
  - persistentvolumeclaims
  - persistentvolumes
  - namespaces
  - endpoints
  verbs:
  - list
  - watch
- apiGroups:
  - extensions
  resources:
  - daemonsets
  - deployments
  - replicasets
  - ingresses
  verbs:
  - list
  - watch
- apiGroups:
  - apps
  resources:
  - statefulsets
  - daemonsets
  - deployments
  - replicasets
  verbs:
  - list
  - watch
- apiGroups:
  - batch
  resources:
  - cronjobs
  - jobs
  verbs:
  - list
  - watch
- apiGroups:
  - autoscaling
  resources:
  - horizontalpodautoscalers
  verbs:
  - list
  - watch
- apiGroups:
  - authentication.k8s.io
  resources:
  - tokenreviews
  verbs:
  - create
- apiGroups:
  - authorization.k8s.io
  resources:
  - subjectaccessreviews
  verbs:
  - create
- apiGroups:
  - policy
  resources:
  - poddisruptionbudgets
  verbs:
  - list
  - watch
- apiGroups:
  - certificates.k8s.io
  resources:
  - certificatesigningrequests
  verbs:
  - list
  - watch
- apiGroups:
  - storage.k8s.io
  resources:
  - storageclasses
  - volumeattachments
  verbs:
  - list
  - watch
- apiGroups:
  - admissionregistration.k8s.io
  resources:
  - mutatingwebhookconfigurations
  - validatingwebhookconfigurations
  verbs:
  - list
  - watch
- apiGroups:
  - networking.k8s.io
  resources:
  - networkpolicies
  verbs:
  - list
  - watch
```

`kube-state-metrics-clusterRoleBinding.yaml`

```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    app.kubernetes.io/name: kube-state-metrics
    app.kubernetes.io/version: v1.9.5
  name: kube-state-metrics
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: kube-state-metrics
subjects:
- kind: ServiceAccount
  name: kube-state-metrics
  namespace: monitoring

```

`kube-state-metrics-serviceAccount.yaml`

```
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app.kubernetes.io/name: kube-state-metrics
    app.kubernetes.io/version: v1.9.5
  name: kube-state-metrics
  namespace: monitoring
```









```bash
kubectl create clusterrole deployment-clusterrole --verb=create --resource=deployments,statefulsets,daemonsets 
```



这个命令用于在 Kubernetes 中创建一个名为 `deployment-clusterrole` 的 **ClusterRole**，它定义了对 `deployments`、`statefulsets` 和 `daemonsets` 资源的访问权限。具体来说，这个命令表示：

- [ ] **kubectl create clusterrole**：使用 `kubectl` 工具创建一个 **ClusterRole**。
- [ ] **deployment-clusterrole**：创建的 ClusterRole 名称是 `deployment-clusterrole`。
- [ ] **--verb=create**：指定对这些资源的操作是 **create**，意味着该角色有权限创建这些资源。
- [ ] **--resource=deployments,statefulsets,daemonsets**：指定该角色适用于以下三种资源：`deployments`（部署）、`statefulsets`（有状态副本集）和 `daemonsets`（守护进程集）。

这个命令创建了一个角色，允许持有该角色的用户或服务帐户执行创建操作（create）对 **deployments**、**statefulsets** 和 **daemonsets** 这些资源。



```bash
kubectl -n app-team1 create serviceaccount cicd-token
```

这个命令用于在 Kubernetes 中创建一个名为 `cicd-token` 的 **ServiceAccount**，并且在 **app-team1** 命名空间下。具体来说，命令的各部分含义如下：

### 解释：

- [ ] **kubectl**：Kubernetes 命令行工具，用于与 Kubernetes 集群交互。
- [ ] **-n app-team1**：指定命名空间为 `app-team1`，意味着该命令将在 `app-team1` 命名空间中创建资源。
- [ ] **create serviceaccount**：创建一个 **ServiceAccount**，这是 Kubernetes 中的一个对象，通常用于在集群内运行应用程序时，赋予应用程序访问 Kubernetes API 的权限。
- [ ] **cicd-token**：是 ServiceAccount 的名称，这个账户可能会被用来为 CI/CD（持续集成/持续部署）管道提供访问权限。

### **ServiceAccount 的作用：**

- [ ] **ServiceAccount** 是 Kubernetes 中的一种特殊账户，它通常用于授权某个进程（如 Pod 中运行的应用）访问 Kubernetes API。
- [ ] 它允许 Kubernetes 集群内的服务或应用通过 API 与集群交互，而不需要使用传统的用户凭证（如用户名和密码）。
- [ ] Kubernetes 会为每个 **ServiceAccount** 自动创建一个令牌（token），这个令牌可以用来进行身份验证，确保该服务的安全访问。



总结

- [ ] 这个命令在 `app-team1` 命名空间中创建了一个名为 `cicd-token` 的 ServiceAccount，可能是用于 CI/CD 流程中的某些自动化任务。
- [ ] 通过创建这个 ServiceAccount，集群中的应用程序（如 CI/CD 工具）可以通过 Kubernetes 的 API 与集群进行交互（比如部署应用、更新资源等）。



```bash
kubectl -n app-team1 create rolebinding cicd-token-rolebinding --clusterrole=deployment-clusterrole --serviceaccount=app-team1:cicd-token 
```



这个命令用于在 **app-team1** 命名空间中创建一个 **RoleBinding**，并将名为 `cicd-token` 的 **ServiceAccount** 与一个名为 `deployment-clusterrole` 的 **ClusterRole** 绑定。命令的各部分含义如下：

### 解释：

- [ ] **kubectl**：Kubernetes 命令行工具，用于与 Kubernetes 集群交互。
- [ ] **-n app-team1**：指定命名空间为 `app-team1`，意味着该命令将在 `app-team1` 命名空间中创建资源。
- [ ] **create rolebinding**：创建一个 **RoleBinding**，它将一个角色（如 `ClusterRole` 或 `Role`）与某个用户、组或服务帐户关联起来，从而授予其相应的权限。
- [ ] **cicd-token-rolebinding**：这是创建的 **RoleBinding** 的名称。
- [ ] **--clusterrole=deployment-clusterrole**：将名为 `deployment-clusterrole` 的 **ClusterRole** 赋予该 **RoleBinding**，也就是说，持有此角色的账户将获得对指定资源的访问权限。`deployment-clusterrole` 是一个集群范围的角色，可能允许执行对 `deployments`、`statefulsets` 和 `daemonsets` 等资源的创建、修改或删除操作。
- [ ] **--serviceaccount=app-team1:cicd-token**：将 **ServiceAccount** `cicd-token`（在 `app-team1` 命名空间中）与此角色绑定，这意味着该服务帐户将获得 `deployment-clusterrole` 角色所定义的权限。

### 

这个命令的作用是在 `app-team1` 命名空间内创建一个 **RoleBinding**，将 **ServiceAccount** `cicd-token` 与一个集群级别的 **ClusterRole**（`deployment-clusterrole`）绑定。这样，`cicd-token` 服务帐户将拥有由 `deployment-clusterrole` 定义的权限（如创建、管理 `deployments`、`statefulsets` 和 `daemonsets` 等资源），通常用于 CI/CD 管道自动化任务，以便自动执行部署等操作。
# Secret

在 Kubernetes 中，可以通过以下几种方式创建 Secret：

------

### 1. **使用命令行创建（推荐简单场景）**

#### 创建基于字符串的 Secret

使用 `kubectl create secret` 命令：

```bash
kubectl create secret generic my-secret --from-literal=username=my-user --from-literal=password=my-password
```

#### 创建基于文件的 Secret

如果你有文件，比如 `username.txt` 和 `password.txt`，每个文件中包含 Secret 的值：

```bash
kubectl create secret generic my-secret --from-file=username=./username.txt --from-file=password=./password.txt
```

#### 验证创建的 Secret

```bash
kubectl get secrets
kubectl describe secret my-secret
```

------

### 2. **使用 YAML 文件创建**

如果需要更复杂的配置，可以通过编写 YAML 文件来创建 Secret。

#### 示例：

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
type: Opaque
data:
  username: bXktdXNlcg==  # Base64编码后的值 "my-user"
  password: bXktcGFzc3dvcmQ=  # Base64编码后的值 "my-password"
```

#### 创建 Secret：

```bash
kubectl apply -f my-secret.yaml
```

#### 验证创建：

```bash
kubectl get secrets my-secret -o yaml
```

------

### 3. **动态生成 Base64 编码的 Secret 值**

YAML 文件中的 `data` 字段需要 Base64 编码后的值。如果你手动创建 Secret，可以用以下方法生成编码值：

```bash
echo -n "my-user" | base64  # 结果：bXktdXNlcg==
echo -n "my-password" | base64  # 结果：bXktcGFzc3dvcmQ=
```

把生成的值填入 YAML 文件的 `data` 字段中。

------

### 4. **通过 Kubernetes Dashboard 创建**

如果你使用的是 Kubernetes Dashboard，可以通过 Web 界面创建 Secret：

1. 登录 Dashboard。
2. 导航到 **Config and Storage > Secrets**。
3. 点击 **Create** 按钮，填写名称和键值对内容。
4. 点击 **Deploy** 完成创建。

------

### Secret 类型说明

创建时可以指定 `type`，常见类型包括：

- **Opaque（默认类型）：** 通用类型，通常用于存储任意键值对。
- **kubernetes.io/dockerconfigjson：** 用于存储 Docker 的镜像拉取凭据。
- **kubernetes.io/tls：** 用于存储 TLS 证书。

例如，创建 Docker 镜像拉取凭据：

```bash
kubectl create secret docker-registry my-registry-secret \
  --docker-username=my-user \
  --docker-password=my-password \
  --docker-server=my-registry.example.com
```

------

### 注意事项

- **大小限制：** 单个 Secret 的数据总大小不能超过 1MB。
- **安全性：** Secret 数据存储在 etcd 中，请确保 etcd 加密已启用，避免泄漏。



在 Kubernetes 中创建了一个 Secret 后，你可以通过以下两种主要方式在 Pod 中使用它：

------

### 1. **作为环境变量注入到 Pod 中**

**步骤：**

1. 假设你已经创建了一个 Secret，名字为 `my-secret`，其中包含一个键值对 `username=my-user`。
2. 在 Pod 的 YAML 配置中，通过 `env` 配置引用 Secret。

**示例：**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-env-example
spec:
  containers:
  - name: my-container
    image: nginx
    env:
    - name: SECRET_USERNAME
      valueFrom:
        secretKeyRef:
          name: my-secret    # Secret 名称
          key: username      # Secret 的键
```

**结果：** 容器内可以通过环境变量 `SECRET_USERNAME` 访问 Secret 值。

------

### 2. **将 Secret 挂载为文件卷**

**步骤：**

1. 假设你已经创建了一个 Secret，名字为 `my-secret`，其中包含两个键值对：`username=my-user` 和 `password=my-password`。
2. 在 Pod 的 YAML 配置中，通过 `volumes` 和 `volumeMounts` 将 Secret 挂载为一个文件系统。

**示例：**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-volume-example
spec:
  containers:
  - name: my-container
    image: nginx
    volumeMounts:
    - name: secret-volume
      mountPath: "/etc/secret-volume"   # 挂载路径
      readOnly: true
  volumes:
  - name: secret-volume
    secret:
      secretName: my-secret             # Secret 名称
```

**结果：**

- Secret 中的每个键会被映射为一个文件，文件名是键名，文件内容是值。
- 在容器中，`/etc/secret-volume/username` 和 `/etc/secret-volume/password` 文件中分别包含 `my-user` 和 `my-password`。

------

### 选择方式的建议：

- **环境变量：** 适合小型的简单配置（如用户名、单个密码）。
- **文件挂载：** 适合需要管理多个 Secret 或需要文件格式的场景。

如果需要更复杂的动态注入场景，可以结合 Kubernetes Secret 的 `CSI 驱动` 或 `Secrets Manager` 服务。
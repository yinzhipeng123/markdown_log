## 1️⃣ `volumes`：卷

**概念**：

- `volumes` 是 Kubernetes Pod 级别的存储抽象。
- 它定义了 Pod 内容器可以使用的存储源。
- 可以是：
  - **ConfigMap**：挂载配置文件
  - **Secret**：挂载敏感信息
  - **emptyDir**：临时目录（Pod 删除就消失）
  - **hostPath**：挂载宿主机目录
  - **PersistentVolumeClaim (PVC)**：持久化卷

**特点**：

- Pod 里的所有容器都可以共享同一个卷。
- 只定义存储位置，不决定容器里挂到哪个路径，这个由 `volumeMounts` 决定。

**例子**：

```
volumes:
  - name: renzheng-proxy
    configMap:
      name: renzheng-proxy-conf
```

解释：

- 定义了一个名字叫 `renzheng-proxy` 的卷。
- 数据来源是一个 ConfigMap `renzheng-proxy-conf`。
- 这个卷里会包含 ConfigMap 里的文件。

------

## 2️⃣ `volumeMounts`：卷挂载

**概念**：

- `volumeMounts` 是容器级别的配置。
- 它指定某个卷挂载到容器内的哪个路径。
- 可以挂载整个卷，也可以挂载卷里某个文件（`subPath`）。

**例子**：

```
volumeMounts:
  - mountPath: /home/renzheng/proxy/conf/gflags.conf
    name: renzheng-proxy
    subPath: gflags.conf
```

解释：

- `name: renzheng-proxy` → 指定挂载的卷（必须在 Pod 的 `volumes` 里定义）。
- `mountPath: /home/renzheng/proxy/conf/gflags.conf` → 容器里挂载的路径。
- `subPath: gflags.conf` → 只挂载卷里的这个文件，而不是整个卷。

**注意**：

- 如果 `volumes` 里没有定义 `renzheng-proxy`，这个挂载就会失败。
- 如果 `subPath` 指定的文件不存在，也会失败。

------

## 3️⃣ 总结

| 名称           | 定义位置 | 意义                                         |
| -------------- | -------- | -------------------------------------------- |
| `volumes`      | Pod 级别 | 定义存储来源，Pod 中容器可以共享             |
| `volumeMounts` | 容器级别 | 挂载卷到容器内路径，决定容器看到的目录或文件 |

------

### 🔹 对你 Pod 的情况

- 你的 `renzheng-proxy` 容器挂载了 `volumeMounts` 指向 `/home/renzheng/proxy/conf/` 下的文件。
- 但是 Pod 的 `volumes` 里 **没有对应的 `renzheng-proxy` 卷**。
- 因此容器启动时找不到文件，目录也是空的 → 启动失败。
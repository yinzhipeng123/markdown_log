

```
[root@ yinzhipeng]# kubectl get pod 
NAME                               READY   STATUS    RESTARTS      AGE
aaa-bbbbbbbbb-basenetwork-0        1/1     Running   1 (22d ago)   25d
aaa-bbbbbbbbb-basenetwork-1        1/1     Running   0             12d
aaa-bbbbbbbbb-basenetwork-2        1/1     Running   0             12d
frontend-0                         2/2     Running   0             2m
frontend-1                         2/2     Running   0             2m
frontend-2                         2/2     Running   0             2m
```



`READY` 这一列表示 **Pod 中实际处于“就绪(Ready)”状态的容器数量 / Pod 中容器总数量**。

举例说明：

- `1/1`：Pod 里有 1 个容器，且它已经就绪，可以正常提供服务。
- `2/2`：Pod 里有 2 个容器，而且 2 个都就绪。
- `0/1`：Pod 里有 1 个容器，但它还没准备好（可能正在启动、探针未通过等）。

### 你列表中的含义

| Pod                            | READY | 含义                                               |
| ------------------------------ | ----- | -------------------------------------------------- |
| `aaa-bbbbbbbbb-basenetwork-0 ` | `1/1` | 有 1 个容器，且已就绪                              |
| `frontend-0`                   | `2/2` | 这个 Pod 有 2 个容器，如主容器 + sidecar，都已就绪 |

READY 状态结合 `STATUS` 能更好判断 Pod 是否健康：

- `Running` 但 `0/1`：说明在运行，但还没准备好对外服务（通常 Readiness Probe 没通过）。
- `Running` 且 `1/1`：完全正常。



# 🟦 `kubectl get pod` 各列含义

你的表格类似下面这样：

```
NAME     READY   STATUS   RESTARTS   AGE
```

下面逐列说明：

------

## 🔵 **1. NAME**

Pod 的名字，每个 Pod 都有唯一名称。
 如果是有状态副本集（StatefulSet），会带编号，例如：

- `aaa-bbbbbbbbb-basenetwork-0 `
- `frontend-2`

这是 StatefulSet 自动生成的顺序编号。

------

## 🔵 **2. READY**

格式：**就绪容器数 / Pod 的总容器数**

例如：

- `1/1` → Pod 中有 1 个容器且已就绪
- `2/2` → Pod 有两个容器（常见：主容器 + sidecar），都准备好
- `0/1` → 容器未准备好（正在启动或探针未通过）

------

## 🔵 **3. STATUS**

Pod 当前状态，表示 Pod 的生命周期情况。

常见的状态：

| 状态                 | 含义                             |
| -------------------- | -------------------------------- |
| **Pending**          | 镜像正在下载或等待调度           |
| **Running**          | 正常运行中                       |
| **Succeeded**        | Pod 已成功完成（比如一次性任务） |
| **Failed**           | Pod 已失败退出                   |
| **CrashLoopBackOff** | 容器不断启动失败循环             |
| **Error**            | 容器启动失败                     |

你看到的大多是 `Running`。

------

## 🔵 **4. RESTARTS**

容器重启次数（整个 Pod 生命周期累积）。

重启原因常见包括：

- 程序崩溃（Crash）
- 存活探针失败（Liveness Probe fail）
- OOMKilled（内存不足）
- 手动 kill 容器

你看到的例子：

```
aaa-bbbbbbbbb-basenetwork-0    1 (22d ago)
```

表示：
 这个 Pod 的容器曾重启过 1 次，22 天前发生的。

------

## 🔵 **5. AGE**

Pod 运行起来的总时间，比如：

- `13h` → 已运行 13 小时
- `12d` → 已运行 12 天
- `4m15s` → 刚创建

反映 Pod 生命周期长短。



```
NAME      → Pod 名称
READY     → 处于就绪状态的容器数/总容器数
STATUS    → Pod 当前状态
RESTARTS  → 容器历史重启次数
AGE       → Pod 已运行时间
```
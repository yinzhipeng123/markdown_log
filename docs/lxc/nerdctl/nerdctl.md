#  **nerdctl 是什么？**

**nerdctl** 是一个 **兼容 Docker CLI 的容器命令行工具**，可以理解为：

> **“看起来像 Docker、用起来也像 Docker，但底层不是 Docker，而是 containerd。”**

它是 containerd 官方提供的 CLI，用来直接操作 containerd。

所以如果你的系统用 **containerd**（比如 Kubernetes / k3s / k0s / Rancher / containerd 独立安装），就可以用 nerdctl 替代 Docker。

------

# 🔧 **能做什么？几乎和 Docker 一样**

nerdctl 和 Docker 的命令几乎一样：

| 想做的事                        | Docker 命令           | nerdctl 命令           |
| ------------------------------- | --------------------- | ---------------------- |
| 拉镜像                          | `docker pull nginx`   | `nerdctl pull nginx`   |
| 运行容器                        | `docker run -d nginx` | `nerdctl run -d nginx` |
| 查看容器                        | `docker ps`           | `nerdctl ps`           |
| 查看镜像                        | `docker images`       | `nerdctl images`       |
| 构建镜像（支持 BuildKit）       | `docker build`        | `nerdctl build`        |
| Compose（需要 nerdctl compose） | `docker compose`      | `nerdctl compose`      |

基本你会 Docker，就会 nerdctl。

------

#  **它的优势（相比 Docker）**

### **1. 完全基于 containerd（K8s 默认）**

Kubernetes 默认使用**containerd**作为运行时，不需要 Docker。

所以 nerdctl 非常适合 **Kubernetes 本地调试、边缘节点运维、轻量化系统**。

------

### **2. 支持 Cgroup v2**

新系统（RHEL9、CentOS Stream 9、Ubuntu 新版本）都用 cgroup v2
 → nerdctl + containerd 原生支持
 → Docker 以前兼容不好，现在也改了，但架构还是更重。

------

### **3. 更轻量，不依赖 dockerd 守护进程**

没有 Docker daemon，直接调用 containerd 的 API。

------

### **4. 原生支持 BuildKit（构建更快更省空间）**

`nerdctl build` 默认可以使用 BuildKit
 → 并行构建、缓存更好、速度快

------

#  **安装方式（举例）**

如果你的系统是 **CentOS Stream 9**（你就是这个系统），安装可以用：

```
curl -fsSL https://github.com/containerd/nerdctl/releases/latest/download/nerdctl-full-$(uname -m).tar.gz \
  -o nerdctl.tar.gz

sudo tar -zxvf nerdctl.tar.gz -C /usr/local
```

然后（如果 containerd 已经安装）就可以直接用：

```
nerdctl ps
```

------

#  **常见用法示例**

### 1️⃣ 运行 Nginx

```
nerdctl run -d --name web -p 8080:80 nginx
```

### 2️⃣ 构建镜像

```
nerdctl build -t myapp .
```

### 3️⃣ 登录镜像仓库

```
nerdctl login registry.example.com
```

### 4️⃣ 使用 compose（需要 nerdctl compose）

```
nerdctl compose up -d
```

------

# nerdctl 与 Docker 的区别总结

| 项目            | Docker  | nerdctl    |
| --------------- | ------- | ---------- |
| 底层            | dockerd | containerd |
| 是否带 daemon   | 有      | 无         |
| 是否更轻量      | ❌       | ✅          |
| 适合 Kubernetes | 一般    | 非常合适   |
| CLI 兼容度      | -       | 90%以上    |
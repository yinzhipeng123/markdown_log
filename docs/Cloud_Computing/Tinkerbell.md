Tinkerbell 是由 Equinix Metal（前 Packet） 开源的一个裸机自动部署平台，目标是像部署虚拟机一样灵活、快速地部署物理服务器。

它支持通过网络引导（PXE）和自动化工作流，将操作系统及必要配置部署到裸金属机器上，无需人工干预。



部署 Tinkerbell

------

## 🧰 一、前提条件

你需要准备一台 Linux 主机（推荐 Ubuntu 20.04+），并满足以下条件：

- 已安装 **Docker** 和 **Docker Compose**
- 可连接网络，或已准备好本地源
- 裸金属待装机服务器至少一台（支持 PXE 启动）

------

## 📦 二、克隆官方部署模板

Tinkerbell 官方提供了一个名为 [`tink-example`](https://github.com/tinkerbell/tink-example) 的项目，它用来快速部署完整的 Tinkerbell 服务。

```
git clone https://github.com/tinkerbell/tink-example.git
cd tink-example
```

------

## 🚀 三、启动 Tinkerbell 服务（使用 Docker Compose）

```
make docker-compose
```

这一步会部署以下组件：

| 组件                 | 作用                   |
| -------------------- | ---------------------- |
| **Tink**             | 提供 API 和工作流管理  |
| **Boots**            | PXE 启动服务           |
| **Hegel**            | 元数据服务             |
| **Hook**             | 实际装机引擎（容器）   |
| **Redis / Postgres** | 缓存和数据库服务       |
| **DNSMASQ**          | 提供 DHCP 和 TFTP 服务 |



你可以通过以下命令查看容器是否正常运行：

```
docker ps
```

------

## 🖥️ 四、配置 PXE 启动

确保你的裸机服务器设置为：

- 启动方式：**Network PXE Boot**
- 能在同一局域网内接收到 **Tinkerbell DHCP/TFTP 服务**

------

## 🧩 五、注册你的裸金属机器

你需要将裸机的 MAC 地址等信息注册到 Tinkerbell 中：

```
tink hardware push < your-hardware.json >
```

文件示例：

```
{
  "id": "abc123",
  "metadata": {},
  "network": {
    "interfaces": [
      {
        "mac": "aa:bb:cc:dd:ee:ff",
        "ipv4": {
          "address": "192.168.1.10",
          "gateway": "192.168.1.1",
          "netmask": "255.255.255.0"
        }
      }
    ]
  }
}
```

------

## 📝 六、创建模板（Workflow Template）

模板是一个 YAML 文件，定义装机逻辑，比如：

- 下载 OS 镜像
- 分区 / 格式化磁盘
- 安装系统
- 设置主机名 / 密钥

模板上传：

```bash
tink template create -n ubuntu-install -p template.yaml
```

------

## ▶️ 七、启动工作流（Workflow）

```
tink workflow create -t ubuntu-install -r abc123
```

系统就会在目标裸机上开始执行装机流程。

------

## 📚 八、补充建议

| 进阶需求                 | 可选操作                                                     |
| ------------------------ | ------------------------------------------------------------ |
| 使用 Kubernetes 管理组件 | 看 [`tink-k8s`](https://github.com/tinkerbell/tink/tree/main/deploy/kubernetes) 项目 |
| 支持 IPMI/BMC 控制       | 加装 [Rufio](https://github.com/tinkerbell/rufio)            |
| 自定义 Hook 逻辑         | 修改或添加容器步骤                                           |



------

## ✅ 总结：一句话回顾

> **Tinkerbell 使用 Docker Compose 可快速部署，通过工作流驱动裸机自动装系统，是现代自动化运维的利器。**


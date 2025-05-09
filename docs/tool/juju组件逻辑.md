Juju 是 Canonical 开发的一个开源运维编排工具，主要用于部署、配置、管理和扩展云应用。Juju 使用一种叫做 **Charm** 的模型来管理服务的生命周期。

------

## 一、Juju 的核心组件

| 组件名称        | 说明                                                         |
| --------------- | ------------------------------------------------------------ |
| **Controller**  | Juju 的控制平面，管理模型、用户、授权、状态等。一个 Controller 可支持多个模型。 |
| **Model**       | 一个逻辑环境或工作空间，部署的应用和服务都运行在 Model 中。每个模型相互隔离。 |
| **Charm**       | 描述应用如何部署、配置、升级和集成的包（一个 charm 就是一个自动化脚本集合）。 |
| **Application** | 基于 Charm 部署的实际运行服务，如部署 MySQL 就是一个 Application。 |
| **Unit**        | Application 的实例。比如部署了 3 个 MySQL 实例，就会有 3 个 Unit。 |
| **Machine**     | Application/Unit 运行的虚拟或物理主机。可以是容器或裸机。    |
| **Relation**    | 不同应用之间的连接关系（例如 Web 应用和数据库的关系）。      |

------

## 二、组件之间的逻辑关系

以下是它们的关系图与层级结构的简化描述：

```
Controller
└── Model(s)
    ├── Application(s)
    │   ├── Unit(s)
    │   │   └── Machine (or container)
    │   └── Charm (定义如何部署和管理)
    └── Relation(s) (在多个 Application 之间建立)
```

- **一个 Controller** 可以有多个 **Model**，比如按项目或环境划分。
- **一个 Model** 中可以部署多个 **Application**（基于 Charm）。
- **一个 Application** 可能有多个 **Unit**（即多个实例）。
- 每个 **Unit** 运行在一个 **Machine** 上（可共享或独立）。
- **Relation** 是 **Application** 间的逻辑连接，由 Charm 中的 hooks 处理。

------

## 举个例子：

部署一个 WordPress + MySQL 的架构：

```
Controller
└── Model: blog-site
    ├── Application: wordpress
    │   ├── Unit: wordpress/0
    │   └── Charm: wordpress
    ├── Application: mysql
    │   ├── Unit: mysql/0
    │   └── Charm: mysql
    └── Relation: wordpress ↔ mysql (通过 charm 中定义的接口连接)
```

这个模型中 WordPress 应用依赖于 MySQL 应用，Juju 通过 Relation 自动协商连接配置（如数据库地址、端口等）。



## 三、juju命令的目录结构

 `/snap/juju/current/` 目录结构和文件的功能说明：

```
.
├── bash_completions                   # Bash 自动补全脚本目录
│   ├── juju                           # Juju 命令自动补全脚本
│   └── juju-version                   # juju-version 命令自动补全脚本
├── bin                                # Juju 可执行二进制文件目录
│   ├── juju                           # Juju CLI 主程序
│   ├── jujuc                          # Juju controller 相关组件
│   ├── jujud                          # Juju agent 守护进程
│   ├── jujud-versions.yaml            # Juju 各版本的 agent 版本信息配置文件
│   └── juju-metadata                  # 用于处理 charm/store 元数据的工具
├── meta                               # Snap 包的元数据目录
│   ├── hooks                          # Snap 生命周期钩子脚本
│   │   ├── configure                  # 安装或配置时调用的脚本
│   │   ├── connect-plug-peers         # 当连接 interface plug 时触发
│   │   ├── disconnect-plug-peers      # 当断开 interface plug 时触发
│   │   └── post-refresh               # Snap 更新后调用的脚本
│   └── snap.yaml                      # 描述该 snap 的核心元数据（如版本、权限等）
├── snap                               # 与 snapcraft 构建和运行相关的配置
│   ├── command-chain
│   │   └── snapcraft-runner           # 构建时用于运行命令链的脚本
│   ├── hooks
│   │   ├── configure                  # 与 meta/hooks 中功能类似，用于兼容性或内部用途
│   │   ├── connect-plug-peers         # 同上
│   │   ├── disconnect-plug-peers      # 同上
│   │   └── post-refresh               # 同上
│   ├── manifest.yaml                  # Snap 包构建生成的组件和依赖的详细信息
│   └── snapcraft.yaml                 # Snapcraft 的构建配置文件，定义如何构建该 snap
└── wrappers                           # 包含辅助脚本的目录
    └── fetch-oci                      # 用于从 OCI（Open Container Initiative）源抓取资源的脚本
```

这个结构是一个典型的 Snap 包运行环境，`juju` 被打包成了一个 Snap 应用，其中包含了运行、更新、配置等所需的各种组件和脚本。


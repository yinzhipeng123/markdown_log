

juju安装过程

```bash
snap install juju --channel=2.8/stable --classic
yum install epel-release -y 
yum install snapd -y
systemctl enable --now snapd.socket 
ln -s /var/lib/snapd/snap /snap 
snap info juju #版本查询
snap install juju --channel=2.8/stable --classic #安装juju
echo 'export PATH=$PATH:/var/lib/snapd/snap/bin' >> ~/.bashrc 
source ~/.bashrc 
```



### juju 命令解释 



```bash
[root@localhost ~]# juju --help

当不带参数运行时，进入一个交互式 shell，该 shell 可用于直接运行任何 Juju 命令。在 shell 中：
  键入 "help" 查看可用命令列表。
  键入 "q" 或 ^D 或 ^C 退出。

否则，支持的命令用法如下所述。

用法: juju [选项] <命令> ...

选项:
--debug (= false)
  等效于 --show-log --logging-config=<root>=DEBUG
--description (= false)
  显示插件的简短描述（如果有）
-h, --help (= false)
  显示关于命令或其他主题的帮助。
--log-file (= "")
  写入日志的路径
--logging-config (= "")
  指定模块的日志级别
--no-alias (= false)
  运行此命令时不处理命令别名
-q, --quiet (= false)
  不显示任何信息性输出
--show-log (= false)
  如果设置，将日志文件写入 stderr
-v, --verbose (= false)
  显示更详细的输出

详情:
Juju 在 Amazon EC2、MaaS、OpenStack、Windows、Azure 或本地计算机等云基础设施提供商之上提供简单、智能的应用程序编排。

有关想法、文档和常见问题解答，请参阅 https://discourse.jujucharms.com/。

命令:
  actions                       - 列出应用程序定义的操作。
  add-cloud                     - 向 Juju 添加云定义。
  add-credential                - 向本地客户端添加云凭证并将其上传到控制器。
  add-k8s                       - 向 Juju 添加 k8s 端点和凭证。
  add-machine                   - 启动一个新的空机器，并可选择启动一个容器，或向一个机器添加一个容器。
  add-model                     - 添加一个托管模型。
  add-relation                  - 在两个应用程序端点之间添加一个关系。
  add-space                     - 添加一个新的网络空间。
  add-ssh-key                   - 向模型添加一个公共 SSH 密钥。
  add-storage                   - 动态添加单元存储。
  add-subnet                    - 向 Juju 添加一个现有的子网。
  add-unit                      - 向已部署的应用程序添加一个或多个单元。
  add-user                      - 向控制器添加一个 Juju 用户。
  agree                         - 同意条款。
  agreements                    - 列出用户的协议。
  attach                        - 'attach-resource' 的别名。
  attach-resource               - 更新应用程序的资源。
  attach-storage                - 将现有存储附加到单元。
  autoload-credentials          - 尝试自动检测并添加云的凭证。
  backups                       - 显示所有备份的信息。
  bind                          - 更改已部署应用程序的绑定。
  bootstrap                     - 初始化一个云环境。
  budget                        - 更新预算。
  cached-images                 - 显示缓存的操作系统镜像。
  cancel-action                 - 取消待处理或正在运行的操作。
  cancel-task                   - 'cancel-action' 的别名。
  change-user-password          - 更改当前或指定 Juju 用户的密码。
  charm                         - 已弃用：与 charm 交互。
  charm-resources               - 显示 charm 商店中 charm 的资源。
  clouds                        - 列出 Juju 可用的所有云。
  collect-metrics               - 在给定的单元/应用程序上收集指标。
  config                        - 获取、设置或重置已部署应用程序的配置。
  consume                       - 向模型添加一个远程提供。
  controller-config             - 显示或设置控制器的配置设置。
  controllers                   - 列出所有控制器。
  create-backup                 - 创建一个备份。
  create-storage-pool           - 创建或定义一个存储池。
  create-wallet                 - 创建一个新的钱包。
  credentials                   - 列出云的 Juju 凭证。
  dashboard                     - 打印 Juju 仪表板 URL，或在默认浏览器中打开 Juju 仪表板。
  debug-code                    - 启动一个 tmux 会话来调试钩子和/或操作。
  debug-hook                    - 'debug-hooks' 的别名。
  debug-hooks                   - 启动一个 tmux 会话来调试钩子和/或操作。
  debug-log                     - 显示模型的日志消息。
  default-credential            - 在此客户端上设置云的本地默认凭证。
  default-region                - 设置云的默认区域。
  deploy                        - 部署一个新的应用程序或 bundle。
  destroy-controller            - 销毁一个控制器。
  destroy-model                 - 终止非控制器模型的所有机器/容器和资源。
  detach-storage                - 从单元分离存储。
  diff-bundle                   - 比较 bundle 和模型并报告任何差异。
  disable-command               - 禁用模型的命令。
  disable-user                  - 禁用一个 Juju 用户。
  disabled-commands             - 列出禁用的命令。
  download-backup               - 获取一个归档文件。
  enable-command                - 启用先前禁用的命令。
  enable-destroy-controller     - 通过删除控制器中禁用的命令来启用 destroy-controller。
  enable-ha                     - 确保存在足够的控制器以提供冗余。
  enable-user                   - 重新启用先前禁用的 Juju 用户。
  exec                          - 在指定的远程目标上运行命令。
  export-bundle                 - 将当前模型配置导出为可重用的 bundle。
  expose                        - 使应用程序在网络上公开可用。
  find-offers                   - 查找提供的应用程序端点。
  firewall-rules                - 'list-firewall-rules' 的别名。
  get-constraints               - 显示应用程序的机器约束。
  get-model-constraints         - 显示模型的机器约束。
  grant                         - 授予 Juju 用户对模型、控制器或应用程序提供的访问级别。
  grant-cloud                   - 授予 Juju 用户对云的访问级别。
  gui                           - 'dashboard' 的别名。
  help                          - 显示关于命令或其他主题的帮助。
  help-tool                     - 'hook-tool' 的别名。
  hook-tool                     - 显示关于 Juju charm 钩子工具的帮助。
  hook-tools                    - 'hook-tool' 的别名。
  import-filesystem             - 将文件系统导入到模型中。
  import-ssh-key                - 从受信任的身份源向模型添加一个公共 SSH 密钥。
  kill-controller               - 强制终止 Juju 控制器的所有机器和其他相关资源。
  list-actions                  - 'actions' 的别名。
  list-agreements               - 'agreements' 的别名。
  list-backups                  - 'backups' 的别名。
  list-cached-images            - 'cached-images' 的别名。
  list-charm-resources          - 'charm-resources' 的别名。
  list-clouds                   - 'clouds' 的别名。
  list-controllers              - 'controllers' 的别名。
  list-credentials              - 'credentials' 的别名。
  list-disabled-commands        - 'disabled-commands' 的别名。
  list-firewall-rules           - 打印防火墙规则。
  list-machines                 - 'machines' 的别名。
  list-models                   - 'models' 的别名。
  list-offers                   - 'offers' 的别名。
  list-payloads                 - 'payloads' 的别名。
  list-plans                    - 'plans' 的别名。
  list-regions                  - 'regions' 的别名。
  list-resources                - 'resources' 的别名。
  list-spaces                   - 'spaces' 的别名。
  list-ssh-keys                 - 'ssh-keys' 的别名。
  list-storage                  - 'storage' 的别名。
  list-storage-pools            - 'storage-pools' 的别名。
  list-subnets                  - 'subnets' 的别名。
  list-users                    - 'users' 的别名。
  list-wallets                  - 'wallets' 的别名。
  login                         - 用户登录到控制器。
  logout                        - Juju 用户从控制器注销。
  machines                      - 列出模型中的机器。
  metrics                       - 检索指定实体收集的指标。
  migrate                       - 将托管模型迁移到另一个控制器。
  model-config                  - 显示或设置模型上的配置值。
  model-default                 - 'model-defaults' 的别名。
  model-defaults                - 显示或设置模型的默认配置设置。
  models                        - 列出用户可以访问控制器上的模型。
  move-to-space                 - 更新网络空间的 CIDR。
  offer                         - 提供应用程序端点供其他模型使用。
  offers                        - 列出共享的端点。
  payloads                      - 显示关于已知负载的状态信息。
  plans                         - 列出计划。
  regions                       - 列出给定云的区域。
  register                      - 注册一个控制器。
  relate                        - 'add-relation' 的别名。
  reload-spaces                 - 从底层重新加载空间和子网。
  remove-application            - 从模型中删除应用程序。
  remove-backup                 - 从远程存储中删除指定的备份。
  remove-cached-images          - 删除缓存的操作系统镜像。
  remove-cloud                    - 从 Juju 中删除一个云。
  remove-consumed-application   - 'remove-saas' 的别名。
  remove-credential             - 删除云的 Juju 凭证。
  remove-k8s                      - 从 Juju 中删除一个 k8s 云。
  remove-machine                - 从模型中删除一个或多个机器。
  remove-offer                  - 删除一个或多个通过其 URL 指定的提供。
  remove-relation               - 删除两个应用程序之间现有的关系。
  remove-saas                   - 从模型中删除已使用的应用程序 (SAAS)。
  remove-space                    - 删除一个网络空间。
  remove-ssh-key                - 从模型中删除一个或多个公共 SSH 密钥。
  remove-storage                - 从模型中删除存储。
  remove-storage-pool           - 删除一个现有的存储池。
  remove-unit                   - 从模型中删除应用程序单元。
  remove-user                   - 从控制器中删除一个 Juju 用户。
  rename-space                    - 重命名一个网络空间。
  resolve                       - 'resolved' 的别名。
  resolved                      - 标记单元错误已解决并重新执行失败的钩子。
  resources                     - 显示应用程序或单元的资源。
  restore-backup                - 从备份归档恢复到现有控制器。
  resume-relation               - 恢复与应用程序提供的已暂停关系。
  retry-provisioning            - 重试失败机器的配置。
  revoke                        - 撤销 Juju 用户对模型、控制器或应用程序提供的访问权限。
  revoke-cloud                  - 撤销 Juju 用户对云的访问权限。
  run                           - 在指定的远程目标上运行命令。
  run-action                    - 将一个操作排队以供执行。
  scale-application             - 设置所需的应用程序单元数。
  scp                           - 将文件传输到/从 Juju 机器。
  set-constraints               - 设置应用程序的机器约束。
  set-credential                - 将远程凭证关联到一个模型。
  set-default-credential        - 'default-credential' 的别名。
  set-default-region            - 'default-region' 的别名。
  set-firewall-rule             - 设置一个防火墙规则。
  set-meter-status              - 设置应用程序或单元的计量状态。
  set-model-constraints         - 设置模型的机器约束。
  set-plan                      - 设置应用程序的计划。
  set-series                    - 设置应用程序的系列。
  set-wallet                    - 设置钱包限额。
  show-action                   - 显示关于操作的详细信息。
  show-action-output            - 显示操作的结果。
  show-action-status            - 显示所有操作的结果，按可选的 ID 前缀过滤。
  show-application              - 显示关于应用程序的信息。
  show-backup                   - 显示指定备份的元数据。
  show-cloud                      - 显示云的详细信息。
  show-controller               - 显示控制器的详细信息。
  show-credential               - 显示存储在此客户端或控制器上的凭证信息。
  show-credentials              - 'show-credential' 的别名。
  show-machine                  - 显示机器的状态。
  show-model                    - 显示关于当前或指定模型的信息。
  show-offer                    - 显示关于提供的应用程序的扩展信息。
  show-space                    - 显示关于网络空间的信息。
  show-status                   - 报告模型、机器、应用程序和单元的当前状态。
  show-status-log               - 输出指定实体的过去状态。
  show-storage                  - 显示存储实例信息。
  show-unit                     - 显示关于单元的信息。
  show-user                     - 显示关于用户的信息。
  show-wallet                   - 显示关于钱包的详细信息。
  sla                           - 设置模型的 SLA 级别。
  spaces                        - 列出已知的空间，包括关联的子网。
  ssh                           - 启动一个 SSH 会话或在 Juju 机器上执行一个命令。
  ssh-keys                      - 列出当前（或指定）模型的当前已知 SSH 密钥。
  status                        - 'show-status' 的别名。
  storage                       - 列出存储详细信息。
  storage-pools                 - 列出存储池。
  subnets                       - 列出 Juju 已知的子网。
  suspend-relation              - 暂停与应用程序提供的关系。
  switch                        - 选择或标识当前的控制器和模型。
  sync-agent-binaries           - 将代理二进制文件从官方代理商店复制到本地模型。
  sync-tools                    - 'sync-agent-binaries' 的别名。
  trust                         - 将已部署应用程序的信任状态设置为 true。
  unexpose                      - 删除应用程序在网络上的公开可用性。
  unregister                    - 注销一个 Juju 控制器。
  update-cloud                  - 更新 Juju 可用的云信息。
  update-credential             - 更新云的控制器凭证。
  update-credentials            - 'update-credential' 的别名。
  update-k8s                      - 更新 Juju 使用的现有 k8s 端点。
  update-public-clouds          - 更新 Juju 可用的公共云信息。
  update-storage-pool           - 更新存储池属性。
  upgrade-charm                 - 升级应用程序的 charm。
  upgrade-controller            - 升级控制器上的 Juju。
  upgrade-dashboard             - 升级到新的 Juju 仪表板版本。
  upgrade-gui                   - 'upgrade-dashboard' 的别名。
  upgrade-juju                  - 'upgrade-model' 的别名。
  upgrade-model                 - 升级模型中所有机器上的 Juju。
  upgrade-series                - 升级机器的 Ubuntu 系列。
  upload-backup                 - 将备份归档文件远程存储在 Juju 中。
  users                         - 列出允许连接到控制器或模型的 Juju 用户。
  version                       - 打印 Juju CLI 客户端版本。
  wallets                       - 列出钱包。
  whoami                        - 打印当前的登录详细信息。
```



### juju run-action命令解释

```bash
[root@localhost ~]# juju run-action --help
用法: juju run-action [选项] <单元> [<单元> ...] <操作> [<键>=<值> [<键>[.<键> ...]=<值>]]

概要:
将一个操作排队以供执行。

全局选项:
--debug (= false)
  等效于 --show-log --logging-config=<root>=DEBUG
-h, --help (= false)
  显示关于命令或其他主题的帮助。
--logging-config (= "")
  指定模块的日志级别
--quiet (= false)
  不显示任何信息性输出
--show-log (= false)
  如果设置，将日志文件写入 stderr
--verbose (= false)
  显示更详细的输出

命令选项:
-B, --no-browser-login (= false)
  不使用 Web 浏览器进行身份验证
--format (= yaml)
  指定输出格式 (json|yaml)
-m, --model (= "")
  要操作的模型。接受 [<控制器名称>:]<模型名称>|<模型 UUID>
-o, --output (= "")
  指定一个输出文件
--params (= )
  yaml 格式的参数文件路径
--string-args (= false)
  使用 CLI 参数的原始字符串值
--wait (= )
  等待结果，可选择超时

详情:
在给定的单元上，使用给定的参数集，将一个操作排队以供执行。
将返回操作 ID，用于 'juju show-action-output <ID>' 或
'juju show-action-status <ID>'。

有效的单元标识符包括:
  一个标准的单元 ID，例如 mysql/0；或
  <应用程序>/leader 形式的领导者语法，例如 mysql/leader。

如果使用领导者语法，将在操作入队之前解析应用程序的领导者单元。

参数将根据单元应用程序的 charm 进行验证。可以使用 "juju actions <应用程序> --schema" 查看有效的参数。
参数可以位于通过 --params 选项传递的 yaml 文件中，也可以通过 key.key.key...=value 格式指定（见下面的示例）。

除非设置了 --string-args 选项，否则 CLI 调用中给出的参数将被解析为 YAML。这对于诸如 'y' 之类的值很有用，
在 YAML 中 'y' 是布尔值 true。

如果传递了 --params，并且同时存在 key.key...=value 显式参数，则显式参数将覆盖参数文件。

示例:

  juju run-action mysql/3 backup --wait
  juju run-action mysql/3 backup
  juju run-action mysql/leader backup
  juju show-action-output <ID>
  juju run-action mysql/3 backup --params parameters.yml
  juju run-action mysql/3 backup out=out.tar.bz2 file.kind=xz file.quality=high
  juju run-action mysql/3 backup --params p.yml file.kind=xz file.quality=high
  juju run-action sleeper/0 pause time=1000
  juju run-action sleeper/0 pause --string-args time=1000
```



`juju run-action` 命令用于**在 Juju 部署的应用程序单元上执行定义的操作（actions）**。

你可以把它想象成对一个正在运行的应用程序发送一个特定的指令，让它执行某些任务。这些可执行的任务是由应用程序的 "charm"（一个包含部署和管理应用程序所有必要信息的软件包）预先定义好的。

**更详细地说，`juju run-action` 可以让你：**

- **触发特定的管理任务：** 比如备份数据库、重启服务、收集诊断信息、执行自定义脚本等等。这些操作都是 charm 的开发者预先编写好的。
- **针对特定的单元执行：** 你可以指定在一个或多个应用程序单元上运行该操作。
- **传递参数：** 许多操作需要一些输入参数才能正常工作。`juju run-action` 允许你通过命令行或者参数文件来提供这些参数。
- **等待结果（可选）：** 你可以使用 `--wait` 选项来等待操作执行完成，并查看其输出结果。
- **查看操作状态和输出：** 执行操作后，你会得到一个操作 ID。你可以使用 `juju show-action-output <ID>` 和 `juju show-action-status <ID>` 命令来查看操作的执行状态和详细输出。

**简单来说，`juju run-action` 是与正在运行的 Juju 应用程序进行交互，并执行其提供的管理功能的关键工具。**

为了更好地理解它的用途，你可以思考以下场景：

- 你部署了一个 MySQL 数据库。MySQL 的 charm 可能定义了一个名为 "backup" 的 action。你可以使用 `juju run-action mysql/0 backup` 来触发对该数据库单元的备份操作。
- 你部署了一个 Web 服务器。它的 charm 可能有一个 "restart" 的 action。你可以使用 `juju run-action webserver/1 restart` 来重启该 Web 服务器的特定实例。
- 你部署了一个监控应用程序。它可能有一个 "collect-logs" 的 action，并且需要指定收集日志的时间范围。你可以使用 `juju run-action monitor/leader collect-logs --params '{"start_time": "2025-05-05T00:00:00Z", "end_time": "2025-05-06T00:00:00Z"}'` 来执行该操作并传递参数。



### juju actions命令

通常来说，action 的具体功能是由编写 charm 的开发者定义的，并且会与该 charm 所管理的应用程序的功能相关联。

**1. 查看 Charm 的 Actions 列表和 Schema：**

这是了解 action 功能的最直接的方法。你可以使用 `juju actions` 命令查看特定应用程序的所有可用 actions，以及它们的参数 schema（如果定义了的话）。Schema 通常会提供一些关于参数的描述，从而暗示 action 的功能。

执行以下命令：

```bash
juju actions docker-hello --schema
```

这个命令会列出 docker-hello 这个应用程序的所有 actions，schema 中通常会有这些参数的名称、类型和描述。通过查看参数的名称，你或许能推断出这个 action 的作用。



### juju config命令

`juju config docker-hello` 命令用于**查看或设置名为 `docker-hello` 的已部署应用程序的配置选项**。

**具体来说，这个命令有以下两种主要的用法和含义：**

**1. 查看配置 (如果后面没有指定 `key=value`):**

如果你只运行 `juju config docker-hello`，它会**显示当前 `docker-hello` 应用程序的所有配置选项及其当前的值**。输出通常会以 YAML 格式呈现，列出每个配置项的名称和它所设置的值。

例如，输出可能看起来像这样：



```yaml
access-address: 10.0.1.10
external-port: 8080
message: Hello from Docker!
```

在这个例子中，`docker-hello` 应用有三个配置选项：`access-address`、`external-port` 和 `message`，并且它们分别被设置为 `10.0.1.10`、`8080` 和 `Hello from Docker!`。

**2. 设置配置 (如果在后面指定了 `key=value`):**

如果你在 `juju config docker-hello` 后面加上一个或多个 `key=value` 对，那么这个命令将**用于设置 `docker-hello` 应用程序的特定配置选项的值**。

例如，要将 `docker-hello` 应用程序的 `message` 配置项更改为 "Greetings!"，你可以运行：

```bash
juju config docker-hello message="Greetings!"
```

你可以一次设置多个配置项，只需要用空格分隔不同的 `key=value` 对：

```bash
juju config docker-hello external-port=80 message="A new message"
```

**总结来说：**

- **`juju config <application-name>` (不带 `key=value`)**: **查看** 指定应用程序的当前配置。
- **`juju config <application-name> <key>=<value> [key2=value2 ...]`**: **设置** 指定应用程序的配置选项的值。

这个命令是管理已部署应用程序行为的重要工具，因为它允许你在不重新部署应用程序的情况下动态地调整其设置。应用程序的 charm 定义了哪些配置选项是可用的。你可以使用 `juju show <application-name>` 命令来查看应用程序的详细信息，包括其可用的配置选项和它们的描述。







### juju show-status-log 命令

`juju show-status-log docker-hello` 命令用于**查看名为 `docker-hello` 的已部署应用程序的单元的过去状态变化和相关的日志信息**。

**详细解释：**

- **`juju`**: 这是 Juju 命令行工具的名称。
- **`show-status-log`**: 这是 Juju 的一个子命令，用于显示实体的状态日志。状态日志记录了该实体在不同时间点的状态变化以及可能相关的消息。
- **`docker-hello`**: 这是你想要查看状态日志的应用程序的名称。

**这个命令会输出什么信息？**

通常，`juju show-status-log <application-name>` 会显示该应用程序下所有单元的状态日志。对于每个单元，你可能会看到类似以下的条目：

```
2025-05-06 04:00:00 INFO unit-docker-hello-0: Installing software
2025-05-06 04:01:15 INFO unit-docker-hello-0: Hook finished: install
2025-05-06 04:01:30 INFO unit-docker-hello-0: Starting application
2025-05-06 04:02:00 INFO unit-docker-hello-0: Hook finished: start
2025-05-06 04:02:10 INFO unit-docker-hello-0: Active: <unit is running>
```

**每一行通常包含以下信息：**

- **时间戳**: 指示状态变化或日志消息发生的时间。
- **日志级别**: 例如 `INFO`、`WARNING`、`ERROR` 等，表示消息的重要性。
- **单元名称**: 指示该日志条目属于哪个单元 (例如 `unit-docker-hello-0`)。
- **状态信息或日志消息**: 描述了单元在那个时间点正在做什么或者其状态是什么。这可能包括钩子（hooks）的执行情况（例如 `install`、`start`）、应用程序的状态信息（例如 `active`、`waiting`、`error`）以及 charm 输出的自定义日志消息。

**这个命令的用途：**

- **故障排除**: 当应用程序出现问题时，查看状态日志可以帮助你了解在问题发生之前或发生时发生了什么，例如哪个钩子失败了，或者应用程序报告了什么错误。
- **监控部署过程**: 在应用程序部署过程中，你可以使用这个命令来跟踪每个单元的状态变化，了解软件是否正在成功安装和启动。
- **了解应用程序行为**: 通过查看状态日志，你可以更好地理解 charm 在不同生命周期阶段是如何管理应用程序的。
- **审计和历史记录**: 状态日志提供了一个应用程序状态变化的审计 trail。

**总结：**

`juju show-status-log docker-hello` 是一个非常有用的命令，可以让你回顾 `docker-hello` 应用程序的部署和运行历史，帮助你诊断问题、监控状态和理解应用程序的行为。它提供了比 `juju status docker-hello` 命令更详细的历史信息，后者只显示应用程序的当前状态。

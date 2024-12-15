## 存放systemd配置文件的目录

`/etc/systemd/system/` 和 `/lib/systemd/system/` 目录都是 **systemd** 用来存放服务单元（unit）文件的地方，但是它们的用途有所不同。

### **1./etc/systemd/system/**

这个目录是系统管理员用来管理和修改 systemd 服务单元文件的地方。它主要用于 **自定义服务配置** 和 **覆盖** 系统默认的服务配置。

- [ ] **自定义服务单元文件**：你可以在这里创建新的服务文件，或者修改现有的服务文件。这个目录通常用来为服务添加特殊的配置选项，或者禁用某个系统默认的服务。
- [ ] **优先级较高**：如果 `/etc/systemd/system/` 中存在某个服务单元文件，它会覆盖 `/lib/systemd/system/` 中的同名文件。

##### 常见用途：

- [ ] 在此目录中修改服务文件，以便修改服务的启动行为、环境变量等。
- [ ] 禁用或启用服务。
- [ ] 启动服务时应用额外的自定义设置。

### **2./lib/systemd/system/**

这个目录是系统包安装服务单元文件的默认目录。系统软件包（如安装的应用程序、服务等）会将服务单元文件放在这里。这个目录包含的是由软件包管理器安装的、通常 **不应修改** 的原始系统服务配置文件。

- [ ] **系统级服务**：所有通过系统包管理工具（如 `yum`、`dnf`、`apt` 等）安装的软件会在这里安装服务文件。这些文件通常是“只读”的，不建议直接修改。
- [ ] **修改需要覆盖**：如果你需要修改这些服务文件，应该复制到 `/etc/systemd/system/` 目录下，并进行修改。这样可以保证原始文件不会被系统更新或软件包安装覆盖。

##### 常见用途：

- [ ] 系统软件包的默认服务配置。
- [ ] 包含了系统服务的原始设置，通常不直接修改。

### 目录层次的优先级：

- [ ] **/etc/systemd/system/** 目录的优先级 **高于** **/lib/systemd/system/** 目录。因此，如果同名的服务单元文件存在于这两个目录中，`/etc/systemd/system/` 中的文件会覆盖 `/lib/systemd/system/` 中的文件。

### 文件示例：

假设你想修改 Jenkins 的 systemd 服务配置文件。在大多数 Linux 系统上，默认的 Jenkins 服务文件通常位于 `/lib/systemd/system/jenkins.service`。

如果你希望修改 Jenkins 的启动行为（比如调整 `JAVA_HOME` 路径或其他启动参数），你应该：

1. **复制文件到 `/etc/systemd/system/` 目录**：

   ```bash
   sudo cp /lib/systemd/system/jenkins.service /etc/systemd/system/jenkins.service
   ```

2. **编辑 `/etc/systemd/system/jenkins.service`**： 通过编辑 `/etc/systemd/system/jenkins.service`，你可以对 Jenkins 的服务进行个性化配置，例如设置 `JAVA_HOME` 或修改其他启动参数。

   ```bash
   sudo vim /etc/systemd/system/jenkins.service
   ```

3. **重新加载 systemd 配置**： 修改服务配置文件后，重新加载 systemd 配置文件，以便让修改生效：

   ```bash
   sudo systemctl daemon-reload
   ```

4. **重启 Jenkins 服务**： 然后重启 Jenkins 服务以应用更改：

   ```bash
   sudo systemctl restart jenkins
   ```



- [ ] **/etc/systemd/system/**：用来存放 **自定义** 或 **覆盖** 默认服务配置的文件，优先级高。
- [ ] **/lib/systemd/system/**：存放由系统软件包管理器安装的 **默认服务配置文件**，通常不建议修改这些文件。







## systemd目录下的service文件书写规则

`systemd` 是 Linux 系统上的一个初始化系统和服务管理器，广泛用于管理系统和服务的启动、停止、维护等。`systemd` 使用 `.service` 文件来定义服务的配置和行为。`*.service` 文件是 `systemd` 用来启动和管理服务的配置文件。在 **systemd** 的 `.service` 配置文件中，**节（Section）** 和 **选项（Option）** 是定义服务行为和配置的基本组成部分。它们帮助 systemd 确定如何管理和运行服务。

### 1. **节（Section）**

节（也称为 **[Unit]**、**[Service]** 等部分）用于将配置文件划分为不同的区域，每个节负责配置某个特定方面的内容。每个节都有一个标题，以方括号包围，标题下方列出该节的相关选项。

常见的节有：

- **[Unit]**：描述服务的基本信息及其依赖关系。
- **[Service]**：描述服务如何启动、停止、重启等行为。
- **[Install]**：定义服务的安装选项，决定如何启用、禁用服务。

### 2. **选项（Option）**

选项是每个节中的具体配置项，用于控制该节下特定功能的行为。每个选项由 **键=值** 的形式表示，配置了特定功能的属性。

### 节和选项的详细解释：

#### 1. **[Unit]** 节

这个节包含关于服务的元数据和描述信息，定义了服务如何与其他服务交互。

常见的选项：

- [ ] `Description`：服务的简短描述。
- [ ] `Documentation`：相关的文档或帮助链接。
- [ ] `After`：指定服务启动顺序，表示该服务必须在其他服务之后启动。
- [ ] `Requires`：指定当前服务依赖的其他服务，若依赖的服务没有启动，当前服务也无法启动。
- [ ] `Wants`：类似于 `Requires`，但依赖关系不那么严格。
- [ ] `Before`：指定当前服务必须在其他服务之前启动。
- [ ] `Condition`：设置启动条件，如果条件不满足，则该服务不会启动。

**示例：**

```ini
[Unit]
Description=Jenkins Continuous Integration Server
Documentation=https://www.jenkins.io
After=network.target
```

- [ ] `Description` 给服务添加一个简短的说明。
- [ ] `After=network.target` 表示 Jenkins 服务必须在网络服务启动之后启动。

#### 2. **[Service]** 节

这个节包含服务的启动、停止、重启、环境变量等配置，定义了服务的具体行为。

常见的选项：

- [ ] `ExecStart`：定义启动服务时执行的命令。
- [ ] `ExecStop`：定义停止服务时执行的命令。
- [ ] `ExecReload`：定义重新加载服务时执行的命令。
- [ ] `WorkingDirectory`：指定服务运行时的工作目录。
- [ ] `Environment`：设置服务的环境变量。
- [ ] `User` 和 `Group`：指定服务运行时的用户和组权限。
- [ ] `Restart`：定义服务停止后是否自动重启，常见的值有 `always`、`on-failure` 等。
- [ ] `Type`：定义服务的启动类型，如 `simple`、`forking`、`oneshot` 等。

**示例：**

```ini
[Service]
ExecStart=/usr/bin/java -jar /opt/jenkins/jenkins.war
ExecStop=/bin/kill -s TERM $MAINPID
User=jenkins
Group=jenkins
WorkingDirectory=/opt/jenkins
Restart=on-failure
```

- [ ] `ExecStart` 定义了 Jenkins 服务的启动命令。
- [ ] `ExecStop` 定义了停止 Jenkins 服务时使用的命令。
- [ ] `User=jenkins` 和 `Group=jenkins` 表示 Jenkins 服务将以 `jenkins` 用户和组的身份运行。
- [ ] `Restart=on-failure` 表示如果服务异常终止，将自动重启。

#### 3. **[Install]** 节

这个节定义了服务的安装选项，控制服务如何启用和禁用。通常用于定义服务在哪个目标（target）下启动。

常见的选项：

- [ ] `WantedBy`：指定服务启用时的目标（例如 `multi-user.target`），表示该服务将在目标启动时自动启用。
- [ ] `RequiredBy`：类似 `WantedBy`，但更加严格，如果目标没有启动，当前服务也不会启动。
- [ ] `Alias`：为服务设置别名。

**示例：**

```ini
[Install]
WantedBy=multi-user.target
```

- [ ] `WantedBy=multi-user.target` 表示当系统进入多用户模式时，自动启动 Jenkins 服务。








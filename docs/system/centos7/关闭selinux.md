查看selinux状态

```bash
[root@localhost ~]# sestatus -help

用法: sestatus [OPTION]

  -v  对进程和文件上下文进行详细检查。
  -b  显示布尔值的当前状态。

不带选项，显示SELinux状态。
```



```bash
[root@localhost ~]# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   enforcing
Mode from config file:          enforcing
Policy version:                 29
Policy from config file:        targeted
```



根据上文提供的 `sestatus` 命令的输出，可以了解到 SELinux（Security-Enhanced Linux）在您的系统上的配置和状态：

**SELinux 状态**: 启用（`enabled`）。

```
这表示 SELinux 在您的系统上是激活的，正在运行。
```

**SELinux 文件系统挂载点**: `/selinux`。

```
这是 SELinux 文件系统在您系统上的挂载位置。
```

**当前模式**: 强制（`enforcing`）。

```
这意味着 SELinux 正在强制执行其安全策略。违反这些策略的行为将被阻止。
```

**配置文件中的模式**: 强制（`enforcing`）。

```
这表明 SELinux 的强制模式是通过配置文件（通常是 `/etc/selinux/config`）设置的，并且在系统启动时生效。
```

**策略版本**: 29。

```
这显示了 SELinux 使用的策略版本号。
```

**配置文件中的策略**: 针对性（`targeted`）。

```
SELinux 的“targeted”策略是一种常用的策略类型，它主要关注对系统中的特定目标（如网络守护进程和公共服务）施加安全控制，而不是对整个系统施加全面的控制。
```





要关闭 SELinux，你可以按照以下步骤操作：

**临时关闭 SELinux**:

```
使用 `setenforce 0` 命令可以临时将 SELinux 设置为宽容模式（Permissive），这实际上会禁用 SELinux 的强制策略，但仍会记录违反政策的行为。这种更改只在当前会话有效，重启后会恢复。
```

**永久关闭 SELinux**:

```
编辑 `/etc/selinux/config` 文件。

找到 `SELINUX=enforcing` 或 `SELINUX=permissive` 这一行，并将其更改为 `SELINUX=disabled`。
```

保存文件并重启系统。
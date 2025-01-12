Ansible执行命令实例

```bash
ansible all -i host.txt -m shell -a "mv /tmp/testfile /tmp/test" -e 'ansible_ssh_common_args=" -o StrictHostKeyChecking=no"'
```



`all` 是目标主机组的名称。在 Ansible 中，你可以使用组名来指定要运行命令的主机集合。`all` 是一个特殊的关键字，代表 **所有主机**。在这个例子中，它表示对 `host.txt` 文件中列出的所有主机执行命令。

`-i` 用于指定 **清单文件**，即目标主机的列表文件。
在这个例子中，`host.txt` 是一个文本文件，里面列出了所有目标主机的 IP 地址或主机名。这个文件告诉 Ansible 需要连接哪些主机

`-m` 用于指定要使用的 **模块**，`shell` 模块表示你希望在目标主机上运行一个 shell 命令。Ansible 提供了很多模块，不同的模块用于不同类型的任务（如 `yum`、`apt`、`copy`、`file` 等）。在这个例子中，使用的是 `shell` 模块，因此它会执行后续提供的 shell 命令。

`-a` 后面跟的是要在目标主机上执行的 **命令参数**。
在这个例子中，`-a "mv /tmp/testfile /tmp/test"` 表示要在目标主机上执行 `mv /tmp/testfile /tmp/test` 命令，即将 `/tmp/testfile` 文件移动到 `/tmp/test` 位置。

`-e` 选项用于设置 **额外的变量**，这里设置的是 SSH 连接的参数。

- [ ] **`ansible_ssh_common_args`**：这是 Ansible 连接 SSH 时的一个常见参数。
- [ ] **`-o StrictHostKeyChecking=no`**：这是 SSH 的一个选项，表示在连接新主机时不进行严格的主机密钥检查。如果目标主机的公钥不在 `known_hosts` 文件中，SSH 默认会要求确认。这条设置的作用是 **跳过这个验证**，避免第一次连接时需要手动输入 `yes` 进行确认。



备份

```bash
ansible all -i host.txt -m shell -a "cp /etc/ssh/sshd_config /etc/ssh/sshd_config_bak" -e 'ansible_ssh_common_args=" -o StrictHostKeyChecking=no"'
```

更改

```bash
ansible all -i host.txt -m shell -a "sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config" -e 'ansible_ssh_common_args=" -o StrictHostKeyChecking=no"'
```

重启服务

```bash
ansible all -i host.txt -m shell -a "systemctl restart sshd" -e 'ansible_ssh_common_args=" -o StrictHostKeyChecking=no"'
```





忽略 Host Key 检查，并设置ssh密码

```bash
ansible all -i ip.txt -m shell -a "uptime" -e 'ansible_ssh_common_args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"' --extra-vars "ansible_password=mypasswd"
```


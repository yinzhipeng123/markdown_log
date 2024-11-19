

将内核转储文件从机器 A 迁移到机器 B 进行分析的流程需要确保转储文件、内核调试符号和分析工具版本的正确匹配。以下是详细步骤：

---

### **1. 准备条件**
#### 在机器 A 上：
- 确保已生成 `vmcore` 文件。
  ```bash
  ls /var/crash
  ```
  通常会看到类似 `/var/crash/<时间戳>/vmcore` 的文件。

- 确认机器 A 的内核版本：
  ```bash
  uname -r
  ```
  示例输出：
  ```
  3.10.0-1160.el7.x86_64
  ```

#### 在机器 B 上：
- 确保机器 B 上安装了与机器 A 相同的 `crash` 工具。
- 确保机器 B 上安装了与机器 A 内核版本完全一致的调试符号文件（`kernel-debuginfo` 和 `kernel-debuginfo-common`）。

---

### **2. 迁移转储文件**
将 `vmcore` 文件从机器 A 拷贝到机器 B，例如：
```bash
scp /var/crash/<时间戳>/vmcore user@machineB:/path/to/vmcore
```

---

### **3. 在机器 B 上准备内核调试符号**
#### 3.1 安装匹配的 `kernel-debuginfo` 和 `kernel-debuginfo-common`
在机器 B 上，安装与机器 A 内核版本一致的调试包：

1. 启用 `debuginfo` 仓库：
   ```bash
   sudo yum install -y yum-utils
   sudo yum-config-manager --enable base-debuginfo
   ```

2. 安装调试包：
   ```bash
   sudo yum install kernel-debuginfo-<A的内核版本> kernel-debuginfo-common-<A的内核版本>
   ```
   示例：
   ```bash
   sudo yum install kernel-debuginfo-3.10.0-1160.el7.x86_64 kernel-debuginfo-common-3.10.0-1160.el7.x86_64
   ```

3. 验证调试包版本：
   ```bash
   rpm -q kernel-debuginfo kernel-debuginfo-common
   ```

#### 3.2 确保调试符号文件路径正确
调试符号文件应位于以下路径：
```bash
/usr/lib/debug/lib/modules/<A的内核版本>/vmlinux
```
如果路径不存在或文件缺失，需要重新检查 `kernel-debuginfo` 包的安装。

---

### **4. 分析转储文件**
使用 `crash` 工具分析转储文件。

#### 4.1 检查 `crash` 是否已安装
```bash
rpm -q crash
```
如未安装：
```bash
sudo yum install crash
```

#### 4.2 使用 `crash` 工具加载转储文件
运行以下命令：
```bash
crash /usr/lib/debug/lib/modules/<A的内核版本>/vmlinux /path/to/vmcore
```

- 示例：
  ```bash
  crash /usr/lib/debug/lib/modules/3.10.0-1160.el7.x86_64/vmlinux /home/user/vmcore
  ```

#### 4.3 检查加载是否成功
加载成功时，`crash` 工具会显示类似以下输出：
```
crash 7.2.3
Copyright (C) 2002-2016 Red Hat, Inc.
...
```
如果加载失败：
- 检查 `vmlinux` 和 `vmcore` 是否匹配。
- 确保调试包安装正确。

---

### **5. 分析转储文件**
在 `crash` 工具中可以使用多种命令分析转储文件，常用命令包括：

#### 查看系统信息
```bash
sys
```

#### 查看崩溃原因
```bash
bt
```

#### 查看内核日志
```bash
log
```

#### 查看内存使用情况
```bash
kmem -i
```

#### 查看任务状态
```bash
ps
```

#### 查看特定进程的上下文
```bash
task <pid>
```

更多命令可以通过 `help` 查看。

---

### **6. 调试符号不匹配的解决方法**
如果遇到以下问题：
- `cannot resolve symbol` 错误。
- 调试符号文件加载失败。

可能的解决方法：
1. 确认 `vmlinux` 与 `vmcore` 的内核版本匹配。
2. 手动从 [CentOS Vault](http://vault.centos.org/) 或源代码编译调试符号。
3. 使用机器 A 上生成的 `vmlinux`，并将其复制到机器 B 进行分析。

---

### **7. 总结**
1. 在机器 A 上记录内核版本并生成 `vmcore`。
2. 将 `vmcore` 和匹配的 `vmlinux` 转移到机器 B。
3. 在机器 B 上安装相同版本的 `kernel-debuginfo` 和 `kernel-debuginfo-common`。
4. 使用 `crash` 工具加载并分析转储文件。

确保工具和文件的版本完全匹配，才能顺利完成分析任务。
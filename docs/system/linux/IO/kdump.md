## kdump

在 CentOS 7 中部署和配置 `kdump`（内核转储）功能可以帮助捕获系统崩溃时的内核转储数据，从而进行调试和问题分析。以下是详细步骤：

---

### 1. 安装和启用 kdump
#### 1.1 安装 `kdump` 和 `crash`
确保系统已安装 `kdump` 和 `crash` 工具。

```bash
sudo yum install -y kexec-tools crash
```

#### 1.2 启用 `kdump`
确保 `kdump` 服务已启动并设置为开机自启动：

```bash
sudo systemctl enable kdump
sudo systemctl start kdump
```

---

### 2. 配置 kdump
#### 2.1 修改内存保留设置
编辑 `/etc/default/grub` 文件，添加或修改 `crashkernel` 参数以预留内存用于捕获转储。例如：

```bash
GRUB_CMDLINE_LINUX="... crashkernel=auto ..."
```

如果内存不足，可以手动设置：

- **内存小于 2GB**：设置 `crashkernel=128M`
- **内存介于 2GB 和 8GB 之间**：设置 `crashkernel=256M`
- **内存大于 8GB**：设置 `crashkernel=512M` 或更多

保存后，更新 GRUB 配置：

```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

如果是 UEFI 系统，请运行：

```bash
sudo grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg
```

重启系统以应用更改：

```bash
sudo reboot
```

#### 2.2 验证内存保留
重启后，检查是否成功预留内存：

```bash
dmesg | grep -i crashkernel
```

输出类似以下信息表示成功：

```
[    0.000000] Reserving X MB of memory at 0X for crashkernel
```

---

### 3. 配置转储存储路径
默认情况下，转储文件会存储在 `/var/crash` 目录。如果需要更改路径，请编辑 `/etc/kdump.conf` 文件：

```bash
path /your/custom/path
```

可选配置：
- 保存为压缩文件：`core_collector makedumpfile -c --message-level 1 -d 31`
- 通过网络保存转储：`nfs server:/path/to/save`

---

### 4. 测试 kdump 功能
#### 4.1 手动触发系统崩溃
**警告：以下操作会导致系统立即崩溃！请在测试环境中进行操作。**

启用 `sysrq` 功能：

```bash
echo 1 > /proc/sys/kernel/sysrq
```

触发崩溃：

```bash
echo c > /proc/sysrq-trigger
```

#### 4.2 检查转储文件
系统重新启动后，检查转储文件是否生成（默认路径 `/var/crash`）：

```bash
ls /var/crash
```

使用 `crash` 工具分析生成的转储文件：

```bash
sudo crash /usr/lib/debug/lib/modules/$(uname -r)/vmlinux /var/crash/.../vmcore
```

---

### 5. 常见问题排查
- 如果内核转储未生成：
  1. 确认 `crashkernel` 参数正确。
  2. 检查 `/etc/kdump.conf` 是否正确配置。
  3. 查看 `journalctl -xe` 获取更多信息。
- 如果系统内存不足，请减少 `crashkernel` 的内存预留量。

---

通过上述步骤即可成功部署 `kdump` 并捕获系统崩溃时的内核转储。
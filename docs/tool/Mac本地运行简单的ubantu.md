### **使用 Multipass**

**Multipass** 是由 Canonical（Ubuntu 的开发者）提供的工具，可以快速在 macOS 上启动轻量级的 Ubuntu 虚拟机。

使用 **Hypervisor.framework**，这是 macOS 提供的本地虚拟化框架，类似于 Windows 的 Hyper-V

安装命令：

```bash
brew install multipass
```

启动 Ubuntu：

```bash
xxx@MacBook-Pro ~ % multipass launch  #启动
#如果只需要一个实例，直接管理默认的 primary 即可，不需要再次运行 multipass launch。
#如果需要创建多个实例，建议显式命名,命令如下
#multipass launch -n my-instance

xxx@MacBook-Pro ~ % multipass shell   #登录
```

查看虚拟机列表

```bash
xxx@MacBook-Pro ~ % multipass list
Name                    State             IPv4             Image
primary                 Running           192.168.64.3     Ubuntu 24.04 LTS
xxx@MacBook-Pro ~ % multipass info primary
Name:           primary
State:          Running
Snapshots:      0
IPv4:           192.168.64.3
Release:        Ubuntu 24.04.1 LTS
Image hash:     6e1f90d3e81b (Ubuntu 24.04 LTS)
CPU(s):         1
Load:           0.00 0.00 0.00
Disk usage:     2.0GiB out of 4.8GiB
Memory usage:   241.0MiB out of 953.0MiB
Mounts:         /Users/v_yinzhipeng01 => Home
                    UID map: 501:default
                    GID map: 20:default
```

停止实例

```bash
xxx@MacBook-Pro ~ % multipass stop nurtured-darter #停止实例
xxx@MacBook-Pro ~ % multipass delete nurtured-darter #删除实例
xxx@MacBook-Pro ~ % multipass purge #清理磁盘
```

`delete` 删除实例，但磁盘文件仍保留；`purge` 清理所有已删除实例的残留数据

配置sshd登录

```bash
ubuntu@primary:/etc/ssh/sshd_config.d$ vim /etc/ssh/sshd_config

PermitRootLogin yes #允许root登录

PubkeyAuthentication yes #允许root密码登录


ubuntu@primary:/etc/ssh/sshd_config.d$ sudo systemctl daemon-reload #加载新配置
ubuntu@primary:/etc/ssh/sshd_config.d$ sudo systemctl restart ssh  #重启SSH
```

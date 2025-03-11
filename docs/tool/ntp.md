**NTPD (Network Time Protocol Daemon)** 是一个用于网络时间同步的服务，通过该服务可以让计算机或设备与标准时间源同步，以确保系统的时间准确性。NTP（Network Time Protocol）是一种广泛使用的协议，用于通过网络同步计算机的时钟，保持系统时间与 UTC（协调世界时）一致。

### NTPD 的基本功能

NTPD 主要有以下功能：

1. **时间同步**：NTPD 会与指定的时间服务器进行通信，并使本地系统时钟与网络时间（如 UTC）同步。
2. **时间保持**：NTPD 会在运行时持续跟踪和校准系统时间，定期进行时间同步以确保时钟的准确性。
3. **对网络时钟的调节**：NTPD 会通过调整系统时钟的频率（也叫做“时钟漂移”）来保持系统时间的稳定。
4. **容错机制**：NTPD 可以从多个时间源（如公共的 NTP 服务器）获取时间，并通过算法选择最准确的时间源，从而避免单一服务器故障的影响。

### NTPD 的工作原理

NTPD 基于 **NTP 协议**，它通过使用层级结构的时间源来同步时间。时间源通常从 **原子钟**、**GPS** 或其他高精度设备获取时间。NTP 协议的时间同步机制是通过 **时间戳交换** 来实现的。

1. **时间源层次结构**：NTP 服务器根据其提供的时间源的精确度分为不同的层级，称为 "stratum"。

   - **Stratum 0**：原子钟、GPS、其他高精度时间源。
   - **Stratum 1**：直接从 stratum 0 时间源获取时间的服务器。
   - **Stratum 2**：通过 stratum 1 服务器获取时间的服务器，依此类推。

   一个高层次的 NTP 服务器通常会从低层次的服务器获取时间，而低层次的服务器则依赖于更精确的源。

2. **时间同步过程**：NTPD 客户端与 NTP 服务器之间交换时间戳信息，具体步骤如下：

   - 客户端发送请求到 NTP 服务器，要求获取当前时间。
   - 服务器返回一个时间戳（包括发送时间、接收时间等信息）。
   - 客户端计算延迟和时钟偏差，然后调整自己的系统时间。

   **延迟计算**：NTP 协议会计算请求的往返延迟并尽量减少网络延迟的影响。

3. **时钟调节**：NTPD 会根据实际的时间差异调整系统时钟的频率，以纠正长时间积累的小误差。这种调节方式不会突然改变系统时间，而是平滑地进行调整。





```bash
[root@ ~]# rpm -ql  ntp-4.2.6p5-29.el7.centos.2.x86_64 
/etc/dhcp/dhclient.d   # DHCP客户端的配置脚本目录，用于设置NTP相关配置
/etc/dhcp/dhclient.d/ntp.sh   # 脚本，用于从DHCP服务器获取NTP服务器地址
/etc/ntp.conf   # NTP配置文件，指定NTP服务器和其他时间同步设置
/etc/ntp/crypto   # 存放NTP加密文件和密钥的目录
/etc/ntp/crypto/pw   # 存放NTP认证所需的密码文件
/etc/sysconfig/ntpd   # 配置NTP守护进程启动参数的系统配置文件
/usr/bin/ntpstat   # 显示NTP同步状态的工具
/usr/lib/systemd/ntp-units.d/60-ntpd.list   # systemd依赖关系和单位配置文件
/usr/lib/systemd/system/ntpd.service   # systemd服务单元，管理ntpd服务
/usr/sbin/ntp-keygen   # 用于生成和管理NTP密钥的工具
/usr/sbin/ntpd   # NTP守护进程主程序，负责时间同步
/usr/sbin/ntpdc   # 用于监控ntpd守护进程的工具（已废弃）
/usr/sbin/ntpq   # 查询ntpd状态和统计信息的工具
/usr/sbin/ntptime   # 显示系统时间和NTP同步状态的工具
/usr/sbin/tickadj   # 调整系统时钟滴答间隔的工具
/usr/share/doc/ntp-4.2.6p5   # NTP文档目录，包含软件包的使用说明
/usr/share/doc/ntp-4.2.6p5/COPYRIGHT   # NTP软件包的版权声明
/usr/share/doc/ntp-4.2.6p5/ChangeLog   # 记录NTP包更新内容的日志文件
/usr/share/doc/ntp-4.2.6p5/NEWS   # 发布说明，告诉用户新版本的改动
/usr/share/man/man1/ntpstat.1.gz   # ntpstat命令的手册页，压缩版
/usr/share/man/man5/ntp.conf.5.gz   # ntp.conf配置文件手册页，压缩版
/usr/share/man/man5/ntp_acc.5.gz   # NTP认证配置的手册页
/usr/share/man/man5/ntp_auth.5.gz   # NTP认证的手册页
/usr/share/man/man5/ntp_clock.5.gz   # 配置NTP时间源的手册页
/usr/share/man/man5/ntp_decode.5.gz   # 解释NTP数据包的手册页
/usr/share/man/man5/ntp_misc.5.gz   # 其他NTP配置选项的手册页
/usr/share/man/man5/ntp_mon.5.gz   # ntpd监控配置的手册页
/usr/share/man/man8/ntp-keygen.8.gz   # ntp-keygen命令的手册页，压缩版
/usr/share/man/man8/ntpd.8.gz   # ntpd守护进程手册页
/usr/share/man/man8/ntpdc.8.gz   # ntpdc命令手册页
/usr/share/man/man8/ntpq.8.gz   # ntpq命令手册页
/usr/share/man/man8/ntptime.8.gz   # ntptime命令手册页
/usr/share/man/man8/tickadj.8.gz   # tickadj命令手册页
/var/lib/ntp   # 存储NTP服务运行时数据的目录
/var/lib/ntp/drift   # NTP系统时钟漂移数据文件
/var/log/ntpstats   # 存储ntpd日志和同步状态信息的目录
```



### 配置 NTPD 服务

1. **安装 NTPD**

在大多数 Linux 发行版中，`ntpd` 包可以通过包管理器安装：

- **Ubuntu/Debian** 系统：
  
  ```bash
  sudo apt update
  sudo apt install ntp
  ```

- **CentOS/RHEL** 系统：
  
  ```bash
  sudo yum install ntp
  ```
2. **启动和启用 NTPD 服务**

安装完成后，启动并启用 `ntpd` 服务，以便它在系统启动时自动启动：

- 启动服务：
  
  ```bash
  sudo systemctl start ntp
  ```

- 启用服务（使其在系统启动时自动启动）：
  
  ```bash
  sudo systemctl enable ntp
  ```

- 检查 NTP 服务状态：
  
  ```bash
  sudo systemctl status ntp
  ```
3. **配置 NTPD**

`ntpd` 的配置文件通常位于 `/etc/ntp.conf`，可以编辑这个文件来配置时间服务器和其他设置。

```bash
[root@noaheese ~]# cat /etc/ntp.conf  
driftfile /var/lib/ntp/drift               # 指定存储本地时钟漂移值的文件，ntpd 用它来校正系统时钟误差
restrict default kod nomodify notrap nopeer noquery  # 为所有客户端设置默认访问限制，启用关键字检测（kod），禁止修改、陷阱、对等连接和查询
restrict -6 default kod nomodify notrap nopeer noquery # 为所有 IPv6 客户端设置与 IPv4 相同的默认访问限制
restrict 127.0.0.1                        # 对本地 IPv4 回环地址提供较宽松的访问权限，允许本机查询和修改
restrict ::1                              # 对本地 IPv6 回环地址提供较宽松的访问权限，允许本机查询和修改
includefile /etc/ntp/crypto/pw            # 包含存放 NTP 认证密码的文件，用于安全认证
keys /etc/ntp/keys                        # 指定存储 NTP 认证密钥的文件，供 ntpd 验证和生成时间戳签名
disable monitor                           # 禁用 ntpd 的监控功能，防止外部访问详细的状态信息
server xxx.xxx.xxx.xxx                        # 指定用于时间同步的上游 NTP 服务器地址
```



基本配置如下：

```ini
# /etc/ntp.conf                       
# 定义时间服务器                         # 注释说明接下来是定义上游时间服务器
server 0.centos.pool.ntp.org iburst   # 指定上游 NTP 服务器为 0.centos.pool.ntp.org，iburst 选项用于加速初始同步
server 1.centos.pool.ntp.org iburst   # 指定上游 NTP 服务器为 1.centos.pool.ntp.org，iburst 选项用于加速初始同步
server 2.centos.pool.ntp.org iburst   # 指定上游 NTP 服务器为 2.centos.pool.ntp.org，iburst 选项用于加速初始同步
server 3.centos.pool.ntp.org iburst   # 指定上游 NTP 服务器为 3.centos.pool.ntp.org，iburst 选项用于加速初始同步

# 启用局域网中的广播模式                # 注释说明启用局域网内的广播时间同步功能
broadcast 192.168.1.255                # 设置广播地址为 192.168.1.255，ntpd 将通过此地址广播时间信息到局域网内

# 允许特定的客户端访问本地 NTP 服务      # 注释说明配置对特定网络的客户端访问限制
restrict 192.168.0.0 mask 255.255.255.0 nomodify notrap.  # 对 192.168.0.0/24 网络的客户端应用访问限制，允许查询但禁止修改配置及发送 trap 消息

```

- `server` 行指定了要使用的 NTP 服务器。可以选择本地的 NTP 服务器或公共的 NTP 服务器。
- `iburst` 选项可以在启动时快速同步时间。
- `restrict` 行用于限制哪些 IP 地址或网络可以访问本地 NTP 服务。

### 验证和查看 NTP 状态

1. **查看 NTP 同步状态**

要查看 `ntpd` 是否正在正常同步时间，可以使用以下命令：

```bash
ntpq -p
```

这将显示当前正在使用的 NTP 服务器以及它们的状态信息。例如，输出可能如下所示：

```bash
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
*xx.xx.xx.xx     xx.xxx.xx.xx      2 u 1004 1024  377    0.115   -1.462   0.221
# *10.52.192.2     # 远程 NTP 服务器的 IP 地址
# 10.50.27.35      # 参考 ID，表示远程服务器时间来源的地址
# 2                # 层级，表示该服务器距离参考时钟的距离（层次为 2）
# u                # 连接类型，u 表示单播连接
# 1004             # 距离上次轮询的时间（秒）
# 1024             # 轮询间隔（秒）
# 377              # 可达性寄存器，表示 NTP 查询的状态（八进制）
# 0.115            # 网络延迟，单位为毫秒（此处为 0.115 秒，即 115 毫秒）
# -1.462           # 时间偏移，表示本地系统与远程服务器之间的时间差（单位为毫秒）
# 0.221            # 抖动，时间偏移测量的变化范围（单位为毫秒）

```

- `*` 表示当前选中的同步源。

- `reach` 列表示 NTP 服务器的可达性，`377` 表示 8 次请求均成功。

- `delay` 和 `offset` 表示网络延迟和本地时钟偏差。
2. **强制同步时间**

如果需要手动强制同步时间，可以使用 `ntpdate` 工具：

```bash
sudo ntpdate 0.centos.pool.ntp.org
```

### 常见问题和故障排查

1. **时钟偏差过大**：
   
   - 如果系统时钟与 NTP 服务器的时间差异过大，`ntpd` 可能会无法同步。在这种情况下，可以使用 `ntpdate` 工具来立即同步时间，然后重新启动 `ntpd`。
   
   ```bash
   sudo ntpdate 0.centos.pool.ntp.org
   sudo systemctl restart ntp
   ```

2. **防火墙问题**：
   
   - 确保防火墙允许 NTP 服务的 UDP 123 端口通信。如果防火墙阻止了这些流量，`ntpd` 将无法同步时间。

3. **NTP 服务器不可达**：
   
   - 如果 `ntpd` 无法连接到配置的 NTP 服务器，检查网络连接并尝试更换服务器。可以使用其他公共的 NTP 服务器，如 `pool.ntp.org`。

4. **系统时间不正确**：
   
   - 如果系统时间不准确，`ntpd` 可能无法正确同步。使用 `date` 命令检查当前系统时间并确保它的正确性。

---

### **时间同步工具命令**

#### 1. **ntpq**

`ntpq` 是用于监控和管理 `ntpd` 服务的工具，显示当前 NTP 状态信息。

- **检查 NTP 服务器状态**：
  
  ```bash
  ntpq -p
  ```
  
  显示连接到的 NTP 服务器列表及状态。输出示例：
  
  ```
       remote           refid      st t when poll reach   delay   offset  jitter
  ==============================================================================
  *0.centos.pool.ntp.org  .POOL.          2 u   43   64   377    0.223    0.001   0.004
  +1.centos.pool.ntp.org  .POOL.          2 u   35   64   377    0.234    0.001   0.003
  ```
  
  字段含义：
  
  - `remote`：NTP 服务器地址。
  - `st`：服务器层级（stratum），数字越小表示时间源越精确。
  - `delay`：从本地到服务器的延迟。
  - `offset`：本地时间与服务器时间的差值。
  - `*`：当前选用的时间源，`+` 表示备用。

- **进入交互模式**：
  
  ```bash
  ntpq
  ```
  
  输入以下命令查看详细信息：
  
  - `peers`：显示 NTP 服务器的状态。
  - `as`：显示活动服务器的状态。
  - `rv`：查看本地 NTP 服务的运行状态。

#### 2. **ntpdate**

`ntpdate` 是一个用于手动同步系统时间的工具。

- **立即同步时间**：
  
  ```bash
  sudo ntpdate pool.ntp.org
  ```
  
  将本地时间与 `pool.ntp.org` 时间服务器同步。

- **测试时间服务器**：
  
  ```bash
  ntpdate -q pool.ntp.org
  ```
  
  仅测试与时间服务器的连接状态，不实际同步时间。

- **注意**：
  如果正在运行 `ntpd` 服务，使用 `ntpdate` 前需要停止 `ntpd`，以避免冲突：
  
  ```bash
  sudo systemctl stop ntpd
  sudo ntpdate pool.ntp.org
  sudo systemctl start ntpd
  ```

#### 3. **timedatectl**

`timedatectl` 是现代 Linux 系统中管理时间的命令。

- **查看当前时间状态**：
  
  ```bash
  timedatectl
  ```
  
  输出示例：
  
  ```bash
        Local time: Fri 2025-03-07 22:28:01 CST   # 当前系统的本地时间，根据所设置的时区（此处为CST）显示
    Universal time: Fri 2025-03-07 14:28:01 UTC   # 当前协调世界时（UTC），独立于本地时区显示
          RTC time: Fri 2025-03-07 22:28:00     # 硬件实时时钟（RTC）的时间，此处与本地时间一致（因RTC采用本地时间模式）
         Time zone: Asia/Shanghai (CST, +0800)   # 系统所用时区为Asia/Shanghai，即中国标准时间，UTC偏移+8小时
       NTP enabled: no        # 这行表示系统的自动时间同步服务（通常是 systemd-timesyncd）没有启用，也就是说，系统没有使用内置的 systemd NTP 客户端来定期更新时间。
  NTP synchronized: yes       # 这行表示当前系统时间已经与某个 NTP 服务器保持同步。即使 systemd 的自动同步服务没有启用，系统仍可能通过其他 NTP 守护进程（如 ntpd 或 chronyd）或者一次性手动同步等方式获得正确的时间。
   RTC in local TZ: yes       # 表示硬件时钟（RTC）设置为本地时区时间，而非UTC
        DST active: n/a       # 表示夏令时（DST）不适用或未激活
  
  Warning: The system is configured to read the RTC time in the local time zone.   # 警告：系统配置为以本地时区读取RTC时间
           This mode can not be fully supported. It will create various problems         # 此模式支持不完全，可能导致时区更改及夏令时调整时出现问题
           with time zone changes and daylight saving time adjustments. The RTC
           time is never updated, it relies on external facilities to maintain it.      # RTC时间不会自动更新，而是依赖外部工具或服务进行维护
           If at all possible, use RTC in UTC by calling                                 # 建议尽可能将RTC设置为UTC，避免潜在问题，可使用以下命令
           'timedatectl set-local-rtc 0'.                                               # 'timedatectl set-local-rtc 0' 将RTC设置为UTC模式
  
  ```
  
- **启用 NTP**：
  
  ```bash
  sudo timedatectl set-ntp true
  ```

- **关闭 NTP**：
  
  ```bash
  sudo timedatectl set-ntp false
  ```

#### 4. **ntpstat**

`ntpstat` 用于查看 NTP 同步状态，显示同步是否成功。

- **查看同步状态**：
  
  ```bash
  ntpstat
  ```
  
  输出示例：
  
  ```
  synchronised to NTP server (192.168.1.1) at stratum 2
     time correct to within 50 ms
     polling server every 64 s
  ```

- 状态解释：
  
  - `synchronised`：表示已同步。
  - `unsynchronised`：表示未同步，可能是网络问题或 NTP 服务器不可用。

#### 5. **hwclock**

`hwclock` 管理硬件时钟（BIOS/RTC 时钟），与系统时间相关联。

- **查看硬件时钟时间**：
  
  ```bash
  hwclock
  ```

- **将系统时间写入硬件时钟**：
  
  ```bash
  hwclock --systohc
  ```

- **将硬件时钟时间写入系统时间**：
  
  ```bash
  hwclock --hctosys
  ```

---

### **NTP 服务管理命令**

#### 1. **服务启动与管理**

```bash
[root@ ~]# cat /etc/sysconfig/ntpd
# Command line options for ntpd           # 注释：指定 ntpd 命令行选项
OPTIONS="-g"                             # 定义 ntpd 启动时使用的选项，-g 表示允许 ntpd 在启动时进行大幅度时间校正

[root@ ~]# cat /usr/lib/systemd/system/ntpd.service
[Unit]                                   # [Unit] 部分，用于描述服务和其依赖关系
Description=Network Time Service           # 描述该服务的功能：网络时间同步服务
After=syslog.target ntpdate.service sntp.service  # 指定此服务必须在 syslog、ntpdate 和 sntp 服务启动后再启动

[Service]                                # [Service] 部分，定义服务的启动方式和运行环境
Type=forking                             # 指定服务类型为“forking”，表示服务启动后会派生出子进程并在后台运行
EnvironmentFile=-/etc/sysconfig/ntpd      # 从 /etc/sysconfig/ntpd 加载环境变量，前面的“-”表示文件不存在时不报错
ExecStart=/usr/sbin/ntpd -u ntp:ntp $OPTIONS  # 定义启动命令：以 ntp 用户/组身份运行 ntpd，并附加 /etc/sysconfig/ntpd 中定义的选项
PrivateTmp=true                          # 为该服务提供私有临时目录，提高服务安全性

[Install]                                # [Install] 部分，定义服务在系统目标中的安装配置
WantedBy=multi-user.target               # 指定该服务在 multi-user.target（多用户运行级别）下启动


[root@ ~]# ps -ef | grep ntpd
ntp       13852      1  0  2024 ?        00:00:31 /usr/sbin/ntpd -u ntp:ntp -g
```





- **启动 NTP 服务**：
  
  ```bash
  sudo systemctl start ntpd
  ```

- **停止 NTP 服务**：
  
  ```bash
  sudo systemctl stop ntpd
  ```

- **重启 NTP 服务**：
  
  ```bash
  sudo systemctl restart ntpd
  ```

- **检查服务状态**：
  
  ```bash
  sudo systemctl status ntpd
  ```

- **设置开机自启**：
  
  ```bash
  sudo systemctl enable ntpd
  ```

- **取消开机自启**：
  
  ```bash
  sudo systemctl disable ntpd
  ```

#### 2. **日志与故障排查**

- **查看 NTP 日志**：
  
  ```bash
  sudo journalctl -u ntpd
  ```

- **调试模式运行 NTP**：
  如果需要排查问题，可以在前台运行 `ntpd` 服务并启用调试模式：
  
  ```bash
  sudo ntpd -d
  ```

---

### **排查常见问题的命令**

#### 1. **检查网络连接**

确认是否可以访问 NTP 服务器：

```bash
ping pool.ntp.org
```

#### 2. **检查 UDP 123 端口**

NTP 使用 UDP 123 端口，确保防火墙未阻止：

```bash
sudo firewall-cmd --list-ports
sudo firewall-cmd --add-port=123/udp --permanent
sudo firewall-cmd --reload
```

#### 3. **验证时间同步**

手动检查系统时间偏差：

```bash
ntpdate -q pool.ntp.org
```

---

### **常用时间服务器**

- 公共 NTP 服务器池：
  
  - `0.pool.ntp.org`
  - `1.pool.ntp.org`
  - `2.pool.ntp.org`
  - `3.pool.ntp.org`

- 中国地区 NTP 服务器：
  
  - 中国国家授时中心：`ntp.ntsc.ac.cn`
  - 阿里云：`ntp.aliyun.com`
  - 腾讯云：`time1.cloud.tencent.com`

- [ ] **将系统时间写入硬件时钟**：使用 `sudo hwclock --systohc`。这是标准做法，因为系统时间在运行过程中会被动态调整。

- [ ] **将硬件时钟写入系统时间**：使用 `sudo hwclock --hctosys`。当硬件时钟时间准确，系统时间不准确时，可以使用此命令

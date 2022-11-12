# chrony服务

`chrony`是网络时间协议 （NTP） 的多功能实现。它可以将系统时钟与NTP服务器，参考时钟（例如GPS接收器）以及使用键盘的手动输入同步。它还可以作为 NTPv4 （RFC 5905） 服务器和对等体运行，为网络中的其他计算机提供时间服务。

`chrony`由两个程序组成，分别是`chronyd`和`chronyc`

`chronyd`是一个后台运行的守护进程，用于调整内核中运行的系统时钟和时钟服务器同步。它确定计算机增减时间的比率，并对此进行补偿。

`chronyc`提供了一个用户界面，用于监控性能并进行多样化的配置。它可以在`chronyd`实例控制的计算机上工作，也可以在一台不同的远程计算机上工作。

`ntp` 是网络时间协议（Network Time Protocol）的简称，通过 `udp` 123 端口进行网络时钟同步。

`RHEL7`中默认使用`chrony`作为时间服务器，也支持NTP，需要额外安装。

`ntp`与`chrony`不能同时存在

`chrony`的设计即使在困难的条件下，如间歇性网络连接和拥塞的网络，也能同步时间。与 ntpd 不同，它支持通过硬件时间戳同步系统时钟，从而提高 [LAN](https://en.wikipedia.org/wiki/Local_area_network) 上计算机之间时间同步的准确性。它还支持手动输入同步，并且可以在隔离网络内执行时间校正。

chrony官网：https://chrony.tuxfamily.org/index.html

chrony的设计性能上比ntp更加好，这个是对比：https://chrony.tuxfamily.org/comparison.html

### 前提知识

#### UTC时间

utc是协调世界时，又称世界统一时间、世界标准时间、国际协调时间。

[协调世界时 - 维基百科，自由的百科全书 (wikipedia.org)](https://zh.m.wikipedia.org/zh/协调世界时)

UTC + (+0800) =北京时间

Linux查看本地UTC时间：

```
date -u
Wed Oct  5 18:57:38 UTC 2022
```

就这东西使用闰秒，闰秒导致大面积宕机

[就因为这一秒钟，科技巨头吵了快十年 (qq.com)](https://view.inews.qq.com/k/20220823A06TQJ00?web_channel=wap&openApp=false)

#### CST时间

时间缩写，CST可视为美国、澳大利亚、古巴或中国的标准时间。

美国中部时间：Central Standard Time (USA) UT-6:00

澳大利亚中部时间：Central Standard Time (Australia) UT+9:30

中国标准时间：China Standard Time UT+8:00

古巴标准时间：Cuba Standard Time UT-4:00

#### GMT时间

格林尼治标准时间

格林威治平时 (GMT, Greenwich Mean Time) 作为世界时间标准（UT, Universal Time） 

GMT是前世界标准时，UTC是现世界标准时。

UTC 比 GMT更精准，以原子时计时，适应现代社会的精确计时。

但在不需要精确到秒的情况下，二者可以视为等同。     



#### RTC时间

RTC是芯片内置的硬件时钟，只要芯片不断电，即使操作系统关机的时候，RTC时钟也是正常在走的，所以当操作系统关机重启后，可通过读取RTC时间来更新系统时间。

查看RTC时间

```bash
hwclock -r
```



#### 系统时间

由内核维护的软件时钟。它是计算机上运行的应用程序使用的主时钟。

查看系统时间

```bash
date
```



### chrony 软件包 



```bash
[root@VM-0-16-centos ~]# yum install -y chrony
[root@VM-0-16-centos ~]# rpm -ql chrony-3.4-1.el7.x86_64
/etc/NetworkManager/dispatcher.d/20-chrony
/etc/chrony.conf
/etc/chrony.keys
/etc/dhcp/dhclient.d/chrony.sh
/etc/logrotate.d/chrony
/etc/sysconfig/chronyd
/usr/bin/chronyc
/usr/lib/systemd/ntp-units.d/50-chronyd.list
/usr/lib/systemd/system/chrony-dnssrv@.service
/usr/lib/systemd/system/chrony-dnssrv@.timer
/usr/lib/systemd/system/chrony-wait.service
/usr/lib/systemd/system/chronyd.service
/usr/libexec/chrony-helper
/usr/sbin/chronyd
/usr/share/doc/chrony-3.4
/usr/share/doc/chrony-3.4/COPYING
/usr/share/doc/chrony-3.4/FAQ
/usr/share/doc/chrony-3.4/NEWS
/usr/share/doc/chrony-3.4/README
/usr/share/man/man1/chronyc.1.gz
/usr/share/man/man5/chrony.conf.5.gz
/usr/share/man/man8/chronyd.8.gz
/var/lib/chrony
/var/lib/chrony/drift
/var/lib/chrony/rtc
/var/log/chrony
```



### chrony作为服务端

修改chrony的配置，然后启动即可

```bash
[root@VM-0-16-centos ~]# cat /etc/chrony.conf
server ntpupdate.tencentyun.com iburst
# 从哪个服务器上同步时间，格式为 server xxx.xxx.xxx [选项]
# 服务器可以通过其主机名或 IP 地址指定。如果无法在启动时解析主机名，chronyd 将每隔一段时间再次尝试
# 此指令可以多次用于指定多个服务器。
# 该指令支持以下选项：

# minpoll poll 
# 此选项将发送到服务器的请求之间的最小间隔指定为2次幂（以秒为单位）。例如，minpoll 5 意味着轮询间隔不应低于 32秒。默认值为6（64秒），最小值为-7（1/128 秒），最大值为24（6 个月）。请注意，短于6（64 秒）的间隔通常不应与 Internet 上的公共服务器一起使用，因为它可能被视为滥用。仅当服务器可访问且往返延迟短于 10 毫秒（即服务器应位于本地网络中）时，才会启用亚秒级间隔。

# maxpoll poll
# 此选项将发送到服务器的请求之间的最大间隔指定为2次幂（以秒为单位）。例如，maxpoll 9 表示轮询间隔应保持在或低于9（512 秒）。默认值为10（1024 秒），最小值为 -7（1/128 秒），最大值为 24（6 个月）。

# iburst
# chronyd 将从4-8个多个请求开始，以便更快地进行时钟的首次更新。它还会在每次使用 chronyc 中，从脱机状态切换到联机时也会用多个请求。

# burst
# chronyd 最多使用4个请求

# key ID
# NTP 协议支持消息身份验证代码 （MAC），以防止计算机因向其发送恶意数据包而导致系统时间中断

# nts
# 此选项启用使用网络时间安全性 （NTS） 机制的身份验证。


# certset ID
# 此选项指定在启用 nts 选项时应使用哪组受信任的证书来验证服务器的证书。 

# maxdelay
# maxdelay 0.3 表示应忽略往返延迟大于 0.3 秒的测量值。默认值为 3 秒，最大值为 1000 秒。

# offline
# 如果在启动 chronyd 时无法访问服务器，则可以指定这个脱机选项。chronyd 不会尝试轮询服务器，直到它能够这样做

# auto_offline
# 使用此选项，当发送请求失败时，服务器将被假定为已脱机，


driftfile /var/lib/chrony/drift
# 记录系统时钟获得/丢失时间的速率的文件

makestep 1.0 3
#如果偏移大于1秒，允许在前三次更新中调整系统时钟


rtcsync
# rtcsync 指令启用了一种模式，在该模式下，系统时间定期复制到 RTC,RTC时间可以通过hwclock -r查看。

#hwtimestamp *
# 在所有支持硬件时间戳的接口上启用硬件时间戳.

#minsources 2
# 指令设置在更新本地时钟之前，需要在源选择算法中被视为可选择的源的最小数目。默认值为 1。将此选项设置为较大的数字可用于提高可靠性。更多的源将不得不相互同意，并且当只有一个源（可能提供不正确的时间）可访问时，时钟将不会更新


allow 192.168.0.0/16
# allow 指令用于指定允许 NTP 客户端作为 NTP 服务器访问计算机的特定子网。它还控制在服务器上启用 NTS 时对 NTS-KE 客户端的访问。
# 默认设置是不允许任何客户端访问，即 chronyd 纯粹作为 NTP 客户端运行。如果使用 allow 指令，则 chronyd 既是其服务器的客户端，也是其他客户端的服务器。
# 此指令可以多次使用。读取的顺序从上到下


#local stratum 10
# local 指令启用了本地模式，即使没有与时间源同步，也要服务


#keyfile /etc/chrony.keys
# 密钥文件


logdir /var/log/chrony
# 此指令指定用于写入由 log 指令启用的日志文件的目录。如果该目录不存在，则将自动创建该目录。


#cmdport 323
#默认为323，用于监视chronyd的端口

#port 123
#当chronyd作为NTP服务器的时候打开的监听端口，ntp客户端会通过这个端口与chronyd服务器进行同步。默认值为 123，即标准 NTP 端口。如果设置为 0，chronyd 将永远不会打开服务器端口，并将严格在仅客户端模式下运行。

#log tracking
#把每次修改时间的记录写到tracking.log中去

```

更多配置细节请查看chrony官网：https://chrony.tuxfamily.org/doc/4.3/chrony.conf.html

启动chronyd

```bash
systemctl enable chronyd
systemctl restart chronyd
```



### chrony作为客户端

修改chrony的配置

```bash
[root@VM-0-16-centos ~]# cat /etc/chrony.conf
# 这里改成服务端的IP或者域名
server xxx.xxx.xxx iburst
```

启动chronyd

```bash
systemctl enable chronyd
systemctl restart chronyd
```

### chronyd命令



**语法**

```bash
 chronyd [选项]...[指令]...
```

**功能**

```bash
chronyd是用于同步系统时钟的守护进程。它可以将系统时间与NTP服务器，参考时钟（例如GPS接收器）同步，并通过chronyd使用键盘进行手动输入。它还可以作为 NTPv4 （RFC 5905）服务器运行，为网络中的其他计算机提供时间服务。
如果未在命令行上指定任何配置指令，chronyd 将从配置文件中读取它们。文件的编译默认位置是 /etc/chrony.conf。
信息性消息、警告和错误将记录到系统日志中。
```

**选项**

- -4
  使用此选项，主机名将仅解析为 IPv4 地址，并且仅创建 IPv4 套接字。

- -6
  使用此选项，主机名将仅解析为 IPv6 地址，并且仅创建 IPv6 套接字。

- -f 文件
  此选项可用于指定配置文件的备用位置。编译的默认值为 /etc/chrony.conf。

- -n
  在此模式下运行时，程序不会将自己与终端分离。

- -d
  在此模式下运行时，程序不会将自己与终端分离，并且所有消息都将写入终端而不是 syslog。如果 chronyd 是在启用调试支持的情况下编译的，则可以使用此选项两次来启用调试消息。

- -l 文件
  此选项允许将日志消息写入文件，而不是 syslog 或终端。

- -L 级
  此选项指定要写入日志文件、syslog 或终端的消息的最低严重性级别。可以指定以下级别：0（信息性）、1（警告）、2（非致命错误）和 3（致命错误）。默认值为 0。

- -p
  在此模式下运行时，chronyd 将打印配置并退出。它不会与终端分离。此选项可用于验证配置的语法并获取整个配置，即使它被拆分为多个文件并由 include 或 confdir 指令读取。

- -q
  在此模式下运行时，chronyd 将设置系统时钟一次并退出。它不会与终端分离。

- -Q
  此选项与 -q 选项类似，只是它只打印偏移量而不对时钟进行任何校正，并且它允许在没有 root 权限的情况下启动 chronyd。

- -r
  此选项将尝试重新加载并删除包含每个服务器的示例历史记录和正在使用的参考时钟的文件。这些文件应位于配置文件中的 dumpdir 指令指定的目录中。如果您出于任何原因（例如安装新版本）想要短暂停止并重新启动chronyd，则此选项很有用。但是，它应该只用于内核可以在不受时间控制的情况下保持时钟补偿的系统（即 Linux、FreeBSD、NetBSD、光源和 macOS 10.13 或更高版本）。

- -R
  使用此选项时，将忽略初始化同步指令和具有正限制的 maketep 指令。此选项在重新启动 chronyd 时很有用，可以与 -r 选项结合使用。

- -s
  此选项将设置系统时钟从计算机的实时时钟 （RTC） 或到 driftfile 指令指定的文件的上次修改时间。实时时钟仅在 Linux 上受支持。

  如果与 -r 标志结合使用，chronyd 将在从 RTC 设置系统时钟后尝试保留旧样本。这可用于允许 chronyd 在系统重新启动期间执行增益或损失率的长期平均，并且对于间歇性访问在不使用时关闭的网络的系统非常有用。为了使其正常工作，它依赖于chronyd能够确定上次计算机打开时RTC和系统时钟之间差异的准确统计信息。

  如果漂移文件的上次修改时间同时晚于当前时间和 RTC 时间，则系统时间将设置为该时间，以恢复之前停止 chronyd 的时间。这在没有RTC或RTC损坏（例如，它没有电池）的计算机上很有用。

- -t timeout
  此选项设置超时（以秒为单位），之后 chronyd 将退出。如果时钟未同步，它将以非零状态退出。这对于 -q 或 -Q 选项（用于缩短等待测量的最长时间）或 -r 选项（用于限制 chronyd 运行时间，但仍允许它调整系统时钟的频率）非常有用。

- -u user
  此选项设置 chronyd 在启动后将切换到的系统用户的名称，以便删除 root 权限。它覆盖用户指令。编译的默认值为 root。

  在 Linux 上，需要编译时支持库库。在 macOS 上，自由软件、网络操作系统和光源将时间分叉成两个进程。子进程保留 root 权限，但只能代表父进程执行非常有限的特权系统调用。

- -U
  此选项禁用对 root 权限的检查，以允许在非 root 用户下启动 chronyd，假设该进程将具有在指定配置中正确操作所需的所有功能（例如，由服务管理器提供）和对所有文件、目录和设备的访问权限。请注意，不同的配置和不同的 Linux 内核版本可能需要不同的功能。当配置未知时，不建议在非 root 用户下启动 chronyd，或者至少仅限于特定指令。

- -F level
  此选项配置由 chronyd 进程加载的系统调用筛选器（如果编译时支持 Linux 安全计算 （seccomp） 工具）。定义了三个级别：0、1、2.筛选器在级别 0 处禁用。在级别 1 和 2 中，如果 chronyd 发出被过滤器阻止的系统调用，则 chronyd 将被杀死。可以将电平指定为负数以触发 SIGSYS 信号，而不是 SIGKILL，这对于调试非常有用。默认值为 0。

  在级别 1 中，筛选器仅允许通常由 chronyd 进行的选定系统调用。其他系统调用被阻止。仅当已知此级别在安装了 chrony 的系统版本上有效时，才建议使用此级别。过滤器还需要允许 chronyd 正在使用的库（例如 libc）进行系统调用，但库的不同版本或实现可能会进行不同的系统调用。如果筛选器缺少系统调用，则即使在正常操作中也可能被终止 chronyd。

  在级别 2 中，筛选器仅阻止少量特定系统调用（例如分叉和 exec）。这种方法应该避免误报，但对系统免受受损的 chronyd 进程的保护要有限得多。

  不能使用邮件更改指令启用筛选器。

- -P 优先级
  在 Linux、FreeBSD、NetBSD 和光源上，此选项将以指定的优先级（必须在 0 到 100 之间）选择SCHED_FIFO实时调度程序。在 macOS 上，此选项的值必须为 0 才能禁用线程时间限制策略，或者其值为 1 才能启用策略。其他系统不支持此选项。默认值为 0。

- -m
  此选项将按时间顺序锁定到RAM中，以便永远不会分页。此模式仅在 Linux、自由软件、网络操作系统和光源上受支持。

- -x
  此选项禁用对系统时钟的控制。不会尝试对时钟进行任何调整。它将假设时钟是自由运行的，并且仍然跟踪其相对于估计真实时间的偏移量和频率。此选项允许在没有调整或设置系统时钟（例如在某些容器中）以作为NTP服务器运行的情况下启动chronyd。

- -v， --版本
  使用此选项，chronyd将打印版本号到终端并退出。

- -h， --帮助
  使用此选项，chronyd将向终端打印帮助消息并退出。

详细信息查询：https://chrony.tuxfamily.org/doc/4.3/chronyd.html



### chronyc命令

**语法**

```bash
 chronyc [选项]...[指令]...
```



**功能**

```bash
chronyc是一个命令行界面程序，可用于监视chronyd的性能，并在运行时更改各种操作参数。如果未在命令行上指定任何命令，chronyc将期望来自用户的输入。从终端运行时将显示 chronyc> 。如果 chronyc 的输入或输出从文件重定向到文件或重定向到文件，则不会显示提示。
```



选项

- -4
  使用此选项，主机名将仅解析为 IPv4 地址。

- -6
  使用此选项，主机名将仅解析为 IPv6 地址。

- -n
  此选项禁用将 IP 地址解析为主机名，例如，以避免缓慢的 DNS 查找。长地址不会被截断以适合该列。

- -N
  此选项允许打印配置文件或 chronyc 命令中指定的 NTP 源的原始主机名或 IP 地址。如果没有 -n 和 -N 选项，则打印的主机名是从反向 DNS 查找中获取的，并且可以与指定的主机名不同。

- -c
  此选项允许以逗号分隔值 （CSV） 格式打印报表。反向 DNS 查找将被禁用，时间将打印为自 epoch 以来的秒数，并且以秒为单位的值将不会转换为其他单位。例如 chronyc  -c tracking 会把结果打印成CSV格式

- -d
  如果 chronyc 是在调试支持下编译的，则此选项允许打印调试消息。

- -m
  通常，命令行上的所有参数都被解释为一个命令。使用此选项可以指定多个命令。每个参数将被解释为一个完整的命令。

- -h 主机
  此选项指定要按时间顺序联系的主机。可以使用主机名、IP 地址或本地 Unix 域套接字的路径来指定它。可以将多个值指定为逗号分隔的列表以提供回退。

  默认值为 */var/run/chrony/chronyd.sock,127.0.0.1,::1*，即运行时间轴的主机。首先，它尝试连接到Unix域套接字，如果失败（例如，由于在非root用户下运行），它将尝试连接到127.0.0.1，然后是::1。

- -p 端口
  此选项允许用户指定目标时间轴用于其监视连接的 UDP 端口号。这默认为323；很少需要改变这一点。

- -f 文件
  此选项将被忽略，仅为兼容性而提供。

- -a
  此选项将被忽略，仅为兼容性而提供。

- -v， --版本
  使用此选项，chronyc在终端上显示其版本号并退出。

- --帮助
  使用此选项，chronyc 会在终端上显示一条帮助消息并退出。



更多细节查看：https://chrony.tuxfamily.org/doc/4.3/chronyd.html



#### chronyc支持的指令



##### **tracking**

```bash
# chronyc tracking
Reference ID    : CB00710F (foo.example.net)
Stratum         : 3
Ref time (UTC)  : Fri Jan 27 09:49:17 2017
System time     : 0.000006523 seconds slow of NTP time
Last offset     : -0.000006747 seconds
RMS offset      : 0.000035822 seconds
Frequency       : 3.225 ppm slow
Residual freq   : -0.000 ppm
Skew            : 0.129 ppm
Root delay      : 0.013639022 seconds
Root dispersion : 0.001100737 seconds
Update interval : 64.2 seconds
Leap status     : Normal
```

###### tracking结果解释

**Reference ID**

这是计算机当前同步到的服务器的引用 ID 或者名称（或 IP 地址，域名），如果引用 ID 为 *7F7F0101* 并且没有名称或 IP 地址，则表示计算机未同步到任何外部源

**Stratum**

该层表示我们距离连接了参考时钟的计算机有多少跃点，本机算一个点。

**Ref time**

这是处理来自参考源的最后一次测量的时间 （UTC）。

**System time**

这是 NTP 时钟和系统时钟之间的偏移。NTP 服务器为 NTP 客户端提供时间。系统时钟与 NTP 时钟同步。为了避免系统时间中的步骤（这可能会对某些应用程序产生负面影响），通常只能通过加速或减慢来校正系统时钟。如果偏移量太大，此校正将花费很长时间。可以通过 [**maketep**](https://chrony.tuxfamily.org/doc/4.3/chronyc.html#makestep) 命令或配置文件中的 [**maketep**](https://chrony.tuxfamily.org/doc/4.3/chrony.conf.html#makestep) 指令强制执行步骤。

请注意，**chronyc** 报告的所有其他偏移量和日志文件中的大多数偏移量都是相对于 NTP 时钟的，而不是相对于系统时钟的。

**Last offset**

这是上次时钟更新时估计的本地偏移量。正值表示本地时间（如前所述估计的真实时间）早于时间源。

**RMS offset**

这是偏移值的长期平均值。

**Frequency**

“频率”是系统时钟出错的速率，如果**chronyd**没有纠正它。它以 ppm（百万分之几）表示。例如，1 ppm 的值意味着当系统时钟认为它已经前进了 1 秒时，它实际上相对于真实时间前进了 1.000001 秒。

**Residual freq**

这显示了当前所选参考源的“残余频率”。这反映了参考源的测量值指示的频率与当前使用的频率之间的任何差异。

**Skew**

这是频率上绑定的估计误差。

**Root delay**

这是从上一跳到此计算机的网络路径延迟

**Root dispersion**

这是网络路径延迟的总和。

**Update interval**

这是最近两次时钟更新之间的间隔。 真正对系统时间更改的两次间隔，每次时间更改，可以通过在配置文件中，添加log  tracking 选项，可以把每次时间更改的记录写到tracking.log去

**Leap status**

这是跳跃状态，可以是`正常` Normal 、`插入第二` Insert second、`删除秒` Delete second 或 `未同步` Not synchronised。



##### **sources** [**-a**] [**-v**]

**功能**

```bash
此命令显示有关 chronyd 正在访问的当前时间源的信息。

如果指定了 -a 选项，则显示所有源，包括尚无已知地址的源。此类源具有 ID#XXXXXXXXXX 格式的标识符，可用于需要源地址的其他命令。

-v 选项启用详细输出。在这种情况下，将显示额外的标题行作为列含义的提醒。
```



```bash
# chronyc sources -a
MS Name/IP address         Stratum Poll Reach LastRx Last sample
===============================================================================
#* GPS0                          0   4   377    11   -479ns[ -621ns] +/-  134ns
^? foo.example.net               2   6   377    23   -923us[ -924us] +/-   43ms
^+ bar.example.net               1   6   377    21  -2629us[-2619us] +/-   86ms
```



###### sources命令解释

**M**

这表示源的模式。*^* 表示服务器，*=* 表示对等方，*#* 表示本地连接的参考时钟。

**S**

此列指示源的选择状态。

- ***表示当前选择进行同步的最佳源。

- *+*表示选择进行同步的其他源，这些源与最佳源相结合。

- *-*表示被视为可选择进行同步但当前未选择的源。

- *x*表示**chronyd**认为是虚假标记的来源（即其时间与大多数其他来源或使用**信任**选项指定的来源不一致）。

- *~*表示其时间似乎具有太大可变性的来源。

- *？*表示由于其他原因（例如，无法访问、未同步或没有足够的测量值）而被认为无法选择同步的源。

  

**Name/IP address**

这将显示源的名称或 IP 地址，或参考时钟的引用 ID。

**Stratum**

这显示了来源层，如最近收到的样本中所报告的那样。第 1 层表示具有本地连接的参考时钟的计算机。与第 1 层计算机同步的计算机位于第 2 层。与第 2 层计算机同步的计算机位于第 3 层，依此类推。

**Poll**

这将显示轮询源的速率，以间隔的 2 为底数（以秒为单位）。因此，值为 6 表示每 64 秒进行一次测量。**chronyd** 会根据当前条件自动改变轮询率。

**Reach**

这显示了打印为八进制数的源的可访问性寄存器。寄存器有8位，并在从源接收或丢失的每个数据包上更新。值为 377 表示已收到最近八次传输中所有传输的有效回复。

**LastRx**

此列显示从源接收到最后一个良好样本（显示在下一列中）的时间。某些测试失败的测量值将被忽略。这通常以秒为单位。字母 *m*、*h*、*d* 或 *y* 表示分钟、小时、天或年。

**Last sample**

此列显示上次测量时本地时钟与源之间的偏移。方括号中的数字表示实际测量的偏移量。这可以由 *ns*（表示纳秒）、*us*（表示微秒）、*毫秒*（表示毫秒）或 *s*（表示秒）后缀。方括号左侧的数字显示了原始测量值，经过调整以允许自那时以来应用于本地时钟的任何压摆率。*+/-* 指标后面的数字显示测量中的边际误差。正偏移表示本地时钟早于源时钟。



##### **sourcestats** [**-a**] [**-v**]

**功能**

```bash
sourcestats 命令显示有关 chronyd 当前正在检查的每个源的漂移率和偏移估计过程的信息。

如果指定了 -a 选项，则显示所有源，包括尚无已知地址的源。此类源具有 ID#XXXXXXXXXX 格式的标识符，可用于需要源地址的其他命令。

-v 选项启用详细输出。在这种情况下，将显示额外的标题行作为列含义的提醒。
```



```bash
# chronyc sourcestats -a
Name/IP Address            NP  NR  Span  Frequency  Freq Skew  Offset  Std Dev
===============================================================================
foo.example.net            11   5   46m     -0.001      0.045      1us    25us
```



**Name/IP Address**

这是 NTP 服务器的名称或 IP 地址，或参考时钟的引用 ID。

**NP**

这是当前为服务器保留的采样点数。

**NR**

这是在最后一次回归后具有相同符号的残差运行次数。如果此数字相对于样本数开始变得太小，则表明直线不再适合数据。如果运行次数太少，**chronyd** 将丢弃较旧的样本并重新运行回归，直到运行次数变得可接受。

**Span**

这是最旧和最新样本之间的间隔。如果未显示单位，则该值以秒为单位。在此示例中，间隔为 46 分钟。

**Frequency**

这是服务器的估计残余频率，以百万分之一为单位。在这种情况下，计算机的时钟相对于服务器估计运行速度慢 10^9 中的 1 部分。

**Freq Skew**

这是 **Freq** 上的估计误差边界（同样以百万分之一为单位）。

**Offset**

这是源的估计偏移量。

**Std Dev**

这是估计的样本标准差。





##### **maketep**

立即同步(需要在chrony较高的版本中才行)

```bash
#chronyc makestep
200 OK
```



##### **activity**

功能

```bash
此命令报告联机的数量。
```

```bash
# chronyc activity 
200 OK
1 sources online
0 sources offline
0 sources doing burst (return to online)
0 sources doing burst (return to offline)
0 sources with unknown address
```



###### activity结果解释

**online**

服务器或对等方当前处于联机状态（即由 **chronyd** 假定为可访问）

**offline**

服务器或对等体当前处于脱机状态（即由 **chronyd** 假定为无法访问）

**burst_online**

已为服务器启动突发命令，并且正在执行该命令;突发完成后，服务器或对等方将返回到联机状态。

**burst_offline**

已为服务器启动突发命令，并且正在执行该命令;突发完成后，服务器或对等方将返回到脱机状态。

**unresolved**

服务器或对等方的名称尚未解析为地址;此来源在**来源**和**来源统计**报告中不可见。



更多细节查看：https://chrony.tuxfamily.org/doc/4.3/chronyc.html



## 其他知识



#### date命令

打印或设置系统日期和时间

**语法**

```bash
       date [选项]... [+格式]
       date [选项] [MMDDhhmm[[CC]YY][.ss]]
```

**功能**

```bash
 根据指定格式显示当前时间或设置系统时间.
```



- -d, --date=STRING

  显示由 STRING 指定的时间, 而不是当前时间

- -f, --file=DATEFILE

  显示 DATEFILE 中每一行指定的时间, 如同将 DATEFILE 中的每行作为 --date 的参数一样

- -I, --iso-8601[=TIMESPEC] 按照 ISO-8601 的日期/时间格式输出时间.

  TIMESPEC=`date`  (或者不指定时)仅输出日期,等于  `hours`, `minutes`,`seconds`时按照指定精度输出日期及时间。

- -r, --reference=FILE
  显示 FILE 的最后修改时间

- -R, --rfc-822
  根据 RFC-822 指定格式输出日期

- -s, --set=STRING

  根据 STRING 设置时间

-  -u, --utc, --universal

  显示或设置全球时间(格林威治时间)

- --help 显示本帮助文件并退出

- --version

  显示版本信息并退出

- 格式 FORMAT 控制着输出格式. 仅当选项指定为全球时间时本格式才有效。 分别解释如下:

  %%     文本的 %

  %a     当前区域的星期几的简写 (Sun..Sat)

  %A     当前区域的星期几的全称 (不同长度) (Sunday..Saturday)

  %b     当前区域的月份的简写 (Jan..Dec)

  %B     当前区域的月份的全称(变长) (January..December)

  %c     当前区域的日期和时间 (Sat Nov 04 12:02:33 EST 1989)

  %d     (月份中的)几号(用两位表示) (01..31)

  %D     日期(按照 月/日期/年 格式显示) (mm/dd/yy)

  %e     (月份中的)几号(去零表示) ( 1..31)

  %h     同 %b

  %H     小时(按 24 小时制显示，用两位表示) (00..23)

  %I     小时(按 12 小时制显示，用两位表示) (01..12)

  %j     (一年中的)第几天(用三位表示) (001..366)

  %k     小时(按 24 小时制显示，去零显示) ( 0..23)

  %l     小时(按 12 小时制显示，去零表示) ( 1..12)

  %m     月份(用两位表示) (01..12)

  %M     分钟数(用两位表示) (00..59)

  %n     换行

  %p     当前时间是上午 AM 还是下午 PM

  %r     时间,按 12 小时制显示 (hh:mm:ss [A/P]M)

  %s     从 1970年1月1日0点0分0秒到现在历经的秒数 (GNU扩充)

  %S     秒数(用两位表示)(00..60)

  %t     水平方向的 tab 制表符

  %T     时间,按 24 小时制显示(hh:mm:ss)

  %U     (一年中的)第几个星期，以星期天作为一周的开始(用两位表示) (00..53)

  %V     (一年中的)第几个星期，以星期一作为一周的开始(用两位表示) (01..52)

  %w     用数字表示星期几 (0..6); 0 代表星期天

  %W     (一年中的)第几个星期，以星期一作为一周的开始(用两位表示) (00..53)

  %x     按照 (mm/dd/yy) 格式显示当前日期

  %X     按照 (%H:%M:%S) 格式显示当前时间

  %y     年的后两位数字 (00..99)

  %Y     年(用 4 位表示) (1970...)

  %z     按照 RFC-822 中指定的数字时区显示(如, -0500) (为非标准扩充)

  %Z     时区(例如, EDT (美国东部时区)), 如果不能决定是哪个时区则为空 

  默认情况下,用 0 填充数据的空缺部分.  GNU 的 date 命令能分辨在 `%'和数字指示之间的以下修改.

  `-` (连接号) 不进行填充 `_`(下划线) 用空格进行填充



#### hwclock命令



**语法**

```bash
hwclock [功能] [选项...]
```

**功能**

```bash
hwclock是一个时钟管理工具。它可以：显示硬件时钟时间；将硬件时钟设置为指定时间；从系统时钟设置硬件时钟；设定来自硬件时钟的系统时钟；硬件补偿时钟漂移；更正系统时钟时间刻度；设置内核的时区、NTP 时间刻度和纪元（仅限 Alpha）；并预测基于其漂移率的未来硬件时钟值
```



```bash
 -h, --help           显示此帮助并退出
 -r, --show           读取硬件时钟并打印结果
     --set            将 RTC 设置为 --date 指定的时间
 -s, --hctosys        从硬件时钟设置系统时间
 -w, --systohc        从当前系统时间设置硬件时钟
     --systz          基于当前时区设置系统时间
     --adjust         根据自上次时钟设置或调整后的系统漂移
                        来调整 RTC
 -c, --compare        定期将系统时钟与 CMOS 时钟相比较
     --getepoch       打印内核的硬件时钟纪元(epoch)值
     --setepoch       将内核的硬件时钟纪元(epoch)值设置为
                        --epoch 选项指定的值
     --predict        预测 --date 选项所指定时刻读取到的 RTC 值
 -V, --version        显示版本信息并退出

选项：
 -u, --utc            硬件时钟保持为 UTC 时间
     --localtime      硬件时钟保持为本地时间
 -f, --rtc <文件>     代替默认文件的特殊 /dev/... 文件
     --directisa      直接访问 ISA 总线，而非 /dev/rtc
     --badyear        忽略  RTC 年份(由于 BIOS 损坏)
     --date <时间>    指定要设置的硬件时钟时间
     --epoch <年>     指定作为硬件纪元(epoch)值起始的年份
     --noadjfile      不访问 /etc/adjtime；需要使用 --utc 或 --localtime 选项
     --adjfile <文件> 指定调整文件的路径；
                        默认为 /etc/adjtime
     --test           不更新，只显示将进行什么操作
 -D, --debug          调试模式

--version：显示版本信息。
```


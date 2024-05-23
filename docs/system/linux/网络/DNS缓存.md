当网络条件不好时，可以设置DNS缓存提高DNS查询速度



在 CentOS 7 上设置 DNS 缓存可以通过安装和配置名为 `dnsmasq` 的服务来实现。`dnsmasq` 是一个轻量级的 DNS 服务器，它可以为本地系统提供 DNS 缓存功能，从而加快域名解析速度并减少对上游 DNS 服务器的请求。下面是如何在 CentOS 7 上安装和配置 `dnsmasq` 的步骤：

### 安装 dnsmasq
1. 打开终端。
2. 使用以下命令安装 `dnsmasq`：
   ```bash
   sudo yum install dnsmasq
   ```

### 配置 dnsmasq
1. 安装完成后，编辑 `dnsmasq` 的配置文件。使用你喜欢的文本编辑器打开 `/etc/dnsmasq.conf`，例如：
   ```bash
   sudo vi /etc/dnsmasq.conf
   ```

2. 在配置文件中添加或修改以下行来启用 DNS 缓存：
   ```bash
   # 启用 DNS 缓存功能
   cache-size=1000
   # 添加或取消注释以下行来启用日志记录：
   log-queries
   log-facility=/var/log/dnsmasq.log
   
   # min-cache-ttl ：这个设置指定了缓存条目的最小TTL值（以秒为单位）。当从上游DNS服务器接收到的TTL值低于此设置时，`dnsmasq` 会自动将TTL调整到这个最小值。这可以防止某些动态DNS配置过于频繁地导致缓存失效。
   min-cache-ttl=300
   # max-cache-ttl ：这个设置指定了缓存条目的最大TTL值。这对于限制长时间存储缓存条目特别有用，可以防止过时的DNS信息长时间保留在缓存中。
   max-cache-ttl=3600
   ```
   这里的 `cache-size=1000` 表示缓存大小，你可以根据需要调整这个值。
   
   

### 设置 dnsmasq 为系统的 DNS 服务
1. 为了让系统通过 `dnsmasq` 解析所有 DNS 请求，需要更改系统的 DNS 设置。编辑 `/etc/resolv.conf` 文件：
   ```bash
   sudo vi /etc/resolv.conf
   ```
   
2. 修改或添加以下行，设置 `dnsmasq` 作为本地 DNS 解析器（确保这是文件中的第一行）：
   ```
   nameserver 127.0.0.1
   ```

### 启动 dnsmasq 服务
1. 启动 `dnsmasq` 服务：
   ```bash
   sudo systemctl start dnsmasq
   ```
2. 设置 `dnsmasq` 服务开机自启：
   ```bash
   sudo systemctl enable dnsmasq
   ```

### 测试配置
1. 使用 `dig` 或 `nslookup` 命令测试 DNS 解析是否正常：
   ```bash
   dig example.com
   ```

2. 第一次查询会稍慢，因为 `dnsmasq` 需要从上游 DNS 服务器获取数据并缓存。之后的查询应该会明显快很多，因为数据会从本地缓存中获取。

   如果从缓存中查询到了地址，那么就会缓存被命中

   ```bash
   # sudo grep "cached" /var/log/dnsmasq.log
   Apr 28 19:08:54 dnsmasq[4061579]: cached www.baidu.com is <CNAME>
   ```


这样，你就成功在 CentOS 7 系统上设置了 DNS 缓存，应该能有效提高域名解析的速度和效率。如果你遇到任何问题，可以重查配置或检查 `dnsmasq` 的状态和日志以确保一切正常运行。















下面是 `dnsmasq` 配置文件的格式保持不变的翻译：





```
# dnsmasq的配置文件。
#
# 格式为每行一个选项，有效选项与命令行上的长选项相同。详情见
# "/usr/sbin/dnsmasq --help" 或 "man 8 dnsmasq"。

# 在标准DNS端口（53）之外的特定端口上监听
# （53）。将此设置为零会完全禁用DNS功能，
# 仅留下DHCP和/或TFTP。
#port=5353

# 下面两个选项使你成为一个更好的网络公民，因为它们
# 告诉dnsmasq过滤掉公共DNS无法回答的查询，
# 并且不必要地加载服务器（尤其是根服务器）。
# 如果你有按需拨号连接，它们还能阻止
# 这些请求不必要地建立连接。

# 从不转发没有点或域部分的纯名称
#domain-needed
# 从不转发非路由地址空间中的地址。
#bogus-priv

# 取消注释这些以启用DNSSEC验证和缓存：
# (需要dnsmasq编译时包含DNSSEC选项。)
#conf-file=/usr/share/dnsmasq/trust-anchors.conf
#dnssec

# 没有DNSSEC签名的回复可能是合法的，因为该域
# 未签名，或可能是伪造的。设置此选项告诉dnsmasq
# 检查未签名回复是否可以接受，方法是找到一个安全证明
# 表明从根到该域之间某处的DS记录不存在。
# 设置此项的代价是即使在未签名的域中的查询也需要
# 一个或多个额外的DNS查询来验证。
#dnssec-check-unsigned

# 取消注释此项以过滤无用的Windows起源DNS请求
# 这可能无缘无故触发按需连接。
# 注意这（在其他事项中）会阻塞所有SRV请求，
# 因此如果你使用例如Kerberos, SIP, XMPP或Google-talk，
# 则不要使用它。
# 这个选项仅影响转发，SRV记录由
# dnsmasq（通过srv-host=行）产生的不受其影响。
#filterwin2k

# 如果你希望dns从其他地方获取其上游服务器
# 而不是/etc/resolv.conf
#resolv-file=

# 默认情况下，dnsmasq会向它所知道的任何上游
# 服务器发送查询，并尝试优先考虑已知的
# 运行中的服务器。取消注释此项强制dnsmasq
# 尝试按/etc/resolv.conf中出现的顺序
# 严格地对每个查询的每个服务器进行尝试。
#strict-order

# 如果你不希望dnsmasq读取/etc/resolv.conf或任何其他
# 文件，而是从这个文件中获取其服务器（见下文），那么
# 取消注释这一行。
#no-resolv

# 如果你不希望dnsmasq轮询/etc/resolv.conf或其他解析
# 文件的变化并重新读取它们，那么取消注释这一行。
#no-poll

# 在这里添加其他名称服务器，带有域规范，如果它们是为
# 非公共域。
#server=/localnet/192.168.0.1

# 例子，将PTR查询路由到名称服务器：这会发送所有
# 地址->名称查询192.168.3/24到名称服务器10.1.2.3
#server=/3.168.192.in-addr.arpa/10.1.2.3

# 在这里添加仅本地域，这些域的查询
# 从/etc/hosts或DHCP仅回答查询。
#local=/localnet/

# 在这里添加你想要强制转到IP地址的域。
# 下面的例子把double-click.net的任何主机都发送到一个本地
# web-server。
#address=/double-click.net/127.0.0.1

# --address (和 --server) 也适用于IPv6地址。
#address=/www.thekelleys.org.uk/fe80::20d:60ff:fe36:f83

# 将yahoo.com, google.com及其子域的所有查询IP
# 添加到vpn和search ipsets:
#ipset=/yahoo.com/google.com/vpn,search

# 你可以控制dnsmasq如何与服务器对话：这强制
# 通过eth1路由到10.1.2.3的查询
# server=10.1.2.3@eth1

# 这将设置与10.1.2.3通话的源（即本地）地址
# 为192.168.1.1 端口 55（显然，机器上必须有一个
# 该IP的接口）。
# server=10.1.2.3@192.168.1.1#55

# 如果你希望dnsmasq更改启动后的uid和gid
# 为其他默认值，请编辑以下行。
user=dnsmasq
group=dnsmasq

# 如果你希望dnsmasq仅在指定的接口上监听
# DHCP和DNS请求（和loopback），请在这里给出
# 接口的名称（例如eth0）。
# 重复该行以包括多个接口。
#interface=
# 默认情况下仅在localhost上监听
interface=lo
# 或者你可以指定_不_监听的接口
#except-interface=
# 或者通过地址指定监听的接口（记住包括127.0.0.1
# 如果你使用这个。）
#listen-address=
# 如果你希望dnsmasq仅在一个接口上提供DNS服务，
# 如上所示配置它，然后使用以下行来
# 禁用其上的DHCP和TFTP。
#no-dhcp-interface=

# 仅为直接连接到本机的网络提供DNS和DHCP服务。
# 任何interface=行将覆盖它。
#local-service

# 在支持的系统上，dnsmasq绑定通配地址，
# 即使它只监听某些接口。然后它丢弃
# 不应答复的请求。这样做的好处是
# 即使接口来来去去且更改地址也能工作。如果你
# 希望dnsmasq真正只绑定它正在监听的接口，
# 取消注释这个选项。大约唯一需要这个的时候是当
# 同一台机器上运行另一个名称服务器。
#
# 要只在localhost上监听并不接收其他
# 接口的数据包，请仅绑定到lo设备。注释掉以在单个
# 通配符套接字上绑定。
bind-interfaces

# 如果你不希望dnsmasq读取/etc/hosts，取消注释
# 下面这行。
#no-hosts
# 或者如果你希望它读取另一个文件以及/etc/hosts，使用
# 这个。
#addn-hosts=/etc/banner_add_hosts

# 如果你希望dnsmasq自动将域添加到hosts-file中的简单名称中，
# 设置此项（和domain: 见下文）。
#expand-hosts

# 为dnsmasq设置域。这是可选的，但如果设置，
# 它将做以下几件事情。
# 1) 允许DHCP主机拥有完全合格的域名，只要域部分与此设置匹配。
# 2) 设置“域”DHCP选项，从续而潜在地设置所有通过DHCP配置的系统的域
# 3) 为“expand-hosts”提供域部分
#domain=thekelleys.org.uk

# 为特定子网设置不同的域
#domain=wireless.thekelleys.org.uk,192.168.2.0/24

# 同样的概念，但使用范围而不是子网
#domain=reserved.thekelleys.org.uk,192.68.3.100,192.168.3.200

# 取消注释这个以启用集成的DHCP服务器，你需要
# 提供可供租赁的地址范围，以及可选的
# 租赁时间。如果你有多个网络，你将需要
# 为每个网络重复这一设置以提供DHCP服务。
#dhcp-range=192.168.0.50,192.168.0.150,12h

# 这是一个DHCP范围的示例，其中给出了子网掩码。这是
# 需要通过中继代理到达dnsmasq DHCP服务器的网络所需的。
# 如果你不知道DHCP中继代理是什么，你可能
# 不需要担心这个。
#dhcp-range=192.168.0.50,192.168.0.150,255.255.255.0,12h

# 这是一个设置了标签的DHCP范围的示例，
# 因此某些DHCP选项可能只为这个网络设置。
#dhcp-range=set:red,192.168.0.50,192.168.0.150

# 当标签"green"被设置时，使用这个DHCP范围。
#dhcp-range=tag:green,192.168.0.50,192.168.0.150,12h

# 指定一个子网不能用于动态地址分配，
# 仅为与--dhcp-host行匹配的主机可用。注意
# 除非有某种类型的dhcp-range为该子网，
# 否则dhcp-host声明将被忽略。
# 在这种情况下子网掩码是隐含的（它来自
# 运行dnsmasq的机器上的网络配置），可以指定
# 一个明确的子网掩码。
#dhcp-range=192.168.0.0,static

# 启用DHCPv6。注意不需要指定前缀长度
# 默认情况下如果缺失则为64。
#dhcp-range=1234::2, 1234::500, 64, 12h

# 进行路由通告，但不为这个子网做DHCP。
#dhcp-range=1234::, ra-only

# 进行路由通告，但不为这个子网做DHCP，同时尝试
# 为SLAAC配置的双栈主机的IPv6地址添加名称。
# 使用DHCPv4租约来推导名称，网络段和
# MAC地址，并假设该主机也会有一个
# 使用SLAAC算法计算的IPv6地址。
#dhcp-range=1234::, ra-names

# 进行路由通告，但不为这个子网做DHCP。
# 设置生命周期为46小时。（注意：最小生命周期为2小时。）
#dhcp-range=1234::, ra-only, 48h

# 为这个子网做DHCP和路由通告。在RA中设置A位，
# 这样客户端可以使用SLAAC地址和DHCP地址。
#dhcp-range=1234::2, 1234::500, slaac

# 进行路由通告和无状态DHCP为这个子网。客户端不会
# 从DHCP获得地址，但它们会获得其他配置信息。
# 它们将使用SLAAC来获得地址。
#dhcp-range=1234::, ra-stateless

# 进行无状态DHCP、SLAAC，并从DHCPv4租约生成
# SLAAC地址的DNS名称。
#dhcp-range=1234::, ra-stateless # ra-names

# 对于所有进行DHCPv6的子网做路由通告
# 除非被ra-stateless, ra-names等覆盖，路由通告会
# 设置M和O位，使得客户端从DHCPv6获取地址和配置，
# 并重置A位，所以客户端不使用SLAAC地址。
#enable-ra

# 使用DHCP为指定主机提供参数。有很多
# 有效的替代方案，因此我们将给出每个的示例。注意
# IP地址不必在上面给出的范围内，它们只需要
# 在同一网络上。这些参数的顺序无关紧要，可以任意
# 顺序给出名称、地址和MAC。

# 始终为具有以太网地址 11:22:33:44:55:66 的主机分配
# IP地址 192.168.0.60
#dhcp-host=11:22:33:44:55:66,192.168.0.60

# 始终将硬件地址为 11:22:33:44:55:66 的主机的名称
# 设置为 "fred"
#dhcp-host=11:22:33:44:55:66,fred

# 始终给以太网地址为 11:22:33:44:55:66 的主机
# 名称fred和IP地址192.168.0.60，并且租约时间为45分钟
#dhcp-host=11:22:33:44:55:66,fred,192.168.0.60,45m

# 给具有以太网地址 11:22:33:44:55:66 或
# 12:34:56:78:90:12 的主机 IP 地址 192.168.0.60。
# Dnsmasq 会假设这两个以太网接口不会同时使用，
# 并即使第一个正在使用该 IP 地址也会给第二个分配 IP 地址。
# 对于具有有线和无线地址的笔记本电脑很有用。
#dhcp-host=11:22:33:44:55:66,12:34:56:78:90:12,192.168.0.60

# 给声称其名称为 "bert" 的机器 IP 地址
# 192.168.0.70 和一个无限期租约
#dhcp-host=bert,192.168.0.70,infinite

# 始终给具有客户端标识符 01:02:02:04 的主机
# IP地址 192.168.0.60
#dhcp-host=id:01:02:02:04,192.168.0.60

# 始终给具有 InfiniBand 硬件地址
# 80:00:00:48:fe:80:00:00:00:00:00:00:f4:52:14:03:00:28:05:81 的
# ip地址 192.168.0.61。客户端ID来源于前缀
# ff:00:00:00:00:00:02:00:00:02:c9:00 和硬件地址的最后8对
# 十六进制数字。
#dhcp-host=id:ff:00:00:00:00:00:02:00:00:02:c9:00:f4:52:14:03:00:28:05:81,192.168.0.61

# 始终给客户端标识符为 "marjorie" 的主机
# IP地址 192.168.0.60
#dhcp-host=id:marjorie,192.168.0.60

# 启用“judge”在/etc/hosts中的地址
# 给呈现名称“judge”的机器，当
# 它请求一个DHCP租约。
#dhcp-host=judge

# 永不向以太网
# 地址为 11:22:33:44:55:66 的机器提供DHCP服务
#dhcp-host=11:22:33:44:55:66,ignore

# 忽略具有以太网地址 11:22:33:44:55:66 的机器提供的任何客户端ID。
# 这有助于在机器在不同操作系统下运行或
# 在PXE引导与操作系统引导之间防止机器被不同对待。
#dhcp-host=11:22:33:44:55:66,id:*

# 向设置了"red"标签的主机发送额外的选项，
# 其以太网地址为 11:22:33:44:55:66
#dhcp-host=11:22:33:44:55:66,set:red

# 向任何以太网地址开始为11:22:33:的机器发送额外的选项，
# 设置了"red"标签
#dhcp-host=11:22:33:*:*:*,set:red

# 给具有DUID 00:01:00:01:16:d2:83:fc:92:d4:19:e2:d8:b2的客户端
# 固定IPv6地址和名称，注意MAC地址不能用于识别DHCPv6客户端。
# 还要注意必须在IPv6地址周围使用[]。
#dhcp-host=id:00:01:00:01:16:d2:83:fc:92:d4:19:e2:d8:b2, fred, [1234::5] 

# 忽略任何未在dhcp-host行中指定或/etc/ethers中的客户端。
# 相当于ISC的"deny unknown-clients"。
# 这依赖于特殊的"known"标签，当
# 匹配主机时会设置。
#dhcp-ignore=tag:!known

# 向包含子字符串"Linux"的DHCP vendorclass字符串的任何机器发送额外的选项
#dhcp-vendorclass=set:red,Linux

# 向其中一个DHCP userclass字符串包含子字符串"accounts"的任何机器发送额外的选项
#dhcp-userclass=set:red,accounts

# 向MAC地址符合模式的任何机器发送额外的选项。
#dhcp-mac=set:red,00:60:8C:*:*:*

# 如果取消注释此行，dnsmasq将读取/etc/ethers并执行
# 以太网地址/IP对，就像它们已经
# 作为--dhcp-host选项给出一样。如果你保持
# MAC地址/主机映射在那里出于其他目的有用。
#read-ethers

# 向请求DHCP租约的主机发送选项。
# 详见RFC 2132了解可用选项。
# 常见选项可以通过名称给dnsmasq：
# 运行 "dnsmasq --help dhcp" 获得列表。
# 注意所有常见设置，如网络掩码和
# 广播地址、DNS服务器和默认路由，都被dnsmasq赋予
# 合理的默认值。你很可能不需要
# 任何dhcp-options。如果你使用Windows客户端和Samba，有一些
# 推荐的选项，它们详细说明在本节的
# 末尾。

# 覆盖dnsmasq提供的默认路由，该默认路由假设路由器
# 是运行dnsmasq的同一台机器。
#dhcp-option=3,1.2.3.4

# 做同样的事情，但使用选项名称
#dhcp-option=option:router,1.2.3.4

# 覆盖dnsmasq提供的默认路由并根本不发送默认路由。
# 注意这仅适用于默认发送的选项（1, 3, 6, 12, 28）
# 相同行将为所有其他选项编号发送零长度选项。
#dhcp-option=3

# 将NTP时间服务器地址设置为192.168.0.4和10.10.0.5
#dhcp-option=option:ntp-server,192.168.0.4,10.10.0.5

# 发送DHCPv6选项。注意IPv6地址周# 围需要用[]括起来。
#dhcp-option=option6:dns-server,[1234::77],[1234::88]

# 将作为机器运行dnsmasq的机器和另一台机器的名称服务器发送DHCPv6选项。
#dhcp-option=option6:dns-server,[::],[1234::88]

# 要求客户端每六小时轮询一次选项变更。（RFC4242）
#dhcp-option=option6:information-refresh-time,6h

# 设置选项58客户端续租时间（T1）。默认为租约时间的一半，如果未指定。（RFC2132）
#dhcp-option=option:T1,1m

# 设置选项59重新绑定时间（T2）。默认为租约时间的7/8，如果未指定。（RFC2132）
#dhcp-option=option:T2,2m

# 将NTP时间服务器地址设置为运行dnsmasq的同一台机器
#dhcp-option=42,0.0.0.0

# 将NIS域名设置为"welly"
#dhcp-option=40,welly

# 将默认生存时间设置为50
#dhcp-option=23,50

# 设置“所有子网都是本地”的标志
#dhcp-option=27,1

# 发送etherboot魔术标志然后是etherboot选项（字符串）。
#dhcp-option=128,e4:45:74:68:00:00
#dhcp-option=129,NIC=eepro100

# 指定仅当设置了"red"标签时发送的选项，
# （见dhcp-range用于声明"red"网络）
# 注意标签部分必须在选项部分之前。
#dhcp-option = tag:red, option:ntp-server, 192.168.1.1

# 下面的DHCP选项设置dnsmasq与为
# ISC dhcpcd指定的方式相同，在
# http://www.samba.org/samba/ftp/docs/textdocs/DHCP-Server-Configuration.txt
# 为典型的dnsmasq安装适应，其中运行dnsmasq的主机也是运行samba的主机。
# 如果你使用Windows客户端和Samba，你可能希望取消注释一些或全部这些选项。
#dhcp-option=19,0           # 关闭ip-forwarding
#dhcp-option=44,0.0.0.0     # 设置NetBIOS over TCP/IP名称服务器（即WINS服务器）
#dhcp-option=45,0.0.0.0     # netbios数据报分发服务器
#dhcp-option=46,8           # netbios节点类型

# 发送空的WPAD选项。这可能是必需的以使Windows 7表现正常。
#dhcp-option=252,"\n"

# 发送RFC-3397 DNS域搜索DHCP选项。警告：你的DHCP客户端
# 可能不支持这个......
#dhcp-option=option:domain-search,eng.apple.com,marketing.apple.com

# 发送RFC-3442无类静态路由（注意网络掩码编码）
#dhcp-option=121,192.168.1.0/24,1.2.3.4,10.0.0.0/8,5.6.7.8

# 在DHCP选项43中发送封装的vendor-class特定选项。
# 选项的含义由vendor-class定义
# 因此选项仅在客户端提供的vendor class
# 匹配此处给出的类时发送。（子字符串匹配也可以，所以"MSFT"
# 匹配"MSFT"和"MSFT 5.0"）。此示例为PXEClient设置
# mtftp地址为0.0.0.0。
#dhcp-option=vendor:PXEClient,1,0.0.0.0

# 发送microsoft特定选项以告诉windows在它关闭时释放DHCP租约。
# 注意'i'标志，告诉dnsmasq以四字节整数发送值 - 这是microsoft所需的。
# 参见
# http://technet2.microsoft.com/WindowsServer/en/library/a70f1bb7-d2d4-# 49f0-96d6-4b7414ecfaae1033.mspx?mfr=true
#dhcp-option=vendor:MSFT,2,1i

# 发送Etherboot需要的封装vendor-class ID，
# 以使其能识别DHCP服务器。
#dhcp-option=vendor:Etherboot,60,"Etherboot"

# 向PXELinux发送选项。注意即使它们没有出现在参数请求列表中，
# 我们也需要发送选项，因此我们需要在这里使用dhcp-option-force。
# 详情见 http://syslinux.zytor.com/pxe.php#special。
# 魔法数字 - 在任何其他东西被认出之前需要
#dhcp-option-force=208,f1:00:74:7e
# 配置文件名
#dhcp-option-force=209,configs/common
# 路径前缀
#dhcp-option-force=210,/tftpboot/pxelinux/files/
# 重启时间。 (注意 'i' 用于发送32位值)
#dhcp-option-force=211,30i

# 为netboot/PXE设置启动文件名。你只需要这个
# 如果你想要通过网络启动机器，你将需要
# 一个TFTP服务器；要么是dnsmasq的内置TFTP服务器或一个
# 外部的。 (见下面如何启用TFTP服务器。)
#dhcp-boot=pxelinux.0

# 与上面相同，但使用自定义的tftp-server代替运行dnsmasq的机器
#dhcp-boot=pxelinux,server.name,192.168.1.100

# 为iPXE引导。这个想法是发送两个不同的
# 文件名，第一个加载iPXE，第二个告诉iPXE加载什么。
# dhcp-match设置ipxe标签以响应来自iPXE的请求。
#dhcp-boot=undionly.kpxe
#dhcp-match=set:ipxe,175 # iPXE发送175选项。
#dhcp-boot=tag:ipxe,http://boot.ipxe.org/demo/boot.php

# 为iPXE封装的选项。所有选项都
# 在175选项中封装。
#dhcp-option=encap:175, 1, 5b         # 优先级代码
#dhcp-option=encap:175, 176, 1b       # 无代理dhcp
#dhcp-option=encap:175, 177, string   # 总线ID
#dhcp-option=encap:175, 189, 1b       # BIOS驱动代码
#dhcp-option=encap:175, 190, user     # iSCSI用户名
#dhcp-option=encap:175, 191, pass     # iSCSI密码

# 测试netboot客户端的架构。PXE客户端应
# 通过选项93发送其架构。（参见RFC 4578）
#dhcp-match=peecees, option:client-arch, 0 #x86-32
#dhcp-match=itanics, option:client-arch, 2 #IA64
#dhcp-match=hammers, option:client-arch, 6 #x86-64
#dhcp-match=mactels, option:client-arch, 7 #EFI x86-64

# 做真正的PXE，而不是仅引导单个文件，这是一个
# dhcp-boot的替代方案。
#pxe-prompt="What system shall I netboot?"
# 或在第一次可用操作执行前的超时：
#pxe-prompt="Press F8 for menu.", 60

# 可用的引导服务。用于PXE。
#pxe-service=x86PC, "Boot from local disk"

# 从dnsmasq TFTP服务器加载<tftp-root>/pxelinux.0。
#pxe-service=x86PC, "Install Linux", pxelinux

# 从位于1.2.3.4的TFTP服务器加载<tftp-root>/pxelinux.0。
# 注意这在旧的PXE ROM上可能失败。
#pxe-service=x86PC, "Install Linux", pxelinux, 1.2.3.4

# 使用网络上的引导服务器，通过多播或广播找到。
#pxe-service=x86PC,"Install windows from RIS server", 1

# 使用已知IP地址的引导服务器。
#pxe-service=x86PC, "Install windows from RIS server", 1, 1.2.3.4

# 如果你有可用的多播FTP，
# 可以以类似方式传递关于此的信息，使用选项1
# 到5。参见第19页
# http://download.intel.com/design/archives/wfm/downloads/pxespec.pdf

# 启用dnsmasq的内置TFTP服务器
#enable-tftp

# 设置可通过FTP提供文件的根目录。
#tftp-root=/var/ftpd

# 如果tftp-root不可用，不中止
#tftp-no-fail

# 让TFTP服务器更安全：设置此项后，只有
# 用户dnsmasq运行时的用户拥有的文件才会通过网络发送。
#tftp-secure

# 此选项阻止dnsmasq为TFTP传输协商更大的块大小。
# 它会减慢速度，但可能拯救一些损坏的TFTP客户端。
#tftp-no-blocksize

# 设置仅当设置了"red"标签时的启动文件名。
#dhcp-boot=tag:red,pxelinux.red-net

# dhcp-boot的一个示例，带有外部TFTP服务器：文件名后给出服务器的名称和IP地址。
# 在旧的PXE ROM上可能失败。被--pxe-service覆盖。
#dhcp-boot=/var/ftpd/pxelinux.0,boothost,192.168.0.3

# 如果有多个外部tftp服务器具有相同的名字
# (使用/etc/hosts) 则可以指定该名称为tftp_servername
# (dhcp-boot的第三个选项) 并在这种情况下dnsmasq将解析此名称
# 并以循环方式返回结果IP地址。此功能可用于
# 在一组服务器之间平衡tftp负载。
#dhcp-boot=/var/ftpd/pxelinux.0,boothost,tftp_server_name

# 设置DHCP租约的限制，缺省值为150
#dhcp-lease-max=150

# DHCP服务器需要一个磁盘位置来保持其租约数据库。
# 这默认于一个合理的位置，但如果你想改变它，使用
# 下面的行。
#dhcp-leasefile=/var/lib/dnsmasq/dnsmasq.leases

# 将DHCP服务器设置为权威模式。在这种模式下，它将介入
# 并接管任何在网络上广播的客户端的租约，
# 无论它是否有该租约的记录。这避免了当一台机器
# 在新网络上唤醒时的长时间超时。如果有
# 任何可能你最终不小心为你的校园/公司配置了一个DHCP服务器，
# 则不要启用此功能。ISC服务器使用
# 相同的选项，这个URL提供了更多信息：
# http://www.isc.org/files/auth.html
#dhcp-authoritative

# 将DHCP服务器设置为根据RFC 4039启用DHCPv4 Rapid Commit选项。
# 在这种模式下，它将响应包含Rapid Commit选项的DHCPDISCOVER消息
# 用一个包含Rapid Commit选项和完全提交的地址和配置信息的DHCPACK。
# 仅当服务器是子网的唯一服务器，或者多个服务器存在并且它们每个都
# 为所有客户端提交绑定时，才能启用此模式。
#dhcp-rapid-commit

# 在创建或销毁DHCP租约时运行一个可执行文件。
# 发送到脚本的参数是 "add" 或 "del",
# 然后是MAC地址，IP地址，最后是主机名
# 如果有的话。
#dhcp-script=/bin/echo

# 在这里设置缓存大小。
cache-size=1500

# 如果你想禁用负缓存，取消注释这一行。
#no-negcache

# 通常来自/etc/hosts和DHCP租约文件的响应
# 有生存时间设置为零，传统上意味着
# 不进一步缓存。如果你愿意为了减轻服务器负载
# 交换潜在的陈旧数据，你可以在这里设置一个生存时间（以秒为单位）。
#local-ttl=

# 如果你希望dnsmasq检测Verisign企图发送查询
# 到未注册的.com和.net主机到其sitefinder服务，并且让
# dnsmasq反而返回正确的NXDOMAIN响应，取消注释
# 这一行。你可以添加类似的行来做同样的事情
# 对于实现了通配符A记录的其他注册机构。
#bogus-nxdomain=64.94.110.11

# 如果你想要修正来自上游服务器的DNS结果，使用
# alias选项。这只适用于IPv4。
# 这个别名使1.2.3.4的结果出现为5.6.7.8
#alias=1.2.3.4,5.6.7.8
# 这将映射1.2.3.x到5.6.7.x
#alias=1.2.3.0,5.6.7.0,255.255.255.0
# 这将映射192.168.0.10-192.168.0.40到10.0.0.10-10.0.0.40
#alias=192.168.0.10-192.168.0.40,10.0.0.0,255.255.255.0

# 更改以下行，如果你希望dnsmasq提供MX记录。

# 返回名为 "maildomain.com" 的MX记录，目标
# 服务器为 servermachine.com 和优先级为 50
#mx-host=maildomain.com,servermachine.com,50

# 设置使用localmx选项创建的MX记录的默认目标。
#mx-target=servermachine.com

# 返回指向mx-target的MX记录给所有本地
# 机器。
#localmx

# 返回一个指向自身的MX记录给所有本地机器。
#selfmx

# 更改以下行，如果你希望dnsmasq提供SRV
# 记录。这些在你希望为
# Active Directory和其他windows起源的DNS请求服务ldap时很有用。
# 参见RFC 2782。
# 你可以添加多个srv-host行。
# 字段是<name>,<target>,<port>,<priority>,<weight>
# 如果名字部分缺少域（所以它只有服务和协议部分）
# 那么使用domain=配置选项给出的域。（注意expand-hosts不需要
# 设置为这个工作。）

# 一个SRV记录，为example.com域发送LDAP到
# ldapserver.example.com端口389
#srv-host=_ldap._tcp.example.com,ldapserver.example.com,389

# 一个SRV记录，使用domain=发送LDAP为example.com域到
# ldapserver.example.com端口389
#domain=example.com
#srv-host=_ldap._tcp,ldapserver.example.com,389

# 两个LDAP的SRV记录，每个有不同的优先级
#srv-host=_ldap._tcp.example.com,ldapserver.example.com,389,1
#srv-host=_ldap._tcp.example.com,ldapserver.example.com,389,2

# 一个SRV记录指示example.com域没有LDAP服务器
#srv-host=_ldap._tcp.example.com

# 下面的行显示如何使dnsmasq提供一个任意的PTR
# 记录。这对DNS-SD很有用。（注意
# 为SRV记录完成的域名扩展 _does_not
# 发生在PTR记录上。）
#ptr-record=_http._tcp.dns-sd-services,"New Employee Page._http._tcp.dns-sd-services"

# 更改以下行，如果你希望dnsm# asq提供TXT记录。
# 这些用于像SPF和zeroconf这样的东西。（注意
# 为SRV记录完成的域名扩展 _does_not
# 发生在TXT记录上。）

# 示例SPF。
#txt-record=example.com,"v=spf1 a -all"

# 示例zeroconf
#txt-record=_http._tcp.example.com,name=value,paper=A4

# 为一个“本地”DNS名称提供别名。注意这 _only_ 对于
# 目标是来自DHCP或/etc/hosts的名称有效。给主机
# "bert" 另一个名字，bertrand
#cname=bertand,bert

# 为了调试目的，记录每个通过
# dnsmasq的DNS查询。
log-queries

# 日志文件位置。
log-facility=/var/log/dnsmasq.log
# 记录有关DHCP交易的大量额外信息。
#log-dhcp

# 包含另一组配置选项。
#conf-file=/etc/dnsmasq.more.conf
#conf-dir=/etc/dnsmasq.d

# 包含一个目录中的所有文件，除了以.bak结尾的文件
#conf-dir=/etc/dnsmasq.d,.bak

# 包含一个目录中所有以.conf结尾的文件
#conf-dir=/etc/dnsmasq.d/,*.conf

# 包含/etc/dnsmasq.d中的所有文件，除了RPM备份文件
conf-dir=/etc/dnsmasq.d,.rpmnew,.rpmsave,.rpmorig

# 如果一个DHCP客户端声称它的名字是"wpad"，忽略它。
# 这修复了一个安全漏洞。请参阅CERT漏洞VU#598349
#dhcp-name-match=set:wpad-ignore,wpad
#dhcp-ignore-names=tag:wpad-ignore
```


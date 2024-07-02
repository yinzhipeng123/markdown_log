

## NMAP命令



在线ipv6检测：http://www.ipv6scanner.com/cgi-bin/main.py 



nmap的帮助手册真的是又臭又长，及时是help提供的内容也非常多，以下是gpt4理解并翻译的内容。

nmap - 网络探索工具、安全或端口扫描仪

语法     

```bash
nmap [扫描类型...] [选项] {目标规范}
Nmap 6.40 (http://nmap.org)
使用方式: nmap [扫描类型] [选项] {目标规范}
目标规范:
  可以输入主机名，IP地址，网络等。
  例如: scanme.nmap.org, microsoft.com/24, 192.168.0.1; 10.0.0-255.1-254
  -iL <输入文件名>: 从主机/网络列表文件输入
  -iR <主机数量>: 随机选择目标
  --exclude <主机1[,主机2][,主机3],...>: 排除主机/网络
  --excludefile <排除文件>: 从文件排除列表
主机发现:
  -sL: 列表扫描 - 仅列出要扫描的目标
  -sn: Ping扫描 - 禁用端口扫描
  -Pn: 将所有主机视为在线 - 跳过主机发现
  -PS/PA/PU/PY[portlist]: 到指定端口的TCP SYN/ACK，UDP或SCTP发现
  -PE/PP/PM: ICMP回声，时间戳和网络掩码请求发现探针
  -PO[协议列表]: IP协议Ping
  -n/-R: 从不进行DNS解析/总是解析 [默认: 有时]
  --dns-servers <服务器1[,服务器2],...>: 指定自定义DNS服务器
  --system-dns: 使用操作系统的DNS解析器
  --traceroute: 跟踪到每个主机的跳转路径
扫描技术:
  -sS/sT/sA/sW/sM: TCP SYN/Connect()/ACK/Window/Maimon扫描
  -sU: UDP扫描
  -sN/sF/sX: TCP Null，FIN和Xmas扫描
  --scanflags <标志>: 自定义TCP扫描标志
  -sI <僵尸主机[:探针端口]>: 闲置扫描
  -sY/sZ: SCTP INIT/COOKIE-ECHO扫描
  -sO: IP协议扫描
  -b <FTP中继主机>: FTP弹跳扫描
端口规范和扫描顺序:
  -p <端口范围>: 仅扫描指定端口
    例如: -p22; -p1-65535; -p U:53,111,137,T:21-25,80,139,8080,S:9
  -F: 快速模式 - 扫描的端口比默认扫描少
  -r: 连续扫描端口 - 不随机化
  --top-ports <数量>: 扫描<数量>个最常见的端口
  --port-ratio <比例>: 扫描比<比例>更常见的端口
服务/版本检测:
  -sV: 探测开放端口以确定服务/版本信息
  --version-intensity <级别>: 设置从0 (轻) 到9 (尝试所有探针)
  --version-light: 限制最有可能的探针 (强度2)
  --version-all: 尝试每个单独的探针 (强度9)
  --version-trace: 显示详细版本扫描活动 (用于调试)
脚本扫描:
  -sC: 相当于 --script=default
  --script=<Lua脚本>: <Lua脚本>是逗号分隔的目录，脚本文件或脚本类别列表
  --script-args=<n1=v1,[n2=v2,...]>: 向脚本提供参数
  --script-args-file=文件名: 在文件中提供NSE脚本参数
  --script-trace: 显示发送和接收的所有数据
  --script-updatedb: 更新脚本数据库。
  --script-help=<Lua脚本>: 显示有关脚本的帮助。
           <Lua脚本>是脚本文件或脚本类别的逗号分隔列表。
操作系统检测:
  -O: 启用操作系统检测
  --osscan-limit: 限制操作系统检测到有希望的目标
  --osscan-guess: 更积极地猜测操作系统
时序和性能:
  使用<time>的选项以秒为单位，或者将'ms' (毫秒)，
  's' (秒)，'m' (分钟) 或 'h' (小时) 添加到值后面 (例如 30m)。
  -T<0-5>: 设置时序模板 (数字越高越快)
  --min-hostgroup/max-hostgroup <大小>: 并行主机扫描组大小
  --min-parallelism/max-parallelism <探针数>: 探针并行化
  --min-rtt-timeout/max-rtt-timeout/initial-rtt-timeout <time>: 设置RTT超时
  --max-retries <尝试次数>: 设置最大重试次数
  --host-timeout <时间>: 放弃对目标的扫描
  --scan-delay/--max-scan-delay <时间>: 调整探针之间的时间
  --min-rate <速率>: 发送探针的最小速率
  --max-rate <速率>: 发送探针的最大速率
防火墙/IDS躲避和欺骗:
  -f; --mtu <值>: 分段扫描; 指定自定义的MTU
  -D <伪装主机1,2,...>: 使用伪装主机进行欺骗
  -S <IP地址>: 使用指定的源地址
  -e <接口>: 使用指定的网络接口
  --source-port <端口>: 使用指定的源端口
  --proxies <url1,[url2],...>: 通过HTTP/SOCKS4/SOCKS5代理扫描
  --data-length <数量>: 在包中添加随机数据
  --ip-options <选项>: 使用自定义的IP选项
  --ttl <值>: 设置IP生存时间
  --spoof-mac <MAC地址/前缀/供应商>: 伪装MAC地址
  --badsum: 发送带有错误校验和的包
输出:
  -oN/-oX/-oS/-oG <文件>: 正常，XML，s|<rIpt kIddi3 和 Grepable输出
  -oA <basename>: 输出所有格式 (-oN, -oX, -oS, -oG)
  -v: 增加详细度等级 (使用两次或更多以获取更多信息)
  --version-all: 显示所有版本号
  --open: 仅显示开放的 (或可能开放的) 端口
  --packet-trace: 显示网络包跟踪
  --iflist: 列出接口和路由 (用于调试)
  --append-output: 附加到而不是覆盖输出文件
  --resume <文件名>: 从之前中断的扫描继续
  --stylesheet <path/URL>: 自定义XSL样式表
  --webxml: 引用 http://nmap.org/svn/docs/nmap.xsl 的网络样式表
  --no-stylesheet: 禁用样式表
其他:
  -6: 启用IPv6扫描
  -A: 启用操作系统检测和版本检测，脚本扫描和traceroute
  --datadir <目录>: 指定自定义数据文件的位置
  --send-eth/--send-ip: 使用以太网帧/IP数据包发送 (仅限root用户)
  --privileged: 假设用户有权限 (跳过权限检查)
  --unprivileged: 假设用户无权限 (跳过权限检查)
  -V: 显示版本号
  -h: 显示帮助摘要

例子:
  nmap -v -A scanme.nmap.org
  nmap -v -sn 192.168.0.1/24
  nmap -v -Pn -p 80,443,8080 -oA scanme 192.168.0.1
  nmap -6 fe80::202:b3ff:fe1e:8329
  nmap -v -sV -T4 -O -F --version-light 192.168.0.1
```



这里有几个Nmap的常用用法：

1. **基本主机扫描**:
   ```
   nmap 192.168.1.1
   ```
   这个命令会扫描IP地址为192.168.1.1的主机上开放的端口。

2. **扫描整个子网**:
   ```
   nmap 192.168.1.0/24
   ```
   这将扫描192.168.1.0到192.168.1.255的所有IP地址。

3. **操作系统检测**:
   ```
   nmap -A 192.168.1.1
   ```
   `-A` 选项会开启操作系统检测、版本检测、脚本扫描和traceroute。

4. **扫描特定端口**:
   ```
   nmap -p 80,443 192.168.1.1
   ```
   这会扫描目标主机的80和443端口。

5. **快速扫描**:
   ```
   nmap -T4 -F 192.168.1.1
   ```
   `-T4` 选项加速扫描，而`-F`选项限制扫描到最常见的端口。

6. **不进行ping检测**:
   ```
   nmap -Pn 192.168.1.1
   ```
   `-Pn` 选项跳过ping检测，对于防火墙后面的主机特别有用。

7. **扫描TCP和UDP端口**:
   ```
   nmap -sS -sU -p T:22,80,U:53,111,137 192.168.1.1
   ```
   这将同时扫描TCP和UDP端口。

8. **脚本扫描**:
   ```
   nmap --script=default -p 443 192.168.1.1
   ```
   使用默认脚本集对目标主机的443端口进行脚本扫描。

这里有几个更实用的Nmap用法：

1. **仅显示开放的端口**:
   ```
   nmap --open 192.168.1.1
   ```
   使用`--open`选项只显示目标主机上开放的端口。

2. **扫描特定的服务版本**:
   ```
   nmap -sV 192.168.1.1
   ```
   `-sV`选项可以检测端口上运行的服务及其版本。

3. **使用特定的脚本**:
   ```
   nmap --script=http-title 192.168.1.1
   ```
   这将使用`http-title`脚本来获取目标网站的标题。

4. **输出扫描结果到文件**:
   ```
   nmap -oN scan_results.txt 192.168.1.1
   ```
   `-oN`选项将扫描结果输出到`scan_results.txt`文件中。

5. **扫描特定协议的端口**:
   ```
   nmap -sU -p U:53,111,137 192.168.1.1
   ```
   这个命令扫描目标主机上指定的UDP端口。

6. **执行激进的OS和服务检测**:
   ```
   nmap -A -T4 192.168.1.1
   ```
   `-A`开启OS检测、服务版本检测、脚本扫描和traceroute，`-T4`加快扫描速度。

7. **排除特定的主机或网络**:
   ```
   nmap 192.168.1.0/24 --exclude 192.168.1.5
   ```
   这会扫描192.168.1.0/24子网中的所有主机，但排除了192.168.1.5。

8. **TCP SYN扫描**:
   ```
   nmap -sS 192.168.1.1
   ```
   `-sS`执行TCP SYN扫描，这是一种较为隐蔽的扫描方式。

记得使用Nmap时要遵守法律和道德准则，只在授权的环境中进行扫描。

快速扫描所有端口：

```bash
nmap -p 1-65535 -T4 --min-rate 1000 --max-retries 1 -n --host-timeout 30m <目标IP>

-p 1-65535：扫描从端口1到65535的所有端口。
-T4：设置扫描的速度为较快。
--min-rate 1000：设置每秒最少发送1000个包。
--max-retries 1：每个端口只重试一次。
-n：禁用DNS解析，加快扫描速度。
--host-timeout 30m：如果一个主机的扫描超过30分钟则放弃扫描。
<目标IP>：您要扫描的目标IP地址。
```



[Nmap使用教程（初级篇） - zha0gongz1 - 博客园 (cnblogs.com)](https://www.cnblogs.com/zha0gongz1/p/12231851.html)

[Nmap使用教程（进阶篇） - zha0gongz1 - 博客园 (cnblogs.com)](https://www.cnblogs.com/zha0gongz1/p/12234762.html)

[(42条消息) Nmap常用命令_百密不疏的博客-CSDN博客](https://blog.csdn.net/m0_48907714/article/details/123001723)
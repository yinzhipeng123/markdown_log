mtr工具

以下全部由gpt4生成，它翻译的man手册，及给出的一些例子

**MTR(8) 网络诊断工具**

**名称**  
mtr - 一个网络诊断工具

**概述**  
mtr [-BfhvrctglxspQemniuTP46] [--help] [--version] [--report] [--report-wide] [--report-cycles COUNT] [--curses] [--split] [--raw] [--xml] [--mpls] [--no-dns] [--show-ips] [--gtk] [--address IP.ADD.RE.SS] [--interval SECONDS] [--max-ttl NUM] [--first-ttl NUM] [--bitpattern NUM] [--tos NUM] [--psize BYTES | -s BYTES] [--tcp] [--udp] [--port PORT] [--timeout SECONDS] HOSTNAME [PACKETSIZE]

**描述**  
mtr 结合了 traceroute 和 ping 程序的功能，成为一个单一的网络诊断工具。

当 mtr 启动时，它会检查运行 mtr 的主机与 HOSTNAME 之间的网络连接，通过发送具有特意设定的低 TTL 的数据包。它继续发送低 TTL 的数据包，注意中间路由器的响应时间。这使 mtr 能够打印到 HOSTNAME 的网络路径的响应百分比和响应时间。突然的数据包丢失或响应时间的增加通常表示一个不好的（或简单的超载的）链接。

结果通常以毫秒的往返响应时间和丢包百分比报告。

**选项**  
-h

--help  
输出命令行参数选项的摘要。

-v

--version  
打印 mtr 的已安装版本。

-r

--report  
此选项使 mtr 进入报告模式。在此模式下，mtr 将运行由 -c 选项指定的循环次数，然后打印统计信息并退出。

这种模式对于生成关于网络质量的统计数据非常有用。请注意，每个运行的 mtr 实例都会生成大量的网络流量。使用 mtr 来测量网络的质量可能导致网络性能下降。

-w

--report-wide  
此选项使 mtr 进入宽报告模式。在此模式下，mtr 在报告中不会截断主机名。

-c COUNT

--report-cycles COUNT  
使用此选项设置发送的 ping 数量，以确定网络上的机器及其可靠性。每个循环持续一秒。



-s BYTES

--psize BYTES

PACKETSIZE 
这些选项或命令行末尾的 PACKETSIZE 用于设置用于探测的数据包大小。它以字节为单位，包括 IP 和 ICMP 头部。

如果设置为负数，每次迭代都会使用不同的随机数据包大小，最大不超过该数字。

-t

--curses 
使用此选项强制 mtr 使用基于 curses 的终端界面（如果可用）。

-e

--mpls 
使用此选项告诉 mtr 显示来自 ICMP 扩展的 MPLS (RFC 4950) 信息，该信息被编码在响应数据包中。

-n

--no-dns 
使用此选项强制 mtr 显示数字 IP 地址，不尝试解析主机名。

-b

--show-ips 
使用此选项告诉 mtr 同时显示主机名和数字 IP 地址。在分裂模式下，这会在输出中增加一个额外的字段。在报告模式中，通常没有足够的空间添加 IP，它们将被截断。使用宽报告 (-w) 模式在报告模式中查看 IP。

-o fields order

--order fields order 
使用此选项在加载 mtr 时指定字段及其顺序。 
可用字段：

| 标识 | 描述 |
|------|----------------------|
| L | 丢包比例 |
| D | 丢失的数据包 |
| R | 接收的数据包 |
| S | 已发送的数据包 |
| N | 最新的 RTT(毫秒) |
| B | 最小/最好的 RTT(毫秒)|
| A | 平均 RTT(毫秒) |
| W | 最大/最差的 RTT(毫秒)|
| V | 标准偏差 |
| G | 几何均值 |
| J | 当前抖动 |
| M | 抖动均值 |
| X | 最差抖动 |
| I | 到达间隔抖动 |

示例：-o "LSD NBAW"

-g

--gtk  
使用此选项强制 mtr 使用基于 GTK+ 的 X11 窗口界面（如果可用）。当 mtr 构建时系统上必须有 GTK+ 才能使其工作。更多关于 GTK+ 的信息，请访问 http://www.gtk.org/ 。

-p

--split  
使用此选项设置 mtr 以输出适合于分裂用户界面的格式。

-l

--raw  
使用此选项告诉 mtr 使用原始输出格式。此格式更适合测量结果的存档。它可以被解析以呈现到任何其他显示方法。

-x

--xml  
使用此选项告诉 mtr 使用 xml 输出格式。此格式更适合于测量结果的自动处理。

-a IP.ADD.RE.SS

--address IP.ADD.RE.SS  
使用此选项将发出的数据包的套接字绑定到特定接口，这样任何数据包都会通过此接口发送。请注意，此选项不适用于 DNS 请求。

-i SECONDS

--interval SECONDS  
使用此选项指定 ICMP ECHO 请求之间的正数秒数。此参数的默认值是一秒。

-m NUM

--max-ttl NUM  
指定 traceroute 将探测的最大跳数（最大生存时间值）。默认是30。

-f NUM

--first-ttl NUM  
指定从哪个 TTL 开始。默认值为1。

-B NUM

--bitpattern NUM  
指定在负载中使用的位模式。应在0 - 255范围内。

-Q NUM

--tos NUM  
指定 IP 标头中服务类型字段的值。应在0 - 255范围内。

-u

--udp  
使用 UDP 数据报而不是 ICMP ECHO。

-T

--tcp  
使用 TCP SYN 数据包而不是 ICMP ECHO。PACKETSIZE 被忽略，因为 SYN 数据包不能包含数据。

-P PORT

--port PORT  
TCP 跟踪的目标端口号。

--timeout SECONDS  
在放弃连接之前保持 TCP 套接字打开的秒数。这只会影响最后一跳。对此使用大的值，特别是与短间隔结合使用，将使用大量的文件描述符。

-4  
仅使用 IPv4。

-6  
仅使用 IPv6。

**问题**  
一些现代路由器比其他网络流量对 ICMP ECHO 数据包的优先级较低。因此，mtr 报告的这些路由器的可靠性将比这些路由器的实际可靠性显著降低。

**联系信息**  
要获取最新版本，请访问 mtr 网页：http://www.bitwizard.nl/mtr/。

mtr 邮件列表很少使用，目前已不再活跃。

应将错误报告和功能请求提交给 launchpad mtr 错误跟踪器。

**参见**  
traceroute(8)，ping(8) TCP/IP 描述 (Stevens, ISBN 0201633469)。





当然可以，以下是一些`mtr`的常用实例：

1. **基本使用**:
   ```bash
   mtr example.com
   ```
   这个命令会启动一个交互式的`mtr`会话，持续地监控从当前系统到`example.com`的路径。

2. **仅使用IPv4**:
   ```bash
   mtr -4 example.com
   ```
   这将仅使用IPv4进行追踪。

3. **仅使用IPv6**:
   ```bash
   mtr -6 example.com
   ```
   这将仅使用IPv6进行追踪。

4. **显示报告**:
   ```bash
   mtr -r -c 10 example.com
   ```
   这将发送10个数据包到`example.com`，然后显示统计报告并退出。

5. **显示宽报告**:
   ```bash
   mtr -rw example.com
   ```
   与上面的报告模式相似，但会使用宽格式以避免主机名被截断。

6. **不解析DNS**:
   ```bash
   mtr -n example.com
   ```
   这将显示数字IP地址，而不是尝试解析主机名。

7. **使用UDP数据报**:
   ```bash
   mtr -u example.com
   ```

8. **使用TCP SYN数据包**:
   ```bash
   mtr -T example.com
   ```

9. **指定数据包大小**:
   ```bash
   mtr -s 100 example.com
   ```
   这将使用100字节的数据包进行追踪。

10. **指定时间间隔**:
   ```bash
   mtr -i 2 example.com
   ```
   这将每2秒发送一个数据包。

这只是`mtr`的一些基本使用实例。由于`mtr`是一个功能丰富的工具，还有许多其他选项和配置可用。为了更全面地了解这些功能，建议查看其官方文档或使用`man mtr`命令。
# tcping



下载地址：https://www.elifulkerson.com/projects/tcping.php

```bash
tcping.exe --help

tcping.exe 由 Eli Fulkerson 制作
请访问 http://www.elifulkerson.com/projects/ 获取更新。

使用方法: tcping.exe [-flags] 服务器地址 [服务器端口]

完整使用方法: tcping.exe [-t] [-d] [-i interval] [-n times] [-w ms] [-b n] [-r times] [-s] [-v] [-j] [-js size] [-4] [-6] [-c] [-g count] [-S source_address] [--file] [--tee filename] [-h] [-u] [--post] [--head] [--proxy-port port] [--proxy-server server] [--proxy-credentials username:password] [-f] 服务器地址 [服务器端口]

 -t     : 持续 ping 直到通过 control-c 停止
 -n 5   : 例如，发送 5 次 ping
 -i 5   : 例如，每5秒 ping 一次
 -w 0.5 : 例如，等待0.5秒的响应
 -d     : 在每行包括日期和时间
 -b 1   : 启用蜂鸣声 (1 表示下线时响，2 表示上线时响，
                        3 表示状态变化时响，4 表示总是响)
 -r 5   : 例如，每 5 次 ping 重新查找主机名
 -s     : 成功 ping 时自动退出
 -v     : 打印版本并退出
 -j     : 包括抖动，默认使用滚动平均值
 -js 5  : 包括抖动，滚动平均值大小为5 (例如)
 --tee  : 将输出镜像到 '--tee' 后指定的文件名
 --append : 向 '--tee' 文件名追加而非覆盖
 -4     : 优先使用 ipv4
 -6     : 优先使用 ipv6
 -c     : 只在状态变化时显示输出行
 --file : 将“服务器地址”视为文件名，逐行循环
          注意：--file 与如 -j 和 -c 这样的选项不兼容，因为它正在循环不同的目标
          可选择接受服务器端口。例如，“example.org 443”是有效的。
          或者，使用 -p 在命令行强制为文件中的所有内容指定端口。
 -g 5   : 例如，如果连续失败5次则放弃
 -S _X_ : 指定源地址 _X_。源地址必须是客户端计算机的有效IP。
 -p _X_ : 指定端口的另一种方法
 --fqdn : 每行打印域名（如果可用）
 --ansi : 使用 ANSI 颜色序列（cygwin）
 --color: 使用 Windows 颜色序列

HTTP 选项:
 -h     : HTTP 模式（使用不带 http:// 的 url 作为服务器地址）
 -u     : 每行包括目标 URL
 --post : 使用 POST 而非 GET（可能避免缓存）
 --head : 使用 HEAD 而非 GET
 --proxy-server : 指定代理服务器
 --proxy-port   : 指定代理端口
 --proxy-credentials : 以用户名:密码格式指定 'Proxy-Authorization: Basic' 头

调试选项:
 -f     : 强制 tcping 发送至少一个字节
 --header : 包括一个带有原始参数和日期的头部。如果使用 --tee，则默认包含。
 --block  : 使用 '阻塞' 套接字连接。这会阻止 -w 工作并使用默认超时（在我的情况下长达 20 秒）。
            但它可以区分主动拒绝的连接与超时。

        如果你不传递服务器端口，默认为 80。
```



`tcping.exe` 是一个在 Windows 环境下模拟 ICMP ping 功能的工具，主要用于检测 TCP 端口的连通性。它不仅可以测试端口是否开放，还能提供关于延迟和响应时间的信息。下面是一些 `tcping.exe` 的常用用法：

**1.基本的 TCP Ping**：

- 命令：`tcping.exe [服务器地址] [端口]`
- 作用：检测指定服务器地址的指定端口是否开放。如果未指定端口，默认为 80 端口。
- 示例：`tcping.exe example.com 80`

**2.持续 Ping**：

- 命令：`tcping.exe -t [服务器地址] [端口]`
- 作用：持续检测指定端口的状态，直到用户手动停止（使用 Ctrl + C）。
- 示例：`tcping.exe -t example.com 80`

**3.设置 Ping 的次数**：

- 命令：`tcping.exe -n [次数] [服务器地址] [端口]`
- 作用：设置要发送的 ping 数量。
- 示例：`tcping.exe -n 5 example.com 80`

**4.设置 Ping 的间隔时间**：

- 命令：`tcping.exe -i [间隔秒数] [服务器地址] [端口]`
- 作用：设置每次 ping 之间的间隔时间（秒）。
- 示例：`tcping.exe -i 10 example.com 80`

**5.设置响应超时时间**：

- 命令：`tcping.exe -w [超时时间] [服务器地址] [端口]`
- 作用：设置等待响应的超时时间（秒）。
- 示例：`tcping.exe -w 2 example.com 80`

**6.HTTP 模式**：

- 命令：`tcping.exe -h [服务器地址]`
- 作用：在 HTTP 模式下进行 ping，可以对 HTTP 服务进行更具针对性的检测。
- 示例：`tcping.exe -h www.example.com`

**7.显示带时间戳的 Ping 结果**：

- 命令：`tcping.exe -d [服务器地址] [端口]`
- 作用：在每次 ping 的输出中包含日期和时间。
- 示例：`tcping.exe -d example.com 80`

这些用法可以根据您的具体需求进行组合和调整。`tcping` 是一个灵活的工具，适用于网络诊断和测试 TCP 端口的连通性。请记住，对于不属于您的服务器和服务，进行此类测试时应确保您有适当的权限和合法性。


`tcping` 和传统的 `ping` 命令在功能和用途上有一些关键区别：

**1.协议**：

- **ping**：使用 ICMP (Internet Control Message Protocol) 协议。它发送 ICMP Echo Request 消息到目标地址，如果目标响应，则返回 ICMP Echo Reply。
- **tcping**：使用 TCP (Transmission Control Protocol) 协议。它尝试建立到目标地址的 TCP 连接（通常是到指定的端口）。

**2.用途**：

- **ping**：主要用于检测网络连通性。它可以告诉您目标机器是否可以通过网络访问，并提供往返时间 (RTT) 数据。
- **tcping**：主要用于检测特定 TCP 端口的可达性和响应时间。它对于检测特定服务（如 HTTP、数据库服务等）是否运行或监听特定端口非常有用。

**3.防火墙和过滤**：

- **ping**：许多系统和网络会阻止或过滤 ICMP 流量，这意味着即使系统在线，ping 也可能失败。
- **tcping**：由于许多应用和服务依赖于 TCP 连接，TCP 端口通常不会被阻止。因此，tcping 更有可能得到准确的端口可达性信息。

**4.输出信息**：

- **ping**：提供了目标地址的可达性、数据包往返时间、丢包信息等。
- **tcping**：提供了端口的开放状态、建立连接的时间等，更适合检测特定服务的状态。

总结来说，`ping` 是检测网络层的连通性和质量的工具，而 `tcping` 是检测特定 TCP 端口（因此是特定服务）的可达性和响应时间的工具。在诊断网络问题时，两者可以互为补充。

命令结果：

```bash
C:\Users\yinzhipeng>tcping.exe 172.61.222.51 80                                                
                                                                                                             
Probing 171.220.227.81:80/tcp - Port is open - time=9.747ms                                                  
Probing 171.220.227.81:80/tcp - Port is open - time=7.875ms                                                  
Probing 171.220.227.81:80/tcp - Port is open - time=8.482ms                                                  
Probing 171.220.227.81:80/tcp - Port is open - time=8.327ms                                                  
                                                                                                             
Ping statistics for 171.220.227.81:80                                                                        
     4 probes sent.                                                                                          
     4 successful, 0 failed.  (0.00% fail)                                                                   
Approximate trip times in milli-seconds:                                                                     
     Minimum = 7.875ms, Maximum = 9.747ms, Average = 8.608ms   
     
逐行翻译一下:

正在探测 171.220.227.81:80/tcp - 端口是开放的 - 时间=9.747毫秒
正在探测 171.220.227.81:80/tcp - 端口是开放的 - 时间=7.875毫秒
正在探测 171.220.227.81:80/tcp - 端口是开放的 - 时间=8.482毫秒
正在探测 171.220.227.81:80/tcp - 端口是开放的 - 时间=8.327毫秒

对 171.220.227.81:80 的 Ping 统计数据
     已发送 4 个探测包。
     4 次成功，0 次失败。  (失败率 0.00%)
大约的往返时间（以毫秒为单位）：
     最小值 = 7.875毫秒，最大值 = 9.747毫秒，平均值 = 8.608毫秒
     
```


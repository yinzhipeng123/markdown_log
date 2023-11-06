# iperf3命令



```bash
[root@VM-0-16-centos ~]＃ iperf3 --help
用法：iperf [-s | -c 主机] [选项]
       iperf [-h | --help] [-v | --version]

服务器或客户端：
  -p，--port      ＃         服务器监听/连接的端口
  -f，--format    [kmgKMG]  报告格式：K位，M位，K字节，M字节
  -i，--interval  ＃         周期性带宽报告之间的秒数
  -F，--file name           传输/接收指定文件
  -A，--affinity n/n,m      设置CPU亲和性
  -B，--bind      <host>    绑定到特定接口
  -V，--verbose             更详细的输出
  -J，--json                以JSON格式输出
  --logfile f               将输出发送到日志文件
  --forceflush              强制在每个间隔内刷新输出
  -d，--debug               发出调试输出
  -v，--version             显示版本信息并退出
  -h，--help                显示此消息并退出
服务器特定：
  -s，--server              以服务器模式运行
  -D，--daemon              将服务器作为守护程序运行
  -I，--pidfile file        写入PID文件
  -1，--one-off             处理一个客户端连接然后退出
客户端特定：
  -c，--client    <host>    以客户端模式运行，连接到<host>
  -u，--udp                 使用UDP而不是TCP
  -b，--bandwidth #[KMG][/#] 目标带宽位数/秒（0为无限制）
                            （UDP默认1 Mbit/sec，TCP无限制）
                            （用于突发模式的可选斜杠和分组计数）
  --fq-rate #[KMG]          启用基于公平排队的套接字调度速度
                            位数/秒（仅适用于Linux）
  -t，--time      #         传输的时间（默认10秒）
  -n，--bytes     #[KMG]    要传输的字节数（而不是-t）
  -k，--blockcount #[KMG]   要传输的块（数据包）数（而不是-t或-n）
  -l，--len       #[KMG]    要读取或写入的缓冲区长度
                            （TCP默认128 KB，UDP动态或1）
  --cport         <port>    绑定到特定客户端端口（TCP和UDP，默认：临时端口）
  -P，--parallel  #         要运行的并行客户端流数
  -R，--reverse             以反向模式运行（服务器发送，客户端接收）
  -w，--window    #[KMG]    设置窗口大小/套接字缓冲区大小
  -C，--congestion <algo>   设置TCP拥塞控制算法（仅适用于Linux和FreeBSD）
  -M，--set-mss   #         设置TCP/SCTP最大段大小（MTU - 40字节）
  -N，--no-delay            设置TCP/SCTP无延迟，禁用Nagle算法
  -4，--version4            仅使用IPv4
  -6，--version6            仅使用IPv6
  -S，--tos N               设置IP“服务类型”
  -L，--flowlabel N         设置IPv6流标签（仅在Linux上支持）
  -Z，--zerocopy            使用“零拷贝”方法发送数据
  -O，--omit N              省略前n秒
  -T，--title str           每个输出行都以此字符串为前缀
  --get-server-output       从服务器获取结果
  --udp-counters-64bit      在UDP测试数据包中使用64位计数器

[KMG]表示支持kilo（千位），mega（兆位）或giga（吉位）的选项后缀

iperf3主页：http://software.es.net/iperf/
报告错误：https://github.com/esnet/iperf
```



当使用iperf3进行网络性能测试时，以下是一些常见的用法示例：

1. 在服务器模式下运行iperf3：
   ```
   iperf3 -s
   ```
   这将在默认端口（5201）上启动iperf3服务器以监听连接请求。

2. 在客户端模式下连接到iperf3服务器，进行下载测试：
   ```
   iperf3 -c 服务器IP地址 -R
   ```
   用服务器的实际IP地址替换“服务器IP地址”以连接到服务器并测试带宽。

   ```bash
   iperf3 -c 服务器IP地址 -R -P 10
   ```
   
   开10个并发，同时进行下载测试
   
   ```
   iperf3 -c -w 1024K 服务器IP地址 -R -P 10 
   ```
   
   设置tcp窗口为1024K，开10个并发，同时进行下载测试
   
3. 使用UDP协议进行测试：
   ```
   iperf3 -u -c 服务器IP地址
   ```
   这将使用UDP协议而不是默认的TCP协议进行带宽测试。

4. 设置测试时长：
   ```
   iperf3 -t 30 -c 服务器IP地址
   ```
   这将使iperf3测试运行30秒，然后生成带宽报告。

5. 设置带宽限制：
   ```
   iperf3 -c 服务器IP地址 -b 10M
   ```
   这将限制测试的带宽为10兆位每秒（Mbps）。

6. 并行连接测试：
   ```
   iperf3 -c 服务器IP地址 -P 4
   ```
   这将创建4个并行连接以同时测试带宽。

7. 输出JSON格式报告：
   ```
   iperf3 -c 服务器IP地址 -J
   ```
   这将生成一个以JSON格式呈现的带宽报告。

这些是一些常见的iperf3用法示例，您可以根据特定的网络测试需求进行调整和扩展。



-w 参数用于设置iperf3 测试中的窗口大小（或套接字缓冲区大小）。窗口大小在TCP测试中特别重要，因为它可以影响数据传输速度和性能。下面是 -w 参数的用法示例：

```
iperf3 -c 服务器IP地址 -w 64K
```

在这个示例中，`-w` 后面跟着窗口大小的设置，这里设置窗口大小为 64K（64千字节）。您可以根据需求调整窗口大小的值，通常可以使用 K、M 或 G 作为后缀，表示千字节、兆字节或千兆字节。

窗口大小的选择取决于网络环境和测试目标。较大的窗口大小可能会提高带宽利用率，但可能会增加延迟。较小的窗口大小可能会减少延迟，但可能无法充分利用高带宽连接。因此，您可以根据实际情况进行测试和调整，以找到最佳的窗口大小设置。
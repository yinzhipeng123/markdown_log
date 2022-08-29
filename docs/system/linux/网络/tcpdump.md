# tcpdump

我们知道，tcpdump 也是最常用的一个网络分析工具。它基于 libpcap  ，利用内核中的 AF_PACKET 套接字，抓取网络接口中传输的网络包；并提供了强大的过滤规则，帮你从大量的网络包中，挑出最想关注的信息。tcpdump 为你展示了每个网络包的详细细节，这就要求，在使用前，你必须要对网络协议有基本了解。而要了解网络协议的详细设计和实现细节， RFC 当然是最权威的资料。

### 语法：

它的基本使用方法，还是比较简单的，也就是 tcpdump [选项] [过滤表达式]。当然，选项和表达式的外面都加了中括号，表明它们都是可选的。

```

$ tcpdump -nn udp port 53 or host 35.190.27.188
```

- -nn ，表示不解析抓包中的域名（即不反向解析）、协议以及端口号。
- udp port 53 ，表示只显示 UDP 协议的端口号（包括源端口和目的端口）为 53 的包。
- host 35.190.27.188 ，表示只显示 IP 地址（包括源地址和目的地址）为 35.190.27.188 的包。
- 这两个过滤条件中间的“ or ”，表示或的关系，也就是说，只要满足上面两个条件中的任一个，就可以展示出来。



<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202208251319540.png" alt="img" style="zoom: 25%;" />

刚刚用过的是 udp port 53 or host 35.190.27.188 ，表示抓取 DNS 协议的请求和响应包，以及源地址或目的地址为 35.190.27.188 的包。

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202208251320046.png" alt="img" style="zoom:25%;" />

最后，再次强调 tcpdump 的输出格式，我在前面已经介绍了它的基本格式：

```bash
时间戳 协议 源地址.源端口 > 目的地址.目的端口 网络包详细信息
```



### Wireshark

Wireshark 也是最流行的一个网络分析工具，它最大的好处就是提供了跨平台的图形界面。跟 tcpdump 类似，Wireshark 也提供了强大的过滤规则表达式，同时，还内置了一系列的汇总分析工具。



```bash
$ tcpdump -nn udp port 53 or host 35.190.27.188 -w ping.pcap
```

然后，再用 Wireshark 打开它。打开后，你就可以看到下面这个界面：

![img](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202208251329938.png)



TCP 三次握手和四次挥手很类似，作为对比， 你通常看到的 TCP 三次握手和四次挥手的流程，基本是这样的：

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202208251343928.png" alt="img" style="zoom: 33%;" />



<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202208251343572.png" alt="img" style="zoom: 50%;" />



对比这两张图，你会发现，这里抓到的包跟上面的四次挥手，并不完全一样，实际挥手过程只有三个包，而不是四个。

其实，之所以有三个包，是因为服务器端收到客户端的 FIN 后，服务器端同时也要关闭连接，这样就可以把 ACK 和 FIN 合并到一起发送，节省了一个包，变成了“三次挥手”。

而通常情况下，服务器端收到客户端的 FIN 后，很可能还没发送完数据，所以就会先回复客户端一个 ACK 包。稍等一会儿，完成所有数据包的发送后，才会发送 FIN 包。这也就是四次挥手了。





tcpdump手册

[tcpdump(1) man page | TCPDUMP & LIBPCAP](https://www.tcpdump.org/manpages/tcpdump.1.html)
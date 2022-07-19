# TIME_WAIT过多的解决方法

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207200246764.png" style="zoom: 50%;" />

上图对排除和定位网络或系统故障时大有帮助，但是怎样牢牢地将这张图刻在脑中呢？那么你就一定要对这张图的每一个状态，及转换的过程有深刻地认识，不能只停留在一知半解之中。下面对这张图的11种状态详细解释一下，以便加强记忆！不过在这之前，先回顾一下TCP建立连接的三次握手过程，以及关闭连接的四次握手过程。

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207200400715.png)

### 1、建立连接协议（三次握手）

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207200301284.png)

1. 客户端发送一个带SYN标志的TCP报文到服务器。这是三次握手过程中的报文1。
2. 服务器端回应客户端的，这是三次握手中的第2个报文，这个报文同时带ACK标志和SYN标志。因此它表示对刚才客户端SYN报文的回应；同时又标志SYN给客户端，询问客户端是否准备好进行数据通讯。
3. 客户必须再次回应服务段一个ACK报文，这是报文段3。



### 2、连接终止协议（四次握手）

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207200303304.png)

由于TCP连接是全双工的，因此每个方向都必须单独进行关闭。这原则是当一方完成它的数据发送任务后就能发送一个FIN来终止这个方向的连接。收到一个 FIN只意味着这一方向上没有数据流动，一个TCP连接在收到一个FIN后仍能发送数据。首先进行关闭的一方将执行主动关闭，而另一方执行被动关闭。

1. TCP客户端发送一个FIN，用来关闭客户到服务器的数据传送（报文段4）。
2. 服务器收到这个FIN，它发回一个ACK，确认序号为收到的序号加1（报文段5）。和SYN一样，一个FIN将占用一个序号。
3. 服务器关闭客户端的连接，发送一个FIN给客户端（报文段6）。
4. 客户段发回ACK报文确认，并将确认序号设置为收到序号加1（报文段7）。



1. CLOSED：这个没什么好说的了，表示初始状态。
2. LISTEN：这个也是非常容易理解的一个状态，表示服务器端的某个SOCKET处于监听状态，可以接受连接了。
3. SYN_RCVD：这个状态表示接受到了SYN报文，在正常情况下，这个状态是服务器端的SOCKET在建立TCP连接时的三次握手会话过程中的一个中间状态，很短暂，基本上用netstat你是很难看到这种状态的，除非你特意写了一个客户端测试程序，故意将三次TCP握手过程中最后一个ACK报文不予发送。因此这种状态时，当收到客户端的ACK报文后，它会进入到ESTABLISHED状态。
4. SYN_SENT：这个状态与SYN_RCVD遥想呼应，当客户端SOCKET执行CONNECT连接时，它首先发送SYN报文，因此也随即它会进入到了SYN_SENT状态，并等待服务端的发送三次握手中的第2个报文。SYN_SENT状态表示客户端已发送SYN报文。
5. ESTABLISHED：这个容易理解了，表示连接已经建立了。
6. FIN_WAIT_1：这个状态要好好解释一下，其实FIN_WAIT_1和FIN_WAIT_2状态的真正含义都是表示等待对方的FIN报文。而这两种状态的区别是：FIN_WAIT_1状态实际上是当SOCKET在ESTABLISHED状态时，它想主动关闭连接，向对方发送了FIN报文，此时该SOCKET即进入到FIN_WAIT_1状态。而当对方回应ACK报文后，则进入到FIN_WAIT_2状态，当然在实际的正常情况下，无论对方何种情况下，都应该马上回应ACK报文，所以FIN_WAIT_1状态一般是比较难见到的，而FIN_WAIT_2状态还有时常常可以用netstat看到。
7. FIN_WAIT_2：上面已经详细解释了这种状态，实际上FIN_WAIT_2状态下的SOCKET，表示半连接，也即有一方要求close连接，但另外还告诉对方，我暂时还有点数据需要传送给你，稍后再关闭连接。
8. TIME_WAIT：表示收到了对方的FIN报文，并发送出了ACK报文，就等2MSL后即可回到CLOSED可用状态了。如果FIN_WAIT_1状态下，收到了对方同时带FIN标志和ACK标志的报文时，可以直接进入到TIME_WAIT状态，而无须经过FIN_WAIT_2状态。
9. 注:MSL(最大分段生存期)指明TCP报文在Internet上最长生存时间,每个具体的TCP实现都必须选择一个确定的MSL值.RFC 1122建议是2分钟,但BSD传统实现采用了30秒.TIME_WAIT 状态最大保持时间是2 * MSL,也就是1-4分钟.
10. CLOSING：这种状态比较特殊，实际情况中应该是很少见，属于一种比较罕见的例外状态。正常情况下，当你发送FIN报文后，按理来说是应该先收到（或同时收到）对方的ACK报文，再收到对方的FIN报文。但是CLOSING状态表示你发送FIN报文后，并没有收到对方的ACK报文，反而却也收到了对方的FIN报文。什么情况下会出现此种情况呢？其实细想一下，也不难得出结论：那就是如果双方几乎在同时close一个SOCKET的话，那么就出现了双方同时发送FIN报文的情况，也即会出现CLOSING状态，表示双方都正在关闭SOCKET连接。
11. CLOSE_WAIT：这种状态的含义其实是表示在等待关闭。怎么理解呢？当对方close一个SOCKET后发送FIN报文给自己，你系统毫无疑问地会回应一个ACK报文给对方，此时则进入到CLOSE_WAIT状态。接下来呢，实际上你真正需要考虑的事情是察看你是否还有数据发送给对方，如果没有的话，那么你也就可以close这个SOCKET，发送FIN报文给对方，也即关闭连接。所以你在CLOSE_WAIT状态下，需要完成的事情是等待你去关闭连接。
12. LAST_ACK：这个状态还是比较容易好理解的，它是被动关闭一方在发送FIN报文后，最后等待对方的ACK报文。当收到ACK报文后，也即可以进入到CLOSED可用状态了。



最后有2个问题的回答，我自己分析后的结论（不一定保证100%正确）

1、 为什么建立连接协议是三次握手，而关闭连接却是四次握手呢？

这是因为服务端的LISTEN状态下的SOCKET当收到SYN报文的建连请求后，它可以把ACK和SYN（ACK起应答作用，而SYN起同步作用）放在一个报文里来发送。但关闭连接时，当收到对方的FIN报文通知时，它仅仅表示对方没有数据发送给你了；但未必你所有的数据都全部发送给对方了，所以你可以未必会马上会关闭SOCKET,也即你可能还需要发送一些数据给对方之后，再发送FIN报文给对方来表示你同意现在可以关闭连接了，所以它这里的ACK报文和FIN报文多数情况下都是分开发送的。

2、 为什么TIME_WAIT状态还需要等2MSL后才能返回到CLOSED状态？

这是因为：虽然双方都同意关闭连接了，而且握手的4个报文也都协调和发送完毕，按理可以直接回到CLOSED状态（就好比从SYN_SEND状态到ESTABLISH状态那样）；但是因为我们必须要假想网络是不可靠的，你无法保证你最后发送的ACK报文会一定被对方收到，因此对方处于LAST_ACK状态下的SOCKET可能会因为超时未收到ACK报文，而重发FIN报文，所以这个TIME_WAIT状态的作用就是用来重发可能丢失的ACK报文，并保证于此。

查看当前系统下所有连接状态的数：

```
[root@vps ~]#netstat -n|awk '/^tcp/{++S[$NF]}END{for (key in S) print key,S[key]}'
TIME_WAIT 286
FIN_WAIT1 5
FIN_WAIT2 6
ESTABLISHED 269
SYN_RECV 5
CLOSING 1
```

如发现系统存在大量TIME_WAIT状态的连接，通过调整内核参数解决：

编辑文件/etc/sysctl.conf，加入以下内容：

```
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 30
```

然后执行 /sbin/sysctl -p 让参数生效。

```
net.ipv4.tcp_syncookies = 1 
```

表示开启SYN Cookies。当出现SYN等待队列溢出时，启用cookies来处理，可防范少量SYN攻击，默认为0，表示关闭；

```
net.ipv4.tcp_tw_reuse = 1 
```

表示开启重用。允许将TIME-WAIT sockets重新用于新的TCP连接，默认为0，表示关闭；

```
net.ipv4.tcp_tw_recycle = 1 
```

表示开启TCP连接中TIME-WAIT sockets的快速回收，默认为0，表示关闭。

```
net.ipv4.tcp_fin_timeout 
```

修改系默认的 TIMEOUT 时间



其它参数说明：

```
net.ipv4.tcp_syncookies = 1 
```

表示开启SYN Cookies。当出现SYN等待队列溢出时，启用cookies来处理，可防范少量SYN攻击，默认为0，表示关闭；

```
net.ipv4.tcp_tw_reuse = 1 
```

表示开启重用。允许将TIME-WAIT sockets重新用于新的TCP连接，默认为0，表示关闭；

```
net.ipv4.tcp_tw_recycle = 1 
```

表示开启TCP连接中TIME-WAIT sockets的快速回收，默认为0，表示关闭。

```
net.ipv4.tcp_fin_timeout = 30 
```

表示如果套接字由本端要求关闭，这个参数决定了它保持在FIN-WAIT-2状态的时间。

```
net.ipv4.tcp_keepalive_time = 1200 
```

表示当keepalive起用的时候，TCP发送keepalive消息的频度。缺省是2小时，改为20分钟。

```
net.ipv4.ip_local_port_range = 1024 65000
```

表示用于向外连接的端口范围。缺省情况下很小：32768到61000，改为1024到65000。

```
net.ipv4.tcp_max_syn_backlog = 8192 
```

表示SYN队列的长度，默认为1024，加大队列长度为8192，可以容纳更多等待连接的网络连接数。

```
net.ipv4.tcp_max_tw_buckets = 5000 
```

表示系统同时保持TIME_WAIT套接字的最大数量，如果超过这个数字，TIME_WAIT套接字将立刻被清除并打印警告信息。默认为180000，改为5000。对于Apache、Nginx等服务器，上几行的参数可以很好地减少TIME_WAIT套接字数量，但是对于Squid，效果却不大。此项参数可以控制TIME_WAIT套接字的最大数量，避免Squid服务器被大量的TIME_WAIT套接字拖死。

注:

```
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
```

设置这两个参数：

reuse是表示是否允许重新应用处于TIME-WAIT状态的socket用于新的TCP连接

recyse是加速TIME-WAIT sockets回收


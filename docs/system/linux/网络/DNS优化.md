## DNS速度优化

DNS优化，云主机中第一条往往是云平台的DNS，没有公网网站的解析记录，DNS默认查询等待时间比较长，可以手动增加查询限时增加DNS解析速度

可以在最后一行添加，options timeout:1 attempts:1 

最后一行 options timeout:1 attempts:1 是 DNS 客户端的配置选项，具体解释如下：

timeout:1：这表示 DNS 查询的超时时间为 1 秒。客户端将等待 1 秒钟以接收来自 DNS 服务器的响应。如果在这段时间内没有收到响应，它将尝试下一个服务器（如果有配置多个）。

attempts:1：这表示 DNS 查询的尝试次数为 1 次。客户端将尝试向 DNS 服务器发送查询一次。如果没有收到响应，它将不会再次尝试相同的服务器，而是继续下一个服务器（如果有配置多个）。



\# 锁定DNS,防止被篡改

```bash
chattr +i /etc/resolv.conf 
```

\#查看锁定权限

```bash
lsattr 文件名
```


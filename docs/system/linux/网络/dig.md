# dig命令和nslookup命令

### dig

`dig`（域信息搜寻器）是一个用于查询DNS（域名系统）的命令行工具，广泛用于网络管理员和IT专业人员中。这是一些基本的使用方法：

1. **查询域名的A记录（IP地址）**：
   ```
   dig example.com
   ```
   这个命令将显示与`example.com`相关的DNS信息，包括其A记录，即域名对应的IP地址。

2. **查询特定类型的记录**：
   你可以查询特定类型的DNS记录，如MX（邮件交换）记录、NS（名称服务器）记录等。
   ```
   dig example.com MX
   dig example.com NS
   ```

3. **指定DNS服务器**：
   你可以通过指定一个DNS服务器来进行查询，这对于检查特定DNS服务器上的记录很有用。
   ```
   dig @8.8.8.8 example.com
   ```
   这个例子使用了Google的公共DNS服务器（8.8.8.8）来查询`example.com`。

4. **查询逆向DNS记录**：
   逆向DNS查询用于查找与特定IP地址关联的域名。
   ```
   dig -x 192.0.2.1
   ```

5. **简化输出**：
   如果你只对结果中的某部分感兴趣，可以使用`+short`选项来简化输出。
   ```
   dig example.com +short
   ```

6. **详细输出**：
   使用`+trace`选项可以查看到域名解析的每一步，这对于诊断DNS问题非常有用。
   ```
   dig example.com +trace
   ```

7. **查看DNSSEC（DNS安全扩展）信息**：
   ```
   dig example.com +dnssec
   ```

这些只是`dig`工具的一些基本用法。由于`dig`是一个功能强大的工具，它还有许多其他选项和功能可以探索。



命令结果解释：

```bash
[root@VM-0-16-centos ~]# dig www.baidu.com

; <<>> DiG 9.11.4-P2-RedHat-9.11.4-26.P2.el7_9.14 <<>> www.baidu.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 5539
;; flags: qr rd ra; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;www.baidu.com.                 IN      A

;; ANSWER SECTION:
www.baidu.com.          380     IN      CNAME   www.a.shifen.com.
www.a.shifen.com.       60      IN      A       110.242.68.4
www.a.shifen.com.       60      IN      A       110.242.68.3

;; Query time: 1 msec
;; SERVER: 183.60.83.19#53(183.60.83.19)
;; WHEN: Thu Dec 21 12:34:59 CST 2023
;; MSG SIZE  rcvd: 90
```



这是使用`dig`命令查询`www.baidu.com`的DNS信息时得到的输出

`; <<>> DiG 9.11.4-P2-RedHat-9.11.4-26.P2.el7_9.14 <<>> www.baidu.com`：

这一行显示了`dig`命令的版本信息（9.11.4-P2-RedHat-9.11.4-26.P2.el7_9.14），以及被查询的域名（www.baidu.com）。

`;; global options: +cmd`：
这表示`dig`使用的全局选项，`+cmd`表示显示命令行参数。

`;; Got answer:`：
这表明下面的部分包含了对查询的响应。

`;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 5539`：
`opcode: QUERY`表示这是一个标准查询。
`status: NOERROR`表明查询成功，没有错误。
`id: 5539`是这次查询的唯一标识符。

`;; flags: qr rd ra; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 0`：
`flags`展示了不同的DNS标志：
`qr`（查询响应）表示这是一个响应消息。
`rd`（递归请求）表示客户端希望服务器进行递归查询。
`ra`（递归可用）表示服务器可以进行递归查询。
`QUERY: 1`意味着询问了一个问题。
`ANSWER: 3`表明收到了3个回答。
`AUTHORITY: 0`和`ADDITIONAL: 0`表示没有权威和附加部分的记录。

`;; QUESTION SECTION:`：
这是查询部分，显示了进行的查询。

`;www.baidu.com.                 IN      A`： 
这是实际的查询。查询`www.baidu.com`的`A`记录，即IP地址。

`;; ANSWER SECTION:`：
这部分包含了对查询的回答。

`www.baidu.com.          380     IN      CNAME   www.a.shifen.com.`：
这表明`www.baidu.com`是一个别名，实际的名称是`www.a.shifen.com`（CNAME记录）。

`www.a.shifen.com.       60      IN      A       110.242.68.4`：

`www.a.shifen.com.       60      IN      A       110.242.68.3`：
这两行显示`www.a.shifen.com`的A记录，即其IP地址，分别为110.242.68.4和110.242.68.3。

`;; Query time: 1 msec`：
查询耗时1毫秒。

`;; SERVER: 183.60.83.19#53(183.60.83.19)`：
指出了响应查询的DNS服务器的IP地址和端口号（183.60.83.19，端口53）。

`;; WHEN: Thu Dec 21 12:34:59 CST 2023`：
查询发生的时间。

`;; MSG SIZE  rcvd: 90`：
接收到的消息大小为90字节。

这个输出提供了详细的信息关于`www.baidu.com`的DNS记录，包括其CNAME记录和相应的IP地址。

### nslookup

`nslookup` 是一个功能强大的网络管理员工具，用于查询DNS（域名系统）来获取域名或IP地址的相关信息。这里是一些基本和高级的 `nslookup` 用法：

基础查询

1. **查询域名的IP地址**:
   
   ```bash
   nslookup example.com
   ```
   这会返回 `example.com` 的IP地址。
   
2. **反向DNS查询（根据IP地址查询域名）**:
   ```bash
   nslookup 192.0.2.1
   ```
   这会返回与IP地址 `192.0.2.1` 关联的域名。

指定DNS服务器

- **使用特定DNS服务器查询**:
  ```bash
  nslookup example.com 8.8.8.8
  ```
  使用Google的DNS服务器（8.8.8.8）查询 `example.com`。

查询特定类型的DNS记录

1. **查询MX（邮件交换）记录**:
   ```bash
   nslookup -type=mx example.com
   ```
   查询 `example.com` 的邮件服务器记录。

2. **查询NS（名称服务器）记录**:
   ```bash
   nslookup -type=ns example.com
   ```
   
   查询管理 `example.com`的TXT记录，常用于SPF记录或其他验证信息。

4. **查询A（地址）记录**:
   ```bash
   nslookup -type=a example.com
   ```
   查询 `example.com` 的IPv4地址。

5. **查询AAAA（IPv6地址）记录**:
   ```bash
   nslookup -type=aaaa example.com
   ```
   查询 `example.com` 的IPv6地址。

使用交互模式

- **进入交互模式**:
  ```bash
  nslookup
  ```
  在交互模式下，可以连续进行多次查询而无需重复输入 `nslookup`。

- **在交互模式中设置类型**:
  ```bash
  > set type=mx
  > example.com
  ```
  首先设置查询类型为MX，然后查询 `example.com`。

- **退出交互模式**:
  ```bash
  > exit
  ```

高级用法

1. **开启详细输出**:
   ```bash
   nslookup -debug example.com
   ```
   提供查询过程的详细信息，有助于调试。

2. **查询SOA（起始授权）记录**:
   ```bash
   nslookup -type=soa example.com
   ```
   查询 `example.com` 的SOA记录，包含关于域名管理的信息。

注意事项

- 在使用 `nslookup` 时，确保输入正确的域名或IP地址。
- 不同的操作系统或 `nslookup` 的版本可能在命令行选项上有所差异。
- `nslookup` 主要用于诊断和解决DNS相关的问题，对于日常的网络问题排查非常有用。

通过这些不同的命令和选项，可以探索和理解域名系统的工作方式及其配置。



命令结果解释：

```bash
[root@VM-0-16-centos ~]# nslookup www.baidu.com
Server:         183.60.83.19
Address:        183.60.83.19#53

Non-authoritative answer:
www.baidu.com   canonical name = www.a.shifen.com.
Name:   www.a.shifen.com
Address: 220.181.38.149
Name:   www.a.shifen.com
Address: 220.181.38.150
Name:   www.a.shifen.com
Address: 240e:83:205:58:0:ff:b09f:36bf
Name:   www.a.shifen.com
Address: 240e:83:205:5a:0:ff:b05f:346b
```



下面是对您提供的 `nslookup` 查询结果的逐行解释：

`[root@VM-0-16-centos ~]# nslookup www.baidu.com`

这是您在命令行界面输入的命令，表示您要使用 `nslookup` 工具查询 `www.baidu.com` 域名的DNS信息。

`Server: 183.60.83.19`
这一行表示处理您的DNS查询的服务器的IP地址是 `183.60.83.19`。这是您的网络配置中指定的DNS服务器，或者是您系统默认的DNS服务器。

`Address: 183.60.83.19#53`
 这一行显示了上述DNS服务器的IP地址 (`183.60.83.19`) 和使用的端口号 (`#53`)。DNS查询通常使用53端口。

`Non-authoritative answer`
这意味着这个响应不是来自存储有 `www.baidu.com` 域名记录的权威DNS服务器，而是来自一个缓存这些信息的服务器。非权威回答通常来自本地DNS服务器或ISP的DNS服务器。

`www.baidu.com canonical name = www.a.shifen.com.`
这表明 `www.baidu.com` 有一个CNAME（规范名）记录指向 `www.a.shifen.com`。CNAME记录是一种DNS记录，它将一个域名映射到另一个域名。在这种情况下，当你访问 `www.baidu.com` 时，实际上被引导到 `www.a.shifen.com`。

`Name: www.a.shifen.com`
这一行表明接下来的IP地址属于 `www.a.shifen.com`。

`Address: 220.181.38.149`
这是 `www.a.shifen.com` 的一个IPv4地址。这意味着 `www.baidu.com`（通过 `www.a.shifen.com`）可以通过这个IP地址访问。

`Name: www.a.shifen.com`

`Address: 220.181.38.150`
这是另一个IPv4地址，属于同一个域名（`www.a.shifen.com`）。多个地址的存在可能是为了负载均衡和冗余。

`Name: www.a.shifen.com`
`Address: 240e:83:205:58:0:ff:b09f:36bf`
这是 `www.a.shifen.com` 的一个IPv6地址，提供了一个IPv6网络的访问点。

`Name: www.a.shifen.com`
`Address: 240e:83:205:5a:0:ff:b05f:346b`
另一个IPv6地址，同样属于 `www.a.shifen.com`。与IPv4地址类似，多个IPv6地址的存在可能也是出于负载均衡和冗余的考虑。

总的来说，这个 `nslookup` 查询展示了 `www.baidu.com` 如何通过CNAME记录指向 `www.a.shifen.com`，以及后者的多个IPv4和IPv6地址，这些地址可能用于处理不同的网络请求，确保可靠性和高效性。

# dig命令

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

- 这一行显示了`dig`命令的版本信息（9.11.4-P2-RedHat-9.11.4-26.P2.el7_9.14），以及被查询的域名（www.baidu.com）。

`;; global options: +cmd`：
- 这表示`dig`使用的全局选项，`+cmd`表示显示命令行参数。

`;; Got answer:`：
- 这表明下面的部分包含了对查询的响应。

`;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 5539`：
- `opcode: QUERY`表示这是一个标准查询。
- `status: NOERROR`表明查询成功，没有错误。
- `id: 5539`是这次查询的唯一标识符。

`;; flags: qr rd ra; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 0`：
- `flags`展示了不同的DNS标志：
  - `qr`（查询响应）表示这是一个响应消息。
  - `rd`（递归请求）表示客户端希望服务器进行递归查询。
  - `ra`（递归可用）表示服务器可以进行递归查询。
- `QUERY: 1`意味着询问了一个问题。
- `ANSWER: 3`表明收到了3个回答。
- `AUTHORITY: 0`和`ADDITIONAL: 0`表示没有权威和附加部分的记录。

`;; QUESTION SECTION:`：
- 这是查询部分，显示了进行的查询。

`;www.baidu.com.                 IN      A`：
- 这是实际的查询。查询`www.baidu.com`的`A`记录，即IP地址。

`;; ANSWER SECTION:`：
- 这部分包含了对查询的回答。

`www.baidu.com.          380     IN      CNAME   www.a.shifen.com.`：
- 这表明`www.baidu.com`是一个别名，实际的名称是`www.a.shifen.com`（CNAME记录）。

`www.a.shifen.com.       60      IN      A       110.242.68.4`：

`www.a.shifen.com.       60      IN      A       110.242.68.3`：
- 这两行显示`www.a.shifen.com`的A记录，即其IP地址，分别为110.242.68.4和110.242.68.3。

`;; Query time: 1 msec`：
- 查询耗时1毫秒。

`;; SERVER: 183.60.83.19#53(183.60.83.19)`：
- 指出了响应查询的DNS服务器的IP地址和端口号（183.60.83.19，端口53）。

`;; WHEN: Thu Dec 21 12:34:59 CST 2023`：
- 查询发生的时间。

`;; MSG SIZE  rcvd: 90`：
- 接收到的消息大小为90字节。

这个输出提供了详细的信息关于`www.baidu.com`的DNS记录，包括其CNAME记录和相应的IP地址。




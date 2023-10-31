

# curl命令



```bash
使用方式：curl [选项...] <url>
选项：(H) 代表仅适用于 HTTP/HTTPS，(F) 代表仅适用于 FTP
     --anyauth       选择“任何”认证方式 (H)
 -a, --append        上传时追加到目标文件 (F/SFTP)
     --basic         使用 HTTP 基本认证 (H)
     --cacert FILE   用于对等方验证的 CA 证书 (SSL)
     --capath DIR    用于对等方验证的 CA 目录 (SSL)
 -E, --cert CERT[:PASSWD] 客户端证书文件和密码 (SSL)
     --cert-type TYPE 证书文件类型 (DER/PEM/ENG) (SSL)
     --ciphers LIST  要使用的 SSL 密码 (SSL)
     --compressed    请求压缩响应 (使用 deflate 或 gzip)
 -K, --config FILE   指定要读取的配置文件
     --connect-timeout SECONDS  连接的最长允许时间
 -C, --continue-at OFFSET  恢复传输的偏移量
 -b, --cookie STRING/FILE  从字符串或文件读取 cookie (H)
 -c, --cookie-jar FILE  操作后将 cookie 写入此文件 (H)
     --create-dirs   创建必要的本地目录结构
     --crlf          上传时将 LF 转换为 CRLF
     --crlfile FILE  从给定文件获取 PEM 格式的 CRL 列表
 -d, --data DATA     HTTP POST 数据 (H)
     --data-ascii DATA  HTTP POST ASCII 数据 (H)
     --data-binary DATA  HTTP POST 二进制数据 (H)
     --data-urlencode DATA  HTTP POST 数据 URL 编码 (H)
     --delegation STRING GSS-API 委派权限
     --digest        使用 HTTP 摘要认证 (H)
     --disable-eprt  禁止使用 EPRT 或 LPRT (F)
     --disable-epsv  禁止使用 EPSV (F)
 -D, --dump-header FILE  将头信息写入此文件
     --egd-file FILE  EGD 套接字路径，用于随机数据 (SSL)
     --engine ENGINGE  加密引擎 (SSL)。“--engine list” 显示列表
 -f, --fail          在 HTTP 错误时静默失败（完全没有输出）(H)
 -F, --form CONTENT  指定 HTTP 多部分 POST 数据 (H)
     --form-string STRING  指定 HTTP 多部分 POST 数据 (H)
     --ftp-account DATA  账户数据字符串 (F)
     --ftp-alternative-to-user COMMAND  用于替换 “USER [name]” 的字符串 (F)
     --ftp-create-dirs  如果远程目录不存在，则创建 (F)
     --ftp-method [MULTICWD/NOCWD/SINGLECWD] 控制 CWD 使用 (F)
     --ftp-pasv      使用 PASV/EPSV 而不是 PORT (F)
 -P, --ftp-port ADR  使用 PORT 以及给定地址而非 PASV (F)
     --ftp-skip-pasv-ip 跳过 PASV 的 IP 地址 (F)
     --ftp-pret      在 PASV 之前发送 PRET（用于 drftpd）(F)
     --ftp-ssl-ccc   在认证后发送 CCC (F)
     --ftp-ssl-ccc-mode ACTIVE/PASSIVE  设置 CCC 模式 (F)
     --ftp-ssl-control 对于 ftp 登录要求 SSL/TLS，传输时清除 (F)
 -G, --get           使用 HTTP GET 发送 -d 数据 (H)
 -g, --globoff       禁用使用 {} 和 [] 的 URL 序列和范围
 -H, --header LINE   发送给服务器的自定义头信息 (H)
 -I, --head          仅显示文档信息
 -h, --help          此帮助文本
     --hostpubmd5 MD5  宿主公钥的十六进制编码 MD5 字符串 (SSH)
 -0, --http1.0       使用 HTTP 1.0 (H)
     --ignore-content-length  忽略 HTTP Content-Length 头
 -i, --include       在输出中包含协议头 (H/F)
 -k, --insecure      允许连接到没有证书的 SSL 站点 (H)
     --interface INTERFACE  指定要使用的网络接口/地址
 -4, --ipv4          将名称解析为 IPv4 地址
 -6, --ipv6          将名称解析为 IPv6 地址
 -j, --junk-session-cookies  忽略从文件读取的会话 cookie (H)
     --keepalive-time SECONDS  保持活动探测之间的间隔
     --key KEY       私钥文件名 (SSL/SSH)
     --key-type TYPE 私钥文件类型 (DER/PEM/ENG) (SSL)
     --krb LEVEL     启用 Kerberos，并指定安全级别 (F)
     --libcurl FILE  将此命令行的 libcurl 等效代码转储
     --limit-rate RATE  将传输速度限制为此速率
 -l, --list-only     仅列出 FTP 目录的名称 (F)
     --local-port RANGE  强制使用这些本地端口号
 -L, --location      跟随重定向 (H)
     --location-trusted 像 --location 一样，但发送认证到其他主机 (H)
 -M, --manual        显示完整手册
     --mail-from FROM  从这个地址发邮件
     --mail-rcpt TO  发邮件给这个接收者/接收者们
     --mail-auth AUTH  原始电子邮件的发起人地址
     --max-filesize BYTES  要下载的最大文件大小 (H/F)
     --max-redirs NUM  允许的最大重定向次数 (H)
 -m, --max-time SECONDS  传输所允许的最大时间
     --metalink      将给定的 URL 当作 metalink XML 文件处理
     --negotiate     使用 HTTP Negot
 -o, --output FILE 将输出写入<file>，而不是标准输出
     --pass PASS 私钥的通行短语（SSL/SSH）
     --post301 在跟随301重定向后不切换到GET（H）
     --post302 在跟随302重定向后不切换到GET（H）
     --post303 在跟随303重定向后不切换到GET（H）
 -#, --progress-bar 以进度条形式显示传输进度
     --proto PROTOCOLS 启用/禁用指定协议
     --proto-redir PROTOCOLS 在重定向时启用/禁用指定协议
 -x, --proxy [PROTOCOL://]HOST[:PORT] 使用给定端口上的代理
     --proxy-anyauth 选择“任意”代理认证方式（H）
     --proxy-basic 在代理上使用基本认证（H）
     --proxy-digest 在代理上使用摘要认证（H）
     --proxy-negotiate 在代理上使用协商认证（H）
     --proxy-ntlm 在代理上使用NTLM认证（H）
 -U, --proxy-user USER[:PASSWORD] 代理用户和密码
     --proxy1.0 HOST[:PORT] 使用给定端口上的HTTP/1.0代理
 -p, --proxytunnel 通过HTTP代理隧道操作（使用CONNECT）
     --pubkey KEY 公钥文件名（SSH）
 -Q, --quote CMD 在传输前向服务器发送命令（F/SFTP）
     --random-file FILE 从中读取随机数据的文件（SSL）
 -r, --range RANGE 只检索范围内的字节
     --raw 以HTTP“原始”方式进行，不进行任何传输解码（H）
 -e, --referer 引用URL（H）
 -J, --remote-header-name 使用头文件提供的文件名（H）
 -O, --remote-name 将输出写入一个命名为远程文件的文件
     --remote-name-all 对所有URL使用远程文件名
 -R, --remote-time 在本地输出上设置远程文件的时间
 -X, --request COMMAND 指定要使用的请求命令
     --resolve HOST:PORT:ADDRESS 强制解析HOST:PORT为ADDRESS
     --retry NUM 如遇到暂时性问题，重试请求NUM次
     --retry-delay SECONDS 重试时，每次之间等待这么多秒
     --retry-max-time SECONDS 只在此期间内重试
 -S, --show-error 显示错误。与-s一起使用时，使curl在出现错误时显示错误
 -s, --silent 静默模式。不输出任何东西
     --socks4 HOST[:PORT] 在给定的主机+端口上使用SOCKS4代理
     --socks4a HOST[:PORT] 在给定的主机+端口上使用SOCKS4a代理
     --socks5 HOST[:PORT] 在给定的主机+端口上使用SOCKS5代理
     --socks5-basic 启用SOCKS5代理的用户名/密码认证
     --socks5-gssapi 启用SOCKS5代理的GSS-API认证
     --socks5-hostname HOST[:PORT] SOCKS5代理，将主机名传递给代理
     --socks5-gssapi-service NAME SOCKS5代理的gssapi服务名
     --socks5-gssapi-nec 与NEC SOCKS5服务器的兼容性
 -Y, --speed-limit RATE 在'speed-time'秒内停止低于速度限制的传输
 -y, --speed-time SECONDS 触发速度限制中止的时间。默认为30秒
     --ssl 尝试SSL/TLS（FTP, IMAP, POP3, SMTP）
     --ssl-reqd 要求SSL/TLS（FTP, IMAP, POP3, SMTP）
 -2, --sslv2 使用SSLv2（SSL）
 -3, --sslv3 使用SSLv3（SSL）
     --ssl-allow-beast 允许安全漏洞以提高互操作性（SSL）
     --stderr FILE 将stderr重定向到哪里。- 表示标准输出
     --tcp-nodelay 使用TCP_NODELAY选项
 -t, --telnet-option OPT=VAL 设置telnet选项
     --tftp-blksize VALUE 设置TFTP BLKSIZE选项（必须>512）
 -z, --time-cond TIME 基于时间条件进行传输
 -1, --tlsv1 使用 => TLSv1（SSL）
     --tlsv1.0 使用TLSv1.0（SSL）
     --tlsv1.1 使用TLSv1.1（SSL）
     --tlsv1.2 使用TLSv1.2（SSL）
     --tlsv1.3 使用TLSv1.3（SSL）
     --tls-max VERSION 使用TLS最多到VERSION（SSL）
     --trace FILE 将调试跟踪写入给定文件
     --trace-ascii FILE 像--trace一样，但没有十六进制输出
     --trace-time 在跟踪/详细输出中添加时间戳
     --tr-encoding 请求压缩的传输编码（H）
 -T, --upload-file FILE 将FILE传输到目的地
     --url URL 要处理的URL
 -B, --use-ascii 使用ASCII/文本传输
 -u, --user USER[:PASSWORD] 服务器用户和密码
     --tlsuser USER TLS用户名
     --tlspassword STRING TLS密码
     --tlsauthtype STRING TLS认证类型（默认SRP）
     --unix-socket FILE 通过这个UNIX域套接字连接
 -A, --user-agent STRING 发送到服务器的User-Agent（H）
 -v, --verbose 使操作更加详细
 -V, --version 显示版本号并退出
 -w, --write-out FORMAT 完成后输出什么
     --xattr 在扩展文件属性中存储元数据
 -q 如果作为第一个参数使用，则禁用.curlrc
```



`curl` 是一个非常强大的命令行工具，它用于传输数据，通常用于HTTP请求。下面是一些常用的 `curl` 用法：

1. **简单的GET请求**：
   
   ```bash
   curl http://example.com
   ```
   
2. **带有头信息的GET请求**：
   ```bash
   curl -H "Content-Type: application/json" http://example.com
   ```

3. **发送POST请求**：
   ```bash
   curl -X POST http://example.com
   ```

4. **发送POST请求携带数据**：
   ```bash
   curl -X POST -d "param1=value1&param2=value2" http://example.com
   ```

5. **以JSON格式发送POST数据**：
   ```bash
   curl -X POST -H "Content-Type: application/json" -d '{"param1":"value1", "param2":"value2"}' http://example.com
   ```

6. **使用基本的HTTP认证**：
   ```bash
   curl -u username:password http://example.com
   ```

7. **保存输出到文件**：
   ```bash
   curl -o filename.html http://example.com
   ```

8. **从文件中读取POST数据**：
   ```bash
   curl -X POST -d @data.txt http://example.com
   ```

9. **发送PUT请求**：
   ```bash
   curl -X PUT -d "param=value" http://example.com
   ```

10. **删除请求**：
    ```bash
    curl -X DELETE http://example.com/resource
    ```

11. **设置超时时间**：
    ```bash
    curl -m 10 http://example.com
    ```

12. **通过代理发送请求**：
    ```bash
    curl -x http://proxyserver:port http://example.com
    ```

13. **显示请求头信息**：
    ```bash
    curl -I http://example.com
    ```

14. **下载文件并重命名**：
    ```bash
    curl -o newfilename.html http://example.com/oldfilename.html
    ```

15. **断点续传下载文件**：
    ```bash
    curl -C - -O http://example.com/bigfile.zip
    ```

16. **使用HTTPS协议，并忽略SSL证书检查**：
    ```bash
    curl -k https://example.com
    ```

17. **显示详细的连接信息**：
    ```bash
    curl -v http://example.com
    ```

`curl` 的用法非常广泛，上面这些是一些常见和基本的用法。你可以根据实际需求进行选择和组合。



[curl 命令，Linux curl 命令详解：利用URL规则在命令行下工作的文件传输工具 - Linux 命令搜索引擎 (wangchujiang.com)](https://wangchujiang.com/linux-command/c/curl.html)
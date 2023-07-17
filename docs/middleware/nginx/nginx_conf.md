# Nginx配置文件详解

一些有帮助的文档：

[Nginx 配置详解 | 菜鸟教程 (runoob.com)](https://www.runoob.com/w3cnote/nginx-setup-intro.html)

源码安装后的默认配置

配置文件中关键字都可以在官网文档[Alphabetical index of directives (p2hp.com)](https://nginx.p2hp.com/en/docs/dirindex.html)  中进行搜索。并给出关键字的设置范围。

1. **全局块**：配置影响nginx全局的指令。一般有运行nginx服务器的用户组，nginx进程pid存放路径，日志存放路径，配置文件引入，允许生成worker process数等。
2. **events块**：配置影响nginx服务器或与用户的网络连接。有每个进程的最大连接数，选取哪种事件驱动模型处理连接请求，是否允许同时接受多个网路连接，开启多个网络连接序列化等。
3. **http块**：可以嵌套多个server，配置代理，缓存，日志定义等绝大多数功能和第三方模块的配置。如文件引入，mime-type定义，日志自定义，是否使用sendfile传输文件，连接超时时间，单连接请求数等。
4. **server块**：配置虚拟主机的相关参数，一个http中可以有多个server。
5. **location块**：配置请求的路由，以及各种页面的处理情况

```bash
[root@VM-0-16-centos conf]# cd /usr/local/webserver/nginx/conf/
[root@VM-0-16-centos conf]# cat nginx.conf | grep -v "^[[:blank:]]*#"  | grep -v '^#' | grep -v '^$'  #去掉注释
worker_processes  1;  
#nginx有一个主进程和几个工作进程。主进程的主要目的是读取和评估配置，
#并维护工作进程。工作进程对请求进行实际处理。nginx采用基于事件的模型
#和依赖于操作系统的机制来有效地在工作进程之间分发请求。工作进程的数量
#在配置文件中定义，并且可以针对 给定配置 或 自动调整 。 此处值可以设
#置成数字，也可以设置成auto  详情解释：https://nginx.p2hp.com/en/docs/ngx_core_module.html#worker_processes

events {
    worker_connections  1024;
    #单个后台worker process进程的最大并发链接数
}
http {
    include       mime.types;
#      mime.types 设定mime类型(邮件支持类型),类型由mime.types文件定义
#      include 在配置中包含另一个或与指定文件匹配的文件。包含的文件应由语法正确的指令和块组成。
    default_type  application/octet-stream;
    #default_type  定义响应的默认MIME类型。可以使用类型指令设置文件扩展名映射到MIME类型。
    sendfile        on;
    # sendfile 启用或禁用 sendfile()的使用.从 nginx 0.8.12 和 FreeBSD 5.2.1 开始，可以使用 aio 来预加载数据 为：sendfile()
    # https://nginx.p2hp.com/en/docs/http/ngx_http_core_module.html#sendfile
    keepalive_timeout  65;
    #  keepalive_timeout  设置一个超时，在此期间，服务器端的保持活动客户端连接将保持打开状态
    server {
        listen       80;
        # listen 设置IP的地址和端口，或服务器接受请求的UNIX域套接字的路径。可以指定地址和端口，或者只能指定地址或端口。地址也可以是主机名
        server_name  localhost;
        # server_name 设置虚拟服务器的名称
        location / {
        # location 根据请求 URI 设置配置。
            root   html;
            # root 设置请求的根目录
            index  index.html index.htm;
            # 定义将用作索引的文件。 名称可以包含变量。 按指定顺序检查文件。 列表的最后一个元素可以是具有绝对路径的文件。
        }
        error_page   500 502 503 504  /50x.html;
        # 定义将为指定错误显示的 URI。 值可以包含变量。
        location = /50x.html {
            root   html;
        }
    }
}
```





完整的默认nginx配置

```bash

#user  nobody; 
#user  定义工作进程使用的用户 不填写默认为nobody
worker_processes  1;
#nginx有一个主进程和几个工作进程。主进程的主要目的是读取和评估配置，
#并维护工作进程。工作进程对请求进行实际处理。nginx采用基于事件的模型
#和依赖于操作系统的机制来有效地在工作进程之间分发请求。工作进程的数量
#在配置文件中定义，并且可以针对 给定配置 或 自动调整 。 此处值可以设
#置成数字，也可以设置成auto  详情解释：https://nginx.p2hp.com/en/docs/ngx_core_module.html#worker_processes

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;
# 定义错误日志和级别

#pid        logs/nginx.pid;
# 定义一个文件，该文件将存储主进程的进程ID。 默认在 logs/nginx.pid



events {
    worker_connections  1024;
    # 单个后台worker process进程的最大并发链接数
}


http {
    include       mime.types;
    # mime.types 设定mime类型(邮件支持类型),类型由mime.types文件定义
    # include 在配置中包含另一个或与指定文件匹配的文件。包含的文件应由语法正确的指令和块组成。
    default_type  application/octet-stream;
    # default_type  定义响应的默认MIME类型。可以使用类型指令设置文件扩展名映射到MIME类型。

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';
    # 指定日志格式。 格式的名字  定义要记录哪些东西
    # 需要记录哪些字段，可以从此网页上查看
    # https://nginx.p2hp.com/en/docs/http/ngx_http_core_module.html#variables_hash_max_size
    # 例如如下
    # $bytes_sent
    # 发送到客户端的字节数
    # $connection
    # 连接序列号
    # $connection_requests
    # 通过连接发出的当前请求数 （1.1.18）
    # $msec
    # 以秒为单位的时间，日志写入时分辨率为毫秒
    # $pipe
    # “” if request was pipelined, “” otherwise p.
    # $request_length
    # 请求长度（包括请求行、标头和请求正文）
    # $request_time
    # 请求处理时间（以秒为单位），分辨率为毫秒;
    # $status
    # 响应状态
    # $time_iso8601
    # ISO 8601 标准格式的当地时间
    # $time_local
    # 通用日志格式的本地时间
    

    #access_log  logs/access.log  main;
    # 定义访问日志 路径 及格式

    sendfile        on;
    # sendfile 启用或禁用 sendfile()的使用.从 nginx 0.8.12 和 FreeBSD 5.2.1 开始，可以使用 aio 来预加载数据 为：sendfile()
    #tcp_nopush     on;
    # 启用或禁用FreeBSD上的套接字选项或Linux上的套接字选项。仅当使用sendfile时，才会启用这些选项。启用该选项允许TCP_NOPUSHTCP_CORK

    #keepalive_timeout  0;
    keepalive_timeout  65;
    #  keepalive_timeout  设置一个超时，在此期间，服务器端的保持活动客户端连接将保持打开状态

    #gzip  on;
    #启用或禁用响应的 gziping。

    server {
        listen       80;
        # listen 设置IP的地址和端口，或服务器接受请求的UNIX域套接字的路径。可以指定地址和端口，或者只能指定地址或端口。地址也可以是主机名
        server_name  localhost;
				# server_name 设置虚拟服务器的名称
        #charset koi8-r;
        # 将指定的字符集添加到“内容类型” 响应标头字段。

        #access_log  logs/host.access.log  main;
        # 这个server的访问日志

        location / {
        # location 根据请求 URI 设置配置。
            root   html;
            # root 设置请求的根目录
            index  index.html index.htm;
            # 定义将用作索引的文件。 名称可以包含变量。 按指定顺序检查文件。 列表的最后一个元素可以是具有绝对路径的文件。
        }

        #error_page  404              /404.html;
         # 定义将为指定错误显示的 URI。 值可以包含变量。

        # redirect server error pages to the static page /50x.html
        # 将服务器错误页面重定向到静态页面/50x.html
        error_page   500 502 503 504  /50x.html;
         
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        # 在127.0.0.1:80上将PHP脚本代理到Apache监听
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        # 设置代理服务器的协议和地址，以及应映射位置的可选URI。作为协议，可以指定“”或“”。
        # 地址可以指定为域名或IP地址，以及可选端口。 可以设置一组服务器，用服务器组进行设置
        # https://nginx.p2hp.com/en/docs/http/ngx_http_proxy_module.html#proxy_pass
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        # 将PHP脚本传递到FastCGI服务器，在127.0.0.1:9000上监听
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    设置 FastCGI 服务器的地址。 地址可以指定为域名或 IP 地址， 和一个端口：
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root concurs with nginx's one
        # 如果Apache的文档根与nginx的文档根一致，则拒绝访问.htaccess文件
        #location ~ /\.ht {
        #    deny  all;
        #}
    }


    # another virtual host using mix of IP-, name-, and port-based configuration
    # 另一个使用基于IP、名称和端口的配置组合的虚拟主机
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;

    #    ssl_certificate      cert.pem;
    #    为给定的虚拟服务器指定具有PEM格式证书。如果除了主证书之外还应指定中间证书，则应在同一文件中按以下顺序指定它们：先指定主证书，然后指定中间证书。PEM格式的密钥可以被放置在相同的文件中。
    #    ssl_certificate_key  cert.key;
    #    key格式的证书

    #    ssl_session_cache    shared:SSL:1m;
    #    设置存储会话参数的缓存的类型和大小。
    #    ssl_session_timeout  5m;
    #    指定客户端可以重用会话参数的时间。

    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    指定启用的密码。 密码以 OpenSSL库
    #    ssl_prefer_server_ciphers  on;
    #    指定服务器密码应优先于客户端 使用 SSLv3 和 TLS 协议时的密码
    #    

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

}
```


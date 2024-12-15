## Nginx相关地址

源码：https://trac.nginx.org/nginx/browser

官网：http://www.nginx.org/

中文教程：https://github.com/taobao/nginx-book

中文简单教程：https://github.com/dunwu/nginx-tutorial



## Nginx安装

nginx最常见的安装方式是源码进行安装，主要原因是好维护，虽然官方提供了rpm，YUM等安装方式。下面的部署方式是在CentOS7下

通常会把源码包放在Linux系统中的 `/usr/local/src` 目录下，这个目录是存放本地源代码的目录

这个目录的使用规则是个约定俗称的一个规范，这里放一个百科地址：[Filesystem Hierarchy Standard - Wikipedia](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard) ，百科下面有Linux基金会官方的地址

Linux基金会提供了一个网页版本的目录介绍：[4.9. /usr/local : Local hierarchy (linuxfoundation.org)](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04s09.html)





##### 1、安装依赖

```bash
[root@VM-0-16-centos src]# yum install -y gcc gcc-c++ make  zlib zlib-devel gcc-c++ openssl-devel
[root@VM-0-16-centos src]# yum install -y libtool
[root@VM-0-16-centos src]# yum install -y openssl
```

安装依赖 pcre2

PCRE官网 [PCRE - Perl Compatible Regular Expressions](http://www.pcre.org/)

```bash
[root@VM-0-16-centos ~]# cd /usr/local/src
[root@VM-0-16-centos src]# wget https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.42/pcre2-10.42.tar.gz
[root@VM-0-16-centos src]# ls
pcre2-10.42.tar.gz
[root@VM-0-16-centos src]#  tar -zxvf pcre2-10.42.tar.gz
[root@VM-0-16-centos src]# ls
pcre2-10.42  pcre2-10.42.tar.gz
[root@VM-0-16-centos src]# cd pcre2-10.42
[root@bogon pcre2-10.42]# ./configure
[root@bogon pcre2-10.42]# make && make install
```



##### 2、下载安装包

官网下载地址：[nginx: 下载 (p2hp.com)](https://nginx.p2hp.com/en/download.html)

```bash
[root@VM-0-16-centos ~]# cd /usr/local/src
[root@VM-0-16-centos src]# wget http://nginx.org/download/nginx-1.24.0.tar.gz
nginx-1.24.0.tar.gz            100%[===================================================>]   1.06M  27.7KB/s    in 54s     
[root@VM-0-16-centos src]# ls
nginx-1.24.0.tar.gz
```



##### 3、编译并安装

解压安装包

```bash
[root@VM-0-16-centos src]# ls
nginx-1.24.0.tar.gz  pcre2-10.42  pcre2-10.42.tar.gz
[root@VM-0-16-centos src]# tar -zxvf nginx-1.24.0.tar.gz
[root@VM-0-16-centos src]# ls
nginx-1.24.0  nginx-1.24.0.tar.gz  pcre2-10.42  pcre2-10.42.tar.gz
```

对nginx编译前配置

- [ ] `--prefix=/usr/local/webserver/nginx #安装路径
  `
- [ ] `--with-http_stub_status_module  该模块提供 访问基本状态信息
  `
- [ ] `--with-http_ssl_module 该模块提供 对 HTTPS 的必要支持
  `
- [ ] `--with-pcre 设置 PCRE库的源码的路径。 该库被ngx_http_rewrite_module模块所需要`
- [ ] `--user=nginx`：指定 Nginx 使用的用户。
- [ ] `--group=nginx`：指定 Nginx 使用的用户组。



```bash
[root@VM-0-16-centos src]# ls
nginx-1.24.0  nginx-1.24.0.tar.gz  pcre2-10.42  pcre2-10.42.tar.gz
[root@VM-0-16-centos src]# cd nginx-1.24.0
[root@VM-0-16-centos nginx-1.24.0]# ./configure --prefix=/usr/local/webserver/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre=/usr/local/src/pcre2-10.42  --user=nginx --group=nginx 
...
...
Configuration summary
  + using PCRE2 library: /usr/local/src/pcre2-10.42
  + using system OpenSSL library
  + using system zlib library

  nginx path prefix: "/usr/local/webserver/nginx"
  nginx binary file: "/usr/local/webserver/nginx/sbin/nginx"
  nginx modules path: "/usr/local/webserver/nginx/modules"
  nginx configuration prefix: "/usr/local/webserver/nginx/conf"
  nginx configuration file: "/usr/local/webserver/nginx/conf/nginx.conf"
  nginx pid file: "/usr/local/webserver/nginx/logs/nginx.pid"
  nginx error log file: "/usr/local/webserver/nginx/logs/error.log"
  nginx http access log file: "/usr/local/webserver/nginx/logs/access.log"
  nginx http client request body temporary files: "client_body_temp"
  nginx http proxy temporary files: "proxy_temp"
  nginx http fastcgi temporary files: "fastcgi_temp"
  nginx http uwsgi temporary files: "uwsgi_temp"
  nginx http scgi temporary files: "scgi_temp"
  
  
[root@VM-0-16-centos nginx-1.24.0]# make && make install  
[root@VM-0-16-centos nginx-1.24.0]# useradd -r -s /sbin/nologin nginx
[root@VM-0-16-centos nginx]# pwd
/usr/local/webserver/nginx
[root@VM-0-16-centos nginx]# chown -R nginx:nginx /usr/local/webserver/nginx
[root@VM-0-16-centos nginx]# tree
.
├── conf #默认配置目录
│   ├── fastcgi.conf
│   ├── fastcgi.conf.default
│   ├── fastcgi_params
│   ├── fastcgi_params.default
│   ├── koi-utf
│   ├── koi-win
│   ├── mime.types
│   ├── mime.types.default
│   ├── nginx.conf
│   ├── nginx.conf.default
│   ├── scgi_params
│   ├── scgi_params.default
│   ├── uwsgi_params
│   ├── uwsgi_params.default
│   └── win-utf
├── html #存放网页的目录
│   ├── 50x.html
│   └── index.html
├── logs #日志目录
└── sbin #nginx二进制文件
    └── ngin
```



修改 `nginx` 用户的最大打开文件数，修改 `/etc/security/limits.conf` 文件，添加如下内容：

```bash
nginx   soft    nofile   65535
nginx   hard    nofile   65535
nginx   soft    nproc    4096
nginx   hard    nproc    4096 #用户最大文件描述
```



```
[root@VM-0-16-centos ~]# cat /etc/pam.d/system-auth | grep pam_li                                                                       
session     required                                     pam_limits.so  
```



如果不通过systemd启动，那么在系统启动脚本中，增加一条限制进程最大文件描述符的限制

```
[root@VM-0-16-centos ~]# echo "ulimit -n 65535" >> /etc/rc.local 
[root@VM-0-16-centos ~]# cat /etc/rc.local 
```



手动创建一个 systemd 启动脚本来管理 Nginx 服务。创建文件 `/etc/systemd/system/nginx.service`，并添加如下内容：

```bash
[Unit]
Description=The nginx HTTP and reverse proxy server
Documentation=http://nginx.org/en/docs/
After=network.target

[Service]
ExecStartPre=/usr/local/webserver/nginx/sbin/nginx -t
ExecStart=/usr/local/webserver/nginx/sbin/nginx
ExecReload=/usr/local/webserver/nginx/sbin/nginx -s reload
ExecStop=/usr/local/webserver/nginx/sbin/nginx -s stop
PIDFile=/usr/local/webserver/nginx/logs/nginx.pid
User=nginx
Group=nginx
WorkingDirectory=/usr/local/nginx
# 设置 Nginx 服务进程最大文件描述符限制
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
```

保存文件后，重新加载 systemd 配置并启用 Nginx：

```bash
systemctl daemon-reload
systemctl enable nginx
systemctl start nginx
```



###### NGINX 编译的选项  configure --help  

官网说明：[从源代码构建nginx](http://nginx.org/en/docs/configure.html)

  

```bash
  [root@VM-0-16-centos nginx-1.24.0]# ./configure --help
  --help                             打印此帮助
  --prefix=PATH                      设置安装路径
  --sbin-path=PATH                   设置nginx二进制路径
  --modules-path=PATH                设置模块路径
  --conf-path=PATH                   设置nginx.conf路径
  --error-log-path=PATH              设置error log路径
  --pid-path=PATH                    设置nginx.pid路径
  --lock-path=PATH                   设置nginx.lock路径
  --user=USER                        为工作进程设置非特权用户
  --group=GROUP                      为工作进程设置非特权用户组
  --build=NAME                       设置 build 名字
  --builddir=DIR                     设置 build 目录
  --with-select_module               启用选择模块
  --without-select_module            禁用选择模块
  --with-poll_module                 启用polL模块
  --without-poll_module              禁用polL模块
  --with-threads                     启用线程池支持
  --with-file-aio                    启用文件AIO支持
  --with-http_ssl_module             启用ngx_http_ssl_module
  --with-http_v2_module              启用 ngx_http_v2_module
  --with-http_realip_module          启用 ngx_http_realip_module
  --with-http_addition_module        启用 ngx_http_addition_module
  --with-http_xslt_module            启用 ngx_http_xslt_module
  --with-http_xslt_module=dynamic    启用 dynamic ngx_http_xslt_module
  --with-http_image_filter_module    启用 ngx_http_image_filter_module
  --with-http_image_filter_module=dynamic   启用 dynamic ngx_http_image_filter_module
  --with-http_geoip_module           启用 ngx_http_geoip_module
  --with-http_geoip_module=dynamic   启用 dynamic ngx_http_geoip_module
  --with-http_sub_module             启用 ngx_http_sub_module
  --with-http_dav_module             启用 ngx_http_dav_module
  --with-http_flv_module             启用 ngx_http_flv_module
  --with-http_mp4_module             启用 ngx_http_mp4_module
  --with-http_gunzip_module          启用 ngx_http_gunzip_module
  --with-http_gzip_static_module     启用 ngx_http_gzip_static_module
  --with-http_auth_request_module    启用 ngx_http_auth_request_module
  --with-http_random_index_module    启用 ngx_http_random_index_module
  --with-http_secure_link_module     启用 ngx_http_secure_link_module
  --with-http_degradation_module     启用 ngx_http_degradation_module
  --with-http_slice_module           启用 ngx_http_slice_module
  --with-http_stub_status_module     启用 ngx_http_stub_status_module
  --without-http_charset_module      禁用 ngx_http_charset_module
  --without-http_gzip_module         禁用 ngx_http_gzip_module
  --without-http_ssi_module          禁用 ngx_http_ssi_module
  --without-http_userid_module       禁用 ngx_http_userid_module
  --without-http_access_module       禁用 ngx_http_access_module
  --without-http_auth_basic_module   禁用 ngx_http_auth_basic_module
  --without-http_mirror_module       禁用 ngx_http_mirror_module
  --without-http_autoindex_module    禁用 ngx_http_autoindex_module
  --without-http_geo_module          禁用 ngx_http_geo_module
  --without-http_map_module          禁用 ngx_http_map_module
  --without-http_split_clients_module  禁用 ngx_http_split_clients_module
  --without-http_referer_module      禁用 ngx_http_referer_module
  --without-http_rewrite_module      禁用 ngx_http_rewrite_module
  --without-http_proxy_module        禁用 ngx_http_proxy_module
  --without-http_fastcgi_module      禁用 ngx_http_fastcgi_module
  --without-http_uwsgi_module        禁用 ngx_http_uwsgi_module
  --without-http_scgi_module         禁用 ngx_http_scgi_module
  --without-http_grpc_module         禁用 ngx_http_grpc_module
  --without-http_memcached_module    禁用 ngx_http_memcached_module
  --without-http_limit_conn_module   禁用 ngx_http_limit_conn_module
  --without-http_limit_req_module    禁用 ngx_http_limit_req_module
  --without-http_empty_gif_module    禁用 ngx_http_empty_gif_module
  --without-http_browser_module      禁用 ngx_http_browser_module
  --without-http_upstream_hash_module    禁用 ngx_http_upstream_hash_module
  --without-http_upstream_ip_hash_module    禁用 ngx_http_upstream_ip_hash_module
  --without-http_upstream_least_conn_module  禁用 ngx_http_upstream_least_conn_module
  --without-http_upstream_random_module   禁用 ngx_http_upstream_random_module
  --without-http_upstream_keepalive_module   禁用 ngx_http_upstream_keepalive_module
  --without-http_upstream_zone_module  禁用 ngx_http_upstream_zone_module
  --with-http_perl_module            启用 ngx_http_perl_module
  --with-http_perl_module=dynamic    启用 dynamic ngx_http_perl_module
  --with-perl_modules_path=PATH      设置Perl模块路径
  --with-perl=PATH                   设置perl二进制路径名
  --http-log-path=PATH               设置http访问日志路径名
  --http-client-body-temp-path=PATH  设置存储http客户端请求正文临时文件的路径
  --http-proxy-temp-path=PATH        设置存储http代理临时文件的路径
  --http-fastcgi-temp-path=PATH      设置存储http fastcgi临时文件的路径
  --http-uwsgi-temp-path=PATH        设置存储http uwsgi临时文件的路径
  --http-scgi-temp-path=PATH         设置存储http scgi临时文件的路径
  --without-http                     禁用HTTP服务器
  --without-http-cache               禁用HTTP缓存
  --with-mail                        启用POP3/IMAP4/SMTP代理模块
  --with-mail=dynamic                启用动态POP3/IMAP4/SMTP代理模块
  --with-mail_ssl_module             启用 ngx_mail_ssl_module
  --without-mail_pop3_module         禁用 ngx_mail_pop3_module
  --without-mail_imap_module         禁用 ngx_mail_imap_module
  --without-mail_smtp_module         禁用 ngx_mail_smtp_module
  --with-stream                      启用TCP/UDP代理模块
  --with-stream=dynamic              启用动态TCP/UDP代理模块
  --with-stream_ssl_module           启用 ngx_stream_ssl_module
  --with-stream_realip_module        启用 ngx_stream_realip_module
  --with-stream_geoip_module         启用 ngx_stream_geoip_module
  --with-stream_geoip_module=dynamic 启用 dynamic ngx_stream_geoip_module
  --with-stream_ssl_preread_module   启用 ngx_stream_ssl_preread_module
  --without-stream_limit_conn_module 禁用 ngx_stream_limit_conn_module
  --without-stream_access_module     禁用 ngx_stream_access_module
  --without-stream_geo_module        禁用 ngx_stream_geo_module
  --without-stream_map_module        禁用 ngx_stream_map_module
  --without-stream_split_clients_module   禁用 ngx_stream_split_clients_module
  --without-stream_return_module     禁用 ngx_stream_return_module
  --without-stream_set_module        禁用 ngx_stream_set_module
  --without-stream_upstream_hash_module  禁用 ngx_stream_upstream_hash_module
  --without-stream_upstream_least_conn_module    禁用  ngx_stream_upstream_least_conn_module
  --without-stream_upstream_random_module   禁用 ngx_stream_upstream_random_module
  --without-stream_upstream_zone_module     禁用 ngx_stream_upstream_zone_module
  --with-google_perftools_module     启用 ngx_google_perftools_module
  --with-cpp_test_module             启用 ngx_cpp_test_module
  --add-module=PATH                  启用 external module
  --add-dynamic-module=PATH          启用 dynamic external module
  --with-compat                      动态模块兼容性
  --with-cc=PATH                     设置C编译器路径名
  --with-cpp=PATH                    设置C预处理器路径名
  --with-cc-opt=OPTIONS              设置额外的C编译器选项
  --with-ld-opt=OPTIONS              设置额外的链接器选项
  --with-cpu-opt=CPU                 为指定的CPU构建，有效值：pentium, pentiumpro, pentium3, pentium4,athlon, opteron, sparc32, sparc64, ppc64
  --without-pcre                     禁用PCRE库的使用
  --with-pcre                        强制使用PCRE库
  --with-pcre=DIR                    设置PCRE库源码的路径
  --with-pcre-opt=OPTIONS            为PCRE设置额外的构建选项
  --with-pcre-jit                    使用JIT编译支持构建PCRE
  --without-pcre2                    不要使用PCRE2库
  --with-zlib=DIR                    设置zlib库源的路径
  --with-zlib-opt=OPTIONS            为zlib设置额外的构建选项
  --with-zlib-asm=CPU                使用为指定CPU优化的zlib汇编源，有效值：pentium，pentiumpro
  --with-libatomic                   强制 libatomic_ops 库使用
  --with-libatomic=DIR               设置libatomic_ops库源的路径
  --with-openssl=DIR                 设置OpenSSL库源的路径
  --with-openssl-opt=OPTIONS         为OpenSSL设置额外的构建选项
  --with-debug                       启用调试日志记录
```




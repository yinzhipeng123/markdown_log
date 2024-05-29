### 最简单的反向代理配置

7层可以识别http协议，此时的proxy_pass为： [模块ngx_http_proxy_module (p2hp.com)](https://nginx.p2hp.com/en/docs/http/ngx_http_proxy_module.html#proxy_pass)

```ini
worker_processes  1;
events {
    worker_connections  1024;
}
http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;
    server {
        listen       3306;
        server_name  localhost;
        location / {
            root   html;
            index  index.html index.htm;
            proxy_pass https://www.baidu.com; 
            #访问本机的3306，请求会转发到百度,一个server只能配置一个proxy_pass
        }
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }
}
```





我生产系统使用的nginx反向代理配置

```ini
[root@VM-0-16-centos ~] nginx -T | grep -v '^$'
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful

# configuration file /etc/nginx/modules-enabled/50-mod-http-geoip.conf:
load_module modules/ngx_http_geoip_module.so;
# configuration file /etc/nginx/modules-enabled/50-mod-http-image-filter.conf:
load_module modules/ngx_http_image_filter_module.so;
# configuration file /etc/nginx/modules-enabled/50-mod-http-xslt-filter.conf:
load_module modules/ngx_http_xslt_filter_module.so;
# configuration file /etc/nginx/modules-enabled/50-mod-mail.conf:
load_module modules/ngx_mail_module.so;
# configuration file /etc/nginx/modules-enabled/50-mod-stream.conf:
load_module modules/ngx_stream_module.so;
# configuration file /etc/nginx/mime.types:
types {
    text/html                             html htm shtml;
    text/css                              css;
    text/xml                              xml;
    image/gif                             gif;
    image/jpeg                            jpeg jpg;
    application/javascript                js;
    application/atom+xml                  atom;
    application/rss+xml                   rss;
    text/mathml                           mml;
    text/plain                            txt;
    text/vnd.sun.j2me.app-descriptor      jad;
    text/vnd.wap.wml                      wml;
    text/x-component                      htc;
    image/png                             png;
    image/tiff                            tif tiff;
    image/vnd.wap.wbmp                    wbmp;
    image/x-icon                          ico;
    image/x-jng                           jng;
    image/x-ms-bmp                        bmp;
    image/svg+xml                         svg svgz;
    image/webp                            webp;
    application/font-woff                 woff;
    application/java-archive              jar war ear;
    application/json                      json;
    application/mac-binhex40              hqx;
    application/msword                    doc;
    application/pdf                       pdf;
    application/postscript                ps eps ai;
    application/rtf                       rtf;
    application/vnd.apple.mpegurl         m3u8;
    application/vnd.ms-excel              xls;
    application/vnd.ms-fontobject         eot;
    application/vnd.ms-powerpoint         ppt;
    application/vnd.wap.wmlc              wmlc;
    application/vnd.google-earth.kml+xml  kml;
    application/vnd.google-earth.kmz      kmz;
    application/x-7z-compressed           7z;
    application/x-cocoa                   cco;
    application/x-java-archive-diff       jardiff;
    application/x-java-jnlp-file          jnlp;
    application/x-makeself                run;
    application/x-perl                    pl pm;
    application/x-pilot                   prc pdb;
    application/x-rar-compressed          rar;
    application/x-redhat-package-manager  rpm;
    application/x-sea                     sea;
    application/x-shockwave-flash         swf;
    application/x-stuffit                 sit;
    application/x-tcl                     tcl tk;
    application/x-x509-ca-cert            der pem crt;
    application/x-xpinstall               xpi;
    application/xhtml+xml                 xhtml;
    application/xspf+xml                  xspf;
    application/zip                       zip;
    application/octet-stream              bin exe dll;
    application/octet-stream              deb;
    application/octet-stream              dmg;
    application/octet-stream              iso img;
    application/octet-stream              msi msp msm;
    application/vnd.openxmlformats-officedocument.wordprocessingml.document    docx;
    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet          xlsx;
    application/vnd.openxmlformats-officedocument.presentationml.presentation  pptx;
    audio/midi                            mid midi kar;
    audio/mpeg                            mp3;
    audio/ogg                             ogg;
    audio/x-m4a                           m4a;
    audio/x-realaudio                     ra;
    video/3gpp                            3gpp 3gp;
    video/mp2t                            ts;
    video/mp4                             mp4;
    video/mpeg                            mpeg mpg;
    video/quicktime                       mov;
    video/webm                            webm;
    video/x-flv                           flv;
    video/x-m4v                           m4v;
    video/x-mng                           mng;
    video/x-ms-asf                        asx asf;
    video/x-ms-wmv                        wmv;
    video/x-msvideo                       avi;
}
# configuration file /etc/nginx/nginx.conf:
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;
events {
        worker_connections 768;
}
http {
        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;
        include /etc/nginx/mime.types;
        default_type application/octet-stream;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
        ssl_prefer_server_ciphers on;
        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;
        gzip on;
        client_max_body_size 500m; # 指令用于设置客户端请求主体的最大允许大小，即客户端发送到服务器的数据的大小上限，，默认为1M
        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;
}
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        root /var/www/html;
        
        index index.html index.htm index.nginx-debian.html;
        server_name _;
        location / {
                try_files $uri $uri/ =404;
        }
 
}

# configuration file /etc/nginx/conf.d/1_1_1_1_8080.conf:
server {
    listen       8083;
    server_name  0.0.0.0;
    default_type 'text/html';
    charset utf-8;
    #access_log  /var/log/nginx/host.access.log  main;
    
    location / {
        proxy_pass http://1.1.1.1:8083;
     }
}
```



### 给OSS做反向代理

给OSS做的反向代理配置：

```
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;
include /usr/share/nginx/modules/*.conf;
events {
    worker_connections 1024;
}
http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;
    server_tokens off;
    proxy_hide_header X-Powered-By;
    proxy_hide_header Server;
    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;
    include /etc/nginx/conf.d/*.conf;
server {
    listen       81 default_server; ## 反向代理的端口
    server_name  1.1.1.1 oss.ganxie.com; ## 将反向代理IP(也就是部署nginx的ECS IP)、OSS endpoint原始域，都作为server_name。确保无论使用IP地址还是新域名的请求都能被正确处理。
    root         /usr/share/nginx/html;
    include /etc/nginx/default.d/*.conf;
    location / {
    proxy_pass http://oss.ganxie.com; ## 将访问nginx 反向代理域名(IP)的请求，转发到OSS bucket真正的域名。
    proxy_set_header Host $http_host; # 指令允许你设置或重写向后端服务器发送的请求头部。默认情况下，Nginx 不会传递所有来自原始请求的头部信息。这里·$http_host'是一个变量，代表客户端请求中的 Host 头部的值。这样的改动意味着后端服务器现在接收到的 Host 头部将与客户端发送给Nginx 的原始 Host 头部一致。这样保持应用系统原始IP访问OSS bucket配置的endpoint 域名host，否则还会出现鉴权问题。
    }
}
}
```

除了这个之外，要访问OSS的应用，应用所在的操作系统，需要配置一下hosts文件。

```
# 应用程序所在的操作系统hosts文件添加如下： 
nginx代理的IP  OSS_endpoint_原始域名
nginx代理的IP  bucketname_OSS_endpoint_原始域名
```

OSS上传下载慢，可以设置分片大小，并发数，设置断点续传文件的大小阈值来优化时间

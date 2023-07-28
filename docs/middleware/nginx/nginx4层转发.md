Nginx在1.9版本之后就可以配置4层的转发：[Module ngx_stream_core_module (nginx.org)](http://nginx.org/en/docs/stream/ngx_stream_core_module.html)

需要在配置中添加  --with-stream 

4层转发无法识别http等协议，此时的proxy_pass为[模块ngx_stream_proxy_module (p2hp.com)](https://nginx.p2hp.com/en/docs/stream/ngx_stream_proxy_module.html#proxy_pass)

4层转发可以用作4层反向代理及4层负载均衡

```bash
[root@VM-0-16-centos sbin]# ./nginx -V
nginx version: nginx/1.24.0
built by gcc 4.8.5 20150623 (Red Hat 4.8.5-44) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx  --with-stream --with-http_stub_status_module --with-http_ssl_module
[root@VM-0-16-centos sbin]# cd /usr/local/webserver/nginx/conf/
[root@VM-0-16-centos conf]# cat nginx.conf
worker_processes  1;
events {
    worker_connections  1024;
}
stream {
    upstream bak {
        server localhost:3306 weight=5;
        server localhost:80 weight=50;
        #必须配置【主机名或者IP】+端口，可以配置多个，那么就是4层负载均衡，还可以设置权重
        }
    server {
        listen 8080;
        proxy_pass bak;
        #访问本机的8080,就会把请求转发到bak服务组中
        }
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
        }
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }
}
```



最简单的4层转发：

```ini
worker_processes  1;
events {
    worker_connections  1024;
}
stream {
    upstream bak {
        server localhost:22;
        #转发本机的22端口到8080端口
        }
    server {
        listen 8080;
        proxy_pass bak;
        }
}
```


最简单的反向代理配置

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

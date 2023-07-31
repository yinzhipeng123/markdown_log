最简单的7层负载均衡

```ini
worker_processes  1;
events {
    worker_connections  1024;
}
http {
    include       mime.types;
    default_type  application/octet-stream;
    server {
        listen 9001;
        server_name localhost;
        default_type text/html;
        
        location / {
            return 200 '<h1>server:9001</h1>';
        }
    }
    server {
        listen 9002;
        server_name localhost;
        default_type text/html;
        
        location / {
            return 200 '<h1>server:9002</h1>';
        }
    }
    server {
        listen 9003;
        server_name localhost;
        default_type text/html;
        
        location / {
            return 200 '<h1>server:9003</h1>';
        }
    }
    
    upstream backend {
        server localhost:9001;
        server localhost:9002;
        server localhost:9003;
    }
    server {
        listen 8080;
        server_name localhost;
        
        location / {
            proxy_pass http://backend/;
        }
    }
}
```

在server后面可以加一些参数，比如权重、超时等。具体查看官方描述：[Module ngx_http_upstream_module (p2hp.com)](https://nginx.p2hp.com/en/docs/http/ngx_http_upstream_module.html#upstream)
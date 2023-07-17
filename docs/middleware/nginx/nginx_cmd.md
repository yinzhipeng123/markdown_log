

## nginx命令参数

[Command-line parameters (p2hp.com)](https://nginx.p2hp.com/en/docs/switches.html)

```bash
[root@VM-0-16-centos sbin]# ./nginx -h
nginx version: nginx/1.24.0
Usage: nginx [-?hvVtTq] [-s signal] [-p prefix]
             [-e filename] [-c filename] [-g directives]
```

#### 选项:

-   -?,-h         : 此帮助
-   -v              : 显示版本并退出
-   -V             : 显示版本和编译配置选项，然后退出
-   -t              : 测试配置和退出
-   -T              : 测试配置，转储并退出
-   -q             : 在配置测试期间抑制非错误消息
-   -s signal     : 向主进程发送信号：停止、退出、重新打开、重新加载。 stop, quit, reopen, reload
-   -p prefix     : 设置前缀路径 (default: /usr/local/webserver/nginx/)
-   -e filename   : 设置错误日志文件 (default: logs/error.log)
-   -c filename   : 设置配置文件 (default: conf/nginx.conf)
-   -g directives : 设置配置文件之外的全局参数 --可以设置的参数：[Core functionality (p2hp.com)](https://nginx.p2hp.com/en/docs/ngx_core_module.html#load_module)

####  启动

```bash
[root@VM-0-16-centos ~]# cd /usr/local/webserver/nginx/sbin
[root@VM-0-16-centos sbin]# ./nginx 
没有提示就是启动成功了
[root@VM-0-16-centos sbin]# ps -ef | grep nginx
root      396270       1  0 00:32 ?        00:00:00 nginx: master process ./nginx
nobody    396271  396270  0 00:32 ?        00:00:00 nginx: worker process
root      396311  376295  0 00:32 pts/1    00:00:00 grep --color=auto nginx
[root@VM-0-16-centos ~]# cd /usr/local/webserver/nginx/
[root@VM-0-16-centos nginx]# tree
... 查看目录，只有两个html
├── html
│   ├── 50x.html
│   └── index.html
├── proxy_temp
├── sbin
│   └── nginx
[root@VM-0-16-centos nginx]# curl localhost/50x.html
[root@VM-0-16-centos nginx]# curl localhost/index.html

停止nginx
[root@VM-0-16-centos ~]# cd /usr/local/webserver/nginx/sbin
[root@VM-0-16-centos sbin]# ./nginx -s quit
[root@VM-0-16-centos sbin]# ps -ef | grep nginx
root      397682  376295  0 00:38 pts/1    00:00:00 grep --color=auto nginx
```


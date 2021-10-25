## Docker安装

https://developer.aliyun.com/mirror/docker-ce

## Docker加速

Centos7

```bash
[root@server ~]# cat  /etc/docker/daemon.json                           
{
  "registry-mirrors": ["https://registry.docker-cn.com","http://hub-mirror.c.163.com","https://docker.mirrors.ustc.edu.cn"
  ]
}



[root@server ~] systemctl daemon-reload
[root@server ~] systemctl restart docker
```


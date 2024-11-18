## Docker安装

https://developer.aliyun.com/mirror/docker-ce

## Docker加速

Centos7
https://www.coderjia.cn/archives/dba3f94c-a021-468a-8ac6-e840f85867ea

```bash
[root@server ~]# cat  /etc/docker/daemon.json                           
{
    "registry-mirrors": [
        "https://docker.unsee.tech",
        "https://dockerpull.org",
        "https://dockerhub.icu"
    ]
}



[root@server ~] systemctl daemon-reload
[root@server ~] systemctl restart docker
```


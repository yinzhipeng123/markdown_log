# 停止docker出现警告

```
[root@VM-0-2-centos ~]# systemctl stop docker        
Warning: Stopping docker.service, but it can still be activated by:
  docker.socket
#解决方法
[root@VM-0-2-centos ~]# systemctl stop docker.socket
[root@VM-0-2-centos ~]# systemctl stop docker
```


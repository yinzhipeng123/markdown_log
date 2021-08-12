# 部署

下载地址：

https://grafana.com/grafana/download

centos系列安装：

```bash
[root@centos7 ~]# wget https://dl.grafana.com/oss/release/grafana-6.6.0-1.x86_64.rpm
[root@centos7 ~]# sudo yum install grafana-6.6.0-1.x86_64.rpm
[root@centos7 ~]# systemctl daemon-reload
[root@centos7 ~]# systemctl start grafana-server
[root@centos7 ~]# systemctl status grafana-server
[root@centos7 ~]# grafana-server -v
Version 6.6.0 (commit: 5c11bbdfb4, branch: HEAD)
[root@centos7 ~]# sudo systemctl enable grafana-server
Created symlink from /etc/systemd/system/multi-user.target.wants/grafana-server.service to /usr/lib/systemd/system/grafana-server.service.
[root@centos7 ~]# curl 127.0.0.7:3000
<a href="/login">Found</a>.
```


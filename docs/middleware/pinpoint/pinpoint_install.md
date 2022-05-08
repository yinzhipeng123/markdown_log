# Pinpoint部署



Pinpoint官方Git库：https://github.com/pinpoint-apm/pinpoint

官方安装指南：https://pinpoint-apm.gitbook.io/pinpoint/getting-started/docker

| 主机名  | Pinpoint版本 | IP             | Cpu  | 内存 |
| ------- | ------------ | -------------- | ---- | ---- |
| centos7 | v2.3.0       | 192.168.70.151 | 4核  | 8G   |

客户端：

```bash
机器都关闭selinux和防火墙
 
[root@centos7 ~]# yum install yum-utils device-mapper-persistent-data lvm2 openssl socat conntrack ebtables ipset
[root@centos7 ~]# yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
[root@centos7 ~]# yum list docker-ce --showduplicates | sort -r
[root@centos7 ~]# yum install docker-ce
[root@centos7 ~]# systemctl enable --now docker
[root@centos7 ~]# sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
[root@centos7 ~]# sudo chmod +x /usr/local/bin/docker-compose
[root@centos7 ~]# sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
[root@centos7 ~]# docker version
Client: Docker Engine - Community
 Version:           20.10.10
 API version:       1.41
 Go version:        go1.16.9
 Git commit:        b485636
 Built:             Mon Oct 25 07:44:50 2021
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true
 
Server: Docker Engine - Community
 Engine:
  Version:          20.10.10
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.16.9
  Git commit:       e2f740d
  Built:            Mon Oct 25 07:43:13 2021
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.11
  GitCommit:        5b46e404f6b9f661a205e28d59c982d3634148f8
 runc:
  Version:          1.0.2
  GitCommit:        v1.0.2-0-g52b36a2
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
[root@centos7 ~]# docker-compose --version
docker-compose version 1.29.2, build 5becea4c
 
[root@centos7 ~]# git clone https://github.com/naver/pinpoint-docker.git
[root@centos7 ~]# cd pinpoint-docker/
[root@centos7 ~]# git checkout 2.3.0
[root@centos7 ~]# docker-compose pull
查看配置文件
[root@centos7 ~]# vim .env
部署启动，需要下载镜像，失败了就重试
[root@centos7 ~]# docker-compose up -d
```

访问192.168.70.151:8079
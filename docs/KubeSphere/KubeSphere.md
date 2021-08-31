# KubeSphere 单点安装

https://kubesphere.com.cn/docs/quick-start/all-in-one-on-linux/

all in one：

设置4核，8G内存，太小的话，有的服务无法启动，关闭防火墙，关闭selinux

| 主机名  | KubeSphere版本 | IP             |
| ------- | -------------- | -------------- |
| centos7 | 3.1.0          | 192.168.70.130 |

```bash
[root@centos7 ~]# yum install yum-utils device-mapper-persistent-data lvm2 openssl socat conntrack ebtables ipset
[root@centos7 ~]# yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
[root@centos7 ~]# yum list docker-ce --showduplicates | sort -r
[root@centos7 ~]# yum install docker-ce-20.10.6
[root@centos7 ~]# systemctl enable --now docker

[root@centos7 ~]# export KKZONE=cn
[root@centos7 ~]# curl -sfL https://get-kk.kubesphere.io | VERSION=v1.1.0 sh -
[root@centos7 ~]# chmod +x kk
[root@centos7 ~]#./kk create cluster --with-kubernetes v1.20.4 --with-kubesphere v3.1.0
然后会提示让安装依赖，忽略就可以 输入yes，然后就完成了安装
```

启用多集群管理功能

https://v3-1.docs.kubesphere.io/zh/docs/multicluster-management/enable-multicluster/direct-connection/

启动商店

https://v3-1.docs.kubesphere.io/zh/docs/pluggable-components/app-store/

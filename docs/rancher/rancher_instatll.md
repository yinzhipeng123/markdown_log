# rancher安装

版本2.6.3



```bash
[root@server ~] yum install -y yum-utils device-mapper-persistent-data lvm2 wget
[root@server ~] yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
[root@server ~] yum makecache fast
[root@server ~] yum install docker-ce-19.03.15-3.el7  docker-ce-cli-19.03.15-3.el7 -y
[root@server ~] systemctl enable docker && systemctl restart docker
[root@server ~] sudo docker run -d --restart=unless-stopped --privileged  -p 80:80 -p 443:443 rancher/rancher
```

访问 本机80端口

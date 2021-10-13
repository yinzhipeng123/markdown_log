# Python3的Docker镜像制作



编辑`Dockerfile`文件

```dockerfile
FROM docker.io/library/centos:7.4.1708
#python3基础镜像构建
MAINTAINER yinzhipeng
WORKDIR /usr/local
RUN yum install -y https://repo.ius.io/ius-release-el7.rpm https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo && curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo && yum makecache fast
RUN yum install -y wget git222 vim net-tools  gcc zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel libffi-devel make
RUN wget https://mirrors.huaweicloud.com/python/3.9.6/Python-3.9.6.tgz
RUN tar -zxvf Python-3.9.6.tgz
WORKDIR /usr/local/Python-3.9.6
RUN ./configure --prefix=/usr/local/python/python3 && make && make install
RUN ln -s /usr/local/python/python3/bin/python3 /usr/bin/python3
RUN ln -s /usr/local/python/python3/bin/pip3 /usr/bin/pip3
WORKDIR /app
CMD bash -c "while true;do sleep 1s;done"
```

然后执行

```bash
 docker build  -t='self_Python3' .
```


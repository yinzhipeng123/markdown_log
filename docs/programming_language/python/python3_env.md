# Centos7安装Python3，不影响python2



下载python3安装包：https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tgz



```bash
[root@graphical ~]# cat install_python3.sh
yum install -y https://repo.ius.io/ius-release-el7.rpm https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo && curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo && yum makecache fast

yum install -y wget git222 vim net-tools  gcc zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel libffi-devel make

wget https://mirrors.huaweicloud.com/python/3.9.6/Python-3.9.6.tgz
tar -zxvf Python-3.9.6.tgz
cd Python-3.9.6
mkdir -p /usr/local/python/python3
./configure --prefix=/usr/local/python/python3 && make && make install

ln -s /usr/local/python/python3/bin/python3 /usr/bin/python3
ln -s /usr/local/python/python3/bin/pip3 /usr/bin/pip3

添加环境变量，末尾导入两行,安装第三方包有的时候会在/usr/local/python/python3/bin生成二进制文件
[root@graphical ~]# cat /etc/profile
export PYTHON3_HOME=/usr/local/python/python3
export PATH=$PATH:$PYTHON3_HOME/bin
[root@graphical ~]# source /etc/profile
[root@graphical ~]# python --version
Python 2.7.5
[root@graphical ~]# python3 --version
Python 3.9.6
[root@graphical ~]# 
```


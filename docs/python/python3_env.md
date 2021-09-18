# Centos7安装Python3，不影响python2



下载python3安装包：https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tgz



```bash
[root@graphical ~]# yum install epel-release -y
[root@graphical ~]# yum -y install zlib zlib-devel bzip2 bzip2-devel  ncurses ncurses-devel readline readline-devel openssl [root@graphical ~]# openssl-devel libffi libffi-devel openssl-static xz lzma xz-devel sqlite sqlite-devel gdbm gdbm-devel tk tk-devel gcc -y
[root@graphical ~]# mkdir /opt/python3
[root@graphical ~]# wget https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tgz
[root@graphical ~]# tar -zxvf Python-3.9.7.tgz
[root@graphical ~]# cd Python-3.9.6/
[root@graphical ~]# ./configure --prefix=/opt/python3/
[root@graphical ~]# make
[root@graphical ~]# make install
添加环境变量，末尾导入两行
[root@graphical ~]# cat /etc/profile
export PYTHON3_HOME=/opt/python3
export PATH=$PATH:$PYTHON3_HOME/bin
[root@graphical ~]# source /etc/profile
[root@graphical ~]# python --version
Python 2.7.5
[root@graphical ~]# python3 --version
Python 3.9.6
[root@graphical ~]# 
```


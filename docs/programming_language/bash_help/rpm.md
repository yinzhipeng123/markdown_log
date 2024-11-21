# Rpm

rpm命令是Red-Hat Package Manager（RPM软件包管理器）的缩写， 该命令用于管理Linux 下软件包的软件。在 Linux 操作系统下，几乎所有的软件均可以通过RPM 进行安装、卸载及管理等操作。

概括的说，rpm命令包含了五种基本功能：安装、卸载、升级、查询和验证。

## 语法

**语法格式：**rpm [参数] [软件包]

**常用参数：**

| -a            | 查询所有的软件包                                 |
| ------------- | ------------------------------------------------ |
| -b或-t        | 设置包装套件的完成阶段，并指定套件档的文件名称； |
| -c            | 只列出组态配置文件，本参数需配合”-l”参数使用     |
| -d            | 只列出文本文件，本参数需配合”-l”参数使用         |
| -e或--erase   | 卸载软件包                                       |
| -f            | 查询文件或命令属于哪个软件包                     |
| -h或--hash    | 安装软件包时列出标记                             |
| -i            | 显示软件包的相关信息                             |
| --install     | 安装软件包                                       |
| -l            | 显示软件包的文件列表                             |
| -p            | 查询指定的rpm软件包                              |
| -q            | 查询软件包                                       |
| -R            | 显示软件包的依赖关系                             |
| -s            | 显示文件状态，本参数需配合”-l”参数使用           |
| -U或--upgrade | 升级软件包                                       |
| -v            | 显示命令执行过程                                 |
| -vv           | 详细显示指令执行过程                             |

**参考实例**

直接安装软件包：

```
[root@linuxcool ~]# rpm -ivh packge.rpm 
```

忽略报错，强制安装：

```
[root@linuxcool ~]# rpm --force -ivh package.rpm
```

列出所有安装过的包：

```
[root@linuxcool ~]# rpm -qa
```

查询rpm包中的文件安装的位置：

```
[root@linuxcool ~]# rpm -ql ls
```

卸载rpm包：

```
[root@linuxcool ~]# rpm -e package.rpm 
```

升级软件包：

```
[root@linuxcool ~]# rpm -U file.rpm
```



## 查看系统软件变化

```bash
for p in $(rpm -qa); do rpm --verify $p || echo $p;done


S= 大小改变
M= 权限改变
5=MD5改变，说明文件内容被改了 ： md5sum
L= 连接改变
D= 设备改变
U=用户改变
G= 组改变
T=修改时间改
```

查询文件属于哪个软件包

```bash
#查询文件属于哪个软件包
[root@VM-0-16-centos ~]# rpm -qf  /etc/passwd                                                                                   
setup-2.13.7-6.el9.noarch 
[root@VM-0-16-centos ~]# yum provides /etc/passwd
Last metadata expiration check: 0:15:24 ago on Thu 21 Nov 2024 10:41:08 AM CST.
setup-2.13.7-6.el9.noarch : A set of system configuration and setup files
Repo        : @System  #代表已经安装在系统上
Matched from:
Filename    : /etc/passwd

setup-2.13.7-6.el9.noarch : A set of system configuration and setup files
Repo        : baseos
Matched from:
Filename    : /etc/passwd
#查询软件包中已经发生的变化
[root@VM-0-16-centos ~]# rpm --verify setup-2.13.7-6.el9.noarch
S.5....T.  c /etc/bashrc
.M....G..  g /var/log/lastlog
```


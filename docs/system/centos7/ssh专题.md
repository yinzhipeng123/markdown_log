- [ ] # ssh相关命令中文man

## 服务端

服务端包含的命令：

```
$rpm -ql openssh-server                                                                                                                                          
/etc/pam.d/sshd
/etc/ssh/sshd_config
/etc/sysconfig/sshd
/usr/lib/systemd/system/sshd-keygen.service
/usr/lib/systemd/system/sshd.service
/usr/lib/systemd/system/sshd.socket
/usr/lib/systemd/system/sshd@.service
/usr/lib64/fipscheck/sshd.hmac
/usr/libexec/openssh/sftp-server
/usr/sbin/sshd
/usr/sbin/sshd-keygen
/var/empty/sshd
```

服务端中文man：

[sshd 中文手册 [金步国\] (jinbuguo.com)](https://www.jinbuguo.com/openssh/sshd.html)

[sshd_config 中文手册 [金步国\] (jinbuguo.com)](https://www.jinbuguo.com/openssh/sshd_config.html)

[ssh-keygen 中文手册 [金步国\] (jinbuguo.com)](https://www.jinbuguo.com/openssh/ssh-keygen.html)

## 客户端

客户端包含的命令：

```
$rpm -ql openssh-clients                                                                                                                                         
/etc/ssh/ssh_config
/usr/bin/scp
/usr/bin/sftp
/usr/bin/slogin
/usr/bin/ssh
/usr/bin/ssh-add
/usr/bin/ssh-agent
/usr/bin/ssh-copy-id
/usr/bin/ssh-keyscan
/usr/lib64/fipscheck/ssh.hmac
/usr/libexec/openssh/ssh-pkcs11-helper
```

客户端中文man：

[ssh(1) — manpages-zh — Debian unstable — Debian Manpages](https://manpages.debian.org/unstable/manpages-zh/ssh.1.zh_CN.html)

[scp(1) — manpages-zh — Debian unstable — Debian Manpages](https://manpages.debian.org/unstable/manpages-zh/scp.1.zh_CN.html)

免密配置：

```bash
ssh-keygen -t rsa -b 4096
```

发送密钥

```bash
ssh-copy-id root@ip地址
```





不使用免密登录root

```
ssh -o PubkeyAuthentication=no root@hostname
```



ssh 连接提示如下：

```bash
[root@ ~]# ssh root@ip 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ED25519 key sent by the remote host is
Please contact your system administrator.
Add correct host key in /root/.ssh/known_hosts to get rid of this message.
Offending ED25519 key in /root/.ssh/known_hosts:2186


```


解决方法：

```
ssh-keygen -R "服务器IP地址"
#这会自动从known_hosts文件中删除该主机的旧记录。之后重新连接时会提示你确认新指纹。
```


```commandline
sshpass -p "密码" ssh -o PubkeyAuthentication=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null   root@IP 
#不使用免密，不验证远程主机的SSH密钥且不保存记录
```
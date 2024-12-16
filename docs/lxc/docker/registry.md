



创建目录。

```bash
sudo mkdir -p /etc/docker/registry
```

创建 `htpasswd` 文件

```bash
sudo htpasswd -c /etc/docker/registry/htpasswd myuser
```

系统会提示你输入并确认密码

```bash
sudo chown root:root /etc/docker/registry/htpasswd
sudo chmod 600 /etc/docker/registry/htpasswd
```

编辑 `/etc/docker/daemon.json` 文件，添加以下内容：

```bash
{
  "insecure-registries": ["localhost:5000"]
}
```



**配置 Docker Registry 使用该文件**： 确保在启动 Docker Registry 时正确配置了 `htpasswd` 文件的路径

```bash
docker run -d -p 5000:5000 --name registry -v /etc/docker/registry/htpasswd:/etc/docker/registry/htpasswd registry:2
```

登录Registry

```bash
[root@VM-0-16-centos ~]# docker login localhost:5000
Username: myuser
Password: 
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credential-stores

Login Succeeded
```

退出登录

```bash
[root@VM-0-16-centos ~]# docker logout localhost:5000
Removing login credentials for localhost:5000
```

重置密码

```bash
htpasswd /etc/docker/registry/htpasswd myuser #重置密码
docker restart registry #重启容器
```









官方介绍连接：https://hub.docker.com/_/registry
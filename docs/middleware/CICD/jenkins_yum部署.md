

配置源

```bash
  sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
```

安装

```bash
  yum install fontconfig java-17-openjdk
  yum install jenkins
  alternatives --config java #选择默认的JAVA版本
```

设置好 Java 17 后，重新启动 Jenkins 服务：

```bash
sudo systemctl start jenkins
```

rpm包内文件

```bash
[root@VM-0-16-centos ~]# rpm -ql jenkins                                                                                                                                       
/usr/bin/jenkins                                                                                                                                                               
/usr/lib/systemd/system/jenkins.service                                                                                                                                        
/usr/lib/tmpfiles.d/jenkins.conf                                                                                                                                               
/usr/share/java/jenkins.war                                                                                                                                                    
/usr/share/jenkins/migrate                                                                                                                                                     
/var/cache/jenkins                                                                                                                                                             
/var/lib/jenkins  
```

系统服务配置文件

```bash
[Unit]
Description=Jenkins Continuous Integration Server  # 描述服务的作用，说明这是一个 Jenkins 持续集成服务器
Requires=network.target  # 服务依赖于网络服务，即需要网络服务启动后才能启动 Jenkins
After=network.target  # Jenkins 服务启动时，需要在网络服务启动之后启动
StartLimitBurst=5  # 启动失败时的重试次数限制
StartLimitIntervalSec=5m  # 重试的时间间隔为 5 分钟
[Service]
Type=notify  # 服务类型为 notify，表示服务将向 systemd 通知其启动状态
NotifyAccess=main  # 通知来自主进程
ExecStart=/usr/bin/jenkins  # 定义启动 Jenkins 服务的命令
Restart=on-failure  # 如果 Jenkins 服务崩溃（非正常退出），则自动重启
SuccessExitStatus=143  # 当进程以退出码 143（正常关闭）退出时，认为服务成功停止
User=jenkins  # 指定服务以 jenkins 用户身份运行
Group=jenkins  # 指定服务以 jenkins 组身份运行
Environment="JENKINS_HOME=/var/lib/jenkins"  # 设置 Jenkins 的主目录路径
WorkingDirectory=/var/lib/jenkins  # 设置 Jenkins 的工作目录路径
Environment="JENKINS_WEBROOT=%C/jenkins/war"  # 设置 Jenkins Web 资源路径
Environment="JAVA_OPTS=-Djava.awt.headless=true"  # 设置 Java 运行时选项，禁用图形界面
Environment="JENKINS_PORT=8080"  # 设置 Jenkins 服务的端口号为 8080
[Install]
WantedBy=multi-user.target  # 将该服务添加到 multi-user.target 中，表示系统进入多用户模式时会启动 Jenkins
```


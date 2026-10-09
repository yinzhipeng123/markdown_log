# 用tcpconnect监控服务器主动请求外部地址



## ubuntu 2204下使用tcpconnect

安装

```bash
apt update
apt install -y bpfcc-tools linux-headers-$(uname -r) clang llvm
```

启动

```
tcpconnect-bpfcc
```



### 1. 创建 systemd 服务

直接执行：

```
sudo tee /etc/systemd/system/tcpconnect.service > /dev/null <<'EOF'
[Unit]
Description=BCC TCP Connect Monitor
After=network.target

[Service]
Type=simple
ExecStart=/usr/sbin/tcpconnect-bpfcc
Restart=always
RestartSec=5
StandardOutput=append:/var/log/tcpconnect.log
StandardError=append:/var/log/tcpconnect.log

[Install]
WantedBy=multi-user.target
EOF
```

### 2. 创建日志文件

```
sudo touch /var/log/tcpconnect.log
```

### 3. 加载并启动

```
sudo systemctl daemon-reload
sudo systemctl enable --now tcpconnect.service
```

### 4. 查看运行状态

```
systemctl status tcpconnect.service
```

应该看到：

```
Active: active (running)
```

5. 看监控日志

```
tail -f /var/log/tcpconnect.log
```

然后另外开一个 SSH 窗口：

```
curl https://www.baidu.com
```



## centos 7.9 下使用tcpconnect

```bash
yum install -y kernel-devel-$(uname -r) kernel-headers-$(uname -r)
yum install -y bcc-tools
```



### 系统检查

```bash
1.
grep -E 'CONFIG_BPF=|CONFIG_BPF_SYSCALL=|CONFIG_BPF_JIT=|CONFIG_KPROBES=|CONFIG_BPF_EVENTS=' /boot/config-$(uname -r)
在结果中需要以下：
CONFIG_BPF=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_KPROBES=y
CONFIG_BPF_EVENTS=y

```



### 1. 创建服务

```
cat > /etc/systemd/system/tcpconnect.service <<'EOF'
[Unit]
Description=BCC TCP Connect Monitor
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash -c '/usr/bin/python -u /usr/share/bcc/tools/tcpconnect >> /var/log/tcpconnect.log 2>&1'
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

### 2. 启用并立即启动

```
touch /var/log/tcpconnect.log
systemctl daemon-reload
systemctl enable --now tcpconnect.service
```

### 3. 检查

```
systemctl status tcpconnect.service
```

正常应该看到：

```
Active: active (running)
```

再看日志：

```
tail -f /var/log/tcpconnect.log
```

### 4. 测试

另开一个 SSH 窗口：

```
curl http://www.baidu.com
```

然后：

可以看到进程号，进程名字，发起地址，和目的地址，目的端口

```bash
tail -n 20 /var/log/tcpconnect.log
PID    COMM         IP SADDR            DADDR            DPORT
1669   curl         4  172.31.89.232    183.2.172.177    80 

```

服务资源占用情况

```bash
服务情况
[root@localhost ~]# systemctl status tcpconnect.service
● tcpconnect.service - BCC TCP Connect Monitor
   Loaded: loaded (/etc/systemd/system/tcpconnect.service; enabled; vendor preset: disabled)
   Active: active (running) since 五 2026-10-09 14:26:09 CST; 25min ago
 Main PID: 1045 (bash)
   CGroup: /system.slice/tcpconnect.service
           ├─1045 /bin/bash -c /usr/bin/python -u /usr/share/bcc/tools/tcpconnect >> /var/log/tcpconnect.log 2>&1
           └─1047 /usr/bin/python -u /usr/share/bcc/tools/tcpconnect

10月 09 14:26:09 localhost.localdomain systemd[1]: Started BCC TCP Connect Monitor.
进程占用情况
[root@localhost ~]# ps -ef | grep tcpconnect
root      1045     1  0 14:26 ?        00:00:00 /bin/bash -c /usr/bin/python -u /usr/share/bcc/tools/tcpconnect >> /var/log/tcpconnect.log 2>&1
root      1047  1045  0 14:26 ?        00:00:02 /usr/bin/python -u /usr/share/bcc/tools/tcpconnect
root      1685  1648  0 14:52 pts/0    00:00:00 grep --color=auto tcpconnect



ps查看资源占用情况
[root@localhost ~]# ps -p 1045,1047 -o pid,ppid,%cpu,%mem,rss,vsz,etime,cmd
  PID  PPID %CPU %MEM   RSS    VSZ     ELAPSED CMD
 1045     1  0.0  0.0  1432 115404       24:01 /bin/bash -c /usr/bin/python -u /usr/share/bcc/tools/tcpconnect >> /var/log/tcpconnect.log 2>&1
 1047  1045  0.1  2.6 101060 367740      24:01 /usr/bin/python -u /usr/share/bcc/tools/tcpconnect
TOP查看资源占用情况
[root@localhost ~]# top -p 1045,1047
 top - 14:51:01 up 24 min,  2 users,  load average: 0.00, 0.01, 0.02
Tasks:   2 total,   0 running,   2 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.0 sy,  0.0 ni, 99.9 id,  0.0 wa,  0.0 hi,  0.1 si,  0.0 st
KiB Mem :  3879640 total,   502556 free,  3185600 used,   191484 buff/cache
KiB Swap:  4063228 total,  4063228 free,        0 used.   477328 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                         
 1045 root      20   0  115404   1432   1240 S   0.0  0.0   0:00.00 bash                                                                            
 1047 root      20   0  367740 101060  31716 S   0.0  2.6   0:02.18 python 
```


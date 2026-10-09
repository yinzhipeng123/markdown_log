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

```
tail -n 20 /var/log/tcpconnect.log
```

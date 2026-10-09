# WSL 2 使用记录



## 安装 wsl 2



```bash
wsl --install
```

选择系统

```bash
wsl --list --online
```

安装系统到D盘

```bash
mkdir D:\WSL\Fedora44
wsl --install -d FedoraLinux-44 --location D:\WSL\Fedora44
```

进入wsl 2

```bash
wsl -d FedoraLinux-44
```

查看系统状态

```bash
wsl -l -v
```

关闭所有系统

```bash
wsl --shutdown
```



## 修改系统root默认密码

进入系统

```
wsl -d FedoraLinux-44
```

修改密码

```
sudo passwd root
```





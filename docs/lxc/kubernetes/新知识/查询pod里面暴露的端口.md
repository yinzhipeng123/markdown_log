## 查看pod暴露的端口

```bash
[root@master1-lc01 ~]# kubectl get pod -A -o wide | grep app-aimanager-sdjn #查询pod
app             app-aimanager-sdjn-0                                    1/1     Running            0                   7d22h   10.48.97.115    worker10-lc01.mycloud.com        <none>           2/2
app             app-aimanager-sdjn-1                                    1/1     Running            0                   7d22h   10.48.106.130   worker11-lc01.mycloud.com        <none>           2/2
app             app-aimanager-sdjn-2                                    1/1     Running            42 (7d22h ago)      8d      10.48.105.27    worker7-lc01.mycloud.com         <none>           2/2

[root@master1-lc01 ~]# ssh worker10-lc01.mycloud.com #登陆pod所在的宿主机
Last login: Tue Mar 24 14:49:28 2026 from 10.48.235.14
[root@worker10-lc01 ~]# crictl ps | grep app-aimanager-sdjn-0 #查看容器id
19d15775b7b98       4f660f34512eb       7 days ago          Running             app-aimanager                         0                   37580f242e7d4       app-aimanager-sdjn-0
[root@worker10-lc01 ~]# crictl inspect 19d15775b7b98 | grep pid #查询pid，就是容器的“init 进程”
    "pid": 615713,
            "pid": 1
            "type": "pid"
            
[root@worker10-lc01 ~]# crictl inspect 19d15775b7b98 | jq .info.pid #查询pid，就是容器的“init 进程”
615713

[root@worker10-lc01 ~]# nsenter -t 615713 -n ss -lntp
State      Recv-Q Send-Q                                                 Local Address:Port                                                                Peer Address:Port              
LISTEN     0      2048                                                       127.0.0.1:4001                                                                           *:*                   users:(("rqlited",pid=615729,fd=6))
LISTEN     0      2048                                                       127.0.0.1:4002                                                                           *:*                   users:(("rqlited",pid=615729,fd=3))
LISTEN     0      2048                                                              :::2388                                                                          :::*                   users:(("app-aimanage",pid=615713,fd=8))
LISTEN     0      2048                                                              :::2399                                                                          :::*                   users:(("app-aimanage",pid=615713,fd=9))
LISTEN     0      2048                                                              :::19846                                                                         :::*                   users:(("app-aimanage",pid=615713,fd=24))
[root@worker10-lc01 ~]#  crictl ps | head -n 1
CONTAINER           IMAGE               CREATED             STATE               NAME                                     ATTEMPT             POD ID              POD

[root@worker10-lc01 ~]# 
```





### 1. 查容器端口

```
nsenter -t <pid> -n ss -lntp
```

------

### 2.进入容器(pod中没有bash的情况下进入容器)

```
nsenter -t <pid> -m -u -i -n -p bash
```

### 3.直接抓容器里的流量

```
nsenter -t <pid> -n tcpdump -i any
```

直接抓容器里的流量

### 4.查看容器进程

```
nsenter -t <pid> -p ps aux
nsenter -t <pid> -m -u -i -n -p ps -ef #生产环境测试过，可用
```

### 5.查看容器ip地址

```
nsenter -t 615713 -n ip addr
```



## nsenter命令

```
用法：
 nsenter [选项] <程序> [<参数>...]

使用其他进程的命名空间运行一个程序。

选项：
 -t, --target <pid>     目标进程，从该进程获取命名空间
 -m, --mount[=<file>]   进入挂载（mount）命名空间
 -u, --uts[=<file>]     进入 UTS 命名空间（主机名等）
 -i, --ipc[=<file>]     进入 System V IPC 命名空间
 -n, --net[=<file>]     进入网络（network）命名空间
 -p, --pid[=<file>]     进入 PID 命名空间
 -U, --user[=<file>]    进入用户（user）命名空间
 -S, --setuid <uid>     在进入的命名空间中设置 uid
 -G, --setgid <gid>     在进入的命名空间中设置 gid
     --preserve-credentials 不修改 uid 或 gid
 -r, --root[=<dir>]     设置根目录
 -w, --wd[=<dir>]       设置工作目录
 -F, --no-fork          在执行 <程序> 前不进行 fork
 -Z, --follow-context   根据目标 PID 设置 SELinux 上下文

 -h, --help     显示帮助信息并退出
 -V, --version  输出版本信息并退出

更多详情请参见 nsenter(1)。
```


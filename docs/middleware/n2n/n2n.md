

n2n 内网穿透

n2n 可以进行内网穿透，把各地的节点和中心组成个局域网

| 主机名    | n2n版本 | IP              | 虚拟IP        |
| --------- | ------- | --------------- | ------------- |
| supernode | 3.1.0   | 121.121.121.121 |               |
| agent1    | 3.1.0   | 192.168.8.66    | 192.168.100.3 |
| agent2    | 3.1.0   | 192.168.74.128  | 192.168.100.1 |



在一台有公网地址的主机上部署 ”超级中心“，开放31754端口，公网地址121.121.121.121

```shell
[root@supernode ~]#  wget https://github.com/ntop/n2n/releases/download/3.1.0/n2n-3.1.0-1073.x86_64.rpm
[root@supernode ~]#  yum install epel-release
[root@supernode ~]#  yum install -y n2n-3.1.0-1073.x86_64.rpm
[root@supernode ~]#  cd /etc/n2n/
[root@supernode ~]#  cp supernode.conf.sample supernode.conf
[root@supernode ~]#  vim supernode.conf
-p=31754
[root@supernode ~]#  sudo systemctl start supernode

```

这样就启动超级节点





然后客户端去连接超级节点，客户端之间就可以互相ping，互相连接了

下面是agent1 接入 超级中心

```shell
[root@agent1 ~]#  wget https://github.com/ntop/n2n/releases/download/3.1.0/n2n-3.1.0-1073.x86_64.rpm
[root@agent1 ~]#  yum install epel-release
[root@agent1 ~]#  yum install -y n2n-3.1.0-1073.x86_64.rpm
[root@agent1 ~]# 
[root@agent1 ~]# edge -c myinnetwork -k myinsecretpass -a 192.168.100.3 -f -l 121.121.121.121:31754
出现下面这行就成功了
21/Dec/2021 20:03:41 [edge_utils.c:2731] [OK] edge <<< ================ >>> supernode
```

agent1  

edge -c myinnetwork -k myinsecretpass -a 192.168.100.3 -f -l 121.121.121.121:31754  这行的意思是  -c 指定网络名称 -k 指定接入的密码 -a  给自己设定的虚拟IP  -l 接入超级中心的节点



下面是agent2 接入 超级中心

```shell
[root@agent2 ~]#  wget https://github.com/ntop/n2n/releases/download/3.1.0/n2n-3.1.0-1073.x86_64.rpm
[root@agent2 ~]#  yum install epel-release
[root@agent2 ~]#  yum install -y n2n-3.1.0-1073.x86_64.rpm
[root@agent2 ~]# 
[root@agent2 ~]# edge -c myinnetwork -k myinsecretpass -a 192.168.100.1 -f -l 121.121.121.121:31754
出现下面这行就成功了
21/Dec/2021 20:03:41 [edge_utils.c:2731] [OK] edge <<< ================ >>> supernode
```

查看agent2的 IP信息

```shell
[root@agent2 ~]# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:5e:74:39 brd ff:ff:ff:ff:ff:ff
    inet 192.168.74.128/24 brd 192.168.74.255 scope global noprefixroute dynamic ens33
       valid_lft 1284sec preferred_lft 1284sec
    inet6 fe80::2976:eaa3:a0b4:f828/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: edge0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1290 qdisc pfifo_fast state UNKNOWN group default qlen 1000
    link/ether b6:60:36:ce:7c:fa brd ff:ff:ff:ff:ff:ff
    inet 192.168.100.1/24 brd 192.168.100.255 scope global edge0
       valid_lft forever preferred_lft forever
    inet6 fe80::b460:36ff:fece:7cfa/64 scope link 
       valid_lft forever preferred_lft forever
```

然后ping agent1  ，可以ping通

```shell
[root@agent2 ~]# ping 192.168.100.3
PING 192.168.100.3 (192.168.100.3) 56(84) bytes of data.
64 bytes from 192.168.100.3: icmp_seq=1 ttl=64 time=0.397 ms
64 bytes from 192.168.100.3: icmp_seq=2 ttl=64 time=0.485 ms
^C
--- 192.168.100.3 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 0.397/0.441/0.485/0.044 ms
[root@server ~]# 
```



然后

agent2部署nginx容器

```shell
[root@agent2 ~]# docker run --name nginx -p 80:80 -d nginx          
0c32734399d94dae4df9b651741aa1a7e6f6336d8aaf4bb6cb10d934878ceaad
[root@agent2 ~]# 
[root@agent2 ~]# 
[root@agent2 ~]# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                               NAMES
0c32734399d9   nginx     "/docker-entrypoint.…"   2 seconds ago   Up 2 seconds   0.0.0.0:80->80/tcp, :::80->80/tcp   nginx
```

然后在agent1 上进行访问，可以访问通

```shell
[root@agent1 ~]# curl 192.168.100.1:80
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
[root@agent1 ~]# 
```


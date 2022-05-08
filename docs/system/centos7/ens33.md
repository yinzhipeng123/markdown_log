修改网卡为固定地址

```bash
[root@master ~]# cat /etc/sysconfig/network-scripts/ifcfg-ens33 
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="static"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="ens33"
UUID="f52ff6ca-5e7d-4f00-b4f7-679ef47b77da"
DEVICE="ens33"
ONBOOT="yes"
IPADDR=192.168.70.131
PREFIX=24
GATEWAY=192.168.70.2
DNS1=192.168.70.2
DNS2=114.114.114.114
```


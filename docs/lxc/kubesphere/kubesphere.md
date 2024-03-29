# KubeSphere 单点安装

https://kubesphere.com.cn/docs/quick-start/all-in-one-on-linux/

all in one：

设置4核，8G内存，太小的话，有的服务无法启动，关闭防火墙，关闭selinux

| 主机名  | KubeSphere版本 | IP             |
| ------- | -------------- | -------------- |
| centos7 | 3.1.1          | 192.168.70.130 |

```bash
[root@centos7 ~]# yum install yum-utils device-mapper-persistent-data lvm2 openssl socat conntrack ebtables ipset
[root@centos7 ~]# yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
[root@centos7 ~]# yum list docker-ce --showduplicates | sort -r
[root@centos7 ~]# yum install docker-ce-20.10.6
[root@centos7 ~]# systemctl enable --now docker

[root@centos7 ~]# export KKZONE=cn
[root@centos7 ~]# curl -sfL https://get-kk.kubesphere.io | VERSION=v1.1.1 sh -
[root@centos7 ~]# chmod +x kk
[root@centos7 ~]#./kk create cluster --with-kubernetes v1.20.4 --with-kubesphere v3.1.1
然后会提示让安装依赖，忽略就可以 输入yes，然后就完成了安装
```

启用多集群管理功能

https://v3-1.docs.kubesphere.io/zh/docs/multicluster-management/enable-multicluster/direct-connection/

启动商店

https://v3-1.docs.kubesphere.io/zh/docs/pluggable-components/app-store/

启动Metrics Server功能

[https://kubesphere.com.cn/docs/pluggable-components/metrics-server/#%E5%9C%A8%E5%AE%89%E8%A3%85%E5%90%8E%E5%90%AF%E7%94%A8-metrics-server](https://kubesphere.com.cn/docs/pluggable-components/metrics-server/#在安装后启用-metrics-server)





**需要注意的是，如果使用边缘节点功能，一定要启动Metrics Server功能，否则边缘节点没有监控信息**

## 启用边缘节点功能

官方文档

https://kubesphere.com.cn/docs/pluggable-components/kubeedge/#%E5%9C%A8%E5%AE%89%E8%A3%85%E5%90%8E%E5%90%AF%E7%94%A8-kubeedge

我是安装后启用 KubeEdge，其中文章中

“将 `kubeedge.cloudCore.cloudHub.advertiseAddress` 的值设置为集群的公共 IP 地址或边缘节点可以访问的 IP 地址“ 提到集群的公共 IP 地址，因为我使用的是all in one模式，只有一个IP地址，那么这里我填写的就是192.168.70.130

然后在机器上执行

```bash
[root@centos7 ~] kubectl logs -n kubesphere-system $(kubectl get pod -n kubesphere-system -l app=ks-install -o jsonpath='{.items[0].metadata.name}') -f
```

等待配置更改完成，出现下面这个，就表示变更完成

```bash
#####################################################
###              Welcome to KubeSphere!           ###
#####################################################

Console: http://192.168.70.130:30880
Account: admin
Password: P@88w0rd

NOTES：
  1. After you log into the console, please check the
     monitoring status of service components in
     "Cluster Management". If any service is not
     ready, please wait patiently until all components 
     are up and running.
  2. Please change the default password after login.

#####################################################
https://kubesphere.io             2021-09-01 10:35:12
#####################################################
```

刷新页面，节点管理中，出现边缘节点

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/KubeSphere/edge.png?raw=true)

## 添加边缘节点

https://kubesphere.com.cn/docs/installing-on-linux/cluster-operation/add-edge-nodes/

新建一台机器，来当做边缘节点，关闭防火墙，关闭selinux，我设置的是4G，双核机器

| 主机名   | IP             |
| -------- | -------------- |
| edgenode | 192.168.70.140 |

机器准备工作，安装依赖

```bash
[root@edgenode ~] yum install -y yum-utils device-mapper-persistent-data lvm2 wget
[root@edgenode ~] yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
[root@edgenode ~] yum makecache fast
[root@edgenode ~] yum install docker-ce-19.03.15-3.el7  docker-ce-cli-19.03.15-3.el7 -y
[root@edgenode ~] systemctl enable docker && systemctl restart docker
[root@edgenode ~] vi /etc/nsswitch.conf
//修改这行
hosts:          dns files mdns4_minimal [NOTFOUND=return]

[root@edgenode ~] echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
[root@edgenode ~] sysctl -p | grep ip_forward
```

然后就可以在KubeSphere页面上，节点管理--》边缘节点--》添加节点，输入给node的名字，node的IP地址（**注意：这里这个node的IP地址，不要是node的真实IP地址，这个IP是个虚拟IP地址，类似K8S的clusterIP一样，是个假的IP，下面的图的IP地址，不应该是192.168.70.140，可以设置为1.1.1.1或者2.2.2.2之类的**），然后复制下面的命令

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/KubeSphere/edge_add.png?raw=true)

但是需要把命令中的10000,10001,10002,10004依次更换为30000,30001,30002,30004，如果安装失败，就把--region=zh 改成--region=en

```bash
[root@edgenode ~]# arch=$(uname -m); curl -LO https://kubeedge.pek3b.qingstor.com/bin/v1.6.2/$arch/keadm-v1.6.2-linux-$arch.tar.gz  && tar xvf keadm-v1.6.2-linux-$arch.tar.gz && chmod +x keadm && ./keadm join --kubeedge-version=1.6.2 --region=zh --cloudcore-ipport=192.168.70.130:30000 --quicport 30001 --certport 30002 --tunnelport 30004 --edgenode-name edge-1 --edgenode-ip 192.168.70.140 --token 41c74c8e8f86d03b8560eb5be566c62c33eeac1865cdf3a48ad554e9626ef34e.eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MzA1NTAwNDZ9.mmR51Ue8rduKViXYqEuQQFyNcYol_IHQIm0K53iOQdM --with-edge-taint
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 38.5M  100 38.5M    0     0  1061k      0  0:00:37  0:00:37 --:--:-- 1034k
./keadm
install MQTT service successfully.
kubeedge-v1.6.2-linux-amd64.tar.gz checksum: 
checksum_kubeedge-v1.6.2-linux-amd64.tar.gz.txt content: 
[Run as service] start to download service file for edgecore
[Run as service] success to download service file for edgecore
kubeedge-v1.6.2-linux-amd64/
kubeedge-v1.6.2-linux-amd64/edge/
kubeedge-v1.6.2-linux-amd64/edge/edgecore
kubeedge-v1.6.2-linux-amd64/cloud/
kubeedge-v1.6.2-linux-amd64/cloud/csidriver/
kubeedge-v1.6.2-linux-amd64/cloud/csidriver/csidriver
kubeedge-v1.6.2-linux-amd64/cloud/admission/
kubeedge-v1.6.2-linux-amd64/cloud/admission/admission
kubeedge-v1.6.2-linux-amd64/cloud/cloudcore/
kubeedge-v1.6.2-linux-amd64/cloud/cloudcore/cloudcore
kubeedge-v1.6.2-linux-amd64/version

KubeEdge edgecore is running, For logs visit: journalctl -u edgecore.service -b
```

服务端刷新页面，就添加完成了

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/KubeSphere/edge_add_fin.png?raw=true)

上面添加完后，边缘节点加入集群后，部分 Pod 在调度至该边缘节点上后可能会一直处于 `Pending` 状态。由于部分守护进程集（例如，Calico）有强容忍度，在当前版本中 (KubeSphere 3.2.1)，您需要手动 Patch Pod 以防止它们调度至该边缘节点。

```shell
#!/bin/bash
   
NodeSelectorPatchJson='{"spec":{"template":{"spec":{"nodeSelector":{"node-role.kubernetes.io/master": "","node-role.kubernetes.io/worker": ""}}}}}'
   
NoShedulePatchJson='{"spec":{"template":{"spec":{"affinity":{"nodeAffinity":{"requiredDuringSchedulingIgnoredDuringExecution":{"nodeSelectorTerms":[{"matchExpressions":[{"key":"node-role.kubernetes.io/edge","operator":"DoesNotExist"}]}]}}}}}}}'
   
edgenode="edgenode"
if [ $1 ]; then
        edgenode="$1"
fi
   
   
namespaces=($(kubectl get pods -A -o wide |egrep -i $edgenode | awk '{print $1}' ))
pods=($(kubectl get pods -A -o wide |egrep -i $edgenode | awk '{print $2}' ))
length=${#namespaces[@]}
   
   
for((i=0;i<$length;i++));  
do
        ns=${namespaces[$i]}
        pod=${pods[$i]}
        resources=$(kubectl -n $ns describe pod $pod | grep "Controlled By" |awk '{print $3}')
        echo "Patching for ns:"${namespaces[$i]}",resources:"$resources
        kubectl -n $ns patch $resources --type merge --patch "$NoShedulePatchJson"
        sleep 1
done

```



其实上面arch=$(uname -m)开头的命令，是连接[cloudcore]服务，在页面中查看cloudcore是nodeport的形式提供的，映射都是30000后的端口号，所以需要改下，而`kubeedge.cloudCore.cloudHub.advertiseAddress`则应该是cloudcore服务的IP地址，他们是一个IP地址，all-in-one模式下只有一个IP地址，如果在公网下，cloudcore应该是SLB或者公网地址才行

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/KubeSphere/edge-cloud.png?raw=true)



## 边缘节点重置

如果该边缘节点需要重置，需要如下操作。

```
./keadm reset

yum remove mosquitto

rm -rf  /var/lib/kubeedge /var/lib/edged /etc/kubeedge/ca /etc/kubeedge/certs

rm -rf  /etc/systemd/system/edgecore.service
```

## 删除边缘节点

在集群的机器上执行下面的命令，<edgenode-name>是页面上的边缘节点的名字

```
kubectl delete node <edgenode-name>
```



设置公开集群，在集群的`集群设置`中，`集群可见性`中，`编辑可见性`，拉到最底部，有个`设置为公开集群`的开关打开。

创建企业空间及相关用户

https://kubesphere.com.cn/docs/quick-start/create-workspace-and-project/

导入HELM仓库

https://kubesphere.com.cn/docs/workspace-administration/app-repository/import-helm-repository/

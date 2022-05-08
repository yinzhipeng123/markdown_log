# 本地部署K8S 1.16

实验环境：

| 主机名 | IP地址         | k8s版本 |
| ------ | -------------- | ------- |
| master | 192.168.70.130 | v1.16.9 |
| node1  | 192.168.70.141 | v1.16.9 |
| node1  | 192.168.70.142 | v1.16.9 |

机器都关闭selinux和防火墙

##### 三台机器都执行：

```bash
# cat >> /etc/hosts << EOF
192.168.70.130 k8s-master
192.168.70.141 k8s-node1
192.168.70.142 k8s-node2
EOF
# yum -y install wget vim
# mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak 
# wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
# yum clean all && yum makecache
# yum install net-tools -y
# sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
# 临时禁用
# swapoff -a


# 本文的k8s网络使用flannel，该网络需要设置内核参数bridge-nf-call-iptables=1，修改这个参数需要系统有br_netfilter模块。
# 查看br_netfilter模块：
# lsmod |grep br_netfilter
 
# 如果系统没有br_netfilter模块则执行下面的新增命令，如有则忽略
# 临时新增br_netfilter模块:
# modprobe br_netfilter

# lsmod |grep br_netfilter
br_netfilter           22256  0 
bridge                151336  1 br_netfilter
# 该方式重启后会失效

# 永久新增br_netfilter模块：
# cat > /etc/rc.sysinit << EOF
#!/bin/bash
for file in /etc/sysconfig/modules/*.modules ; do
[ -x $file ] && $file
done
EOF

# cat > /etc/sysconfig/modules/br_netfilter.modules << EOF
modprobe br_netfilter
EOF

# chmod 755 /etc/sysconfig/modules/br_netfilter.modules


# cat <<EOF >  /etc/sysctl.d/k8s.conf
vm.swappiness                       = 0
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-iptables  = 1
EOF


# cat > /etc/sysconfig/modules/ipvs.modules <<EOF
#!/bin/bash
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack
EOF
# chmod 755 /etc/sysconfig/modules/ipvs.modules && bash /etc/sysconfig/modules/ipvs.modules && lsmod | grep -e ip_vs -e nf_conntrack_ipv4


# yum install yum-utils device-mapper-persistent-data lvm2 openssl socat conntrack ebtables ipset
# yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# yum list docker-ce --showduplicates | sort -r

# yum install -y docker-ce-18.09.9 docker-ce-cli-18.09.9 containerd.io
# systemctl enable docker && systemctl start docker
#

# mkdir /etc/docker
# cat > /etc/docker/daemon.json <<EOF
{
  # "registry-mirrors": [
    "https://registry.docker-cn.com",
    "http://hub-mirror.c.163.com",
    "https://docker.mirrors.ustc.edu.cn"
  ], "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF

# systemctl daemon-reload && systemctl restart docker



# cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

# 更新缓存
# yum clean all
# yum -y makecache
# yum list kubelet --showduplicates | sort -r
# yum install -y kubelet-1.16.9 kubeadm-1.16.9 kubectl-1.16.9
# systemctl enable kubelet.service && systemctl start kubelet

# vi image.sh
#!/bin/bash
url=registry.cn-hangzhou.aliyuncs.com/google_containers
version=v1.16.9
images=(`kubeadm config images list --kubernetes-version=$version|awk -F '/' '{print $2}'`)
for imagename in ${images[@]} ; do
  docker pull $url/$imagename
  docker tag $url/$imagename k8s.gcr.io/$imagename
  docker rmi -f $url/$imagename
done

# chmod 777 image.sh
# ./image.sh
```

##### master执行：

```bash
# kubeadm init \
--apiserver-advertise-address=192.168.70.130 \
--image-repository registry.cn-hangzhou.aliyuncs.com/google_containers \
--kubernetes-version v1.16.9 \
--service-cidr=10.1.0.0/16 \
--pod-network-cidr=10.244.0.0/16

W0628 09:01:05.568405   20714 configset.go:202] WARNING: kubeadm cannot validate component configs for API groups 
...省略...
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.70.130:6443 --token eufass.9mj0z1oafwjwna8y \
    --discovery-token-ca-cert-hash sha256:1899cb7904899c7377fa01ca452d7260241f2f333f6dfff1bc843f338224ffb9 


# echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> ~/.bash_profile
# source .bash_profile
# mkdir -p $HOME/.kube
# cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# chown $(id -u):$(id -g) $HOME/.kube/config
查看集群状态
# kubectl get cs
NAME                 AGE
scheduler            <unknown>
controller-manager   <unknown>
etcd-0               <unknown>
# kubectl get cs -o=go-template='{{printf "|NAME|STATUS|MESSAGE|\n"}}{{range .items}}{{$name := .metadata.name}}{{range .conditions}}{{printf "|%s|%s|%s|\n" $name .status .message}}{{end}}{{end}}'
|NAME|STATUS|MESSAGE|
|scheduler|True|ok|
|controller-manager|True|ok|
|etcd-0|True|{"health":"true"}|


部署网络
# 这个yml文件可以提前下载下来
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/2140ac876ef134e0ed5af15c65e414cf26827915/Documentation/kube-flannel.yml

# kubectl get ds -l app=flannel -n kube-system
NAME                      DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
kube-flannel-ds-amd64     1         1         1       1            1           <none>          39s
kube-flannel-ds-arm       0         0         0       0            0           <none>          39s
kube-flannel-ds-arm64     0         0         0       0            0           <none>          39s
kube-flannel-ds-ppc64le   0         0         0       0            0           <none>          39s
kube-flannel-ds-s390x     0         0         0       0            0           <none>          39s


# kubeadm token create --print-join-command
W0628 09:12:59.371222   26258 configset.go:202] WARNING: kubeadm cannot validate component configs for API groups [kubelet.config.k8s.io kubeproxy.config.k8s.io]
kubeadm join 192.168.70.130:6443 --token jf0j4u.lieaijygwth7jcoo     --discovery-token-ca-cert-hash sha256:1899cb7904899c7377fa01ca452d7260241f2f333f6dfff1bc843f338224ffb9 

```

##### node执行：

```
# kubeadm join 192.168.119.191:6443 --token jf0j4u.lieaijygwth7jcoo     --discovery-token-ca-cert-hash sha256:1899cb7904899c7377fa01ca452d7260241f2f333f6dfff1bc843f338224ffb9
```

测试集群：

```bash
在master上执行

# kubectl run curl --image=radial/busyboxplus:curl -it
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
If you don't see a command prompt, try pressing enter.

$ nslookup kubernetes.default
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

Name:      kubernetes.default
Address 1: 10.96.0.1 kubernetes.default.svc.cluster.local

# 测试集群是否正常

# kubectl create deployment nginx --image=nginx
deployment.apps/nginx created

# 创建service
# kubectl expose deployment nginx --port=80 --type=NodePort
service/nginx exposed

# kubectl get pods,svc
NAME                         READY   STATUS              RESTARTS   AGE
pod/nginx-6799fc88d8-wp9db   0/1     ContainerCreating   0          19s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)        AGE
service/kubernetes   ClusterIP   10.1.0.1     <none>        443/TCP        31m
service/nginx        NodePort    10.1.245.2   <none>        80:31532/TCP   6s

$ curl 10.1.245.2
<!DOCTYPE html>
<html>
<head>
```


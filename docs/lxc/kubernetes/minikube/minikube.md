# 部署Minikube

### ECS部署Minikube

我的ECS是腾讯云的，Centos7.6 镜像，地域在硅谷，因为K8S很多镜像都在海外，国内即使有腾讯阿里的源，但是经常也下载不下来，折腾了很多遍，不折腾了，直接地域选择海外，节省很多心力

官方源码：[kubernetes/minikube: Run Kubernetes locally (github.com)](https://github.com/kubernetes/minikube)

官网操作文档：[minikube start | minikube (k8s.io)](https://minikube.sigs.k8s.io/docs/start/)

机器需要安装  Kubectl和Docker

Kubectl安装：https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

版本选择：

```shell
#设置源
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum list kubectl --showduplicates | sort -r
yum install -y kubectl-1.18.20-0
```

Docker安装：https://docs.docker.com/engine/install/centos/

```bash
 sudo yum install -y yum-utils
 sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
 sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
 systemctl start docker
 systemctl enable docker
```

安装minikube

```bash
#安装minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
# minikube启动集群，--image-mirror-country='cn'就是在中国区安装集群，下载镜像从阿里云下，经过测试，发现还是有很多镜像下载不下来
# minikube start --image-mirror-country='cn' --force --driver=docker --nodes=2 --cpus=2 --memory=3000MB --network-plugin=cni --cni=flannel --extra-config=kubeadm.pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.18.20 
# 海外直接用下面这条命令
minikube start --force --driver=docker --nodes=2   --network-plugin=cni --cni=flannel --extra-config=kubeadm.pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.18.20 

#如果不设置cni，后续添加节点，会出现Cluster was created without any CNI, adding a node to it might cause broken networking。就是后续的节点无法访问集群内的service
#添加节点，可以不添加，上面命令已经添加了两个节点
minikube node add 

部署完成
```



转发 service 的端口到ecs 的端口 ，-n 指定命名空间，也可以直接映射POD

```
kubectl port-forward -n infra svc/consul-net --address 0.0.0.0 8500:8500
```

```
kubectl port-forward -n namespace $POD_NAME --address 0.0.0.0  3306:3306
```

后台运行

```
nohup kubectl port-forward svc/infra-consul-net --address 0.0.0.0  8500:8500 >>forward-8500.log 2>&1 &
```

访问k8s面板

```
kubectl proxy --port=8001 --address='0.0.0.0' --accept-hosts='^.*' --disable-filter=true
```

访问dashboard地址

http://ECS地址:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/overview?namespace=default

测试集群

```bash
# 创建deployment
# kubectl create deployment nginx --image=nginx
deployment.apps/nginx created
#扩容deployment
# kubectl scale deployment nginx --replicas=5
deployment.apps/nginx scaled
# 创建service
# kubectl expose deployment nginx --port=80 --type=NodePort
service/nginx exposed

# kubectl get pods,svc

```

测试完集群，可以重新初始化集群，省的一个个删除资源

```shell
#停止集群
minikube stop
#删除集群
minikube delete
```



### Mac 部署 minikube

因为很多镜像在海外，需要安装代理软件

[Release 支持apple arm64,修复trojan导入问题 · yanue/V2rayU (github.com)](https://github.com/yanue/V2rayU/releases/tag/3.3.0)

设置好代理之后，在mac终端内粘贴如下命令

```
export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;export ALL_PROXY=socks5://127.0.0.1:1080 export NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.59.0/24,192.168.49.0/24,192.168.39.0/24
```

下载安装virtualbox

[Downloads – Oracle VM VirtualBox](https://www.virtualbox.org/wiki/Downloads)

安装kubectl

[Install and Set Up kubectl on macOS | Kubernetes](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/)

开始安装minikube

```bash
$ minikube start --force --driver=virtualbox --kubernetes-version=v1.18.20 --nodes=2
😄  Darwin 11.6.5 上的 minikube v1.26.1
❗  minikube skips various validations when --force is supplied; this may lead to unexpected behavior
✨  根据用户配置使用 virtualbox 驱动程序
❗  Local proxy ignored: not passing HTTP_PROXY=http://127.0.0.1:1087 to docker env.
❗  Local proxy ignored: not passing HTTPS_PROXY=http://127.0.0.1:1087 to docker env.
👍  Starting control plane node minikube in cluster minikube
🔥  Creating virtualbox VM (CPUs=2, Memory=2200MB, Disk=20000MB) ...
❗  Local proxy ignored: not passing HTTP_PROXY=http://127.0.0.1:1087 to docker env.
❗  Local proxy ignored: not passing HTTPS_PROXY=http://127.0.0.1:1087 to docker env.
🌐  找到的网络选项：
    ▪ NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.59.0/24,192.168.49.0/24,192.168.39.0/24
    ▪ http_proxy=http://127.0.0.1:1087
    ▪ https_proxy=http://127.0.0.1:1087
❗  This VM is having trouble accessing https://k8s.gcr.io
💡  To pull new external images, you may need to configure a proxy: https://minikube.sigs.k8s.io/docs/reference/networking/proxy/
🐳  正在 Docker 20.10.17 中准备 Kubernetes v1.18.20…
    ▪ env NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.59.0/24,192.168.49.0/24,192.168.39.0/24
    ▪ kubelet.cni-conf-dir=/etc/cni/net.mk
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔗  Configuring CNI (Container Networking Interface) ...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass
🔎  Verifying Kubernetes components...

👍  Starting worker node minikube-m02 in cluster minikube
🔥  Creating virtualbox VM (CPUs=2, Memory=2200MB, Disk=20000MB) ...
❗  Local proxy ignored: not passing HTTP_PROXY=http://127.0.0.1:1087 to docker env.
❗  Local proxy ignored: not passing HTTPS_PROXY=http://127.0.0.1:1087 to docker env.
🌐  找到的网络选项：
    ▪ NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.59.0/24,192.168.49.0/24,192.168.39.0/24
    ▪ http_proxy=http://127.0.0.1:1087
    ▪ https_proxy=http://127.0.0.1:1087
❗  This VM is having trouble accessing https://k8s.gcr.io
💡  To pull new external images, you may need to configure a proxy: https://minikube.sigs.k8s.io/docs/reference/networking/proxy/
🐳  正在 Docker 20.10.17 中准备 Kubernetes v1.18.20…
    ▪ env NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.59.0/24,192.168.49.0/24,192.168.39.0/24
🔎  Verifying Kubernetes components...

❗  /usr/local/bin/kubectl is version 1.25.0, which may have incompatibilites with Kubernetes 1.18.20.
    ▪ Want kubectl v1.18.20? Try 'minikube kubectl -- get pods -A'
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default

$ kubectl get node -A -o wide
NAME           STATUS   ROLES    AGE   VERSION    INTERNAL-IP      EXTERNAL-IP   OS-IMAGE               KERNEL-VERSION   CONTAINER-RUNTIME
minikube       Ready    master   21m   v1.18.20   192.168.59.107   <none>        Buildroot 2021.02.12   5.10.57          docker://20.10.17
minikube-m02   Ready    <none>   20m   v1.18.20   192.168.59.108   <none>        Buildroot 2021.02.12   5.10.57          docker://20.10.17
```




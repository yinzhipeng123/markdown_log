# ECS部署Minikube



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








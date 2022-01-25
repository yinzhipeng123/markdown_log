# ECS部署Minikube



我的ECS是腾讯云的，Centos7.6 镜像

机器需要安装  Kubectl和Docker

Kubectl安装：https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

Docker安装：https://mirrors.cloud.tencent.com/help/docker-ce.html



```bash
#安装minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
#minikube启动集群
minikube start --image-mirror-country='cn' --force --driver=docker  -n=2 --cpus=2 --memory=3000MB --network-plugin=cni --cni=flannel --extra-config=kubeadm.pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.18.20 
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



https://developer.aliyun.com/article/221687
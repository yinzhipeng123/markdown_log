## 1.主机内目录挂载到pod中

把本地目录挂载到POD中

```bash
[root@VM-0-16-centos ~]# cat host.yaml 
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    volumeMounts:
    - mountPath: /xin
      name: volume
  volumes:
  - name: volume
    hostPath:
      path: /xin 

#查看容器
[root@VM-0-16-centos ~]# kubectl exec -it nginx bash
root@nginx:/# cd /xin
root@nginx:/xin# touch hello
root@nginx:/xin# exit
#查看POD所在主机
root@minikube-m02:/# ls /xin/
hello
root@minikube-m02:/# cd /xin/
root@minikube-m02:/xin# touch helloworld
#查看容器
[root@VM-0-16-centos ~]# kubectl exec -it nginx bash      
root@nginx:/# ls /xin
hello  helloworld
```

此方法可以把主机目录挂载到容器上，但是不能把容器初始化后的目录挂载到宿主机上，例如。把/data 挂载到 容器的/etc目录，容器就会起不来

样例：

应用设置为hostpath并设置尽量不在同一台机器上部署POD

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: infra-nginx
  namespace: default
  labels:
    app: infra-nginx
    version: infra-nginx-uat-podname
spec:
  replicas: 2
  progressDeadlineSeconds: 600
  selector:
    matchLabels:
      app: infra-nginx
  template:
    metadata:
      labels:
        app: infra-nginx
        version: infra-nginx-uat-podname
    spec:
      containers:
      - image: nginx
        name: nginx
        volumeMounts:
        - mountPath: /yun
          name: volume
      volumes:
      - name: volume
        hostPath:
          path: /yun
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
            - podAffinityTerm:
                labelSelector:
                  matchExpressions:
                    - key: app
                      operator: In
                      values:
                        - infra-nginx
                topologyKey: kubernetes.io/hostname
              weight: 100
```

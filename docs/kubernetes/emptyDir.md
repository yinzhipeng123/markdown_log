# emptyDir

emptyDir类型的存储卷创建于Pod被调度到宿主机上的时候，同一个Pod内的多个容器能读写emptyDir中的同一个文件，一旦这个Pod销毁或者漂移开该宿主机，emptyDir中的数据就会被永久删除。emptyDir类型的存储卷主要用作临时空间或者不同容器之间的数据共享。容器的crashing事件并不会导致emptyDir中的数据被删除。

emptyDir支持内存作为存储资源，emptyDir.medium设为Memory即可，但如果遇到node节点重启，emptyDir中的数据也会全部丢失。



以下演示如何在Pod中不同容器之间共享数据。

vi emptydir-pod.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: emptydir-pod
spec:
  #定义emptyDir存储卷，名称my-emptydir-vol
  volumes:
    - name: my-emptydir-vol
      emptyDir: {}
  containers:
    - name: busybox-1
      image: busybox:latest
      command:
        - "sleep"
        - "3600"
      #将my-emptydir-vol存储卷Mount到容器中
      volumeMounts:
        - name: my-emptydir-vol
          #此路径为容器中目录
          mountPath: /data-1
    - name: busybox-2
      image: busybox:latest
      command:
        - "sleep"
        - "3600"
      #将my-emptydir-vol存储卷Mount到容器中
      volumeMounts:
        - name: my-emptydir-vol
          mountPath: /data-2
```

kubectl apply -f emptydir-pod.yaml

进入容器busybox-1，存在/data-1目录

```bash
kubectl exec -it emptydir-pod -c busybox-1 sh

ls
bin     data-1  dev     etc     home    proc    root    sys     tmp     usr     var

```

在容器busybox-1向共享目录中/data-1创建一个文件

```bash
cd data-1
echo "hello world" > hello.txt
exit
```


容器busybox-2的共享目录中/data-2确实能够访问容器busybox-1创建的文件，注意busybox-1:/data-1 = busybox-2:/data-2

```bash
kubectl exec -it emptydir-pod -c busybox-2 sh
cat /data-2/hello.txt
hello world
exit
```


我们看看emptyDir存储卷在宿主机的位置。在k8s-node1节点，在Pod临时目录下存在my-emptydir-vol目录，容器创建的文件就存放在该目录中。Pod的临时目录会在Pod销毁时删除，其中my-emptydir-vol也会被附带删除。

```
kubectl get pod -o yaml | grep nodeName
    nodeName: k8s-node1
kubectl get pod -o yaml | grep uid
    uid: e70923f9-156a-4fde-98be-e77f3f65fbd9

#在k8s-node1节点
tree /var/lib/kubelet/pods/e70923f9-156a-4fde-98be-e77f3f65fbd9/
/var/lib/kubelet/pods/e70923f9-156a-4fde-98be-e77f3f65fbd9/
├── containers
│   ├── busybox-1
│   │   ├── 753e3ae2
│   │   └── 96560e76
│   └── busybox-2
│       ├── 1a8b5849
│       └── a6a696a2
├── etc-hosts
├── plugins
│   └── kubernetes.io~empty-dir
│       ├── my-emptydir-vol
│       │   └── ready
│       └── wrapped_default-token-wtqgl
│           └── ready
└── volumes
    ├── kubernetes.io~empty-dir
    │   └── my-emptydir-vol
    │       └── hello.txt
    └── kubernetes.io~secret
        └── default-token-wtqgl
            ├── ca.crt -> ..data/ca.crt
            ├── namespace -> ..data/namespace
            └── token -> ..data/token

cat /var/lib/kubelet/pods/e70923f9-156a-4fde-98be-e77f3f65fbd9/volumes/kubernetes.io~empty-dir/my-emptydir-vol/hello.txt
hello world
```


删除Pod，查看Pod临时目录。发现已经没有Pod临时目录e70923f9-156a-4fde-98be-e77f3f65fbd9了。

```
kubectl delete -f emptydir-pod.yaml

#在k8s-node1节点
ls /var/lib/kubelet/pods/
```



# Liveness 

liveness   用户可以设置自定义条件，通过条件探测判断容器是否健康。如果探测失败，Kubernetes就会重启应用

举例说明，创建如下pod：

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    test: liveness
  name: liveness
spec:
  restartPolicy: OnFailure
  containers:
  - name: liveness
    image: busybox
    args:
    - /bin/sh
    - -c
    - touch /tmp/healthy; sleep 30; rm -rf /tmp/healthy; sleep 600
    livenessProbe:
      exec:
        command:
        - cat
        - /tmp/healthy
      initialDelaySeconds: 10
      periodSeconds: 5
```



启动进程首先创建文件 /tmp/healthy，30 秒后删除，在我们的设定中，如果 /tmp/healthy 文件存在，则认为容器处于正常状态，反正则发生故障。
livenessProbe 部分定义如何执行 Liveness 探测：
1. 探测的方法是：通过 cat 命令检查 /tmp/healthy 文件是否存在。如果命令执行成功，返回值为零，Kubernetes 则认为本次 Liveness 探测成功；如果命令返回值非零，本次 Liveness 探测失败。

2. initialDelaySeconds: 10 指定容器启动 10 之后开始执行 Liveness 探测，我们一般会根据应用启动的准备时间来设置。比如某个应用正常启动要花 30 秒，那么 initialDelaySeconds 的值就应该大于 30。

3. periodSeconds: 5 指定每 5 秒执行一次 Liveness 探测。Kubernetes 如果连续执行 3 次 Liveness 探测均失败，则会杀掉并重启容器。



下面创建 Pod liveness：

```sh 
ubantu@k8s-master:~$
ubantu@k8s-master:~$ kubectl apply -f liveness.yml
pod "liveness" created 
ubantu@k8s-master:~$
```

从配置文件可知，最开始的 30 秒，/tmp/healthy 存在，cat 命令返回 0，Liveness 探测成功，这段时间 kubectl describe pod liveness 的 Events部分会显示正常的日志。

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202208151818444.png)

35 秒之后，日志会显示 /tmp/healthy 已经不存在，Liveness 探测失败。再过几十秒，几次探测都失败后，容器会被重启。

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202208151819349.png)

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202208151820981.png)

除了 Liveness 探测，Kubernetes Health Check 机制还包括 Readiness 探测



阿里云对应的设置：

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202208151824666.png)
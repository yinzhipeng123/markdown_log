# Readiness

用户通过Liveness探测可以告诉Kubernetes什么时候通过重启容器实现自愈；Readiness探测则是告诉Kubernetes什么时候可以将容器加入到Service负载均衡池中，对外提供服务。



```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    test: readiness
  name: readiness
spec:
  restartPolicy: OnFailure
  containers:
  - name: readiness
    image: busybox
    args:
    - /bin/sh
    - -c
    - touch /tmp/healthy; sleep 30; rm -rf /tmp/healthy; sleep 600
    readinessProbe:
      exec:
        command:
        - cat
        - /tmp/healthy
      initialDelaySeconds: 10
      periodSeconds: 5
```

这个配置文件只是将前面例子中的 liveness 替换为了 readiness，我们看看有什么不同的效果。

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202208151835262.png)

Pod readiness 的 READY 状态经历了如下变化：
1. 刚被创建时，READY 状态为不可用。

2. 15 秒后（initialDelaySeconds + periodSeconds），第一次进行 Readiness 探测并成功返回，设置 READY 为可用。

3. 30 秒后，/tmp/healthy 被删除，连续 3 次 Readiness 探测均失败后，READY 被设置为不可用。

通过 kubectl describe pod readiness 也可以看到 Readiness 探测失败的日志。

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202208151835844.png)

下面对 Liveness 探测和 Readiness 探测做个比较：
1. Liveness 探测和 Readiness 探测是两种 Health Check 机制，如果不特意配置，Kubernetes 将对两种探测采取相同的默认行为，即通过判断容器启动进程的返回值是否为零来判断探测是否成功。

2. 两种探测的配置方法完全一样，支持的配置参数也一样。不同之处在于探测失败后的行为：Liveness 探测是重启容器；Readiness 探测则是将容器设置为不可用，不接收 Service 转发的请求。

3. Liveness 探测和 Readiness 探测是独立执行的，二者之间没有依赖，所以可以单独使用，也可以同时使用。用 Liveness 探测判断容器是否需要重启以实现自愈；用 Readiness 探测判断容器是否已经准备好对外提供服务。

阿里云对应的位置：

![Untitled](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202208151836114.png)
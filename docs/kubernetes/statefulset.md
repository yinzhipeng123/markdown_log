StatefulSet 

Demo

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: infra-nginx
  namespace: default
  labels:
    app: infra-nginx
    version: infra-nginx-uat-podname
spec:
  serviceName: "infra-nginx"
  replicas: 2
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



```bash
[root@VM-0-16-centos ~]# kubectl get pod            
NAME            READY   STATUS    RESTARTS   AGE
infra-nginx-0   1/1     Running   0          21m
infra-nginx-1   1/1     Running   0          21m
```



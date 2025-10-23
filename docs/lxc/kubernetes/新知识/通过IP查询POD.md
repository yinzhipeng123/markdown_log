

通过IP查询POD

```
kubectl get pods --all-namespaces -o wide | grep <IP地址>

kubectl get pods --all-namespaces -o wide | grep 10.6.64.42
```


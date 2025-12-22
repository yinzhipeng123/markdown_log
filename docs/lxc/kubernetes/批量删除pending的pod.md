

查询：

```bash
kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=paas5.xxx.com  | grep ContainerCreating 
```

删除：

```bash
kubectl delete pods --all-namespaces --field-selector spec.nodeName=paas5.xxx.com,status.phase=Pending
```


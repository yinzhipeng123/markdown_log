查看POD中几个容器

```bash
kubectl get pod <pod-name> -o jsonpath='{.spec.containers[*].name}'
```


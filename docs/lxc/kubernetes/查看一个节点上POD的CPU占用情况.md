

```bash
kubectl get pods -A -o custom-columns="NAMESPACE:.metadata.namespace,POD:.metadata.name,NODE:.spec.nodeName,CPU_REQ:.spec.containers[0].resources.requests.cpu,CPU_LIM:.spec.containers[0].resources.limits.cpu,MEM_REQ:.spec.containers[0].resources.requests.memory,MEM_LIM:.spec.containers[0].resources.limits.memory" | grep worker6.xxx.com  | sort -k4
```


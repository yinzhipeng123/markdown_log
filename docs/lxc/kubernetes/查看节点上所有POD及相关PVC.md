

```bash
kubectl get pods -A -o wide --field-selector spec.nodeName=worker6.XXXXX.com   -o custom-columns="NAMESPACE:.metadata.namespace,NAME:.metadata.name,NODE:.spec.nodeName,PVCs:.spec.volumes[*].persistentVolumeClaim.claimName"
```


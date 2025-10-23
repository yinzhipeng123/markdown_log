



```bash
kubectl delete pod renzheng-proxy-xian-0 -n console --force --grace-period=0 --wait=false
kubectl delete pvc -n console renzheng-proxy-log-renzheng-proxy-xian-0 renzheng-flume-log-renzheng-proxy-xian-0 --wait=false
```


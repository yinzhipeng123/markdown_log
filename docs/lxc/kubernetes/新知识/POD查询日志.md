



```bash
[root@k8smaster1 ~]# kubectl get pod -n base | grep lb
lb-controller-region-68f97c5798-qsfr2                      1/1     Running             1 (14d ago)   15d
lb-controller-region-68f97c5798-wr85s                      1/1     Running             0             15d
[root@k8smaster1 ~]# kubectl logs lb-controller-region-68f97c5798-wr85s -n base --tail=20
```


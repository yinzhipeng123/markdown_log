

NFS作为PV来演示



nfs服务器

```yaml
yum install -y nfs-common nfs-utils rpcbind
mkdir /nfsdata
chmod 666 /nfsdata
cat /etc/exports
	/nfsdata *(rw,no_root_squash,no_all_squash,sync)
systemctl start rpcbind
systemctl start nfs
```

部署PV

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfspv
spec:
  capacity:
    storage: 1Gi
  accessModes: 
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle
  storageClassName: nfs
  nfs:
    path: /nfsdata
    server:1.1.1.1
```

创建服务

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx
  labels:
  	app: nginx
spec:
  ports:
  - port: 80
    name: web
  clusterIP: None
  selector:
    app: nginx
```

创建StatefulSet

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  selector:
    matchLabels:
      app: nginx
  serviceName: "nginx"
  replicas: 3
  template:
    metadata:
      labels:
        app: nginx
     spec:
       containers:
       - name: nginx
         image: k8s.gcr.io/nginx-slim:0.8
         ports:
         - containerPort: 80
           name: web
         volumeMounts:
         - name: www
           mountPath: /usr/share/nginx/html
volumeClaimTemplates:
- metadata:
    name: www
  spec:
    accessModes: [ "ReadWriteOnce" ]
    storageClassName: "nfs"
    resources:
      requests:
        storage: 1Gi
```


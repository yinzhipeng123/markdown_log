以下是使用 **StatefulSet** 部署 MySQL 的完整示例，包含持久化存储、服务暴露等内容。StatefulSet 是部署 MySQL 等有状态应用的最佳实践。

------

### **1. 准备 MySQL 的 Persistent Volume Claim (PVC)**

StatefulSet 为每个 Pod 分配独立的 PVC，以确保每个实例的数据独立持久化。

**示例 YAML 文件：`mysql-pvc.yaml`**

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pvc
  namespace: default
  labels:
    app: mysql
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```

**命令：**

```bash
kubectl apply -f mysql-pvc.yaml
```

------

### **2. 创建 MySQL Secret (存储 MySQL 的 root 密码)**

为了提高安全性，MySQL 密码使用 Secret 管理。

**示例 YAML 文件：`mysql-secret.yaml`**

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secret
type: Opaque
data:
  mysql-root-password: <Base64编码后的密码>  # 用 echo -n "密码" | base64 生成
```

**命令：**

```bash
kubectl apply -f mysql-secret.yaml
```

------

### **3. 创建 StatefulSet 和 Service**

StatefulSet 确保每个 MySQL Pod 都有唯一标识和独立存储。

**示例 YAML 文件：`mysql-statefulset.yaml`**

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mysql
  labels:
    app: mysql
spec:
  ports:
  - port: 3306
    targetPort: 3306
  clusterIP: None  # Headless Service，用于 StatefulSet 的 Pod 发现
  selector:
    app: mysql
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
spec:
  serviceName: mysql
  replicas: 1  # 可调整为更多副本
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:8.0
        ports:
        - containerPort: 3306
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: mysql-root-password
        volumeMounts:
        - name: mysql-storage
          mountPath: /var/lib/mysql
  volumeClaimTemplates:
  - metadata:
      name: mysql-storage
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 10Gi
```

------

### **4. 部署 MySQL**

**命令：**

```bash
kubectl apply -f mysql-statefulset.yaml
```

------

### **5. 验证部署**

1. **检查 Pod 状态：**

   ```bash
   kubectl get pods
   ```

   确保 MySQL Pod 状态为 `Running`。

2. **检查 Service 状态：**

   ```bash
   kubectl get svc
   ```

   确认 Headless Service 已正确创建。

3. **连接 MySQL：** 使用临时容器测试连接：

   ```bash
   kubectl run mysql-client --image=mysql:8.0 -it --rm -- bash
   ```

   在容器内运行以下命令连接：

   ```bash
   mysql -h mysql-0.mysql -u root -p
   ```

   （`mysql-0.mysql` 是第一个 Pod 的主机名，`mysql` 是 Headless Service 的名称。）

------

### **6. 如果需要扩展为主从架构**

可以调整 StatefulSet 的副本数，并通过初始化脚本或 MySQL 配置文件实现主从复制（例如使用 `ConfigMap` 或自定义镜像）。

------

### **StatefulSet 的优势**

- **稳定的网络标识**：每个 Pod 都有固定的名称（如 `mysql-0`、`mysql-1`）。
- **独立存储**：每个实例有自己的 PVC，数据不会相互干扰。
- **有序启动/停止**：适合主从复制或其他有状态需求。

如果需要添加高可用 MySQL 的具体配置或支持多副本读写分离，告诉我！
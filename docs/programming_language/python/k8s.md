Python 使用K8S API



```python
from kubernetes import client, config
config_file = r"config"
config.kube_config.load_kube_config(config_file=config_file)
# 获取K8S 核心API接口
Api_Instance = client.CoreV1Api()
# 获取K8S APP APIJ接口
apps_api = client.AppsV1Api()
print(apps_api.list_deployment_for_all_namespaces())
```

获取所有的deployment详情

config文件为K8S链接文件config



官方地址：

https://github.com/kubernetes-client/python



```python
from kubernetes import client, config
import json

config_file = r"config"

config.kube_config.load_kube_config(config_file=config_file)

v1 = client.CoreV1Api()
print("Listing pods with their IPs:")
ret = v1.list_pod_for_all_namespaces(watch=False)
for i in ret.items:
    print("%s\t%s\t%s" % (i.status.pod_ip, i.metadata.namespace, i.metadata.name))
```


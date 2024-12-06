ETC备份



```bash
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
--cacert=/opt/KUIN00601/ca.crt \
--cert=/opt/KUIN00601/etcd-client.crt \
--key=/opt/KUIN00601/etcd-client.key \
snapshot save /var/lib/backup/etcd-snapshot.db
```

这条命令是用来备份 **etcd** 数据库的快照。具体来说，`etcdctl` 是 **etcd** 的命令行工具，通过它可以进行各种管理操作。

命令解释如下：

- [ ] `ETCDCTL_API=3`：指定使用 `etcdctl` 的 API 版本 3。etcd 采用了多个版本的 API，版本 3 是最新的，支持更多的功能和更高的性能。
- [ ] `etcdctl --endpoints=https://127.0.0.1:2379`：指定 **etcd** 集群的端点地址，这里是 `https://127.0.0.1:2379`，即本地的 etcd 服务。
- [ ] `--cacert=/opt/KUIN00601/ca.crt`：指定用于验证 etcd 服务的 **CA 证书**，确保连接是安全的并且经过信任验证。
- [ ] `--cert=/opt/KUIN00601/etcd-client.crt`：指定客户端的 **证书**，用于身份验证，确保连接到 etcd 的客户端是经过授权的。
- [ ] `--key=/opt/KUIN00601/etcd-client.key`：指定客户端的 **私钥**，用于加密通信。
- [ ] `snapshot save /var/lib/backup/etcd-snapshot.db`：创建 etcd 数据库的快照，并将其保存到 `/var/lib/backup/etcd-snapshot.db` 路径中。这个快照文件可以在需要恢复时使用。

总结来说，这条命令会连接到本地的 etcd 服务，使用指定的证书和密钥进行认证，创建一个数据库快照，并将该快照保存到 `/var/lib/backup/etcd-snapshot.db` 文件中。





```bash
ETCDCTL_API=3 etcdctl --write-out=table snapshot status /var/lib/backup/etcd-snapshot.db
```

这条命令的作用是检查指定的 **etcd** 快照的状态。具体解释如下：

- `ETCDCTL_API=3`：指定使用 **etcdctl** 的 API 版本 3。
- `etcdctl`：这是 **etcd** 的命令行工具。
- `--write-out=table`：指定输出格式为表格形式，方便阅读和查看信息。
- `snapshot status /var/lib/backup/etcd-snapshot.db`：查询指定的快照文件 `/var/lib/backup/etcd-snapshot.db` 的状态。这将显示快照的详细信息，包括快照的大小、创建时间、数据的健康状态等。







```bash
mkdir /opt/backup #创建系统配置文件备份目录， 其实可以不创建， 直接将系统配置文件移到已存在的/data/backup
mkdir /var/lib/etcd-restore #创建 Etcd 备份将要恢复数据的位置目录
mv /etc/kubernetes/manifests/* /opt/backup/ #将系统配置文件移动至此目录， 即官网所述停止所有 API 实例
etcdutl --data-dir=/var/lib/etcd-restore snapshot restore /data/backup/etcd-snapshot-previous.db
```



- [ ] `etcdutl`：这应该是一个打错的命令，正确的命令是 `etcdctl`。它是 **etcd** 的命令行工具。
- [ ] `--data-dir=/var/lib/etcd-restore`：指定恢复的 **etcd** 数据将存放的位置，即 `/var/lib/etcd-restore` 目录。
- [ ] `snapshot restore`：指定执行 **etcd** 快照恢复操作。
- [ ] `/data/backup/etcd-snapshot-previous.db`：指定用于恢复的数据快照文件的路径，这里是 `/data/backup/etcd-snapshot-previous.db`。这个文件应该是之前创建的 **etcd** 数据快照。

### 
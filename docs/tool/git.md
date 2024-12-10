记录一个git提交过程中的一个报错

```bash
[main 3a71b901] commit_message
 3 files changed, 2 insertions(+), 2 deletions(-)
Enumerating objects: 1553, done.
Counting objects: 100% (1553/1553), done.
Delta compression using up to 8 threads
Compressing objects: 100% (496/496), done.
Writing objects: 100% (897/897), 972.21 KiB | 1.04 MiB/s, done.
Total 897 (delta 431), reused 0 (delta 0), pack-reused 0
error: RPC failed; HTTP 400 curl 22 The requested URL returned error: 400
send-pack: unexpected disconnect while reading sideband packet
fatal: the remote end hung up unexpectedly
Everything up-to-date
```

推送的文件比较大，Git 可能会失败。尝试增加 Git 的缓冲区大小，通过以下命令：

```bash
git config http.postBuffer 524288000
```

提交成功
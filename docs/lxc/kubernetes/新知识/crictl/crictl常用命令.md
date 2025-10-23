

容器查看

```BASH
crictl ps   -a 
```

查看容器的映射目录都有哪些

```bash
crictl inspect --template '{{json .status.mounts}}' 容器ID | jq 
crictl inspect --template '{{json .status.mounts}}' 容器ID | jq | grep -i log -C 10 #查找日志对应的目录
```



在 `crictl` 中，你可以直接用容器的 **ID** 查看日志。根据你提供的容器 ID `84cbea5781115`，命令如下：

```
crictl logs 84cbea5781115
```

### 常用选项：

- `-f`：跟随日志输出（类似 `tail -f`）

  ```
  crictl logs -f 84cbea5781115
  ```

- `--tail n`：只看最近 n 行日志

  ```
  crictl logs --tail 100 84cbea5781115
  ```

- `--timestamps`：显示时间戳

  ```
  crictl logs --timestamps 84cbea5781115
  ```

> 注意：如果容器已经 **Exited**，`crictl logs` 仍然可以查看退出前的日志。
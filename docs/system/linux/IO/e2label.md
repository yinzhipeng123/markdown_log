# e2label命令

e2label将显示或更改位于设备上的ext2、ext3或ext4文件系统上的文件系统标签。
如果可选参数new label不存在，e2label将只显示当前文件系统标签。
如果存在可选参数new label，则e2label将文件系统标签设置为new label。Ext2文件系统标签的长度最多可以是16个字符；如果新标签超过16个字符，e2label将截断它并打印一条警告消息。



查看设备label

```bash
#e2label /dev/sda1
disk1
```

设置设备label

```bash
e2label /dev/sda1 mydisk
```



[e2label 命令，Linux e2label 命令详解：设置第二扩展文件系统的卷标 - Linux 命令搜索引擎 (wangchujiang.com)](https://wangchujiang.com/linux-command/c/e2label.html)


下载命令

[Support Documents and Downloads (broadcom.com)](https://www.broadcom.com/support/download-search?pg=Legacy+Products&pf=Legacy+Products&pn=MegaRAID+SAS+9260-4i&pa=&po=&dk=&pl=&l=false)

查找MegaCLI 

[MegaCLI 5.5 P2 (broadcom.com)](https://docs.broadcom.com/docs/12351587)

安装，解压后安装rpm包。

```
[root@VM-0-16-centos MegaCli]# pwd
/opt/MegaRAID/MegaCli
[root@VM-0-16-centos MegaCli]# ls
MegaCli64
```



`MegaCli` 是一种用于管理和配置LSI Logic Corporation的MegaRAID控制器的命令行界面（CLI）工具。这个工具非常强大，可以用来获取控制器和磁盘阵列的状态信息、创建和管理RAID阵列、管理单个磁盘驱动器等等。

这里是一些基本的`MegaCli` 命令示例，可用于进行常见的管理任务：

*1.查看适配器信息**:

```sh
MegaCli64 -AdpAllInfo -aALL
```

**2.查看逻辑磁盘信息**:

```sh
MegaCli64 -LDInfo -Lall -aALL
```

**3.查看物理磁盘信息**:

```sh
MegaCli64 -PDList -aALL
```

**4.查看事件日志**:

```sh
MegaCli64 -AdpEventLog -GetEvents -f events.log -aALL
```

**5.电池备份状态**:

```sh
MegaCli64 -AdpBbuCmd -aALL
```

在使用`MegaCli64` 命令时，请务必谨慎，因为错误的命令可能会导致数据丢失。在进行任何修改之前，建议先备份重要数据。

请记住，具体命令的参数和选项可能会根据您的具体硬件配置和MegaCli版本而有所不同，因此在使用之前请查看相关的帮助文档或官方指南。通常，您可以通过在命令后添加`-help`选项来获取特定命令的帮助信息，例如：

```sh
MegaCli64 -help
```
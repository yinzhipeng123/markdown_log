# lsblk命令

lsblk列出有关所有或指定的块设备的信息。lsblk命令读取sysfs文件系统以收集信息。
默认情况下，该命令以树状格式打印所有块设备（RAM磁盘除外）。使用lsblk--help获取所有可用列的列表。
默认输出以及--topology和--fs等选项的默认输出可能会发生更改，因此应尽可能避免在脚本中使用默认输出。在需要稳定输出的环境中，始终通过--output列显式定义期望的列。

[lsblk 命令，Linux lsblk 命令详解：列出块设备信息 - Linux 命令搜索引擎 (wangchujiang.com)](https://wangchujiang.com/linux-command/c/lsblk.html#!kw=l)

[lsblk(8): block devices - Linux man page (die.net)](https://linux.die.net/man/8/lsblk)



```
# lsblk -a
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sr0     11:0    1 18.8M  0 rom  
vda    253:0    0   50G  0 disk 
└─vda1 253:1    0   50G  0 part /
vdb    253:16   0  800G  0 disk 
# lsblk -f
NAME   FSTYPE  LABEL    UUID                                 MOUNTPOINT
sr0    iso9660 config-2 2023-03-22-17-15-00-00               
vda                                                          
└─vda1 ext4             2c04c946-7fee-41c2-a99f-f53e2532e4f7 /
vdb                                                          
# lsblk -t
NAME   ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC ROTA SCHED       RQ-SIZE   RA WSAME
sr0            0   2048      0    2048    2048    1 deadline        128  128    0B
vda            0    512      0     512     512    1 mq-deadline     256 4096    0B
└─vda1         0    512      0     512     512    1 mq-deadline     256 4096    0B
vdb            0    512      0     512     512    1 mq-deadline     256 4096    0B
```


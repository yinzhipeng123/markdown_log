# findmnt命令

findmnt将列出所有安装的文件系统或搜索文件系统。findmnt命令可以在/etc/fstab、/etc/fstab.d、/etc/mtab或/proc/self/mountinfo中进行搜索。如果没有给出设备或装入点，则会显示所有文件系统。

[findmnt(8): find filesystem - Linux man page (die.net)](https://linux.die.net/man/8/findmnt)

[系统运维|findmnt 命令的八个应用实例 (linux.cn)](https://linux.cn/article-3135-1.html)

常用

**-s， --fstab**

在 /*etc/fstab* 和 */etc/fstab.d* 中搜索。输出采用列表格式（请参阅 --list）。

**-m， --mtab**

在 /*etc/mtab* 中搜索。输出采用列表格式（请参阅 --list）。

**-k， --kernel**

在 /*proc/self/mountinfo* 中搜索。输出采用树状格式。这是默认值。


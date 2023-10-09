# StorCLI命令



下载

[超级突袭 9560-8i (broadcom.com)](https://www.broadcom.com/products/storage/raid-controllers/megaraid-9560-8i)

安装

```bash
安装包解压后
rpm安装包在如下目录：
storcli_rel/Unified_storcli_all_os/Linux
rpm -ivh 安装后
命令在/opt/MegaRAID/storcli目录下

# pwd
/opt/MegaRAID/storcli
# ll
total 7724
-rw-r--r-- 1 root root       0 Oct  8 18:34 install.log
-rwxr--r-- 1 root root 7890144 Nov  2  2022 storcli64
-rw-r--r-- 1 root root     853 Oct  8 18:36 storcli.log


```







```
[root@VM-0-16-centos storcli]# ./storcli64 

      StorCli SAS Customization Utility Ver 007.2310.0000.0000 Nov 02, 2022

    (c)Copyright 2022, Broadcom Inc. All Rights Reserved.


help - lists all the commands with their usage. E.g. storcli help
<command> help - gives details about a particular command. E.g. storcli add help

List of commands:

Commands   Description
-------------------------------------------------------------------
add        Adds/creates a new element to controller like VD,Spare..etc
delete     Deletes an element like VD,Spare
show       Displays information about an element
set        Set a particular value to a property 
get        Get a particular value to a property 
compare    Compares particular value to a property
start      Start background operation
stop       Stop background operation
pause      Pause background operation
resume     Resume background operation
download   Downloads file to given device
expand     expands size of given drive
insert     inserts new drive for missing
transform  downgrades the controller
reset      resets the controller phy
split      splits the logical drive mirror
/cx        Controller specific commands
/ex        Enclosure specific commands
/sx        Slot/PD specific commands
/vx        Virtual drive specific commands
/dx        Disk group specific commands
/fall      Foreign configuration specific commands
/px        Phy specific commands
/lnx       Lane specific commands
/[bbu|cv]  Battery Backup Unit, Cachevault commands
Other aliases : cachecade, freespace, sysinfo

Use a combination of commands to filter the output of help further.
E.g. 'storcli cx show help' displays all the show operations on cx.
Use verbose for detailed description E.g. 'storcli add  verbose help'
Use 'page[=x]' as the last option in all the commands to set the page break.
X=lines per page. E.g. 'storcli help page=10'
Use J as the last option to print the command output in JSON format
Command options must be entered in the same order as displayed in the help of 
the respective commands.
Use 'nolog' option to disable debug logging. E.g. 'storcli show nolog'

```


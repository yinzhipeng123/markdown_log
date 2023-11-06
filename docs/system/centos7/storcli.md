# StorCLI命令



下载

[超级突袭 9560-8i (broadcom.com)](https://www.broadcom.com/products/storage/raid-controllers/megaraid-9560-8i)

点击页面上 storcli

[Latest StorCLI](https://docs.broadcom.com/docs/1232743397)

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





### 帮助

```bash
[root@VM-0-16-centos storcli]# ./storcli64 

      StorCli SAS定制实用程序版本007.2310.0000.0000 2022年11月2日

    （c） 版权所有2022，Broadcom股份有限公司保留所有权利。


help - 列出了所有命令及其用法。 例如： storcli help
<命令> help - 提供有关特定命令的详细信息. 例如： storcli add help

命令列表：

命令   描述
-------------------------------------------------------------------
add        向控制器添加/创建一个新元素，如VD、Spare。。等
delete     删除VD、Spare等元素
show       显示有关元信息
set        为属性设置特定值
get        为属性获取特定值
compare    将特定值与属性进行比较
start      启动后台操作
stop       停止后台操作
pause      暂停后台操作
resume     恢复后台操作
download   将文件下载到给定设备
expand     扩展给定驱动器的大小
insert     插入丢失的新驱动器
transform  降低控制器的级别
reset      重置控制器phy
split      拆分逻辑驱动器镜像
/cx        控制器特定命令
/ex        机柜特定命令
/sx        插槽/PD特定命令
/vx        虚拟驱动器特定命令
/dx        磁盘组特定命令
/fall      外部配置特定命令
/px        Phy特定命令
/lnx       Lane特定命令
/[bbu|cv]  备用电池单元，Cachevault命令
Other aliases : cachecade, freespace, sysinfo

使用命令组合可以进一步筛选帮助的输出。
例如. 'storcli cx show help' 显示cx上的所有显示操作。
使用verbose进行详细描述 例如. 'storcli add  verbose help'
使用“page[=x]”作为所有命令中设置分页符的最后一个选项。
X=每页行数。 例如. 'storcli help page=10'
使用J作为最后一个选项，以JSON格式打印命令输出
命令选项的输入顺序必须与相应命令帮助中显示的顺序相同。
使用“nolog”选项禁用调试日志记录. 例如. 'storcli show nolog'

```



#### 显示raid信息

例如：

```bash
#storcli64 /c0 show
Controller = 0   #几号控制器
Status = Success  #状态成功
Description = None  #描述无

Product Name = AVAGO MegaRAID SAS 9361-8i  #产品型号
Serial Number = SK01467706  #sn号
SAS Address =  500605b01018f980 #SAS地址
Mfg. Date = 04/02/20  #制造日期
System Time = 10/13/2023 11:24:04 #系统时间
Controller Time = 10/13/2023 11:21:19 #控制器时间
FW Package Build = 24.21.0-0132 #FW包构建号
BIOS Version = 6.36.00.3_4.19.08.00_0x06180203  #bios版本
FW Version = 4.680.00-8527 #FW版本
Driver Name = megaraid_sas # 驱动名字
Driver Version = 07.710.06.00 # 驱动版本
Controller Bus Type = N/A # 控制器总线类型
PCI Slot = N/A # 插槽
PCI Bus Number = 24 # PCI总线号
PCI Device Number = 0 # PCI设备编号
PCI Function Number = 0 # PCI功能编号
Drive Groups = 2 # 驱动器组

TOPOLOGY : # 拓扑结构
========

--------------------------------------------------------------------------
DG Arr Row EID:Slot DID Type  State BT       Size PDC  PI SED DS3  FSpace 
--------------------------------------------------------------------------
 0 -   -   -        -   RAID5 Optl  N    1.635 TB dsbl N  N   dflt N      
 0 0   -   -        -   RAID5 Optl  N    1.635 TB dsbl N  N   dflt N      
 0 0   0   8:0      20  DRIVE Onln  N  558.406 GB dsbl N  N   dflt -      
 0 0   1   8:1      11  DRIVE Onln  N  558.406 GB dsbl N  N   dflt -      
 0 0   2   8:2      15  DRIVE Onln  N  558.406 GB dsbl N  N   dflt -      
 0 0   3   8:3      19  DRIVE Onln  N  558.406 GB dsbl N  N   dflt -      
 1 -   -   -        -   RAID5 Optl  N    3.816 TB dsbl N  N   dflt N      
 1 0   -   -        -   RAID5 Optl  N    3.816 TB dsbl N  N   dflt N      
 1 0   0   8:4      12  DRIVE Onln  N  558.406 GB dsbl N  N   dflt -      
 1 0   1   8:5      17  DRIVE Onln  N  558.406 GB dsbl N  N   dflt -      
 1 0   2   8:6      16  DRIVE Onln  N  558.406 GB dsbl N  N   dflt -      
 1 0   3   8:7      9   DRIVE Onln  N  558.406 GB dsbl N  N   dflt -      
 1 0   4   8:8      10  DRIVE Onln  N  558.406 GB dsbl N  N   dflt -      
 1 0   5   8:9      14  DRIVE Onln  N  558.406 GB dsbl N  N   dflt -      
 1 0   6   8:10     13  DRIVE Onln  N  558.406 GB dsbl N  N   dflt -      
 1 0   7   8:11     18  DRIVE Onln  N  558.406 GB dsbl N  N   dflt -      
--------------------------------------------------------------------------

DG=Disk Group Index|Arr=Array Index|Row=Row Index|EID=Enclosure Device ID
DID=Device ID|Type=Drive Type|Onln=Online|Rbld=Rebuild|Dgrd=Degraded
Pdgd=Partially degraded|Offln=Offline|BT=Background Task Active
PDC=PD Cache|PI=Protection Info|SED=Self Encrypting Drive|Frgn=Foreign
DS3=Dimmer Switch 3|dflt=Default|Msng=Missing|FSpace=Free Space Present

###################################翻译#####################################

--------------------------------------------------------------------------
磁盘组索引 阵列索引 行索引 设备柜设备ID:插槽 设备ID 驱动器类型  状态 后台任务活动   大小 保护数据缓存  保护信息 自加密硬盘 调光开关  空闲空间存在 
--------------------------------------------------------------------------
 0 -   -   -        -   RAID5 最佳  N    1.635 TB 禁用 N  N   默认 N      
 0 0   -   -        -   RAID5 最佳  N    1.635 TB 禁用 N  N   默认 N      
 0 0   0   8:0      20  驱动器 在线  N  558.406 GB 禁用 N  N   默认 -      
 0 0   1   8:1      11  驱动器 在线  N  558.406 GB 禁用 N  N   默认 -      
 0 0   2   8:2      15  驱动器 在线  N  558.406 GB 禁用 N  N   默认 -      
 0 0   3   8:3      19  驱动器 在线  N  558.406 GB 禁用 N  N   默认 -      
 1 -   -   -        -   RAID5 最佳  N    3.816 TB 禁用 N  N   默认 N      
 1 0   -   -        -   RAID5 最佳  N    3.816 TB 禁用 N  N   默认 N      
 1 0   0   8:4      12  驱动器 在线  N  558.406 GB 禁用 N  N   默认 -      
 1 0   1   8:5      17  驱动器 在线  N  558.406 GB 禁用 N  N   默认 -      
 1 0   2   8:6      16  驱动器 在线  N  558.406 GB 禁用 N  N   默认 -      
 1 0   3   8:7      9   驱动器 在线  N  558.406 GB 禁用 N  N   默认 -      
 1 0   4   8:8      10  驱动器 在线  N  558.406 GB 禁用 N  N   默认 -      
 1 0   5   8:9      14  驱动器 在线  N  558.406 GB 禁用 N  N   默认 -      
 1 0   6   8:10     13  驱动器 在线  N  558.406 GB 禁用 N  N   默认 -      
 1 0   7   8:11     18  驱动器 在线  N  558.406 GB 禁用 N  N   默认 -      
--------------------------------------------------------------------------

DG = 磁盘组索引
Arr = 阵列索引
Row = 行索引
EID = 设备柜设备ID
DID = 设备ID
Type = 驱动器类型
Onln = 在线
Rbld = 重建
Dgrd = 降级
Pdgd = 部分降级
Offln = 离线
BT = 后台任务活动
PDC = 保护数据缓存
PI = 保护信息
SED = 自加密硬盘
Frgn = 外部
DS3 = 调光开关 3
dflt = 默认
Msng = 缺失
FSpace = 空闲空间存在

###################################翻译#####################################

Virtual Drives = 2

VD LIST : # VD列表
=======

------------------------------------------------------------
DG/VD TYPE  State Access Consist Cache sCC     Size Name    
------------------------------------------------------------
0/0   RAID5 Optl  RW     Yes     RWBD  -   1.635 TB RaidGP1 
1/1   RAID5 Optl  RW     Yes     RWBD  -   3.816 TB RaidGP2 
------------------------------------------------------------

Cac=CacheCade|Rec=Recovery|OfLn=OffLine|Pdgd=Partially Degraded|dgrd=Degraded
Optl=Optimal|RO=Read Only|RW=Read Write|B=Blocked|Consist=Consistent|
Ra=Read Ahead Adaptive|R=Read Ahead Always|NR=No Read Ahead|WB=WriteBack|
AWB=Always WriteBack|WT=WriteThrough|C=Cached IO|D=Direct IO|sCC=Scheduled
Check Consistency
###################################翻译#####################################
------------------------------------------------------------
磁盘组/虚拟磁盘类型  状态  访问  一致性  缓存  计划检查一致性  大小  名称    
------------------------------------------------------------
0/0   RAID5 最佳  读写  是   读写缓存  -   1.635 TB RaidGP1 
1/1   RAID5 最佳  读写  是   读写缓存  -   3.816 TB RaidGP2 
------------------------------------------------------------
Cac = 缓存
Rec = 恢复
OfLn = 离线
Pdgd = 部分降级
dgrd = 降级
Optl = 最佳
RO = 只读
RW = 读写
B = 阻止
Consist = 一致
Ra = 自适应预读
R = 总是预读
NR = 不预读
WB = 写回
AWB = 总是写回
WT = 直写
C = 缓存IO
D = 直接IO
sCC = 计划检查一致性
###################################翻译#####################################


Physical Drives = 12

PD LIST :
=======

-------------------------------------------------------------------------
EID:Slt DID State DG       Size Intf Med SED PI SeSz Model            Sp 
-------------------------------------------------------------------------
8:0      20 Onln   0 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:1      11 Onln   0 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:2      15 Onln   0 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:3      19 Onln   0 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:4      12 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:5      17 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:6      16 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:7       9 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:8      10 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:9      14 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:10     13 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:11     18 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
-------------------------------------------------------------------------

EID-Enclosure Device ID|Slt-Slot No.|DID-Device ID|DG-DriveGroup
DHS-Dedicated Hot Spare|UGood-Unconfigured Good|GHS-Global Hotspare
UBad-Unconfigured Bad|Onln-Online|Offln-Offline|Intf-Interface
Med-Media Type|SED-Self Encryptive Drive|PI-Protection Info
SeSz-Sector Size|Sp-Spun|U-Up|D-Down|T-Transition|F-Foreign

###################################翻译#####################################
-------------------------------------------------------------------------
EID: 设备柜标识号 | Slt: 插槽编号 | DID: 设备标识号 | State: 状态 | DG: 驱动组
Size: 大小 | Intf: 接口 | Med: 媒体类型 | SED: 自加密驱动 | PI: 保护信息 | SeSz: 扇区大小 Model: 型号 | Sp: 磁盘驱动器旋转状态
-------------------------------------------------------------------------
8:0      20 Onln   0 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:1      11 Onln   0 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:2      15 Onln   0 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:3      19 Onln   0 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:4      12 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:5      17 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:6      16 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:7       9 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:8      10 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:9      14 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:10     13 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
8:11     18 Onln   1 558.406 GB SAS  HDD N   N  512B ST600MM0009      U  
-------------------------------------------------------------------------

- EID: 设备柜标识号
- Slt: 插槽编号
- DID: 设备标识号
- DG: 驱动组
- DHS: 专用热备
- UGood: 未配置好
- GHS: 全局热备
- UBad: 未配置不佳
- Onln: 在线
- Offln: 离线
- Intf: 接口
- Med: 媒体类型
- SED: 自加密驱动
- PI: 保护信息
- SeSz: 扇区大小
- Sp: 旋转中
- U: 启动
- D: 停用
- T: 状态转换
- F: 外部的

###################################翻译#####################################
BBU_Info :
========

-----------------------------------------------------------------------
Model  State   RetentionTime Temp Mode MfgDate    Next Learn           
-----------------------------------------------------------------------
CVPM02 Optimal 0 hour(s)     26C  0    2019/11/02 2023/10/17  09:23:25 
-----------------------------------------------------------------------

###################################翻译#####################################
BBU信息：
========
-----------------------------------------------------------------------
型号  状态     保持时间 温度 模式 制造日期    下次学习
-----------------------------------------------------------------------
CVPM02 正常    0 小时    26摄氏度 0   2019/11/02  2023/10/17  09:23:25
-----------------------------------------------------------------------

"保持时间"（RetentionTime）通常是指电池备份单元（BBU）能够在断电或故障情况下保持其充电状态，以继续提供电源支持的时间。它表示在断电情况下，BBU可以保持充电状态并继续供电的时间长度。在提供电源支持的情况下，数据可以被保存或完成写入磁盘，以避免数据丢失或损坏。

"保持时间"的值是 "0 小时"，这表示电池备份单元目前没有保持时间，即它可能无法在断电情况下提供电源支持。通常情况下，BBU应该具有非零的保持时间以提供数据保护。

"模式"（Mode）是描述电池备份单元（BBU）的工作模式的信息。不同的工作模式可能会影响电池的行为和性能。

"模式"的值是 "0"，通常情况下，不同的数字代表不同的工作模式。具体的模式含义可能因制造商和设备而异，通常模式 0 表示正常运行或优化模式。不同的模式可以对电池充电、放电和备份操作产生影响，因此了解电池备份单元的模式对于维护和监控电源支持非常重要。
###################################翻译#####################################
```



上文中提到的例子，在带外系统也可以查询到：

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/Xnip2023-10-13_14-17-08.jpg)



![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/Xnip2023-10-13_14-17-21.jpg)



![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/Xnip2023-10-13_14-17-39.jpg)



![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/Xnip2023-10-13_14-18-44.jpg)



要使用`storcli64`命令来查看所有磁盘的状态，你可以使用以下命令：

```
storcli64 /c0 /eall /sall show
```

这里的参数解释如下：

- `storcli64`：这是命令行工具的名称。
- `/c0`：表示控制器编号，0是第一个控制器。如果你有多个控制器，可能需要改变这个数字。
- `/eall`：表示所有的机箱（enclosure），如果你有多个机箱，这会显示所有机箱的信息。
- `/sall`：表示所有的槽位（slot），即显示所有磁盘槽位的信息。
- `show`：这个参数指示storcli显示信息。

运行此命令后，你将获得一个包含所有磁盘状态的列表，其中包括每个磁盘的状态、大小、类型等信息。


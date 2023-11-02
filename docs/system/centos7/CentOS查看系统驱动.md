# CentOS查看系统驱动



要查看Linux系统中预装的驱动程序列表，你可以使用几种不同的方法。这里有两种常用方法：

#### **1.查看加载的模块：**

使用 `lsmod` 命令可以列出当前加载的内核模块（包括驱动程序）。这会显示当前会话中实际使用的模块。打开终端，然后输入：

```bash
lsmod
```
这个命令会列出所有当前加载的内核模块以及它们的依赖关系和使用状态。

例如：

```bash
[root@VM-0-16-centos ~]# lsmod | nl
     1  Module                  Size  Used by
     2  binfmt_misc            17468  1 
     3  tcp_diag               12591  0 
     4  inet_diag              18949  1 tcp_diag
     5  iptable_filter         12810  0 
     6  nls_utf8               12557  0 
     7  isofs                  43940  0 
     8  iosf_mbi               15582  0 
     9  crc32_pclmul           13133  0 
    10  ghash_clmulni_intel    13273  0 
    11  ppdev                  17671  0 
    12  aesni_intel           189456  0 
    13  lrw                    13286  1 aesni_intel
    14  gf128mul               15139  1 lrw
    15  glue_helper            13990  1 aesni_intel
    16  ablk_helper            13597  1 aesni_intel
    17  cryptd                 21190  3 ghash_clmulni_intel,aesni_intel,ablk_helper
    18  joydev                 17389  0 
    19  sg                     40719  0 
    20  virtio_balloon         18015  0 
    21  pcspkr                 12718  0 
    22  parport_pc             28205  0 
    23  i2c_piix4              22401  0 
    24  parport                46395  2 ppdev,parport_pc
    25  ip_tables              27126  1 iptable_filter
    26  ext4                  592325  1 
    27  mbcache                14958  1 ext4
    28  jbd2                  107486  1 ext4
    29  sr_mod                 22416  0 
    30  cdrom                  46696  1 sr_mod
    31  ata_generic            12923  0 
    32  pata_acpi              13053  0 
    33  virtio_net             27994  0 
    34  net_failover           18147  1 virtio_net
    35  virtio_blk             18472  2 
    36  failover               13374  1 net_failover
    37  cirrus                 24171  1 
    38  drm_kms_helper        186531  1 cirrus
    39  syscopyarea            12529  1 drm_kms_helper
    40  sysfillrect            12701  1 drm_kms_helper
    41  sysimgblt              12640  1 drm_kms_helper
    42  fb_sys_fops            12703  1 drm_kms_helper
    43  ttm                   100769  1 cirrus
    44  crct10dif_pclmul       14307  0 
    45  crct10dif_common       12595  1 crct10dif_pclmul
    46  crc32c_intel           22094  0 
    47  ata_piix               35052  0 
    48  drm                   468454  4 ttm,drm_kms_helper,cirrus
    49  serio_raw              13434  0 
    50  libata                247190  3 pata_acpi,ata_generic,ata_piix
    51  virtio_pci             22985  0 
    52  virtio_ring            22991  4 virtio_blk,virtio_net,virtio_pci,virtio_balloon
    53  virtio                 14959  4 virtio_blk,virtio_net,virtio_pci,virtio_balloon
    54  drm_panel_orientation_quirks    17180  1 drm
    55  floppy                 73520  0 
```

这个命令`lsmod`展示的是当前系统上加载的内核模块（驱动程序）。每一行代表一个模块，分别列出了模块的名称、大小（以字节为单位）以及使用它的实例数量（如果有其他模块依赖于此模块，或者该模块正在被系统或设备使用，这个数字就会大于0）。

例如，第一行显示了`binfmt_misc`模块，大小为17468字节，被一个实例使用。而`tcp_diag`模块，大小为12591字节，目前没有被使用（Used by为0）。如果被使用，那么使用方将会后面显示

这个列表基本上是你的系统当前使用的所有硬件和文件系统相关的驱动程序的概览。通过这个列表，你可以了解哪些驱动程序当前在系统上活跃，以及他们的使用情况。

依次解释这55行`lsmod`命令的输出结果：

1. **binfmt_misc** - 支持可执行文件的多种格式。
2. **tcp_diag** - 用于TCP网络诊断。
3. **inet_diag** - 网络诊断框架，由tcp_diag使用。
4. **iptable_filter** - Netfilter的IPv4过滤规则表。
5. **nls_utf8** - 支持UTF-8编码。
6. **isofs** - ISO 9660文件系统支持，用于读取CD/DVD。
7. **iosf_mbi** - 用于Intel平台的消息总线接口驱动。
8. **crc32_pclmul** - 使用PCLMULQDQ指令的CRC32校验。
9. **ghash_clmulni_intel** - AES-GCM的Intel硬件加速。
10. **ppdev** - 并口设备驱动。
11. **aesni_intel** - Intel AES-NI指令集支持。
12. **lrw** - LRW（线性相关-乘法）块密码模式。
13. **gf128mul** - GF(2^128)域的乘法支持。
14. **glue_helper** - 用于加密算法的帮助函数。
15. **ablk_helper** - 异步块密码帮助函数。
16. **cryptd** - 加密算法的软件实现。
17. **joydev** - 游戏手柄设备驱动。
18. **sg** - SCSI通用（sg）驱动。
19. **virtio_balloon** - Virtio内存气球驱动，用于调整虚拟机的内存分配。
20. **pcspkr** - PC扬声器驱动。
21. **parport_pc** - PC并口驱动。
22. **i2c_piix4** - AMD/Intel I2C总线驱动。
23. **parport** - 并行端口（printer port）设备支持。
24. **ip_tables** - IPv4防火墙（Netfilter）支持。
25. **ext4** - EXT4文件系统驱动。
26. **mbcache** - EXT文件系统的元数据缓存。
27. **jbd2** - EXT文件系统的日志块设备。
28. **sr_mod** - SCSI CD-ROM支持。
29. **cdrom** - 通用CD-ROM驱动。
30. **ata_generic** - 通用ATA驱动。
31. **pata_acpi** - 支持通过ACPI配置PATA接口。
32. **virtio_net** - Virtio网络设备驱动。
33. **net_failover** - 网络故障转移支持。
34. **virtio_blk** - Virtio块设备驱动。
35. **failover** - 通用网络故障转移模块。
36. **cirrus** - Cirrus逻辑GPU驱动。
37. **drm_kms_helper** - DRM（直接渲染管理器）内核模式设置帮助函数。
38. **syscopyarea** - 内核帧缓冲复制区域支持。
39. **sysfillrect** - 内核帧缓冲填充矩形支持。
40. **sysimgblt** - 内核帧缓冲图像位块传输支持。
41. **fb_sys_fops** - 内核帧缓冲系统文件操作支持。
42. **ttm** - 内核的转换和缓存管理器（TTM）。
43. **crct10dif_pclmul** - 使用PCLMULQDQ指令的CRC-T10DIF校验。
44. **crct10dif_common** - CRC-T10DIF校验通用函数。
45. **crc32c_intel** - 使用Intel硬件加速的CRC32c校验。
46. **ata_piix** - Intel PIIX/ICH ATA控制器驱动。
47. **drm** - 直接渲染管理器（DRM）支持。
48. **serio_raw** - 原始串行I/O接口驱动。
49. **libata** - 通用ATA/ATAPI驱动库。
50. **virtio_pci** - Virtio PCI总线驱动。
51. **virtio_ring** - Virtio环缓冲区管理。
52. **virtio** - Virtio核心框架。
53. **drm_panel_orientation_quirks** - 用于特定面板的DRM屏幕方向问题修正。
54. **floppy** - 软盘驱动。







#### **2.查看可用模块：**



要查看系统可用的所有内核模块（不仅仅是当前加载的），你可以在 `/lib/modules/$(uname -r)` 目录下查找。这里的 `$(uname -r)` 会被替换为你当前运行的内核版本。你可以使用如下命令：

```bash
ls /lib/modules/$(uname -r)/kernel/drivers/
```
这个命令将显示当前系统版本所有可用的驱动程序模块，组织在不同的子目录下，如 `net`（网络）、`scsi`（存储控制器）、`video`（视频设备）等。

请注意，这些方法展示的是系统中可用或者已加载的驱动程序，但并不意味着所有这些驱动都是在内核编译时预装的。一些驱动可能是在后续过程中添加的，尤其是在使用定制或者第三方内核时。

以我的腾讯云为例：

```
[root@VM-0-16-centos ~]# ls /lib/modules/$(uname -r)
build   modules.alias      modules.builtin      modules.dep.bin  modules.modesetting  modules.softdep      source   weak-updates
extra   modules.alias.bin  modules.builtin.bin  modules.devname  modules.networking   modules.symbols      updates
kernel  modules.block      modules.dep          modules.drm      modules.order        modules.symbols.bin  vdso
```

以下是每个文件或目录的说明：

1. **build**: 通常是一个符号链接，指向内核源代码的位置，用于编译内核模块。
2. **extra**: 用于存放非标准或第三方的内核模块。
3. **kernel**: 包含了大量的子目录，每个子目录都包含特定类型的内核模块（如驱动程序）。
4. **modules.alias**: 包含模块别名的映射，有助于`modprobe`命令识别请求加载哪个模块。
5. **modules.alias.bin**: 是`modules.alias`的二进制版本，加快处理速度。
6. **modules.block**: 可能包含与块设备（如硬盘驱动）相关的模块信息。
7. **modules.dep**: 包含模块间依赖关系的信息。
8. **modules.dep.bin**: 是`modules.dep`的二进制版本。
9. **modules.devname**: 包含模块和设备名称之间的映射。
10. **modules.drm**: 与直接渲染管理器（DRM）相关的模块信息。
11. **modules.modesetting**: 与图形模式设置相关的模块信息。
12. **modules.networking**: 与网络功能相关的模块信息。
13. **modules.order**: 列出了模块的加载顺序。
14. **modules.softdep**: 描述了模块间软依赖关系。
15. **modules.symbols**: 包含模块导出符号的信息。
16. **modules.symbols.bin**: 是`modules.symbols`的二进制版本。
17. **source**: 通常是一个符号链接，指向内核源代码的位置。
18. **updates**: 用于存放内核模块的更新或修补程序。
19. **vdso**: 与虚拟动态共享对象（vDSO）相关的信息。
20. **weak-updates**: 用于存放弱更新模块，这些模块可能会覆盖原始模块。
21. **modules.builtin**: 列出了内核内置的模块。
22. **modules.builtin.bin**: 是`modules.builtin`的二进制版本。



#### 某案例：

某机器使用LSI HBA直通卡，HBA LSI 9300-8i卡，插上后，系统无法启动，某大神通过/etc/modprobe.d/blacklist.conf添加一个配置

```
blacklist mpt3sas
```

禁用了该卡的驱动，系统成功启动。因为客户不使用该卡，但是希望在带外上看到。



#### 课外知识：

```
HBA LSI 9300-8i 是一款由LSI公司（现为Broadcom的一部分）生产的Host Bus Adapter（主机总线适配器）卡。这款适配器卡通常用于连接服务器与外部存储系统，如硬盘阵列或磁带库。它支持SAS（Serial Attached SCSI）和SATA（Serial ATA）接口，使其能够兼容多种存储设备。

LSI 9300-8i 的主要特点包括：

1.端口数量和速度：此卡提供8个SAS/SATA端口，每个端口的数据传输速度高达12Gb/s，适用于高性能存储需求。

2.直通设计：作为一款HBA卡，9300-8i 通常以直通模式（pass-through mode）工作，这意味着它将存储设备直接呈现给操作系统，而不进行RAID或其他额外处理。

3.广泛兼容性：支持多种操作系统和硬件平台，适用于各种企业级和数据中心应用场景。

4.高可靠性和性能：提供稳定和高速的数据传输能力，非常适合要求高可靠性和性能的应用。

LSI 9300-8i 适配器卡因其优秀的性能和可靠性，被广泛应用于需要大量数据存储和快速数据访问的环境中。
```

经过查询，这款直通卡在Linux的驱动叫mpt3sas，mpt3sas 是一个用于Linux系统的内核驱动程序，主要用来支持LSI（现在是Broadcom的一部分）生产的SAS 3.0（Serial Attached SCSI 第三代）控制器。这些控制器包括但不限于LSI SAS 9300系列卡，例如前文提到的LSI 9300-8i HBA卡。

这个驱动程序使得Linux操作系统能够识别和有效地与安装有LSI SAS控制器的硬件通信，从而实现对连接到这些控制器的存储设备（如硬盘、固态硬盘或磁带驱动器）的管理和访问。

简而言之，mpt3sas 是 Linux 系统下用来确保服务器或计算机可以正确识别并使用基于 LSI SAS 3.0 技术的存储控制器的关键软件组件。

不是所有LSI的驱动都叫mpt3sas。mpt3sas 是用于特定LSI SAS控制器的Linux驱动程序，尤其是支持SAS 3.0（12Gb/s）规格的控制器。然而，LSI生产了多种不同类型和代的SAS控制器，这些控制器可能需要不同的驱动程序。

例如，针对较早代的SAS控制器（如SAS 2.0），可能使用的是mpt2sas驱动。还有针对特定型号和功能（比如RAID功能）的控制器，可能会有专用的驱动程序。

因此，选择驱动程序时需要基于具体的硬件型号和操作系统来确定适合的驱动程序。通常，可以在硬件制造商的官方网站或与您的操作系统相关的软件库中找到正确的驱动程序。

在Linux系统中，禁用特定的内核模块（如mpt3sas驱动）可以通过几种方式实现。下面是几种常见的方法：

**1.临时禁用（单次启动）**:
在Linux启动时，可以通过修改内核启动参数来临时禁用模块。在启动加载器（如GRUB）的启动菜单中，选择要启动的Linux内核，然后编辑启动参数，添加`modprobe.blacklist=mpt3sas`。这样，在这次启动过程中，mpt3sas模块将不会被加载。

**2.永久禁用**:
要永久禁用mpt3sas模块，可以在`/etc/modprobe.d/`目录下创建一个配置文件（如`blacklist.conf`），并添加以下内容：

```
blacklist mpt3sas
```
保存文件后，这个模块在未来的启动中将不会被自动加载。

**3.通过内核参数永久禁用**:

1. 对于基于Red Hat的系统，如CentOS，步骤类似，但有一些细微差别。以下是在CentOS系统上通过内核参数永久禁用驱动的步骤：

   1. 编辑GRUB配置文件。这通常是`/etc/default/grub`。你可以使用文本编辑器打开它，例如使用命令：
      ```bash
      sudo vi /etc/default/grub
      ```

   2. 找到`GRUB_CMDLINE_LINUX`这一行。它看起来可能像这样：
      ```bash
      GRUB_CMDLINE_LINUX="crashkernel=auto rhgb quiet"
      ```

   3. 添加`modprobe.blacklist=mpt3sas`到该行的末尾，保持其他参数不变。修改后的行可能看起来像这样：
      ```bash
      GRUB_CMDLINE_LINUX="crashkernel=auto rhgb quiet modprobe.blacklist=mpt3sas"
      ```

   4. 保存并关闭文件。

   5. 由于您更改了GRUB配置，需要重新生成GRUB配置文件。在CentOS上，您可以使用以下命令：
      ```bash
      sudo grub2-mkconfig -o /boot/grub2/grub.cfg
      ```
      对于使用UEFI启动的系统，路径可能不同，可能需要使用：
      ```bash
      sudo grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg
      ```

      `grub2-mkconfig`是一个用于生成GRUB2（GRand Unified Bootloader version 2）的配置文件的工具。GRUB是Linux和其他操作系统用来管理引导过程的一种引导加载器。

      在大多数基于Linux的操作系统中，`grub-mkconfig`命令会生成一个名为`grub.cfg`的配置文件，通常位于`/boot/grub/`或`/boot/grub2/`目录下。这个配置文件包含了启动菜单选项、内核参数、引导的操作系统列表等信息。

      当您安装新的内核或者更改引导相关的设置时，通常需要重新生成这个配置文件，以确保引导加载器能够识别和加载新的更改。`grub2-mkconfig`命令通常会自动检测系统中安装的所有内核和操作系统，并创建相应的引导菜单项。

      **主要功能**

      ​	 **检测操作系统和内核**：自动搜索并添加系统中所有可用的Linux内核以及其他操作系统（如Windows）的引导项。
      ​	 **生成引导菜单**：根据检测到的操作系统和内核，以及`/etc/default/grub`和`/etc/grub.d/`中的配置和脚本，生成一个详细的引导菜单。
      ​	 **支持自定义**：用户可以通过编辑`/etc/default/grub`文件或在`/etc/grub.d/`目录下添加自定义脚本，来影响生成的配置文件。

      

      使用`grub2-mkconfig`时，通常需要以超级用户权限运行

      在基于Red Hat的系统（如CentOS或Fedora）中，命令：

      ```bash
      sudo grub2-mkconfig -o /boot/grub2/grub.cfg
      ```

      请注意，直接编辑`grub.cfg`文件通常不推荐，因为该文件在运行`grub2-mkconfig`或系统更新时会被覆盖。相反，建议编辑`/etc/default/grub`文件或在`/etc/grub.d/`目录中添加自定义脚本，然后使用`grub-mkconfig`重新生成配置。

   6. 重新启动系统以应用更改。

   请记住，禁用某些驱动可能会影响系统的功能，因此请确保您了解这样做的后果。如果您的系统依赖于mpt3sas驱动来访问存储设备，禁用它可能会导致问题。在执行这些操作之前，请确保您已备份重要数据和系统配置。

在执行这些操作之前，请确保您了解禁用特定驱动的影响，特别是如果您的系统依赖于该驱动来访问重要的硬件设备时。禁用关键的驱动可能会导致系统或某些功能无法正常工作。





在CentOS系统中，`/boot/grub2`和`/boot/grub`这两个目录的区别主要是由于GRUB版本的不同：

**1.GRUB2**（较新版本）：CentOS 7及更高版本默认使用GRUB2作为引导加载器。在这些系统中，GRUB2的配置文件和相关的引导文件通常位于`/boot/grub2`目录。

**2.GRUB Legacy**（较旧版本）：在较旧的CentOS版本中（如CentOS 6及之前），默认使用的是GRUB Legacy。在这些系统中，GRUB Legacy的配置文件和相关引导文件通常位于`/boot/grub`目录。

主要区别：

**1.配置文件位置**：

- 在使用GRUB2的CentOS系统中，主要的配置文件是`/boot/grub2/grub.cfg`。
- 在使用GRUB Legacy的较旧CentOS系统中，主要的配置文件可能是`/boot/grub/menu.lst`或`/boot/grub/grub.conf`。

**2.功能和设计**：

- GRUB2相比于GRUB Legacy拥有更多的功能，更好的模块化设计，以及更易于理解和维护的配置方式。

在实际操作中，如果你使用的是CentOS 7或更高版本，你几乎总是会与`/boot/grub2`目录打交道。而对于旧版CentOS，比如CentOS 6及更早版本，才会涉及到`/boot/grub`目录。

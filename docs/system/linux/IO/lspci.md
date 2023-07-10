# lspci命令

lspci是一个实用程序，用于显示系统中PCI总线及其连接设备的信息。
默认情况下，它显示设备的简短列表。使用下面描述的选项来请求更详细的输出或用于其他程序解析的输出。
如果您要报告PCI设备驱动程序或lspci本身中的错误，请包括“lspci-vvx”或更好的“lspci-vvxxx”的输出（但是，请参阅以下可能的注意事项）。
输出的某些部分，尤其是在高度冗长的模式下，可能只有经验丰富的PCI黑客才能理解。有关字段的确切定义，请参阅PCI规范或header.h和/usr/include/linux/PCI.h include文件。
在许多操作系统上，对PCI配置空间的某些部分的访问仅限于root用户，因此lspci对普通用户可用的功能受到限制。然而，lspci尽可能多地显示可用信息，并用<access denied>文本标记所有其他信息。



[lspci linux 命令 在线中文手册 (51yip.com)](http://linux.51yip.com/search/lspci)

[lspci（8）： 所有 PCI 设备 - Linux 手册页 (die.net)](https://linux.die.net/man/8/lspci)



```bash
[root@VM-0-16-centos ~]# lspci -tv
-[0000:00]-+-00.0  Intel Corporation 440FX - 82441FX PMC [Natoma]
           +-01.0  Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II]
           +-01.1  Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
           +-01.2  Intel Corporation 82371SB PIIX3 USB [Natoma/Triton II]
           +-01.3  Intel Corporation 82371AB/EB/MB PIIX4 ACPI
           +-02.0  Cirrus Logic GD 5446
           +-03.0-[01]--
           +-04.0-[02]--
           +-05.0  Red Hat, Inc. Virtio network device
           +-06.0  Red Hat, Inc. Virtio block device
           +-07.0  Red Hat, Inc. Virtio block device
           \-08.0  Red Hat, Inc. Virtio memory balloon
[root@VM-0-16-centos ~]# lspci |grep -i eth
00:05.0 Ethernet controller: Red Hat, Inc. Virtio network device
[root@VM-0-16-centos ~]# lspci -vvxxx
00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
        Subsystem: Red Hat, Inc. Qemu virtual machine
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
00: 86 80 37 12 03 01 00 00 02 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 ff 00 10 11 11 11 11 11 31
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 0a 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II]
        Subsystem: Red Hat, Inc. Qemu virtual machine
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
00: 86 80 00 70 03 01 00 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 4d 00 03 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0a 0a 0b 0b 00 00 00 00 00 02 00 00 00 00 00 00
70: 80 00 00 00 00 00 0c 0c 02 00 00 00 00 00 00 00
80: 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 08 00 00 00 00 00 00 00 0f 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [ISA Compatibility mode-only controller, supports bus mastering])
        Subsystem: Red Hat, Inc. Qemu virtual machine
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
        Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable)
        Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
        Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable)
        Region 4: I/O ports at e100 [size=16]
        Kernel driver in use: ata_piix
        Kernel modules: ata_piix, pata_acpi, ata_generic
00: 86 80 10 70 07 01 80 02 00 80 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e1 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 30 c0 00 c0 0b 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.2 USB controller: Intel Corporation 82371SB PIIX3 USB [Natoma/Triton II] (rev 01) (prog-if 00 [UHCI])
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at e0c0 [size=32]
        Kernel driver in use: uhci_hcd
00: 86 80 20 70 07 01 00 00 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: c1 e0 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 03)
        Subsystem: Red Hat, Inc. Qemu virtual machine
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 9
        Kernel driver in use: piix4_smbus
        Kernel modules: i2c_piix4
00: 86 80 13 71 03 01 80 02 03 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00
40: 01 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 10
60: 00 00 00 60 00 00 00 08 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 01 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 09 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 VGA compatible controller: Cirrus Logic GD 5446 (prog-if 00 [VGA controller])
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at fea20000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fea00000 [disabled] [size=64K]
        Kernel driver in use: cirrus
        Kernel modules: cirrus
00: 13 10 b8 00 03 01 00 00 00 00 00 03 00 00 00 00
10: 08 00 00 fc 00 00 a2 fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
30: 00 00 a0 fe 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fea21000 (64-bit, non-prefetchable) [size=256]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe800000-fe9fffff
        Prefetchable memory behind bridge: 00000000fe200000-00000000fe3fffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [4c] MSI: Enable- Count=1/1 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [48] Slot ID: 0 slots, First+, chassis 01
        Capabilities: [40] Hot-plug capable
00: 36 1b 01 00 03 01 b0 00 00 00 04 06 00 00 01 00
10: 04 10 a2 fe 00 00 00 00 00 01 01 00 d0 d0 a0 00
20: 80 fe 90 fe 21 fe 31 fe 00 00 00 00 00 00 00 00
30: 00 00 00 00 4c 00 00 00 00 00 00 00 0b 01 02 00
40: 0c 00 00 00 00 00 00 00 04 40 20 01 05 48 80 01
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fea22000 (64-bit, non-prefetchable) [size=256]
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fe600000-fe7fffff
        Prefetchable memory behind bridge: 00000000fe000000-00000000fe1fffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [4c] MSI: Enable- Count=1/1 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [48] Slot ID: 0 slots, First+, chassis 02
        Capabilities: [40] Hot-plug capable
00: 36 1b 01 00 03 01 b0 00 00 00 04 06 00 00 01 00
10: 04 20 a2 fe 00 00 00 00 00 02 02 00 c0 c0 a0 00
20: 60 fe 70 fe 01 fe 11 fe 00 00 00 00 00 00 00 00
30: 00 00 00 00 4c 00 00 00 00 00 00 00 0b 01 02 00
40: 0c 00 00 00 00 00 00 00 04 40 20 02 05 48 80 01
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:05.0 Ethernet controller: Red Hat, Inc. Virtio network device
        Subsystem: Red Hat, Inc. Device 0001
        Physical Slot: 5
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e000 [size=64]
        Region 1: Memory at fea23000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at fe400000 (64-bit, prefetchable) [size=16K]
        Expansion ROM at fea10000 [disabled] [size=64K]
        Capabilities: [98] MSI-X: Enable+ Count=6 Masked-
                Vector table: BAR=1 offset=00000000
                PBA: BAR=1 offset=00000800
        Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
                BAR=0 offset=00000000 size=00000000
        Capabilities: [70] Vendor Specific Information: VirtIO: Notify
                BAR=4 offset=00003000 size=00001000 multiplier=00000004
        Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
                BAR=4 offset=00002000 size=00001000
        Capabilities: [50] Vendor Specific Information: VirtIO: ISR
                BAR=4 offset=00001000 size=00001000
        Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
                BAR=4 offset=00000000 size=00001000
        Kernel driver in use: virtio-pci
        Kernel modules: virtio_pci
00: f4 1a 00 10 07 05 10 00 00 00 00 02 00 00 00 00
10: 01 e0 00 00 00 30 a2 fe 00 00 00 00 00 00 00 00
20: 0c 00 40 fe 00 00 00 00 00 00 00 00 f4 1a 01 00
30: 00 00 a1 fe 98 00 00 00 00 00 00 00 0a 01 00 00
40: 09 00 10 01 04 00 00 00 00 00 00 00 00 10 00 00
50: 09 40 10 03 04 00 00 00 00 10 00 00 00 10 00 00
60: 09 50 10 04 04 00 00 00 00 20 00 00 00 10 00 00
70: 09 60 14 02 04 00 00 00 00 30 00 00 00 10 00 00
80: 04 00 00 00 09 70 14 05 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 11 84 05 80 01 00 00 00
a0: 01 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 SCSI storage controller: Red Hat, Inc. Virtio block device
        Subsystem: Red Hat, Inc. Device 0002
        Physical Slot: 6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e040 [size=64]
        Region 1: Memory at fea24000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at fe404000 (64-bit, prefetchable) [size=16K]
        Capabilities: [98] MSI-X: Enable+ Count=2 Masked-
                Vector table: BAR=1 offset=00000000
                PBA: BAR=1 offset=00000800
        Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
                BAR=0 offset=00000000 size=00000000
        Capabilities: [70] Vendor Specific Information: VirtIO: Notify
                BAR=4 offset=00003000 size=00001000 multiplier=00000004
        Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
                BAR=4 offset=00002000 size=00001000
        Capabilities: [50] Vendor Specific Information: VirtIO: ISR
                BAR=4 offset=00001000 size=00001000
        Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
                BAR=4 offset=00000000 size=00001000
        Kernel driver in use: virtio-pci
        Kernel modules: virtio_pci
00: f4 1a 01 10 07 05 10 00 00 00 00 01 00 00 00 00
10: 41 e0 00 00 00 40 a2 fe 00 00 00 00 00 00 00 00
20: 0c 40 40 fe 00 00 00 00 00 00 00 00 f4 1a 02 00
30: 00 00 00 00 98 00 00 00 00 00 00 00 0a 01 00 00
40: 09 00 10 01 04 00 00 00 00 00 00 00 00 10 00 00
50: 09 40 10 03 04 00 00 00 00 10 00 00 00 10 00 00
60: 09 50 10 04 04 00 00 00 00 20 00 00 00 10 00 00
70: 09 60 14 02 04 00 00 00 00 30 00 00 00 10 00 00
80: 04 00 00 00 09 70 14 05 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 11 84 01 80 01 00 00 00
a0: 01 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 SCSI storage controller: Red Hat, Inc. Virtio block device
        Subsystem: Red Hat, Inc. Device 0002
        Physical Slot: 7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e080 [size=64]
        Region 1: Memory at fea25000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at fe408000 (64-bit, prefetchable) [size=16K]
        Capabilities: [98] MSI-X: Enable+ Count=2 Masked-
                Vector table: BAR=1 offset=00000000
                PBA: BAR=1 offset=00000800
        Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
                BAR=0 offset=00000000 size=00000000
        Capabilities: [70] Vendor Specific Information: VirtIO: Notify
                BAR=4 offset=00003000 size=00001000 multiplier=00000004
        Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
                BAR=4 offset=00002000 size=00001000
        Capabilities: [50] Vendor Specific Information: VirtIO: ISR
                BAR=4 offset=00001000 size=00001000
        Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
                BAR=4 offset=00000000 size=00001000
        Kernel driver in use: virtio-pci
        Kernel modules: virtio_pci
00: f4 1a 01 10 07 05 10 00 00 00 00 01 00 00 00 00
10: 81 e0 00 00 00 50 a2 fe 00 00 00 00 00 00 00 00
20: 0c 80 40 fe 00 00 00 00 00 00 00 00 f4 1a 02 00
30: 00 00 00 00 98 00 00 00 00 00 00 00 0b 01 00 00
40: 09 00 10 01 04 00 00 00 00 00 00 00 00 10 00 00
50: 09 40 10 03 04 00 00 00 00 10 00 00 00 10 00 00
60: 09 50 10 04 04 00 00 00 00 20 00 00 00 10 00 00
70: 09 60 14 02 04 00 00 00 00 30 00 00 00 10 00 00
80: 04 00 00 00 09 70 14 05 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 11 84 01 80 01 00 00 00
a0: 01 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Unclassified device [00ff]: Red Hat, Inc. Virtio memory balloon
        Subsystem: Red Hat, Inc. Device 0005
        Physical Slot: 8
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e0e0 [size=32]
        Region 4: Memory at fe40c000 (64-bit, prefetchable) [size=16K]
        Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
                BAR=0 offset=00000000 size=00000000
        Capabilities: [70] Vendor Specific Information: VirtIO: Notify
                BAR=4 offset=00003000 size=00001000 multiplier=00000004
        Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
                BAR=4 offset=00002000 size=00001000
        Capabilities: [50] Vendor Specific Information: VirtIO: ISR
                BAR=4 offset=00001000 size=00001000
        Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
                BAR=4 offset=00000000 size=00001000
        Kernel driver in use: virtio-pci
        Kernel modules: virtio_pci
00: f4 1a 02 10 07 01 10 00 00 00 ff 00 00 00 00 00
10: e1 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 0c c0 40 fe 00 00 00 00 00 00 00 00 f4 1a 05 00
30: 00 00 00 00 84 00 00 00 00 00 00 00 0b 01 00 00
40: 09 00 10 01 04 00 00 00 00 00 00 00 00 10 00 00
50: 09 40 10 03 04 00 00 00 00 10 00 00 00 10 00 00
60: 09 50 10 04 04 00 00 00 00 20 00 00 00 10 00 00
70: 09 60 14 02 04 00 00 00 00 30 00 00 00 10 00 00
80: 04 00 00 00 09 70 14 05 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
```


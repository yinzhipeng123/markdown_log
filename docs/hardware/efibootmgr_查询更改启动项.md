

efibootmgr查询启动顺序

```bash
# efibootmgr -v 
BootCurrent: 0000                                  # 当前实际使用的启动项编号，本次从 Boot0000 启动
Timeout: 3 seconds                                # UEFI 启动菜单等待时间，单位秒
BootOrder: 0000,0001,0002,0003,0004,0005,0006,0007,0008,0009,000A,000B,000C,000D,000E,000F,0010,0011  # UEFI 启动尝试顺序，按顺序依次尝试，成功即停止
Boot0000* openEuler     HD(1,GPT,056f4909-63b0-49c5-a41a-17a09777cedd,0x800,0x100000)/File(\EFI\openEuler\shimaa64.efi)  # 主系统启动项，GPT 第1分区（EFI 分区）上的 openEuler ARM64 EFI 启动器
      dp: 04 01 2a 00 01 00 00 00 00 08 00 00 00 00 00 00 00 00 10 00 00 00 00 00 09 49 6f 05 b0 63 c5 49 a4 1a 17 a0 97 77 ce dd 02 02 / 04 04 3c 00 5c 00 45 00 46 00 49 00 5c 00 6f 00 70 00 65 00 6e 00 45 00 75 00 6c 00 65 00 72 00 5c 00 73 00 68 00 69 00 6d 00 61 00 61 00 36 00 34 00 2e 00 65 00 66 00 69 00 00 00 / 7f ff 04 00  # 设备路径二进制表示：GPT 分区 + EFI 文件路径
Boot0001* UiApp MemoryMapped(11,0x989d0000,0x994cd73f)/FvFile(462caa21-7614-4503-836e-8ab6f4662331)  # 固件内置的 UEFI 图形/配置界面应用
      dp: 01 03 18 00 0b 00 00 00 00 00 9d 98 00 00 00 00 3f d7 4c 99 00 00 00 00 / 04 06 14 00 21 aa 2c 46 14 76 03 45 83 6e 8a b6 f4 66 23 31 / 7f ff 04 00  # 固件内存映射 + 固件卷文件路径
Boot0002* EFI Internal Shell    MemoryMapped(11,0x989d0000,0x994cd73f)/FvFile(7c04a583-9e3e-4f1c-ad65-e05268d0b4d1)  # UEFI 内置 Shell，可手动执行 UEFI 命令
      dp: 01 03 18 00 0b 00 00 00 00 00 9d 98 00 00 00 00 3f d7 4c 99 00 00 00 00 / 04 06 14 00 83 a5 04 7c 3e 9e 1c 4f ad 65 e0 52 68 d0 b4 d1 / 7f ff 04 00  # 固件内存 + Shell EFI 文件路径
Boot0003* UEFI Misc Device      VenHw(8c91e049-9bf9-440e-bbad-7dc5fc082c02){auto_created_boot_option}  # 厂商自定义的杂项 UEFI 启动项，BIOS 自动生成
      dp: 01 04 14 00 49 e0 91 8c f9 9b 0e 44 bb ad 7d c5 fc 08 2c 02 / 7f ff 04 00  # Vendor Hardware 设备路径
    data: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2          # 厂商私有数据，无通用语义
Boot0004* UEFI KBG40ZPZ128G TOSHIBA MEMORY 84N20079NSJ4 1       PciRoot(0x0)/Pci(...)/NVMe(0x1,8C-E3-8E-04-04-F8-23-84){auto_created_boot_option}  # NVMe 固态硬盘的 UEFI 启动项，指向具体 NVMe 设备
      dp: 02 01 0c 00 d0 41 03 0a 00 00 00 00 / ... / 03 17 10 00 01 00 00 00 8c e3 8e 04 04 f8 23 84 / 7f ff 04 00  # PCI 总线到 NVMe 控制器的完整设备路径
    data: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2          # 厂商附加数据
Boot0005* UEFI Non-Block Boot Device    VenHw(f019e406-8c9c-11e5-8797-001aca00bfc4){auto_created_boot_option}  # 非块设备启动项（如厂商恢复、管理控制器等）
      dp: 01 04 14 00 06 e4 19 f0 9c 8c e5 11 87 97 00 1a ca 00 bf c4 / 7f ff 04 00  # 厂商定义硬件路径
    data: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2          # 厂商私有数据
Boot0006* UEFI PXEv4 (MAC:001ACAFFFF01) MAC(001acaffff01,1)/IPv4(0.0.0.0,0,0){auto_created_boot_option}  # 第一张网卡的 IPv4 PXE 启动（DHCP + TFTP）
      dp: 03 0b 25 00 00 1a ca ff ff 01 ... / 03 0c 1b 00 ... / 7f ff 04 00  # MAC + IPv4 PXE 设备路径
    data: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2          # PXE 相关厂商数据
Boot0007* UEFI PXEv6 (MAC:001ACAFFFF01) MAC(001acaffff01,1)/IPv6([::]:<->[::]:,0,0){auto_created_boot_option}  # 第一张网卡的 IPv6 PXE 启动
      dp: 03 0b 25 00 ... / 03 0d 3c 00 ... / 7f ff 04 00        # MAC + IPv6 PXE 设备路径
    data: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2          # PXE 厂商数据
Boot0008* UEFI HTTPv4 (MAC:001ACAFFFF01)        MAC(001acaffff01,1)/IPv4(...)/Uri(){auto_created_boot_option}  # 第一张网卡的 IPv4 HTTP Boot
Boot0009* UEFI HTTPv6 (MAC:001ACAFFFF01)        MAC(001acaffff01,1)/IPv6(...)/Uri(){auto_created_boot_option}  # 第一张网卡的 IPv6 HTTP Boot
Boot000A* UEFI PXEv4 (MAC:CC40F38D2484) MAC(cc40f38d2484,1)/IPv4(...){auto_created_boot_option}  # 第二张网卡的 IPv4 PXE 启动
Boot000B* UEFI PXEv6 (MAC:CC40F38D2484) MAC(cc40f38d2484,1)/IPv6(...){auto_created_boot_option}  # 第二张网卡的 IPv6 PXE 启动
Boot000C* UEFI HTTPv4 (MAC:CC40F38D2484)        MAC(cc40f38d2484,1)/IPv4(...)/Uri(){auto_created_boot_option}  # 第二张网卡的 IPv4 HTTP Boot
Boot000D* UEFI HTTPv6 (MAC:CC40F38D2484)        MAC(cc40f38d2484,1)/IPv6(...)/Uri(){auto_created_boot_option}  # 第二张网卡的 IPv6 HTTP Boot
Boot000E* UEFI PXEv4 (MAC:CC40F38D2484 VLAN4040)        MAC(...)/Vlan(4040)/IPv4(...){auto_created_boot_option}  # 第二张网卡 + VLAN 4040 的 IPv4 PXE
Boot000F* UEFI PXEv6 (MAC:CC40F38D2484 VLAN4040)        MAC(...)/Vlan(4040)/IPv6(...){auto_created_boot_option}  # 第二张网卡 + VLAN 4040 的 IPv6 PXE
Boot0010* UEFI HTTPv4 (MAC:CC40F38D2484 VLAN4040)       MAC(...)/Vlan(4040)/IPv4(...)/Uri(){auto_created_boot_option}  # 第二张网卡 + VLAN 4040 的 IPv4 HTTP Boot
Boot0011* UEFI HTTPv6 (MAC:CC40F38D2484 VLAN4040)       MAC(...)/Vlan(4040)/IPv6(...)/Uri(){auto_created_boot_option}  # 第二张网卡 + VLAN 4040 的 IPv6 HTTP Boot

```



curl 命令查询网卡启动顺序

```bash
# curl -g -k -u root:'password' -X GET https://[240c:4051:2323:9::f038]/redfish/v1/Systems/Bluefield
{
  "@Redfish.Settings": {                                  # Redfish 设置对象，描述该资源是否支持可修改设置
    "@odata.type": "#Settings.v1_3_5.Settings",           # Settings 资源类型版本
    "SettingsObject": {
      "@odata.id": "/redfish/v1/Systems/Bluefield/Settings" # 指向该系统的可配置 Settings 资源
    }
  },
  "@odata.id": "/redfish/v1/Systems/Bluefield",           # 当前系统资源在 Redfish 中的唯一 URI
  "@odata.type": "#ComputerSystem.v1_22_0.ComputerSystem",# 资源类型：计算机系统，版本 v1.22.0
  "Actions": {                                            # 对该系统可执行的动作集合
    "#ComputerSystem.Reset": {                            # 系统重启动作
      "@Redfish.ActionInfo": "/redfish/v1/Systems/Bluefield/ResetActionInfo", # Reset 动作参数说明
      "target": "/redfish/v1/Systems/Bluefield/Actions/ComputerSystem.Reset" # Reset 动作调用地址
    }
  },
  "Bios": {
    "@odata.id": "/redfish/v1/Systems/Bluefield/Bios"     # BIOS 配置资源路径
  },
  "Boot": {                                               # 启动相关配置（核心部分）
    "AutomaticRetryAttempts": 3,                          # 自动重试启动的最大次数
    "AutomaticRetryConfig": "Disabled",                   # 自动重试功能当前关闭
    "AutomaticRetryConfig@Redfish.AllowableValues": [
      "Disabled",
      "RetryAttempts"
    ],
    "BootNext": "",                                       # 单次启动覆盖项（类似 efibootmgr -n），为空表示未设置
    "BootOptions": {
      "@odata.id": "/redfish/v1/Systems/Bluefield/BootOptions" # 系统可用的 BootXXXX 详细列表
    },
    "BootOrder": [                                        # 当前生效的 UEFI 启动顺序（与你 efibootmgr 完全对应）
      "Boot0006",                                         # 第一优先：PXE IPv4（网卡1）
      "Boot000A",                                         # 第二优先：PXE IPv4（网卡2）
      "Boot000E",                                         # 第三优先：PXE IPv4（网卡2 + VLAN 4040）
      "Boot0000",                                         # 本地 openEuler 启动项
      "Boot0001",                                         # UEFI UI App
      "Boot0002",                                         # UEFI Shell
      "Boot0003",                                         # 厂商 Misc Device
      "Boot0004",                                         # NVMe 硬盘
      "Boot0005",                                         # 非块设备启动项
      "Boot0007",                                         # PXE IPv6（网卡1）
      "Boot0008",                                         # HTTP IPv4（网卡1）
      "Boot0009",                                         # HTTP IPv6（网卡1）
      "Boot000B",                                         # PXE IPv6（网卡2）
      "Boot000C",                                         # HTTP IPv4（网卡2）
      "Boot000D",                                         # HTTP IPv6（网卡2）
      "Boot000F",                                         # PXE IPv6（网卡2 + VLAN 4040）
      "Boot0010",                                         # HTTP IPv4（网卡2 + VLAN 4040）
      "Boot0011",                                         # HTTP IPv6（网卡2 + VLAN 4040）
      "Boot0012",                                         # 额外存在的启动项（BIOS 自动生成）
      "Boot0013",
      "Boot0014",
      "Boot0015"
    ],
    "BootOrderPropertySelection": "BootOrder",             # 表示当前使用 BootOrder 方式控制启动
    "BootSourceOverrideEnabled": "Disabled",               # 启动源覆盖关闭（非一次性、非强制）
    "BootSourceOverrideEnabled@Redfish.AllowableValues": [
      "Once",
      "Continuous",
      "Disabled"
    ],
    "BootSourceOverrideMode": "UEFI",                      # 启动模式为 UEFI
    "BootSourceOverrideMode@Redfish.AllowableValues": [
      "Legacy",
      "UEFI"
    ],
    "BootSourceOverrideTarget": "Pxe",                     # 覆盖目标类型为 PXE（但因 Enabled=Disabled 未生效）
    "BootSourceOverrideTarget@Redfish.AllowableValues": [
      "None",
      "Pxe",
      "Hdd",
      "UefiHttp",
      "UefiShell",
      "None",
      "UefiTarget",
      "UefiBootNext"
    ],
    "HttpBootUri": "",                                     # HTTP Boot 使用的 URI（当前未配置）
    "RemainingAutomaticRetryAttempts": 0,                  # 剩余可用的自动重试次数
    "StopBootOnFault": "Never",                            # 启动失败时不停止重试流程
    "TrustedModuleRequiredToBoot": "Disabled",             # 不要求 TPM/可信模块参与启动
    "UefiTargetBootSourceOverride": "None"                 # 未指定具体 UEFI Target 覆盖
  },
  "BootProgress": {                                        # 启动过程状态信息
    "LastState": "OEM",                                    # 最近一次启动阶段（厂商定义）
    "LastStateTime": "1970-01-21T10:45:33.348316+00:00",   # 上一次状态记录时间（明显未同步时钟）
    "OemLastState": "UEFI"                                 # 厂商定义的阶段：UEFI
  },
  "Description": "This ComputerSystem resource represents the SoC that is part of the DPU found in Card1", # 描述：该系统代表 DPU 上的 SoC
  "EthernetInterfaces": {
    "@odata.id": "/redfish/v1/Systems/Bluefield/EthernetInterfaces" # 以太网接口资源集合
  },
  "GraphicalConsole": {
    "ConnectTypesSupported": [
      "KVMIP"                                              # 支持 KVM over IP 图形控制台
    ],
    "MaxConcurrentSessions": 4,                            # 最大并发会话数
    "ServiceEnabled": true                                 # 图形控制台服务已启用
  },
  "HostWatchdogTimer": {
    "FunctionEnabled": false,                              # 看门狗功能未启用
    "Status": {
      "State": "Enabled"                                   # 看门狗硬件状态启用
    },
    "TimeoutAction": "ResetSystem"                         # 超时时的动作：重启系统
  },
  "Id": "Bluefield",                                       # 系统 ID
  "LastResetTime": "1970-01-01T00:00:00+00:00",            # 最近一次重启时间（未初始化）
  "Links": {
    "Chassis": [
      {
        "@odata.id": "/redfish/v1/Chassis/Bluefield_BMC"   # 关联的机箱资源
      }
    ],
    "ManagedBy": [
      {
        "@odata.id": "/redfish/v1/Managers/Bluefield_BMC"  # 管理该系统的 BMC
      }
    ]
  },
  "LogServices": {
    "@odata.id": "/redfish/v1/Systems/Bluefield/LogServices" # 系统日志服务
  },
  "Manufacturer": "Nvidia",                                # 厂商：NVIDIA
  "Memory": {
    "@odata.id": "/redfish/v1/Systems/Bluefield/Memory"    # 内存资源（DPU SoC 侧）
  },
  "MemorySummary": {
    "TotalSystemMemoryGiB": 0                              # 对外不可见或未上报系统内存
  },
  "Model": "BlueField-3 DPU",                               # 型号：BlueField-3 DPU
  "Name": "Bluefield",                                     # 系统名称
  "Oem": {
    "Nvidia": {
      "@odata.id": "/redfish/v1/Systems/Bluefield/Oem/Nvidia" # NVIDIA 私有 OEM 扩展
    }
  },
  "PowerMode": "Static",                                   # 电源模式：固定模式
  "PowerMode@Redfish.AllowableValues": [
    "Static",
    "MaximumPerformance",
    "PowerSaving"
  ],
  "PowerRestorePolicy": "AlwaysOn",                         # 上电恢复策略：来电即开机
  "PowerState": "Paused",                                  # 当前电源状态：暂停（非完全运行）
  "ProcessorSummary": {
    "Count": 0                                             # Redfish 未暴露 CPU（DPU SoC 架构常见）
  },
  "Processors": {
    "@odata.id": "/redfish/v1/Systems/Bluefield/Processors" # 处理器资源集合
  },
  "SecureBoot": {
    "@odata.id": "/redfish/v1/Systems/Bluefield/SecureBoot" # Secure Boot 配置资源
  },
  "SerialConsole": {
    "IPMI": {
      "ServiceEnabled": true                               # IPMI 串口控制台启用
    },
    "MaxConcurrentSessions": 15,                            # 串口最大并发会话数
    "SSH": {
      "HotKeySequenceDisplay": "Press ~. to exit console",  # SSH 串口退出快捷键提示
      "Port": 2200,                                        # SSH 串口端口
      "ServiceEnabled": true                               # SSH 串口服务启用
    }
  },
  "SerialNumber": "MT2530601J3Z",                            # 设备序列号
  "Status": {
    "Conditions": [],                                      # 当前无告警条件
    "Health": "OK",                                        # 健康状态正常
    "State": "StandbyOffline"                              # 当前系统处于待机/离线状态
  },
  "Storage": {
    "@odata.id": "/redfish/v1/Systems/Bluefield/Storage"   # 存储资源集合
  },
  "SystemType": "Physical"                                 # 系统类型：物理设备
}

```






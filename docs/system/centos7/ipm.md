



```bash
ipmitool 版本 1.8.18-csv

用法: ipmitool [选项...] <命令>

       -h             显示帮助信息
       -V             显示版本信息
       -v             启用详细模式（可以多次使用）
       -c             以逗号分隔格式显示输出
       -d N           指定使用的 /dev/ipmiN 设备（默认为0）
       -I intf        使用的接口
       -H 主机名     远程主机名，用于LAN接口
       -p 端口        远程RMCP端口 [默认是623]
       -U 用户名      远程会话用户名
       -f 文件        从文件读取远程会话密码
       -z 大小        更改通信通道的大小（OEM）
       -S sdr         使用本地文件作为远程SDR缓存
       -D tty:b[:s]   指定串口设备、波特率，并可选地指定该接口为系统接口
       -4             仅使用IPv4
       -6             仅使用IPv6
       -a             提示输入远程密码
       -Y             提示输入IPMIv2身份验证的Kg密钥
       -e char        设置SOL转义字符
       -C 密码套件    指定LANPlus接口使用的密码套件
       -k 密钥        使用Kg密钥进行IPMIv2身份验证
       -y hex_key     使用十六进制编码的Kg密钥进行IPMIv2身份验证
       -L 等级        远程会话权限等级 [默认是ADMINISTRATOR]
                      在RAKP1阶段，附加“+”表示使用名称/权限查找
       -A authtype    强制使用身份验证类型 NONE, PASSWORD, MD2, MD5 或 OEM
       -P 密码        远程会话密码
       -E             从IPMI_PASSWORD环境变量读取密码
       -K             从IPMI_KGKEY环境变量读取Kg密钥
       -m 地址        设置本地IPMB地址
       -b 通道        设置桥接请求的目标通道
       -t 地址        将请求桥接到远程目标地址
       -B 通道        设置桥接请求的过渡通道（双桥接）
       -T 地址        设置桥接请求的过渡地址（双桥接）
       -l lun         设置原始命令的目标LUN
       -o oemtype     为OEM配置（使用'list'查看可用的OEM类型）
       -O seloem      使用文件描述OEM SEL事件
       -N 秒数        指定LAN接口的超时时间 [默认是2] / LANPlus接口 [默认是1]
       -R 重试次数    设置LAN/LANPlus接口的重试次数 [默认是4]

接口：
        open          Linux OpenIPMI接口 [默认]
        imb           英特尔IMB接口 
        lan           IPMI v1.5 LAN接口 
        lanplus       IPMI v2.0 RMCP+ LAN接口 
        serial-terminal  串行接口，终端模式 
        serial-basic  串行接口，基本模式 
        usb           IPMI USB接口（AMi设备的OEM接口） 

命令：
        raw           发送RAW IPMI请求并打印响应
        i2c           发送I2C主写读命令并打印响应
        spd           打印远程I2C设备的SPD信息
        lan           配置LAN通道
        chassis       获取机箱状态并设置电源状态
        power         快捷命令用于机箱电源控制
        event         发送预定义的事件到管理控制器
        mc            管理控制器状态及全局启用设置
        sdr           打印传感器数据存储库条目及读数
        sensor        打印详细的传感器信息
        fru           打印内置FRU并扫描SDR以查找FRU定位器
        gendev        读取/写入与通用设备定位器相关联的设备
        sel           打印系统事件日志（SEL）
        pef           配置平台事件过滤（PEF）
        sol           配置并连接IPMIv2.0串行LAN
        tsol          配置并连接Tyan IPMIv1.5串行LAN
        isol          配置IPMIv1.5串行LAN
        user          配置管理控制器用户
        channel       配置管理控制器通道
        session       打印会话信息
        dcmi          数据中心管理接口
        nm            节点管理接口
        sunoem        Sun服务器的OEM命令
        kontronoem    Kontron设备的OEM命令
        picmg         执行PICMG/ATCA扩展命令
        fwum          使用Kontron OEM固件更新管理器更新IPMC
        firewall      配置固件防火墙
        delloem       Dell系统的OEM命令
        shell         启动交互式IPMI命令行
        exec          从文件执行命令列表
        set           设置shell和exec的运行时变量
        hpm           使用PICMG HPM.1文件更新HPM组件
        ekanalyzer    使用FRU文件运行FRU-Ekeying分析器
        ime           更新Intel管理引擎固件
        vita          执行VITA 46.11扩展命令
        lan6          配置IPv6 LAN通道

```





`ipmitool` 是一个用于管理服务器硬件的工具，通常用于与 IPMI（Intelligent Platform Management Interface）兼容的管理控制器（如 BMC）进行交互。以下是一些常用的 `ipmitool` 命令和用法：

### 1. **查看系统电源状态**

```
ipmitool power status
```

用于查看服务器当前的电源状态（开机、关机、待机等）。

### 2. **启动系统**

```
ipmitool power on
```

启动服务器。

### 3. **关闭系统**

```
ipmitool power off
```

关闭服务器。

### 4. **重启系统**

下面两个命令都是用于远程管理服务器电源，但它们的工作方式不同：

```
ipmitool power cycle
```

 该命令会先关闭服务器电源，然后在等待一段时间后再启动。换句话说，它执行的是一个完整的断电再重启的过程。这种方式能确保所有硬件状态都被完全重置，适合于系统无响应或需要彻底清除状态的情况。

```
ipmitool power reset
```

 该命令类似于按下机箱上的重启按钮。它会直接向系统发送重置信号，让服务器重启，但不会完全断开电源。这种方式更温和，适用于需要快速重启而无需完全断电的场景。



### 5. **获取机箱状态**

```
ipmitool chassis status
```

查看机箱状态（例如：电源、温度、风扇等）。

### 6. **获取传感器数据**

```
ipmitool sensor
```

查看服务器中各类传感器的当前数据，如温度、风扇速度、电压等。

### 7. **查看系统事件日志（SEL）**

```
ipmitool sel list
```

打印系统事件日志条目，包含服务器硬件故障或警告。

### 8. **配置管理控制器用户**

```
ipmitool user list 1
```

查看管理控制器（BMC）的用户列表。`1` 是表示通道的编号。

### 9. **添加用户**

```
ipmitool user set name 2 username
ipmitool user set password 2 password
```

设置新用户，`2` 是用户ID，`username` 和 `password` 是用户名和密码。

### 10. **配置LAN接口**

```
ipmitool lan set 1 ipaddr 192.168.1.100
ipmitool lan set 1 netmask 255.255.255.0
ipmitool lan set 1 defgw ipaddr 192.168.1.1
```

配置BMC的LAN接口，设置IP地址、子网掩码和默认网关。

### 11. **查看管理控制器（MC）状态**

```
ipmitool mc info
```

显示管理控制器的状态信息，包括固件版本、制造商等。

### 12. **查看传感器数据仓库（SDR）**

```
ipmitool sdr
```

打印出所有传感器的当前状态信息。

### 13. **执行原始命令**

```bash
  ipmitool -I lanplus -H "带外ip地址" -U 用户名 -P 密码 raw 0x30 0x02 0x61 0x7e 0x0 0x2 
```

下面对该命令各部分做一下详细说明：

**连接和认证部分**

- **ipmitool**
   用于通过IPMI协议管理服务器硬件的命令行工具。
- **-I lanplus**
   指定使用的接口类型为“lanplus”，这表示采用IPMI v2.0的加密LAN接口，安全性更高。
- **-H "带外ip地址"**
   指定目标BMC（Baseboard Management Controller，即主板管理控制器）的IP地址或主机名。这里使用了变量`$server`。
- **-U 用户名**
   登录BMC时使用的用户名为`ADMIN`。
- **-P 密码**
   登录BMC时使用的密码为`ADMIN`。

**raw命令部分**

- **raw**
   表示接下来跟随的是原始IPMI命令数据，而不是ipmitool内置的高级命令。使用raw方式可以直接发送厂商自定义的命令。由于raw命令的数据部分是厂商自定义的，具体每个字节的意义需要参考目标设备厂商提供的IPMI命令手册或文档来确定。该命令使用LAN加密接口，通过指定的IP地址和认证信息连接到BMC后，发送了一条OEM原始命令（由`0x30 0x02 0x61 0x7e 0x0 0x2`这几个字节组成）。每个参数的确切功能取决于具体厂商的实现。这条命令是重启命令





### 14. **配置串行过LAN（SOL）**

```bash
ipmitool -I lanp -H 带外ip地址 -U 用户名 -P 密码 sol activate
```

启用串行过LAN（SOL）会话，允许远程通过串行接口访问服务器。

该命令通过IPMI协议连接到服务器的带外管理接口，并激活其串口重定向（SOL，Serial Over LAN）功能。具体来说：

- **-I lanp**：指定使用LAN接口进行通信（有时也使用lan或lanplus，根据环境而定）。
- **-H 带外ip地址**：指定BMC（主板管理控制器）的IP地址，通常是服务器的管理网卡地址。
- **-U 用户名 -P 密码**：用于验证访问BMC的认证信息。
- **sol activate**：激活SOL功能，即打开远程串口会话。这样管理员可以通过网络远程访问服务器的串口输出，便于故障排查和系统管理。

该命令用于远程打开服务器的串口控制台会话，实现带外管理下登陆主机内实例



### 15. **查看IPMI版本**

```
ipmitool -V
```

显示 `ipmitool` 的版本信息。

### 16. **获取系统的FRU（Field Replaceable Unit）信息**

```
ipmitool fru
```

打印出服务器的FRU信息（如型号、序列号、制造商等）。

### 17. **查看BMC固件信息**

```
ipmitool mc selftest
```

执行BMC的自检操作，帮助排查BMC硬件或固件的问题。

### 18. **配置平台事件过滤（PEF）**

```
ipmitool pef status
```

查看或配置PEF（平台事件过滤）状态，用于设置对硬件事件的响应策略。

### 19. **列出所有用户**

```
ipmitool user list 1
```

查看当前管理控制器的所有用户。

这些是 `ipmitool` 最常用的命令和用法。通过这些命令，你可以远程管理服务器的硬件状态、控制电源、查看传感器数据、修改配置等操作，尤其在数据中心中进行硬件管理时非常有用。









```bash
[root@ ~]# ipmitool -I open chassis status 
System Power         : on                  # 系统电源状态：开启
Power Overload       : false               # 电源过载：否
Power Interlock      : inactive            # 电源互锁：未激活
Main Power Fault     : false               # 主电源故障：否
Power Control Fault  : false               # 电源控制故障：否
Power Restore Policy : always-on           # 断电恢复策略：始终开启
Last Power Event     : command             # 上次电源事件：命令触发
Chassis Intrusion    : inactive            # 机箱入侵检测：未激活
Front-Panel Lockout  : inactive            # 前面板锁定：未激活
Drive Fault          : false               # 硬盘故障：否
Cooling/Fan Fault    : false               # 散热/风扇故障：否
Sleep Button Disable : allowed             # 休眠按钮禁用：允许
Diag Button Disable  : allowed             # 诊断按钮禁用：允许
Reset Button Disable : allowed             # 复位按钮禁用：允许
Power Button Disable : allowed             # 电源按钮禁用：允许
Sleep Button Disabled: false               # 休眠按钮当前是否禁用：否
Diag Button Disabled : false               # 诊断按钮当前是否禁用：否
Reset Button Disabled: false               # 复位按钮当前是否禁用：否
Power Button Disabled: false               # 电源按钮当前是否禁用：否

[root@ ~]# ipmitool sdr list
Event_Log        | 0x00              | ok    # 事件日志传感器，当前数值为 0x00，状态正常
Watchdog2        | 0x00              | ok    # 看门狗2传感器，当前数值为 0x00，状态正常
CPU0_Status      | 0 unspecified     | ok    # CPU0 状态传感器，数值为 0（单位未指定），状态正常
CPU1_Status      | 0 unspecified     | ok    # CPU1 状态传感器，数值为 0（单位未指定），状态正常
PSU1_Status      | 0 unspecified     | nc    # 电源1状态传感器，数值为 0（单位未指定），状态 nc（未连接/无数据）
PSU2_Status      | 0 unspecified     | nc    # 电源2状态传感器，数值为 0（单位未指定），状态 nc（未连接/无数据）
CPU0_A0          | 0 unspecified     | ok    # CPU0 A0 通道传感器，数值为 0（单位未指定），状态正常
CPU0_A1          | 0 unspecified     | ok    # CPU0 A1 通道传感器，数值为 0（单位未指定），状态正常
CPU0_B0          | 0 unspecified     | ok    # CPU0 B0 通道传感器，数值为 0（单位未指定），状态正常
CPU0_B1          | 0 unspecified     | ok    # CPU0 B1 通道传感器，数值为 0（单位未指定），状态正常
CPU0_C0          | 0 unspecified     | ok    # CPU0 C0 通道传感器，数值为 0（单位未指定），状态正常
CPU0_C1          | 0 unspecified     | ok    # CPU0 C1 通道传感器，数值为 0（单位未指定），状态正常
CPU0_D0          | 0 unspecified     | ok    # CPU0 D0 通道传感器，数值为 0（单位未指定），状态正常
CPU0_D1          | 0 unspecified     | ok    # CPU0 D1 通道传感器，数值为 0（单位未指定），状态正常
CPU0_E0          | 0 unspecified     | ok    # CPU0 E0 通道传感器，数值为 0（单位未指定），状态正常
CPU0_E1          | 0 unspecified     | ok    # CPU0 E1 通道传感器，数值为 0（单位未指定），状态正常
CPU0_F0          | 0 unspecified     | ok    # CPU0 F0 通道传感器，数值为 0（单位未指定），状态正常
CPU0_F1          | 0 unspecified     | ok    # CPU0 F1 通道传感器，数值为 0（单位未指定），状态正常
CPU0_G0          | 0 unspecified     | ok    # CPU0 G0 通道传感器，数值为 0（单位未指定），状态正常
CPU0_G1          | 0 unspecified     | ok    # CPU0 G1 通道传感器，数值为 0（单位未指定），状态正常
CPU0_H0          | 0 unspecified     | ok    # CPU0 H0 通道传感器，数值为 0（单位未指定），状态正常
CPU0_H1          | 0 unspecified     | ok    # CPU0 H1 通道传感器，数值为 0（单位未指定），状态正常
CPU1_A0          | 0 unspecified     | ok    # CPU1 A0 通道传感器，数值为 0（单位未指定），状态正常
CPU1_A1          | 0 unspecified     | ok    # CPU1 A1 通道传感器，数值为 0（单位未指定），状态正常
CPU1_B0          | 0 unspecified     | ok    # CPU1 B0 通道传感器，数值为 0（单位未指定），状态正常
CPU1_B1          | 0 unspecified     | ok    # CPU1 B1 通道传感器，数值为 0（单位未指定），状态正常
CPU1_C0          | 0 unspecified     | ok    # CPU1 C0 通道传感器，数值为 0（单位未指定），状态正常
CPU1_C1          | 0 unspecified     | ok    # CPU1 C1 通道传感器，数值为 0（单位未指定），状态正常
CPU1_D0          | 0 unspecified     | ok    # CPU1 D0 通道传感器，数值为 0（单位未指定），状态正常
CPU1_D1          | 0 unspecified     | ok    # CPU1 D1 通道传感器，数值为 0（单位未指定），状态正常
CPU1_E0          | 0 unspecified     | ok    # CPU1 E0 通道传感器，数值为 0（单位未指定），状态正常
CPU1_E1          | 0 unspecified     | ok    # CPU1 E1 通道传感器，数值为 0（单位未指定），状态正常
CPU1_F0          | 0 unspecified     | ok    # CPU1 F0 通道传感器，数值为 0（单位未指定），状态正常
CPU1_F1          | 0 unspecified     | ok    # CPU1 F1 通道传感器，数值为 0（单位未指定），状态正常
CPU1_G0          | 0 unspecified     | ok    # CPU1 G0 通道传感器，数值为 0（单位未指定），状态正常
CPU1_G1          | 0 unspecified     | ok    # CPU1 G1 通道传感器，数值为 0（单位未指定），状态正常
CPU1_H0          | 0 unspecified     | ok    # CPU1 H0 通道传感器，数值为 0（单位未指定），状态正常
CPU1_H1          | 0 unspecified     | ok    # CPU1 H1 通道传感器，数值为 0（单位未指定），状态正常
CPU0_Temp        | 71 degrees C      | ok    # CPU0 温度传感器，当前温度 71°C，状态正常
CPU1_Temp        | 60 degrees C      | ok    # CPU1 温度传感器，当前温度 60°C，状态正常
DIMMG0_Temp      | 51 degrees C      | ok    # DIMM G0 温度传感器，当前温度 51°C，状态正常
DIMMG1_Temp      | 44 degrees C      | ok    # DIMM G1 温度传感器，当前温度 44°C，状态正常
BMC_Boot_Up      | 0 unspecified     | ok    # BMC 启动状态传感器，数值为 0（单位未指定），状态正常
Total_Power      | 760 Watts         | ok    # 总功率传感器，当前功率 760 瓦，状态正常
CPU_Total_Power  | 198 Watts         | ok    # CPU 总功率传感器，当前功率 198 瓦，状态正常
PSU1_Temp        | 33 degrees C      | ok    # PSU1 温度传感器，当前温度 33°C，状态正常
PSU2_Temp        | 31 degrees C      | ok    # PSU2 温度传感器，当前温度 31°C，状态正常
PSU_Redundant    | 0 unspecified     | nc    # PSU 冗余状态传感器，数值为 0（单位未指定），状态 nc（未连接/无数据）
PSU1_POUT        | 352 Watts         | ok    # PSU1 输出功率传感器，当前输出 352 瓦，状态正常
PSU2_POUT        | 368 Watts         | ok    # PSU2 输出功率传感器，当前输出 368 瓦，状态正常
PSU1_Fan_Status  | 0 unspecified     | ok    # PSU1 风扇状态传感器，数值为 0（单位未指定），状态正常
PSU2_Fan_Status  | 0 unspecified     | ok    # PSU2 风扇状态传感器，数值为 0（单位未指定），状态正常
NVME_Temp        | 38 degrees C      | ok    # NVMe 温度传感器，当前温度 38°C，状态正常
CPU0_VR_Temp     | 60 degrees C      | ok    # CPU0 电压调节器温度传感器，当前温度 60°C，状态正常
CPU1_VR_Temp     | 52 degrees C      | ok    # CPU1 电压调节器温度传感器，当前温度 52°C，状态正常
CPU_ResourceRate | disabled          | ns    # CPU 资源利用率传感器，已禁用，状态 ns（不支持/未采样）
MEM_ResourceRate | disabled          | ns    # 内存资源利用率传感器，已禁用，状态 ns（不支持/未采样）
HDD_ResourceRate | disabled          | ns    # 硬盘资源利用率传感器，已禁用，状态 ns（不支持/未采样）
MEM_Total_Power  | 65 Watts          | ok    # 内存总功率传感器，当前功率 65 瓦，状态正常
OCP_Zone_Temp    | disabled          | ns    # OCP 区域温度传感器，已禁用，状态 ns（不支持/未采样）
IB_Zone_Temp     | 35 degrees C      | ok    # IB 区域温度传感器，当前温度 35°C，状态正常
FAN40_1_F_RPM    | 9920 RPM          | ok    # 前置 40mm 风扇1转速传感器，转速 9920 RPM，状态正常
FAN40_1_R_RPM    | 8800 RPM          | ok    # 后置 40mm 风扇1转速传感器，转速 8800 RPM，状态正常
FAN40_2_F_RPM    | 9760 RPM          | ok    # 前置 40mm 风扇2转速传感器，转速 9760 RPM，状态正常
FAN40_2_R_RPM    | 8800 RPM          | ok    # 后置 40mm 风扇2转速传感器，转速 8800 RPM，状态正常
FAN40_3_F_RPM    | 9920 RPM          | ok    # 前置 40mm 风扇3转速传感器，转速 9920 RPM，状态正常
FAN40_3_R_RPM    | 8800 RPM          | ok    # 后置 40mm 风扇3转速传感器，转速 8800 RPM，状态正常
FAN40_4_F_RPM    | 9920 RPM          | ok    # 前置 40mm 风扇4转速传感器，转速 9920 RPM，状态正常
FAN40_4_R_RPM    | 8800 RPM          | ok    # 后置 40mm 风扇4转速传感器，转速 8800 RPM，状态正常
FAN80_1_F_RPM    | 3552 RPM          | ok    # 前置 80mm 风扇1转速传感器，转速 3552 RPM，状态正常
FAN80_1_R_RPM    | 4128 RPM          | ok    # 后置 80mm 风扇1转速传感器，转速 4128 RPM，状态正常
FAN80_2_F_RPM    | 3552 RPM          | ok    # 前置 80mm 风扇2转速传感器，转速 3552 RPM，状态正常
FAN80_2_R_RPM    | 4128 RPM          | ok    # 后置 80mm 风扇2转速传感器，转速 4128 RPM，状态正常
FAN80_3_R_RPM    | 4128 RPM          | ok    # 后置 80mm 风扇3转速传感器，转速 4128 RPM，状态正常
FAN80_3_F_RPM    | 3552 RPM          | ok    # 前置 80mm 风扇3转速传感器，转速 3552 RPM，状态正常
FAN80_4_R_RPM    | 4128 RPM          | ok    # 后置 80mm 风扇4转速传感器，转速 4128 RPM，状态正常
FAN80_4_F_RPM    | 3552 RPM          | ok    # 前置 80mm 风扇4转速传感器，转速 3552 RPM，状态正常
DISK0_Status     | 0 unspecified     | nc    # 磁盘0状态传感器，数值为 0（单位未指定），状态 nc（未检测到/无数据）
DISK1_Status     | 0 unspecified     | nc    # 磁盘1状态传感器，数值为 0（单位未指定），状态 nc
DISK2_Status     | 0 unspecified     | nc    # 磁盘2状态传感器，数值为 0（单位未指定），状态 nc
DISK3_Status     | 0 unspecified     | nc    # 磁盘3状态传感器，数值为 0（单位未指定），状态 nc
DISK4_Status     | 0 unspecified     | nc    # 磁盘4状态传感器，数值为 0（单位未指定），状态 nc
DISK5_Status     | 0 unspecified     | nc    # 磁盘5状态传感器，数值为 0（单位未指定），状态 nc
DISK6_Status     | 0 unspecified     | nc    # 磁盘6状态传感器，数值为 0（单位未指定），状态 nc
DISK7_Status     | 0 unspecified     | nc    # 磁盘7状态传感器，数值为 0（单位未指定），状态 nc
DISK8_Status     | 0 unspecified     | nc    # 磁盘8状态传感器，数值为 0（单位未指定），状态 nc
DISK9_Status     | 0 unspecified     | nc    # 磁盘9状态传感器，数值为 0（单位未指定），状态 nc
DISK10_Status    | 0 unspecified     | nc    # 磁盘10状态传感器，数值为 0（单位未指定），状态 nc
DISK11_Status    | 0 unspecified     | nc    # 磁盘11状态传感器，数值为 0（单位未指定），状态 nc
DISK12_Status    | 0 unspecified     | nc    # 磁盘12状态传感器，数值为 0（单位未指定），状态 nc
DISK13_Status    | 0 unspecified     | nc    # 磁盘13状态传感器，数值为 0（单位未指定），状态 nc
DISK14_Status    | 0 unspecified     | nc    # 磁盘14状态传感器，数值为 0（单位未指定），状态 nc
DISK15_Status    | 0 unspecified     | nc    # 磁盘15状态传感器，数值为 0（单位未指定），状态 nc
DISK16_Status    | 0 unspecified     | nc    # 磁盘16状态传感器，数值为 0（单位未指定），状态 nc
DISK17_Status    | 0 unspecified     | nc    # 磁盘17状态传感器，数值为 0（单位未指定），状态 nc
DISK18_Status    | 0 unspecified     | nc    # 磁盘18状态传感器，数值为 0（单位未指定），状态 nc
DISK19_Status    | 0 unspecified     | nc    # 磁盘19状态传感器，数值为 0（单位未指定），状态 nc
DISK20_Status    | 0 unspecified     | nc    # 磁盘20状态传感器，数值为 0（单位未指定），状态 nc
DISK21_Status    | 0 unspecified     | nc    # 磁盘21状态传感器，数值为 0（单位未指定），状态 nc
DISK22_Status    | 0 unspecified     | nc    # 磁盘22状态传感器，数值为 0（单位未指定），状态 nc
DISK23_Status    | 0 unspecified     | nc    # 磁盘23状态传感器，数值为 0（单位未指定），状态 nc
DISK24_Status    | 0 unspecified     | nc    # 磁盘24状态传感器，数值为 0（单位未指定），状态 nc
DISK25_Status    | 0 unspecified     | nc    # 磁盘25状态传感器，数值为 0（单位未指定），状态 nc
DISK26_Status    | 0 unspecified     | cr    # 磁盘26状态传感器，数值为 0（单位未指定），状态 cr（关键错误）
DISK27_Status    | 0 unspecified     | nc    # 磁盘27状态传感器，数值为 0（单位未指定），状态 nc
DISK28_Status    | 0 unspecified     | nc    # 磁盘28状态传感器，数值为 0（单位未指定），状态 nc
DISK29_Status    | 0 unspecified     | nc    # 磁盘29状态传感器，数值为 0（单位未指定），状态 nc
DISK30_Status    | 0 unspecified     | nc    # 磁盘30状态传感器，数值为 0（单位未指定），状态 nc
DISK31_Status    | 0 unspecified     | nc    # 磁盘31状态传感器，数值为 0（单位未指定），状态 nc
DISK32_Status    | 0 unspecified     | nc    # 磁盘32状态传感器，数值为 0（单位未指定），状态 nc
DISK33_Status    | 0 unspecified     | nc    # 磁盘33状态传感器，数值为 0（单位未指定），状态 nc
DISK34_Status    | 0 unspecified     | nc    # 磁盘34状态传感器，数值为 0（单位未指定），状态 nc
DISK35_Status    | 0 unspecified     | nc    # 磁盘35状态传感器，数值为 0（单位未指定），状态 nc
DISK36_Status    | 0 unspecified     | nc    # 磁盘36状态传感器，数值为 0（单位未指定），状态 nc
DISK37_Status    | 0 unspecified     | nc    # 磁盘37状态传感器，数值为 0（单位未指定），状态 nc
DISK38_Status    | 0 unspecified     | nc    # 磁盘38状态传感器，数值为 0（单位未指定），状态 nc
DISK39_Status    | 0 unspecified     | nc    # 磁盘39状态传感器，数值为 0（单位未指定），状态 nc
DISK40_Status    | 0 unspecified     | nc    # 磁盘40状态传感器，数值为 0（单位未指定），状态 nc
DISK41_Status    | 0 unspecified     | nc    # 磁盘41状态传感器，数值为 0（单位未指定），状态 nc
DISK42_Status    | 0 unspecified     | nc    # 磁盘42状态传感器，数值为 0（单位未指定），状态 nc
DISK43_Status    | 0 unspecified     | nc    # 磁盘43状态传感器，数值为 0（单位未指定），状态 nc
DISK44_Status    | 0 unspecified     | nc    # 磁盘44状态传感器，数值为 0（单位未指定），状态 nc
DISK45_Status    | 0 unspecified     | nc    # 磁盘45状态传感器，数值为 0（单位未指定），状态 nc
DISK46_Status    | 0 unspecified     | nc    # 磁盘46状态传感器，数值为 0（单位未指定），状态 nc
DISK47_Status    | 0 unspecified     | nc    # 磁盘47状态传感器，数值为 0（单位未指定），状态 nc
DISK48_Status    | 0 unspecified     | nc    # 磁盘48状态传感器，数值为 0（单位未指定），状态 nc
DISK49_Status    | 0 unspecified     | nc    # 磁盘49状态传感器，数值为 0（单位未指定），状态 nc
DISK50_Status    | 0 unspecified     | nc    # 磁盘50状态传感器，数值为 0（单位未指定），状态 nc
DISK51_Status    | 0 unspecified     | nc    # 磁盘51状态传感器，数值为 0（单位未指定），状态 nc
DISK52_Status    | 0 unspecified     | nc    # 磁盘52状态传感器，数值为 0（单位未指定），状态 nc
DISK53_Status    | 0 unspecified     | nc    # 磁盘53状态传感器，数值为 0（单位未指定），状态 nc
DISK54_Status    | 0 unspecified     | nc    # 磁盘54状态传感器，数值为 0（单位未指定），状态 nc
DISK55_Status    | 0 unspecified     | nc    # 磁盘55状态传感器，数值为 0（单位未指定），状态 nc
DISK56_Status    | 0 unspecified     | nc    # 磁盘56状态传感器，数值为 0（单位未指定），状态 nc
DISK57_Status    | 0 unspecified     | nc    # 磁盘57状态传感器，数值为 0（单位未指定），状态 nc
DISK58_Status    | 0 unspecified     | nc    # 磁盘58状态传感器，数值为 0（单位未指定），状态 nc
DISK59_Status    | 0 unspecified     | nc    # 磁盘59状态传感器，数值为 0（单位未指定），状态 nc
DISKSSD1_Status  | 0 unspecified     | nc    # SSD 磁盘1状态传感器，数值为 0（单位未指定），状态 nc
DISKSSD2_Status  | 0 unspecified     | ok    # SSD 磁盘2状态传感器，数值为 0（单位未指定），状态正常
DISKSSD3_Status  | 0 unspecified     | ok    # SSD 磁盘3状态传感器，数值为 0（单位未指定），状态正常
DISKSSD4_Status  | 0 unspecified     | ok    # SSD 磁盘4状态传感器，数值为 0（单位未指定），状态正常
DISKSSD5_Status  | 0 unspecified     | ok    # SSD 磁盘5状态传感器，数值为 0（单位未指定），状态正常
DISKSSD6_Status  | 0 unspecified     | nc    # SSD 磁盘6状态传感器，数值为 0（单位未指定），状态 nc
FAN40_1_Present  | 0 unspecified     | cr    # 40mm 风扇1存在传感器，数值为 0（单位未指定），状态 cr（关键错误，可能未检测到风扇）
FAN40_2_Present  | 0 unspecified     | cr    # 40mm 风扇2存在传感器，数值为 0（单位未指定），状态 cr（关键错误）
FAN40_3_Present  | 0 unspecified     | cr    # 40mm 风扇3存在传感器，数值为 0（单位未指定），状态 cr（关键错误）
FAN40_4_Present  | 0 unspecified     | cr    # 40mm 风扇4存在传感器，数值为 0（单位未指定），状态 cr（关键错误）
FAN80_1_Present  | 0 unspecified     | cr    # 80mm 风扇1存在传感器，数值为 0（单位未指定），状态 cr（关键错误）
FAN80_2_Present  | 0 unspecified     | cr    # 80mm 风扇2存在传感器，数值为 0（单位未指定），状态 cr（关键错误）
FAN80_3_Present  | 0 unspecified     | cr    # 80mm 风扇3存在传感器，数值为 0（单位未指定），状态 cr（关键错误）
FAN80_4_Present  | 0 unspecified     | cr    # 80mm 风扇4存在传感器，数值为 0（单位未指定），状态 cr（关键错误）
HDD_Total_Power  | 384 Watts         | ok    # 硬盘总功率传感器，当前功率 384 瓦，状态正常
ExpR_12V         | 12.06 Volts       | ok    # 右侧 12V 传感器，当前电压 12.06V，状态正常
ExpL_12V         | 11.88 Volts       | ok    # 左侧 12V 传感器，当前电压 11.88V，状态正常
ExpR_5V          | 4.92 Volts        | ok    # 右侧 5V 传感器，当前电压 4.92V，状态正常
ExpL_5V          | 4.96 Volts        | ok    # 左侧 5V 传感器，当前电压 4.96V，状态正常
ExpR_3V3         | 3.28 Volts        | ok    # 右侧 3.3V 传感器，当前电压 3.28V，状态正常
ExpL_3V3         | 3.24 Volts        | ok    # 左侧 3.3V 传感器，当前电压 3.24V，状态正常
System_Status    | 0 unspecified     | ok    # 系统状态传感器，数值为 0（单位未指定），状态正常
P12V_AUX         | 12.12 Volts       | ok    # 辅助 12V 电源传感器，当前电压 12.12V，状态正常
P3V3_AUX         | 3.33 Volts        | ok    # 辅助 3.3V 电源传感器，当前电压 3.33V，状态正常
SYS_12V          | 12.06 Volts       | ok    # 系统 12V 电源传感器，当前电压 12.06V，状态正常
SYS_5V           | 4.97 Volts        | ok    # 系统 5V 电源传感器，当前电压 4.97V，状态正常
SYS_3.3V         | 3.33 Volts        | ok    # 系统 3.3V 电源传感器，当前电压 3.33V，状态正常
P1V8_CPU1        | 1.82 Volts        | ok    # CPU1 1.8V 电源传感器，当前电压 1.82V，状态正常
P1V8_CPU0        | 1.83 Volts        | ok    # CPU0 1.8V 电源传感器，当前电压 1.83V，状态正常
P3V_BAT_SOURCE   | 3.04 Volts        | ok    # 电池 3V 电源传感器，当前电压 3.04V，状态正常
SOC_AUX_CPU0     | 0.90 Volts        | ok    # CPU0 SoC 辅助电源传感器，当前电压 0.90V，状态正常
SOC_AUX_CPU1     | 0.90 Volts        | ok    # CPU1 SoC 辅助电源传感器，当前电压 0.90V，状态正常
PVPP_VR0_CPU0    | 2.53 Volts        | ok    # CPU0 电压调节器 PVPP 电压传感器，当前电压 2.53V，状态正常
PVPP_VR0_CPU1    | 2.51 Volts        | ok    # CPU1 电压调节器 PVPP 电压传感器，当前电压 2.51V，状态正常
PVDDQ_VR0_CPU0   | 1.24 Volts        | ok    # CPU0 电压调节器 PVDDQ 电压传感器，当前电压 1.24V，状态正常
PVDDQ_VR1_CPU0   | 1.24 Volts        | ok    # CPU0 第二路电压调节器 PVDDQ 电压传感器，当前电压 1.24V，状态正常
PVDDQ_VR0_CPU1   | 1.23 Volts        | ok    # CPU1 电压调节器 PVDDQ 电压传感器，当前电压 1.23V，状态正常
PVDDQ_VR1_CPU1   | 1.24 Volts        | ok    # CPU1 第二路电压调节器 PVDDQ 电压传感器，当前电压 1.24V，状态正常
MB_Inlet_Temp    | 33 degrees C      | ok    # 主板进风口温度传感器，当前温度 33°C，状态正常
Outlet_Temp      | 46 degrees C      | ok    # 出风口温度传感器，当前温度 46°C，状态正常
PVDDCR_CPU0      | 0.94 Volts        | ok    # CPU0 数字电压调节器 PVDDCR 电压传感器，当前电压 0.94V，状态正常
PVDDCR_SOC_CPU0  | 0.95 Volts        | ok    # CPU0 SoC PVDDCR 电压传感器，当前电压 0.95V，状态正常
PVDDCR_SOC_CPU1  | 0.96 Volts        | ok    # CPU1 SoC PVDDCR 电压传感器，当前电压 0.96V，状态正常
PVDDCR_CPU1      | 0.94 Volts        | ok    # CPU1 数字电压调节器 PVDDCR 电压传感器，当前电压 0.94V，状态正常
OCP_Temp         | disabled          | ns    # OCP 温度传感器（可能用于过流保护区域），已禁用，状态 ns（不支持/未采样）
IB_Temp          | 80 degrees C      | ok    # IB 温度传感器，当前温度 80°C，状态正常
ExpCore_Max_Temp | 47 degrees C      | ok    # 预期核心最大温度传感器，当前温度 47°C，状态正常
HDD_Max_Temp     | 47 degrees C      | ok    # 硬盘最大温度传感器，当前温度 47°C，状态正常
Inlet_Temp       | 27 degrees C      | ok    # 进气温度传感器，当前温度 27°C，状态正常
HBAZone_Max_Temp | 23 degrees C      | ok    # HBA 区域最大温度传感器（主机总线适配器），当前温度 23°C，状态正常
SATA_BP_Temp     | 26 degrees C      | ok    # SATA 背板温度传感器，当前温度 26°C，状态正常
MB_Power         | 260 Watts         | ok    # 主板功率传感器，当前功率 260 瓦，状态正常

```


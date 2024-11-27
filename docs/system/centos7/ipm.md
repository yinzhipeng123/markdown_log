



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

```
ipmitool power reset
```

重启服务器。

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

```
ipmitool raw 0x30 0x01
```

发送原始IPMI命令。`0x30 0x01` 是命令的具体数据，根据不同需求，可以执行各种底层IPMI操作。

### 14. **配置串行过LAN（SOL）**

```
ipmitool sol activate
```

启用串行过LAN（SOL）会话，允许远程通过串行接口访问服务器。

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
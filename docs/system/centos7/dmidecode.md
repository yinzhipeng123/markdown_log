# dmidecode命令

**dmidecode**是一种工具，用于以人类可读的格式转储计算机的DMI（有人说SMBIOS）表内容。此表包含系统硬件组件的说明，以及 其他有用的信息，例如序列号和 BIOS 修订版



```
Usage: dmidecode [选项]
Options are:
 -d, --dev-mem FILE     (default:/dev/mem)从设备文件读取信息，输出内容与不加参数标准输出相同。
 -h, --help             显示帮助信息。
 -q, --quiet            较少的详细输出
 -s, --string KEYWORD   只显示指定DMI字符串的信息。(string)
 -t, --type TYPE        只显示指定条目的信息。(type) type可以是DMI类型号，也可以是逗号分隔的类型号列表，或者是以下列表中的关键字：bios(bios)、系统(system)、基板(baseboard)、机箱(chassis)、处理器(processor)、内存(memory)、缓存(cache)、连接器(connector)、插槽(slot)。
 -H, --handle HANDLE    只显示给定句柄的条目
 -u, --dump             显示未解码的原始条目内容。
     --dump-bin FILE    将DMI数据转储到一个二进制文件中。
     --from-dump FILE   从一个二进制文件读取DMI数据。
     --no-sysfs         不要尝试从sysfs文件中读取DMI数据
     --oem-string N     仅显示给定OEM字符串的值
 -V, --version          显示版本并退出
 
 
 


-t 选项列表





```



### -s 选项列表

1. bios-vendor
2. bios-version
3. bios-release-date
4. system-manufacturer
5. system-product-name
6. system-version
7. system-serial-number
8. system-uuid
9. baseboard-manufacturer
10. baseboard-product-name
11. baseboard-version
12. baseboard-serial-number
13. baseboard-asset-tag
14. chassis-manufacturer
15. chassis-type
16. chassis-version
17. chassis-serial-number
18. chassis-asset-tag
19. processor-family
20. processor-manufacturer
21. processor-version
22. processor-frequency



### -t 选项列表

#### 字符串（关键字）

1. bios
2. system
3. baseboard
4. chassis
5. processor
6. memory
7. Cache
8. connector
9. slot

#### 数字（DMI类型号）

- 0        bios
- 1	System
- 2	Base Board
- 3	Chassis
- 4	Processor
- 5	Memory Controller
- 6	Memory Module
- 7	Cache
- 8	Port Connector
- 9	System Slots
- 10	On Board Devices
- 11	OEM Strings
- 12	System Configuration Options
- 13	BIOS Language
- 14	Group Associations
- 15	System Event Log
- 16	Physical Memory Array
- 17	Memory Device
- 18	32-bit Memory Error
- 19	Memory Array Mapped Address
- 20	Memory Device Mapped Address
- 21	Built-in Pointing Device
- 22	Portable Battery
- 23	System Reset
- 24	Hardware Security
- 25	System Power Controls
- 26	Voltage Probe
- 27	Cooling Device
- 28	Temperature Probe
- 29	Electrical Current Probe
- 30	Out-of-band Remote Access
- 31	Boot Integrity Services
- 32	System Boot
- 33	64-bit Memory Error
- 34	Management Device
- 35	Management Device Component
- 36	Management Device Threshold Data
- 37	Memory Channel
- 38	IPMI Device
- 39	Power Supply
- 40	Additional Information
- 41	Onboard Device





### MAN手册如下：

[dmidecode（8）： DMI 表解码器 - Linux 手册页 (die.net)](https://linux.die.net/man/8/dmidecode)

[dmidecode 命令，Linux dmidecode 命令详解：在Linux系统下获取有关硬件方面的信息 - Linux 命令搜索引擎 (wangchujiang.com)](https://wangchujiang.com/linux-command/c/dmidecode.html)









#### 查看服务器SN码

```bash
# dmidecode -t 1 
# dmidecode 2.12-dmifs
SMBIOS 2.8 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: New H3C Technologies Co., Ltd.
        Product Name: UniServer R4900 G3
        Version: To be filled by O.E.M.
        Serial Number: 211111111111111111
        UUID: 111111-2222-2222-2222-111111111111
        Wake-up Type: Power Switch
        SKU Number: 0
        Family: Rack
```


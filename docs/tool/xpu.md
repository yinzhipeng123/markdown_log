```
[root@xxxx ~]# xpu_smi --help
KUNLUNXIN 系统管理接口 -- v

XPUSMI 提供用于 KUNLUNXIN 设备的监控信息。
数据可以以纯文本或 XML 格式展示，通过标准输出或文件输出。
XPUSMI 还提供若干管理操作，用于更改设备状态。

注意：XPUSMI 的功能通过基于 C 的 XPUML 库暴露。
xpu-smi [选项1 [参数1]] [选项2 [参数2]] ...

    -h,   --help                显示使用信息并退出。

  列表选项：

    -L,   --list-xpus           显示系统中连接的 XPU 列表。

    -B,   --list-excluded-xpus  显示系统中被排除的 XPU 列表。

  概要选项：

    <无参数>                    显示系统中连接的 XPU 概要。

    [以及以下任意选项]

    -i,   --id=                 指定目标 XPU。
    -f,   --filename=           将日志写入指定文件，而不是标准输出。
    -l,   --loop=               按指定的秒数间隔循环探测，直到按 Ctrl+C 终止。

  查询选项：

    -q,   --query               显示 XPU 信息。

    -m,   --machine-readable    以机器可读的格式显示 XPU 信息。每行依次打印以下项目：
                                    0  : pci_addr
                                    1  : board_id
                                    2  : dev_id
                                    3  : sn
                                    4  : 温度
                                    5  : - 总是 0
                                    6  : 内存温度
                                    7  : - 总是 0
                                    8  : 功耗 (W)
                                    9  : freq_0
                                    10 : freq_1
                                    11 : freq_2
                                    12 : freq_3
                                    13 : freq_4
                                    14 : freq_5
                                    15 : L3 已使用 (MB)
                                    16 : L3 总大小 (MB)
                                    17 : 内存已使用 (MB)
                                    18 : 内存总大小 (MB)
                                    19 : 使用率 [0, 100]
                                    20 : 固件版本 [v_init:v_bootloader:v_main.v_cpld]
                                    21 : 型号
                                    22 : 板载芯片索引
                                    23 : 解码比率
                                    24 : 编码比率
                                    25 : 处理比率
                                    26 : 解码帧率
                                    27 : 编码帧率
                                    28 : 处理帧率
                                    29 : 解码时钟
                                    30 : 编码时钟
                                    31 : 处理时钟

    [以及以下任意选项]

    -i,   --id=                 指定目标 XPU。
    -f,   --filename=           将日志写入指定文件，而不是标准输出。
    -x,   --xml-format          生成 XML 格式输出。
    -d,   --display=            仅显示选定信息：MEMORY、UTILIZATION、ECC、TEMPERATURE、POWER、CLOCK、
                                    COMPUTE、PIDS
                                标志可以用逗号组合，例如 ECC,POWER。
                                采样数据的最大/最小/平均值也会返回用于 POWER、UTILIZATION 和 CLOCK 显示类型。
                                与 -x 标志不兼容。
    -l,   --loop=               按指定的秒数间隔循环探测，直到按 Ctrl+C 终止。

    -lms, --loop-ms=            按指定的毫秒间隔循环探测，直到按 Ctrl+C 终止。

  设备修改选项：

    [以下任意选项之一]

    -r    --xpu-reset           触发 XPU 重置。
                                在某些情况下（如发生双比特 ECC 错误）可以用于重置 XPU 硬件状态，
                                否则可能需要重启机器。
                                重置操作并不能保证在所有情况下都有效，应谨慎使用。
    -V    --set-sriov-numvfs    设置 XPU 的 VF 数量。
                                只有在运行于虚拟机管理程序上时，才能设置 XPU 的 numvfs。

   [以及可选参数]

    -i,   --id=                 指定目标 XPU。
    -eow, --error-on-warning    对警告返回非零错误码。

 拓扑选项：
    topo                        显示设备/系统拓扑信息。输入 "xpu-smi topo -h" 以查看更多信息。

 XPULINK：
    xpulink                     显示设备 xpulink 信息。输入 "xpu-smi xpulink -h" 以查看更多信息。

有关更详细的信息，请参阅 xpu-smi(1) 手册页。
```





`xpu-smi` 是用于管理和监控 KUNLUNXIN（华为自研的加速卡）设备的命令行工具。它类似于 NVIDIA 的 `nvidia-smi`，用于监控加速卡（如 XPU）的状态、性能和配置。

下面是一些常用的 `xpu-smi` 命令及其功能：

### 常用命令

1. **查看系统中所有 XPU 设备的概况：**
   
   ```bash
   xpu-smi
   ```
   
   - 该命令会显示系统中连接的所有 XPU 的简要信息，包括设备的温度、功率、频率等。

2. **列出所有连接的 XPU：**
   
   ```bash
   xpu-smi --list-xpus
   ```
   
   - 显示当前系统中所有连接的 XPU 设备列表。

3. **列出被排除的 XPU：**
   
   ```bash
   xpu-smi --list-excluded-xpus
   ```
   
   - 显示系统中被排除的 XPU 列表。

4. **查询特定 XPU 的详细信息：**
   
   ```bash
   xpu-smi --query
   ```
   
   - 显示有关所有 XPU 的详细信息，包括温度、功耗、频率等。你也可以通过加上 `--id` 参数来查询特定的 XPU 信息。
   
   ```bash
   xpu-smi --query --id=<XPU_ID>
   ```

5. **以机器可读的格式输出 XPU 信息：**
   
   ```bash
   xpu-smi --machine-readable
   ```
   
   - 以机器可读的格式输出信息，适合用于后续的数据处理或脚本。

6. **按指定的时间间隔循环显示 XPU 状态（例如每 1 秒刷新一次）：**
   
   ```bash
   xpu-smi --loop=1
   ```
   
   - 该命令会每秒钟刷新一次设备状态，直到按 `Ctrl+C` 停止。

7. **查看特定类型的信息（如内存、温度、功率等）：**
   
   ```bash
   xpu-smi --display=MEMORY,TEMPERATURE,POWER
   ```
   
   - 显示指定的设备信息类型，如内存使用情况、温度、功率等。你可以组合多个信息类型，使用逗号分隔。

8. **生成 XML 格式输出：**
   
   ```bash
   xpu-smi --xml-format
   ```
   
   - 输出结果为 XML 格式，便于进一步处理和自动化。

9. **重置 XPU（例如，在发生 ECC 错误时重置 XPU）：**
   
   ```bash
   xpu-smi --xpu-reset --id=<XPU_ID>
   ```
   
   - 触发 XPU 设备的重置，通常用于恢复设备的正常状态。

10. **设置 XPU 的虚拟功能（VF）数量：**
    
    ```bash
    xpu-smi --set-sriov-numvfs=4 --id=<XPU_ID>
    ```
    
    - 设置 XPU 设备的虚拟功能（VF）数量，这在虚拟化环境中使用时非常有用。

### 一些进阶用法

- **查看拓扑信息（设备和系统的拓扑结构）：**
  
  ```bash
  xpu-smi topo
  ```
  
  - 显示设备的拓扑信息，可以帮助你了解各个设备之间的连接关系。

- **查看 XPU 之间的链路信息：**
  
  ```bash
  xpu-smi xpulink
  ```
  
  - 显示 XPU 之间的链路信息，适用于多设备间的连接检查。

### 使用帮助

如果你需要详细了解某个选项或命令，可以使用 `--help` 来查看命令的帮助信息：

```bash
xpu-smi --help
```

或者，针对具体功能：

```bash
xpu-smi topo --help
xpu-smi xpulink --help
```

这些命令可以帮助你监控和管理 KUNLUNXIN 加速卡，确保它们的健康和性能。









```
# xpu-smi
+-----------------------------------------------------------------------------+
| XPU-SMI               Driver Version: 5.0.21.26    XPU-RT Version: 5.0.21   |
|-------------------------------+----------------------+----------------------+
| XPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | XPU-Util  Compute M. |
|                               |             L3-Usage |            SR-IOV M. |
|===============================+======================+======================|
|   0  P800 OAM           N/A   | 00000000:52:00.0 N/A |                    0 |
| N/A   38C  N/A     85W / 400W |      0MiB / 98304MiB |      0%      Default |
|                               |      0MiB /    96MiB |             Disabled |
+-------------------------------+----------------------+----------------------+
|   1  P800 OAM           N/A   | 00000000:55:00.0 N/A |                    0 |
| N/A   40C  N/A     84W / 400W |      0MiB / 98304MiB |      0%      Default |
|                               |      0MiB /    96MiB |             Disabled |
+-------------------------------+----------------------+----------------------+
|   2  P800 OAM           N/A   | 00000000:63:00.0 N/A |                    0 |
| N/A   45C  N/A     86W / 400W |      0MiB / 98304MiB |      0%      Default |
|                               |      0MiB /    96MiB |             Disabled |
+-------------------------------+----------------------+----------------------+
|   3  P800 OAM           N/A   | 00000000:66:00.0 N/A |                    0 |
| N/A   44C  N/A     86W / 400W |      0MiB / 98304MiB |      0%      Default |
|                               |      0MiB /    96MiB |             Disabled |
+-------------------------------+----------------------+----------------------+
|   4  P800 OAM           N/A   | 00000000:9A:00.0 N/A |                    0 |
| N/A   49C  N/A     89W / 400W |      0MiB / 98304MiB |      0%      Default |
|                               |      0MiB /    96MiB |             Disabled |
+-------------------------------+----------------------+----------------------+
|   5  P800 OAM           N/A   | 00000000:9B:00.0 N/A |                    0 |
| N/A   41C  N/A     85W / 400W |      0MiB / 98304MiB |      0%      Default |
|                               |      0MiB /    96MiB |             Disabled |
+-------------------------------+----------------------+----------------------+
|   6  P800 OAM           N/A   | 00000000:AA:00.0 N/A |                    0 |
| N/A   43C  N/A     85W / 400W |      0MiB / 98304MiB |      0%      Default |
|                               |      0MiB /    96MiB |             Disabled |
+-------------------------------+----------------------+----------------------+
|   7  P800 OAM           N/A   | 00000000:AB:00.0 N/A |                    0 |
| N/A   42C  N/A     88W / 400W |      0MiB / 98304MiB |      0%      Default |
|                               |      0MiB /    96MiB |             Disabled |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  XPU   XI   CI        PID   Type   Process name                  XPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```



- **XPU**: XPU 的索引编号，从 0 开始。

- **Name**: XPU 的型号名称（例如 `P800 OAM`）。

- **Persistence-M**: 持久模式（Persistence Mode）。表示是否启用持久模式，用于保持设备状态以减少初始化开销。`N/A` 表示未启用。

- **Bus-Id**: XPU 的 PCI 总线地址，格式为 `域:总线:设备.功能`（例如 `00000000:03:00.0`），标识 XPU 在系统中的位置。

- **Disp.A**: 显示适配器状态。`N/A` 表示此设备不是显示设备或未应用显示适配器功能。

- **Volatile Uncorr. ECC**: 易失性未更正 ECC（Error Correction Code）错误的数量，通常为 `0` 表示未发生未更正的 ECC 错误。

- **Fan**: 风扇转速或状态，通常显示转速数值；`N/A` 表示无风扇或不适用。

- **Temp**: XPU 当前温度（单位：摄氏度）。

- **Perf**: 性能模式或状态，可能为 `Default` 或其他自定义值，`N/A` 表示没有设置。

- **Pwr:Usage/Cap**: XPU 的功耗信息：
  - [ ] **Usage**: 当前实际功耗（单位：瓦特）。
  - [ ] **Cap**: 最大允许功耗（单位：瓦特）。
  
- **Memory-Usage**: XPU 的全局内存使用情况，格式为 `已使用内存 / 总内存`（例如 `0MiB / 98304MiB` 表示总内存 98304MiB，当前未使用）。

- **L3-Usage**: L3 缓存的使用情况，格式为 `已使用缓存 / 总缓存`（例如 `0MiB / 96MiB` 表示总缓存 96MiB，当前未使用）。
- **SR-IOV M**: SR-IOV（单根 I/O 虚拟化）模式状态：
  - [ ] **Disabled**: 未启用 SR-IOV 功能。
  - [ ] **Enabled**: 表示启用了虚拟化支持，用于将单个设备分割成多个虚拟设备。

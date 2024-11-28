# FIO命令

以下是 `fio` 命令的帮助信息翻译：

```
fio-3.35
fio [选项] [作业选项] <作业文件(s)>
  --debug=选项          启用调试日志。可以是以下之一或多个：
                        process, file, io, mem, blktrace, verify, random, parse,
                        diskutil, job, mutex, profile, time, net, rate, compress,
                        steadystate, helperthread, zbd
  --parse-only          仅解析选项，不开始任何 IO
  --merge-blktrace-only 仅合并 blktrace，不开始任何 IO
  --output              输出写入文件
  --bandwidth-log       生成汇总带宽日志
  --minimal             最小（简洁）输出
  --output-format=type  输出格式（terse, json, json+, normal）
  --terse-version=type  设置简洁输出格式的版本（默认为 3，或者 2、4 或 5）
  --version             输出版本信息并退出
  --help                打印此页面
  --cpuclock-test       执行 CPU 时钟的测试/验证
  --crctest=[type]      测试校验和函数的速度
  --cmdhelp=cmd         打印命令帮助，“all”表示列出所有命令
  --enghelp=engine      打印 ioengine 帮助，或者列出可用的 ioengines
  --enghelp=engine,cmd  打印某个 ioengine 命令的帮助
  --showcmd             将作业文件转换为命令行选项
  --eta=when            设置 ETA 估算显示时机
                        可选值： "always", "never" 或 "auto"
  --eta-newline=t       强制每个 't' 周期输出一个新的行
  --status-interval=t   强制每隔 't' 周期输出完整的状态信息
  --readonly            开启安全的只读检查，防止写操作
  --section=name        仅运行作业文件中的指定部分，可以指定多个部分
  --alloc-size=kb       设置 smalloc 池的大小（单位：KB，默认值 16384）
  --warnings-fatal      fio 解析器警告视为致命错误
  --max-jobs=nr         支持的最大线程/进程数
  --server=args         启动后端 fio 服务器
  --daemonize=pidfile   将 fio 服务器在后台运行，并将 pid 写入文件
  --client=hostname     与远程后端 fio 服务器通信
  --remote-config=file  告诉 fio 服务器加载此本地作业文件
  --idle-prof=option    报告系统或每个 CPU 的空闲情况（option=system, percpu）或仅运行单元工作标定（option=calibrate）
  --inflate-log=log     解压并输出压缩日志
  --trigger-file=file   当文件存在时执行触发命令
  --trigger-timeout=t   在此时间后执行触发命令
  --trigger=cmd         设置本地触发命令
  --trigger-remote=cmd  设置远程触发命令
  --aux-path=path       使用此路径保存 fio 状态生成的文件

Fio 由 Jens Axboe 编写 <axboe@kernel.dk>
```



## 常见用法



### 1. **基本的读写测试**

- **顺序读取测试：**

  ```bash
  fio --name=read_test --ioengine=sync --rw=read --size=1G --numjobs=1 --time_based --runtime=30s --output=read_test.log
  ```

  这个命令会对一个 1GB 的文件进行顺序读取测试，持续 30 秒。

- **顺序写入测试：**

  ```bash
  fio --name=write_test --ioengine=sync --rw=write --size=1G --numjobs=1 --time_based --runtime=30s --output=write_test.log
  ```

  这个命令会对一个 1GB 的文件进行顺序写入测试，持续 30 秒。

### 2. **随机读写测试**

- **随机读取测试：**

  ```bash
  fio --name=random_read --ioengine=sync --rw=randread --size=1G --numjobs=1 --time_based --runtime=30s --output=random_read.log
  ```

  这个命令会对 1GB 文件进行随机读取测试，持续 30 秒。

- **随机写入测试：**

  ```bash
  fio --name=random_write --ioengine=sync --rw=randwrite --size=1G --numjobs=1 --time_based --runtime=30s --output=random_write.log
  ```

  这个命令会对 1GB 文件进行随机写入测试，持续 30 秒。

### 3. **多线程测试**

- **并发读取测试：**

  ```bash
  fio --name=multi_read --ioengine=sync --rw=read --size=1G --numjobs=4 --time_based --runtime=30s --output=multi_read.log
  ```

  这个命令会对 1GB 文件进行 4 线程的并发读取测试，持续 30 秒。

- **并发写入测试：**

  ```bash
  fio --name=multi_write --ioengine=sync --rw=write --size=1G --numjobs=4 --time_based --runtime=30s --output=multi_write.log
  ```

  这个命令会对 1GB 文件进行 4 线程的并发写入测试，持续 30 秒。

### 4. **混合读写测试**

- 50/50 混合读写：

  ```bash
  fio --name=mixed_readwrite --ioengine=sync --rw=randwrite --size=1G --numjobs=1 --time_based --runtime=30s --output=mixed_readwrite.log --bs=4k --rwmixread=50
  ```

  这个命令会进行 50% 读取和 50% 写入的混合测试，块大小为 4KB。

### 5. **指定 I/O 引擎**

- 使用 `libaio` 引擎进行异步 I/O 测试：

  ```bash
  fio --name=async_read --ioengine=libaio --rw=read --size=1G --numjobs=1 --time_based --runtime=30s --output=async_read.log
  ```

  这个命令使用 

  ```
  libaio
  ```

   引擎进行异步读取测试。

### 6. **指定 I/O 大小（块大小）**

- 设置 4KB 块大小的读写测试：

  ```bash
  fio --name=block_size_test --ioengine=sync --rw=randwrite --size=1G --numjobs=1 --time_based --runtime=30s --output=block_size_test.log --bs=4k
  ```

  这个命令使用 4KB 的块大小进行随机写入测试。

### 7. **IOPS 测试**

- 测试 IOPS（每秒 I/O 操作次数）：

  ```bash
  fio --name=iops_test --ioengine=sync --rw=randwrite --size=1G --numjobs=1 --time_based --runtime=30s --output=iops_test.log --blocksize=4k
  ```

  通过指定较小的块大小 (如 4KB)，可以测试每秒的 I/O 操作次数（IOPS）。

### 8. **多作业文件测试**

- 测试多个文件：

  ```bash
  fio --name=multi_file_test --ioengine=sync --rw=randwrite --size=500M --numjobs=4 --time_based --runtime=30s --output=multi_file_test.log
  ```

  这个命令会进行 4 个线程同时对多个 500MB 文件进行随机写入测试。

### 9. **指定作业文件**

- **使用作业文件进行测试：** 你可以将作业配置放在一个文件中，然后通过文件运行测试。

  **jobfile.fio**

  ```ini
  [global]
  ioengine=sync
  time_based
  runtime=30s
  size=1G
  
  [readtest]
  rw=read
  
  [writetest]
  rw=write
  ```

  运行：

  ```bash
  fio jobfile.fio
  ```

### 10. **显示详细统计信息**

- 显示每个线程的统计数据：

  ```bash
  fio --name=read_test --ioengine=sync --rw=read --size=1G --numjobs=4 --time_based --runtime=30s --output-format=normal
  ```

  这个命令会显示详细的测试结果，包括每个线程的性能数据。

### 11. **带宽日志**

- 生成带宽日志：

  ```bash
  fio --name=bandwidth_test --ioengine=sync --rw=read --size=1G --numjobs=4 --time_based --runtime=30s --bandwidth-log=bandwidth.log
  ```

  该命令会生成带宽日志，用于后续分析带宽性能。

## 参数

`fio` 是一个非常强大的性能测试工具，适用于对存储系统、磁盘、SSD 或网络存储进行基准测试。它提供了很多选项，用于灵活地配置不同类型的测试。以下是一些常用的 `fio` 选项，帮助你快速上手：

### 1. **常用参数**

- **`--name`**
   指定作业的名称。每个作业应该有一个唯一的名称，通常在作业文件中定义。
   示例：`--name=mytest`
- **`--ioengine`**
   指定 I/O 引擎（也就是测试使用的驱动程序）。常见的引擎有：
  - `sync`：同步 I/O（默认）。
  - `libaio`：Linux 异步 I/O。
  - `mmap`：内存映射 I/O。
  - `pvsync`：同步 I/O，逐个块写入。 示例：`--ioengine=libaio`
- **`--rw`**
   指定 I/O 模式（Read/Write）。常见的模式包括：
  - `read`：只读。
  - `write`：只写。
  - `randwrite`：随机写入。
  - `randread`：随机读取。
  - `writewithread`：读写混合。
  - `randwritewithrandread`：随机读写混合。 示例：`--rw=randwrite`
- **`--bs`**
   设置块大小（Block Size）。单位可以是字节、KB、MB 等，例如：`4k`、`128k`。
   示例：`--bs=4k`
- **`--size`**
   设置每个作业的文件大小。通常用于测试文件的大小，例如 `1G`。
   示例：`--size=1G`
- **`--numjobs`**
   设置并行作业的数量（即并发线程数）。
   示例：`--numjobs=4`  （4 个并行作业）
- **`--runtime`**
   设置测试运行的持续时间。可以使用单位（例如秒，`s`）。
   示例：`--runtime=30m`（运行 30 分钟）
- **`--time_based`**
   指定基于时间的测试（通常与 `--runtime` 一起使用）。如果指定此选项，`fio` 将持续运行直到达到指定的时间，而不是通过文件大小来确定结束。
   示例：`--time_based`
- **`--iodepth`**
   设置 I/O 深度（每个作业队列中的 I/O 请求数）。较高的 I/O 深度适用于测试高负载环境。
   示例：`--iodepth=16`
- **`--output`**
   指定输出结果保存的文件名。
   示例：`--output=fio_results.txt`
- **`--output-format`**
   设置输出格式。常见的格式有：
  - `normal`：标准输出（默认）。
  - `json`：JSON 格式。
  - `json+`：带有额外详细信息的 JSON 格式。
  - `terse`：简洁输出。 示例：`--output-format=json`
- **`--runtime`**
   设置测试的持续时间。
   示例：`--runtime=60s`（持续 60 秒）
- **`--blocksize`**
   设置每个 I/O 操作的大小。
   示例：`--blocksize=4k`
- **`--numjobs`**
   设置运行多少个并行作业。
   示例：`--numjobs=4`

### 2. **其他常用选项**

- **`--verify`**
   启用数据验证。默认情况下，`fio` 只进行性能测试，如果启用此选项，`fio` 会在写入数据后对数据进行验证，确保没有错误。
   示例：`--verify=md5`
- **`--io_size`**
   设置单个线程的总 I/O 操作大小。
   示例：`--io_size=1G`
- **`--direct`**
   指定是否绕过文件系统缓存，直接对磁盘进行操作。使用该选项可以测试存储设备的原始性能。
   示例：`--direct=1`（启用直接 I/O）
- **`--runtime`**
   设置测试运行的时间长度。例如，可以设置为 10 分钟：
   示例：`--runtime=10m`
- **`--group_reporting`**
   启用分组报告。此选项使得多个作业的结果可以在一行中报告，便于比较。
   示例：`--group_reporting`
- **`--latency`**
   打印出延迟的详细信息。
   示例：`--latency`
- **`--trim`**
   对存储设备进行修整操作，这对 SSD 测试尤为重要。
   示例：`--trim=1`（启用修整操作）
- **`--numjobs`**
   设置并行作业的数量，控制线程的数量。
   示例：`--numjobs=4`（启动 4 个作业）

### 3. **高级选项**

- **`--rate`**
   控制 I/O 操作的速率。例如设置为 10 MB/s：
   示例：`--rate=10M`
- **`--runtime`**
   设置作业的最大运行时间，单位为秒（s），分钟（m）等。
   示例：`--runtime=60m`
- **`--time_based`**
   表示测试是时间为基础，而不是根据文件大小来停止。
   示例：`--time_based`
- **`--write_bw_log`**
   用于生成写操作带宽日志。
   示例：`--write_bw_log=write_bw_log`
- **`--bandwidth-log`**
   生成带宽汇总日志。
   示例：`--bandwidth-log`

------

### 示例命令：

1. **基本的随机写入测试：**

   ```bash
   fio --name=randwrite --ioengine=libaio --rw=randwrite --bs=4k --size=1G --numjobs=4 --runtime=30m --output=result.txt
   ```

2. **基于时间的顺序读取测试：**

   ```bash
   fio --name=seqread --ioengine=sync --rw=read --bs=128k --size=10G --time_based --runtime=1h --output=result.txt
   ```

3. **并行测试与结果汇总：**

   ```bash
   fio --name=multi --ioengine=sync --rw=write --bs=8k --size=1G --numjobs=8 --runtime=10m --group_reporting --output=result.txt
   ```

4. **带有数据验证的随机写入测试：**

   ```bash
   fio --name=randwrite_verify --ioengine=sync --rw=randwrite --bs=4k --size=2G --numjobs=2 --verify=md5 --runtime=15m --output=result_verify.txt
   ```


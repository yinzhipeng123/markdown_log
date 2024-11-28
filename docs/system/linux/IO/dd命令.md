# DD命令

以下是 `dd` 命令帮助信息的中文翻译：

```bash
用法: dd [操作数]...
  或:  dd 选项
复制文件，按操作数转换和格式化。

  bs=字节数        每次读写最多字节数（默认为512）；会覆盖 ibs 和 obs 设置
  cbs=字节数       每次转换字节数
  conv=转换选项    按逗号分隔的符号列表转换文件
  count=数量       只复制 N 个输入块
  ibs=字节数       每次读最多字节数（默认为512）
  if=文件名        从文件读取数据，而不是从标准输入
  iflag=标志       按逗号分隔的符号列表读取
  obs=字节数       每次写最多字节数（默认为512）
  of=文件名        将数据写入文件，而不是标准输出
  oflag=标志       按逗号分隔的符号列表写入
  seek=数量        输出开始跳过 N 个 obs 大小的块
  skip=数量        输入开始跳过 N 个 ibs 大小的块
  status=级别      控制输出到标准错误的信息级别；
                  'none' 只显示错误信息，
                  'noxfer' 不显示最终传输统计信息，
                  'progress' 显示周期性传输统计信息

N 和字节数可以使用以下乘法后缀：
c=1, w=2, b=512, kB=1000, K=1024, MB=1000*1000, M=1024*1024, xM=M,
GB=1000*1000*1000, G=1024*1024*1024，依此类推，直到 T、P、E、Z、Y。
也可以使用二进制前缀，如 KiB=K, MiB=M 等。

每个转换符号可以是：

  ascii     从 EBCDIC 转换为 ASCII
  ebcdic    从 ASCII 转换为 EBCDIC
  ibm       从 ASCII 转换为替代 EBCDIC
  block     用空格填充换行符结尾的记录到 cbs 大小
  unblock   将 cbs 大小记录末尾的空格替换为换行符
  lcase     将大写字母转为小写字母
  ucase     将小写字母转为大写字母
  sparse    尝试跳过而不是写入所有 NUL 填充的输出块
  swab      每对输入字节交换
  sync      用 NUL 填充每个输入块到 ibs 大小；与 block 或 unblock 一起使用时，用空格代替 NUL
  excl      如果输出文件已存在则失败
  nocreat   不创建输出文件
  notrunc   不截断输出文件
  noerror   遇到读取错误时继续
  fdatasync  在完成之前物理写入输出文件数据
  fsync     同样，但也写入元数据

每个标志符号可以是：

  append    追加模式（仅对输出有意义；建议使用 conv=notrunc）
  direct    使用直接 I/O 进行数据传输
  directory  如果目标是目录则失败
  dsync     使用同步 I/O 进行数据传输
  sync      同样，但也包括元数据
  fullblock  累积完整的输入块（仅限 iflag）
  nonblock  使用非阻塞 I/O
  noatime   不更新访问时间
  nocache   请求丢弃缓存。也可以使用 oflag=sync
  noctty    不将控制终端分配给文件
  nofollow  不跟随符号链接
  count_bytes  将 'count=N' 视为字节数（仅限 iflag）
  skip_bytes  将 'skip=N' 视为字节数（仅限 iflag）
  seek_bytes  将 'seek=N' 视为字节数（仅限 oflag）

向正在运行的 'dd' 进程发送 USR1 信号会使其
打印 I/O 统计信息到标准错误，然后继续复制。

选项有：

      --help     显示此帮助信息并退出
      --version  输出版本信息并退出

GNU coreutils 在线帮助：<https://www.gnu.org/software/coreutils/>
完整文档：<https://www.gnu.org/software/coreutils/dd>
或者可以通过：info '(coreutils) dd invocation' 本地查看
```



## DD常用用法

`dd` 命令是一个非常强大的工具，常用于文件操作和数据备份，特别是在低级别的文件复制、转换以及备份和恢复等任务中。以下是一些常见的 `dd` 用法：

### 1. **复制磁盘或分区**

用 `dd` 可以将整个磁盘或分区内容进行完整复制，常用于备份或者克隆操作。

```bash
dd if=/dev/sda of=/dev/sdb bs=64K
```

- [ ] `if` 是输入文件，可以是设备文件（如 `/dev/sda` 表示源磁盘）。
- [ ] `of` 是输出文件，可以是另一个设备文件（如 `/dev/sdb` 表示目标磁盘）。
- [ ] `bs` 是块大小，这里设置为 64K。

### 2. **创建磁盘镜像备份**

你可以使用 `dd` 将整个磁盘或分区内容备份到一个镜像文件。

```bash
dd if=/dev/sda of=/path/to/backup.img bs=4M
```

- [ ] 这会将 `/dev/sda` 的内容备份到 `backup.img` 文件中。

### 3. **恢复磁盘镜像备份**

将镜像文件恢复到磁盘或分区。

```bash
dd if=/path/to/backup.img of=/dev/sda bs=4M
```

- [ ] 这里会将镜像文件 `backup.img` 恢复到 `/dev/sda`。

### 4. **制作启动盘**

使用 `dd` 将 ISO 文件写入 USB 设备，创建启动盘。

```bash
dd if=/path/to/distro.iso of=/dev/sdX bs=4M status=progress
```

- [ ] `if` 是 ISO 文件路径。
- [ ] `of` 是目标设备（如 USB 设备 `/dev/sdX`）。
- [ ] `status=progress` 用于显示复制进度。

### 5. **转换文件格式**

`dd` 可以用来将文件转换成不同的编码格式（例如 ASCII 和 EBCDIC 之间的转换）。

```bash
dd if=input.txt of=output.txt conv=ascii
```

- [ ] `conv=ascii` 选项表示将输入文件从 EBCDIC 转换为 ASCII 格式。

### 6. **数据擦除**

你可以使用 `dd` 来擦除磁盘上的数据（例如将其填充为零或随机数据）。

```bash
dd if=/dev/zero of=/dev/sda bs=1M
```

- [ ] `if=/dev/zero` 会将设备内容写入零，以此实现擦除。

或者使用随机数据擦除：

```bash
dd if=/dev/urandom of=/dev/sda bs=1M
```

### 7. **生成文件的随机数据**

- [ ] 使用 `/dev/urandom` 来生成随机数据，并将其写入文件。

```bash
dd if=/dev/urandom of=/path/to/file bs=1M count=10
```

- [ ] 这会生成 10MB 的随机数据并保存到指定的文件中。

### 8. **按块大小调整复制速度**

`dd` 可以使用不同的块大小来优化读写速度。常见的块大小有 512B、4K、64K 等。

```bash
dd if=input_file of=output_file bs=64K
```

- [ ] 这里 `bs=64K` 可以提高大文件复制的效率，尤其在磁盘 I/O 速度较快的情况下。

### 9. **显示进度**

使用 `status=progress` 显示复制过程中的进度信息：

```bash
dd if=/path/to/large_file of=/dev/sda bs=4M status=progress
```

### 10. **创建空白文件**

你可以使用 `dd` 创建指定大小的空白文件，通常用于测试或占位。

```bash
dd if=/dev/zero of=empty_file bs=1M count=100
```

- [ ] 这将创建一个大小为 100MB 的空白文件 `empty_file`。

### 11. **提取磁盘的某一部分**

通过设置 `seek` 和 `skip` 选项，你可以从磁盘或文件中提取特定的数据块。

```bash
dd if=/dev/sda of=partition.img bs=512 skip=1000 count=500
```

- [ ] `skip=1000` 表示跳过输入文件的前 1000 个块。
- [ ] `count=500` 表示复制 500 个块。

------

## DD命令测试IO性能

`dd` 命令可以用来测试磁盘或文件系统的 I/O 性能，特别是在测试读写速度时非常有用。你可以通过创建和写入大文件来测试写入性能，通过从文件中读取数据来测试读取性能。

### 1. **测试磁盘写入性能**

你可以使用 `dd` 将数据写入磁盘，计算每秒写入的数据量，从而评估磁盘的写入性能。例如，使用 `/dev/zero` 来生成零数据写入磁盘：

```bash
dd if=/dev/zero of=/path/to/output_file bs=1M count=1024 oflag=direct
```

- [ ] `if=/dev/zero`：输入文件为 `/dev/zero`，它会生成无限的零字节。
- [ ] `of=/path/to/output_file`：指定输出文件路径。
- [ ] `bs=1M`：每个块的大小为 1MB，设置较大的块大小通常能更准确地反映磁盘性能。
- [ ] `count=1024`：总共写入 1024 个 1MB 的块，即 1GB 的数据。
- [ ] `oflag=direct`：使用直接 I/O（绕过操作系统缓存），从而测试磁盘的原始写入性能。

运行后，`dd` 会输出写入操作的统计信息，包括写入的总字节数、时间和写入速度（如 MB/s）。

### 2. **测试磁盘读取性能**

同样，可以使用 `dd` 从文件或设备读取数据并测试读取速度：

```bash
dd if=/path/to/output_file of=/dev/null bs=1M
```

- [ ] `if=/path/to/output_file`：从之前写入的文件中读取数据。
- [ ] `of=/dev/null`：将数据输出到 `/dev/null`，即丢弃数据，只关注读取速度。
- [ ] `bs=1M`：每次读取 1MB 数据块。

这将测试文件系统的读取性能，输出读取的总字节数、时间和读取速度（如 MB/s）。

### 3. **显示实时进度**

在进行性能测试时，建议使用 `status=progress` 选项，这样 `dd` 会定期显示当前进度，例如：

```bash
dd if=/dev/zero of=/path/to/output_file bs=1M count=1024 oflag=direct status=progress
```

`status=progress` 会显示复制过程中的实时数据传输情况，帮助你了解当前的写入速度和已完成的数据量。

### 4. **测试磁盘 I/O 性能的不同块大小**

通过改变 `bs`（块大小）的值，你可以测试不同块大小对性能的影响。一般来说，较大的块大小能提高性能，尤其是在快速磁盘上。你可以尝试不同的 `bs` 值，比如：

- [ ] 4K（小块）
- [ ] 64K（中块）
- [ ] 1M（大块）

例如：

```bash
dd if=/dev/zero of=/path/to/output_file bs=4K count=256K oflag=direct status=progress
dd if=/dev/zero of=/path/to/output_file bs=64K count=256K oflag=direct status=progress
dd if=/dev/zero of=/path/to/output_file bs=1M count=256K oflag=direct status=progress
```

### 5. **测试随机读取/写入性能**

如果你需要测试随机读写性能，`dd` 命令并不是最合适的工具，因为它本质上是顺序读写。但你可以通过使用 `seek` 和 `skip` 来模拟随机读取和写入。

例如，测试从文件的不同位置进行读取（模拟随机读取）：

```bash
dd if=/path/to/output_file of=/dev/null bs=1M skip=1000 count=100 oflag=direct status=progress
```

- [ ] `skip=1000`：跳过文件的前 1000 个 1MB 块，模拟从文件的中间部分开始读取。
- [ ] `count=100`：读取 100 个 1MB 的块。

### 6. **综合 I/O 性能测试**

如果你想同时测试读取和写入性能（例如，测试磁盘的整体性能），可以同时使用 `dd` 进行读写操作，这样可以模拟更真实的磁盘负载。

```bash
dd if=/dev/zero of=/path/to/output_file bs=1M count=1024 oflag=direct & dd if=/path/to/output_file of=/dev/null bs=1M status=progress
```

此命令会在后台启动一个写入进程，并且主进程会进行读取，从而同时测试读写性能。

------

### 结果解释

`dd` 命令的输出会显示一些关键的性能指标，以下是一个典型输出示例：

```bash
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1024 MiB) copied, 5.24509 s, 205 MB/s
```

- [ ] `1024+0 records in`：读取了 1024 个 1MB 块。
- [ ] `1024+0 records out`：写入了 1024 个 1MB 块。
- [ ] `1073741824 bytes copied`：复制的总字节数。
- [ ] `5.24509 s`：操作总耗时。
- [ ] `205 MB/s`：平均写入速度。

通过这些输出，你可以获得磁盘的 I/O 性能，例如吞吐量（MB/s），并且可以对不同的磁盘和文件系统进行对比分析。




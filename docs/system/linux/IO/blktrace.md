# 跟踪IO系列

## blktrace命令

### 语法

```bash
blktrace -d dev [ -r debugfs_path ] [ -o output ] [-k ] [ -w time ] [ -a action ] [ -A action_mask ] [ -v ]
```

### 命令选项

blktrace是一个块层IO跟踪命令

```bash
$ blktrace -help
-d <dev>             | --dev=<dev>   填写一个跟踪的磁盘，必填选项
[ -r <debugfs path>  | --relay=<debugfs path> ]   指定debugfs的挂载路径
[ -o <file>          | --output=<file>]  输出的文件叫什么,默认值为 device.blktrace.cpu。 -o - 可以把输出打印屏幕上
[ -D <dir>           | --output-dir=<dir>  输出的目录
[ -w <time>          | --stopwatch=<time>] 跟踪的时长，默认单位为秒
[ -a <action field>  | --act-mask=<action field>]   跟踪哪种磁盘行为
[ -A <action mask>   | --set-mask=<action mask>]    通过16位掩码设置跟踪哪种磁盘行为
[ -b <size>          | --buffer-size]   缓存区的大小，默认为512KB，默认单位为K
[ -n <number>        | --num-sub-buffers=<number>]  默认缓存区的个数，默认为4个
[ -l                 | --listen]  开启监听（blktrace服务器模式）
[ -h <hostname>      | --host=<hostname>] 客户端模式，要链接哪个主机上
[ -p <port number>   | --port=<port number>]  网络模式要使用哪个端口默认为8462
[ -s                 | --no-sendfile]  在网络客户端模式下，不使用sendfile()系统调用来传输数据
[ -I <devs file>     | --input-devs=<devs file>]  输入文件，将文件作为设置
[ -v <version>       | --version] 打印版本
[ -V <version>       | --version] 打印版本
        -d Use specified device. May also be given last after options  跟踪一个设备，可以放在最后
        -r Path to mounted debugfs, defaults to /sys/kernel/debug  指定debugfs的挂载路径，默认指向/sys/kernel/debug 
        -o File(s) to send output to  要输出发送到哪个文件中
        -D Directory to prepend to output file names  输出文件在哪个目录中
        -w Stop after defined time, in seconds  要跟踪多少秒
        -a Only trace specified actions. See documentation  仅仅跟踪一个磁盘行为 可以添加多个-a
        -A Give trace mask as a single value. See documentation 通过16位掩码设置跟踪哪种磁盘行为
        -b Sub buffer size in KiB (default 512)  缓冲区大小，默认为512K，单位为K
        -n Number of sub buffers (default 4)  缓冲区个数，默认为4个
        -l Run in network listen mode (blktrace server)  运行blktrace为服务端模式，打开监听
        -h Run in network client mode, connecting to the given host 运行blktrace为客户端模式，-h后面加服务端的主机IP地址
        -p Network port to use (default 8462)   网络模式的端口，默认为8462
        -s Make the network client NOT use sendfile() to transfer data  网络模式下发送数据不使用sendfile()系统调用
        -I Add devices found in <devs file>  在文件中查找设备（不知道什么意思）
        -v Print program version info  打印版本信息
        -V Print program version info  打印版本信息
```

### 一些详细的解释

-a 可以添加作为过滤的选项

```
barrier: barrier attribute
complete: completed by driver
fs: requests
issue: issued to driver
pc: packet command events
queue: queue operations
read: read traces
requeue: requeue operations
sync: synchronous attribute
write: write traces
notify: trace messages
drv_data: additional driver specific trace
```

blktrace区分两种类型的块层请求，文件系统和SCSI命令。前者称为fs请求，后者称为pc请求。文件系统请求是正常的读/写操作，即以给定大小从特定磁盘位置进行任何类型的读或写操作。这些请求通常来自用户进程，但也可能由vm将脏数据刷新到磁盘或文件系统将超级或日志块同步到磁盘来启动。pc请求是SCSI命令。blktrace将命令数据块作为有效载荷发送，以便blkparse可以对其进行解码。

### 举例

要跟踪设备/*dev/sda*上的 I/O 并将输出解析为人类可读的形式，请使用以下命令：

```
$ blktrace -d /dev/sda -o - |blkparse -i -
```





## blkparse命令

### 语法

```bash
blkparse [选项]
```

### 命令选项

```bash
$ blkparse
Usage: blkparse 

-i <file>           | --input=<file>   必填选项，选定blktrace的输出文件
[ -a <action field> | --act-mask=<action field> ]  过滤查看哪种IO类型
[ -A <action mask>  | --set-mask=<action mask> ] 通过16位掩码设置过滤哪种磁盘行为
[ -b <traces>       | --batch=<traces> ]  标准输入读取
[ -d <file>         | --dump-binary=<file> ]  二进制输出文件
[ -D <dir>          | --input-directory=<dir> ] blktrace的输出文件的目录
[ -f <format>       | --format=<format> ] 输出的格式，可以自定义输出哪些列
[ -F <spec>         | --format-spec=<spec> ]  格式规范，可以自定义
[ -h                | --hash-by-name ] 按名字进行hash
[ -o <file>         | --output=<file> ]  输出文件
[ -O                | --no-text-output ] 无文本输出
[ -q                | --quiet ] 静默输出
[ -s                | --per-program-stats ] 每个程序的统计信息
[ -t                | --track-ios ] 将告诉您请求排队、调度和完成所需的时间
[ -w <time>         | --stopwatch=<time> ] 仅分析给定时间间隔之间的数据（以秒为单位），如果未给定“start”，blkparse默认开始时间为0
[ -M                | --no-msgs  不将消息输出到二进制文件
[ -v                | --verbose ] 详细输出
[ -V                | --version ] 输出版本

        -a 过滤查看哪种IO类型
        -A 通过16位掩码设置过滤哪种磁盘行为
        -b 标准输入读取
        -d 二进制输出文件
        -D blktrace的输出文件的目录
        -f 输出的格式，可以自定义输出哪些列
        -F 格式规范，可以自定义
        -h 按进程名字排序而不是pid
        -i 必填选项，选定blktrace的输出文件, 或者加 - 跟blktrace命令行输出
        -o 输出文件。如果未给出，则输出为标准输出
        -O 无文本输出
        -q 静默输出
        -s 显示每个程序的io统计信息
        -t 将告诉您请求排队、调度和完成所需的时间
        -w 仅分析给定时间间隔之间的数据（以秒为单位），如果未给定“start”，blkparse默认开始时间为0
        -M 不将消息输出到二进制文件
        -v 详细输出
        -V 输出版本
```





```
TRACE ACTIONS
       识别以下跟踪：
       C -- complete A previously issued request has been completed.  The output will detail the sector and size of that request, as well as the success or failure of it.

       D -- issued A request that previously resided on the block layer queue or in the i/o scheduler has been sent to the driver.

       I -- inserted A request is being sent to the i/o scheduler for addition to the internal queue and later service by the driver. The request is fully formed at this time.

       Q -- queued This notes intent to queue i/o at the given location.  No real requests exists yet.

       B  --  bounced  The  data pages attached to this bio are not reachable by the hardware and must be bounced to a lower memory location. This causes a big slowdown in i/o performance, since the data must be copied to/from kernel buffers. Usually this can be fixed with using better hardware -- either a
           better i/o controller, or a platform with an IOMMU.

       M -- back merge A previously inserted request exists that ends on the boundary of where this i/o begins, so the i/o scheduler can merge them together.

       F -- front merge Same as the back merge, except this i/o ends where a previously inserted requests starts.

       M --front or back merge One of the above

       M -- front or back merge One of the above.

       G -- get request To send any type of request to a block device, a struct request container must be allocated first.

       S -- sleep No available request structures were available, so the issuer has to wait for one to be freed.

       P -- plug When i/o is queued to a previously empty block device queue, Linux will plug the queue in anticipation of future ios being added before this data is needed.

       U -- unplug Some request data already queued in the device, start sending requests to the driver. This may happen automatically if a timeout period has passed (see next entry) or if a number of requests have been added to the queue.

       T -- unplug due to timer If nobody requests the i/o that was queued after plugging the queue, Linux will automatically unplug it after a defined period has passed.

       X -- split On raid or device mapper setups, an incoming i/o may straddle a device or internal zone and needs to be chopped up into smaller pieces for service. This may indicate a performance problem due to a bad setup of that raid/dm device, but may also just be part of normal  boundary  conditions.
           dm is notably bad at this and will clone lots of i/o.

       A -- remap For stacked devices, incoming i/o is remapped to device below it in the i/o stack. The remap action details what exactly is being remapped to what.
```





```bash
输出说明
       blkparse的输出可以针对特定用途进行定制，特别是为了简化输出解析，和/或将输出字段限制为用户希望看到的字段。可输出的字段数据包括：

       a   Action, a (small) string (1 or 2 characters) -- see table below for more details

       c   CPU id

       C   Command

       d   RWBS field, a (small) string (1-3 characters)  -- see section below for more details

       D   7-character string containing the major and minor numbers of the event's device (separated by a comma).

       e   Error value

       m   Minor number of event's device.

       M   Major number of event's device.

       n   Number of blocks

       N   Number of bytes

       p   Process ID

       P   Display packet data -- series of hexadecimal values

       s   Sequence numbers

       S   Sector number

       t   Time stamp (nanoseconds)

       T   Time stamp (seconds)

       u   Elapsed value in microseconds (-t command line option)

       U   Payload unsigned integer

       注意，用户可以选择指定字段显示宽度，也可以选择左对齐说明符。它们位于字段说明符之前，后跟“%”字符，后跟可选的左对齐说明符（-），后跟宽度（十进制数），然后是字段。

			因此，要在左对齐的12个字符字段中指定命令：  -f "%-12C"
			
指定每列输出
%  blkparse -f "%a %c %C %d  %n %p  %s %S %t  \n" -i myvda
```





```
"%a输出列中每个字母的含义

       A      IO was remapped to a different device

       B      IO bounced

       C      IO completion

       D      IO issued to driver

       F      IO front merged with request on queue

       G      Get request

       I      IO inserted onto request queue

       M      IO back merged with request on queue

       P      Plug request

       Q      IO handled by request queue code

       S      Sleep request

       T      Unplug due to timeout

       U      Unplug request

       X      Split
```



```
%d 输出列中每个字母的含义
这是一个小字符串，至少包含一个字符（“R”表示读取，“W”表示写入，“D”表示块丢弃操作），以及可选的“B”（表示屏障操作）或“S”（表示同步操作）。
```



```
默认输出
标准标题包含下列标题：
           "%D %2c %8s %5T.%9t %5p %2a %3d"
```



## btt命令

### 语法

```bash
btt [选项]
```

### 命令选项

```
[ -a               | --seek-absolute ]  
[ -A               | --all-data ] 通常，btt不会打印有关每个进程和每个设备数据的详细信息。如果需要该详细级别，可以指定此选项。
[ -B <output name> | --dump-blocknos=<output name> ] 此选项将以指定的输出名称为前缀向三个文件输出绝对块号
[ -d <seconds>     | --range-delta=<seconds> ] btt输出一个包含Q和C活动的文件，活动跟踪的概念简单地意味着在彼此的某个时间段内存在Q或C跟踪。默认值为0.1秒；该选项允许您更改粒度。值越小，提供的数据点越多。
[ -D <dev;...>     | --devices=<dev;...> ] 通常，btt将为在分析的跟踪中检测到的所有设备生成数据。使用此选项，可以将分析减少到传递给此选项的字符串中提供的一个或多个设备
[ -e <exe,...>     | --exes=<exe,...>  ] -e选项提供将分析I/O的可执行文件列表。
[ -h               | --help ] 打印此帮助
[ -i <input name>  | --input-file=<input name> ] 指定输入文件
[ -I <output name> | --iostat=<output name> ] -I选项指示btt将类似iostat的数据输出到指定的文件。有关数据列的详细信息，请参阅iostat（sysstat）文档。
[ -l <output name> | --d2c-latencies=<output name> ] -l选项允许分别输出每个IO D2C延迟。提供的参数为每个设备的输出名称提供了基础。
[ -L <freq>        | --periodic-latencies=<freq> ]  -L选项允许输出Q2C和D2C延迟的周期性延迟信息。指定的频率将调节输出平均延迟的频率——表示秒的浮点值。
[ -m <output name> | --seeks-per-second=<output name> ]  触发btt以输出每秒寻道信息。第一列将包含时间值（秒），第二列将指示此时每秒的寻道次数。
[ -M <dev map>     | --dev-maps=<dev map>
[ -o <output name> | --output-file=<output name> ] 指定输出文件名。
[ -p <output name> | --per-io-dump=<output name> ] -p选项将生成一个包含所有IO“序列”列表的文件，显示每个IO的部分（Q、a、I/M、D和C）。
[ -P <output name> | --per-io-trees=<output name> ]  -P选项将生成一个包含所有IO“序列”列表的文件，仅显示Q、D和C操作时间。D&C时间值与Q时间值用竖条隔开。
[ -q <output name> | --q2c-latencies=<output name> ] -q选项允许分别输出每个IO Q2C延迟。提供的参数为每个设备的输出名称提供了基础。
[ -Q <output name> | --active-queue-depth=<output name> ]  -Q选项允许输出显示时间戳和活动命令深度（已发出但尚未完成的命令）的数据文件。
[ -r               | --no-remaps ] 忽略重映射跟踪；较旧的内核没有实现完整的重映射PDU。
[ -s <output name> | --seeks=<output name> ] -s选项指示btt输出搜索数据，提供的参数是文件名输出的基础。每个设备有两个文件，读查找和写查找。
[ -S <interval>    | --iostat-interval=<interval> ] -S选项指定数据输出之间使用的间隔，默认为每秒一次。
[ -t <sec>         | --time-start=<sec> ] 分析的开始时间
[ -T <sec>         | --time-end=<sec> ]  分析的结束时间
[ -u <output name> | --unplug-hist=<output name> ]  输出直方图
[ -V               | --version ] 版本信息
[ -v               | --verbose ] 详细信息
[ -X               | --easy-parse-avgs ] 以易于解析的形式提供数据，并将其写入带有.avg exentsion的文件
[ -z <output name> | --q2d-latencies=<output name> ]  -z选项允许分别输出每个IO Q2D延迟。提供的参数为每个设备的输出名称提供了基础。
[ -Z               | --do-active -Z将输出包含数据的文件，这些数据可以绘制为显示每个设备（和整个系统）的I/O活动。
```



追踪vda磁盘10秒钟，指定目录到mydata，文件名为myvda，blkparse 指定输入myvda ，输出二进制报告在myvdabin中，btt 输入二进制报告myvdabin，输出iostat信息在iostatreport中，报告打印在屏幕上

```
[root@VM-0-16-centos blk]# blktrace -d /dev/vda -w 10 -D mydata -o myvda
=== vda ===
  CPU  0:                  391 events,       19 KiB data
  CPU  1:                  246 events,       12 KiB data
  CPU  2:                    0 events,        0 KiB data
  CPU  3:                   17 events,        1 KiB data
  Total:                   654 events (dropped 0),       31 KiB data
[root@VM-0-16-centos blk]# ls
mydata
[root@VM-0-16-centos blk]# cd mydata/
[root@VM-0-16-centos mydata]# ls
myvda.blktrace.0  myvda.blktrace.1  myvda.blktrace.2  myvda.blktrace.3
[root@VM-0-16-centos mydata]#  blkparse -i myvda -d myvdabin 
Input file myvda.blktrace.0 added
Input file myvda.blktrace.1 added
Input file myvda.blktrace.2 added
253,0    0        1     0.000000000 31360  A  WS 18285248 + 8 <- (253,1) 18283200
253,0    0        2     0.000002963 31360  Q  WS 18285248 + 8 [barad_agent]
253,0    0        3     0.000005948 31360  G  WS 18285248 + 8 [barad_agent]
253,0    0        4     0.000008960 31360  P   N [barad_agent]
253,0    0        5     0.000011457 31360 UT   N [barad_agent] 1
253,0    0        6     0.000012926 31360  I  WS 18285248 + 8 [barad_agent]
253,0    0        7     0.000016476 31360  D  WS 18285248 + 8 [barad_agent]
253,0    0        8     0.000910827     0  C  WS 18285248 + 8 [0]
253,0    1        1     0.000960226   291  A  WS 7928704 + 8 <- (253,1) 7926656
253,0    1        2     0.000961174   291  Q  WS 7928704 + 8 [jbd2/vda1-8]
253,0    1        3     0.000962002   291  G  WS 7928704 + 8 [jbd2/vda1-8]
253,0    1        4     0.000963025   291  P   N [jbd2/vda1-8]
253,0    1        5     0.000963520   291  A  WS 7928712 + 8 <- (253,1) 7926664
253,0    1        6     0.000963743   291  Q  WS 7928712 + 8 [jbd2/vda1-8]
253,0    1        7     0.000964425   291  M  WS 7928712 + 8 [jbd2/vda1-8]
253,0    1        8     0.000964942   291  A  WS 7928720 + 8 <- (253,1) 7926672
253,0    1        9     0.000965136   291  Q  WS 7928720 + 8 [jbd2/vda1-8]
253,0    1       10     0.000965273   291  M  WS 7928720 + 8 [jbd2/vda1-8]
253,0    1       11     0.000965616   291  A  WS 7928728 + 8 <- (253,1) 7926680
253,0    1       12     0.000965733   291  Q  WS 7928728 + 8 [jbd2/vda1-8]
253,0    1       13     0.000965867   291  M  WS 7928728 + 8 [jbd2/vda1-8]
253,0    1       14     0.000966134   291  A  WS 7928736 + 8 <- (253,1) 7926688
253,0    1       15     0.000966253   291  Q  WS 7928736 + 8 [jbd2/vda1-8]
253,0    1       16     0.000966385   291  M  WS 7928736 + 8 [jbd2/vda1-8]
253,0    1       17     0.000966664   291  A  WS 7928744 + 8 <- (253,1) 7926696
253,0    1       18     0.000966781   291  Q  WS 7928744 + 8 [jbd2/vda1-8]
253,0    1       19     0.000966910   291  M  WS 7928744 + 8 [jbd2/vda1-8]
253,0    1       20     0.000967197   291  A  WS 7928752 + 8 <- (253,1) 7926704
253,0    1       21     0.000967316   291  Q  WS 7928752 + 8 [jbd2/vda1-8]
253,0    1       22     0.000967450   291  M  WS 7928752 + 8 [jbd2/vda1-8]
253,0    1       23     0.000967645   291  A  WS 7928760 + 8 <- (253,1) 7926712
253,0    1       24     0.000967763   291  Q  WS 7928760 + 8 [jbd2/vda1-8]
253,0    1       25     0.000967894   291  M  WS 7928760 + 8 [jbd2/vda1-8]
253,0    1       26     0.000968162   291  A  WS 7928768 + 8 <- (253,1) 7926720
253,0    1       27     0.000968281   291  Q  WS 7928768 + 8 [jbd2/vda1-8]
253,0    1       28     0.000968411   291  M  WS 7928768 + 8 [jbd2/vda1-8]
253,0    1       29     0.000968771   291  A  WS 7928776 + 8 <- (253,1) 7926728
253,0    1       30     0.000968894   291  Q  WS 7928776 + 8 [jbd2/vda1-8]
253,0    1       31     0.000969027   291  M  WS 7928776 + 8 [jbd2/vda1-8]
253,0    1       32     0.000969474   291  A  WS 7928784 + 8 <- (253,1) 7926736
253,0    1       33     0.000969599   291  Q  WS 7928784 + 8 [jbd2/vda1-8]
253,0    1       34     0.000969731   291  M  WS 7928784 + 8 [jbd2/vda1-8]
253,0    1       35     0.000970010   291  A  WS 7928792 + 8 <- (253,1) 7926744
253,0    1       36     0.000970129   291  Q  WS 7928792 + 8 [jbd2/vda1-8]
253,0    1       37     0.000970259   291  M  WS 7928792 + 8 [jbd2/vda1-8]
253,0    1       38     0.000970541   291  A  WS 7928800 + 8 <- (253,1) 7926752
253,0    1       39     0.000970665   291  Q  WS 7928800 + 8 [jbd2/vda1-8]
253,0    1       40     0.000970796   291  M  WS 7928800 + 8 [jbd2/vda1-8]
253,0    1       41     0.000971068   291  A  WS 7928808 + 8 <- (253,1) 7926760
253,0    1       42     0.000971188   291  Q  WS 7928808 + 8 [jbd2/vda1-8]
253,0    1       43     0.000971317   291  M  WS 7928808 + 8 [jbd2/vda1-8]
253,0    1       44     0.000971590   291  A  WS 7928816 + 8 <- (253,1) 7926768
253,0    1       45     0.000971710   291  Q  WS 7928816 + 8 [jbd2/vda1-8]
253,0    1       46     0.000971841   291  M  WS 7928816 + 8 [jbd2/vda1-8]
253,0    1       47     0.000972114   291  A  WS 7928824 + 8 <- (253,1) 7926776
253,0    1       48     0.000972234   291  Q  WS 7928824 + 8 [jbd2/vda1-8]
253,0    1       49     0.000972363   291  M  WS 7928824 + 8 [jbd2/vda1-8]
253,0    1       50     0.000972626   291  A  WS 7928832 + 8 <- (253,1) 7926784
253,0    1       51     0.000972819   291  Q  WS 7928832 + 8 [jbd2/vda1-8]
253,0    1       52     0.000972952   291  M  WS 7928832 + 8 [jbd2/vda1-8]
253,0    1       53     0.000973204   291  A  WS 7928840 + 8 <- (253,1) 7926792
253,0    1       54     0.000973397   291  Q  WS 7928840 + 8 [jbd2/vda1-8]
253,0    1       55     0.000973527   291  M  WS 7928840 + 8 [jbd2/vda1-8]
253,0    1       56     0.000973751   291  A  WS 7928848 + 8 <- (253,1) 7926800
253,0    1       57     0.000973930   291  Q  WS 7928848 + 8 [jbd2/vda1-8]
253,0    1       58     0.000974059   291  M  WS 7928848 + 8 [jbd2/vda1-8]
253,0    1       59     0.000974318   291  A  WS 7928856 + 8 <- (253,1) 7926808
253,0    1       60     0.000974500   291  Q  WS 7928856 + 8 [jbd2/vda1-8]
253,0    1       61     0.000974633   291  M  WS 7928856 + 8 [jbd2/vda1-8]
253,0    1       62     0.000974857   291  A  WS 7928864 + 8 <- (253,1) 7926816
253,0    1       63     0.000974977   291  Q  WS 7928864 + 8 [jbd2/vda1-8]
253,0    1       64     0.000975108   291  M  WS 7928864 + 8 [jbd2/vda1-8]
253,0    1       65     0.000975302   291  A  WS 7928872 + 8 <- (253,1) 7926824
253,0    1       66     0.000975418   291  Q  WS 7928872 + 8 [jbd2/vda1-8]
253,0    1       67     0.000975547   291  M  WS 7928872 + 8 [jbd2/vda1-8]
253,0    1       68     0.000976171   291  A  WS 7928880 + 8 <- (253,1) 7926832
253,0    1       69     0.000976289   291  Q  WS 7928880 + 8 [jbd2/vda1-8]
253,0    1       70     0.000976421   291  M  WS 7928880 + 8 [jbd2/vda1-8]
253,0    1       71     0.000976707   291  A  WS 7928888 + 8 <- (253,1) 7926840
253,0    1       72     0.000976823   291  Q  WS 7928888 + 8 [jbd2/vda1-8]
253,0    1       73     0.000976951   291  M  WS 7928888 + 8 [jbd2/vda1-8]
253,0    1       74     0.000977235   291  A  WS 7928896 + 8 <- (253,1) 7926848
253,0    1       75     0.000977351   291  Q  WS 7928896 + 8 [jbd2/vda1-8]
253,0    1       76     0.000977493   291  M  WS 7928896 + 8 [jbd2/vda1-8]
253,0    1       77     0.000977886   291  A  WS 7928904 + 8 <- (253,1) 7926856
253,0    1       78     0.000978066   291  Q  WS 7928904 + 8 [jbd2/vda1-8]
253,0    1       79     0.000978199   291  M  WS 7928904 + 8 [jbd2/vda1-8]
253,0    1       80     0.000978496   291  A  WS 7928912 + 8 <- (253,1) 7926864
253,0    1       81     0.000978675   291  Q  WS 7928912 + 8 [jbd2/vda1-8]
253,0    1       82     0.000978806   291  M  WS 7928912 + 8 [jbd2/vda1-8]
253,0    1       83     0.000979050   291  A  WS 7928920 + 8 <- (253,1) 7926872
253,0    1       84     0.000979244   291  Q  WS 7928920 + 8 [jbd2/vda1-8]
253,0    1       85     0.000979373   291  M  WS 7928920 + 8 [jbd2/vda1-8]
253,0    1       86     0.000980014   291 UT   N [jbd2/vda1-8] 1
253,0    1       87     0.000980420   291  I  WS 7928704 + 224 [jbd2/vda1-8]
253,0    1       88     0.000981785   291  D  WS 7928704 + 224 [jbd2/vda1-8]
253,0    0        9     0.003244357     0  C  WS 7928704 + 224 [0]
253,0    0       10     0.003271459   291  A FWFS 7928928 + 8 <- (253,1) 7926880
253,0    0       11     0.003271854   291  Q FWFS 7928928 + 8 [jbd2/vda1-8]
253,0    0       12     0.003272053   291  G FWFS 7928928 + 8 [jbd2/vda1-8]
253,0    0       13     0.003398213   284  D  WS 7928928 + 8 [kworker/0:1H]
253,0    0       14     0.004277985     0  C  WS 7928928 + 8 [0]
253,0    0       15     0.004446931     0  C  WS 7928928 [0]
253,0    1       89     0.004495486 31360  A  WS 18285248 + 8 <- (253,1) 18283200
253,0    1       90     0.004496628 31360  Q  WS 18285248 + 8 [barad_agent]
253,0    1       91     0.004497546 31360  G  WS 18285248 + 8 [barad_agent]
253,0    1       92     0.004498526 31360  P   N [barad_agent]
253,0    1       93     0.004498959 31360 UT   N [barad_agent] 1
253,0    1       94     0.004499336 31360  I  WS 18285248 + 8 [barad_agent]
253,0    1       95     0.004500300 31360  D  WS 18285248 + 8 [barad_agent]
253,0    0       16     0.005671600     0  C  WS 18285248 + 8 [0]
253,0    0       17     0.005701797   291  A  WS 7928936 + 8 <- (253,1) 7926888
253,0    0       18     0.005702238   291  Q  WS 7928936 + 8 [jbd2/vda1-8]
253,0    0       19     0.005702707   291  G  WS 7928936 + 8 [jbd2/vda1-8]
253,0    0       20     0.005703252   291  P   N [jbd2/vda1-8]
253,0    0       21     0.005703515   291  A  WS 7928944 + 8 <- (253,1) 7926896
253,0    0       22     0.005703710   291  Q  WS 7928944 + 8 [jbd2/vda1-8]
253,0    0       23     0.005704211   291  M  WS 7928944 + 8 [jbd2/vda1-8]
253,0    0       24     0.005704793   291  A  WS 7928952 + 8 <- (253,1) 7926904
253,0    0       25     0.005704987   291  Q  WS 7928952 + 8 [jbd2/vda1-8]
253,0    0       26     0.005705122   291  M  WS 7928952 + 8 [jbd2/vda1-8]
253,0    0       27     0.005705561   291 UT   N [jbd2/vda1-8] 1
253,0    0       28     0.005705843   291  I  WS 7928936 + 24 [jbd2/vda1-8]
253,0    0       29     0.005706577   291  D  WS 7928936 + 24 [jbd2/vda1-8]
253,0    0       30     0.006453326     0  C  WS 7928936 + 24 [0]
253,0    0       31     0.006460459   291  A FWFS 7928960 + 8 <- (253,1) 7926912
253,0    0       32     0.006460644   291  Q FWFS 7928960 + 8 [jbd2/vda1-8]
253,0    0       33     0.006460804   291  G FWFS 7928960 + 8 [jbd2/vda1-8]
253,0    0       34     0.006550733   284  D  WS 7928960 + 8 [kworker/0:1H]
253,0    0       35     0.007294926     0  C  WS 7928960 + 8 [0]
253,0    0       36     0.007375389     0  C  WS 7928960 [0]
253,0    1       96     0.007428746 31360  A  WS 25411448 + 16 <- (253,1) 25409400
253,0    1       97     0.007429357 31360  Q  WS 25411448 + 16 [barad_agent]
253,0    1       98     0.007429742 31360  G  WS 25411448 + 16 [barad_agent]
253,0    1       99     0.007430337 31360  P   N [barad_agent]
253,0    1      100     0.007430888 31360  A  WS 25206952 + 8 <- (253,1) 25204904
253,0    1      101     0.007431068 31360  Q  WS 25206952 + 8 [barad_agent]
253,0    1      102     0.007431411 31360  G  WS 25206952 + 8 [barad_agent]
253,0    1      103     0.007432195 31360 UT   N [barad_agent] 2
253,0    1      104     0.007432429 31360  I  WS 25206952 + 8 [barad_agent]
253,0    1      105     0.007432808 31360  I  WS 25411448 + 16 [barad_agent]
253,0    1      106     0.007433532 31360  D  WS 25206952 + 8 [barad_agent]
253,0    1      107     0.007436657 31360  D  WS 25411448 + 16 [barad_agent]
253,0    0       37     0.008105745     0  C  WS 25411448 + 16 [0]
253,0    0       38     0.008250164     0  C  WS 25206952 + 8 [0]
253,0    0       39     0.008275094   291  A  WS 7928968 + 8 <- (253,1) 7926920
253,0    0       40     0.008275352   291  Q  WS 7928968 + 8 [jbd2/vda1-8]
253,0    0       41     0.008275740   291  G  WS 7928968 + 8 [jbd2/vda1-8]
253,0    0       42     0.008276186   291  P   N [jbd2/vda1-8]
253,0    0       43     0.008276442   291  A  WS 7928976 + 8 <- (253,1) 7926928
253,0    0       44     0.008276634   291  Q  WS 7928976 + 8 [jbd2/vda1-8]
253,0    0       45     0.008276894   291  M  WS 7928976 + 8 [jbd2/vda1-8]
253,0    0       46     0.008277305   291 UT   N [jbd2/vda1-8] 1
253,0    0       47     0.008277559   291  I  WS 7928968 + 16 [jbd2/vda1-8]
253,0    0       48     0.008278189   291  D  WS 7928968 + 16 [jbd2/vda1-8]
253,0    0       49     0.008908633     0  C  WS 7928968 + 16 [0]
253,0    0       50     0.008915078   291  A FWFS 7928984 + 8 <- (253,1) 7926936
253,0    0       51     0.008915273   291  Q FWFS 7928984 + 8 [jbd2/vda1-8]
253,0    0       52     0.008915434   291  G FWFS 7928984 + 8 [jbd2/vda1-8]
253,0    0       53     0.009002428   284  D  WS 7928984 + 8 [kworker/0:1H]
253,0    0       54     0.010153741     0  C  WS 7928984 + 8 [0]
253,0    0       55     0.010240596     0  C  WS 7928984 [0]
253,0    1      108     0.011372486 31360  A  WS 25475000 + 8 <- (253,1) 25472952
253,0    1      109     0.011373483 31360  Q  WS 25475000 + 8 [barad_agent]
253,0    1      110     0.011374518 31360  G  WS 25475000 + 8 [barad_agent]
253,0    1      111     0.011375757 31360  P   N [barad_agent]
253,0    1      112     0.011376731 31360 UT   N [barad_agent] 1
253,0    1      113     0.011377166 31360  I  WS 25475000 + 8 [barad_agent]
253,0    1      114     0.011379302 31360  D  WS 25475000 + 8 [barad_agent]
253,0    0       56     0.012743466     0  C  WS 25475000 + 8 [0]
253,0    0       57     0.012795600   291  A  WS 7928992 + 8 <- (253,1) 7926944
253,0    0       58     0.012796158   291  Q  WS 7928992 + 8 [jbd2/vda1-8]
253,0    0       59     0.012796744   291  G  WS 7928992 + 8 [jbd2/vda1-8]
253,0    0       60     0.012797748   291  P   N [jbd2/vda1-8]
253,0    0       61     0.012798154   291  A  WS 7929000 + 8 <- (253,1) 7926952
253,0    0       62     0.012798341   291  Q  WS 7929000 + 8 [jbd2/vda1-8]
253,0    0       63     0.012798821   291  M  WS 7929000 + 8 [jbd2/vda1-8]
253,0    0       64     0.012799214   291  A  WS 7929008 + 8 <- (253,1) 7926960
253,0    0       65     0.012799421   291  Q  WS 7929008 + 8 [jbd2/vda1-8]
253,0    0       66     0.012799553   291  M  WS 7929008 + 8 [jbd2/vda1-8]
253,0    0       67     0.012799802   291  A  WS 7929016 + 8 <- (253,1) 7926968
253,0    0       68     0.012799985   291  Q  WS 7929016 + 8 [jbd2/vda1-8]
253,0    0       69     0.012800117   291  M  WS 7929016 + 8 [jbd2/vda1-8]
253,0    0       70     0.012800395   291  A  WS 7929024 + 8 <- (253,1) 7926976
253,0    0       71     0.012800532   291  Q  WS 7929024 + 8 [jbd2/vda1-8]
253,0    0       72     0.012800676   291  M  WS 7929024 + 8 [jbd2/vda1-8]
253,0    0       73     0.012800951   291  A  WS 7929032 + 8 <- (253,1) 7926984
253,0    0       74     0.012801089   291  Q  WS 7929032 + 8 [jbd2/vda1-8]
253,0    0       75     0.012801219   291  M  WS 7929032 + 8 [jbd2/vda1-8]
253,0    0       76     0.012801521   291  A  WS 7929040 + 8 <- (253,1) 7926992
253,0    0       77     0.012801708   291  Q  WS 7929040 + 8 [jbd2/vda1-8]
253,0    0       78     0.012801834   291  M  WS 7929040 + 8 [jbd2/vda1-8]
253,0    0       79     0.012802485   291  A  WS 7929048 + 8 <- (253,1) 7927000
253,0    0       80     0.012802672   291  Q  WS 7929048 + 8 [jbd2/vda1-8]
253,0    0       81     0.012802804   291  M  WS 7929048 + 8 [jbd2/vda1-8]
253,0    0       82     0.012803134   291  A  WS 7929056 + 8 <- (253,1) 7927008
253,0    0       83     0.012803328   291  Q  WS 7929056 + 8 [jbd2/vda1-8]
253,0    0       84     0.012803473   291  M  WS 7929056 + 8 [jbd2/vda1-8]
253,0    0       85     0.012804057   291 UT   N [jbd2/vda1-8] 1
253,0    0       86     0.012804345   291  I  WS 7928992 + 72 [jbd2/vda1-8]
253,0    0       87     0.012805270   291  D  WS 7928992 + 72 [jbd2/vda1-8]
253,0    0       88     0.014191981     0  C  WS 7928992 + 72 [0]
253,0    0       89     0.014203185   291  A FWFS 7929064 + 8 <- (253,1) 7927016
253,0    0       90     0.014203387   291  Q FWFS 7929064 + 8 [jbd2/vda1-8]
253,0    0       91     0.014203573   291  G FWFS 7929064 + 8 [jbd2/vda1-8]
253,0    0       92     0.014317414   284  D  WS 7929064 + 8 [kworker/0:1H]
253,0    0       93     0.015572547     0  C  WS 7929064 + 8 [0]
253,0    0       94     0.015655392     0  C  WS 7929064 [0]
253,0    1      115     0.015690905 31360  A  WS 25475000 + 8 <- (253,1) 25472952
253,0    1      116     0.015691641 31360  Q  WS 25475000 + 8 [barad_agent]
253,0    1      117     0.015692260 31360  G  WS 25475000 + 8 [barad_agent]
253,0    1      118     0.015692946 31360  P   N [barad_agent]
253,0    1      119     0.015693391 31360 UT   N [barad_agent] 1
253,0    1      120     0.015693669 31360  I  WS 25475000 + 8 [barad_agent]
253,0    1      121     0.015694488 31360  D  WS 25475000 + 8 [barad_agent]
253,0    0       95     0.016523177     0  C  WS 25475000 + 8 [0]
253,0    0       96     0.016558752   291  A  WS 7929072 + 8 <- (253,1) 7927024
253,0    0       97     0.016559072   291  Q  WS 7929072 + 8 [jbd2/vda1-8]
253,0    0       98     0.016559528   291  G  WS 7929072 + 8 [jbd2/vda1-8]
253,0    0       99     0.016560087   291  P   N [jbd2/vda1-8]
253,0    0      100     0.016560386   291  A  WS 7929080 + 8 <- (253,1) 7927032
253,0    0      101     0.016560984   291  Q  WS 7929080 + 8 [jbd2/vda1-8]
253,0    0      102     0.016561293   291  M  WS 7929080 + 8 [jbd2/vda1-8]
253,0    0      103     0.016561785   291 UT   N [jbd2/vda1-8] 1
253,0    0      104     0.016562064   291  I  WS 7929072 + 16 [jbd2/vda1-8]
253,0    0      105     0.016562819   291  D  WS 7929072 + 16 [jbd2/vda1-8]
253,0    0      106     0.017230216     0  C  WS 7929072 + 16 [0]
253,0    0      107     0.017237203   291  A FWFS 7929088 + 8 <- (253,1) 7927040
253,0    0      108     0.017237406   291  Q FWFS 7929088 + 8 [jbd2/vda1-8]
253,0    0      109     0.017237572   291  G FWFS 7929088 + 8 [jbd2/vda1-8]
253,0    0      110     0.017321427   284  D  WS 7929088 + 8 [kworker/0:1H]
253,0    0      111     0.018309440     0  C  WS 7929088 + 8 [0]
253,0    0      112     0.018403911     0  C  WS 7929088 [0]
253,0    1      122     0.018439004 31360  A  WS 25411448 + 16 <- (253,1) 25409400
253,0    1      123     0.018439495 31360  Q  WS 25411448 + 16 [barad_agent]
253,0    1      124     0.018439938 31360  G  WS 25411448 + 16 [barad_agent]
253,0    1      125     0.018440502 31360  P   N [barad_agent]
253,0    1      126     0.018441134 31360  A  WS 25206952 + 8 <- (253,1) 25204904
253,0    1      127     0.018441338 31360  Q  WS 25206952 + 8 [barad_agent]
253,0    1      128     0.018441682 31360  G  WS 25206952 + 8 [barad_agent]
253,0    1      129     0.018442452 31360 UT   N [barad_agent] 2
253,0    1      130     0.018442691 31360  I  WS 25206952 + 8 [barad_agent]
253,0    1      131     0.018443137 31360  I  WS 25411448 + 16 [barad_agent]
253,0    1      132     0.018443956 31360  D  WS 25206952 + 8 [barad_agent]
253,0    1      133     0.018447486 31360  D  WS 25411448 + 16 [barad_agent]
253,0    0      113     0.019121789     0  C  WS 25411448 + 16 [0]
253,0    0      114     0.019328776     0  C  WS 25206952 + 8 [0]
253,0    0      115     0.019355356   291  A  WS 7929096 + 8 <- (253,1) 7927048
253,0    0      116     0.019355582   291  Q  WS 7929096 + 8 [jbd2/vda1-8]
253,0    0      117     0.019355967   291  G  WS 7929096 + 8 [jbd2/vda1-8]
253,0    0      118     0.019356438   291  P   N [jbd2/vda1-8]
253,0    0      119     0.019356776   291  A  WS 7929104 + 8 <- (253,1) 7927056
253,0    0      120     0.019356963   291  Q  WS 7929104 + 8 [jbd2/vda1-8]
253,0    0      121     0.019357243   291  M  WS 7929104 + 8 [jbd2/vda1-8]
253,0    0      122     0.019357696   291 UT   N [jbd2/vda1-8] 1
253,0    0      123     0.019357942   291  I  WS 7929096 + 16 [jbd2/vda1-8]
253,0    0      124     0.019358583   291  D  WS 7929096 + 16 [jbd2/vda1-8]
253,0    0      125     0.020135467     0  C  WS 7929096 + 16 [0]
253,0    0      126     0.020150134   291  A FWFS 7929112 + 8 <- (253,1) 7927064
253,0    0      127     0.020150867   291  Q FWFS 7929112 + 8 [jbd2/vda1-8]
253,0    0      128     0.020151264   291  G FWFS 7929112 + 8 [jbd2/vda1-8]
253,0    0      129     0.020511308   284  D  WS 7929112 + 8 [kworker/0:1H]
253,0    0      130     0.021340905     0  C  WS 7929112 + 8 [0]
253,0    0      131     0.021432559     0  C  WS 7929112 [0]
253,0    1      134     0.022393544 31360  A  WS 25475008 + 8 <- (253,1) 25472960
253,0    1      135     0.022394631 31360  Q  WS 25475008 + 8 [barad_agent]
253,0    1      136     0.022395813 31360  G  WS 25475008 + 8 [barad_agent]
253,0    1      137     0.022397264 31360  P   N [barad_agent]
253,0    1      138     0.022398347 31360 UT   N [barad_agent] 1
253,0    1      139     0.022398788 31360  I  WS 25475008 + 8 [barad_agent]
253,0    1      140     0.022416608 31360  D  WS 25475008 + 8 [barad_agent]
253,0    0      132     0.023458688     0  C  WS 25475008 + 8 [0]
253,0    0      133     0.023494955   291  A  WS 7929120 + 8 <- (253,1) 7927072
253,0    0      134     0.023495563   291  Q  WS 7929120 + 8 [jbd2/vda1-8]
253,0    0      135     0.023496345   291  G  WS 7929120 + 8 [jbd2/vda1-8]
253,0    0      136     0.023497465   291  P   N [jbd2/vda1-8]
253,0    0      137     0.023497937   291  A  WS 7929128 + 8 <- (253,1) 7927080
253,0    0      138     0.023498136   291  Q  WS 7929128 + 8 [jbd2/vda1-8]
253,0    0      139     0.023498675   291  M  WS 7929128 + 8 [jbd2/vda1-8]
253,0    0      140     0.023499096   291  A  WS 7929136 + 8 <- (253,1) 7927088
253,0    0      141     0.023499281   291  Q  WS 7929136 + 8 [jbd2/vda1-8]
253,0    0      142     0.023499421   291  M  WS 7929136 + 8 [jbd2/vda1-8]
253,0    0      143     0.023499751   291  A  WS 7929144 + 8 <- (253,1) 7927096
253,0    0      144     0.023499883   291  Q  WS 7929144 + 8 [jbd2/vda1-8]
253,0    0      145     0.023500016   291  M  WS 7929144 + 8 [jbd2/vda1-8]
253,0    0      146     0.023500284   291  A  WS 7929152 + 8 <- (253,1) 7927104
253,0    0      147     0.023500416   291  Q  WS 7929152 + 8 [jbd2/vda1-8]
253,0    0      148     0.023500547   291  M  WS 7929152 + 8 [jbd2/vda1-8]
253,0    0      149     0.023500739   291  A  WS 7929160 + 8 <- (253,1) 7927112
253,0    0      150     0.023500873   291  Q  WS 7929160 + 8 [jbd2/vda1-8]
253,0    0      151     0.023501005   291  M  WS 7929160 + 8 [jbd2/vda1-8]
253,0    0      152     0.023501279   291  A  WS 7929168 + 8 <- (253,1) 7927120
253,0    0      153     0.023501412   291  Q  WS 7929168 + 8 [jbd2/vda1-8]
253,0    0      154     0.023501547   291  M  WS 7929168 + 8 [jbd2/vda1-8]
253,0    0      155     0.023501974   291  A  WS 7929176 + 8 <- (253,1) 7927128
253,0    0      156     0.023502168   291  Q  WS 7929176 + 8 [jbd2/vda1-8]
253,0    0      157     0.023502301   291  M  WS 7929176 + 8 [jbd2/vda1-8]
253,0    0      158     0.023502979   291 UT   N [jbd2/vda1-8] 1
253,0    0      159     0.023503390   291  I  WS 7929120 + 64 [jbd2/vda1-8]
253,0    0      160     0.023504516   291  D  WS 7929120 + 64 [jbd2/vda1-8]
253,0    0      161     0.024602854     0  C  WS 7929120 + 64 [0]
253,0    0      162     0.024616650   291  A FWFS 7929184 + 8 <- (253,1) 7927136
253,0    0      163     0.024617176   291  Q FWFS 7929184 + 8 [jbd2/vda1-8]
253,0    0      164     0.024617411   291  G FWFS 7929184 + 8 [jbd2/vda1-8]
253,0    0      165     0.024713783   284  D  WS 7929184 + 8 [kworker/0:1H]
253,0    0      166     0.025436970     0  C  WS 7929184 + 8 [0]
253,0    0      167     0.025517106     0  C  WS 7929184 [0]
253,0    1      141     0.025552987 31360  A  WS 25475008 + 8 <- (253,1) 25472960
253,0    1      142     0.025553735 31360  Q  WS 25475008 + 8 [barad_agent]
253,0    1      143     0.025554451 31360  G  WS 25475008 + 8 [barad_agent]
253,0    1      144     0.025555171 31360  P   N [barad_agent]
253,0    1      145     0.025555615 31360 UT   N [barad_agent] 1
253,0    1      146     0.025555946 31360  I  WS 25475008 + 8 [barad_agent]
253,0    1      147     0.025556859 31360  D  WS 25475008 + 8 [barad_agent]
253,0    0      168     0.026328848     0  C  WS 25475008 + 8 [0]
253,0    0      169     0.026357842   291  A  WS 7929192 + 8 <- (253,1) 7927144
253,0    0      170     0.026358278   291  Q  WS 7929192 + 8 [jbd2/vda1-8]
253,0    0      171     0.026358811   291  G  WS 7929192 + 8 [jbd2/vda1-8]
253,0    0      172     0.026359496   291  P   N [jbd2/vda1-8]
253,0    0      173     0.026359835   291  A  WS 7929200 + 8 <- (253,1) 7927152
253,0    0      174     0.026360019   291  Q  WS 7929200 + 8 [jbd2/vda1-8]
253,0    0      175     0.026360356   291  M  WS 7929200 + 8 [jbd2/vda1-8]
253,0    0      176     0.026360865   291 UT   N [jbd2/vda1-8] 1
253,0    0      177     0.026361259   291  I  WS 7929192 + 16 [jbd2/vda1-8]
253,0    0      178     0.026362035   291  D  WS 7929192 + 16 [jbd2/vda1-8]
253,0    0      179     0.027045353     0  C  WS 7929192 + 16 [0]
253,0    0      180     0.027054385   291  A FWFS 7929208 + 8 <- (253,1) 7927160
253,0    0      181     0.027054673   291  Q FWFS 7929208 + 8 [jbd2/vda1-8]
253,0    0      182     0.027054890   291  G FWFS 7929208 + 8 [jbd2/vda1-8]
253,0    0      183     0.027139235   284  D  WS 7929208 + 8 [kworker/0:1H]
253,0    0      184     0.027877565     0  C  WS 7929208 + 8 [0]
253,0    0      185     0.027956059     0  C  WS 7929208 [0]
253,0    1      148     0.027992206 31360  A  WS 25411448 + 16 <- (253,1) 25409400
253,0    1      149     0.027992686 31360  Q  WS 25411448 + 16 [barad_agent]
253,0    1      150     0.027993213 31360  G  WS 25411448 + 16 [barad_agent]
253,0    1      151     0.027993727 31360  P   N [barad_agent]
253,0    1      152     0.027994497 31360  A  WS 25206928 + 8 <- (253,1) 25204880
253,0    1      153     0.027994701 31360  Q  WS 25206928 + 8 [barad_agent]
253,0    1      154     0.027995006 31360  G  WS 25206928 + 8 [barad_agent]
253,0    1      155     0.027995871 31360 UT   N [barad_agent] 2
253,0    1      156     0.027996160 31360  I  WS 25206928 + 8 [barad_agent]
253,0    1      157     0.027996649 31360  I  WS 25411448 + 16 [barad_agent]
253,0    1      158     0.027997501 31360  D  WS 25206928 + 8 [barad_agent]
253,0    1      159     0.028001198 31360  D  WS 25411448 + 16 [barad_agent]
253,0    0      186     0.028714563     0  C  WS 25206928 + 8 [0]
253,0    0      187     0.028743236     0  C  WS 25411448 + 16 [0]
253,0    0      188     0.028769004   291  A  WS 7929216 + 8 <- (253,1) 7927168
253,0    0      189     0.028769262   291  Q  WS 7929216 + 8 [jbd2/vda1-8]
253,0    0      190     0.028769657   291  G  WS 7929216 + 8 [jbd2/vda1-8]
253,0    0      191     0.028770114   291  P   N [jbd2/vda1-8]
253,0    0      192     0.028770470   291  A  WS 7929224 + 8 <- (253,1) 7927176
253,0    0      193     0.028770667   291  Q  WS 7929224 + 8 [jbd2/vda1-8]
253,0    0      194     0.028770921   291  M  WS 7929224 + 8 [jbd2/vda1-8]
253,0    0      195     0.028771419   291 UT   N [jbd2/vda1-8] 1
253,0    0      196     0.028771724   291  I  WS 7929216 + 16 [jbd2/vda1-8]
253,0    0      197     0.028772493   291  D  WS 7929216 + 16 [jbd2/vda1-8]
253,0    0      198     0.029504720     0  C  WS 7929216 + 16 [0]
253,0    0      199     0.029512617   291  A FWFS 7929232 + 8 <- (253,1) 7927184
253,0    0      200     0.029512873   291  Q FWFS 7929232 + 8 [jbd2/vda1-8]
253,0    0      201     0.029513069   291  G FWFS 7929232 + 8 [jbd2/vda1-8]
253,0    0      202     0.029604935   284  D  WS 7929232 + 8 [kworker/0:1H]
253,0    0      203     0.030330323     0  C  WS 7929232 + 8 [0]
253,0    0      204     0.030432412     0  C  WS 7929232 [0]
253,0    1      160     0.031247827 31360  A  WS 25475016 + 8 <- (253,1) 25472968
253,0    1      161     0.031248733 31360  Q  WS 25475016 + 8 [barad_agent]
253,0    1      162     0.031249689 31360  G  WS 25475016 + 8 [barad_agent]
253,0    1      163     0.031250911 31360  P   N [barad_agent]
253,0    1      164     0.031251917 31360 UT   N [barad_agent] 1
253,0    1      165     0.031252330 31360  I  WS 25475016 + 8 [barad_agent]
253,0    1      166     0.031253744 31360  D  WS 25475016 + 8 [barad_agent]
253,0    0      205     0.033154141     0  C  WS 25475016 + 8 [0]
253,0    0      206     0.033188363   291  A  WS 7929240 + 8 <- (253,1) 7927192
253,0    0      207     0.033188894   291  Q  WS 7929240 + 8 [jbd2/vda1-8]
253,0    0      208     0.033189585   291  G  WS 7929240 + 8 [jbd2/vda1-8]
253,0    0      209     0.033190507   291  P   N [jbd2/vda1-8]
253,0    0      210     0.033190824   291  A  WS 7929248 + 8 <- (253,1) 7927200
253,0    0      211     0.033190991   291  Q  WS 7929248 + 8 [jbd2/vda1-8]
253,0    0      212     0.033191365   291  M  WS 7929248 + 8 [jbd2/vda1-8]
253,0    0      213     0.033191996   291  A  WS 7929256 + 8 <- (253,1) 7927208
253,0    0      214     0.033192210   291  Q  WS 7929256 + 8 [jbd2/vda1-8]
253,0    0      215     0.033192345   291  M  WS 7929256 + 8 [jbd2/vda1-8]
253,0    0      216     0.033192628   291  A  WS 7929264 + 8 <- (253,1) 7927216
253,0    0      217     0.033192788   291  Q  WS 7929264 + 8 [jbd2/vda1-8]
253,0    0      218     0.033192917   291  M  WS 7929264 + 8 [jbd2/vda1-8]
253,0    0      219     0.033193188   291  A  WS 7929272 + 8 <- (253,1) 7927224
253,0    0      220     0.033193304   291  Q  WS 7929272 + 8 [jbd2/vda1-8]
253,0    0      221     0.033193433   291  M  WS 7929272 + 8 [jbd2/vda1-8]
253,0    0      222     0.033193628   291  A  WS 7929280 + 8 <- (253,1) 7927232
253,0    0      223     0.033193747   291  Q  WS 7929280 + 8 [jbd2/vda1-8]
253,0    0      224     0.033193877   291  M  WS 7929280 + 8 [jbd2/vda1-8]
253,0    0      225     0.033194067   291  A  WS 7929288 + 8 <- (253,1) 7927240
253,0    0      226     0.033194185   291  Q  WS 7929288 + 8 [jbd2/vda1-8]
253,0    0      227     0.033194327   291  M  WS 7929288 + 8 [jbd2/vda1-8]
253,0    0      228     0.033194605   291  A  WS 7929296 + 8 <- (253,1) 7927248
253,0    0      229     0.033194721   291  Q  WS 7929296 + 8 [jbd2/vda1-8]
253,0    0      230     0.033194853   291  M  WS 7929296 + 8 [jbd2/vda1-8]
253,0    0      231     0.033195591   291 UT   N [jbd2/vda1-8] 1
253,0    0      232     0.033195982   291  I  WS 7929240 + 64 [jbd2/vda1-8]
253,0    0      233     0.033196998   291  D  WS 7929240 + 64 [jbd2/vda1-8]
253,0    0      234     0.034362372     0  C  WS 7929240 + 64 [0]
253,0    0      235     0.034373192   291  A FWFS 7929304 + 8 <- (253,1) 7927256
253,0    0      236     0.034373470   291  Q FWFS 7929304 + 8 [jbd2/vda1-8]
253,0    0      237     0.034373696   291  G FWFS 7929304 + 8 [jbd2/vda1-8]
253,0    0      238     0.034472706   284  D  WS 7929304 + 8 [kworker/0:1H]
253,0    0      239     0.035196530     0  C  WS 7929304 + 8 [0]
253,0    0      240     0.035285330     0  C  WS 7929304 [0]
253,0    1      167     0.035320979 31360  A  WS 25475016 + 8 <- (253,1) 25472968
253,0    1      168     0.035321822 31360  Q  WS 25475016 + 8 [barad_agent]
253,0    1      169     0.035322749 31360  G  WS 25475016 + 8 [barad_agent]
253,0    1      170     0.035323841 31360  P   N [barad_agent]
253,0    1      171     0.035324321 31360 UT   N [barad_agent] 1
253,0    1      172     0.035324676 31360  I  WS 25475016 + 8 [barad_agent]
253,0    1      173     0.035325991 31360  D  WS 25475016 + 8 [barad_agent]
253,0    0      241     0.037738108     0  C  WS 25475016 + 8 [0]
253,0    0      242     0.037769866   291  A  WS 7929312 + 8 <- (253,1) 7927264
253,0    0      243     0.037770331   291  Q  WS 7929312 + 8 [jbd2/vda1-8]
253,0    0      244     0.037771003   291  G  WS 7929312 + 8 [jbd2/vda1-8]
253,0    0      245     0.037771773   291  P   N [jbd2/vda1-8]
253,0    0      246     0.037772035   291  A  WS 7929320 + 8 <- (253,1) 7927272
253,0    0      247     0.037772238   291  Q  WS 7929320 + 8 [jbd2/vda1-8]
253,0    0      248     0.037772541   291  M  WS 7929320 + 8 [jbd2/vda1-8]
253,0    0      249     0.037773170   291 UT   N [jbd2/vda1-8] 1
253,0    0      250     0.037773616   291  I  WS 7929312 + 16 [jbd2/vda1-8]
253,0    0      251     0.037774465   291  D  WS 7929312 + 16 [jbd2/vda1-8]
253,0    0      252     0.038437889     0  C  WS 7929312 + 16 [0]
253,0    0      253     0.038443546   291  A FWFS 7929328 + 8 <- (253,1) 7927280
253,0    0      254     0.038443827   291  Q FWFS 7929328 + 8 [jbd2/vda1-8]
253,0    0      255     0.038444097   291  G FWFS 7929328 + 8 [jbd2/vda1-8]
253,0    0      256     0.038529733   284  D  WS 7929328 + 8 [kworker/0:1H]
253,0    0      257     0.039309629     0  C  WS 7929328 + 8 [0]
253,0    0      258     0.039383908     0  C  WS 7929328 [0]
253,0    1      174     0.039436530 31360  A  WS 25411448 + 16 <- (253,1) 25409400
253,0    1      175     0.039437228 31360  Q  WS 25411448 + 16 [barad_agent]
253,0    1      176     0.039438201 31360  G  WS 25411448 + 16 [barad_agent]
253,0    1      177     0.039439280 31360  P   N [barad_agent]
253,0    1      178     0.039440282 31360  A  WS 25411488 + 8 <- (253,1) 25409440
253,0    1      179     0.039440468 31360  Q  WS 25411488 + 8 [barad_agent]
253,0    1      180     0.039440801 31360  G  WS 25411488 + 8 [barad_agent]
253,0    1      181     0.039441914 31360  A  WS 25206952 + 8 <- (253,1) 25204904
253,0    1      182     0.039442111 31360  Q  WS 25206952 + 8 [barad_agent]
253,0    1      183     0.039442395 31360  G  WS 25206952 + 8 [barad_agent]
253,0    1      184     0.039443365 31360 UT   N [barad_agent] 3
253,0    1      185     0.039443720 31360  I  WS 25206952 + 8 [barad_agent]
253,0    1      186     0.039444137 31360  I  WS 25411448 + 16 [barad_agent]
253,0    1      187     0.039444301 31360  I  WS 25411488 + 8 [barad_agent]
253,0    1      188     0.039445538 31360  D  WS 25206952 + 8 [barad_agent]
253,0    1      189     0.039450185 31360  D  WS 25411448 + 16 [barad_agent]
253,0    1      190     0.039450924 31360  D  WS 25411488 + 8 [barad_agent]
253,0    0      259     0.040087466     0  C  WS 25411448 + 16 [0]
253,0    0      260     0.040127395     0  C  WS 25411488 + 8 [0]
253,0    0      261     0.040249958     0  C  WS 25206952 + 8 [0]
253,0    0      262     0.040280612   291  A  WS 7929336 + 8 <- (253,1) 7927288
253,0    0      263     0.040281211   291  Q  WS 7929336 + 8 [jbd2/vda1-8]
253,0    0      264     0.040285602   291  G  WS 7929336 + 8 [jbd2/vda1-8]
253,0    0      265     0.040286651   291  P   N [jbd2/vda1-8]
253,0    0      266     0.040287209   291  A  WS 7929344 + 8 <- (253,1) 7927296
253,0    0      267     0.040287499   291  Q  WS 7929344 + 8 [jbd2/vda1-8]
253,0    0      268     0.040288012   291  M  WS 7929344 + 8 [jbd2/vda1-8]
253,0    0      269     0.040288828   291 UT   N [jbd2/vda1-8] 1
253,0    0      270     0.040289335   291  I  WS 7929336 + 16 [jbd2/vda1-8]
253,0    0      271     0.040290356   291  D  WS 7929336 + 16 [jbd2/vda1-8]
253,0    0      272     0.041012337     0  C  WS 7929336 + 16 [0]
253,0    0      273     0.041019669   291  A FWFS 7929352 + 8 <- (253,1) 7927304
253,0    0      274     0.041019970   291  Q FWFS 7929352 + 8 [jbd2/vda1-8]
253,0    0      275     0.041020153   291  G FWFS 7929352 + 8 [jbd2/vda1-8]
253,0    0      276     0.041107629   284  D  WS 7929352 + 8 [kworker/0:1H]
253,0    0      277     0.042000051     0  C  WS 7929352 + 8 [0]
253,0    0      278     0.042077963     0  C  WS 7929352 [0]
253,0    0      279     0.628178798   518  A  WS 25181480 + 8 <- (253,1) 25179432
253,0    0      280     0.628180716   518  Q  WS 25181480 + 8 [auditd]
253,0    0      281     0.628184067   518  G  WS 25181480 + 8 [auditd]
253,0    0      282     0.628187820   518  P   N [auditd]
253,0    0      283     0.628189061   518 UT   N [auditd] 1
253,0    0      284     0.628190268   518  I  WS 25181480 + 8 [auditd]
253,0    0      285     0.628193805   518  D  WS 25181480 + 8 [auditd]
253,0    0      286     0.629566828     0  C  WS 25181480 + 8 [0]
253,0    1      191     0.629607558   291  A  WS 7929360 + 8 <- (253,1) 7927312
253,0    1      192     0.629608842   291  Q  WS 7929360 + 8 [jbd2/vda1-8]
253,0    1      193     0.629609934   291  G  WS 7929360 + 8 [jbd2/vda1-8]
253,0    1      194     0.629611674   291  P   N [jbd2/vda1-8]
253,0    1      195     0.629612235   291  A  WS 7929368 + 8 <- (253,1) 7927320
253,0    1      196     0.629612441   291  Q  WS 7929368 + 8 [jbd2/vda1-8]
253,0    1      197     0.629613193   291  M  WS 7929368 + 8 [jbd2/vda1-8]
253,0    1      198     0.629614221   291  A  WS 7929376 + 8 <- (253,1) 7927328
253,0    1      199     0.629614410   291  Q  WS 7929376 + 8 [jbd2/vda1-8]
253,0    1      200     0.629614551   291  M  WS 7929376 + 8 [jbd2/vda1-8]
253,0    1      201     0.629614907   291  A  WS 7929384 + 8 <- (253,1) 7927336
253,0    1      202     0.629615095   291  Q  WS 7929384 + 8 [jbd2/vda1-8]
253,0    1      203     0.629615227   291  M  WS 7929384 + 8 [jbd2/vda1-8]
253,0    1      204     0.629615550   291  A  WS 7929392 + 8 <- (253,1) 7927344
253,0    1      205     0.629615736   291  Q  WS 7929392 + 8 [jbd2/vda1-8]
253,0    1      206     0.629615867   291  M  WS 7929392 + 8 [jbd2/vda1-8]
253,0    1      207     0.629616209   291  A  WS 7929400 + 8 <- (253,1) 7927352
253,0    1      208     0.629616408   291  Q  WS 7929400 + 8 [jbd2/vda1-8]
253,0    1      209     0.629616542   291  M  WS 7929400 + 8 [jbd2/vda1-8]
253,0    1      210     0.629617126   291  A  WS 7929408 + 8 <- (253,1) 7927360
253,0    1      211     0.629617240   291  Q  WS 7929408 + 8 [jbd2/vda1-8]
253,0    1      212     0.629617372   291  M  WS 7929408 + 8 [jbd2/vda1-8]
253,0    1      213     0.629617659   291  A  WS 7929416 + 8 <- (253,1) 7927368
253,0    1      214     0.629617776   291  Q  WS 7929416 + 8 [jbd2/vda1-8]
253,0    1      215     0.629617908   291  M  WS 7929416 + 8 [jbd2/vda1-8]
253,0    1      216     0.629618181   291  A  WS 7929424 + 8 <- (253,1) 7927376
253,0    1      217     0.629618298   291  Q  WS 7929424 + 8 [jbd2/vda1-8]
253,0    1      218     0.629618431   291  M  WS 7929424 + 8 [jbd2/vda1-8]
253,0    1      219     0.629618932   291  A  WS 7929432 + 8 <- (253,1) 7927384
253,0    1      220     0.629619051   291  Q  WS 7929432 + 8 [jbd2/vda1-8]
253,0    1      221     0.629619184   291  M  WS 7929432 + 8 [jbd2/vda1-8]
253,0    1      222     0.629619455   291  A  WS 7929440 + 8 <- (253,1) 7927392
253,0    1      223     0.629619568   291  Q  WS 7929440 + 8 [jbd2/vda1-8]
253,0    1      224     0.629619700   291  M  WS 7929440 + 8 [jbd2/vda1-8]
253,0    1      225     0.629619977   291  A  WS 7929448 + 8 <- (253,1) 7927400
253,0    1      226     0.629620095   291  Q  WS 7929448 + 8 [jbd2/vda1-8]
253,0    1      227     0.629620227   291  M  WS 7929448 + 8 [jbd2/vda1-8]
253,0    1      228     0.629620500   291  A  WS 7929456 + 8 <- (253,1) 7927408
253,0    1      229     0.629620616   291  Q  WS 7929456 + 8 [jbd2/vda1-8]
253,0    1      230     0.629620747   291  M  WS 7929456 + 8 [jbd2/vda1-8]
253,0    1      231     0.629620940   291  A  WS 7929464 + 8 <- (253,1) 7927416
253,0    1      232     0.629621055   291  Q  WS 7929464 + 8 [jbd2/vda1-8]
253,0    1      233     0.629621187   291  M  WS 7929464 + 8 [jbd2/vda1-8]
253,0    1      234     0.629621380   291  A  WS 7929472 + 8 <- (253,1) 7927424
253,0    1      235     0.629621578   291  Q  WS 7929472 + 8 [jbd2/vda1-8]
253,0    1      236     0.629621708   291  M  WS 7929472 + 8 [jbd2/vda1-8]
253,0    1      237     0.629622048   291  A  WS 7929480 + 8 <- (253,1) 7927432
253,0    1      238     0.629622252   291  Q  WS 7929480 + 8 [jbd2/vda1-8]
253,0    1      239     0.629622384   291  M  WS 7929480 + 8 [jbd2/vda1-8]
253,0    1      240     0.629622715   291  A  WS 7929488 + 8 <- (253,1) 7927440
253,0    1      241     0.629622903   291  Q  WS 7929488 + 8 [jbd2/vda1-8]
253,0    1      242     0.629623035   291  M  WS 7929488 + 8 [jbd2/vda1-8]
253,0    1      243     0.629623303   291  A  WS 7929496 + 8 <- (253,1) 7927448
253,0    1      244     0.629623492   291  Q  WS 7929496 + 8 [jbd2/vda1-8]
253,0    1      245     0.629623623   291  M  WS 7929496 + 8 [jbd2/vda1-8]
253,0    1      246     0.629623887   291  A  WS 7929504 + 8 <- (253,1) 7927456
253,0    1      247     0.629624007   291  Q  WS 7929504 + 8 [jbd2/vda1-8]
253,0    1      248     0.629624137   291  M  WS 7929504 + 8 [jbd2/vda1-8]
253,0    1      249     0.629624908   291 UT   N [jbd2/vda1-8] 1
253,0    1      250     0.629625461   291  I  WS 7929360 + 152 [jbd2/vda1-8]
253,0    1      251     0.629626881   291  D  WS 7929360 + 152 [jbd2/vda1-8]
253,0    0      287     0.631917933     0  C  WS 7929360 + 152 [0]
253,0    0      288     0.631942024   291  A FWFS 7929512 + 8 <- (253,1) 7927464
253,0    0      289     0.631942881   291  Q FWFS 7929512 + 8 [jbd2/vda1-8]
253,0    0      290     0.631943388   291  G FWFS 7929512 + 8 [jbd2/vda1-8]
253,0    0      291     0.632065296   284  D  WS 7929512 + 8 [kworker/0:1H]
253,0    0      292     0.632775420     0  C  WS 7929512 + 8 [0]
253,0    0      293     0.632869996     0  C  WS 7929512 [0]
253,0    0      294     6.100700399   291  A  WS 7929520 + 8 <- (253,1) 7927472
253,0    0      295     6.100702727   291  Q  WS 7929520 + 8 [jbd2/vda1-8]
253,0    0      296     6.100705727   291  G  WS 7929520 + 8 [jbd2/vda1-8]
253,0    0      297     6.100709687   291  P   N [jbd2/vda1-8]
253,0    0      298     6.100710501   291  A  WS 7929528 + 8 <- (253,1) 7927480
253,0    0      299     6.100710732   291  Q  WS 7929528 + 8 [jbd2/vda1-8]
253,0    0      300     6.100711905   291  M  WS 7929528 + 8 [jbd2/vda1-8]
253,0    0      301     6.100712603   291  A  WS 7929536 + 8 <- (253,1) 7927488
253,0    0      302     6.100712850   291  Q  WS 7929536 + 8 [jbd2/vda1-8]
253,0    0      303     6.100713058   291  M  WS 7929536 + 8 [jbd2/vda1-8]
253,0    0      304     6.100713616   291  A  WS 7929544 + 8 <- (253,1) 7927496
253,0    0      305     6.100713853   291  Q  WS 7929544 + 8 [jbd2/vda1-8]
253,0    0      306     6.100714068   291  M  WS 7929544 + 8 [jbd2/vda1-8]
253,0    0      307     6.100715136   291  A  WS 7929552 + 8 <- (253,1) 7927504
253,0    0      308     6.100715394   291  Q  WS 7929552 + 8 [jbd2/vda1-8]
253,0    0      309     6.100715624   291  M  WS 7929552 + 8 [jbd2/vda1-8]
253,0    0      310     6.100716072   291  A  WS 7929560 + 8 <- (253,1) 7927512
253,0    0      311     6.100716243   291  Q  WS 7929560 + 8 [jbd2/vda1-8]
253,0    0      312     6.100716444   291  M  WS 7929560 + 8 [jbd2/vda1-8]
253,0    0      313     6.100716910   291  A  WS 7929568 + 8 <- (253,1) 7927520
253,0    0      314     6.100717153   291  Q  WS 7929568 + 8 [jbd2/vda1-8]
253,0    0      315     6.100717376   291  M  WS 7929568 + 8 [jbd2/vda1-8]
253,0    0      316     6.100717752   291  A  WS 7929576 + 8 <- (253,1) 7927528
253,0    0      317     6.100717986   291  Q  WS 7929576 + 8 [jbd2/vda1-8]
253,0    0      318     6.100718199   291  M  WS 7929576 + 8 [jbd2/vda1-8]
253,0    0      319     6.100718688   291  A  WS 7929584 + 8 <- (253,1) 7927536
253,0    0      320     6.100718916   291  Q  WS 7929584 + 8 [jbd2/vda1-8]
253,0    0      321     6.100719137   291  M  WS 7929584 + 8 [jbd2/vda1-8]
253,0    0      322     6.100719664   291  A  WS 7929592 + 8 <- (253,1) 7927544
253,0    0      323     6.100719882   291  Q  WS 7929592 + 8 [jbd2/vda1-8]
253,0    0      324     6.100720106   291  M  WS 7929592 + 8 [jbd2/vda1-8]
253,0    0      325     6.100720506   291  A  WS 7929600 + 8 <- (253,1) 7927552
253,0    0      326     6.100720680   291  Q  WS 7929600 + 8 [jbd2/vda1-8]
253,0    0      327     6.100720907   291  M  WS 7929600 + 8 [jbd2/vda1-8]
253,0    0      328     6.100722039   291 UT   N [jbd2/vda1-8] 1
253,0    0      329     6.100722945   291  I  WS 7929520 + 88 [jbd2/vda1-8]
253,0    0      330     6.100726933   291  D  WS 7929520 + 88 [jbd2/vda1-8]
253,0    0      331     6.102471460     0  C  WS 7929520 + 88 [0]
253,0    0      332     6.102490992   291  A FWFS 7929608 + 8 <- (253,1) 7927560
253,0    0      333     6.102491627   291  Q FWFS 7929608 + 8 [jbd2/vda1-8]
253,0    0      334     6.102491999   291  G FWFS 7929608 + 8 [jbd2/vda1-8]
253,0    0      335     6.102604873   284  D  WS 7929608 + 8 [kworker/0:1H]
253,0    0      336     6.103623307     0  C  WS 7929608 + 8 [0]
253,0    0      337     6.103697330     0  C  WS 7929608 [0]
253,0    2        1     7.234825143  6234  A  WS 25475264 + 24 <- (253,1) 25473216
253,0    2        2     7.234827666  6234  Q  WS 25475264 + 24 [YDService]
253,0    2        3     7.234830346  6234  G  WS 25475264 + 24 [YDService]
253,0    2        4     7.234833032  6234  P   N [YDService]
253,0    2        5     7.234834582  6234 UT   N [YDService] 1
253,0    2        6     7.234835663  6234  I  WS 25475264 + 24 [YDService]
253,0    2        7     7.234838679  6234  D  WS 25475264 + 24 [YDService]
253,0    0      338     7.235957452     0  C  WS 25475264 + 24 [0]
253,0    0      339     7.236031308   291  A  WS 7929616 + 8 <- (253,1) 7927568
253,0    0      340     7.236032272   291  Q  WS 7929616 + 8 [jbd2/vda1-8]
253,0    0      341     7.236033847   291  G  WS 7929616 + 8 [jbd2/vda1-8]
253,0    0      342     7.236036110   291  P   N [jbd2/vda1-8]
253,0    0      343     7.236036725   291  A  WS 7929624 + 8 <- (253,1) 7927576
253,0    0      344     7.236036965   291  Q  WS 7929624 + 8 [jbd2/vda1-8]
253,0    0      345     7.236037860   291  M  WS 7929624 + 8 [jbd2/vda1-8]
253,0    0      346     7.236038571   291  A  WS 7929632 + 8 <- (253,1) 7927584
253,0    0      347     7.236038840   291  Q  WS 7929632 + 8 [jbd2/vda1-8]
253,0    0      348     7.236039076   291  M  WS 7929632 + 8 [jbd2/vda1-8]
253,0    0      349     7.236039708   291  A  WS 7929640 + 8 <- (253,1) 7927592
253,0    0      350     7.236040053   291  Q  WS 7929640 + 8 [jbd2/vda1-8]
253,0    0      351     7.236040335   291  M  WS 7929640 + 8 [jbd2/vda1-8]
253,0    0      352     7.236040794   291  A  WS 7929648 + 8 <- (253,1) 7927600
253,0    0      353     7.236041051   291  Q  WS 7929648 + 8 [jbd2/vda1-8]
253,0    0      354     7.236041283   291  M  WS 7929648 + 8 [jbd2/vda1-8]
253,0    0      355     7.236041687   291  A  WS 7929656 + 8 <- (253,1) 7927608
253,0    0      356     7.236041881   291  Q  WS 7929656 + 8 [jbd2/vda1-8]
253,0    0      357     7.236042133   291  M  WS 7929656 + 8 [jbd2/vda1-8]
253,0    0      358     7.236042477   291  A  WS 7929664 + 8 <- (253,1) 7927616
253,0    0      359     7.236042670   291  Q  WS 7929664 + 8 [jbd2/vda1-8]
253,0    0      360     7.236042905   291  M  WS 7929664 + 8 [jbd2/vda1-8]
253,0    0      361     7.236043592   291  A  WS 7929672 + 8 <- (253,1) 7927624
253,0    0      362     7.236043793   291  Q  WS 7929672 + 8 [jbd2/vda1-8]
253,0    0      363     7.236043998   291  M  WS 7929672 + 8 [jbd2/vda1-8]
253,0    0      364     7.236044477   291  A  WS 7929680 + 8 <- (253,1) 7927632
253,0    0      365     7.236044653   291  Q  WS 7929680 + 8 [jbd2/vda1-8]
253,0    0      366     7.236044869   291  M  WS 7929680 + 8 [jbd2/vda1-8]
253,0    0      367     7.236045709   291  A  WS 7929688 + 8 <- (253,1) 7927640
253,0    0      368     7.236046036   291  Q  WS 7929688 + 8 [jbd2/vda1-8]
253,0    0      369     7.236057252   291  M  WS 7929688 + 8 [jbd2/vda1-8]
253,0    0      370     7.236057852   291  A  WS 7929696 + 8 <- (253,1) 7927648
253,0    0      371     7.236058077   291  Q  WS 7929696 + 8 [jbd2/vda1-8]
253,0    0      372     7.236058286   291  M  WS 7929696 + 8 [jbd2/vda1-8]
253,0    0      373     7.236059324   291 UT   N [jbd2/vda1-8] 1
253,0    0      374     7.236060184   291  I  WS 7929616 + 88 [jbd2/vda1-8]
253,0    0      375     7.236062500   291  D  WS 7929616 + 88 [jbd2/vda1-8]
253,0    0      376     7.237660002     0  C  WS 7929616 + 88 [0]
253,0    0      377     7.237682084   291  A FWFS 7929704 + 8 <- (253,1) 7927656
253,0    0      378     7.237682713   291  Q FWFS 7929704 + 8 [jbd2/vda1-8]
253,0    0      379     7.237682989   291  G FWFS 7929704 + 8 [jbd2/vda1-8]
253,0    0      380     7.237834365   284  D  WS 7929704 + 8 [kworker/0:1H]
253,0    0      381     7.238811564     0  C  WS 7929704 + 8 [0]
253,0    0      382     7.238915905     0  C  WS 7929704 [0]
253,0    2        8     7.238986214  6234  A  WS 25475264 + 8 <- (253,1) 25473216
253,0    2        9     7.238987851  6234  Q  WS 25475264 + 8 [YDService]
253,0    2       10     7.238988819  6234  G  WS 25475264 + 8 [YDService]
253,0    2       11     7.238990407  6234  P   N [YDService]
253,0    2       12     7.238991052  6234 UT   N [YDService] 1
253,0    2       13     7.238991628  6234  I  WS 25475264 + 8 [YDService]
253,0    2       14     7.239005299  6234  D  WS 25475264 + 8 [YDService]
253,0    0      383     7.239888096     0  C  WS 25475264 + 8 [0]
253,0    0      384     7.239938613   291  A  WS 7929712 + 8 <- (253,1) 7927664
253,0    0      385     7.239939517   291  Q  WS 7929712 + 8 [jbd2/vda1-8]
253,0    0      386     7.239940231   291  G  WS 7929712 + 8 [jbd2/vda1-8]
253,0    0      387     7.239941282   291  P   N [jbd2/vda1-8]
253,0    0      388     7.239941694   291  A  WS 7929720 + 8 <- (253,1) 7927672
253,0    0      389     7.239942093   291  Q  WS 7929720 + 8 [jbd2/vda1-8]
253,0    0      390     7.239943049   291  M  WS 7929720 + 8 [jbd2/vda1-8]
253,0    0      391     7.239943816   291 UT   N [jbd2/vda1-8] 1
253,0    0      392     7.239944390   291  I  WS 7929712 + 16 [jbd2/vda1-8]
253,0    0      393     7.239945588   291  D  WS 7929712 + 16 [jbd2/vda1-8]
253,0    0      394     7.240935597     0  C  WS 7929712 + 16 [0]
253,0    0      395     7.240946972   291  A FWFS 7929728 + 8 <- (253,1) 7927680
253,0    0      396     7.240947401   291  Q FWFS 7929728 + 8 [jbd2/vda1-8]
253,0    0      397     7.240947679   291  G FWFS 7929728 + 8 [jbd2/vda1-8]
253,0    0      398     7.241051410   284  D  WS 7929728 + 8 [kworker/0:1H]
253,0    0      399     7.241991106     0  C  WS 7929728 + 8 [0]
253,0    0      400     7.242084868     0  C  WS 7929728 [0]
253,0    2       15     7.242139450  6234  A  WS 17121960 + 16 <- (253,1) 17119912
253,0    2       16     7.242140532  6234  Q  WS 17121960 + 16 [YDService]
253,0    2       17     7.242141469  6234  G  WS 17121960 + 16 [YDService]
253,0    2       18     7.242142601  6234  P   N [YDService]
253,0    2       19     7.242143182  6234 UT   N [YDService] 1
253,0    2       20     7.242143604  6234  I  WS 17121960 + 16 [YDService]
253,0    2       21     7.242144834  6234  D  WS 17121960 + 16 [YDService]
253,0    0      401     7.245747942     0  C  WS 17121960 + 16 [0]
253,0    0      402     7.245799517   291  A  WS 7929736 + 8 <- (253,1) 7927688
253,0    0      403     7.245800161   291  Q  WS 7929736 + 8 [jbd2/vda1-8]
253,0    0      404     7.245800912   291  G  WS 7929736 + 8 [jbd2/vda1-8]
253,0    0      405     7.245801994   291  P   N [jbd2/vda1-8]
253,0    0      406     7.245802497   291  A  WS 7929744 + 8 <- (253,1) 7927696
253,0    0      407     7.245802747   291  Q  WS 7929744 + 8 [jbd2/vda1-8]
253,0    0      408     7.245803266   291  M  WS 7929744 + 8 [jbd2/vda1-8]
253,0    0      409     7.245803950   291 UT   N [jbd2/vda1-8] 1
253,0    0      410     7.245804360   291  I  WS 7929736 + 16 [jbd2/vda1-8]
253,0    0      411     7.245805765   291  D  WS 7929736 + 16 [jbd2/vda1-8]
253,0    0      412     7.246696643     0  C  WS 7929736 + 16 [0]
253,0    0      413     7.246708021   291  A FWFS 7929752 + 8 <- (253,1) 7927704
253,0    0      414     7.246708418   291  Q FWFS 7929752 + 8 [jbd2/vda1-8]
253,0    0      415     7.246708677   291  G FWFS 7929752 + 8 [jbd2/vda1-8]
253,0    0      416     7.246814502   284  D  WS 7929752 + 8 [kworker/0:1H]
253,0    0      417     7.247668647     0  C  WS 7929752 + 8 [0]
253,0    0      418     7.247757651     0  C  WS 7929752 [0]
CPU0 (myvda):
 Reads Queued:           0,        0KiB  Writes Queued:          87,      348KiB
 Read Dispatches:        0,        0KiB  Write Dispatches:       34,      348KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:        0,        0KiB  Writes Completed:       72,      640KiB
 Read Merges:            0,        0KiB  Write Merges:           53,      212KiB
 Read depth:             0               Write depth:             3
 IO unplugs:             0               Timer unplugs:          17
CPU1 (myvda):
 Reads Queued:           0,        0KiB  Writes Queued:          63,      268KiB
 Read Dispatches:        0,        0KiB  Write Dispatches:       18,      268KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:        0,        0KiB  Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB  Write Merges:           45,      180KiB
 Read depth:             0               Write depth:             3
 IO unplugs:             0               Timer unplugs:          13
CPU2 (myvda):
 Reads Queued:           0,        0KiB  Writes Queued:           3,       24KiB
 Read Dispatches:        0,        0KiB  Write Dispatches:        3,       24KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:        0,        0KiB  Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
 Read depth:             0               Write depth:             3
 IO unplugs:             0               Timer unplugs:           3

Total (myvda):
 Reads Queued:           0,        0KiB  Writes Queued:         153,      640KiB
 Read Dispatches:        0,        0KiB  Write Dispatches:       55,      640KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:        0,        0KiB  Writes Completed:       72,      640KiB
 Read Merges:            0,        0KiB  Write Merges:           98,      392KiB
 IO unplugs:             0               Timer unplugs:          33

Throughput (R/W): 0KiB/s / 88KiB/s
Events (myvda): 690 entries
Skips: 0 forward (0 -   0.0%)
[root@VM-0-16-centos mydata]# ls
myvdabin  myvda.blktrace.0  myvda.blktrace.1  myvda.blktrace.2  myvda.blktrace.3
[root@VM-0-16-centos mydata]# btt -I iostatreport  -i myvdabin
==================== All Devices ====================

            ALL           MIN           AVG           MAX           N
--------------- ------------- ------------- ------------- -----------
Q2Qdm             0.000000438   0.047675694   5.468759846         152
Q2Cdm             0.000631999   0.001516763   0.003607410         153

Q2G               0.000000160   0.000000786   0.000004391          55
G2I               0.000001009   0.000004959   0.000026337          38
Q2M               0.000000126   0.000000332   0.000011216          98
I2D               0.000000630   0.000002691   0.000017820          38
M2D               0.000001295   0.000008099   0.000024640          98
D2C               0.000630444   0.001496100   0.003603108         153

==================== Device Overhead ====================

       DEV |       Q2G       G2I       Q2M       I2D       D2C
---------- | --------- --------- --------- --------- ---------

==================== Device Merge Information ====================

       DEV |       #Q       #D   Ratio |   BLKmin   BLKavg   BLKmax    Total
---------- | -------- -------- ------- | -------- -------- -------- --------
 (253,  0) |      153       55     2.8 |        8       23      224     1280

==================== Device Q2Q Seek Information ====================

       DEV |          NSEEKS            MEAN          MEDIAN | MODE           
---------- | --------------- --------------- --------------- | ---------------
 (253,  0) |             153       3417216.7               0 | 0(116)
---------- | --------------- --------------- --------------- | ---------------
   Overall |          NSEEKS            MEAN          MEDIAN | MODE           
   Average |             153       3417216.7               0 | 0(116)

==================== Device D2D Seek Information ====================

       DEV |          NSEEKS            MEAN          MEDIAN | MODE           
---------- | --------------- --------------- --------------- | ---------------
 (253,  0) |              55       9506075.1               0 | 0(18)
---------- | --------------- --------------- --------------- | ---------------
   Overall |          NSEEKS            MEAN          MEDIAN | MODE           
   Average |              55       9506075.1               0 | 0(18)

==================== Plug Information ====================

       DEV |    # Plugs # Timer Us  | % Time Q Plugged
---------- | ---------- ----------  | ----------------
 (253,  0) |          0(        33) |   0.001672731%

       DEV |    IOs/Unp   IOs/Unp(to)
---------- | ----------   ----------
 (253,  0) |        0.0          1.2
---------- | ----------   ----------
   Overall |    IOs/Unp   IOs/Unp(to)
   Average |        0.0          1.2

==================== Active Requests At Q Information ====================

       DEV |  Avg Reqs @ Q
---------- | -------------

==================== I/O Active Period Information ====================

       DEV |     # Live      Avg. Act     Avg. !Act % Live
---------- | ---------- ------------- ------------- ------
 (253,  0) |         50   0.001091889   0.146797433   0.75
---------- | ---------- ------------- ------------- ------
 Total Sys |         50   0.001091889   0.146797433   0.75

# Total System
#     Total System : q activity
  0.000002963   0.0
  0.000002963   0.4
  0.041019970   0.4
  0.041019970   0.0
  0.628180716   0.0
  0.628180716   0.4
  0.631942881   0.4
  0.631942881   0.0
  6.100702727   0.0
  6.100702727   0.4
  6.102491627   0.4
  6.102491627   0.0
  7.234827666   0.0
  7.234827666   0.4
  7.246708418   0.4
  7.246708418   0.0

#     Total System : c activity
  0.000910827   0.5
  0.000910827   0.9
  0.042000051   0.9
  0.042000051   0.5
  0.629566828   0.5
  0.629566828   0.9
  0.632775420   0.9
  0.632775420   0.5
  6.102471460   0.5
  6.102471460   0.9
  6.103623307   0.9
  6.103623307   0.5
  7.235957452   0.5
  7.235957452   0.9
  7.247668647   0.9
  7.247668647   0.5

# Per process
#        YDService : q activity
  7.234827666   1.0
  7.234827666   1.4
  7.242140532   1.4
  7.242140532   1.0

#        YDService : c activity

#           auditd : q activity
  0.628180716   2.0
  0.628180716   2.4
  0.628180716   2.4
  0.628180716   2.0

#           auditd : c activity

#      barad_agent : q activity
  0.000002963   3.0
  0.000002963   3.4
  0.039442111   3.4
  0.039442111   3.0

#      barad_agent : c activity

#             jbd2 : q activity
  0.000961174   4.0
  0.000961174   4.4
  0.041019970   4.4
  0.041019970   4.0
  0.629608842   4.0
  0.629608842   4.4
  0.631942881   4.4
  0.631942881   4.0
  6.100702727   4.0
  6.100702727   4.4
  6.102491627   4.4
  6.102491627   4.0
  7.236032272   4.0
  7.236032272   4.4
  7.246708418   4.4
  7.246708418   4.0

#             jbd2 : c activity

#           kernel : q activity

#           kernel : c activity
  0.000910827   5.5
  0.000910827   5.9
  0.042000051   5.9
  0.042000051   5.5
  0.629566828   5.5
  0.629566828   5.9
  0.632775420   5.9
  0.632775420   5.5
  6.102471460   5.5
  6.102471460   5.9
  6.103623307   5.9
  6.103623307   5.5
  7.235957452   5.5
  7.235957452   5.9
  7.247668647   5.9
  7.247668647   5.5
  
  [root@VM-0-16-centos mydata]# cat iostatreport 
Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s     rkB/s     wkB/s avgrq-sz avgqu-sz   await   svctm  %util   Stamp
(253,  0)       0.00    12.46    0.00    7.21      0.00    162.60      0.00     81.30    22.55   -74.00    1.40    4.12  10.37    6.10

(253,  0)       0.00     8.82    0.00    1.76      0.00     84.65      0.00     42.32    48.00   -85.98    1.61   10.23   0.26    7.23


Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s     rkB/s     wkB/s avgrq-sz avgqu-sz   await   svctm  %util   Stamp
(253,  0)       0.00    13.52    0.00    7.59      0.00    176.61      0.00     88.30    23.27   -75.91    1.40    4.22   8.95   TOTAL
```


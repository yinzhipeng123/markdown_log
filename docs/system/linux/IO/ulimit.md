## ulimit命令

`ulimit` 是一个在类 Unix 系统中用于控制进程资源限制的命令。它可以设置当前 shell 会话和所有子进程的资源使用上限。资源限制可以涵盖文件句柄数、进程数量、内存使用量等方面，防止程序过度占用系统资源，影响系统稳定性。

### 常见用途：
1. **查看当前资源限制**：执行 `ulimit` 可以显示当前的资源限制。
   
   示例：
   ```bash
   ulimit
   ```

2. **查看具体资源限制**：可以通过 `-a` 查看所有资源的限制：
   
   ```bash
   ulimit -a
   ```

3. **设置资源限制**：使用 `ulimit` 命令来设置各种资源的限制，例如：
   - `-n` 限制文件句柄的最大数量（文件描述符）。
   - `-u` 限制进程的最大数量。
   - `-s` 限制栈大小。
   - `-v` 限制虚拟内存的最大值。

   示例：
   ```bash
   ulimit -n 1024  # 设置最大文件句柄数为 1024
   ulimit -u 100    # 设置最大进程数为 100
   ```

4. **限制特定资源类型**：
   - `-c` 限制核心文件大小。
   - `-l` 限制最大锁定内存。
   - `-m` 限制最大内存大小。

5. **永久修改**：`ulimit` 的修改通常只在当前 shell 会话有效。要永久生效，可以修改 `/etc/security/limits.conf` 配置文件。

   示例：
   ```bash
   *          hard    nofile     4096
   *          soft    nofile     2048
   ```

### 常见的资源限制项：
- `core file size (-c)`：核心文件的最大大小。
- `data area size (-d)`：进程数据段的最大大小。
- `file size (-f)`：可以创建的最大文件大小。
- `stack size (-s)`：栈的最大大小。
- `cpu time (-t)`：进程允许的最大 CPU 时间（秒）。
- `max user processes (-u)`：每个用户可创建的最大进程数。
- `open files (-n)`：每个进程可以打开的最大文件描述符数量。

`ulimit` 可以帮助管理员控制进程的资源使用，以防止资源过度消耗，进而保障系统的稳定性。



命令中文手册：https://manpages.debian.org/unstable/manpages-zh/ulimit.1.zh_CN.html

命令快速帮助：https://wangchujiang.com/linux-command/c/ulimit.html



```bash
[root@VM-0-16-centos ~]# ulimit -a
real-time non-blocking time  (microseconds, -R) unlimited
core file size              (blocks, -c) 0
data seg size               (kbytes, -d) unlimited
scheduling priority                 (-e) 0
file size                   (blocks, -f) unlimited
pending signals                     (-i) 29588
max locked memory           (kbytes, -l) 64
max memory size             (kbytes, -m) unlimited
open files                          (-n) 1024
pipe size                (512 bytes, -p) 8
POSIX message queues         (bytes, -q) 819200
real-time priority                  (-r) 0
stack size                  (kbytes, -s) 8192
cpu time                   (seconds, -t) unlimited
max user processes                  (-u) 29588
virtual memory              (kbytes, -v) unlimited
file locks                          (-x) unlimited
翻译
实时非阻塞时间            (微秒, -R) 无限制
核心文件大小              (块, -c) 0
数据段大小               (千字节, -d) 无限制
调度优先级               (-e) 0
文件大小                 (块, -f) 无限制
待处理信号               (-i) 29588
最大锁定内存             (千字节, -l) 64
最大内存大小             (千字节, -m) 无限制
打开的文件数量           (-n) 1024
管道大小                 (512 字节, -p) 8
POSIX 消息队列           (字节, -q) 819200
实时优先级               (-r) 0
栈大小                   (千字节, -s) 8192
CPU 时间                  (秒, -t) 无限制
最大用户进程数           (-u) 29588
虚拟内存                 (千字节, -v) 无限制
文件锁                   (-x) 无限制

```







`limit` 文件和 `ulimit` 命令是相关的。`limit` 文件通常是指 `/etc/security/limits.conf` 文件，这是一个配置文件，用于定义用户和组的资源限制，类似于 `ulimit` 命令的功能，但它通常用于系统的长期配置。

## `/etc/security/limits.conf` 文件

这个文件用于设置用户和组的资源限制，它允许系统管理员对不同用户或用户组应用不同的资源限制。该文件中的设置会在用户登录时生效，并且影响整个会话，而不仅仅是当前的 shell。

#### 配置格式：
`limits.conf` 文件的格式如下：
```
<用户名或组名> <限制类型> <资源> <限制值>
```

- `<用户名或组名>`：指定某个用户或组，使用 `*` 可以应用于所有用户。
- `<限制类型>`：可以是 `soft`（软限制）或 `hard`（硬限制）。
  - `soft`：表示软限制，用户可以在该限制范围内进行调整，但不能超过硬限制。
  - `hard`：表示硬限制，这是系统设置的最大限制，不能被超过。
- `<资源>`：指定要限制的资源类型，例如 `nofile`（最大文件描述符数）、`nproc`（最大进程数）、`memlock`（最大锁定内存）等。
- `<限制值>`：设置的具体限制值。

#### 常见的配置示例：
```
# 对所有用户应用限制
*               soft    nofile          1024
*               hard    nofile          4096
*               soft    nproc           2048
*               hard    nproc           4096

# 对特定用户应用限制
username        soft    nofile          2048
username        hard    nofile          8192
```

#### 相关资源类型：
- `nofile`：最大打开文件数。
- `nproc`：最大进程数。
- `memlock`：最大锁定内存量。
- `fsize`：最大文件大小。
- `cpu`：最大 CPU 时间。
- `data`：最大数据段大小。
- `stack`：最大栈大小。
- `rss`：最大驻留集大小。

### 配合 `ulimit` 使用
- `ulimit` 命令一般用来查看或临时设置当前会话的资源限制，而 `/etc/security/limits.conf` 文件是设置用户和系统级别的资源限制，通常是在用户登录时生效。
- `ulimit` 设置通常只在当前 shell 会话中有效，而 `/etc/security/limits.conf` 文件中的限制在用户登录时会被系统读取并应用。

总结来说，`limits.conf` 文件提供了一个持久的、系统级别的资源限制机制，而 `ulimit` 命令用于查看和临时调整当前会话的限制。







`/etc/security/limits.d/` 目录是 Linux 系统中用于存放多个资源限制配置文件的目录，它与 `/etc/security/limits.conf` 文件有类似的功能，但提供了更加灵活和模块化的配置方式。

## `/etc/security/limits.d/` 目录
这个目录用于存放独立的配置文件，每个文件都可以包含不同用户或组的资源限制配置。这些文件会在系统启动或用户登录时被读取和应用，从而允许管理员以更加细粒度和模块化的方式配置不同用户或用户组的资源限制。

#### 特点：
- 通过在 `/etc/security/limits.d/` 目录下添加多个配置文件，系统管理员可以根据需要为不同的用户、组或服务提供专门的资源限制，而无需修改全局的 `/etc/security/limits.conf` 文件。
- 文件的命名通常以 `.conf` 结尾，例如：`/etc/security/limits.d/90-nproc.conf`，这种命名方式有助于区分不同的配置文件。

#### 配置文件的格式：
与 `/etc/security/limits.conf` 文件的格式相同，配置文件中的每一行都指定了一个用户或组的资源限制，格式如下：
```
<用户名或组名> <限制类型> <资源> <限制值>
```

#### 示例：
假设你想为特定的服务或用户应用资源限制，你可以在 `/etc/security/limits.d/` 目录下创建相应的配置文件。

例如，创建一个文件 `/etc/security/limits.d/90-user-limits.conf`，内容如下：
```
# 对特定用户 'exampleuser' 设置资源限制
exampleuser   soft    nofile          2048
exampleuser   hard    nofile          8192
exampleuser   soft    nproc           1024
exampleuser   hard    nproc           2048
```

这将为用户 `exampleuser` 设置最大文件描述符数为 2048（软限制）和 8192（硬限制），以及最大进程数为 1024（软限制）和 2048（硬限制）。

#### 配置文件的加载顺序：
- 系统会按照字母顺序读取 `/etc/security/limits.d/` 目录下的所有 `.conf` 配置文件，并将它们与 `/etc/security/limits.conf` 中的配置合并。因此，管理员可以使用数字前缀（如 `90-`）来控制文件的加载顺序。
- 如果在多个配置文件中定义了相同的资源限制，后加载的文件会覆盖前面加载的设置。

### 典型用法：
- **服务级别的配置**：某些服务可能需要与其他服务或用户不同的资源限制。例如，`nginx`、`mysql` 等服务可能会有自己的资源限制要求，可以在 `/etc/security/limits.d/` 下为这些服务创建专门的配置文件。
- **大规模用户管理**：对于一个有大量用户的系统，使用 `/etc/security/limits.d/` 目录可以方便地将不同的资源限制应用到不同的用户组，而不需要修改一个大而复杂的 `/etc/security/limits.conf` 文件。

### 总结：
`/etc/security/limits.d/` 目录提供了一个更加灵活和模块化的方式来管理用户和组的资源限制配置。它允许管理员为不同的用户或服务单独设置资源限制，而不需要修改全局配置文件 `limits.conf`。
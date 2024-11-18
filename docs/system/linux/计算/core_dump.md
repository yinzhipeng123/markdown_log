配置 Core Dump 文件的生成和存储在 Linux 中需要几个步骤，确保在进程崩溃时能够记录完整的进程内存和状态。下面是一个详细的配置步骤和示例：

### 1. **启用 Core Dump 生成**

首先，需要确保操作系统允许生成 Core Dump 文件。可以通过 `ulimit` 命令来配置：

- 打开一个终端，并执行以下命令来设置进程可以生成 `core dump` 文件：
  ```bash
  ulimit -c unlimited  # 允许生成无限大小的core dump
  ```

如果不设置，默认情况下，进程崩溃时不会生成 core dump 文件。`unlimited` 表示没有大小限制。

### 2. **设置 Core Dump 文件路径和文件名模式**

接下来，需要设置 core dump 文件保存的路径和命名方式。这可以通过修改 `/proc/sys/kernel/core_pattern` 文件来实现。

默认情况下，core dump 文件会被保存在进程启动目录中。你可以修改这个配置，使得所有进程崩溃时生成的 core dump 文件都存放在指定目录，并且可以自定义文件名。

- 设置 core dump 文件存放的路径和文件名模式（例如：`/tmp/core.<进程名>.<进程ID>`）：
  ```bash
  echo "/tmp/core.%e.%p" > /proc/sys/kernel/core_pattern
  ```

  这里：
  - `%e` 表示进程的可执行文件名。
  - `%p` 表示进程的 PID。

这意味着所有的 core dump 文件都会保存在 `/tmp` 目录下，并且文件名为 `core.<进程名>.<进程ID>` 的格式。

### 3. **修改 `sysctl` 配置（持久化）**

为了让设置在重启后仍然有效，可以将该设置写入到 `/etc/sysctl.conf` 文件中。

- 打开 `/etc/sysctl.conf` 文件：
  ```bash
  sudo vi /etc/sysctl.conf
  ```

- 在文件中添加以下行：
  ```bash
  kernel.core_pattern = /tmp/core.%e.%p
  ```

- 然后，执行以下命令来使配置生效：
  ```bash
  sudo sysctl -p
  ```

### 4. **设置目录权限**

确保目标目录（在本例中为 `/tmp`）具有足够的权限来存储 core dump 文件。如果你选择其他目录，请确保它具有适当的写权限。

例如，确保 `/tmp` 目录可写：
```bash
sudo chmod 1777 /tmp
```

### 5. **调试进程并生成 Core Dump**

完成上述配置后，当某个进程崩溃时，操作系统将生成 core dump 文件。你可以通过 `ulimit` 命令验证是否已启用 core dump 文件：
```bash
ulimit -a  # 确保 core file size 是 unlimited
```

示例：可以通过模拟一个崩溃的进程来测试配置，创建一个简单的 C 程序：

#### demo.c
```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("This is a test for core dump\n");

    // 模拟崩溃
    int *ptr = NULL;
    *ptr = 42;  // 这将导致崩溃
}
```

编译并运行：
```bash
gcc demo.c -o demo
./demo
```

当程序崩溃时，Core Dump 文件应该会生成在 `/tmp/core.demo.<PID>` 路径下。

### 6. **分析 Core Dump**

你可以使用 `gdb` 来分析生成的 core dump 文件。例如：
```bash
gdb /path/to/demo /tmp/core.demo.12345
```

在 GDB 中，你可以查看崩溃时的堆栈跟踪、变量值等信息，帮助你定位问题。

### 总结

1. 使用 `ulimit` 设置允许生成 Core Dump 文件。
2. 配置 `/proc/sys/kernel/core_pattern` 来设置生成的 Core Dump 文件的路径和命名格式。
3. 确保目标目录具有写权限。
4. 通过编写简单程序模拟崩溃并测试配置。

通过这些步骤，Linux 系统就能够在进程崩溃时生成 Core Dump 文件，便于后续的调试和分析。
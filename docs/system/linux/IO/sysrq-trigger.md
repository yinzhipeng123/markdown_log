## `/proc/sysrq-trigger` 

`/proc/sysrq-trigger` 是 Linux 系统中的一个伪文件，用于直接触发 **SysRq (System Request)** 按键功能。SysRq 是一种低级别的调试和应急管理功能，提供了一种在系统出现问题（如死机或卡死）时进行操作的方法。

### 功能和作用
通过向 `/proc/sysrq-trigger` 写入特定的命令字符，可以模拟按下 `Alt + SysRq` 键组合，从而执行对应的系统操作。这种机制主要用于调试和应对系统问题。

#### 常见用法
向 `/proc/sysrq-trigger` 写入一个字符（如 `b`、`c` 等）即可触发对应功能。例如：

```bash
echo b > /proc/sysrq-trigger
```

上面的命令会触发立即重启操作，相当于按下 `Alt + SysRq + b`。

### 支持的命令字符
以下是常见的 SysRq 功能及其对应的字符：

| 字符 | 功能描述                                |
| ---- | --------------------------------------- |
| `b`  | 立即重启系统，不执行卸载或同步操作。    |
| `c`  | 触发内核崩溃（crash，适用于调试目的）。 |
| `d`  | 显示当前所有 CPU 的运行状态。           |
| `e`  | 向所有进程发送 `SIGTERM` 信号。         |
| `f`  | 触发内存 OOM（Out-Of-Memory）杀手。     |
| `h`  | 显示帮助信息，列出所有支持的命令。      |
| `i`  | 向所有进程发送 `SIGKILL` 信号。         |
| `k`  | 终止所有控制台上的进程。                |
| `m`  | 显示内存信息。                          |
| `o`  | 立即关闭系统（关机）。                  |
| `p`  | 显示当前 CPU 寄存器信息。               |
| `r`  | 重新启用键盘（通常在 X 崩溃时使用）。   |
| `s`  | 将所有内存中的数据同步到磁盘。          |
| `u`  | 重新挂载所有文件系统为只读模式。        |
| `w`  | 显示任务队列信息。                      |

### 使用场景
1. **系统卡死时恢复控制**：当系统无法响应普通输入时，可以通过 SysRq 功能安全重启或调试。
2. **调试和排障**：在内核开发或排查问题时，使用 `m`、`t` 等选项获取系统状态。
3. **强制关机/重启**：在系统无法正常关机或重启时，通过 `b` 或 `o` 快速恢复。

### 注意事项
1. **权限**：写入 `/proc/sysrq-trigger` 需要超级用户权限（`root` 权限）。
2. **安全性**：启用 SysRq 功能可能存在安全隐患（如非授权用户滥用），建议只在需要时启用。
3. **启用/禁用 SysRq**：SysRq 功能可以通过 `/proc/sys/kernel/sysrq` 控制：
   - `echo 1 > /proc/sys/kernel/sysrq` 启用。
   - `echo 0 > /proc/sys/kernel/sysrq` 禁用。

SysRq 是一种强大但需要谨慎使用的工具，适合于系统维护和调试。
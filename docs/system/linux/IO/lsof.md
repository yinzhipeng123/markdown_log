# lsof命令



`lsof`（List Open Files）是一个在Unix、Linux和类Unix系统上非常有用的命令，它用于列出系统中当前打开的文件。由于在Unix和Linux系统中，几乎一切都是文件（包括设备和网络套接字），`lsof`命令变得非常强大和多用途。以下是一些常见的`lsof`用法：

1. **列出所有打开的文件**：仅输入`lsof`命令会列出系统中所有打开的文件。
2. **按照用户筛选**：`lsof -u username`会列出特定用户打开的文件。
3. **查找特定进程打开的文件**：`lsof -p pid`会列出特定进程ID（PID）打开的文件。
4. **查看某个端口的使用情况**：`lsof -i :port`可以查看哪些进程正在使用特定的网络端口。
5. **列出某个目录下被打开的文件**：`lsof +D /path/to/directory`会显示在指定目录下所有被打开的文件。
6. **查找打开某个文件的进程**：`lsof /path/to/file`会列出打开特定文件的所有进程。
7. **显示网络连接**：`lsof -i`用于显示所有网络连接。
8. **列出所有UNIX域套接字**：`lsof -U`用于查看所有UNIX域套接字。
9. **组合使用多个选项**：你可以组合使用多个选项，例如`lsof -u user -i`来查找特定用户打开的网络连接。
10. **查看特定类型的文件**：`lsof -t type`，其中`type`可以是`REG`（常规文件）、`DIR`（目录）、`CHR`（字符设备）、`BLK`（块设备）等。



这些是`lsof`命令输出中各列的意义：

1. **COMMAND**：显示打开文件的进程的命令名或程序名。
2. **PID**：表示打开该文件的进程的进程标识号（Process ID）。
3. **TID**：线程ID（Thread ID）。如果输出中包含这一列，它表示特定线程而不是整个进程打开了文件。
4. **USER**：显示打开文件的进程的所属用户。
5. **FD**：文件描述符。它是一个用于表示进程打开的文件的标记。这个标记可以是一个数字（如1，2，3...），也可以是以下特殊字符之一：
   - `cwd`：表示当前工作目录。
   - `txt`：表示程序代码本身。
   - `mem`：表示内存映射文件，通常是共享库或程序的一部分。
   - `rtd`：表示根目录。
   - `DEL`：表示已删除的文件。
6. **TYPE**：文件的类型，例如：
   - `DIR`：目录
   - `REG`：常规文件
   - `CHR`：字符设备
   - `BLK`：块设备
   - `FIFO`：管道
   - `SOCK`：套接字
7. **DEVICE**：显示文件所在的设备号。通常对于磁盘文件，这代表文件系统的设备。
8. **SIZE/OFF**：对于普通文件，这是文件的大小。对于某些特殊文件，如网络套接字或管道，这可能表示一个偏移量或者不同的数据。
9. **NODE**：文件的inode编号，这是一个文件系统中文件的唯一标识。
10. **NAME**：文件的名称和路径，或者是设备、网络连接的详细信息。



[lsof 命令，Linux lsof 命令详解：显示Linux系统当前已打开的所有文件列表 `lsof -p pid` - Linux 命令搜索引擎 (wangchujiang.com)](https://wangchujiang.com/linux-command/c/lsof.html)
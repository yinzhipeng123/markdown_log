`supervisord` 是一个**进程管理工具**，全称是 **Supervisor Daemon**。它主要用来**管理和监控** Linux/Unix 系统中的**进程**，尤其是让一些程序（比如 web 服务、后台脚本等）**在崩溃后自动重启**，保持服务持续运行。

简单说，`supervisord` 可以帮你做到：

- 启动、停止、重启你指定的程序。
- 程序崩了，它能自动帮你重启。
- 把程序的输出（标准输出、错误输出）集中管理、记录。
- 通过命令行或者 Web 界面统一管理进程。
- 设置进程的优先级、重启策略、启动顺序等等。

### 它由两部分组成：

- **supervisord**：后台常驻程序，真正执行管理工作的守护进程。
- **supervisorctl**：命令行工具，用来和 `supervisord` 通讯，执行启动/停止/查看状态等操作。

### 常见使用场景

- 启动 Python 的 Web 服务，比如 `gunicorn`。
- 管理 Node.js 后台服务。
- 保持一些需要一直运行的脚本不断开。
- Docker 容器里启动多个服务（虽然现在一般更推荐用专门的进程管理器或者分开运行）。

### 一个简单示例

你可以写一个配置文件 `/etc/supervisord.conf` 或者 `/etc/supervisor/conf.d/myapp.conf`：

```ini
[program:myapp]
command=python /path/to/app.py
directory=/path/to/
autostart=true
autorestart=true
stderr_logfile=/var/log/myapp.err.log
stdout_logfile=/var/log/myapp.out.log
```

意思是让 Supervisor 管理 `python /path/to/app.py` 这个程序：

- 启动时自动运行（`autostart=true`）
- 如果崩溃了，自动重启（`autorestart=true`）
- 把输出记录到指定日志文件里。



配置文件官方介绍：https://supervisord.org/configuration.html
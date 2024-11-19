`siege` 是一个功能强大的 HTTP 负载测试和基准测试工具，用于评估 Web 服务器的性能和稳定性。它支持模拟多个用户同时向目标服务器发送请求，从而帮助测试服务器在高负载情况下的表现。

### `siege` 的主要功能
1. **压力测试**：通过模拟并发用户来测试服务器的性能。
2. **基准测试**：测量服务器的响应时间、吞吐量等性能指标。
3. **支持多种协议**：支持 HTTP 和 HTTPS 请求。
4. **易于配置**：可以通过配置文件或命令行直接定义测试参数。
5. **日志和统计报告**：提供详细的请求日志和测试结果汇总。

---

### 安装方法
在 Linux 上，你可以通过以下方式安装 `siege`：

#### Ubuntu/Debian：
```bash
sudo apt update
sudo apt install siege
```

#### CentOS/RHEL：
```bash
sudo yum install siege
```

#### MacOS（通过 Homebrew）：
```bash
brew install siege
```

---

### 使用示例

1. **简单测试一个 URL**：
   ```bash
   siege -c 10 -t 1M https://example.com
   ```
   - `-c 10`：模拟 10 个并发用户。
   - `-t 1M`：测试持续时间为 1 分钟。
   - `https://example.com`：目标 URL。

2. **测试 URL 列表**：
   创建一个 `urls.txt` 文件，里面列出多个 URL：
   ```
   https://example.com/page1
   https://example.com/page2
   ```
   然后执行：
   ```bash
   siege -c 20 -t 2M -f urls.txt
   ```
   - `-f urls.txt`：从文件中读取 URL。

3. **指定请求方法和数据**：
   ```bash
   siege -c 10 -t 30S -m "POST Test" -H "Content-Type: application/json" \
         'https://example.com/api POST {"key":"value"}'
   ```
   - `-m "POST Test"`：为测试命名。
   - `-H "Content-Type: application/json"`：指定请求头。
   - `'URL POST data'`：发送 POST 请求及其数据。

4. **压力测试模式**：
   使用 `--benchmark` 选项运行基准测试：
   ```bash
   siege --benchmark https://example.com
   ```

---

### 常见选项
| 选项          | 描述                               |
| ------------- | ---------------------------------- |
| `-c`          | 设置并发用户数                     |
| `-t`          | 设置测试持续时间（如 10S、2M、1H） |
| `-f`          | 指定包含 URL 的文件路径            |
| `-d`          | 设置用户之间请求的随机延迟（秒）   |
| `-H`          | 添加自定义 HTTP 请求头             |
| `-l`          | 启用日志记录                       |
| `--benchmark` | 启动基准测试模式，仅报告性能数据   |

`siege` 是一个非常实用的工具，特别适合 Web 开发人员、测试工程师以及运维人员在发布或优化服务器时使用。如果有更具体的问题或想要更高级的用法，可以随时告诉我！



help中文手册

```bash
[root@VM-0-16-centos ~]# siege --help
新的配置模板已添加到 /root/.siege
运行 siege -C 查看该文件中的当前设置
SIEGE 4.1.4
用法: siege [选项]
       siege [选项] URL
       siege -g URL
选项:
  -V, --version             版本号，打印版本信息。
  -h, --help                帮助，打印本部分内容。
  -C, --config              配置，显示当前配置。
  -v, --verbose             详细模式，打印通知到屏幕。
  -q, --quiet               静默模式，关闭详细模式并抑制输出。
  -g, --get                 GET，拉取 HTTP 头并显示事务。适合调试应用程序。
  -p, --print               打印，与 GET 类似，但会打印整个页面内容。
  -c, --concurrent=NUM      并发用户数，默认是 10。 此选项允许您设置并发用户数。从技术上讲，用户总数仅限于计算机的资源。
您配置的用户不应超过您的web服务器配置要处理的用户数。例如，默认的apache配置限制为255个线程。如果使用-c1024运行seave，那么769个seave用户将等待apache处理程序。因此，默认的siege配置限制为255个用户。你可以在里面增加这个数字siege.conf但是如果你把事情搞得一团糟，那么请不要向我们抱怨
  -r, --reps=NUM            重复次数，设置测试运行的次数。
  -t, --time=NUMm           定时测试，其中 "m" 是修饰符 S（秒）、M（分钟）或 H（小时）。
                            示例: --time=1H，测试 1 小时。此选项类似于--reps，但它没有指定每个用户应运行的次数，而是指定每个用户应运行的时间量。值格式是“NUMm”，其中“NUM”是时间量，“m”修饰符是S、m或H，表示秒、分和小时。要运行一个小时的siege，您可以选择以下任意组合：-t360s、-t60M、-t1H。修饰符不区分大小写，但它不需要数字和它本身之间的空格。
                       
  -d, --delay=NUM           时间延迟，在每次请求之前随机延迟。
  -b, --benchmark           基准测试模式：请求之间没有延迟。
  -i, --internet            模拟互联网用户，随机访问 URL。
  -f, --file=FILE           文件，选择特定的 URL 文件。
  -R, --rc=FILE             RC，指定一个 siegerc 配置文件。
  -l, --log[=FILE]          日志记录到文件。如果未指定文件，
                            默认路径为：PREFIX/var/siege.log。
  -m, --mark="text"         标记，用一个字符串标记日志文件。
  -H, --header="text"       添加请求头（可以有多个）。
  -A, --user-agent="text"   设置请求中的 User-Agent。
  -T, --content-type="text" 设置请求中的 Content-Type。
  -j, --json-output         JSON 输出，以 JSON 格式将最终统计信息打印到标准输出。
      --no-parser           关闭 HTML 页面解析器。
      --no-follow           不跟随 HTTP 重定向。

版权所有 (C) 2022 由 Jeffrey Fulmer 等人创作。
这是自由软件；请参阅源码以了解复制条件。
没有任何担保；即使关于适销性或特定用途适用性亦无担保。

```



```bash
siege  -c 1 -r 1  http://127.0.0.1:5000/myget
一个并发 测试一次

siege  -c 2 -r 1  http://127.0.0.1:5000/myget
两个并发 测试一次  测试总测试为  2*1=2

siege  -c 1 -r 2 http://127.0.0.1:5000/myget
一个并发 测试两次  测试总测试为  2*1=2

siege  -c 1 -t 2s http://127.0.0.1:5000/myget
一个并发 一共发起2s的请求
```





```bash
Siege输出结果说明
Transactions: 总共测试次数
Availability: 成功次数百分比
Elapsed time: 总共耗时多少秒
Data transferred: 总共数据传输
Response time: 等到响应耗时
Transaction rate: 平均每秒处理请求数
Throughput: 吞吐率
Concurrency: 最高并发
Successful transactions: 成功的请求数
Failed transactions: 失败的请求数
```


# Python控制台输出重定向到日志并控制日志大小

python控制台输出，可以输出print和一些error信息。那么启动python的时候可以重定向控制台的输出信息到日志文件中

```bash
mkdir -p /app/example/log
touch /app/example/example.py
```

编辑python文件，设置日志文件及最大大小和保存个数、及日志样式

```python
import os
import time
import traceback
import schedule
import logging
import colorlog
import sys

# ————————日志————————
logfilename = "/app/example/log/example.log"
log_colors_config = {
    'DEBUG': 'white',
    'INFO': 'green',
    'WARNING': 'yellow',
    'ERROR': 'red',
    'CRITICAL': 'bold_red',
}
logger = logging.getLogger(__name__)
logger.setLevel(level=logging.DEBUG)
# 设置日志文件大小
handler = logging.handlers.RotatingFileHandler(logfilename, encoding='utf-8',
                                               maxBytes=100 * 1024 * 1024,
                                               backupCount=10)

# 输出到文件的日志级别
handler.setLevel(logging.INFO)
# 日志样式
formatter = logging.Formatter(
    '%(asctime)s-%(name)s-%(filename)s-[line:%(lineno)d]-%(levelname)s-[日志信息]: %(message)s')
# 控制台日志样式
formatter_color = colorlog.ColoredFormatter(
    '%(log_color)s%(asctime)s-%(name)s-%(filename)s-[line:%(lineno)d]-%(levelname)s-[日志信息]: %(message)s',
    log_colors=log_colors_config)

# 控制台的日志
console = logging.StreamHandler(stream=sys.stdout)
# 控制台的日志级别
console.setLevel(logging.DEBUG)
# 设置日志样式
handler.setFormatter(formatter)
# 设置控制台日志样式
console.setFormatter(formatter_color)
#添加输出
logger.addHandler(handler)
logger.addHandler(console)
# ————————日志————————



logger.info("cron start")
try:
    logger.info("dir:" + os.getcwd())
    while True:
        time.sleep(1)
        print("hello")

except Exception as e:
    logger.error(e)
    logger.error(traceback.print_exc())
```

到此，example.py中 ` logger.info` 和 `logger.error` 日志会输出到 `日志文件` 中 和 `控制台` 上，`print` 语句会输出到控制台上

用下面的方式启动，控制台的输出会都出现在 `/app/example/log/example.log` 文件中

一开始我以为` logger.info` 和 `logger.error` 会在日志中出现两次，逻辑上，代码中指定了一遍控制台输出，通过命令指定了一遍控制台输出，后来发现并没有，只会在日志中出现一次。而且日志大小正常被切割

```bash
nohup python3  /app/example/example.py > /app/example/log/example.log 2>&1 &
```


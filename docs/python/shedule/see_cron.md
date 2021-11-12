# schedule  日志显示下次任务执行时间

https://schedule.readthedocs.io/en/stable/examples.html

schedule进行定时任务管理非常好用，通过`get_jobs`方法可以获取当前的定时任务详情，可以在子线程中，不断打印定时任务的详情

```python
import schedule
import threading
import time
import colorlog
import logging.handlers
import sys
# ————————日志————————
logfilename = "learn_schedule_catch.log"
log_colors_config = {
    'DEBUG': 'white',
    'INFO': 'green',
    'WARNING': 'yellow',
    'ERROR': 'red',
    'CRITICAL': 'bold_red',
}
logger = logging.getLogger(__name__)
logger.setLevel(level=logging.DEBUG)
# 设置日志文件
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
console.setFormatter(formatter_color)
logger.addHandler(handler)
logger.addHandler(console)


#需要定时执行的任务
def job():
    logger.info("I'm working...")



#设置为1分钟一次
schedule.every(1).minute.do(job)

#查看任务执行时间的方法，死循环
def see_cron():
    while True:
        time.sleep(10)
        all_jobs = schedule.get_jobs()
        logger.info(all_jobs)

#后台执行see_cron
t1 = threading.Thread(target=see_cron)
#让这个任务随主线程退出而退出
t1.setDaemon(True)
t1.start()

#打开定时任务进程
while True:
    schedule.run_pending()
    time.sleep(1)

```

结果：

```shell
2021-11-10 16:25:45,195-__main__-learn_schedule_catch.py-[line:56]-INFO-[日志信息]: [Every 1 minute do job() (last run: [never], next run: 2021-11-10 16:26:15)]
2021-11-10 16:25:55,198-__main__-learn_schedule_catch.py-[line:56]-INFO-[日志信息]: [Every 1 minute do job() (last run: [never], next run: 2021-11-10 16:26:15)]
2021-11-10 16:26:05,206-__main__-learn_schedule_catch.py-[line:56]-INFO-[日志信息]: [Every 1 minute do job() (last run: [never], next run: 2021-11-10 16:26:15)]
2021-11-10 16:26:15,209-__main__-learn_schedule_catch.py-[line:56]-INFO-[日志信息]: [Every 1 minute do job() (last run: [never], next run: 2021-11-10 16:26:15)]
2021-11-10 16:26:15,261-__main__-learn_schedule_catch.py-[line:44]-INFO-[日志信息]: I'm working...
```


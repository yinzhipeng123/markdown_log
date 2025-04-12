# crontab



crontab -e

```bash
0 19 * * * /bin/bash /root/clean_access_debug.sh
```

非交互式添加计划任务

```bash
(crontab -l; echo "0 19 * * * /root/clean_access_debug.sh") | crontab -
```

clean_access_debug.sh 示例

```bash
#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#cron的环境变量与常规不同，引入环境变量

#脚本内容
```


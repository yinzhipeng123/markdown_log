# 查看OOM评分的脚本

1. /proc/<pid>/oom_score内核通过内存消耗计算得出 
2. /proc/<pid>/oom_score_adj允许用于自定义，等同于优先级，优先级越高值越小（-1000 ~1000）。
3. /proc/<pid>/oom_adj里面，取值是-17到+15(为-17此进程不会被杀掉)，取值越高，越容易被杀掉。

```bash
#!/bin/bash
# Displays running processes in descending order of OOM score

printf 'PID\tOOM Score\tOOM Score Adj\tCommand\n'

echo -n  "$(ps -e -o pid= -o comm= | sort -k 2nr)"  | while read line
do 
pid=$(echo $line | awk '{print $1}')
comm=$(echo $line | awk '{print $2}')
[ -f /proc/$pid/oom_score ] && [ $(cat /proc/$pid/oom_score) != 0 ] && printf '%d\t%d\t\t%d\t%s\n' "$pid" "$(cat /proc/$pid/oom_score)" "$(cat /proc/$pid/oom_score_adj)" "$comm"
done 
```

OOM Score越高的先杀死，OOM Score Adj默认为0，分数越低越不容易杀死

```
PID	OOM Score	OOM Score Adj	Command
1169	2		0	tuned
1231	2		0	rsyslogd
1847	2		0	YDLive
1858	7		0	YDService
1911	2		0	sh
406		3		0	systemd-journal
710		∂1		0	polkitd
```



#### 更全的脚本

```bash
#!/bin/bash
# Displays running processes in descending order of OOM score

printf 'PID\tOOM Score\tOOM Score Adj\tOOM_Adj\tCommand\n'

echo -n  "$(ps -e -o pid= -o comm= | sort -k 2nr)"  | while read line
do 
pid=$(echo $line | awk '{print $1}')
comm=$(echo $line | awk '{print $2}')
[ -f /proc/$pid/oom_score ] && [ $(cat /proc/$pid/oom_score) != 0 ] && printf '%d\t%d\t\t%d\t\t%d\t%s\n' "$pid" "$(cat /proc/$pid/oom_score)" "$(cat /proc/$pid/oom_score_adj)" "$(cat /proc/$pid/oom_adj)" "$comm"
done 
```

OOM Score越高的先杀死，OOM Score Adj默认为0，分数越低越不容易杀死。oom_adj里面，取值是-17到+15(为-17此进程不会被杀掉)，取值越高，越容易被杀掉。

```bash
PID	OOM Score	OOM Score Adj	OOM_Adj	Command
1169	2		0	0	tuned
1231	2		0	0	rsyslogd
1847	2		0	0	YDLive
1858	7		0	0	YDService
1911	2		0	0	sh
406	3		0	0	systemd-journal
710	1		0	0	polkitd
```


查看某进程的Rss内存使用量

```bash
awk '/Rss:/{a=a+$2}END{print a/1024"M"}' /proc/PID号/smaps
```

查看某进程的swap内存使用量

```bash
awk '/Swap:/{a=a+$2}END{print a/1024"M"}' /proc/PID号/smaps
```




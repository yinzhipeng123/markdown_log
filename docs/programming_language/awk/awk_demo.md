



```bash
[root@~ ]# cat host_warn.txt  | head -n 3
node2961-zwlt.haha.com
node2961-zwlt.haha.com
node2996-zwlt.haha.com
node2255-zwlt.haha.com

[root@~ ]# cat host_belong.txt  | head -n 10
node2961-zwlt.haha.com 长江
node2962-zwlt.haha.com 黄河
```

###  使用 `awk`

```bash
awk 'NR==FNR {owner[$1]=$2; next} {print $0, owner[$1] ? owner[$1] : "未知"}' host_belong.txt host_warn.txt > host_warn_with_owner.txt
```
- `NR==FNR`：表示处理第一个文件 `host_belong.txt` 时，存储主机名和归属人到 `owner` 数组中。
- 处理 `host_warin` 时，查询 `owner` 数组，如果找到了归属人就输出，否则标记为 `"未知"`。


# awk中的匹配

### (1)模糊匹配

```bash
1)使用if         
	{if($1~/zhengxh/) print $0}
2)不用if
	'$0 ~ /zhengxh/'
awk '$0~/zhengxh/' filename
或
awk '{if($0~/zhengxh/) print $0} filename    #输出含有zhengxh的行
或
awk '/zhengxh/' filename
```

### (2)精确匹配

```bash
$n=="chars"
awk '$1=="zhengxh" {print $0}' filename        #输出第一列等于zhengxh的行
```

### (3)反向匹配

```bash
$n !~ /adf/
awk '$1 !~ /zhengxh/ {print $0}' filename    #输出第一列不是zhengxh的行
```

### (4)大小写匹配

```bash
awk '/[zZ]hengxh/'  filename     #匹配含有zhengxh 或是Zhengxh的字符串
```

### (5)使用或运算

```bash
awk '$0 ~ /(zhengxh|hover)/' filename     #查找含有zhengxh或hover字串的行
或
awk '{if($0~/zhengxh/ OR $0~/hover/) print $0}' filename

pidstat  | awk '{if($9~/1/ || $9~/2/)print $0}
```


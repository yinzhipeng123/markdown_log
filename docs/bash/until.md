# Until



语法格式

```bash
变量的初始值
until 条件表达式或者命令
do
	循环体
	变量的更新
done
```

   说明：当条件为真，退出循环
   until与while是相反的

```bash
[root@shell script]#  cat until.sh
#!/bin/bash
i=1
until [ $i -gt 5 ]
do
	echo $i
	let i++
done
```


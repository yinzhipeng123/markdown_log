# trap 

## 语法

**语法格式：**trap [参数]

**常用参数：**



| -l   | 打印信号列表                       |
| ---- | ---------------------------------- |
| -p   | 打印与每一个信号有关联的命令的列表 |



### 1、捕获脚本中的异常

​	可以捕获脚本中执行错误的命令，需要添加set -E，trap “echo 错误” ERR

#### 例：

```bash
#!/bin/bash
set -E
trap 'echo 抓住非零返回值' ERR
sub()
{
ls dfqwefi
rm fwjepf
}

sub
```



### 2、捕获Linux信号

Linux系统利用信号与系统中的进程进行通信。Linux的常见信号有：

| 信号 | 值      | 描述                           |
| :--- | :------ | :----------------------------- |
| 1    | SIGHP   | 挂起进程                       |
| 2    | SIGINT  | 终止进程                       |
| 3    | SIGQUIT | 停止进程                       |
| 9    | SIGKILL | 无条件终止进程                 |
| 15   | SIGTERM | 尽可能终止进程                 |
| 17   | SIGSTOP | 无条件停止进程，但不是终止进程 |
| 18   | SIGTSTP | 停止或暂停进程，但不终止进程   |
| 19   | SIGCONT | 继续运行停止的进程             |

Ctrl+C组合键会产生SIGINT信号，Ctrl+Z会产生SIGTSTP信号。

trap命令允许你来指定shell脚本要监视并拦截的Linux信号。trap命令的格式为：`trap commands signals`。



#### 例1：

```bash
#!/bin/bash
# test trap command
trap "echo 'Sorry! I have trapped Ctrl-C'" SIGINT

echo This is a test script

count=1
while [ $count -le 10 ]
do
  echo "Loop $count"
  sleep 1
  count=$[ $count + 1 ]
done

echo The end.
```

运行结果：

```swift
This is a test script
Loop 1
Loop 2
^CSorry! I have trapped Ctrl-C
Loop 3
Loop 4
^CSorry! I have trapped Ctrl-C
Loop 5
Loop 6
Loop 7
Loop 8
^CSorry! I have trapped Ctrl-C
Loop 9
Loop 10
The end.
```

#### 例2：

除了在shell脚本中捕获信号外，也可以在shell退出时捕获，在trap命令后加上EXIT信号就行。

```bash
#!/bin/bash
# test trap command
trap "echo Goodbye." EXIT

echo This is a test script

count=1
while [ $count -le 10 ]
do
  echo "Loop $count"
  sleep 1
  count=$[ $count + 1 ]
done

echo The end.
```

运行结果：

```bash
This is a test script
Loop 1
Loop 2
Loop 3
Loop 4
Loop 5
Loop 6
Loop 7
Loop 8
Loop 9
Loop 10
The end.
Goodbye.
```

#### 例3：

```bash
#!/bin/bash
# test trap command

trap "echo 'Sorry! I have trapped Ctrl-C'" SIGINT

count=1
while [ $count -le 5 ]
do
  echo "Loop $count"
  sleep 1
  count=$[ $count + 1 ]
done


trap "echo 'Sorry! The trap has been modified.'" SIGINT

count=1
while [ $count -le 5 ]
do
  echo "Loop $count"
  sleep 1
  count=$[ $count + 1 ]
done

echo The end.
```

运行结果：

```swift
Loop 1
Loop 2
Loop 3
^CSorry! I have trapped Ctrl-C
Loop 4
Loop 5
Loop 1
Loop 2
Loop 3
^CSorry! The trap has been modified.
Loop 4
Loop 5
The end.
```

#### 例4：

删除捕获，命令形式为：`trap - ***`，例如`trap - SIGINT`

```bash
#!/bin/bash
# test trap command

trap "echo 'Sorry! I have trapped Ctrl-C'" SIGINT

count=1
while [ $count -le 5 ]
do
  echo "Loop $count"
  sleep 1
  count=$[ $count + 1 ]
done

trap - SIGINT

count=1
while [ $count -le 5 ]
do
  echo "Loop $count"
  sleep 1
  count=$[ $count + 1 ]
done

echo The end.
```

运行结果：

```bash
Loop 1!!!
Loop 2!!!
Loop 3!!!
^CSorry! I have trapped Ctrl-C
Loop 4!!!
Loop 5!!!
Loop 1
Loop 2
^C
```


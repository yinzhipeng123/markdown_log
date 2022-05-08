# getopts

**`getopts`** 是一个[内置的](https://en.wikipedia.org/wiki/Shell_builtin) [Unix shell](https://en.wikipedia.org/wiki/Unix_shell) 命令，用于解析[命令行参数](https://en.wikipedia.org/wiki/Command-line_argument)。它旨在处理遵循 POSIX 实用程序语法准则的命令行参数，基于 [getopt](https://en.wikipedia.org/wiki/Getopt) 的 C 接口。其前身是[Unix System Laboratories](https://en.wikipedia.org/wiki/Unix_System_Laboratories)的外部程序**`getopt`**。

## 语法

**语法格式**：getopts optstring name [arg...]



例子：

```bash
#!/bin/bash
# getopts-test.sh

while getopts dc:s: o
do
    case "$o" in
        d)
            echo "d option value is $OPTARG"
            echo "d option index is $(($OPTIND-1))"
            ;;
        c)
            echo "c option value is $OPTARG"
            ;;
        s)
            echo "s option... $OPTARG"
            echo "s option index is $(($OPTIND-1))"
            ;;
       '?')
            echo "Usage: $0 [-s] [-d value] file ..."
            ;;
    esac
done
```



```bash
while getopts dc:s: o 
```

此句话意思为 比如，dc:s: 表示c参数后面会有一个值出现，-c value的形式 表示s参数后面会有一个值出现，-s value的形式

例如

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204151632857.png" alt="Untitled" style="zoom:67%;" />

所有的选项都是非必须的

例如

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204151635382.png" alt="Untitled" style="zoom:67%;" />

c后面的:  代表 -c  需要跟着 value OPTARG变量代表value值  $(($OPTIND-1))代表这个value在输入的第几个位置上

d后面没有： 则代表-d 后面不能加value

输入格式没有先后顺序 但是没有value值的 添加了value值导致后面的参数就无法识别

例如

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204151636479.png" alt="Untitled" style="zoom:67%;" />

while getopts :dc:s: o 

如果开头有冒号 代表忽略报错

正常无冒号

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204151636476.png" alt="Untitled" style="zoom:67%;" />

添加开头冒号后

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204151639309.png" alt="Untitled" style="zoom:67%;" />


case里面的 最后的`?`可以替换成 `*` 和 `[?]`
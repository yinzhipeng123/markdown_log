

一些bash的例子：



#### 在bash中设置异常捕获，监控循环中可能发生的错误

```bash
#!/bin/bash
# 可以捕获失败的循环，把错误的循环次数打印在fail.txt中

set -E
> fail.txt
trap 'echo $i >> fail.txt' ERR


for ((i=1; i<=10; i++)); do
    sleep 2s
    echo "This is iteration number $i"
    ls demo_dir
done

echo "end"
```



#### 通过带内IP地址计算带外IP地址

```bash
#!/bin/bash

#提供带内ip列表，输出一个对应的带外ip的列表
if [ $# -ne 1 ]; then
    echo "错误：请提供输入ip列表文件，输出带外ip列表文件:[文件]_ipm.txt"
    exit 1
fi

input_file=$1
output_file="${1}_ipm.txt"

# 确保输出文件是空的
> "$output_file"

# 读取每一行 IP 地址并处理
while IFS= read -r ip; do
    # 分割 IP 地址，取最后一段数字
    base_ip=$(echo "$ip" | awk -F'.' '{print $1"."$2"."$3"."}')
    last_octet=$(echo "$ip" | awk -F'.' '{print $4}')

    # 计算新的最后一段数字
    new_last_octet=$((last_octet + 128))

    # 生成新的 IP 地址并写入输出文件
    echo "${base_ip}${new_last_octet}" >> "$output_file"
done < "$input_file"

echo "处理完成！新的 IP 地址已保存到 $output_file"
```





可以显示目录中，最近有变化的10个日志，并按照距离最近的时间进行排序

```bash
#!/bin/bash

# 检查是否提供了目录路径
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

TARGET_DIR="$1"
NUM_LOGS=10

# 检查目录是否存在
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist."
    exit 1
fi

# 使用 find 查找 .log 文件，获取修改时间并排序，输出最近的文件
find "$TARGET_DIR" -type f -name "*.log" -printf "%T@ %p\n" | \
    sort -nr | \
    head -n "$NUM_LOGS" | \
    while read -r line; do
        timestamp=$(echo "$line" | awk '{print $1}')
        filepath=$(echo "$line" | awk '{$1=""; print $0}' | sed 's/^ //')
        datetime=$(date -d @"$timestamp" +"%Y-%m-%d %H:%M:%S")
        echo "$filepath - Last Modified: $datetime"
    done

```





```bash
#!/bin/bash
find "$1" -type f -name "*.log" -printf "%T@ %p\n" | sort -nr | head -n 10 | awk '{cmd = "date -d @"$1" +\"%Y-%m-%d %H:%M:%S\""; cmd | getline t; close(cmd); print $2, "- Last Modified:", t}'
```



输出 `a.txt` 中所有包含 `b.txt` 中某行内容的行

```
grep -F -f b.txt a.txt
```

批量从文件中查找内容，并显示文件名称

```
grep -rnw '/path/to/lists/' -e '192.168.1.1'
```

批量把txt文件修改成list 文件

```
for file in *.txt; do
    mv "$file" "${file%.txt}.list"
done
```
远程执行命令，提供一个主机列表，命令行后输入需要执行的命令

```bash
#!/bin/bash

# 检查参数
if [ "$#" -lt 2 ]; then
    echo "用法: $0 <machine_list_file> <command>"
    exit 1
fi

MACHINE_LIST="$1"
shift
COMMAND="$@"
USERNAME="root"  # SSH 用户名，请修改为实际的用户名
PASSWORD="centos"  # 你可以修改为从环境变量或安全方式获取密码

# 检查 sshpass 是否安装
if ! command -v sshpass &> /dev/null; then
    echo "sshpass 未安装，请先安装它 (例如：apt install sshpass 或 yum install sshpass)"
    exit 1
fi

# 读取机器列表并执行命令（串行执行，保证顺序）
for HOST in $(cat "$MACHINE_LIST"); do
    echo -n "正在连接 $HOST :"
    sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR  -o ConnectTimeout=3 "$USERNAME@$HOST" "$COMMAND"
done

echo "所有命令执行完毕。"
```





linux有个目录，我想删除除了以.sh结尾其他的文件

```bash
find ./ -type f ! -name "*.sh" -exec rm -f {} +
```

linux有个目录，我想删除除了以.sh和.bin结尾其他的文件

```bash
find ./ -type f ! -name "*.sh" ! -name "*.bin" | xargs rm -f
```

linux有个目录，我想删除除了以.sh，.bin，.gz，.jar结尾其他的文件，仅操作文件，不处理目录，仅处理一级目录中文件

```bash
find ./  -maxdepth 1  -type f ! -name "*.sh" ! -name "*.bin" ! -name "*.gz" ! -name "*.jar" | xargs rm -rf 
```





```bash
find ./ -type f -name '日志.log.2025*' ! -name '日志.log.20250304*' -exec rm {} +
```

```
find ./ -type f -name '日志.log.2025*' ! -name '日志.log.20250314*' -exec ls -l {} +
```



```
du -ah --max-depth=1 ./ | sort -rh | head -n 20
```


# 查看进程的swap使用



### 第一种脚本

```bash
#!/bin/bash
########################################
# 脚本功能 ： 列出正在占用swap的进程。
########################################
echo -e "PID\t\tSwap\tProc_Name"
 
# 拿出/proc目录下所有以数字为名的目录（进程名是数字才是进程，其他如sys,net等存放的是其他信息）
for pid in `ls -l /proc|awk '/^d/ {print $NF}'|grep ^[0-9]`
do

 # Do not check init process
 if [ $pid -eq 1 ];then continue;fi 

 # 判断改进程是否占用了swap
 grep -q "Swap" /proc/$pid/smaps 2>/dev/null

 if [ $? -eq 0 ];then # 如果占用了swap
     swap=$(grep Swap /proc/$pid/smaps| gawk '{ sum+=$2} END{ print sum }')

     # 进程名
     #proc_name=$(ps aux | grep -w "$pid" | grep -v grep 
     proc_name=$(ps -eo pid,comm | grep -w "$pid" | grep -v grep|awk '{print $NF}')

     if [ $swap -ge 0 ];then # 如果占用了swap则输出其信息
         echo -e "$pid\t${swap}\t$proc_name"
     fi
 fi
done | sort -k2 -n | gawk -F'\t' '{ 
 pid[NR]=$1;
 size[NR]=$2;
 name[NR]=$3;
}
END{
 for(id=1;id<=length(pid);id++)
 {
     if(size[id]<1024)
           printf("%-10s\t%10sKB\t%s\n",pid[id],size[id],name[id]);
     else if(size[id]<1048576)
           printf("%-10s\t%10.2fMB\t%s\n",pid[id],size[id]/1024,name[id]);
     else
   printf("%-10s\t%10.2fGB\t%s\n",pid[id],size[id]/1048576,name[id]);
 }
}'
```

结果：

```bash
PID		Swap	Proc_Name
10519     	         0KB	pickup
10579     	         0KB	sshd
10581     	         0KB	bash
1101      	         0KB	dhclient
1168      	         0KB	iscsid
1169      	         0KB	tuned
1171      	         0KB	rshim
```

### 第二种脚本

```
for i in $(ls /proc 2>/dev/null | grep "^[0-9]" ); do awk '/Swap:/{a=a+$2}END{print '"$i"',a/1024"M"}' /proc/$i/smaps;done 2>/dev/null | sort -k2nr 
```

结果：

```
10092 0M
10 0M
10519 0M
10579 0M
10581 0M
10666 0M
10754 0M
10801 0M
1 0M
```


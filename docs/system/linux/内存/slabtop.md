# slabtop命令



**语法格式**：slabtop [参数]

```bash
$ slabtop -h

用法:
 slabtop [选项]

选项:
 -d, --delay <secs>  更改刷新时间
 -o, --once          只显示一次就退出
 -s, --sort <char>   按照什么排序，使用排序选项

 -h, --help     显示帮助
 -V, --version  显示版本

排序选项:

a : 按照ACTIVE进行排序
b : 按照OBJ/SLAB进行排序
c : 按照CACHE SIZE进行排序
l : 按照SLABS进行排序
n : 按照NAME进行排序
o : 按照OBJS进行排序（默认按此顺序排序）
s : 按照OBJ SIZE进行排序
u : 按照USE进行排序
```

```bash
$slabtop -o
Active / Total Objects (% used)    : 110848 / 132470 (83.7%)
 Active / Total Slabs (% used)      : 3844 / 3844 (100.0%)
 Active / Total Caches (% used)     : 74 / 105 (70.5%)
 Active / Total Size (% used)       : 25728.59K / 29652.53K (86.8%)
 Minimum / Average / Maximum Object : 0.01K / 0.22K / 8.00K

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME                   
 18837   6569  34%    0.10K    483       39      1932K buffer_head            
 17952  17884  99%    0.12K    528       34      2112K kernfs_node_cache      
 14826  12898  86%    0.19K    706       21      2824K dentry                 
 10506   9465  90%    0.04K    103      102       412K selinux_inode_security 
```

### 各列解释含义

1. OBJS — The total number of objects (memory blocks), including those in use (allocated), and some spares not in use.   **对象的总数**

2. ACTIVE — The number of objects (memory blocks) that are in use (allocated).  **正在使用的对象数。**

3. USE — Percentage of total objects that are active. **活动对象总数的百分比**。((ACTIVE/OBJS)(100))

4. OBJ SIZE — The size of the objects.**对象的大小。（对应/proc/slabinfo中`<objsize>`）**

5. SLABS — The total number of slabs. **slabs的个数。（slab的个数，对应/proc/slabinfo中的nums_slabs）**

6. OBJ/SLAB — The number of objects that fit into a slab. **slab中的对象数。（一个slab中多少个对象）**

7. CACHE SIZE — The cache size of the slab. **对象缓存大小(我发现这个值大小正好等于OBJS乘以OBJ SIZE，在/proc/slabinfo中，`<num_objs>`乘以`<objsize>`)**  

8. NAME — The name of the slab.  **slab的名称**

   

### slabtop交互命令

按

- a 按照ACTIVE进行排序
- b 按照OBJ/SLAB进行排序
- c 按照CACHE SIZE进行排序
- l 按照SLABS进行排序
- n 按照NAME进行排序
- o 按照OBJS进行排序
- s 按照OBJ SIZE进行排序
- u 按照USE进行排序



材料：

https://docs.fedoraproject.org/en-US/Fedora/15/html/Deployment_Guide/s2-proc-slabinfo.html

https://man7.org/linux/man-pages/man1/slabtop.1.html
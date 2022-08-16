# /proc/slabtop



### 用/proc/slabinfo可以实现简单的slabtop

```bash
$ cat /proc/slabinfo | grep -v "^#"|awk '$3!=0{print $1,$2,$3,$4}' | sort -k3nr | head -n 10 | awk '{print $1,$2,$3,(($2/$3)*100)"%",$4*$3/1024"K"}' 
# slab名字 正在使用的对象个数  总的对象个数   正在使用的对象百分比 cache大小
buffer_head 5726 18213 31.4391% 1849.76K
kernfs_node_cache 17952 17952 100% 2103.75K
dentry 11951 14700 81.2993% 2756.25K
selinux_inode_security 11730 11730 100% 458.203K
kmalloc-64 9477 10368 91.4062% 648K
inode_cache 7346 7992 91.9169% 4620.38K
shared_policy_node 5865 5865 100% 274.922K
kmalloc-8 5120 5120 100% 40K
kmalloc-16 4864 4864 100% 76K
vm_area_struct 4046 4086 99.021% 861.891K

#或者

$ cat /proc/slabinfo | grep -v "^#"|awk '$3!=0{print $1,$2,$3,$4}' | sort -k3nr | head -n 10 | awk '{print $1,"激活obj个数="$2,"  总共obj个数"$3,"  个数占用百分比="(($2/$3)*100)"%","cache="$4,$4*$3/1024/1024"M"}'
buffer_head 激活obj个数=5726   总共obj个数18213   个数占用百分比=31.4391% cache=104 1.8064M
kernfs_node_cache 激活obj个数=17952   总共obj个数17952   个数占用百分比=100% cache=120 2.05444M
dentry 激活obj个数=11951   总共obj个数14700   个数占用百分比=81.2993% cache=192 2.69165M
selinux_inode_security 激活obj个数=11730   总共obj个数11730   个数占用百分比=100% cache=40 0.447464M
kmalloc-64 激活obj个数=10143   总共obj个数10432   个数占用百分比=97.2297% cache=64 0.636719M
inode_cache 激活obj个数=7346   总共obj个数7992   个数占用百分比=91.9169% cache=592 4.51208M
shared_policy_node 激活obj个数=5865   总共obj个数5865   个数占用百分比=100% cache=48 0.268478M
kmalloc-8 激活obj个数=5120   总共obj个数5120   个数占用百分比=100% cache=8 0.0390625M
kmalloc-16 激活obj个数=4864   总共obj个数4864   个数占用百分比=100% cache=16 0.0742188M
vm_area_struct 激活obj个数=4048   总共obj个数4122   个数占用百分比=98.2048% cache=216 0.849106M

$ slabtop 
 Active / Total Objects (% used)    : 121660 / 141528 (86.0%)
 Active / Total Slabs (% used)      : 3998 / 3998 (100.0%)
 Active / Total Caches (% used)     : 79 / 105 (75.2%)
 Active / Total Size (% used)       : 26754.80K / 30372.41K (88.1%)
 Minimum / Average / Maximum Object : 0.01K / 0.21K / 8.00K

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME                   
 18213   5726  31%    0.10K    467	 39	 1868K buffer_head
 17952  17952 100%    0.12K    528	 34	 2112K kernfs_node_cache
 14700  11951  81%    0.19K    700	 21	 2800K dentry
 11730  11730 100%    0.04K    115	102	  460K selinux_inode_security
 10368   9544  92%    0.06K    162	 64	  648K kmalloc-64
  7992   7346  91%    0.58K    296	 27	 4736K inode_cache
  5865   5865 100%    0.05K     69	 85	  276K shared_policy_node
  5120   5120 100%    0.01K     10	512        40K kmalloc-8
  4864   4864 100%    0.02K     19	256        76K kmalloc-16
  4086   4086 100%    0.21K    227	 18	  908K vm_area_struct
  4080   3570  87%    0.04K     40	102	  160K ext4_extent_status
  3024   3024 100%    0.09K     72	 42	  288K kmalloc-96
  2856   2455  85%    0.08K     56	 51	  224K anon_vma
  2800   1422  50%    0.57K    100	 28	 1600K radix_tree_node
  2752   2752 100%    1.00K    172	 16	 2752K ext4_inode_cache
  2064   1721  83%    0.25K    129	 16	  516K kmalloc-256
  1920   1920 100%    0.03K     15	128        60K kmalloc-32
  1659   1659 100%    0.19K     79	 21	  316K kmalloc-192
  1624   1624 100%    0.07K     29	 56	  116K avc_node
  1296   1261  97%    1.00K     81	 16	 1296K kmalloc-1024
  1239   1016  82%    0.19K     59	 21	  236K cred_jar
  1224   1076  87%    0.66K     51	 24	  816K shmem_inode_cache
  1128   1128 100%    0.66K     47	 24	  752K proc_inode_cache
```



### /proc/slabinfo各个列的意思解释



![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202206011900743.png)

每个 slab 由一个或多个物理连续的页面组成，每个 cache 由一个或多个 slab 组成，每个内核数据结构都有一个 cache。cache中又包含对象，对象可分为空闲和使用两种状态。

slab 分配器首先尝试在部分为空的 slab 中用空闲对象来满足请求。如果不存在，则从空的 slab 中分配空闲对象。如果没有空的 slab 可用，则从连续物理页面分配新的 slab，并将其分配给 cache；从这个 slab 上，再分配对象内存。



```bash
cat /proc/slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
dentry             16026  16863    192   21    1 : tunables    0    0    0 : slabdata    803    803      0
#根据下面的列解释进行数值验证，num_objs为16863，objsize为192B，cache总大小为16863*192=3237696B,一个slab大小为192*21=4032（objsize*objperslab），4032/4096取整为1，占用一个4K页，占用slab个数为(cache/一个slab大小)3237696/4032=803个。
kmalloc-8192          25     28   8192    4    8 : tunables    0    0    0 : slabdata      7      7      0
#根据下面的列解释进行数值验证，num_objs为28，objsize为8192B，cache总大小为28*8192=229376B,一个slab大小为8192*4=32768（objsize*objperslab），32768/4096=8，占用8个4K页，占用slab个数为(cache/一个slab大小)229376/32768=7个。


```



```bash
active_objs  
当前处于活动状态（即使用中）的对象数。

num_objs
对象的总数（即正在使用和未使用的对象。

objsize
对象的大小，以字节为单位。

objperslab
一个slab被分成了多少个对象，用这个可以算出slab的基本大小，objsize*objperslab=slab 大小

pagesperslab
一个slab占用多少个4K页，


每行中的tunables条目显示相应缓存的可调参数。使用默认SLUB分配器时，没有可调项，/proc/slabinfo文件不可写，并且这些字段中显示值0。使用较旧的SLAB分配器时，可以通过将以下形式的行写入/proc/slabinfo来设置特定缓存的可调项

# echo 'name limit batchcount sharedfactor' > /proc/slabinfo


这里，name是缓存名称，limit、batchcount和sharedfactor是定义相应可调参数新值的整数。限制值应为正值，batchcount应为小于或等于限制的正值，sharedfactor应为非负值。如果指定的任何值无效，则缓存设置保持不变。


#tunables 每行中的可调项包含以下字段：

limit  
将缓存的最大对象数。

batchcount
在SMP系统上，这指定了在重新填充可用对象列表时一次要传输的对象数。

sharedfactor
待记录

#每行中的slabdata条目包含以下字段：

active_slabs
激活的 objperslab 多少个

nums_slabs
占用的 objperslab 多少个

sharedavail
[待记录]

#行首的
slabinfo - version: 2.1
#1.0 在整个 Linux 2.2.x 内核系列中都存在。
#1.1 出现在 Linux 2.4.x 内核系列中。
#1.2 Linux 2.5开发系列中简要介绍的一种格式。
#2.0 存在于 Linux 2.6.x 内核中，包括 Linux 2.6.9。
#2.1 目前的格式，最早出现在Linux 2.6.10
```

### 解释slabtop命令

```bash
[root@VM-0-16-centos ~]# slabtop 
 Active / Total Objects (% used)    : 210181 / 216239 (97.2%)
 Active / Total Slabs (% used)      : 7921 / 7921 (100.0%)
 Active / Total Caches (% used)     : 74 / 105 (70.5%)
 Active / Total Size (% used)       : 69560.35K / 71380.84K (97.4%)
 Minimum / Average / Maximum Object : 0.01K / 0.33K / 8.00K

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME                   
 49728  49728 100%    0.19K   2368	 21	 9472K dentry
 28     25  89%    8.00K      7	  4	  224K kmalloc-8192
```



1. OBJS — The total number of objects (memory blocks), including those in use (allocated), and some spares not in use.   **对象的总数**
2. ACTIVE — The number of objects (memory blocks) that are in use (allocated).  **正在使用的对象数。**
3. USE — Percentage of total objects that are active. **活动对象总数的百分比**。((ACTIVE/OBJS)(100))
4. OBJ SIZE — The size of the objects.**对象的大小。（对应/proc/slabinfo中`<objsize>`）**
5. SLABS — The total number of slabs. **slabs的个数。（slab的个数，对应/proc/slabinfo中的nums_slabs）**
6. OBJ/SLAB — The number of objects that fit into a slab. **slab中的对象数。（一个slab中多少个对象）**
7. CACHE SIZE — The cache size of the slab. **对象缓存大小(我发现这个值大小正好等于OBJS乘以OBJ SIZE，在/proc/slabinfo中，`<num_objs>`乘以`<objsize>`)**  
8. NAME — The name of the slab.  **slab的名称**



### 释放dentry和inode对象

echo 3 > /proc/sys/vm/drop_caches 

```bash
$ cat /proc/slabinfo | grep -v "^#"|awk '$3!=0{print $1,$2,$3,$4}' | sort -k3nr | head -n 10 | awk '{print $1,$2,$3,(($2/$3)*100)"%",$4*$3/1024"K"}' 
# slab名字 正在使用的对象个数  总的对象个数   正在使用的对象百分比 cache大小
dentry 49959 49959 100% 9367.31K
ext4_inode_cache 36096 36096 100% 36096K
buffer_head 26871 26871 100% 2729.09K
kernfs_node_cache 17884 17952 99.6212% 2103.75K
selinux_inode_security 9465 10506 90.0914% 410.391K
kmalloc-64 9786 10304 94.9728% 644K
inode_cache 9882 9882 100% 5713.03K
ext4_extent_status 8262 8262 100% 322.734K
kmalloc-8 5120 5120 100% 40K
kmalloc-16 4718 4864 96.9984% 76K
$ echo 3 > /proc/sys/vm/drop_caches 
$ cat /proc/slabinfo | grep -v "^#"|awk '$3!=0{print $1,$2,$3,$4}' | sort -k3nr | head -n 10 | awk '{print $1,$2,$3,(($2/$3)*100)"%",$4*$3/1024"K"}' 
buffer_head 5426 18837 28.805% 1913.13K
kernfs_node_cache 17884 17952 99.6212% 2103.75K
dentry 9278 14826 62.5793% 2779.88K
selinux_inode_security 9465 10506 90.0914% 410.391K
kmalloc-64 9311 10240 90.9277% 640K
inode_cache 7608 8424 90.3134% 4870.12K
kmalloc-8 5120 5120 100% 40K
kmalloc-16 4718 4864 96.9984% 76K
vm_area_struct 4075 4122 98.8598% 869.484K
shared_policy_node 3656 3995 91.5144% 187.266K
```



资料：

https://man7.org/linux/man-pages/man5/slabinfo.5.html

https://man7.org/linux/man-pages/man1/slabtop.1.htm

https://www.kernel.org/doc/man-pages/
dumpe2fs命令

ext2/ext3/ext4 文件系统查看命令

部分解释

```bash
   [root@server2 ~]# dumpe2fs -h /dev/sda2
   Default mount options:    user_xattr acl    //默认挂载选项
   Filesystem state:         clean             //说明该文件系统没有问题
   Filesystem OS type:       Linux             //文件系统操作系统类型
   Inode count:              1310720           //i节点数量
   Block count:              5242880           //数据块的数量
   Reserved block count:     262144            //保留的块的数量
   Free blocks:              4454735           //空闲的块的数量
   Free inodes:              1218481           //空闲的i节点的数量
   Block size:               4096              //块的大小  (4KB)            
   Blocks per group:         32768
   Inodes per group:         8192
   Inode blocks per group:   512
   Inode size:	             256               //i节点的大小(单位是字节)
```

完整

```
[root@VM-0-16-centos ~]# dumpe2fs -h /dev/vda1
dumpe2fs 1.42.9 (28-Dec-2013)
Filesystem volume name:   <none>
Last mounted on:          /
Filesystem UUID:          2c04c946-7fee-41c2-a99f-f53e2532e4f7
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype needs_recovery extent sparse_super large_file uninit_bg
Filesystem flags:         signed_directory_hash 
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              3276800
Block count:              13106939
Reserved block count:     544984
Free blocks:              12354403
Free inodes:              3205489
First block:              0
Block size:               4096
Fragment size:            4096
Reserved GDT blocks:      508
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
Filesystem created:       Tue Jan  9 18:18:51 2018
Last mount time:          Mon Aug 15 20:43:44 2022
Last write time:          Mon Aug 15 20:43:44 2022
Mount count:              14
Maximum mount count:      -1
Last checked:             Fri Aug 17 11:27:10 2018
Check interval:           0 (<none>)
Lifetime writes:          47 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:	          256
Required extra isize:     28
Desired extra isize:      28
Journal inode:            8
First orphan inode:       333773
Default directory hash:   half_md4
Directory Hash Seed:      195b1821-47d9-4d62-a960-e58fc3c9b07c
Journal backup:           inode blocks
Journal features:         journal_incompat_revoke
Journal size:             128M
Journal length:           32768
Journal sequence:         0x00026259
Journal start:            21137
```


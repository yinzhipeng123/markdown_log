

### **LVM的基本概念**

1. **Physical Volume（PV，物理卷）**：
   - 是LVM的基础单位，对应实际的硬盘分区或整个硬盘。
   - 通过`pvcreate`命令将普通分区或设备转换为PV。
   - 如：`pvcreate /dev/sdb1`
2. **Volume Group（VG，卷组）**：
   - 由一个或多个PV组成，类似于一个存储池。
   - 通过`vgcreate`命令创建。
   - 如：`vgcreate my_vg /dev/sdb1 /dev/sdc1`
3. **Logical Volume（LV，逻辑卷）**：
   - 从VG中分配的逻辑存储单元，相当于可以动态调整大小的“分区”。
   - 可以格式化为文件系统并挂载使用。
   - 通过`lvcreate`命令创建。
   - 如：`lvcreate -L 10G -n my_lv my_vg`
4. **Physical Extent（PE，物理扩展块）**：
   - PV被分成固定大小的PE（默认4MB）。
   - LV由VG中的PE组合而成。

------

### **LVM的主要优点**

1. **灵活的存储分配**：
   - 可动态调整LV大小（扩展或缩小）。
   - VG可以动态添加或移除PV。
2. **快照功能**：
   - 可以为逻辑卷创建快照，用于备份和测试。
   - 如：`lvcreate -L 1G -s -n snapshot_lv /dev/my_vg/my_lv`
3. **跨磁盘存储**：
   - VG可以跨越多个物理设备，从而创建更大的逻辑卷。
4. **在线调整存储**：
   - 在不卸载分区的情况下扩展逻辑卷大小，并调整文件系统。





以下是将一个磁盘从零开始设置为LVM的流程，包括格式化、创建逻辑卷、以及格式化逻辑卷的步骤。 

### **步骤描述**
假设目标磁盘是 `/dev/sdb`，最终需要一个名为 `my_lv` 的逻辑卷挂载到 `/mnt/data`。

---

### **1. 初始化磁盘（可选）**
如果磁盘已有数据或分区，需要清理。  
```bash
wipefs -a /dev/sdb
```
清除分区表和文件系统信息。

---

### **2. 创建物理卷（PV）**
使用 `pvcreate` 初始化磁盘为物理卷：  
```bash
pvcreate /dev/sdb
```

验证结果：  
```bash
pvdisplay
```

---

### **3. 创建卷组（VG）**
创建卷组 `my_vg` 并添加物理卷 `/dev/sdb`：  
```bash
vgcreate my_vg /dev/sdb
```

查看卷组信息：  
```bash
vgdisplay
```

---

### **4. 创建逻辑卷（LV）**
创建大小为 50GB 的逻辑卷 `my_lv`：  
```bash
lvcreate -L 50G -n my_lv my_vg
```

或者创建使用卷组所有空间的逻辑卷：  
```bash
lvcreate -l 100%FREE -n my_lv my_vg
```

查看逻辑卷信息：  
```bash
lvdisplay
```

---

### **5. 格式化逻辑卷**
将逻辑卷格式化为文件系统（以 `ext4` 为例）：  
```bash
mkfs.ext4 /dev/my_vg/my_lv
```

---

### **6. 挂载逻辑卷**
创建挂载点：  
```bash
mkdir -p /mnt/data
```

挂载逻辑卷到 `/mnt/data`：  
```bash
mount /dev/my_vg/my_lv /mnt/data
```

验证挂载：  
```bash
df -h
```

---

### **7. 配置开机自动挂载（可选）**
编辑 `/etc/fstab` 文件，添加如下行：  
```plaintext
/dev/my_vg/my_lv /mnt/data ext4 defaults 0 0
```

然后验证配置是否正确：  
```bash
umount /mnt/data
mount -a
```

---

### **完整命令示例**
以下是一套完整的命令，连贯执行即可：
```bash
# 清理磁盘（可选）
wipefs -a /dev/sdb

# 创建物理卷
pvcreate /dev/sdb

# 创建卷组
vgcreate my_vg /dev/sdb

# 创建逻辑卷
lvcreate -L 50G -n my_lv my_vg

# 格式化逻辑卷
mkfs.ext4 /dev/my_vg/my_lv

# 挂载逻辑卷
mkdir -p /mnt/data
mount /dev/my_vg/my_lv /mnt/data

# 配置开机自动挂载
echo '/dev/my_vg/my_lv /mnt/data ext4 defaults 0 0' >> /etc/fstab
```

---

### **结果验证**
1. 查看物理卷、卷组、逻辑卷状态：
   ```bash
   pvdisplay
   vgdisplay
   lvdisplay
   ```
2. 确认挂载点的可用空间：
   ```bash
   df -h /mnt/data
   ```







LVM的快照功能（Snapshot）是逻辑卷管理器中的一个强大工具，允许用户在某一时间点创建逻辑卷的副本，用于备份、恢复或测试等场景。以下是有关快照的详细介绍：

---

### **LVM快照的作用**
1. **数据备份**：
   - 快照创建时会捕获逻辑卷的当前状态，提供一个一致性的备份点。
   - 快照可以挂载并备份，而不会干扰正在运行的主逻辑卷。

2. **数据恢复**：
   - 如果主逻辑卷发生错误（如意外删除文件或数据损坏），可以使用快照恢复到快照创建时的状态。

3. **开发和测试**：
   - 快照可用于测试新功能或修改数据。如果修改导致问题，可以快速回滚到原始状态。

4. **文件系统检查**：
   - 在需要运行文件系统检查（fsck）或其他维护任务时，使用快照避免对生产逻辑卷直接操作。

---

### **LVM快照的特点**
- **写时复制（Copy-on-Write, CoW）**：
  - 快照并不是逻辑卷的完整副本，而是只在原始数据发生更改时存储被修改的数据块。
  - 因此快照的创建速度非常快，且初始占用的存储空间很小。

- **动态增长**：
  - 快照的大小决定了它可以存储多少变化数据（而不是原始逻辑卷的大小）。

---

### **快照的使用场景**
1. **数据备份**：
   - 使用快照创建一致性视图，然后将快照挂载并复制数据到其他存储介质。

2. **数据恢复**：
   - 创建快照后误操作文件时，使用快照恢复逻辑卷的状态。

3. **临时分析**：
   - 快照挂载后可以用作数据分析的临时环境，不会影响原始数据。

---

### **快照的创建和管理**

#### **1. 创建快照**
假设主逻辑卷是 `/dev/my_vg/my_lv`，创建一个名为 `my_lv_snap` 的快照，大小为 10GB：
```bash
lvcreate -L 10G -s -n my_lv_snap /dev/my_vg/my_lv
```

#### **2. 挂载快照**
将快照挂载到某个目录（如 `/mnt/snapshot`）以访问快照中的数据：
```bash
mkdir -p /mnt/snapshot
mount /dev/my_vg/my_lv_snap /mnt/snapshot
```

#### **3. 恢复逻辑卷**
如果需要恢复主逻辑卷到快照状态：
```bash
lvconvert --merge /dev/my_vg/my_lv_snap
```
> 注意：
> - 恢复操作需要卸载主逻辑卷。
> - 系统需要重启以完成恢复。

#### **4. 删除快照**
当快照不再需要时，可以删除：
```bash
lvremove /dev/my_vg/my_lv_snap
```

---

### **快照的注意事项**
1. **存储空间限制**：
   - 快照需要足够的空间存储变化数据。如果快照空间用尽，快照会失效。
   - 建议分配的快照大小为主逻辑卷的 10%～20%，根据写入量适当调整。

2. **性能开销**：
   - 写时复制机制会带来一定的性能开销，特别是在主逻辑卷有大量写操作时。

3. **只读和可写快照**：
   - 默认创建的快照是可写的，可以对快照进行实验性更改。
   - 若只需读取快照，可使用 `-pr` 参数创建只读快照。

---

### **完整示例**
#### **场景：备份逻辑卷**
1. 创建快照：
   ```bash
   lvcreate -L 10G -s -n my_lv_snap /dev/my_vg/my_lv
   ```

2. 挂载快照：
   ```bash
   mount /dev/my_vg/my_lv_snap /mnt/snapshot
   ```

3. 备份数据：
   ```bash
   rsync -av /mnt/snapshot /backup/location
   ```

4. 卸载并删除快照：
   ```bash
   umount /mnt/snapshot
   lvremove /dev/my_vg/my_lv_snap
   ```


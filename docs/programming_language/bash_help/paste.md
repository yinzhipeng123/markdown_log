`paste` 是 Linux 中的一个命令行工具，主要用于合并多个文件或标准输入的行，按列拼接数据。它的常见用法如下：

---

### 1. **默认拼接（按列合并）**
```bash
paste file1.txt file2.txt
```
**作用**：按行合并 `file1.txt` 和 `file2.txt`，使用 **制表符（Tab）** 作为默认分隔符。

**示例**：
```bash
$ cat file1.txt
A
B
C

$ cat file2.txt
1
2
3

$ paste file1.txt file2.txt
A       1
B       2
C       3
```

---

### 2. **自定义分隔符（`-d` 选项）**
```bash
paste -d "," file1.txt file2.txt
```
**作用**：使用逗号 `,` 作为分隔符，而不是默认的制表符。

**示例**：
```bash
$ paste -d "," file1.txt file2.txt
A,1
B,2
C,3
```
支持多个分隔符：
```bash
paste -d ",:" file1.txt file2.txt file3.txt
```
如果分隔符数量小于文件数量，则循环使用。

---

### 3. **合并到一行（`-s` 选项）**
```bash
paste -s file1.txt
```
**作用**：将文件的所有行合并到一行。

**示例**：
```bash
$ cat file1.txt
A
B
C

$ paste -s file1.txt
A       B       C
```

结合 `-d` 选项：
```bash
paste -s -d "," file1.txt
```
输出：
```
A,B,C
```

---

### 4. **读取标准输入**
如果不指定文件，`paste` 也可以从标准输入读取数据：
```bash
echo -e "A\nB\nC" | paste -s -d ","
```
输出：
```
A,B,C
```

---

### 5. **处理多个文件并行合并**
```bash
paste file1.txt file2.txt file3.txt
```
如果 `file3.txt` 为空或行数较少，`paste` 会以空值补齐。

---

### 6. **配合 `cut` 或 `awk` 进行列操作**
从 `file.txt` 提取两列数据，并按逗号拼接：
```bash
cut -f1 file.txt | paste -d "," - file.txt
```

---

### 7. **和 `find` 结合批量处理**
```bash
find . -type f -name "*.txt" | paste -s -d " "
```
将当前目录所有 `.txt` 文件的路径合并成一行，以空格分隔。

---

## 总结
| 选项 | 作用 |
|------|------|
| `-d <分隔符>` | 指定分隔符（默认是 `Tab`） |
| `-s` | 合并所有行到一行 |
| `-` | 读取标准输入 |

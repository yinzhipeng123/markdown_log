### 1️⃣ 创建会话

```
screen -S mysession
```

👉 创建一个名字叫 `mysession` 的会话

------

### 2️⃣ 临时离开（不中断程序）

👉 **重点中的重点**

```
Ctrl + A  然后按 D
```

👉 作用：

- 程序继续运行
- 你可以断开SSH

------

### 3️⃣ 查看当前会话

```bash
screen -ls
```

------

### 4️⃣ 重新进入会话

```bash
screen -r mysession
```



杀掉会话

```bash
screen -S mysession -X quit
```



强制接管：

```bash
screen -d -r 3643498.jieya
```


你可以使用以下命令在Linux上创建`virtualenv`：

1. 首先，确保安装了`virtualenv`。如果没有安装，可以通过`pip`安装：

   ```bash
   pip install virtualenv
   ```

2. 然后，创建一个新的虚拟环境：

   ```bash
   virtualenv myenv
   ```

   其中`myenv`是你想要创建的虚拟环境名称。

3. 激活虚拟环境：

   ```bash
   source myenv/bin/activate
   ```

   激活后，你会看到命令行提示符前面有`(myenv)`，表示你已经进入了虚拟环境。

要退出虚拟环境，使用命令：

```bash
deactivate
```



`myenv` 是一个文件夹，虚拟环境会在该文件夹内创建所需的所有文件和目录。具体来说，`virtualenv` 会在 `myenv` 文件夹中创建以下结构：

- [ ] `bin/`：包含激活虚拟环境的脚本，以及虚拟环境的 Python 解释器和其他工具。
- [ ] `lib/`：存放与虚拟环境相关的库文件，包括安装的 Python 包。
- [ ] `include/`：存放 C 语言头文件（如果你编译了某些包，可能会用到）。
- [ ] `pyvenv.cfg`：虚拟环境的配置文件，记录 Python 解释器的位置等信息。

这个文件夹就是你虚拟环境的“家”，所有的依赖和配置都在其中。



### 推荐的做法：

将代码和虚拟环境分别放在不同的文件夹中。一个常见的项目结构可能是这样的：

```
myproject/
├── myenv/        # 虚拟环境文件夹
├── src/          # 你的代码目录
├── requirements.txt  # 依赖文件
```

在这种结构中：

- [ ] `myenv/` 包含虚拟环境。
- [ ] `src/` 包含你的应用代码。
- [ ] `requirements.txt` 用来列出所有依赖，方便在不同的机器上重新创建虚拟环境。


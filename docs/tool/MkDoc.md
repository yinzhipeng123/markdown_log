## 部署MkDocs



安装Python，Pycharm，Git

 参考：

​	[git及github的轻度教程 - MarkDown_Log (yinzhipeng123.github.io)](https://yinzhipeng123.github.io/markdown_log/api/github使用/)

​	[Pycharm及配合Github的使用 - MarkDown_Log (yinzhipeng123.github.io)](https://yinzhipeng123.github.io/markdown_log/api/pycharm/)



使用上两篇文章的Github项目，根据上两篇文章（看完），在项目中，Python依赖安装Markdown，mkdocs

Pycharm终端内输入

```bash
pip3 install Markdown==3.3.4
pip3 install mkdocs==1.3.0
```

然后修改下Pycharm的终端设置

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204172026888.png" alt="image-20220417202620835" style="zoom:67%;" />

如下图操作



<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204172027828.png" alt="image-20220417202718778" style="zoom:67%;" />

```bash
mkdocs new .

# 创建所需文件：docs 和 mkdocs.yml

# 修改docs下的文件，用markdown编辑器（我推荐Typora）对网站内容进行编辑

# mkdocs.yml为网站的索引及配置文件

# 以上详细参考https://www.mkdocs.org/getting-started/

# 有个项目完全用的mkdocs进行API发布，页面地址https://siddhi-io.github.io/siddhi/

# mkdocs serve 

# 这个命令可以本地展示网站，访问127.0.0.1:8000进行预览

mkdocs build
#根据文件生成网站文件
# 生成目录site，目录内文件为网站静态文件
```

把`site`目录中内容放置到项目根目录

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204172037021.png" alt="image-20220417203708971" style="zoom:67%;" />



可以在终端里面进行代码的提交

```bash
git add ./ -A
git commit -m '这次提交的名字'
git push
```



<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204172039788.png" alt="image-20220417203919727" style="zoom:67%;" />



## GitHub Pages发布

Github项目需要设置下，如图所示

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204172043446.png" alt="image-20220417204345397" style="zoom: 50%;" />

然后访问该地址

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204172045430.png" alt="image-20220417204501369" style="zoom:50%;" />



## 美化MkDocs

cmd中执行pip

```powershell
pip install mkdocs-windmill
```

修改mkdocs.yml，添加行theme: windmill，使用nav

```yaml
site_name: markdown_log
site_url: https://yinzhipeng123.github.io/learn/
nav:
- MkDocs: index.md
- 文章列表:
  - MkDocs: api/MkDoc.md
theme: windmill
```

Pycharm 终端输入下面命令进行预览

```powershell
mkdocs serve
```

提交代码

```powershell
git add -A
git commit -m '修改文件'
git push origin main
```



## 为什么要写博客



<img src="https://raw.githubusercontent.com/yinzhipeng123/markdown_log/main/docs/image/%E4%B8%BA%E4%BB%80%E4%B9%88%E5%86%99%E5%8D%9A%E5%AE%A2.jpg" style="zoom:50%;" />



当我要回答一个问题，我需要确定自己对这个问题所涉及到的技术都了然于心，不然写出来的东西如果是错的话，姑且不说丢不丢人，最重要的是这样会误人子弟。所以如果看到一个问题我并不是非常了解，我不会第一时间就去回答，而是自己去研究一轮，研究透彻了，再去回答问题。在这么一个过程当中，**我又巩固了以前的知识，并学习到了新的知识，顺带还帮助到提出问题的人，这是双赢的，何乐而不为**？

另外，**多写东西，可以提高你的表达能力**。


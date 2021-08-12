## 部署MkDocs

我的环境是windows10 ，安装好Python、Git、Pip

有的人不会Python，这里写下Python环境及Pip的安装。Git自行百度



1、下载python安装包
　　在python官网进行下载https://www.python.org/downloads/ 我这里下载的是2.7.9的，当然你也可以下载最新的：

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/Python2.7.png?raw=true)

安装比较简单，只需要下一步...就行。
2、添加Python的系统路径
　　在“系统变量”中的“系统变量”里面的path中，添加你的python的安装路径即可，如我的安装路径如下：
![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/image-20210714193055178.png?raw=true)

3、检验安装是否成功
　　在控制台输入python，是否能进入命令行
　![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/1.png?raw=true)

4、安装pip
　　pip是一个安装和管理 Python 包的工具,后面安装软件用pip安装特别方便
　　（1）下载pip压缩包 https://pypi.org/project/pip/20.3.4/#files
   ![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/image-20210714195020249.png?raw=true)　　　　　
　　（2）解压，在控制台切换到pip的解压后的文件夹的路径中输入"python setup.py install",setup.py就是它的安装文件
   　　![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/image-20210714195401479.png?raw=true)
　　（3)添加pip的环境变量，pip会被安装在你python安装路径中的Scripts文件夹中

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/pip_exnv.png?raw=true)


　　（4)检验pip是否安装成功，windows控制台输入"pip",由如下输出则安装成功
      ![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/oooooooo.png?raw=true)



如果安装完 PIP出现这个



```bash
$-> pip
Traceback (most recent call last):
  File "/home/work/.jumbo/bin/pip", line 9, in <module>
    load_entry_point('pip==21.1.1', 'console_scripts', 'pip')()
  File "/home/work/.jumbo/lib/python2.7/site-packages/pkg_resources/__init__.py", line 552, in load_entry_point
    return get_distribution(dist).load_entry_point(group, name)
  File "/home/work/.jumbo/lib/python2.7/site-packages/pkg_resources/__init__.py", line 2672, in load_entry_point
    return ep.load()
  File "/home/work/.jumbo/lib/python2.7/site-packages/pkg_resources/__init__.py", line 2345, in load
    return self.resolve()
  File "/home/work/.jumbo/lib/python2.7/site-packages/pkg_resources/__init__.py", line 2351, in resolve
    module = __import__(self.module_name, fromlist=['__name__'], level=0)
  File "/home/work/.jumbo/lib/python2.7/site-packages/pip/__init__.py", line 1, in <module>
    from typing import List, Optional
ImportError: No module named typing
```

解决方案：



```bash
> curl -O https://bootstrap.pypa.io/pip/2.7/get-pip.py
> python get-pip.py
> python -m pip install --upgrade "pip < 21.0"
```



5、pip安装wheel 

 控制台输入：

```
pip install wheel  -i https://pypi.tuna.tsinghua.edu.cn/simple
```



Python及pip安装完成

cmd下输入

```powershell
pip install mkdocs -i https://pypi.tuna.tsinghua.edu.cn/simple
```

在github上建立空的公开git库，并克隆到本地

以我的为例

```powershell
D:\git>git clone https://github.com/yinzhipeng123/markdown_log.git
D:\git>cd markdown_log
D:\git\markdown_log>mkdocs new .
INFO    -  Writing config file: .\mkdocs.yml
INFO    -  Writing initial docs: .\docs\index.md
D:\git\markdown_log>mkdocs serve
```

mkdocs serve会把makedown文件以静态页面的形式展示到127.0.0.1:8000，可以更改docs下的md文件进行实时更新

修改mkdocs.yml会对网站一些页面进行设置

以上详细参考https://www.mkdocs.org/getting-started/

有个项目完全用的mkdocs进行API发布，页面地址https://siddhi-io.github.io/siddhi/

该项目yml文件配置https://github.com/siddhi-io/siddhi/blob/master/mkdocs.yml

可以参考其配置



## GitHub Pages发布

```powershell
D:\git\markdown_log>mkdocs build
WARNING -  Config value: 'pages'. Warning: The 'pages' configuration option has been deprecated and will be removed in a future release of MkDocs. Use 'nav' instead.
INFO    -  Cleaning site directory
INFO    -  Building documentation to directory: D:\git\markdown_log\site


```

然后剪切site下的所有文件到D:\git\markdown_log下

这里我做了个脚本  clear_code.sh

```bash
#!/usr/bin/env bash

shopt -s extglob
rm -rf !(mkdocs.yml|README.md|docs|site|.git|clear_code.sh)

mkdocs build
mv site/* ./
```

windows安装git后，这个脚本放在这个目录，双击就能执行，脚本解释：删除上次构建，然后构建，移动目录

然后git上传上去

```powershell
git add -A
git commit -m '修改文件'
git push origin main
```

然后在git库的页面这样设置

![](https://github.com/yinzhipeng123/markdown_log/blob/main/image/image-20210713182030557.png?raw=true)

然后就可以通过这个地址进行访问了



## 美化MkDocs

cmd中执行pip

```powershell
pip install mkdocs-windmill
```



修改mkdocs.yml，添加行theme: windmill，使用nav

```yaml
site_name: markdown_log
site_url: https://yinzhipeng123.github.io/markdown_log/
nav:
- MkDocs: index.md
- 文章列表:
  - MkDocs: api/MkDoc.md
theme: windmill
```



cmd中启动

```powershell
mkdocs serve
```

127.0.0.1:8000预览之后。就双击执行clear_code.sh进行构建，然后git回去

```powershell
git add -A
git commit -m '修改文件'
git push origin main
```



## 为什么要写博客



![](https://raw.githubusercontent.com/yinzhipeng123/markdown_log/main/docs/image/%E4%B8%BA%E4%BB%80%E4%B9%88%E5%86%99%E5%8D%9A%E5%AE%A2.jpg)



当我要回答一个问题，我需要确定自己对这个问题所涉及到的技术都了然于心，不然写出来的东西如果是错的话，姑且不说丢不丢人，最重要的是这样会误人子弟。所以如果看到一个问题我并不是非常了解，我不会第一时间就去回答，而是自己去研究一轮，研究透彻了，再去回答问题。在这么一个过程当中，**我又巩固了以前的知识，并学习到了新的知识，顺带还帮助到提出问题的人，这是双赢的，何乐而不为**？



另外，**多写东西，可以提高你的表达能力**。

这段转自知乎

链接：https://www.zhihu.com/question/39212891/answer/80685372

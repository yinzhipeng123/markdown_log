# Pycharm及配合Github的使用



### Git的安装

参考下面的文章，`安装`章节

[git及github的轻度教程 - MarkDown_Log (yinzhipeng123.github.io)](https://yinzhipeng123.github.io/markdown_log/api/github使用/#_2)

### Python的安装



#### Windows10下

https://www.python.org/downloads/windows/   下载地址，中选择3.9.7，64安装包，下图中最下面的一个

![image-20220417165643411](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171656449.png)

安装过程很简单，基本都是下一步下一步，其中有些配置要如下图，（Add Python 3.9 to Path）添加Python到环境变量中，（Install lanuncher for all user）安装为电脑中所有用户

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171658997.png" alt="image-20220417165824960" style="zoom:67%;" />

下图，全部勾选

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171700050.png" alt="4D612A47566ABEBEA15E93CA6056C156" style="zoom:67%;" />

下图，如图勾选，安装路径按照自己需求

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171701901.png" alt="image-20220417170101862" style="zoom:67%;" />

下图，点击Disable path length limit

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171702784.png" alt="image-20220417170254745" style="zoom:67%;" />

按照上面的安装，环境变量就自动配置好了。查看下环境变量，结果如下，至此安装完成

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171704777.png" alt="image-20220417170416737" style="zoom: 67%;" />

### Pycharm的安装

#### Windows10下

https://www.jetbrains.com/pycharm/  下载地址，选择Professional

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171706978.png" alt="image-20220417170653941" style="zoom: 50%;" />

安装基本都是下一步下一步默认安装就好了，其中下面的选项，如下图

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171708390.png" alt="image-20220417170803350" style="zoom:67%;" />

安装完成后，需要激活，建议在淘宝搜索'IDEA激活'，买个激活账号

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171709190.png" alt="image-20220417170938153" style="zoom:67%;" />

激活后，点击插件中心（Plugins），Marketplace中搜'chinese'

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171710180.png" alt="image-20220417171017143" style="zoom:67%;" />

按照图中，选择中文插件安装，然后点击Restart IDE

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171711122.png" alt="image-20220417171117078" style="zoom:67%;" />

至此pycharm安装完成



### Pycharm从Github上拉取代码

#### 通过内置Git克隆代码

打开pycharm，按照下图操作

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171812908.png" alt="image-20220417181244856" style="zoom:67%;" />

输入repository的地址，目录按照自己需求自定义，然后点击信任目录

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171813468.png" alt="image-20220417181302430" style="zoom:67%;" />

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171813111.png" alt="image-20220417181318070" style="zoom:67%;" />

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171813802.png" alt="image-20220417181336761" style="zoom:67%;" />

![image-20220417181919162](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171819206.png)

#### Pycharm配置项目Python虚拟环境

在项目中，`文件` --> `设置`

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171845670.png" alt="image-20220417184502622" style="zoom:67%;" />

选择`Python解释器`-->`添加`

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171845058.png" alt="image-20220417184534013" style="zoom:67%;" />

创建新环境，位置可以放在项目中

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171846167.png" alt="image-20220417184637123" style="zoom:67%;" />

选择新创建的环境

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171847129.png" alt="image-20220417184733082" style="zoom:67%;" />

#### Pycharm提交代码

例如，新添加app.py，就把app.py添加到暂存

![image-20220417185714102](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171857154.png)

然后点击 提交文件

![image-20220417185831798](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171858851.png)

弹出下图，点击提交，就把文件提交到本地数据库

![image-20220417190050023](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171900063.png)

然后在进行`拉取`，获取最新的中央服务器内容变化，点击拉取

![image-20220417190213491](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171902536.png)

默认即可，点击拉取，拉取完成会在右下角提示完成

![image-20220417190252661](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171902708.png)

然后推送文件到中央服务器

![image-20220417190441241](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171904288.png)

点击推送，（有时让输入下github的账号密码）就可以完成文件的推送

![image-20220417190451527](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171904573.png)

#### 设置git忽略文件

有的时候不像推送全部内容，可以在项目中创建忽略文件，这样git就会根据忽略文件中的配置进行忽略掉某些文件或者目录

在项目的根目录下面创建.gitigonre文件，.gitigonre可以跟随项目上传到中央服务器上

如下图，/venv/是当前项目下的venv目录，是当前项目在本机的虚拟运行环境，这个目录是忽略掉的

/.idea/是当前项目的.idea目录，是pycharm软件在当前项目的配置文件，这个目录也是要忽略掉的

![image-20220417191226941](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171912986.png)

#### Pycharm给虚拟环境安装依赖

一般Python项目中，项目中会提供requirement.txt文件，此为Python的依赖配置文件

项目设置中，`终端`，如图设置

![image-20220417192549327](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171925377.png)

然后在项目的终端中输入，如下图，就完成了安装

```bash
pip3 install --upgrade pip
pip3 install -r requirement.txt
```

![image-20220417192055700](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171920750.png)
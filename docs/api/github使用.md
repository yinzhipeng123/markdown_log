# git及github的使用

## git

### 基本概念：

[git - 维基百科，自由的百科全书 (wikipedia.org)](https://zh.wikipedia.org/wiki/Git)

`git`是一个`分布式`代码管理工具，`git`在本地会有建立个数据库，当我们修改完代码后，`git`会保存相应的变化到数据库中，可以通过命令把变化及文件保存到`中央服务器`，当查看别人修改的记录时，又可以从中央服务器拉取数据到本地数据库，从本地查看别人的修改过的内容及最新的文件

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171443099.png)

#### 个人使用git需要掌握的一些命令

从中央服务器拉取并创建本地数据库

```bash
git clone https://xxx.com/xxx/xxx.git
```

暂存所有文件及变化

```bash
git add ./ -A
```

提交暂存到本地git数据库中

```bash
git commit -m '这次提交的名字'
```

推送本地数据库到中央服务器

```bash
git push
```

拉取中央服务器的代码到本地数据库中

```bash
git pull
```

### 安装

#### Windows10上安装

[Git - Downloads (git-scm.com)](https://git-scm.com/downloads)

此地址为GIT官网下载地址，选择Windows，选择64-bit Git for Windows Setup，然后下载安装，选择安装位置，根据自己需求选择，其中有一项安装选项，如下图选择，给Windows右键添加快速进入git的快捷方式（Git Bash Here、Git GUI Here）、添加git环境配置文件在CMD中（图中最后一项），勾选这几项会给使用添加很多便利

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171500826.png)

安装完之后的样子，如下图，可以在任意目录下，快速进入git

![image-20220417150512976](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171505041.png)

## github的使用

[GitHub - 维基百科，自由的百科全书 (wikipedia.org)](https://zh.wikipedia.org/wiki/GitHub)

github可以理解为世界上最大的`git中央服务器`提供商，给用户免费托管代码。GitHub同时提供付费账户和免费账户。这两种账户都可以创建公开或私有的[代码仓库](https://zh.wikipedia.org/wiki/代码库)，但付费用户拥有更多功能。



### 创建账户

访问https://github.com ，右上角选择[Sign up](https://github.com/signup?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home)，然后注册。[Sign in](https://github.com/login)为登录



### github上创建一个公开的库

github上创建一个公开的库（建立自己的git中央服务器）

登录之后，在页面右上角点击`＋`号，选择 `New repository` 如下图

![image-20220417151351238](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171513285.png)



然后填写repository的名字，描述，选择是否为公开（公开为其他人也能看到，私有是只能自己看到），选择`Add a README file`（添加库的描述文件），点击`Create repository`

![image-20220417151553703](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171515745.png)



## 通过git使用github

讲解下，如何通过git同步中央服务器到本地数据库，从本地数据库如何推送到中央服务器。如何合并文件变化

### 从github上克隆repository到本地

在github上创建repository之后，把它同步到本地电脑上，首先在repository复制repository的地址，如下图

![image-20220417152954186](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171529232.png)

然后在自己的电脑上选择一个目录，然后右键`Git Bash Here`，命令行就从此目录打开了，然后输入git命令，如下图，出现done后，就把repository`克隆`到本地learn目录下了

```bash
git clone https://github.com/yinzhipeng123/learn.git
```

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171532194.png" alt="image-20220417153238140" style="zoom:67%;" />

目录内就一个README.md文件（库的描述文件），`.git`为该repository的git信息文件，不能删除，它保留着该repository是从哪里克隆到这里的，文件变化，github账号信息等等

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171536647.png" alt="image-20220417153625593" style="zoom:67%;" />

### 本地添加文件并推送到github上

在repository目录中，添加个learn.txt文件，随便写点什么，然后通过命令行，进入repository目录，提交信息并推送到github上

```bash
cd learn
#进入repository目录中
ls
#查看文件
git add -A ./
#添加所有文件及变化到暂存，此命令可以执行多次，比如修改文件后，添加到暂存了，后来又修改文件，可以再添加一遍暂存，确保在commit之前，把最新文件都添加到暂存就行
git commit -m '新建learn.txt'
#提交暂存到本地数据库中，-m之后的名字可以随便写
git push
#推送本地数据库到github上，在此步骤中可能会弹出对话框或者网页，让填入github的账号密码，按照提示填写就行了，如果填错了，重新执行该命令就可以
```



![image-20220417154050155](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171540208.png)

然后查看github，显示了刚刚推送的文件及commit信息

![image-20220417155451138](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171554200.png)



### 从github上拉取最新代码



在github上新建一个文件，如下图，新建一个github_add.txt

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171600983.png" alt="image-20220417160059924" style="zoom:50%;" />

点击`commit new file`，完成创建

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171601388.png" alt="image-20220417160117330" style="zoom: 50%;" />

如下图，显示创建完成

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171612571.png" alt="image-20220417161253509" style="zoom:67%;" />

本地拉取最新的文件

```bash
ls 
#图上显示没有github_add.txt
git pull
#显示一个文件变化
ls
图上显示有github_add.txt了
```

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171614874.png" alt="image-20220417161402812" style="zoom: 67%;" />

### github提交的常规操作

如果我们在多端操作，假如你有两个电脑，电脑A，电脑B，你在电脑A和电脑B同一时间克隆的github上相同的的repository，此时电脑A和电脑B文件是一样的。电脑A加了些新的文件并提交了到了github上，此时你用电脑B，电脑B上你也加了新的文件，你想把电脑B也提交到github上，但是直接`git push`是不行的，你需要先`commit`后再`git pull`，把本地和github上最新的文件在本地进行合并，然后再`push`就可以了



所以一般的git常规操作为

```bash
git add ./ -A
#暂存所有文件及变化
git commit -m '这次提交的名字'
#提交暂存到本地git数据库中
git pull
#拉取最新的代码，并进行合并
git push
#推送代码到github上
```

模拟：

在github上添加新的文件，如下图，添加web.txt

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171623502.png" alt="image-20220417162301433" style="zoom:50%;" />

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171626073.png" alt="image-20220417162659006" style="zoom: 67%;" />

本地添加desktop.txt文件  （echo "电脑端" > desktop.txt为新建文件并写入"电脑端"三个字）

```bash
ls 
echo "电脑端" > desktop.txt
```

![image-20220417162808665](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171628735.png)

然后本地提交文件到本地数据库，并拉取github最新数据进行合并

```bash
git add -A ./
git commit -m '添加desktop.txt'
git pull
```

![image-20220417163022118](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171630192.png)

输入`git pull`后，回车会弹出个页面，提示你合并文件，输入`:wq` 保存即可，此为合并成功

![image-20220417163113953](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171631022.png)

然后推送到github上就可以了，提示推送成功

![image-20220417163342554](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171633629.png)

查看github上，已经显示了所有的文件了

![image-20220417163443462](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204171634535.png)
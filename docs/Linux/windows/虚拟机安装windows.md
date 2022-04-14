# 虚拟机安装Microsoft Windows

因为自己偶尔要下载注册机等东西，有些无良软件制作者会给注册机加木马的壳或者一些病毒，为了能正常使用注册机，防止自己的主机中招，可以在虚拟机中安装Windows，在虚拟机中的Windows使用各种注册机。即使有病毒，也是虚拟机中的Windows感染，不会影响自己真正的主机。摸索了一段时间，在这记录下

## 1、真实主机是`Windows`

以安装Windows10为例

#### （1）安装虚拟机

如果真实主机是`Windows`，那么就下载`VMware Workstation 16 Pro`，官网地址：https://www.vmware.com/cn/products/workstation-pro/workstation-pro-evaluation.html，安装时安装选项全部选择默认就可以，这个软件是收费的，可以试用，也可以输入注册码，`VMware Workstation 16 Pro`注册码在网上可以搜到，比如这种 http://www.win7zhijia.cn/win10jc/win10_46025.html

#### （2）下载Windows10

在一个名为`我告诉你`的网站，可以下载到一切跟Microsoft相关的东西。https://msdn.itellyou.cn/  下载Windows10镜像，下图中选择Windows10 1909版本（后面数字越大越新），consumer editions（消费者版本），ed2k开头的选中部分复制到`迅雷`中即可下载

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204130024593.png" style="zoom: 25%;" />

#### （3）用虚拟机安装Windows10

在`VMware Workstation 16 Pro`中，`文件`-->`新建虚拟机`，选择`典型`

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204130038851.png" style="zoom:67%;" />

选择`稍后安装操作系统`，全部下一步即可，新建完虚拟机。右键虚拟机，选择`设置`，调整下内存大小，要大于1G。

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204130040298.png" style="zoom: 67%;" />

`设置 `中选择 `CD/DVD`，设置`启动时连接`，使用`ISO映像文件`，选择上一步中下载的Windows10镜像，点击确定，然后启动虚拟机

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204130043838.png" style="zoom: 50%;" />

Windows10安装过程很简单，虚拟机开机之后，按照提示，基本默认下一步下一步就行。

#### （4）激活Windows10

Windows的激活，可以通过输入密匙（注册码）激活，也可以通过工具激活。

密匙在网上基本可以搜到能用的，例如这个  http://www.xitongcheng.com/jiaocheng/win10_article_55870.html?_360safeparam=647461812

密匙输入在Windows `设置`中，`系统`-->`关于`

通过工具激活，放在文章最后。

## 2、真实主机是`Mac`

#### （1）安装虚拟机

如果真实主机是`Mac`，那么就下载`VirtualBox`，官网地址：https://www.virtualbox.org/    安装时安装选项全部选择默认就可以，这款软件是免费的。

#### （2）下载Windows10

在一个名为`我告诉你`的网站，可以下载到一切跟Microsoft相关的东西。https://msdn.itellyou.cn/  下载Windows10镜像，下图中选择Windows10 1909版本（后面数字越大越新），consumer editions（消费者版本），ed2k开头的选中部分复制到`迅雷`中即可下载

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204130024593.png" style="zoom: 25%;" />

#### （3）用虚拟机安装Windows10

汉化：`VirtualBox`-->`全局设置`-->`语言`-->`中文`

`新建`，输入名称，内存设置大于1G，剩下都点下一步就行，然后在新建的虚拟机中，光驱选择上一步中下载的Windows10镜像文件

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204130101897.png" style="zoom: 33%;" />

Windows10安装过程很简单，虚拟机开机之后，按照提示，基本默认下一步下一步就行。

#### （4）激活Windows10

Windows的激活，可以通过输入密匙（注册码）激活，也可以通过工具激活。

密匙在网上基本可以搜到能用的，例如这个  http://www.xitongcheng.com/jiaocheng/win10_article_55870.html?_360safeparam=647461812

密匙输入在Windows `设置`中，`系统`-->`关于`

通过工具激活，放在文章最后。

## 工具激活

以Windows10为例

工具的获取：http://www.jsgho.net/win10/  上下载一个Windows10 镜像，选择`ghost`开头的镜像，不要`安装版`

例如这个：

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204130112411.png" style="zoom:50%;" />

下载完成之后，可以用`360zip`https://yasuo.360.cn 免费无广告。这个工具进行解压。解压镜像文件

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204130113379.png" style="zoom: 67%;" />

然后下载ghos explorer ，下载地址为： https://baoku.360.cn/soft/show/appid/1900006143 ，选择`普通下载`即可，这个工具的官方网站已经不存在，因为出品这个工具的工具的公司被收购了，网站进行了重组，原官网地址为：http://www.symantec.com/themes/ghost/index.jsp     ，安装选项全部默认即可

用ghos explorer打开刚才下载好的镜像的解压目录，选择解压目录中.GHO结尾的文件。

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204130118155.png" style="zoom: 67%;" />

在GHO文件中，打开路径为Users\Administrator\Desktop，即可找到激活工具，拖出来就可以了。

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204130121686.png" style="zoom: 67%;" />

把该激活工具，复制到未激活的Windows10里面，直接打开，按照提示就可以激活了。
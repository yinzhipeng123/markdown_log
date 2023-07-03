# MAC安装Python



直接上官网下载MAC	Python安装包，不推荐使用brew安装

https://www.python.org/downloads/macos/

![image-20220703195200634](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207031952710.png)

我平时用的是3.8.2版本。下载后的安装包，双击打开，下一步下一步 就安装好了



M1,M2版本直接就选择macOS 64-bit universal2 installer 或者 macOS 64-bit installer



多版本共存问题：

个人电脑（Mac）直接安装多版本即可，小版本之间是互相覆盖安装，比如2.7.10和2.7.18，谁后安装的谁就把前者覆盖。

大版本之间可以共存，比如3.8.2、2.7.18，2.6.3、3.9.1之间就可以共存。不过Python3的命令，默认指向的是后安装的3版本。同理Python2命令也是默认指向后安装的2版本。

安装Pycharm，添加Python解释器时，可以选择Virtualenv环境，新建个虚拟环境，基础解释器选择自己安装的不通版本。一个项目一个虚拟环境。这样不会冲突

如果Pycharm 基础解释器选择不了，基本是读取本地变量问题，MAC建议卸载重装，直接安装官方版本，不要通过toolbox下载Pycharm。

MAC 跑python代码提示nodename nor servname provided

系统hosts 文件中要有

```
127.0.0.1	localhost 
```

推荐个切换自定义HOSTS的工具

[SwitchHosts/README.zh_hans.md at master · oldj/SwitchHosts · GitHub](https://github.com/oldj/SwitchHosts/blob/master/README.zh_hans.md)

然后清除dns设置

```

dscacheutil -flushcache
```


# Pycharm不能访问github



### Mac下

Pycharm访问github，一个是通过系统命令git，一个是通过本身的JAVA虚拟机

访问Github一般需要代理，MAC电脑上推荐安装V2rayU，官方下载地址为：[Releases · yanue/V2rayU (github.com)](https://github.com/yanue/V2rayU/releases)

安装后配置好代理服务器后，我一般打开全局模式

#### 配置Pycharm JAVA虚拟机的代理

需要在Pycharm设置中，设置为`自动检测代理设置`，如下图

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207070238918.png" alt="image-20220707023826840" style="zoom: 33%;" />

#### 配置Git命令行代理

查看V2rayU 设置，查看代理端口

这里解释下这些设置

MUX为多条 TCP 连接合并成一条，节省资源，提高并发能力

pac为一个哪些网站不需要代理就能上列表，pac监听端口为更新这个列表用的端口

V2ray指南：[Mux · V2Ray 配置指南|V2Ray 白话文教程 (toutyrater.github.io)](https://toutyrater.github.io/advanced/mux.html)

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207070242088.png" alt="image-20220707024219051" style="zoom:33%;" />



然后在命令行中输入

```bash
% git config --global http.proxy http://127.0.0.1:1087
% git config --global https.proxy https://127.0.0.1:1087
```



然后Pycharm就能正常访问Github了










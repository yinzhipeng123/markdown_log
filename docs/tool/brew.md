## brew

使用brew，https://brew.sh/zh-cn/

在终端进行安装前，因安装需要下载文件，可以在终端中输入代理后再执行安装：

```bash
设置代理，代理如何设置需请教资深人士
export http_proxy=https://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;export ALL_PROXY=socks5://127.0.0.1:1080

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

安装软件
brew install wget

安装软件如果需要openssl，这里需要注意下，安装openssl过程中，不能使用代理。
因为在make过程中需要访问一些本地的服务，代理会干扰

先下载openssl安装包
brew fetch openssl@3
取消代理
unset http_proxy
unset https_proxy
安装openssl
brew install openssl@3



```







### 查看包的安装路径

运行以下命令列出所有已安装的软件包及其文件路径：

```bash
v_yinzhipeng01@yinzhipeng123 ~ % brew list --verbose wget   
/opt/homebrew/Cellar/wget/1.25.0/INSTALL_RECEIPT.json
/opt/homebrew/Cellar/wget/1.25.0/bin/wget
/opt/homebrew/Cellar/wget/1.25.0/.brew/wget.rb
/opt/homebrew/Cellar/wget/1.25.0/ChangeLog
/opt/homebrew/Cellar/wget/1.25.0/AUTHORS
/opt/homebrew/Cellar/wget/1.25.0/sbom.spdx.json
/opt/homebrew/Cellar/wget/1.25.0/README
/opt/homebrew/Cellar/wget/1.25.0/COPYING
/opt/homebrew/Cellar/wget/1.25.0/NEWS
/opt/homebrew/Cellar/wget/1.25.0/.bottle/etc/wgetrc
/opt/homebrew/Cellar/wget/1.25.0/share/man/man1/wget.1
/opt/homebrew/Cellar/wget/1.25.0/share/locale/sl/LC_MESSAGES/wget-gnulib.mo
```



安装Homebrew



```sh

% export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;export ALL_PROXY=socks5://127.0.0.1:1080  #设置终端代理


% /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" #安装

```



官网介绍：[macOS（或 Linux）缺失的软件包的管理器 — Homebrew](https://brew.sh/zh-cn/)



安装常用软件

```sh
% export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;export ALL_PROXY=socks5://127.0.0.1:1080  #设置终端代理,每次打开新的终端都需要重新设置

% brew install nmap
% brew install tcping
% brew install wget
```


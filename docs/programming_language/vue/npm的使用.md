# npm的使用



NPM是随同NodeJS一起安装的包管理工具，能解决NodeJS代码部署上的很多问题，常见的使用场景有以下几种：

- 允许用户从NPM服务器下载别人编写的第三方包到本地使用。
- 允许用户从NPM服务器下载并安装别人编写的命令行程序到本地使用。
- 允许用户将自己编写的包或命令行程序上传到NPM服务器供别人使用。

由于新版的nodejs已经集成了npm，所以之前npm也一并安装好了。同样可以通过输入 **"npm -v"** 来测试是否成功安装。命令如下，出现版本提示表示安装成功

```bash
% npm -v
8.11.0
```



## 使用 npm 命令安装模块

npm 安装 Node.js 模块语法格式如下：

```bash
$ npm install <Module Name>
```



## 全局安装与本地安装

npm 的包安装分为本地安装（local）、全局安装（global）两种，从敲的命令行来看，差别只是有没有-g而已（MAC系统 -g需要命令前sudo），比如

```
npm install express          # 本地安装
sudo npm install express -g   # 全局安装
```

如果出现以下错误：

```
npm err! Error: connect ECONNREFUSED 127.0.0.1:8087 
```

解决办法为：

```
$ npm config set proxy null
```

### 本地安装

- 将安装包放在 ./node_modules 下（运行 npm 命令时所在的目录），如果没有 node_modules 目录，会在当前执行 npm 命令的目录下生成 node_modules 目录。
- 可以通过 require() 来引入本地安装的包。

### 全局安装

- 将安装包放在 /usr/local 下或者你 node 的安装目录。
- 可以直接在命令行里使用。

如果你希望具备两者功能，则需要在两个地方安装它或使用 **npm link**。



## 查看安装信息



你可以使用以下命令来查看所有全局安装的模块：

```bash
$ npm list -g

├─┬ cnpm@4.3.2
│ ├── auto-correct@1.0.0
│ ├── bagpipe@0.3.5
│ ├── colors@1.1.2
│ ├─┬ commander@2.9.0
│ │ └── graceful-readlink@1.0.1
│ ├─┬ cross-spawn@0.2.9
│ │ └── lru-cache@2.7.3
……
```

如果要查看某个模块的版本号，可以使用命令如下：

```bash
$ npm list grunt

projectName@projectVersion /path/to/project/folder
└── grunt@0.4.1
```





## 卸载模块

我们可以使用以下命令来卸载 Node.js 模块。

```bash
$ npm uninstall express
```

卸载后，如果全局安装的，你可以到 /node_modules/ （MAC在 /usr/local/lib/node_modules/ 下）目录下查看包是否还存在，或者使用以下命令查看，如果是本地安装，直接在安装目录进行查看：

```bash
$ npm ls
```



## 更新模块

我们可以使用以下命令更新模块：

```bash
$ npm update express
```

## 搜索模块

使用以下来搜索模块：

```bash
$ npm search express
```





## 使用淘宝 NPM 镜像

大家都知道国内直接使用 npm 的官方镜像是非常慢的，这里推荐使用淘宝 NPM 镜像。

淘宝 NPM 镜像是一个完整 npmjs.org 镜像，你可以用此代替官方版本(只读)，同步频率目前为 10分钟 一次以保证尽量与官方服务同步。

你可以使用淘宝定制的 cnpm (gzip 压缩支持) 命令行工具代替默认的 npm:

```bash
$ sudo npm install -g cnpm --registry=https://registry.npmmirror.com
```

这样就可以使用 cnpm 命令来安装模块了：

```bash
$ cnpm install [name]
```
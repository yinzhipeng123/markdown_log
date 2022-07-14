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





## npm更换镜像源



查看原来的源

```bash
npm congfig get registry
```

更换国内的源

```bash
npm config set registry https://registry.npm.taobao.org
```

安装从指定的源

```bash
npm install --registry=https://registry.npm.taobao.org
```



## `npm install`与`npm i`区别如下：

1. `npm i`安装的模块及依赖，使用`npm uninstall`是没有办法删除的，必须使用`npm uninstall i`才可以删除
2. `npm i`会帮助检测与当前`node`最匹配的`npm`的版本号，并匹配出相互依赖的`npm`包应该升级的版本号
3. `npm i`安装的一些包，在当前的`node`版本下是没有办法使用的，必须使用建议版本
4. `npm i`安装出现问题是不会出现`npm-debug.log`文件的，但`npm install`安装出现问题是有这个文件的

- `npm i XXX_name -S`  = >  `npm install XXX_name --save`    写入到 `dependencies` 对象

- `npm i XXX_name -D`  => `npm install XXX_name --save-dev`   写入到`devDependencies` 对象

-  `npm i XXX_name -g`  全局安装

  

- `i`是`install`的简写
- `-S`就是`--save`的简写
- `-D`就是`--save-dev`这样安装的包的名称及版本号就会存在`package.json`的`devDependencies`这个里面，而`--save`会将包的名称及版本号放在dependencies里面。



我们在使用`npm install`安装模块或插件的时候，有两种命令把他们写入到 `package.json`文件里面去，比如：

 `--save`

`--save-dev`**



在`package.json`文件里面提现出来的区别:

`--save`安装的插件，被写入到`dependencies`对象里面去。

`--save-dev`安装的插件，被写入到 `devDependencies`对象里面去。



`package.json`文件里面的`devDependencies`和`dependencies`对象有什么区别呢？

`devDependencies`里面的插件只用于开发环境，不用于生产环境。

`dependencies`是需要发布到生产环境的。




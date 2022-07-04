# vue安装



## mac下vue安装



### 命令行工具

Vue.js 提供一个官方命令行工具，可用于快速搭建大型单页应用。

```bash
% cd /opt/github/vue/
# 全局安装 vue-cli
$ sudo cnpm install --global vue-cli
...
All packages installed (228 packages installed from npm registry, used 3s(network 3s), speed 1.68MB/s, json 217(1014.4KB), tarball 4.63MB, manifests cache hit 0, etag hit 0 / miss 0)
[vue-cli@2.9.6] link /usr/local/bin/vue@ -> /usr/local/lib/node_modules/vue-cli/bin/vue
[vue-cli@2.9.6] link /usr/local/bin/vue-init@ -> /usr/local/lib/node_modules/vue-cli/bin/vue-init
[vue-cli@2.9.6] link /usr/local/bin/vue-list@ -> /usr/local/lib/node_modules/vue-cli/bin/vue-list

% npm ls -g                    
/usr/local/lib
├── cnpm@8.2.0
├── corepack@0.10.0
├── npm@8.13.2
└── vue-cli@2.9.6

$ vue init webpack my-project

```

如果不开代理这里会卡住，然后过几分钟后就会报告 vue-cli · Failed to download repo vuejs-templates/webpack: connect ECONNREFUSED 127.0.0.1:443

Mac可以安装V2rayU这款APP，设置代理之后，然后在APP中点击 `复制终端代理命令` 然后在终端中粘贴上

```bash
export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;export ALL_PROXY=socks5://127.0.0.1:1080
```

然后重新运行命令即可

```bash
$ vue init webpack my-project

> my-project@1.0.0 lint
> eslint --ext .js,.vue src test/unit test/e2e/specs


# Project initialization finished!
# ========================

To get started:

  cd my-project
  npm run dev
  
Documentation can be found at https://vuejs-templates.github.io/webpack

% ls
my-project
% cd my-project
% npm run dev
DONE  Compiled successfully in 2533ms                                  21:32:05

I  Your application is running here: http://localhost:8080

```

访问页面：

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207042221996.png" alt="image-20220704222119897" style="zoom: 67%;" />



编译打包

```bash
% npm run build
...
  Build complete.

  Tip: built files are meant to be served over an HTTP server.
  Opening index.html over file:// won't work.

% ls
README.md		index.html		src
build			node_modules		static
config			package-lock.json	test
dist			package.json
% cd dist 
% ls
index.html	static
```



如果直接双击 index.html 打开浏览器，页面可能是空白了，想要修改下 index.html 文件中 js、css 路径即可。

例如我们打开 dist/index.html 文件看到路径是绝对路径：

```
<link href=/static/css/app.33da80d69744798940b135da93bc7b98.css rel=stylesheet>
<script type=text/javascript src=/static/js/app.717bb358ddc19e181140.js></script>
```

我们把 js、css 路径路径修改为相对路径：

```
<link href=static/css/app.33da80d69744798940b135da93bc7b98.css rel=stylesheet>
<script type=text/javascript src=static/js/app.717bb358ddc19e181140.js></script>
```

这样直接双击 dist/index.html 文件就可以在浏览器中看到效果了。

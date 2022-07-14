# vue的目录文件



```bash
% ls -la
total 3000
drwxr-xr-x    20 zhipengyin  wheel      640  7  4 22:29 .
drwxr-xr-x     4 zhipengyin  wheel      128  7  4 22:29 ..
-rw-r--r--@    1 zhipengyin  wheel     6148  7  4 22:29 .DS_Store
-rw-r--r--     1 zhipengyin  wheel      402  7  4 21:21 .babelrc
-rw-r--r--     1 zhipengyin  wheel      147  7  4 21:21 .editorconfig
-rw-r--r--     1 zhipengyin  wheel       51  7  4 21:21 .eslintignore
-rw-r--r--     1 zhipengyin  wheel      791  7  4 21:21 .eslintrc.js
-rw-r--r--     1 zhipengyin  wheel      213  7  4 21:21 .gitignore
-rw-r--r--     1 zhipengyin  wheel      246  7  4 21:21 .postcssrc.js
-rw-r--r--     1 zhipengyin  wheel      553  7  4 21:21 README.md
drwxr-xr-x    10 zhipengyin  wheel      320  7  4 21:21 build
drwxr-xr-x     6 zhipengyin  wheel      192  7  4 21:21 config
drwxr-xr-x     5 zhipengyin  wheel      160  7  4 22:29 dist
-rw-r--r--     1 zhipengyin  wheel      272  7  4 21:21 index.html
drwxr-xr-x  1114 zhipengyin  wheel    35648  7  4 21:28 node_modules
-rw-r--r--     1 zhipengyin  wheel  1489998  7  4 21:28 package-lock.json
-rw-r--r--     1 zhipengyin  wheel     2733  7  4 21:21 package.json
drwxr-xr-x     7 zhipengyin  wheel      224  7  4 21:21 src
drwxr-xr-x     3 zhipengyin  wheel       96  7  4 21:21 static
drwxr-xr-x     4 zhipengyin  wheel      128  7  4 21:21 test
```

### 目录解析

| 目录/文件    | 说明                                                         |
| :----------- | :----------------------------------------------------------- |
| build        | 项目构建(webpack)相关代码                                    |
| config       | 配置目录，包括端口号等。我们初学可以使用默认的。             |
| node_modules | npm 加载的项目依赖模块                                       |
| src          | 这里是我们要开发的目录，基本上要做的事情都在这个目录里。里面包含了几个目录及文件：assets: 放置一些图片，如logo等。<br />components: 目录里面放了一个组件文件，可以不用。<br />App.vue: 项目入口文件，我们也可以直接将组件写这里，而不使用 components 目录。<br />main.js: 项目的核心文件。 |
| static       | 静态资源目录，如图片、字体等。                               |
| test         | 初始测试目录，可删除                                         |
| .xxxx文件    | 这些是一些配置文件，包括语法配置，git配置等。                |
| index.html   | 首页入口文件，你可以添加一些 meta 信息或统计代码啥的。       |
| package.json | 项目配置文件。                                               |
| README.md    | 项目的说明文档，markdown 格式                                |



下载WebStorm，让WebStorm打开/opt/github/vue/my-project 目录，点击这里，可以在WebStrom运行程序

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207042321733.png" alt="image-20220704232138680" style="zoom: 33%;" />

修改 /opt/github/vue/my-project/src/components/HelloWorld.vue 文件



```vue
。。。。

<script>
export default {
  name: 'HelloWorld',
  data () {
    return {
      msg: '欢迎来到VUE教程！'
    }
  }
}
</script>
```

访问页面

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207042328009.png" alt="image-20220704232824958" style="zoom:25%;" />
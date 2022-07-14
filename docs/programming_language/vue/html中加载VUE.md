# 在HTML中加载VUE



创建一个 `.html` 文件，然后通过如下方式引入 Vue：

```vue
<!-- 开发环境版本，包含了有帮助的命令行警告 -->
<script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
```

或者：

```vue
<!-- 生产环境版本，优化了尺寸和速度 -->

<script src="https://cdn.jsdelivr.net/npm/vue@2"></script>


```



Demo：

Hello.html

```vue
<!DOCTYPE html>
<html>
<head>
  <title>My first Vue app</title>
  <script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
</head>
<body>
<div id="app">
  {{ message }}
</div>

<script>
  var app = new Vue({
    el: '#app',
    data: {
      message: 'Hello Vue!'
    }
  })
</script>
</body>
</html>

```

浏览器打开：

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207050056603.png" alt="image-20220705005621549" style="zoom: 33%;" />



HTML标签查询

[HTML 标签参考手册 (w3school.com.cn)](https://www.w3school.com.cn/tags/index.asp)

CSS属性查询

[CSS 参考手册 | 菜鸟教程 (runoob.com)](https://www.runoob.com/cssref/css-reference.html)

Javascript查询

[JavaScript 教程 (w3school.com.cn)](https://www.w3school.com.cn/js/index.asp)



可以在浏览器中下载Vue.js devtools插件

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207051553483.png" alt="image-20220705155305418" style="zoom:33%;" />

这样就可以在控制台上对VUE进行调试

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207051555114.png" alt="image-20220705155523065" style="zoom:33%;" />
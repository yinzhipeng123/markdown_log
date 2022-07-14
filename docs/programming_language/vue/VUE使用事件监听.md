VUE使用事件监听

```vue
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Vue 测试实例 - 菜鸟教程(runoob.com)</title>
<script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
</head>
<body>
<div id="app">
  <button v-on:click="counter += 1">增加 1</button>
  <p>这个按钮被点击了 {{ counter }} 次。</p>
</div>

<script>
new Vue({
  el: '#app',
  data: {
    counter: 0
  }
})
</script>
</body>
</html>
```



[事件处理 — Vue.js (vuejs.org)](https://cn.vuejs.org/v2/guide/events.html)
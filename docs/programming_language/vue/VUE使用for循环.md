VUE使用for循环

```vue
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Vue 测试实例 </title>
  <script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
</head>
<body>
<div id="app">
  <ol>
    <li v-for="site in sites">
      {{ site.name }}
    </li>
  </ol>
</div>

<script>
  new Vue({
    el: '#app',
    data: {
      sites: [
        { name: 'Runoob' },
        { name: 'Google' },
        { name: 'Taobao' }
      ]
    }
  })
</script>
</body>
</html>

```



[列表渲染 — Vue.js (vuejs.org)](https://cn.vuejs.org/v2/guide/list.html)


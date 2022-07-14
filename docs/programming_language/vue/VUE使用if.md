VUE使用if

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
  <div v-if="type === 'A'">
    A
  </div>
  <div v-else-if="type === 'B'">
    B
  </div>
  <div v-else-if="type === 'C'">
    C
  </div>
  <div v-else>
    Not A/B/C
  </div>
</div>

<script>
  new Vue({
    el: '#app',
    data: {
      type: 'C'
    }
  })
</script>
</body>
</html>

```



[条件渲染 — Vue.js (vuejs.org)](https://cn.vuejs.org/v2/guide/conditional.html)


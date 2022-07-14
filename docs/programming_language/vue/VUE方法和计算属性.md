VUE方法和计算属性



计算属性

```vue
<!DOCTYPE html>
<html>
<head>
    <title>My first Vue app</title>
    <script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
</head>
<body>
<div id="app">
    {{ message.split('').reverse().join('') }}
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



方法和计算属性

```vue
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
  <div id="app">
      <p>当前时间方法:{{getCurrentTime()}}</p>
      <p>当前时间属性:{{getCurrentTime1}}</p>
  </div>

<script type="text/javascript" src="js/vue.js"></script>
<script type="text/javascript">
    var app = new Vue({
        el:"#app",
        methods:{
            getCurrentTime:function(){
                return Date.now();
            }
        },
        computed:{
            getCurrentTime1:function(){
                return Date.now();
            }
        }
    })
</script>
</body>
</html>
```

计算属性中的值只计算一次

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207060121699.png" alt="image-20220706012101626" style="zoom: 33%;" />

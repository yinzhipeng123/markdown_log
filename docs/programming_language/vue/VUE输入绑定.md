VUE输入绑定

```vue
<!DOCTYPE html>
<html>
<head>
    <title>My first Vue app</title>
    <script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
</head>
<body>
<div id="app">
    <input v-model="message" placeholder="edit me">
    <p>
        meaasge is : {{ message }}
    </p>
    <div id="example-5">
        <select v-model="selected">
            <option disabled value="">请你选择</option>
            <option>A</option>
            <option>B</option>
            <option>C</option>
        </select>
        <span>Selected: {{ selected }}</span>
    </div>
</div>

<script>
    var app = new Vue({
        el: '#app',
        data: {
            message: 'Hello Vue!',
            selected: ''
        }
    })
</script>
</body>
</html>
```


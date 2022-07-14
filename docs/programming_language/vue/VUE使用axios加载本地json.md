VUE使用axios加载本地json





```vue
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>

<div id="example">
    <div>
        名称:{{info.name}}
    </div>
    <div>
        地址:{{info.address.country}}-{{info.address.city}}-{{info.address.street}}
    </div>
    <div>
        链接:<a v-bind:href="info.url" target="_blank">{{info.url}}</a>
    </div>
    <ul>
        <li v-for="link in info.links">{{link.name}}-{{link.url}}</li>
    </ul>
</div>


<!--<script type="text/javascript" src="js/vue.js"></script>-->
<!--<script type="text/javascript" src="js/axios.min.js"></script>-->
<script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript">
    var example = new Vue({
        el: '#example',
        data() {
            return {
                info: {
                    name: '',
                    address: {
                        country: '',
                        city: '',
                        street: ''
                    },
                    links: []
                }
            }
        },
        mounted() {
            axios.get('data.json').then(response => this.info = response.data)
        }
    })
</script>

</body>
</html>

```



同级目录数据：data.json



```json
{
  "name": "百度",
  "url": "http://www.baidu.com",
  "page": 66,
  "isNonProfit": true,
  "address": {
    "street": "海定区",
    "city": "北京市",
    "country": "中国"
  },
  "links": [
    {
      "name": "Google",
      "url": "http://www.google.com"
    },
    {
      "name": "Baidu",
      "url": "http://www.baidu.com"
    },
    {
      "name": "Sougou",
      "url": "http://www.sougou.com"
    }
  ]
}
```


# node.js运行服务器的例子



创建文件 server.js

```js
var http = require('http');

http.createServer(function (request, response) {

    // 发送 HTTP 头部 
    // HTTP 状态值: 200 : OK
    // 内容类型: text/plain
    response.writeHead(200, {'Content-Type': 'text/plain'});

    // 发送响应数据 "Hello World"
    response.end('Hello World\n');
}).listen(8888);

// 终端打印如下信息
console.log('Server running at http://127.0.0.1:8888/');
```

运行

```bash
~ % node server.js
Server running at http://127.0.0.1:8888/
```

访问

![image-20220703202605627](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207032026673.png)


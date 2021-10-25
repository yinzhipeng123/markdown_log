# Flask框架

一个基于python的，简单快速的WEB框架

GitHub地址：https://github.com/pallets/flask

官方文档：https://flask.palletsprojects.com/en/2.0.x/

# Flask g 对象

### 1.什么是g对象。

1.在flask中，有一个专门用来存储用户信息的g对象，g的全称的为global。
2.g对象在一次请求中的所有的代码的地方，都是可以使用的。

### 2.g对象和session的区别

在我看来，最大的区别是，session对象是可以跨request的，只要session还未失效，不同的request的请求会获取到同一个session，但是g对象不是，g对象不需要管过期时间，请求一次就g对象就改变了一次，或者重新赋值了一次

也就是session可以在我们的这个网站随意都可以用 而 g只能是这次的请求如果重定向之后就会改变

flask_g.py

```python
from flask import Flask, g, request
from util import login_log

app = Flask(__name__)

@app.route('/login/', methods=['GET', 'POST'])
def login():
    username = request.args.get('username')

    if username == 'key':
        g.username = username
        login_log()
        return '恭喜您！登录成功'
    else:
        return '登录名或密码错误!'

if __name__ == '__main__':
    app.run()
```

util.py

```
from flask import  g
def login_log():
    print('登录名为: {}'.format(g.username))
```

启动flask_g.py  

浏览器访问 http://127.0.0.1:5000/login/?username=key

控制台输出 

```
登录名为: key
```

g对象的使用案例：https://vimsky.com/examples/detail/python-method-flask.g.html



# Flask Request对象

来自客户端网页的数据作为全局请求对象发送到服务器。为了处理请求数据，应该从Flask模块导入。

Request对象的重要属性如下所列：

- **Form** - 它是一个字典对象，包含表单参数及其值的键和值对。
- **args** - 解析查询字符串的内容，它是问号（？）之后的URL的一部分。
- **Cookies** - 保存Cookie名称和值的字典对象。
- **files** - 与上传文件有关的数据。
- **method** - 当前请求方法。

| 属性名                   | 解释                                                         |
| ------------------------ | ------------------------------------------------------------ |
| form                     | 一个从POST和PUT请求解析的 MultiDict（一键多值字典）。        |
| args                     | MultiDict，要操作 URL （如 ?key=value ）中提交的参数可以使用 args 属性:searchword = request.args.get('key', '') |
| values                   | CombinedMultiDict，内容是form和args。 可以使用values替代form和args。 |
| cookies                  | 请求的cookies，类型是dict。                                  |
| stream                   | 在可知的mimetype下，如果进来的表单数据无法解码，会没有任何改动的保存到这个 stream 以供使用。很多时候，当请求的数据转换为string时，使用data是最好的方式。这个stream只返回数据一次。 |
| headers                  | 请求头，字典类型。                                           |
| data                     | 包含了请求的数据，并转换为字符串，除非是一个Flask无法处理的mimetype。 |
| files                    | MultiDict，带有通过POST或PUT请求上传的文件。                 |
| environ                  | WSGI隐含的环境配置。                                         |
| method                   | 请求方法，比如POST、GET。                                    |
| path                     | 获取请求文件路径：/myapplication/page.html                   |
| base_url                 | 获取域名与请求文件路径：http://www.baidu.com/myapplication/page.html |
| url                      | 获取全部url：http://www.baidu.com/myapplication/page.html?id=1&edit=edit |
| url_root                 | 获取域名：http://www.baidu.com/                              |
| is_xhr                   | 如果请求是一个来自JavaScript XMLHttpRequest的触发，则返回True，这个只工作在支持X-Requested-With头的库并且设置了XMLHttpRequest。 |
| blueprint                | 蓝图名字。                                                   |
| endpoint                 | endpoint匹配请求，这个与view_args相结合，可是用于重构相同或修改URL。当匹配的时候发生异常，会返回None。 |
| json                     | 如果mimetype是application/json，这个参数将会解析JSON数据，如果不是则返回None。 可以使用这个替代get_json()方法。 |
| max_content_length       | 只读，返回MAX_CONTENT_LENGTH的配置键。                       |
| module                   | 如果请求是发送到一个实际的模块，则该参数返回当前模块的名称。这是弃用的功能，使用blueprints替代。 |
| routing_exception = None | 如果匹配URL失败，这个异常将会/已经抛出作为请求处理的一部分。这通常用于NotFound异常或类似的情况。 |



## Flask Response对象

https://blog.csdn.net/qq_42666483/article/details/82526765


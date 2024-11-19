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





在 Flask 中，`g` 对象是一个全局的上下文变量，用于在一次请求的生命周期内存储和共享数据。`g` 对象由 Flask 提供，它是 `flask.g` 模块中的一个特殊对象。以下是关于 `g` 对象的一些关键点和使用方法的详细讲解：

---

### **`g` 对象的特性**
1. **请求上下文**：
   - `g` 是和 Flask 的请求上下文绑定的，这意味着它的生命周期与当前请求是同步的。
   - 每个请求会有自己的独立的 `g` 对象，彼此之间互不影响。

2. **线程安全**：
   - Flask 使用线程局部存储来实现 `g` 对象的线程隔离。即使在多线程环境中，每个线程都有自己的 `g` 对象。

3. **动态属性**：
   - `g` 是一个空对象（类似于 Python 的 `SimpleNamespace`），你可以动态地为它添加属性。

4. **临时存储**：
   - `g` 通常用来存储在请求中共享但只需要在请求范围内存在的数据。

---

### **常见使用场景**
1. **存储数据库连接**：
   在每次请求中，可以将数据库连接存储到 `g` 对象中，以便在请求结束时释放资源。

   ```python
   from flask import Flask, g
   import sqlite3
   
   app = Flask(__name__)
   
   def get_db():
       if 'db' not in g:
           g.db = sqlite3.connect("example.db")
       return g.db
   
   @app.teardown_appcontext
   def close_db(exception):
       db = g.pop('db', None)
       if db is not None:
           db.close()
   
   @app.route('/')
   def index():
       db = get_db()
       # 使用数据库执行操作
       return "Hello, Flask!"
   ```

2. **存储用户信息**：
   当一个请求需要验证用户身份时，可以将用户对象存储到 `g` 中，方便后续访问。

   ```python
   from flask import Flask, g, request
   
   app = Flask(__name__)
   
   @app.before_request
   def load_user():
       # 假设我们从请求中获取用户 ID
       user_id = request.headers.get('User-ID')
       g.user = {"id": user_id, "name": "Test User"}  # 模拟用户信息
   
   @app.route('/profile')
   def profile():
       user = g.get('user')
       if user:
           return f"Hello, {user['name']}!"
       return "User not found!", 404
   ```

3. **共享跨函数变量**：
   `g` 提供了一种方便的方法来共享变量而无需显式传递。

---

### **常用方法**
1. **`g.get(key, default=None)`**：
   获取 `g` 对象中的属性，如果不存在则返回默认值。

2. **动态赋值**：
   可以直接通过 `g.<属性名>` 的形式设置任意数据。

---

### **注意事项**
1. **只用于当前请求**：
   - 不要将需要跨请求持久化的数据存储在 `g` 中，因为 `g` 对象只在请求期间有效。
   
2. **生命周期**：
   - 在请求处理函数返回后，`g` 对象会被清理。因此，不能在请求之外访问它。

3. **避免滥用**：
   - 不要将 `g` 作为全局变量的替代品，过度依赖 `g` 会让代码难以维护。

---

### **总结**
`g` 是 Flask 提供的一个方便工具，适合用于在请求范围内共享临时数据，避免显式传递参数的麻烦。在实际使用中，可以结合 `@app.before_request` 和 `@app.teardown_appcontext` 等钩子函数来管理和清理 `g` 中的数据。

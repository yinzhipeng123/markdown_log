Mypy是Python的可选静态类型检查器。您可以在Python程序中添加类型提示（PEP 484），并使用mypy进行静态类型检查。查找程序中的错误，甚至不运行它们！

安装

```shell
pip3 install mypy
```

Test继承ABC

1.

```
class ABC(object):

    def prt(self):
        print(self)
        print(self.__class__)


class Test(ABC):
    def prt(self):
        print(self)
        print(self.__class__)

    def prc(self):
        print("abc")


g: "ABC" = Test()
g.prt()
```

运行结果:

```bash
(venv) D:\idea\flask_learn>mypy learn.py
Success: no issues found in 1 source file
```

2

```
class ABC(object):

    def prt(self):
        print(self)
        print(self.__class__)


class Test(ABC):
    def prt(self):
        print(self)
        print(self.__class__)

    def prc(self):
        print("abc")


g: "ABC" = Test()
g.prc()
```

运行结果：

```bash
(venv) D:\idea\flask_learn>mypy learn.py
learn.py:18: error: "ABC" has no attribute "prc"
Found 1 error in 1 file (checked 1 source file)

```

3

```python
class Person(object):  # 定义一个父类

    def talk(self):  # 父类中的方法
        print("person is talking....")


class Chinese(Person):  # 定义一个子类， 继承Person类

    def walk(self):  # 在子类中定义其自身的方法
        print('is walking...')


g: "Person" = Chinese()
g.walk()
```

运行结果：

```bash
(venv) D:\idea\flask_learn>mypy learn.py
learn.py:14: error: "Person" has no attribute "walk"
Found 1 error in 1 file (checked 1 source file)
```





平时我们代码大概都是下面的样子

```python
# 参数name的类型是未知的
# 返回的类型也是未知的
def greeting(name):
    return 'Hello ' + name
```

稍微修改一些



```rust
# 参数name后面跟了:str 代表name期望是str类型
# 参数括号后面跟了->str代表返回类型为str类型
def greeting(name: str) -> str:
    return 'Hello ' + name
x: str = 'xxx' # 声明一个变量为str类型
greeting(x) # Hello xxx
greeting(123) # TypeError: can only concatenate str (not "int") to str
```

到目前为止仅有str、float等基本类型，使用list、tuple复杂类型需要引用typing中的类型

### LIST

数组类型



```python
from typing import List

# 参数names为list类型并且元素都是str类型
# 返回为None
def greet_all(names: List[str]) -> None:
    for name in names:
        print('Hello ' + name)

names = ["Alice", "Bob", "Charlie"]
ages = [10, 20, 30]

greet_all(names)   # Ok!
greet_all(ages)    #出错了 Error due to incompatible types 
```

### Dict

字典类型



```python
from typing import Dict

# Dict[int, str] int代表key类型， str代表val类型
def test(t: Dict[int, str]) -> Dict:
    return t

test({1: '234'}) # {1: '234'}
```

### Iterable

可以迭代类型包括 List、Set、Tuple、Str、Dict



```python
def greeting(names: Iterable[str]) -> None:
    for name in names:
        print(name)

greeting(['aaa', 'bbb']) # list aaa bbb
greeting(('ccc', 'ddd')) # tuple ccc ddd
greeting({'eee', 'fff'}) # set eee fff
greeting({'ggg': 'hhh'}) # dict ggg
greeting('123') # str 1 2 3 
greeting(678) # error: Argument 1 to "greeting" has incompatible type "int"; expected "Iterable[str]"
```

### Union

接受多个指定类型，但不接受除此外的类型



```python
from typing import Union
# user_id 只能为int或者str
def normalize_id(user_id: Union[int, str]) -> str:
    if isinstance(user_id, int):
        return 'user-{}'.format(100000 + user_id)
    else:
        return user_id
normalize_id(1) # user-100001
normalize_id('2') # 2
```

### Optional

可选类型，给参数设置默认值



```python
from typing import Optional

# Optional[str]只是Union [str，None]的简写或别名。它主要是为了方便帮助功能签名看起来更清洁
# Optional[str, int] 只能包含一个类型, 这样是不正确的
def greeting(name: Optional[str] = None) -> str:
    if name is None:
        name = 'stranger'
    return 'Hello, ' + name
greeting() # Hello, stranger
greeting('123') # Hello, 123
```

### Any

有时候我们不确定是什么类型的时候可以用到Any



```python
from typing import Any

def greeting(name: Any = None) -> str:
    if name is None:
        name = 'stranger'

    return 'Hello, ' + str(name)

greeting() # Hello, stranger
greeting('123') # Hello, 123
greeting(234) # Hello, 234
greeting([345]) # Hello, [345]
```

### TypeVar

自定义类型



```python
from typing import TypeVar

T = TypeVar('T') # 任意类型
A = TypeVar('A', int, str) # A类型只能为int或str
def test(t: A) -> None:
    print(t)
test(1)
```


































Python 的基础语法简单直观，非常适合初学者上手。以下是 Python 中的一些关键基础语法概念和示例：

---

### **1. 注释**
- **单行注释**：用 `#` 开头。
- **多行注释**：用三引号 `'''` 或 `"""` 包裹。

```python
# 这是一个单行注释

"""
这是一个多行注释
也可以用于文档字符串
"""
```

---

### **2. 基本数据类型**
- **整数** (`int`): 任意大小的整数。
- **浮点数** (`float`): 带小数的数值。
- **字符串** (`str`): 使用单引号 `'` 或双引号 `"`。
- **布尔值** (`bool`): `True` 或 `False`。

```python
x = 10          # 整数
y = 3.14        # 浮点数
name = "Alice"  # 字符串
is_active = True  # 布尔值
```

---

### **3. 变量**
- 变量名区分大小写，不能以数字开头。
- 使用赋值符号 `=`。

```python
age = 25
price = 99.99
name = "Python"
```

---

### **4. 控制语句**
#### **条件语句**
```python
x = 10

if x > 5:
    print("x is greater than 5")
elif x == 5:
    print("x is equal to 5")
else:
    print("x is less than 5")
```

#### **循环语句**
- **`for` 循环**：用于遍历可迭代对象。
```python
for i in range(5):  # range(5) 生成 0-4 的整数
    print(i)
```

- **`while` 循环**：满足条件时反复执行。
```python
n = 0
while n < 5:
    print(n)
    n += 1  # 每次加 1
```

---

### **5. 函数**
- 使用 `def` 定义函数，`return` 返回值。

```python
def greet(name):
    return f"Hello, {name}!"

print(greet("Alice"))  # 输出: Hello, Alice!
```

---

### **6. 数据结构**
#### **列表 (List)**：有序，可变。
```python
fruits = ["apple", "banana", "cherry"]
fruits.append("orange")  # 添加元素
print(fruits[1])  # 访问第二个元素
```

#### **元组 (Tuple)**：有序，不可变。
```python
coordinates = (10, 20)
print(coordinates[0])  # 访问第一个元素
```

#### **集合 (Set)**：无序，唯一值。
```python
unique_numbers = {1, 2, 3, 3}
print(unique_numbers)  # 输出: {1, 2, 3}
```

#### **字典 (Dict)**：键值对存储。
```python
person = {"name": "Alice", "age": 25}
print(person["name"])  # 访问键 "name" 的值
person["age"] = 26  # 修改值
```

---

### **7. 运算符**
- **算术运算符**：`+`, `-`, `*`, `/`, `//` (整除), `%` (取余), `**` (幂次方)。
- **比较运算符**：`==`, `!=`, `>`, `<`, `>=`, `<=`。
- **逻辑运算符**：`and`, `or`, `not`。

```python
x = 10
y = 20

print(x + y)  # 加法
print(x > y)  # 比较
print(x > 5 and y < 30)  # 逻辑运算
```

---

### **8. 文件操作**
- **读取文件**：
```python
with open("file.txt", "r") as file:
    content = file.read()
    print(content)
```

- **写入文件**：
```python
with open("file.txt", "w") as file:
    file.write("Hello, World!")
```

---

### **9. 异常处理**
使用 `try` 和 `except` 捕获异常。
```python
try:
    result = 10 / 0
except ZeroDivisionError:
    print("Cannot divide by zero!")
```

---

### **10. 模块和库**
- 导入标准库或自定义模块。
```python
import math

print(math.sqrt(16))  # 输出: 4.0
```

---

### **11. 面向对象编程**
- 使用 `class` 定义类，`self` 表示实例本身。

```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def greet(self):
        return f"Hi, I'm {self.name}!"

p = Person("Alice", 25)
print(p.greet())  # 输出: Hi, I'm Alice!
```

---

### **12. 列表推导式**
简洁创建列表的方法。
```python
squares = [x**2 for x in range(5)]  # [0, 1, 4, 9, 16]
```

---

### **13. 常用内置函数**
- `len()`：获取长度。
- `type()`：获取类型。
- `print()`：输出到控制台。
- `input()`：接收用户输入。
- `sum()`：求和。

```python
nums = [1, 2, 3]
print(len(nums))  # 输出: 3
print(type(nums))  # 输出: <class 'list'>
```


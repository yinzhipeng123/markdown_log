## 类的继承

```python

class Person(object):   # 定义一个父类
 
    def talk(self):    # 父类中的方法
        print("person is talking....")  
 
 
class Chinese(Person):    # 定义一个子类， 继承Person类
 
    def walk(self):      # 在子类中定义其自身的方法
        print('is walking...')
 
c = Chinese()
c.talk()      # 调用继承的Person类的方法
c.walk()     # 调用本身的方法
 
# 输出
 
person is talking....
is walking...
```

## 构造函数的继承

1. 经典类的写法：

   ```python
    父类名称.__init__(self,参数1，参数2，...)
   ```

2. 新式类的写法：

   ```python
   super(子类，self).__init__(参数1，参数2，....)
   ```

   

```python
class Person(object):
 
    def __init__(self, name, age):
        self.name = name
        self.age = age
        self.weight = 'weight'
 
    def talk(self):
        print("person is talking....")
 
 
class Chinese(Person):
 
    def __init__(self, name, age, language):  # 先继承，在重构
        Person.__init__(self, name, age)  #继承父类的构造方法，也可以写成：super(Chinese,self).__init__(name,age)
        self.language = language    # 定义类的本身属性
 
    def walk(self):
        print('is walking...')
 
 
class American(Person):
    pass
 
c = Chinese('bigberg', 22, 'Chinese')
```

## 子类对父类方法的重写

```python
class Person(object):
 
    def __init__(self, name, age):
        self.name = name
        self.age = age
        self.weight = 'weight'
 
    def talk(self):
        print("person is talking....")
 
class Chinese(Person):
 
    def __init__(self, name, age, language): 
        Person.__init__(self, name, age) 
        self.language = language
        print(self.name, self.age, self.weight, self.language)
 
    def talk(self):  # 子类 重构方法
        print('%s is speaking chinese' % self.name)
 
    def walk(self):
        print('is walking...')
 
c = Chinese('bigberg', 22, 'Chinese')
c.talk()
 
# 输出
bigberg 22 weight Chinese
bigberg is speaking chinese
```

## 类继承的事例

```python
class SchoolMember(object):
    '''学习成员基类'''
    member = 0
 
    def __init__(self, name, age, sex):
        self.name = name
        self.age = age
        self.sex = sex
        self.enroll()
 
    def enroll(self):
        '注册'
        print('just enrolled a new school member [%s].' % self.name)
        SchoolMember.member += 1
 
    def tell(self):
        print('----%s----' % self.name)
        for k, v in self.__dict__.items():
            print(k, v)
        print('----end-----')
 
    def __del__(self):
        print('开除了[%s]' % self.name)
        SchoolMember.member -= 1
 
 
class Teacher(SchoolMember):
    '教师'
    def __init__(self, name, age, sex, salary, course):
        SchoolMember.__init__(self, name, age, sex)
        self.salary = salary
        self.course = course
 
    def teaching(self):
        print('Teacher [%s] is teaching [%s]' % (self.name, self.course))
 
 
class Student(SchoolMember):
    '学生'
 
    def __init__(self, name, age, sex, course, tuition):
        SchoolMember.__init__(self, name, age, sex)
        self.course = course
        self.tuition = tuition
        self.amount = 0
 
    def pay_tuition(self, amount):
        print('student [%s] has just paied [%s]' % (self.name, amount))
        self.amount += amount
 
t1 = Teacher('Wusir', 28, 'M', 3000, 'python')
t1.tell()
s1 = Student('haitao', 38, 'M', 'python', 30000)
s1.tell()
s2 = Student('lichuang', 12, 'M', 'python', 11000)
print(SchoolMember.member)
del s2
 
print(SchoolMember.member)
 
 
 
# 输出
----end-----
just enrolled a new school member [haitao].
----haitao----
age 38
sex M
name haitao
amount 0
course python
tuition 30000
----end-----
just enrolled a new school member [lichuang].
3
开除了[lichuang]
2
开除了[Wusir]
开除了[haitao]
```


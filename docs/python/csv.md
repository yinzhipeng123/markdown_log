## Python csv模块

Python csv模块使用方法代码实例，复制粘贴运行即可

```python
import csv


def writeDict1():
    headers = ['ID', 'NAME', 'Age', 'Height']
    # 表格内容
    rows = [('1', 'LiLi', 18, 165), ('2', 'Jack', 20, 170), ('3', 'Marry', 21, 168)]
    with open('test1.csv', 'w', encoding='utf_8_sig') as csvfile:
        spamwriter = csv.writer(csvfile)
        spamwriter.writerow(headers)
        spamwriter.writerows(rows)


def writeDict2():
    with open('test2.csv', 'w') as csvfile:
        # 创建字段名
        fieldnames = ['first_name', 'last_time']
        # 创建字段写入对象
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        # 写入表格内容
        writer.writerow({'first_name': 'Baked', 'last_time': 'Beans'})
        writer.writerow({'first_name': 'Baked', 'last_time': 'Beans'})
        writer.writerow({'first_name': 'Baked', 'last_time': 'Beans'})


def readDict1():
    with open("test1.csv", 'r', encoding='utf_8_sig') as f:
        f_csv = csv.reader(f)
        for row in f_csv:
            print(row)


def readDict2():
    with open('test2.csv', 'r') as csvfile:
        # 读取文件
        reader = csv.DictReader(csvfile)
        # 遍历输入指定字段的内容
        for row in reader:
            print(row['first_name'], row['last_time'])


if __name__ == '__main__':
    writeDict1()
    writeDict2()
    readDict1()
    readDict2()
```



```python
import csv

with open('data.csv','w+',encoding='utf-8',newline='') as csvfile:
    writer = csv.writer(csvfile)
    # 写入一行
    writer.writerow(['1', '2', '3', '4', '5', '5', '6'])
```

# Python 生成xlsx表格

## xlsxwriter模块

特点：只能写入，不能读

```Python
import xlsxwriter
workbook = xlsxwriter.Workbook('currency_format.xlsx')
cell_format_one = workbook.add_format({'bold': True, 'font_color': 'red'})
cell_format_two = workbook.add_format({'bold': False, 'font_color': 'green'})
# cell_format_two.set_font_color('red')
worksheet = workbook.add_worksheet()
# 第一行
worksheet.write(0, 0, 'h', cell_format_one)
worksheet.write(0, 1, 'e', cell_format_one)
worksheet.write(0, 2, 'l', cell_format_one)
worksheet.write(0, 3, 'l', cell_format_one)
worksheet.write(0, 4, 'o', cell_format_one)
# 第二行
worksheet.write(1, 0, 'w', cell_format_two)
worksheet.write(1, 1, 'o', cell_format_two)
worksheet.write(1, 2, 'r', cell_format_two)
worksheet.write(1, 3, 'l', cell_format_two)
worksheet.write(1, 4, 'd', cell_format_two)
worksheet.write(1, 5, '!', cell_format_two)
workbook.close()
print('end !')
```



可以把 showrow 设置为全局变量或者方法内变量，代表总行数，show_add_row调用一次，自动加一，调用一次方法行数自动加一

```

import xlsxwriter

workbook = xlsxwriter.Workbook('one.xlsx')
format_title = workbook.add_format({'bold': True, 'font_color': 'black', 'align': 'center'})
format_row = workbook.add_format({'bold': False, 'font_color': 'black', 'align': 'center'})
sheet = workbook.add_worksheet("表格说明")

showrow = 0


def show_add_row(sheet, list, format):
    # nonlocal showrow
    # 此段代码放在其他方法中用nonlocal
    global showrow
    col = 0
    for tl in list:
        sheet.write(showrow, col, tl, format)
        sheet.set_column(0, 10, 50)
        col = col + 1
    showrow = showrow + 1


title_list = ["1", '2', "3"]
word_list = ["4", '5', "6"]

show_add_row(sheet, title_list, format_title)
show_add_row(sheet, word_list, word_list)
workbook.close()
```



## xlrd模块

特点，只有1.2.0版本才能读取xlsx文件，pip安装的时候要指定1.2.0

如果读取表格中的公式计算结果，需要手动打开表格，关闭点保存一下，再用下面方法再读取一边

```python
import xlrd
def xlsx_read(xlsx_file,sheet_name):
    wb = xlrd.open_workbook(xlsx_file)
    sheet = wb.sheet_by_name(sheet_name)
    # 遍历excel，打印所有数据
    for i in range(sheet.nrows):
        print(sheet.row_values(i))

xlsx_read('2022.xlsx','2表')
```



## openpyxl

特点，能读写 xlsx， 个人觉得不好用

如果读取表格中的公式计算结果，需要手动打开表格，关闭点保存一下，再用下面方法再读取一边

data_only=True，是直接获取公式计算结果，如果是False，可以获取计算公式

```
import openpyxl
def read_xlsx(path, sheet_name):
    workbook = openpyxl.load_workbook(path,data_only=True)
    sheet = workbook[sheet_name]
    for row in sheet.rows:
        tmp=[]
        for cell in row:
            # print(cell.value, "\t", end="")
            if cell.value==None:
                pass
            else:
                tmp.append(cell.value)
        #print('\n')
        print(tmp)
read_xlsx("2022.xlsx", '2表')
```




















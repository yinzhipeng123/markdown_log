# Python 生成xlsx表格

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
# xlsx转csv



```
import xlrd
import csv


# 打开excel
# xlsx_name xlsx文件名
# sheet_name xlsx中的表格名
# csv_name csv文件名
def xlsx_to_csv(xlsx_name, sheet_name, csv_name):
    wb = xlrd.open_workbook(xlsx_name)
    sheet = wb.sheet_by_name(sheet_name)
    with open(csv_name, 'w+', encoding='utf-8', newline='') as csvfile:
        writer = csv.writer(csvfile)
        # 遍历excel，打印所有数据
        for i in range(sheet.nrows):
            print(sheet.row_values(i))
            writer.writerow(sheet.row_values(i))

xlsx_to_csv('2022.xlsx', '2表', '2022-02.csv')
```
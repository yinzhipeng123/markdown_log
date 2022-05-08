# CSV文件中，行变列，列变行转换



```python
import csv


# 把CSV中行变成列，列变成行，输入csv文件，每行的列数必须一致
def row_to_col(input_csv_name, output_csv_name):
    with open(input_csv_name, 'r', encoding='utf_8_sig') as f:
        f_csv = csv.reader(f)
        # csv_list 用来存储输入csv中的数据
        csv_list = []
        for row in f_csv:
            csv_list.append(row)
        # 根据第一行，有多少列，就生成多少个list,list的名字为row1,row2,row3...
        # counter_1，counter_2，counter_3，计数器
        first_line = csv_list[0]
        counter_1 = 0
        for i in first_line:
            counter_1 = counter_1 + 1
            locals()['row' + str(counter_1)] = []

        # 往row1,row2,row3...等 list中填数
        # 遍历行
        for row_list in csv_list:

            counter_2 = 0
            # 遍历列，第一列存入row1,第二列存入row2，第三列存入row3...,以此类推
            for i in row_list:
                counter_2 = counter_2 + 1
                locals()['row' + str(counter_2)].append(i)

        # 写入数据
        with open(output_csv_name, 'w+', encoding='utf-8', newline='') as csvfile:
            writer = csv.writer(csvfile)
            counter_3 = 0
            for i in first_line:
                counter_3 = counter_3 + 1
                # 一个list为一行
                writer.writerow(locals()['row' + str(counter_3)])


if __name__ == '__main__':
    row_to_col("input.csv", 'output.csv')
```


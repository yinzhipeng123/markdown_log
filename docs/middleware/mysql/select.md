## 一、指定查询条件

- select      用来过滤字段的

- from        指定从哪些表中查询数据

- where      用来过滤行的

查询ula及格的人的姓名和ula成绩

```sql
mysql> select sname,ula from score where ula>=60;
+-------+------+
| sname | ula  |
+-------+------+
| tom   |   80 |
| mary  |   75 |
| mike  |  100 |
+-------+------+
3 rows in set (0.00 sec)
```

查询ula和ule都及格的人的姓名和两科成绩

```sql
mysql> select sname,ula,ule from score where ula>=60 and ule>=60;
+-------+------+------+
| sname | ula  | ule  |
+-------+------+------+
| tom   |   80 |   70 |
| mike  |  100 |   90 |
+-------+------+------+
2 rows in set (0.00 sec)
```

查询有任何一科不及格的人的全部信息

```sql
mysql> select * from score where ula<60 or ule<60 or uoa<60;
+------+-------+------+------+------+
| sno  | sname | ule  | ula  | uoa  |
+------+-------+------+------+------+
|    2 | mary  |   55 |   75 |   65 |
|    3 | jack  |   75 |   45 |   95 |
+------+-------+------+------+------+
```

## 二、模糊查询

like

使用通配符

- _    ： 匹配单个字符
- %   ： 匹配0个或者多个字符

查询名字是三个字符的人的全部信息

```sql
mysql> select sname from score where sname like '___';     //三个下划线
+-------+
| sname |
+-------+
| tom   |
+-------+
1 row in set (0.00 sec)
mysql> select * from score where sname like 'j%';    //名字以j开头的
+------+-------+------+------+------+
| sno  | sname | ule  | ula  | uoa  |
+------+-------+------+------+------+
|    3 | jack  |   75 |   45 |   95 |
+------+-------+------+------+------+
1 row in set (0.00 sec)
mysql> select * from score where sname like '%k';    //名字以k结尾的
mysql> select * from score where sname like '%m%';   //名字中含有m的
+------+-------+------+------+------+
| sno  | sname | ule  | ula  | uoa  |
+------+-------+------+------+------+
|    1 | tom   |   70 |   80 |   90 |
|    2 | mary  |   55 |   75 |   65 |
|    4 | mike  |   90 |  100 |   86 |
+------+-------+------+------+------+
3 rows in set (0.00 sec)
mysql> show variables;     //查看变量值
mysql> show variables like 'da%';    //查看变量名以da开头的变量的值
+-----------------+-------------------+
| Variable_name   | Value             |
+-----------------+-------------------+
| datadir         | /data/mysql/      |
| date_format     | %Y-%m-%d          |
| datetime_format | %Y-%m-%d %H:%i:%s |
+-----------------+-------------------+
3 rows in set (0.00 sec)
```

## 三、分组      

group by 字段名

```sql
mysql> select * from score;
+------+-------+------+------+------+-------+
| sno  | sname | ule  | ula  | uoa  | class |
+------+-------+------+------+------+-------+
|    1 | tom   |   70 |   80 |   90 |     1 |
|    2 | mary  |   55 |   75 |   65 |     2 |
|    3 | jack  |   75 |   45 |   95 |     1 |
|    4 | mike  |   90 |  100 |   86 |     2 |
|    5 | rose  |   75 |   85 |   95 |     2 |
+------+-------+------+------+------+-------+
```

​    显示每个班的ule的总成绩和平均成绩

```sql
mysql> select class,sum(ule),avg(ule) from score group by class;
+-------+----------+----------+
| class | sum(ule) | avg(ule) |
+-------+----------+----------+
|     1 |      145 |  72.5000 |
|     2 |      220 |  73.3333 |
+-------+----------+----------+
2 rows in set (0.02 sec)
```

注意：group by 里面带条件的话，不能使用where；可以与having连用

显示班级人数大于2的班级的ule的总成绩和平均成绩

```sql
mysql> select class,sum(ule),avg(ule) from score group by class having count(*)>2;
+-------+----------+----------+
| class | sum(ule) | avg(ule) |
+-------+----------+----------+
|     2 |      220 |  73.3333 |
+-------+----------+----------+
1 row in set (0.00 sec)
```

## 四、排序      

order by 

order by 字段名[,字段名2,......] [asc|desc]

asc：  升序，默认的排序方式       ascend：上升的

desc：降序                                  descend：下降的



按照ule的成绩由低到高的顺序显示学生姓名及ule成绩

```sql
mysql> select sname,ule from score order by ule;
```

按照ule的成绩由高到低的顺序显示学生姓名及ule成绩

```sql
mysql>  
+-------+------+
| sname | ule  |
+-------+------+
| mike  |   90 |
| jack  |   75 |
| rose  |   75 |
| tom   |   70 |
| mary  |   55 |
+-------+------+
5 rows in set (0.00 sec)
order by 编号
mysql> select sname,ule from score order by 2 desc;
```

order by 多个字段

按照ule成绩排序，如果成绩相同，按照名字的倒序排序

```sql
mysql> select sname,ule from score order by ule,sname desc;
```

按照ule成绩倒序排序，如果成绩相同，按照名字的倒序排序

```sql
mysql> select sname,ule from score order by ule desc,sname desc;
```

## 五、限制输出     

limit

limit n        只显示查询结果的前n条

显示ule成绩前3名的学生姓名及ule成绩

```sql
mysql> select sname,ule from score order by ule desc limit 3;
+-------+------+
| sname | ule  |
+-------+------+
| mike  |   90 |
| jack  |   75 |
| rose  |   75 |
+-------+------+ß
3 rows in set (0.00 sec)
```

​    limit m,n          从m+1行开始，显示n行

```sql
 mysql> select sname,ule from score limit 2,2;   //显示第3行和第4行
```

## 六、子查询

也叫嵌套查询，将里层查询的结果作为外层查询的条件

查询ula成绩最高的人的学号，姓名以及ula的成绩

```sql
mysql> select sno,sname,ula from score where ula=(select max(ula) from score);
+------+-------+------+
| sno  | sname | ula  |
+------+-------+------+
|    4 | mike  |  100 |
+------+-------+------+
1 row in set (0.00 sec)
```

 
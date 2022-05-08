# MySQL 数据类型

MySQL 中定义数据字段的类型对你数据库的优化是非常重要的。

MySQL 支持多种类型，大致可以分为三类：数值、日期/时间和字符串(字符)类型。

 

## 数值类型

MySQL 支持所有标准 SQL 数值数据类型。

这些类型包括严格数值数据类型(INTEGER、SMALLINT、DECIMAL 和 NUMERIC)，以及近似数值数据类型(FLOAT、REAL 和 DOUBLE PRECISION)。

关键字INT是INTEGER的同义词，关键字DEC是DECIMAL的同义词。

BIT数据类型保存位字段值，并且支持 MyISAM、MEMORY、InnoDB 和 BDB表。

作为 SQL 标准的扩展，MySQL 也支持整数类型 TINYINT、MEDIUMINT 和 BIGINT。下面的表显示了需要的每个整数类型的存储和范围。

|     类型     |                   大小                   |                        范围（有符号）                        | 范围（无符号）                                               |      用途       |
| :----------: | :--------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------- | :-------------: |
|   TINYINT    |                 1 Bytes                  |                         (-128，127)                          | (0，255)                                                     |    小整数值     |
|   SMALLINT   |                 2 Bytes                  |                      (-32 768，32 767)                       | (0，65 535)                                                  |    大整数值     |
|  MEDIUMINT   |                 3 Bytes                  |                   (-8 388 608，8 388 607)                    | (0，16 777 215)                                              |    大整数值     |
| INT或INTEGER |                 4 Bytes                  |               (-2 147 483 648，2 147 483 647)                | (0，4 294 967 295)                                           |    大整数值     |
|    BIGINT    |                 8 Bytes                  |   (-9,223,372,036,854,775,808，9 223 372 036 854 775 807)    | (0，18 446 744 073 709 551 615)                              |   极大整数值    |
|    FLOAT     |                 4 Bytes                  | (-3.402 823 466 E+38，-1.175 494 351 E-38)，0，(1.175 494 351 E-38，3.402 823 466 351 E+38) | 0，(1.175 494 351 E-38，3.402 823 466 E+38)                  | 单精度 浮点数值 |
|    DOUBLE    |                 8 Bytes                  | (-1.797 693 134 862 315 7 E+308，-2.225 073 858 507 201 4 E-308)，0，(2.225 073 858 507 201 4 E-308，1.797 693 134 862 315 7 E+308) | 0，(2.225 073 858 507 201 4 E-308，1.797 693 134 862 315 7 E+308) | 双精度 浮点数值 |
|   DECIMAL    | 对DECIMAL(M,D) ，如果M>D，为M+2否则为D+2 |                        依赖于M和D的值                        | 依赖于M和D的值                                               |     小数值      |

## 

```mysql
整型也可以指定显示宽度的，但是并不影响取值范围的。
[root@mysql mysql]# mysql -u root -predhat
mysql> use up;
mysql> create table table1 (
-> tiny tinyint,
-> small smallint,
-> medium mediumint,
-> nint int,
-> big bigint,
-> fl float(6,3),
-> df double(6,3)
-> );    
mysql> desc table1;
+--------+--------------+------+-----+---------+-------+
| Field  | Type         | Null | Key | Default | Extra |
+--------+--------------+------+-----+---------+-------+
| tiny   | tinyint(4)   | YES  |     | NULL    |       |
| small  | smallint(6)  | YES  |     | NULL    |       |
| medium | mediumint(9) | YES  |     | NULL    |       |
| nint   | int(11)      | YES  |     | NULL    |       |
| big    | bigint(20)   | YES  |     | NULL    |       |
| fl     | float(6,3)   | YES  |     | NULL    |       |
| df     | double(6,3)  | YES  |     | NULL    |       |
+--------+--------------+------+-----+---------+-------+
7 rows in set (0.01 sec)
mysql> insert into table1 values(123456789,123456789,123456789,123456789,123456789,1234.56789,1234.56789);
Query OK, 1 row affected, 5 warnings (0.02 sec)
mysql> show warnings
-> ;
+---------+------+-------------------------------------------------+
| Level   | Code | Message                                         |
+---------+------+-------------------------------------------------+
| Warning | 1264 | Out of range value for column 'tiny' at row 1   |
| Warning | 1264 | Out of range value for column 'small' at row 1  |
| Warning | 1264 | Out of range value for column 'medium' at row 1 |
| Warning | 1264 | Out of range value for column 'fl' at row 1     |
| Warning | 1264 | Out of range value for column 'df' at row 1     |
+---------+------+-------------------------------------------------+
5 rows in set (0.00 sec)
mysql> select * from table1;
+------+-------+---------+-----------+-----------+---------+---------+
| tiny | small | medium  | nint      | big       | fl      | df      |
+------+-------+---------+-----------+-----------+---------+---------+
|  127 | 32767 | 8388607 | 123456789 | 123456789 | 999.999 | 999.999 |
+------+-------+---------+-----------+-----------+---------+---------+
1 row in set (0.00 sec)

超出数据类型能够表示的范围，默认插入该类型的最大值。
```
无符号数举例    unsigned

```mysql
mysql> create table table2 (tiny tinyint unsigned);
mysql> desc table2;
+-------+---------------------+------+-----+---------+-------+
| Field | Type                | Null | Key | Default | Extra |
+-------+---------------------+------+-----+---------+-------+
| tiny  | tinyint(3) unsigned | YES  |     | NULL    |       |
+-------+---------------------+------+-----+---------+-------+
1 row in set (0.00 sec)
mysql> insert into table2 values(128),(256);
mysql> show warnings;
+---------+------+-----------------------------------------------+
| Level   | Code | Message                                       |
+---------+------+-----------------------------------------------+
| Warning | 1264 | Out of range value for column 'tiny' at row 2 |
+---------+------+-----------------------------------------------+
1 row in set (0.00 sec)
mysql> select * from table2;
+------+
| tiny |
+------+
|  128 |
|  255 |
+------+
2 rows in set (0.00 sec)

zerofill：零填充 ，显示宽度不足时，补0
mysql> create table zf (id tinyint zerofill);
mysql> desc zf;
+-------+------------------------------+------+-----+---------+-------+
| Field | Type                         | Null | Key | Default | Extra |
+-------+------------------------------+------+-----+---------+-------+
| id    | tinyint(3) unsigned zerofill | YES  |     | NULL    |       |
+-------+------------------------------+------+-----+---------+-------+
1 row in set (0.00 sec)
mysql> insert into zf values(1),(11),(111);
mysql> select * from zf;
+------+
| id   |
+------+
|  001 |
|  011 |
|  111 |
+------+
3 rows in set (0.00 sec)
```

## 日期和时间类型

表示时间值的日期和时间类型为DATETIME、DATE、TIMESTAMP、TIME和YEAR。

每个时间类型有一个有效值范围和一个"零"值，当指定不合法的MySQL不能表示的值时使用"零"值。

TIMESTAMP类型有专有的自动更新特性，将在后面描述。

|   类型    | 大小 ( bytes) |                             范围                             |        格式         |           用途           |
| :-------: | :-----------: | :----------------------------------------------------------: | :-----------------: | :----------------------: |
|   DATE    |       3       |                    1000-01-01/9999-12-31                     |     YYYY-MM-DD      |          日期值          |
|   TIME    |       3       |                   '-838:59:59'/'838:59:59'                   |      HH:MM:SS       |     时间值或持续时间     |
|   YEAR    |       1       |                          1901/2155                           |        YYYY         |          年份值          |
| DATETIME  |       8       |           1000-01-01 00:00:00/9999-12-31 23:59:59            | YYYY-MM-DD HH:MM:SS |     混合日期和时间值     |
| TIMESTAMP |       4       | 1970-01-01 00:00:00/2038结束时间是第 **2147483647** 秒，北京时间 **2038-1-19 11:14:07**，格林尼治时间 2038年1月19日 凌晨 03:14:07 |   YYYYMMDD HHMMSS   | 混合日期和时间值，时间戳 |

```mysql
mysql> create table ttime (ttime time,tdate date,tdt datetime,tts timestamp,ty year);
mysql> insert into ttime values(curtime(),curdate(),now(),now(),year(now()));
mysql> select * from ttime;
+----------+------------+---------------------+---------------------+------+
| ttime    | tdate      | tdt                 | tts                 | ty   |
+----------+------------+---------------------+---------------------+------+
| 11:20:48 | 2015-09-11 | 2015-09-11 11:20:48 | 2015-09-11 11:20:48 | 2015 |
+----------+------------+---------------------+---------------------+------+
1 row in set (0.00 sec) 
mysql> insert into ttime values('11:22:33','2015-09-11','2015-09-11 11:22:36','2015-09-11 11:22:56','2048');
mysql> insert into ttime values('11:22:33','2015-09-11','2015-09-11 11:22:36','2015-09-11 11:22:56','66');
mysql> select * from ttime;
+----------+------------+---------------------+---------------------+------+
| ttime    | tdate      | tdt                 | tts                 | ty   |
+----------+------------+---------------------+---------------------+------+
| 11:20:48 | 2015-09-11 | 2015-09-11 11:20:48 | 2015-09-11 11:20:48 | 2015 |
| 11:22:33 | 2015-09-11 | 2015-09-11 11:22:36 | 2015-09-11 11:22:56 | 2048 |
| 11:22:33 | 2015-09-11 | 2015-09-11 11:22:36 | 2015-09-11 11:22:56 | 2066 |
+----------+------------+---------------------+---------------------+------+
3 rows in set (0.00 sec)
```

##  字符串类型

字符串类型指CHAR、VARCHAR、BINARY、VARBINARY、BLOB、TEXT、ENUM和SET。该节描述了这些类型如何工作以及如何在查询中使用这些类型。

| 类型       | 大小                  | 用途                            |
| :--------- | :-------------------- | :------------------------------ |
| CHAR       | 0-255 bytes           | 定长字符串                      |
| VARCHAR    | 0-65535 bytes         | 变长字符串                      |
| TINYBLOB   | 0-255 bytes           | 不超过 255 个字符的二进制字符串 |
| TINYTEXT   | 0-255 bytes           | 短文本字符串                    |
| BLOB       | 0-65 535 bytes        | 二进制形式的长文本数据          |
| TEXT       | 0-65 535 bytes        | 长文本数据                      |
| MEDIUMBLOB | 0-16 777 215 bytes    | 二进制形式的中等长度文本数据    |
| MEDIUMTEXT | 0-16 777 215 bytes    | 中等长度文本数据                |
| LONGBLOB   | 0-4 294 967 295 bytes | 二进制形式的极大文本数据        |
| LONGTEXT   | 0-4 294 967 295 bytes | 极大文本数据                    |

**注意**：char(n) 和 varchar(n) 中括号中 n 代表字符的个数，并不代表字节个数，比如 CHAR(30) 就可以存储 30 个字符。

CHAR 和 VARCHAR 类型类似，但它们保存和检索的方式不同。它们的最大长度和是否尾部空格被保留等方面也不同。在存储或检索过程中不进行大小写转换。

BINARY 和 VARBINARY 类似于 CHAR 和 VARCHAR，不同的是它们包含二进制字符串而不要非二进制字符串。也就是说，它们包含字节字符串而不是字符字符串。这说明它们没有字符集，并且排序和比较基于列值字节的数值值。

BLOB 是一个二进制大对象，可以容纳可变数量的数据。有 4 种 BLOB 类型：TINYBLOB、BLOB、MEDIUMBLOB 和 LONGBLOB。它们区别在于可容纳存储范围不同。

有 4 种 TEXT 类型：TINYTEXT、TEXT、MEDIUMTEXT 和 LONGTEXT。对应的这 4 种 BLOB 类型，可存储的最大长度不同，可根据实际情况选择。            

```mysql
注意：对于char型，存储时，如果长度不够，在字符串后面补空格；但是查询时，会自动将字符串右侧的空格脱掉。
mysql> create table str (name char(10),name2 varchar(10));
mysql> insert into str values('abcdefg','abcdefg');
mysql> select * from str;
+---------+---------+
| name    | name2   |
+---------+---------+
| abcdefg | abcdefg |
+---------+---------+
1 row in set (0.00 sec)
mysql> insert into str values('abcd ','abcd ');
mysql> select concat('(',name,')'),concat('(',name2,')') from str;
+----------------------+-----------------------+
| concat('(',name,')') | concat('(',name2,')') |
+----------------------+-----------------------+
| (abcdefg)            | (abcdefg)             |
| (abcd)               | (abcd )               |
+----------------------+-----------------------+
2 rows in set (0.00 sec)
```

enum：枚举类型        插入多个给定的值中的一个值

set：集合类型           插入多个给定的值中的一个或者多个值

```mysql
mysql> create table es (sex enum('male','female'),os set('Linux','AIX','HP-UX','Centos'));
mysql> insert into es values('male','Linux,HP-UX');
对于枚举类型，可以使用值的编号向表中插入数据
mysql> insert into es(sex) values(2);
Query OK, 1 row affected (0.02 sec)
mysql> select * from es;
+--------+-------------+
| sex    | os          |
+--------+-------------+
| male   | Linux,HP-UX |
| female | NULL        |
+--------+-------------+
2 rows in set (0.00 sec)
```

mysql 5.5里，允许向表中插入未定义的值；但是在mysql 5.6版本中是不允许这样操作的。
    
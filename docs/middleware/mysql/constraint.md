# 约束

​		约束也叫完整性约束（integrity constraint ）

什么叫完整性？

​		完整性约束就是确保数据库中的数据是有意义的、正确的

什么是约束？

​		为了保证数据的正确性，对关系模型提出的某些约束条件或者是规则。

​		约束一般作用于字段上

约束有哪些？

​		**非空、唯一、默认值、主键、外键、自增**

语法：

字段名 字段类型 [not null | unique | default 默认值 | auto_increment]

### 1、默认值

```sql
mysql> use up;
Database changed
mysql> create table tdef (name char(10),city char(10) default 'shenyang');
mysql> desc tdef;
+-------+----------+------+-----+----------+-------+
| Field | Type     | Null | Key | Default  | Extra |
+-------+----------+------+-----+----------+-------+
| name  | char(10) | YES  |     | NULL     |       |
| city  | char(10) | YES  |     | shenyang |       |
+-------+----------+------+-----+----------+-------+
mysql> insert into tdef values();
mysql> select * from tdef;
+------+----------+
| name | city     |
+------+----------+
| NULL | shenyang |
+------+----------+
1 row in set (0.00 sec)
```

默认值：当用户向表中插入数据时，若指定该字段的值，那么就插入指定值；如果没有指定该字段的值，那么就插入默认值。

```sql
mysql> insert into tdef values('huangtao','qiqihaer');
mysql> select * from tdef;
+----------+----------+
| name     | city     |
+----------+----------+
| NULL     | shenyang |
| huangtao | qiqihaer |
+----------+----------+
```

对于已经存在的表，如何设置字段的默认值

```sql
mysql> alter table tdef modify name char(10) default 'mary';
```

###  2、非空   not null

```sql
mysql> create table tnn (id int not null,name char(10));
mysql> insert into tnn values();     //会将不允许为空的id字段值转换成0
mysql> show warnings;
+---------+------+-----------------------------------------+
| Level   | Code | Message                                 |
+---------+------+-----------------------------------------+
| Warning | 1364 | Field 'id' doesn't have a default value |
+---------+------+-----------------------------------------+
mysql> select * from tnn;
+----+------+
| id | name |
+----+------+
|  0 | NULL |
+----+------+
1 row in set (0.00 sec)
mysql> desc tnn;
+-------+----------+------+-----+---------+-------+
| Field | Type     | Null | Key | Default | Extra |
+-------+----------+------+-----+---------+-------+
| id    | int(11)  | NO   |     | NULL    |       |
| name  | char(10) | YES  |     | NULL    |       |
+-------+----------+------+-----+---------+-------+
mysql> alter table tnn modify name char(10) not null;
mysql> select * from tnn;
+----+------+
| id | name |
+----+------+
|  0 |      |
+----+------+
1 row in set (0.00 sec)
mysql> select * from tnn where name is null;
Empty set (0.00 sec)

mysql> select * from tnn where name='';    //匹配空字符串
+----+------+
| id | name |
+----+------+
|  0 |      |
+----+------+
1 row in set (0.00 sec)
#注意：非空的约束，对于数值型，未指定插入值时，默认会插入0；对于字符串型，未指定插入值时，默认会插入空字符串。
```
###  3、唯一   unique

```sql
mysql> create table tuni (id int unique,name char(10));
mysql> desc tuni;
+-------+----------+------+-----+---------+-------+
| Field | Type     | Null | Key | Default | Extra |
+-------+----------+------+-----+---------+-------+
| id    | int(11)  | YES  | UNI | NULL    |       |
| name  | char(10) | YES  |     | NULL    |       |
+-------+----------+------+-----+---------+-------+
mysql> insert into tuni values();
mysql> insert into tuni values();    //注意：唯一性约束对空值无效
mysql> insert into tuni values(1,'tom');
mysql> insert into tuni values(2,'mary');
mysql> insert into tuni values(1,'jack');
ERROR 1062 (23000): Duplicate entry '1' for key 'id'
对于唯一性约束，要么向该字段插入空值，要么就向该字段插入唯一的值。
```

### 4、主键    primary key

主键是表中的特殊字段，这个字段能够唯一标识表中的每一条记录。

主键用途：快速定位数据

主键在一张表中最多只能有一个。

主键满足的条件：非空且唯一

```sql
primary key = not null + unique
```

#### 1）使用单个字段做主键

##### a、在字段后直接指定主键约束

```sql
mysql> create table pri (id int primary key,age int,name char(10));
mysql> desc pri;
+-------+----------+------+-----+---------+-------+
| Field | Type     | Null | Key | Default | Extra |
+-------+----------+------+-----+---------+-------+
| id    | int(11)  | NO   | PRI | NULL    |       |
| age   | int(11)  | YES  |     | NULL    |       |
| name  | char(10) | YES  |     | NULL    |       |
+-------+----------+------+-----+---------+-------+
3 rows in set (0.00 sec)    
mysql> insert into pri(id) values (1);
Query OK, 1 row affected (0.01 sec)
mysql> insert into pri(id) values (1);
ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'  
mysql> insert into pri values();
Query OK, 1 row affected, 1 warning (0.01 sec)

mysql> show warnings;
+---------+------+-----------------------------------------+
| Level   | Code | Message                                 |
+---------+------+-----------------------------------------+
| Warning | 1364 | Field 'id' doesn't have a default value |
+---------+------+-----------------------------------------+
1 row in set (0.00 sec)
mysql> select * from pri;
+----+------+------+
| id | age  | name |
+----+------+------+
|  0 | NULL | NULL |
|  1 | NULL | NULL |
+----+------+------+
2 rows in set (0.00 sec)
mysql> insert into pri values();
ERROR 1062 (23000): Duplicate entry '0' for key 'PRIMARY'
```

##### b、整张表的所有字段都定义完成之后再去指定主键

```sql
mysql> create table pri1 (id int,name char(10),primary key(id));
mysql> desc pri1;
+-------+----------+------+-----+---------+-------+
| Field | Type     | Null | Key | Default | Extra |
+-------+----------+------+-----+---------+-------+
| id    | int(11)  | NO   | PRI | 0       |       |
| name  | char(10) | YES  |     | NULL    |       |
+-------+----------+------+-----+---------+-------+
2 rows in set (0.00 sec)
```

####  2）多个字段联合做主键

```sql
mysql> desc mysql.user;    //user和host两个字段联合做主键
+------------------------+-----------------------------------+------+-----+---------+-------+
| Field                  | Type                              | Null | Key | Default | Extra |
+------------------------+-----------------------------------+------+-----+---------+-------+
| Host                   | char(60)                          | NO   | PRI |         |       |
| User                   | char(16)                          | NO   | PRI |         |       |
| Password               | char(41)                          | NO   |     |         |       |
mysql> select user,host from mysql.user;
+----------+-------------+
| user     | host        |
+----------+-------------+
| douni    | %           |
| douni2   | %           |
| douwo    | %           |
| part     | %           |
| root     | 127.0.0.1   |
| allpriv  | 172.16.%.%  |
| allpriv1 | 172.16.%.%  |
| remote   | 172.16.42.8 |
| root     | ::1         |
|          | localhost   |
| ni       | localhost   |
| root     | localhost   |
|          | mysql       |
| root     | mysql       |
+----------+-------------+
14 rows in set (0.05 sec)
```

注意：联合主键只能在所有字段都定义之后，再去定义主键

```sql
mysql> create table pri2 (id int,name char(10),age int,primary key (id,name));
mysql> insert into pri2 values(1,'Tom',22);
Query OK, 1 row affected (0.00 sec)

mysql> insert into pri2 values(1,'Tom',22);
ERROR 1062 (23000): Duplicate entry '1-Tom' for key 'PRIMARY'
mysql> insert into pri2 values(1,'Mary',20);
Query OK, 1 row affected (0.20 sec)

mysql> insert into pri2 values(2,'Tom',20);
Query OK, 1 row affected (0.00 sec)
```


对一个已经存在的表，如何添加主键？如何删除主键？

添加主键：

```sql
alter table score add primary key(sno);
```

删除主键：

```sql
alter table score drop primary key;  
```

### 5、外键    foreign key

外键：一个表B中的数据依赖于另一张表A的主键列的数据，如果A表中未出现的值，是不能够出现在B表中的

A：父表

B：子表，外键在子表中

主键和外键就像是表之间的粘合剂，能够将多个表关联起来。  

创建外键的条件：

1）存储引擎是innodb（是mysql5.5默认的引擎）

2）相关联字段数据类型要一致

3）最好在外键列上建索引       

```sql
例子：
dept：部门表
emp：员工表
mysql> create table dept (dno int,dname char(10),primary key (dno));
mysql> create table emp (eno int,edno int,ename char(10),index(edno),foreign key (edno) references dept(dno));
向父表中插入数据
mysql> insert into dept values(100,'manager'),(101,'dba'),(102,'hr'),(103,'sa');
向子表中插入数据
mysql> insert into emp values(1,100,'Tom');
mysql> insert into emp values(2,101,'Mary');
mysql> insert into emp values(3,108,'Daji');  //反例：插入父表中不存在的部门号
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`up`.`emp`, CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`edno`) REFERENCES `dept` (`dno`))
删除父表中的数据
mysql> select * from dept;
+-----+---------+
| dno | dname   |
+-----+---------+
| 100 | manager |
| 101 | dba     |
| 102 | hr      |
| 103 | sa      |
+-----+---------+
mysql> select * from emp;
+------+------+-------+
| eno  | edno | ename |
+------+------+-------+
|    1 |  100 | Tom   |
|    2 |  101 | Mary  |
+------+------+-------+
2 rows in set (0.00 sec)
mysql> delete from dept where dno=102;
mysql> delete from dept where dno=101;
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`up`.`emp`, CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`edno`) REFERENCES `dept` (`dno`))
```

    以上小实验小结：
    1）子表中的数据依赖于父表，不能向子表中插入父表中不存在的值
    2）不能删除父表中被子表所依赖的行
如何解决？

on delete cascade      级联删除

on update cascade     级联更新

```sql
mysql> drop table emp;
完整的外键创建
mysql> create table emp (eno int,edno int,ename char(10),index(edno),foreign key (edno) references dept(dno) on delete cascade on update cascade);
mysql> insert into emp values(1,100,'Tom');
mysql> insert into emp values(2,101,'Songjiang');    
mysql> insert into emp values(5,101,'Likui');
mysql> delete from dept where dno=101;
mysql> select * from dept;
+-----+---------+
| dno | dname   |
+-----+---------+
| 100 | manager |
| 103 | sa      |
+-----+---------+
2 rows in set (0.00 sec)
mysql> select * from emp;
+------+------+-------+
| eno  | edno | ename |
+------+------+-------+
|    1 |  100 | Tom   |
+------+------+-------+
1 row in set (0.00 sec)

mysql> update dept set dno=110 where dno=100;
mysql> select * from emp;
+------+------+-------+
| eno  | edno | ename |
+------+------+-------+
|    1 |  110 | Tom   |
+------+------+-------+
1 row in set (0.00 sec)
有了级联删除和级联修改选项，父表中的数据发生删除或者更新时，子表中的数据也会发生相应的变化。
```

删除外键

查看外键的名字
         

```sql
mysql> show create table emp\G
*************************** 1. row ***************************
Table: emp
Create Table: CREATE TABLE `emp` (
`eno` int(11) DEFAULT NULL,
`edno` int(11) DEFAULT NULL,
`ename` char(10) DEFAULT NULL,
KEY `edno` (`edno`),   //索引
CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`edno`) REFERENCES `dept` (`dno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8
1 row in set (0.00 sec)
mysql> alter table emp drop foreign key emp_ibfk_1;
```

### 6、自增     auto_increment

要求：

1）该字段的类型必须是数值型的

2）字段上要有唯一性索引或主键
      

```sql
mysql> create table zz (id int primary key auto_increment);
mysql> desc zz;
+-------+---------+------+-----+---------+----------------+
| Field | Type    | Null | Key | Default | Extra          |
+-------+---------+------+-----+---------+----------------+
| id    | int(11) | NO   | PRI | NULL    | auto_increment |
+-------+---------+------+-----+---------+----------------+
1 row in set (0.00 sec)
mysql> insert into zz values();
Query OK, 1 row affected (0.02 sec)
mysql> select * from zz;
+----+
| id |
+----+
|  1 |
+----+
1 row in set (0.00 sec)
```

几点说明：

1）当自增字段发生断档时，值从最大值继续自增

```sql
mysql> insert into zz values();
Query OK, 1 row affected (0.01 sec)
mysql> select * from zz;
+----+
| id |
+----+
|  1 |
|  2 |
|  5 |
|  6 |
+----+
4 rows in set (0.00 sec)   
```

 2）当用delete删除最大值时，下一个值仍然从最大值的下一个继续自增

```sql
mysql> delete from zz where id=6;
Query OK, 1 row affected (0.04 sec)

mysql> insert into zz values();
Query OK, 1 row affected (0.00 sec)

mysql> select * from zz;
+----+
| id |
+----+
|  1 |
|  2 |
|  5 |
|  7 |
+----+
4 rows in set (0.00 sec)
```

3）当你truncate一个表时，值从1开始重新计算

```sql
mysql> truncate table zz;
Query OK, 0 rows affected (0.05 sec)

mysql> insert into zz values();
Query OK, 1 row affected (0.00 sec)

mysql> select * from zz;
+----+
| id |
+----+
|  1 |
+----+
1 row in set (0.00 sec)
```


​         
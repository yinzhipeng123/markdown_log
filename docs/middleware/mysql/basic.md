# SQL

(Structured Query Language)  结构化查询语言

专门用来和关系型数据库进行通信的语言

### SQL语句中的大小写问题：

1）关键字、函数名、列名和索引名不区分大小写

2）数据库名、表名、别名及视图名区分大小写的(因为linux系统是区分大小写的)

3）存储过程、事件不区分大小写，触发器区分大小写。

### SQL语句的分类

#### 1. 数据查询语言DQL

数据查询语言DQL基本结构是由SELECT子句，FROM子句，WHERE，子句组成的查询块：

```sql
SELECT <字段名表>
FROM <表或视图名>
WHERE <查询条件>
```

#### 2 .数据操纵语言DML

数据操纵语言DML主要有三种形式：

```sql
1) 插入：INSERT
2) 更新：UPDATE
3) 删除：DELETE
```

#### 3. 数据定义语言DDL

数据定义语言DDL用来创建数据库中的各种对象-----表、视图、索引、同义词、聚簇等如：

```sql
create TABLE/VIEW/INDEX/SYN/CLUSTER  创建
alter       修改
drop        删除
truncate    截断
```

DDL操作是隐性提交的！不能rollback

#### 4. 数据控制语言DCL

数据控制语言DCL用来授予或回收访问数据库的某种特权，并控制数据库操纵事务发生的时间及效果，对数据库实行监视等。如：

```sql
1) grant：	  授权。
   revoke      回收权限  

2) ROLLBACK [WORK] TO [SAVEPOINT]：回退到某一点。
回滚---ROLLBACK
回滚命令使数据库状态回到上次最后提交的状态。其格式为：
SQL>ROLLBACK;

3) COMMIT [WORK]：提交。
```

在数据库的插入、删除和修改操作时，只有当事务在提交到数据库时才算完成。在事务提交前，只有操作数据库的这个人才能有权看到所做的事情，别人只有在最后提交完成后才可以看到。提交数据有三种类型：显式提交、隐式提交及自动提交。下面分别说明这三种类型。

(1) 显式提交
用COMMIT命令直接完成的提交为显式提交。其格式为：

```sql
SQL>COMMIT；
```

(2) 隐式提交
用SQL命令间接完成的提交为隐式提交。这些命令是：

```sql
ALTER，AUDIT，COMMENT，CONNECT，CREATE，DISCONNECT，DROP，
EXIT，GRANT，NOAUDIT，QUIT，REVOKE，RENAME。
```

(3) 自动提交
若把AUTOCOMMIT设置为ON，则在插入、修改、删除语句执行后，系统将自动进行提交，这就是自动提交。其格式为：

```sql
SQL>SET AUTOCOMMIT ON；
```

### MySQL 事务

MySQL 事务主要用于处理操作量大，复杂度高的数据。比如说，在人员管理系统中，你删除一个人员，你既需要删除人员的基本资料，也要删除和该人员相关的信息，如信箱，文章等等，这样，这些数据库操作语句就构成一个事务！

- 在 MySQL 中只有使用了 Innodb 数据库引擎的数据库或表才支持事务。
- 事务处理可以用来维护数据库的完整性，保证成批的 SQL 语句要么全部执行，要么全部不执行。
- 事务用来管理 insert,update,delete 语句

一般来说，事务是必须满足4个条件（ACID）：

原子性（Atomicity，或称不可分割性）、一致性（Consistency）、隔离性（Isolation，又称独立性）、持久性（Durability）。

- 原子性：一个事务（transaction）中的所有操作，要么全部完成，要么全部不完成，不会结束在中间某个环节。事务在执行过程中发生错误，会被回滚（Rollback）到事务开始前的状态，就像这个事务从来没有执行过一样。
- 一致性：在事务开始之前和事务结束以后，数据库的完整性没有被破坏。这表示写入的资料必须完全符合所有的预设规则，这包含资料的精确度、串联性以及后续数据库可以自发性地完成预定的工作。
- 隔离性：数据库允许多个并发事务同时对其数据进行读写和修改的能力，隔离性可以防止多个事务并发执行时由于交叉执行而导致数据的不一致。事务隔离分为不同级别，包括读未提交（Read uncommitted）、读提交（read committed）、可重复读（repeatable read）和串行化（Serializable）。
- 持久性：事务处理结束后，对数据的修改就是永久的，即便系统故障也不会丢失。

在 MySQL 命令行的默认设置下，事务都是自动提交的，即执行 SQL 语句后就会马上执行 COMMIT 操作。因此要显式地开启一个事务务须使用命令 BEGIN 或 START TRANSACTION，或者执行命令 SET AUTOCOMMIT=0，用来禁止使用当前会话的自动提交。

### 基本SQL语句

#### 1、查看当前用户

```mysql
[root@mysql mysql]# mysql -u root -p123456
mysql> select user();
+----------------+
| user()         |
+----------------+
| root@localhost |
+----------------+
1 row in set (0.00 sec)
```

#### 2、对数据库的操作

##### 1）查看当前操作的数据库

```mysql
mysql> select database();
+------------+
| database() |
+------------+
| NULL       |
+------------+
1 row in set (0.00 sec)
```

##### 2）选择操作哪个数据库

```mysql
mysql> use test
Database changed
```

##### 3）查看系统中有哪些数据库

```mysql
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |    信息模式数据库，保存服务器的信息
| mysql              |    核心管理数据库，保存了用户和权限信息，记录了和系统安全相关的信息
| performance_schema |    性能模式数据库，搜索服务器的性能参数
| test               |    测试数据库
+--------------------+
4 rows in set (0.02 sec)
```

##### 4）查看当前数据库下有哪些表

```mysql
mysql> show tables;
Empty set (0.02 sec)
```

##### 5）创建数据库

```mysql
mysql> create database updb1;
Query OK, 1 row affected (0.01 sec)
注意：在同一个数据库管理系统中数据库名不能重复
```

##### 6）删除数据库

(轻易别这么做，风险大)

```mysql
mysql> drop database updb1;
Query OK, 0 rows affected (0.04 sec)
```

#### 3、对表的操作

注意：

1）表一定要存在数据库中

2）在同一个数据库中，表名不能重复

##### 1）创建表(创建的是表结构)

```mysql
语法：create table 表名 (字段1名 字段类型,字段2名 字段类型,... ...,字段n名 字段类型);
mysql> use test;
Database changed
mysql> create table t1 (id int,name char(10));
Query OK, 0 rows affected (0.05 sec)
```

##### 2）查看表结构

```mysql
mysql> desc t1;
+-------+----------+------+-----+---------+-------+
| Field | Type     | Null | Key | Default | Extra |
+-------+----------+------+-----+---------+-------+
| id    | int(11)  | YES  |     | NULL    |       |
| name  | char(10) | YES  |     | NULL    |       |
+-------+----------+------+-----+---------+-------+
2 rows in set (0.00 sec)
```

- Field：字段名字
- Type：字段类型
- Null：是否允许为空
- Key：键值(主键等)
- Default：默认值
- Extra：其他(自增等)

##### 3）查看建表时使用的语句

```mysql
mysql> show create table t1\G      
******** 1. row *********
Table: t1
Create Table: CREATE TABLE t1 (
id int(11) DEFAULT NULL,
name char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8
1 row in set (0.00 sec)
mysql> show create table mysql.user\G
mysql.user：库名.表名
```

##### 4）向表中插入数据

a、插入数据时，不指定字段，在写值的时候顺序要与表中的字段的顺序一一对应，值的数量要和字段数一样多

```mysql
语法：insert into 表名 values （值1,值2,......,值n）;
mysql> insert into t1 values(1,'Tom');
Query OK, 1 row affected (0.00 sec)  
```

b、插入时指定字段

```mysql
语法：insert into 表名(字段名1,字段名2,... ...,字段名n) values （值1,值2,......,值n）;
mysql> insert into t1(id) values(250);
mysql> insert into t1(name,id) values('Mary',3);    
mysql> select * from t1;       //查询t1表中的数据
+------+------+
| id   | name |
+------+------+
|    1 | Tom  |
|  250 | NULL |
|    3 | Mary |
+------+------+
3 rows in set (0.00 sec)
```

c、向表中插入多条数据

```mysql
mysql> insert into t1 values(4,'jack'),(5,'Kite'),(7,'LiLei');  //同时向t1表中插入三条记录
```

##### 5）查询表中数据

```mysql
mysql> select * from t1;      //全表查询
mysql> select name from t1;    //指定字段查询    select 后面接字段名字
mysql> select name,id from t1;     //查询多个字段
```

##### 6）修改表结构    alter

###### a、增加字段

（1）向表中增加字段(默认添加到最后一个字段)

```mysql
语法：alter table 表名 add 字段名 字段类型 [first|after 字段名];
mysql> alter table t1 add sex char(10);
mysql> desc t1;
+-------+----------+------+-----+---------+-------+
| Field | Type     | Null | Key | Default | Extra |
+-------+----------+------+-----+---------+-------+
| id    | int(11)  | YES  |     | NULL    |       |
| name  | char(10) | YES  |     | NULL    |       |
| sex   | char(10) | YES  |     | NULL    |       |
+-------+----------+------+-----+---------+-------+
3 rows in set (0.01 sec)
```

（2）将字段添加为表中的第一个字段

```mysql
mysql> alter table t1 add qq int first;
```

（3） 在某个字段的后面新增字段

```mysql
mysql> alter table t1 add tel int(15) after qq;  
```

###### b、修改字段属性 

- change：既能修改字段的类型和长度，又能修改字段的名字
- modify：只能修改字段的类型和长度

modify的语法：

```mysql
alter table 表名 modify 字段名 字段类型;
mysql> alter table t1 modify name char(15);
```

change的语法：

```mysql
alter table 表名 change 原字段名 新字段名  字段类型
注意：如果只修改字段类型，那么原字段名和新字段名一样
如果只修改字段名字，那么字段类型与原来的字段类型保持一致
mysql> alter table t1 change qq weixin int; 
```

###### c、删除字段

```mysql
语法：alter table 表名 drop 字段名;
mysql> alter table t1 drop sex;
```

##### 7）修改表名     

```mysql
语法：alter table 表名 rename 新表名;
mysql> alter table t1 rename t22;
mysql> select * from t1;
ERROR 1146 (42S02): Table 'test.t1' doesn't exist 
```

##### 8）更新表中的数据(update)

```mysql
语法：update 表名 set 字段名=值[,字段名2=值2] where 条件;
mysql> update t22 set name='HanMeimei' where id=250;
mysql> update t22 set weixin=1234567;     //会将该表中这段字段的值全部修改为1234567
mysql> update t22 set id=2,name='HanMei' where id=250;   //同时修改多个字段
```

##### 9）删除表中记录  delete

（1）删除表中指定行

```mysql
mysql> delete from t22 where id>=3;
Query OK, 4 rows affected (0.01 sec)
```

（2）删除表中全部数据

```mysql
mysql> delete from t22;       
mysql> select * from t22;
Empty set (0.00 sec)
```

##### 10）截断表   

truncate   也是删除表中的全部记录        

```mysql
mysql> create table test (id int);     
mysql> insert into test values();    //向表中插入空值
mysql> insert into test values();
mysql> insert into test values();
mysql> select * from test;
mysql> truncate table test; 
mysql> select * from test;
```

delete和truncate区别

- delete：DML，可以回滚
- truncate：DDL，不能够回滚的，删除数据的同时会释放空间。

大表数据清除时候，一定要用truncate，速度快。

##### 11）删除表

```mysql
drop table 表名;
mysql> drop table test;
mysql> drop table t22;          
```


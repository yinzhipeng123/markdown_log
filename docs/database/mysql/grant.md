# 用户与授权

MySQL中的用户存在哪张表中   mysql.user

```sql
mysql> select user,host,password from mysql.user;
+------+-----------+-------------------------------------------+
| user | host      | password                                  |
+------+-----------+-------------------------------------------+
| root | localhost | *6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9 |
| root | mysql     |                                           |
| root | 127.0.0.1 |                                           |
| root | ::1       |                                           |
|      | localhost |                                           |
|      | mysql     |                                           |
+------+-----------+-------------------------------------------+
6 rows in set (0.00 sec)
```

### 如果root密码忘记了，该怎么办？

破解root密码前提，就是你能够停止mysql服务。

1）停止服务

```sql
[root@mysql ~]# /etc/init.d/mysqld stop
```

2）使用跳过授权表的方式启动数据库

```sql
[root@mysql ~]# mysqld_safe --skip-grant-tables --user=mysql &
```

3）匿名登录

```sql
[root@mysql ~]# mysql
```

4）修改user表

```sql
mysql> use mysql;
Database changed
mysql> select user,host,password from user;
mysql> update user set password=password("redhat") where user='root' and host='localhost';
#使用password()函数去生成新密码的加密字符串
```

5）重启mysql服务

```bash
[root@mysql mysql]# mysqladmin shutdown     //正常情况下使用mysqld_safe启动的服务需要这么关闭
[root@mysql mysql]# ps -ef | grep mysqld
root     25049 16794  0 11:39 pts/0    00:00:00 grep mysqld
--------------------
```

如果正常关闭不好使，那么就强制杀死进程
```bash
[root@mysql mysql]# kill -9 `pgrep mysqld`
--------------------
[root@mysql mysql]# /etc/init.d/mysqld start
```

6）重新使用新的密码登录数据库即可

```sql
[root@mysql mysql]# mysql -uroot -predhat
-------------------------------------------------------------------------------
插曲
[root@mysql subsys]# pwd
/var/lock/subsys    //各种服务的锁文件所在的位置
xxxx  is not running，but lock file exists.
------------------------------------------------------------------------------
```



 创建用户

语法：create user 用户名@主机 identified by  '密码';

### 1、创建本地用户

```sql
mysql> create user local@localhost identified by 'local';
mysql> select user,host,password from mysql.user where user='local';
+-------+-----------+-------------------------------------------+
| user  | host      | password                                  |
+-------+-----------+-------------------------------------------+
| local | localhost | *EF82E77FF4184209858BDA2C853D3D7A5870DE80 |
+-------+-----------+-------------------------------------------+
1 row in set (0.00 sec)
```

登录测试：

```sql
[root@mysql ~]# mysql -ulocal -plocal
mysql> show databases;     //普通用户，默认只能看到以下两个数据库
+--------------------+
| Database           |
+--------------------+
| information_schema |
| test               |
+--------------------+
2 rows in set (0.00 sec)
```

### 2、删除用户

```sql
mysql> drop user local@localhost;    //用普通用户删除不了用户
ERROR 1227 (42000): Access denied; you need (at least one of) the CREATE USER privilege(s) for this operation
mysql> exit
Bye
[root@mysql ~]# mysql -uroot -predhat
mysql> drop user local@localhost;
Query OK, 0 rows affected (0.03 sec)
```

### 3、创建可以远程登录的用户

服务器端：172.16.254.200

客户端：172.16.42.8     保证要有mysql命令

#### 1）服务器端操作

##### （1）创建远程用户

```sql
mysql> create user remote@'172.16.42.8' identified by 'simida';  //此处为客户端IP

mysql> create user remote@'%'  identified by 'simida';     
# %表示除了localhost和127.0.0.1之外的所有客户端
mysql> create user remote@'172.16.%.%' identified by 'simida';
# 172.16.%.%表示172.16.0.0/16网段的所有客户端

```

##### （2）重启服务                

```
[root@mysql mysql]# /etc/init.d/mysqld restart
```

插曲：如果远程连接报如下错误，那么修改服务器端配置文件，添加一行即可：       

```sql
[root@MySQL ~]# mysql -u remote -h 172.16.254.200 -p
Enter password: 
ERROR 1042 (HY000): Can't get hostname for your address
----------------
[root@mysql mysql]#  /etc/my.cnf 
在[mysqld]那段里面添加如下行：5.6版本不需要
skip-name-resolve       //跳过名字解析，否则无法远程连接该mysql管理系统
```

#### 2）客户端登录验证

```sql
#客户端IP：172.16.42.8
[root@MySQL ~]# mysql -u remote -h 172.16.254.200 -p    //此处为服务器端IP
Enter password:simida
```


### 4、授权  grant

grant不仅可以授权，还能创建用户

授权的语法：grant 权限列表 on 库名.表名 to  用户@主机 identified by '密码';

#### 1）授予全部权限

```sql
mysql> grant all on *.* to allpriv@'172.16.%.%' identified by 'allpriv';
mysql> flush privileges;       //刷新权限
Query OK, 0 rows affected (0.00 sec)
测试：
[root@mysql mysql]# mysql -uallpriv -h 172.16.254.200 -p
Enter password: 
```

 插曲：权限的级联授予

```sql
mysql> grant select on test.score to douni@'%' identified by 'douni';
ERROR 1142 (42000): GRANT command denied to user 'allpriv'@'172.16.254.200' for table 'score'
```

用root用户创建用户时，希望新的用户能够给别人授权的话，执行如下操作：

```sql
mysql> grant all on *.* to allpriv1@'172.16.%.%' identified by 'allpriv1' with grant option;
[root@mysql mysql]# mysql -uallpriv1 -h 172.16.254.200 -p
Enter password: 
mysql> grant select on test.score to douni2@'%' identified by 'douni';   //能够执行成功
------------------------------------------------------
```

#### 2）授予部分权限

```sql
mysql> create database up;
Query OK, 1 row affected (0.00 sec)

mysql> use up;
Database changed
mysql> create table upt1 (id int);
Query OK, 0 rows affecte d (0.01 sec)

mysql> insert into upt1 values();
Query OK, 1 row affected (0.00 sec)

mysql> insert into upt1 values();
Query OK, 1 row affected (0.01 sec)

mysql> insert into upt1 values();
Query OK, 1 row affected (0.00 sec)
mysql> create table upt2 (id int);
Query OK, 0 rows affected (0.03 sec)

mysql> grant select,insert,update on up.upt1 to douwo@'%' identified by 'douwo';
mysql> flush privileges;
```

验证权限

```sql
[root@mysql ~]# mysql -udouwo  -h 172.16.254.200 -p
Enter password: 
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| test               |
| up                 |
+--------------------+
3 rows in set (0.00 sec)
mysql> use up;
Database changed
mysql> show tables;
+--------------+
| Tables_in_up |
+--------------+
| upt1         |      //只对该表有权限，就只能看到这张表
+--------------+
1 row in set (0.00 sec)         
mysql> select * from upt1;
+------+
| id   |
+------+
| NULL |
| NULL |
| NULL |
+------+
3 rows in set (0.00 sec)
mysql> update upt1 set id=1 where id is null;   //成功
mysql> insert into upt1 values();   //成功
Query OK, 1 row affected (0.00 sec)
mysql> delete from upt1 where id is null;     //失败
ERROR 1142 (42000): DELETE command denied to user 'douwo'@'172.16.254.200' for table 'upt1'
mysql> drop table upt1;   //失败
ERROR 1142 (42000): DROP command denied to user 'douwo'@'172.16.254.200' for table 'upt1'
```

### 5、回收权限    revoke

取消用户权限：   

1）删除用户     

 2）revoke

回收语法：revoke 权限 on 库名.表名 from 用户@主机;

```bash
[root@mysql ~]# mysql -uroot  -p
Enter password: 
mysql> revoke all on *.* from allpriv@'172.16.%.%';
```

回收部分权限

```sql
mysql> show grants for part@'%';    //查看用户的权限的
+-----------------------------------------------------------------------------------------------------+
| Grants for part@%                                                                                   |
+-----------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'part'@'%' IDENTIFIED BY PASSWORD '*57FA4A97AD182F6A0872282CACBE109822E9E801' |
| GRANT SELECT, INSERT, UPDATE ON `test`.`score` TO 'part'@'%'                         |
+-----------------------------------------------------------------------------------------------------+
2 rows in set (0.00 sec)   
mysql> revoke update on test.score from part@'%';
Query OK, 0 rows affected (0.00 sec)
mysql> show grants for part@'%';
+-----------------------------------------------------------------------------------------------------+
| Grants for part@%                                                                                   |
+-----------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'part'@'%' IDENTIFIED BY PASSWORD '*57FA4A97AD182F6A0872282CACBE109822E9E801' |
| GRANT SELECT, INSERT ON `test`.`score` TO 'part'@'%'                                                |
+-----------------------------------------------------------------------------------------------------+
2 rows in set (0.00 sec)
```



### 6、查看用户的权限

```sql
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
| root     | localhost   |
|          | mysql       |
| root     | mysql       |
+----------+-------------+
13 rows in set (0.00 sec)
mysql> show grants for part@'%';    #查看用户的权限的
+-----------------------------------------------------------------------------------------------------+
| Grants for part@%                                                                                   |
+-----------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'part'@'%' IDENTIFIED BY PASSWORD '*57FA4A97AD182F6A0872282CACBE109822E9E801' |
| GRANT SELECT, INSERT, UPDATE ON `test`.`score` TO 'part'@'%'                         |
+-----------------------------------------------------------------------------------------------------+
2 rows in set (0.00 sec)
#权限查看:
mysql> use information_schema;
Database changed
mysql> select distinct grantee from user_privileges;
mysql> select privilege_type from user_privileges where grantee="'test'@'172.16.%.%'";
+-------------------------+
| privilege_type          |
+-------------------------+
| SELECT                  |
| INSERT                  |
| UPDATE                  |
| DELETE                  |
| CREATE                  |
| DROP                    |
| RELOAD                  |
| SHUTDOWN                |
| PROCESS                 |
| FILE                    |
| REFERENCES              |
| INDEX                   |
| ALTER                   |
| SHOW DATABASES          |
| SUPER                   |
| CREATE TEMPORARY TABLES |
| LOCK TABLES             |
| EXECUTE                 |
| REPLICATION SLAVE       |
| REPLICATION CLIENT      |
| CREATE VIEW             |
| SHOW VIEW               |
| CREATE ROUTINE          |
| ALTER ROUTINE           |
| CREATE USER             |
| EVENT                   |
| TRIGGER                 |
| CREATE TABLESPACE       |
+-------------------------+
28 rows in set (0.00 sec)
```
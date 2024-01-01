# 备份与恢复

备份是将系统或者数据库中重要是数据保存起来，目的是为了保证在灾难或故障发生的时候，确保数据不丢失或者是最小程度的丢失

备份策略要求：

第三方备份软件    bacula  (开源备份软件)等

### 一、备份的分类

#### 1、根据备份方法分

##### 1）冷备份(cold backup)  

也叫离线备份(offline backup)

这种备份最简单，直接拷贝物理文件

需要关闭数据库，然后才能进行备份

##### 2）热备份(hot backup)  

也叫在线备份(online backup)

无需关闭数据库，直接在线备份

##### 3）温备（warm backup）

无需关闭数据库，但是会对当前数据库的操作有影响，因为会给数据库加全局读锁

#### 2、根据备份后的文件分

#### 逻辑备份

指备份出来的文件是可读的，也就是文本文件    如：mysqldump

#### 物理备份

指备份数据库的物理文件     如：ibbackup   

#### 3、按照备份数据库的内容来分

##### 完全备份：

不管是否发生变化，将全库都备份

##### 增量备份：

仅备份上次备份到这次备份之间发生变化的部分

##### 日志备份：

备份二进制日志



在企业中，一般的备份策略是完全备份+增量备份

备份时间的选择：数据库访问量较小的时候去备份。



### 二、mysqldump

##### 备份

##### 1、单库备份

```bash
[root@mysql ~]# mysqldump -u root -p 库名 > /tmp/up1.sql
Enter password:                      
```

######  2、单表备份

```bash
[root@mysql ~]# mysqldump -uroot -p 库名 表名 > /tmp/dept.sql
Enter password:
```

###### 3、多表备份

```bash
[root@mysql ~]# mysqldump -uroot -p 库名 表名 表名 表名 > /tmp/duu.sql
Enter password:                          
```

###### 4、多库备份    -B

```bash
[root@mysql ~]# mysqldump -uroot -p -B 库名  库名 > /tmp/utdb.sql
Enter password:
```

###### 5、全库备份    --all-databases

```bash
[root@mysql ~]# mysqldump -uroot -p --all-databases > /tmp/all.sql
Enter password: 
```

##### 恢复

###### 1、单库恢复(要先创建数据库的)

```bash
mysql> drop database beh-manager;
mysql> create database beh-manager;     //先建库
```

第一种恢复方式：在mysql提示符下运行

```bash
mysql> use beh-manager
mysql> source /tmp/beh-manager.sql
```

第二种恢复方式：在shell提示符下执行

```bash
mysql> drop database up;
mysql> create database up;   
[root@mysql ~]# mysql -uroot -p up < /tmp/up1.sql 
Enter password: 
```

###### 2、单表恢复

```bash
mysql> drop table dept;
[root@mysql ~]# mysql -uroot -p up < /tmp/dept.sql 
Enter password: 
```

###### 3、多表恢复(同单表恢复)

```bash
[root@mysql ~]# mysql -uroot -p test < /tmp/duu.sql      //将表恢复到test库中的操作
Enter password:
[root@mysql ~]# mysql -uroot -predhat -e "use test;show tables"
```

###### 4、多库恢复  (不需要手动建库)

```bash
mysql> drop database up;
mysql> drop database test;
mysql> source /tmp/utdb.sql
```

###### 5、全库恢复

```bash
[root@mysql ~]# mysql -uroot -p < /tmp/all.sql
```

​            

    备份时候加锁
    	-x：给所有的表加读锁
    	-l：给单独的表加读锁
    查看mysqldump的帮助     
    	mysqldump --help
    	man mysqldump








​    
​    
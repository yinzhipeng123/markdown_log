# sed脚本

将单引号中的定址和命令写在脚本中

```bash
[root@shell shelldoc]#  cat sc1.sed
/Lewis/a \
i am lewis \
who are you
/Suan/c has suan
1i \
************\
begin\
************
$d
[root@shell shelldoc]# sed -f sc1.sed datafile  //执行脚本
************
begin
************
northwest       NW      Charles Main            3.0     .98    34
western         WE      Sharon Gray             5.3     .97    5        23
southwest       SW      Lewis Dalsass           2.7     .8     18
i am lewis 
who are you
has suan
southeast       SE      Patricia Hemenway       4.0     .7     17
eastern         EA      TB Savage               4.4     .84    20
northeast       NE      AM Main Jr.             5.1     .94    13
western         WE      Sharon Gray             5.3     .97    5        23
north           NO      Margot Weber            4.5     .89    9
```

​	带幻数的脚本
```bash
[root@shell shelldoc]#  sc1.sed
#!/bin/sed -f
/Lewis/a \
i am lewis \
who are you
/Suan/c has suan
1i \
************ \
begin \
************
$d
[root@shell shelldoc]# chmod +x sc1.sed
[root@shell shelldoc]# ./sc1.sed datafile

假设脚本中使用了扩展正则，那么选项还得加-r
sed -rf sc2.sed filename
#!/bin/sed -rf
```
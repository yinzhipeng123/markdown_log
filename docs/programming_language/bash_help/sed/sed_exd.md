# 模式空间和保留空间

模式空间：PATT

功能：处理文本行的

最多能保存8KB

保留空间：HOLD

功能：保留处理过的文本行的，以便后续使用

默认有一个空行

最多能保存8KB

命令：

- h：将模式空间的内容覆盖到保留空间 —— 覆盖模式
- H：将模式空间的内容追加到保留空间 —— 追加模式
- g：将保留空间的内容覆盖到模式空间 —— 覆盖模式
- G：将保留空间的内容追加到模式空间 —— 追加模式
- x：将模式空间的内容和保留空间的内容交换  exchange

```bash
例子：
[root@shell shelldoc]#  num.txt
1
2
3
4
5
第一行和第二行颠倒输出
[root@shell shelldoc]# sed '1{h;d};2G' num.txt 
2
1
3
4
5
第2行到第5行的内容复制到第7行下面
[root@shell shelldoc]# sed '2h;3,5H;7G' pass 
1  root:x:0:0:root:/root:/bin/bash
2  bin:x:1:1:bin:/bin:/sbin/nologin
3  daemon:x:2:2:daemon:/sbin:/sbin/nologin
4  adm:x:3:4:adm:/var/adm:/sbin/nologin
5  lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
6  sync:x:5:0:sync:/sbin:/bin/sync
7  shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
2  bin:x:1:1:bin:/bin:/sbin/nologin
3  daemon:x:2:2:daemon:/sbin:/sbin/nologin
4  adm:x:3:4:adm:/var/adm:/sbin/nologin
5  lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
8  halt:x:7:0:halt:/sbin:/sbin/halt
9  mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
10  uucp:x:10:14:uucp:/var/spool/uucp:/sbin/nologin
第2行到第5行的内容剪切到第7行下面
[root@shell shelldoc]# sed '2{h;d};3,5{H;d};7G' pass
```

在每行的下一行输出一个空行

```bash
[root@shell shelldoc]# sed 'G' num.txt
在每行的下一行输出一个空白行
[root@zed scripts]# sed '/$/a \ ' pass
额外的：每行下面输出一个空行，最后一行下面不输出
[root@shell shelldoc]# sed '$!G' num.txt
```
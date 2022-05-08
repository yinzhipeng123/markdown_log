# bash中的通配符

\   转义符，跟在\之后的特殊符号将失去特殊含义，变为普通字符。如\$将输出“$”符号，而不当做是变量引用。

$   ——  用来提取变量值

```bash
[root@shell ~]# echo $USER
root
[root@shell ~]# echo $HOME
/root
```

?  ——  匹配任意单个字符(不能匹配隐藏文件)

? 匹配一个任意字符

```bash
[root@shell ~]# mkdir /script
[root@shell ~]# cd /script/
[root@shell script]# touch {a,b,c,d,e}.txt
[root@shell script]# touch haha.txt
[root@shell script]# ls ?.txt
a.txt  b.txt  c.txt  d.txt  e.txt
```

`*` —— 匹配0个或者多个任意字符，注意这个和正则表达式中的 `*` 不同

`*`  匹配0个或任意多个任意字符， 也就是可以匹配任何内容

```bash
[root@shell script]# ls *.txt
a.txt  b.txt  c.txt  d.txt  e.txt  haha.txt
```

`[abcde]`  —— 匹配一组字符中的任意一个
`[] `    匹配中括号中任意一个字符。 例如： [abc]代表一定匹配一个字符， 或者是a， 或者是b， 或者是c。
`[-]`  匹配中括号中任意一个字符， -代表一个范围。 例如：` [a-z] `代表匹配一个小写字母。
`[^]`  逻辑非， 表示匹配不是中括号内的一个字符。 例如：` [^0-9]` 代表匹配一个不是数字的字符。

```bash
[root@shell script]# ls [acd].txt
a.txt  c.txt  d.txt
[root@shell script]# touch ac.txt
[root@shell script]# ls [abcd][c].txt
ac.txt
[!abcde]  —— 取反，匹配除了a、b、c、d、e之外的任意一个字符
[root@shell script]# ls 
ac.txt  a.txt  b.txt  c.txt  d.txt  e.txt  haha  haha.txt
[root@shell script]# ls [!ac].txt
b.txt  d.txt  e.txt
```

其他

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204100234088.png" style="zoom:67%;" />
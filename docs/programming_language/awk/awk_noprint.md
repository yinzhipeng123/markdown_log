# awk 不打印某一列的输出

比如一个a文件，内容如下，现在要实现不打印最后一列。

```bash
[root@localhost ~]# cat a
a b c
[root@localhost ~]# cat a  | awk '{print $NF}'
c
```

**# 通过设置最后一列为空**

```
[root@localhost ~]# cat a | awk '{$NF="";print$0}'
a b 
```

**# $0 是打印所有列**  （数字零）

```bash
[root@localhost ~]# cat a | awk '{print $0}'
a b c
```

**# 排除多列**

```bash
[root@localhost ~]# cat a | awk '{$2="";$NF="";print$0}'
a 
[root@localhost ~]# cat a | awk '{$2="";print$0}'
a c
```

**# 排除多列另一种写法** （等于多次变量赋值）

```bash
[root@localhost ~]# cat a | awk '{$2=$NF="";print$0}'
a 
```

上面可以看到排除的那列变为了一列空列，再用tr（tr是translate缩写）去除空列：

```bash
[root@localhost ~]# cat a | awk '{$2="";print$0}'
a c # 中间有空列
[root@localhost ~]# cat a | awk '{$2="";print$0}' | tr -s ' ' ' '
a c # 排除了空列
```

tr -s参数意思是如果有多个连续相的同字符就合并为1个。

转自

https://www.rootop.org/pages/4470.html
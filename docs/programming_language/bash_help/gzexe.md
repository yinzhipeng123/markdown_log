# gzexe 

一、  简介
很多时候我们的脚本会涉及到一些私密的信息，例如：用户名，密码，或者其它重要信息的时候，我们使用一些加密的手段来屏蔽这些信息，确保系统的安全已经脚本的可流传性，通常情况下我们只需要通过系统自带的gzexe这个工具就够了。



## 语法

加密：

**语法格式**：gzexe	[文件]

解密：

**语法格式**：gzexe  -d  [文件]

## 实例

1 编写一个用于测试的脚本

```bash
[root@woo ~]# vi woo.sh
#! /bin/ksh
echo 'PrudentWoo'' '`date +%Y-%m-%d' '%T`
uptime
```

2 赋予可执行权限，并执行

```bash
[root@woo ~]# chmod +x woo.sh
[root@woo ~]# ./woo.sh
PrudentWoo 2014-12-30 22:13:27
22:13:27 up 10 days, 23:03,  3 users,  load average: 0.00, 0.01, 0.05
```

3 执行gzexe加密操作

```bash
[root@woo ~]# gzexe woo.sh
woo.sh:  11.5%
[root@woo ~]# ll woo.s*
-rwxr-xr-x 1 root root 888 Dec 30 22:15 woo.sh
-rwxr-xr-x 1 root root  61 Dec 30 22:11 woo.sh~
[root@woo ~]#
```

4 加密后的文件内容

```bash
[root@woo ~]# strings  woo.sh
#!/bin/sh
skip=44
tab='   '
nl='
IFS=" $tab$nl"
umask=`umask`
umask 77
gztmpdir=
trap 'res=$?
  test -n "$gztmpdir" && rm -fr "$gztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15
if type mktemp >/dev/null 2>&1; then
  gztmpdir=`mktemp -dt`
else
  gztmpdir=/tmp/gztmp$$; mkdir $gztmpdir
fi || { (exit 127); exit 127; }
gztmp=$gztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$gztmp" && rm -r "$gztmp";;
*/*) gztmp=$gztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }
case `echo X | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | gzip -cd > "$gztmp"; then
  umask $umask
  chmod 700 "$gztmp"
  (sleep 5; rm -fr "$gztmpdir") 2>/dev/null &
  "$gztmp" ${1+"$@"}; res=$?
else
  echo >&2 "Cannot decompress $0"
  (exit 127); res=127
fi; exit $res
woo.sh
(*MI
WWWPOHI,IU
```

5 再次执行加密后的文件,输出结果一样

```bash
[root@woo ~]# ./woo.sh
PrudentWoo 2014-12-30 22:17:22
 22:17:22 up 10 days, 23:06,  3 users,  load average: 0.00, 0.01, 0.05
[root@woo ~]#
```

6 执行解密操作：

```bash
[root@woo ~]# gzexe -d woo.sh
[root@woo ~]# cat woo.sh
#! /bin/ksh
echo 'PrudentWoo'' '`date +%Y-%m-%d' '%T`
uptime
[root@woo ~]#
```

7 再次执行确认，加密解密都是可行的：

```bash
[root@woo ~]# ./woo.sh
PrudentWoo 2014-12-30 22:19:50
 22:19:50 up 10 days, 23:09,  3 users,  load average: 0.00, 0.01, 0.05
[root@woo ~]#
```


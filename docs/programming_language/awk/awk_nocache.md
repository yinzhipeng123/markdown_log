# awk无缓存输出

```bash
tail -f test.log | grep "mode" | awk '{print $5}' 
或者
tail -f test.log | awk '/mode/ {print $5}'
的时候，如果test.log中满足模式mode的数据很少，会发现即便是test.log中新出现了满足mode的行，但是上面两个命令都没有任何输出。
```

原因在于grep和awk处于效率的考量，会缓存一批数据再输出到标准输出。

grep的--line-buffered选项和awk的fflush(stdout)命令可以使得grep和awk不缓存数据。如：

```bash
tail -f test.log | grep --line-buffered "mode" | awk '{print $5}'
tail -f test.log | awk '/mode/ {print $5,$6; fflush(stdout)}''
```
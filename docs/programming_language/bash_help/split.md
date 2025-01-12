



假设你的文件名是 `input.txt`，你希望将它拆分成每个文件包含 10 行：

```
split -l 10 input.txt output_
```

`-l 10`：指定每个文件包含 10 行。

`input.txt`：要拆分的源文件。

`output_`：拆分后的文件名前缀（结果文件名将依次是 `output_aa`、`output_ab` 等）。



如果你希望生成的文件使用数字后缀而非字母，可以加上 `--numeric-suffixes` 参数，例如：

```bash
split -l 10 --numeric-suffixes input.txt output_
```

结果文件名将变成 `output_00`、`output_01` 等。

```
split -l 5 --numeric-suffixes 47.txt output_
```


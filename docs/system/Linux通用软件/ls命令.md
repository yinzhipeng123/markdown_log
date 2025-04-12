ls命令



```bash
Usage: ls [OPTION]... [FILE]...
列出 FILE 的信息（默认是当前目录）。
如果没有指定 -cftuvSUX 或 --sort，则按字母顺序排序条目。

长选项的必需参数对短选项也同样必需。
  -a, --all                  不忽略以 . 开头的条目
  -A, --almost-all           不列出隐含的 . 和 ..
      --author               与 -l 一起使用时，打印每个文件的作者
  -b, --escape               对非图形字符打印 C 语言风格转义
      --block-size=SIZE      在打印之前将大小按 SIZE 缩放；例如，
                               '--block-size=M' 以 1,048,576 字节为单位打印大小；
                               见下面的 SIZE 格式
  -B, --ignore-backups       不列出以 ~ 结尾的隐含条目
  -c                         与 -lt 一起使用：按并显示状态信息最后修改时间（ctime）排序；
                               与 -l 一起使用：显示 ctime 并按名称排序；
                               否则：按 ctime 排序，最新的在前
  -C                         按列列出条目
      --color[=WHEN]         彩色显示输出；WHEN 可以是 'never'、'auto' 或 'always'（默认值）；更多信息见下文
  -d, --directory            仅列出目录本身，而不是它们的内容
  -D, --dired                生成为 Emacs 的 dired 模式设计的输出
  -f                         不排序，启用 -aU，禁用 -ls --color
  -F, --classify             在条目后追加指示符（例如 */=>@|）
      --file-type            同上，但不追加 '*'
      --format=WORD          across -x, commas -m, horizontal -x, long -l,
                               single-column -1, verbose -l, vertical -C
      --full-time            类似 -l --time-style=full-iso
  -g                         类似 -l，但不列出拥有者
      --group-directories-first
                             将目录排在文件前面；
                               可以与 --sort 选项一起增强使用，但任何使用 --sort=none (-U) 的情况都会禁用分组
  -G, --no-group             在长格式列表中，不打印组名
  -h, --human-readable       与 -l 一起使用时，用易读格式打印大小
                               （例如，1K 234M 2G）
      --si                   同上，但使用 1000 的幂而不是 1024
  -H, --dereference-command-line
                             对命令行中列出的符号链接进行解析
      --dereference-command-line-symlink-to-dir
                             对命令行中指向目录的每个符号链接进行解析
      --hide=PATTERN         不列出匹配 shell PATTERN 的隐含条目
                               （被 -a 或 -A 覆盖）
      --indicator-style=WORD  以 WORD 指定的样式追加指示符到条目名称：
                               none (默认), slash (-p),
                               file-type (--file-type), classify (-F)
  -i, --inode                打印每个文件的索引号
  -I, --ignore=PATTERN       不列出匹配 shell PATTERN 的隐含条目
  -k, --kibibytes            默认使用 1024 字节块计算磁盘使用量
  -l                         使用长格式列表
  -L, --dereference          显示符号链接所指向文件的信息，而不是链接本身的信息
  -m                         以逗号分隔列表填满屏幕宽度
  -n, --numeric-uid-gid      类似 -l，但以数字显示用户和组 ID
  -N, --literal              打印原始条目名称（不对控制字符进行特殊处理）
  -o                         类似 -l，但不列出组信息
  -p, --indicator-style=slash
                             在目录后追加 / 指示符
  -q, --hide-control-chars   用 ? 显示非图形字符
      --show-control-chars   原样显示非图形字符（默认行为，
                               除非程序为 'ls' 且输出为终端）
  -Q, --quote-name           用双引号括起条目名称
      --quoting-style=WORD   使用 WORD 指定的引用样式：
                               literal, locale, shell, shell-always, c, escape
  -r, --reverse              反转排序顺序
  -R, --recursive            递归列出子目录
  -s, --size                 打印每个文件分配的块大小
  -S                         按文件大小排序
      --sort=WORD            按 WORD 排序，而不是按名称：none (-U), size (-S),
                               time (-t), version (-v), extension (-X)
      --time=WORD            与 -l 一起使用时，显示 WORD 指定的时间而不是默认修改时间；
                               可选值为 atime 或 access 或 use (-u)
                               ctime 或 status (-c)；若指定 --sort=time，则使用该时间作为排序关键字
      --time-style=STYLE     与 -l 一起使用时，采用 STYLE 指定的时间显示格式：
                               full-iso, long-iso, iso, locale, 或 +FORMAT;
                               FORMAT 按 'date' 命令的格式进行解析；如果 FORMAT 是 FORMAT1<newline>FORMAT2，
                               则 FORMAT1 用于非近期文件，FORMAT2 用于近期文件；
                               如果 STYLE 前缀为 'posix-'，则 STYLE 只在 POSIX 语言环境之外生效
  -t                         按修改时间排序，最新的在前
  -T, --tabsize=COLS         假定制表符宽度为 COLS 而非 8
  -u                         与 -lt 一起使用：按并显示访问时间排序；
                               与 -l 一起使用：显示访问时间并按名称排序；
                               否则：按访问时间排序
  -U                         不排序；按目录顺序列出条目
  -v                         自然排序文本中的（版本）数字
  -w, --width=COLS           假定屏幕宽度为 COLS 而非当前值
  -x                         按行而非按列列出条目
  -X                         按条目扩展名字母顺序排序
  -1                         每行列出一个文件

SELinux 选项：

  --lcontext                 显示安全上下文。启用 -l。输出行可能对于大多数显示屏来说太宽。
  -Z, --context              显示安全上下文，使其适合大多数显示屏。
                             仅显示模式、用户、组、安全上下文和文件名称。
  --scontext                 仅显示安全上下文和文件名称。
      --help     显示此帮助并退出
      --version  输出版本信息并退出

SIZE 是一个整数并可附加单位（例如：10M 意味着 10*1024*1024）。单位
可以是 K, M, G, T, P, E, Z, Y（以 1024 为底的幂）或者 KB, MB, ...（以 1000 为底的幂）。

使用颜色区分文件类型默认是禁用的，同时也可使用 --color=never 禁用。
在 --color=auto 下，当标准输出连接到终端时，ls 才会发出彩色代码。
LS_COLORS 环境变量可用于改变这些设置。
使用 dircolors 命令来设置它。

退出状态：
 0  如果一切正常，
 1  如果存在小问题（例如，无法访问子目录），
 2  如果存在严重问题（例如，无法访问命令行参数）。

GNU coreutils 在线帮助: <http://www.gnu.org/software/coreutils/>
完整文档，请运行: info coreutils 'ls invocation'
```





```bash
 [root@ ~]# ll -rsth
 total 2.5G
 4.0K -rwxr-xr-x   1 root root      86 Dec 17 14:14 debug
    0 lrwxrwxrwx   1 root root       3 Dec 17 14:57 rvim -> vim
    0 lrwxrwxrwx   1 root root       3 Dec 17 14:57 vimdiff -> vim
    0 lrwxrwxrwx   1 root root       8 Dec 17 14:57 pip-3.6 -> ./pip3.6
    0 lrwxrwxrwx   1 root root       9 Dec 17 14:57 pip-3 -> ./pip-3.6
    0 lrwxrwxrwx   1 root root       5 Dec 19 20:16 mail -> mailx
```



第一列  文件占用的磁盘块数

第二列  文件的权限及类型

第三列  此列显示的是硬链接数

第四列  表示文件的所有者

第五列  文件所在组

第六列  文件的实际大小

第七、第八、第九列（例如 “Jan  7 11:49”）

- “Jan” 表示月份
- “7” 表示日期（号数）
- “11:49” 表示具体修改时间（如果文件修改时间较近，会显示具体的时间，如果修改时间较远则可能显示年份而非时间）

最后一列  文件名



#递归查看，慎用，如果目录非常深

```bash
ls -rsthR
```



https://wangchujiang.com/linux-command/c/ls.html
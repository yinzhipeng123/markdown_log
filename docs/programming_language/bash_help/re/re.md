# 正则表达式

**正则表达式**（英语：Regular Expression，常简写为regex、regexp或RE），又称**正则表示式**、**正则表示法**、**规则表达式**、**常规表示法**，是[计算机科学](https://zh.wikipedia.org/wiki/计算机科学)的一个概念。正则表达式使用单个字符串来描述、匹配一系列匹配某个句法规则的[字符串](https://zh.wikipedia.org/wiki/字符串)。在很多[文本编辑器](https://zh.wikipedia.org/wiki/文本编辑器)里，正则表达式通常被用来检索、替换那些匹配某个模式的文本。

许多[程序设计语言](https://zh.wikipedia.org/wiki/程序设计语言)都支持利用正则表达式进行字符串操作。例如，在[Perl](https://zh.wikipedia.org/wiki/Perl)中就内建了一个功能强大的正则表达式引擎。正则表达式这个概念最初是由[Unix](https://zh.wikipedia.org/wiki/Unix)中的工具软件（例如[sed](https://zh.wikipedia.org/wiki/Sed)和[grep](https://zh.wikipedia.org/wiki/Grep)）普及开的。

[正则表达式 - 维基百科，自由的百科全书 (wikipedia.org)](https://zh.wikipedia.org/wiki/正则表达式)

文本处理命令

grep、sed、awk、sort、cut、uniq、wc等 都支持


字符模式：

​	普通字符：没有任何特殊含义的字符

​	元字符：具有特殊含义的字符    ^  $  *  .   []  ()  {} 等

### 介绍正则表达式元字符

|  元字符   |                功能                 |     例子     |                  匹配结果                   |
| :-------: | :---------------------------------: | :----------: | :-----------------------------------------: |
|     ^     |             行首定位符              |   /^root/    |             匹配以root开头的行              |
|     $     |             行尾定位符              |    /sh$/     |              匹配以sh结尾的行               |
|     .     |    匹配任意单个字符(除了换行符)     |    /l.ve/    |           匹配live、love、... ...           |
|     *     | 前导符，匹配0个或者多个它前面的模式 |    /l*ve/    |         匹配ve、lve、llve、... ...          |
|    .*     |         匹配0到多个任意字符         |              |                                             |
|    []     |      匹配一组字符中的任意一个       | /l[ioIO]ve/  |         匹配live、love、lIve、lOve          |
|   [x-y]   |      匹配一段范围中的任意一个       |  /l[o-z]ve/  |     匹配love、lpve、lqve、... ...、lzve     |
|   [0-9]   |                数字                 |              |                                             |
|   [a-z]   |              小写字母               |              |                                             |
|   [A-Z]   |              大写字母               |              |                                             |
| [a-z0-9]  |           小写字母或数字            |              |                                             |
|  [-+*/]   |            +-*/ 四则运算            |              |                                             |
|   [a-Z]   |                字母                 |              |                                             |
|    [^]    |              表示取反               | `/[^abc]ve/` | 匹配除了ave、bve、cve以外的三个字符的字符串 |
| `[^0-9] ` |              不是数字               |              |                                             |
|     \     |          用于转义元字符的           |  `/93\.4/`   |                  匹配93.4                   |
|   `\<`    |             词首定位符              |   /\<bin/    |          匹配bin、binary、... ...           |
|   `\>`    |             词尾定位符              |   `/sh\>/`   |         匹配bash、csh、ksh、... ...         |
|           |                                     |              |                                             |



### 扩展正则

|   元字符   |                 功能                 |            例子            |                 匹配结果                  |
| :--------: | :----------------------------------: | :------------------------: | :---------------------------------------: |
|    `|`     |                 或者                 |                            |                                           |
|    `?`     |      表示0个或者1个它前面的字符      |            a?d             |                  d   ad                   |
|    `+`     |     表示1个或者多个它前面的字符      |            a+d             |               ad  aad  aaad               |
| `^[0-9]+$` |               任意数字               |                            |                                           |
| `\(...\)`  |              分组、标签              |                            |                                           |
|  `x\{m\}`  | x是字符或者字符串，m是数字，表示次数 | 匹配x出现m次   ` /a\{3\}/` |                 匹配到aaa                 |
| `x\{m,\}`  |           匹配x出现至少m次           |        `/a\{3,\}/ `        | 匹配aaa、aaaa、aaaaaaaa、aaaaaaa、... ... |
| `x\{m,n\}` |          匹配x出现m次到n次           |       ` /a\{3,5\}/`        |           匹配aaa、aaaa、aaaaa            |
|   `x{m}`   |               x出现m次               |                            |                                           |
|  `x{m,}`   |             x至少出现m次             |                            |                                           |
|  `x{m,n}`  |             x出现m到n次              |                            |                                           |
|            |                                      |                            |                                           |

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204101415941.png" style="zoom:67%;" />

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204101346792.png" style="zoom:67%;" />

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202204101347192.png" style="zoom:67%;" />

```bash
[root@shell shelldoc]# egrep "a+" e2.txt --color
aabbcc
aaabbbccc
aaaannnmms    
```



### POSIX表示法

|    元字符    |                功能                 | 例子 | 匹配结果 |
| :----------: | :---------------------------------: | :--: | :------: |
|  [:space:]   | 包含换行符、空格、tab等所有空白字符 |      |          |
|  [:blank:]   |       空格和制表符，空格和tab       |      |          |
|  [:alpha:]   |                字母                 |      |          |
|  [:alnum:]   |      字母和数字(包括空白字符)       |      |          |
|  [:cntrl:]   |    控制字符，ctrl、backspace等等    |      |          |
|  [:lower:]   |              小写字母               |      |          |
|  [:upper:]   |              大写字母               |      |          |
|  [:digit:]   |              十进制数               |      |          |
|  [:xdigit:]  |             十六进制数              |      |          |
|  [:punct:]   |              标点符号               |      |          |
|  [:graph:]   |   可打印的和可见的（非空格）字符    |      |          |
|  [:print:]   |            可打印的字符             |      |          |
| [^[:alpha:]] |         取反，表示不是字母          |      |          |

```bash
[root@shell shelldoc]# grep "[[:space:]]\.[[:digit:]][[:space:]]" datafile --color
southwest	SW	Lewis Dalsass		2.7	.8	218
southeast	SE	Patricia Hemenway	4.0	.7	417
```


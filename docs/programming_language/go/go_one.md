## 安装

**Go安装**

https://golang.google.cn/dl/

Windows安装直接选择go1.16.6.windows-amd64.msi

安装的时候勾线添加环境变量

**IDEA安装**

https://www.jetbrains.com/go/

下载安装

## hello world

打开goland idea

创建项目，创建go文件

```go
package main

import "fmt"

func main() {
   fmt.Println("Hello, World!")
}
```

右键--》运行



## 命令行

用git带的bash 进入项目目录

执行命令

```bash
fugui.wang@wangfuguiK3 MINGW64 /d/idea/go_one
$ go run one.go
Hello, World!

fugui.wang@wangfuguiK3 MINGW64 /d/idea/go_one
$ go build one.go

fugui.wang@wangfuguiK3 MINGW64 /d/idea/go_one
$ ls
one.exe*  one.go

fugui.wang@wangfuguiK3 MINGW64 /d/idea/go_one
$ ./one.exe
Hello, World!
```


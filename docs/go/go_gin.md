# Go Gin Web框架入门



**Go安装**

https://golang.google.cn/dl/

Windows安装直接选择go1.16.6.windows-amd64.msi

安装的时候勾线添加环境变量

**IDEA安装**

https://www.jetbrains.com/go/



**设置源**

官网地址：https://goproxy.io/zh/

```text
1. 右键 我的电脑 -> 属性 -> 高级系统设置 -> 环境变量
2. 在 “[你的用户名]的用户变量” 中点击 ”新建“ 按钮
3. 在 “变量名” 输入框并新增 “GOPROXY”
4. 在对应的 “变量值” 输入框中新增 “https://goproxy.io,direct”
5. 最后点击 “确定” 按钮保存设置
```



创建gin项目

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/go/%E4%BC%81%E4%B8%9A%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20210811151855.png?raw=true)

然后项目中新建main.go文件

```go
package main

import "github.com/gin-gonic/gin"

func main() {
   r := gin.Default()
   r.GET("/ping", func(c *gin.Context) {
      c.JSON(200, gin.H{
         "message": "pong",
      })
   })
   r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}
```

在goland终端输入下面代码，编译依赖包，下载包

```text
D:\idea\mygin>go mod edit -require github.com/gin-gonic/gin@latest

D:\idea\mygin>go mod tidy
```

如图

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/go/%E4%BC%81%E4%B8%9A%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20210811152212.png?raw=true)

项目中右键运行，如图

![](https://github.com/yinzhipeng123/markdown_log/blob/main/docs/image/go/%E4%BC%81%E4%B8%9A%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20210811152458.png?raw=true)


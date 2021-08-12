## Gin 路由拆分到不同的APP

有时候项目规模实在太大，那么我们就更倾向于把业务拆分的更详细一些，例如把不同的业务代码拆分成不同的APP。

因此我们在项目目录下单独定义一个app目录，用来存放我们不同业务线的代码文件，这样就很容易进行横向扩展。大致目录结构如下：

```tex

myapp
│  go.mod
│  main.go
├─app
│  ├─blog
│  │      handler.go
│  │      router.go
│  │
│  └─shop
│          handler.go
│          router.go
│
└─routers
        route.go
```

main.go

```go
package main

import (
   "fmt"
   "myapp/app/blog"
   "myapp/app/shop"
   "myapp/routers"
)

func main() {
   // 加载多个APP的路由配置
   routers.Include(shop.Routers, blog.Routers)
   // 初始化路由
   r := routers.Init()
   if err := r.Run(); err != nil {
      fmt.Println("startup service failed, err:%v\n", err)
   }
}
```

go.mod

```go
module myapp

go 1.16

require github.com/gin-gonic/gin v1.7.3
```

route.go

```go
package routers

import "github.com/gin-gonic/gin"

type Option func(*gin.Engine)

var options = []Option{}

// 注册app的路由配置
func Include(opts ...Option) {
   options = append(options, opts...)
}

// 初始化
func Init() *gin.Engine {
   r := gin.Default()
   for _, opt := range options {
      opt(r)
   }
   return r
}
```

app/shop/handler.go

```go
package shop

import (
   "github.com/gin-gonic/gin"
   "net/http"
)

func helloShop(c *gin.Context) {
   c.JSON(http.StatusOK, gin.H{
      "message": "Hello Shop!",
   })
}
```

app/shop/router.go

```go
package shop

import "github.com/gin-gonic/gin"

func Routers(e *gin.Engine) {
	e.GET("/shop", helloShop)

}

```

app/blog/handler.go

```go
package blog

import (
   "github.com/gin-gonic/gin"
   "net/http"
)

func helloBlog(c *gin.Context) {
   c.JSON(http.StatusOK, gin.H{
      "message": "Hello Blog",
   })
}
```

app/blog/router.go

```go
package blog

import (
   "github.com/gin-gonic/gin"
)

func Routers(e *gin.Engine) {
   e.GET("/Blog", helloBlog)
}
```

然后在终端运行

```powershell
D:\idea\mygin>go mod tidy
```

项目运行，或者在goland中 main.go右键运行

```powershell
D:\idea\mygin>go run main.go
```


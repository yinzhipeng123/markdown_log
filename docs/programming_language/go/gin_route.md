# Go Gin 路由拆分成单个文件





Gin  路由拆分成多个文件，这样适合中小型项目

```bash
mygin
	│  go.mod
	│  main.go
	└─ routers
        	load.go
        	shop.go
```



main.go

```go
package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"mygin/routers"
)

func main() {
	r := gin.Default()
	routers.LoadBlog(r)
	routers.LoadShop(r)
	if err := r.Run(); err != nil {
		fmt.Println("startup service failed, err:%v\n", err)
	}
}

```

load.go

```go
package routers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func helloBlog(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"message": "Hello Blog",
	})
}


func LoadBlog(e *gin.Engine) {
	e.GET("/Blog", helloBlog)
}
```

shop.go

```go
package routers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func helloShop(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"message": "Hello Shop!",
	})
}


func LoadShop(e *gin.Engine)  {
	e.GET("/Shop", helloShop)
}
```

go.mod

```text
module mygin

go 1.16

require github.com/gin-gonic/gin v1.7.3
```



然后在终端运行

```powershell
D:\idea\mygin>go mod tidy
```

项目运行，或者在goland中 main.go右键运行

```powershell
D:\idea\mygin>go run main.go
```


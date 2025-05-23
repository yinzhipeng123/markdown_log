



docker命令查询

https://www.fosstechnix.com/docker-command-cheat-sheet/





docker – 查看所有可用的 Docker 命令

docker version – 显示 Docker 版本

docker info – 显示系统范围的详细信息

docker pull – 从 Docker Hub 仓库拉取 Docker 镜像

docker build – 从 Dockerfile 构建 Docker 镜像

docker run – 从 Docker 镜像运行一个容器

docker commit – 提交容器中的更改或创建新的 Docker 镜像

docker ps – 列出所有运行中的容器。添加 -a 标志可以列出所有容器

docker start – 启动一个 Docker 容器

docker stop – 停止一个 Docker 容器

docker logs – 查看 Docker 容器的日志

docker rename – 重命名 Docker 容器

docker rm – 删除 Docker 容器，先停止再删除

docker build – 从 Dockerfile 构建 Docker 镜像

docker pull – 从 Docker Hub 仓库拉取 Docker 镜像

docker tag – 为 Docker 镜像添加标签

docker images – 列出 Docker 镜像

docker push – 推送 Docker 镜像到仓库

docker history – 显示 Docker 镜像的历史记录

docker inspect – 以 JSON 格式显示详细信息

docker save – 保存现有的 Docker 镜像

docker import – 从 tar 文件创建 Docker 镜像

docker export – 导出现有的 Docker 容器

docker load – 从文件或归档中加载 Docker 镜像

docker rmi – 删除 Docker 镜像

docker start – 启动一个 Docker 容器

docker stop – 停止一个运行中的 Docker 容器

docker restart – 重启 Docker 容器

docker pause – 暂停一个运行中的容器

docker unpause – 恢复一个暂停的容器

docker run – 从 Docker 镜像创建 Docker 容器

docker ps – 列出 Docker 容器

docker exec – 访问 Docker 容器的 shell

docker logs – 查看 Docker 容器的日志

docker rename – 重命名 Docker 容器

docker rm – 删除 Docker 容器

docker inspect – 查看 Docker 容器信息

docker attach – 附加到运行中的容器终端

docker kill – 停止并删除 Docker 容器

docker cp – 在容器和本地文件系统之间复制文件或文件夹

docker-compose build – 构建 Docker Compose 文件

docker-compose up – 运行 Docker Compose 文件

docker-compose ls – 列出 Docker Compose 文件中声明的镜像

docker-compose start – 启动已用 Docker Compose 文件创建的容器

docker-compose run – 运行 docker-compose.yml 中的某个应用

docker-compose rm – 删除 Docker Compose 中的容器

docker-compose ps – 查看 Docker Compose 中容器的状态

docker volume create – 创建 Docker 卷

docker volume inspect – 检查 Docker 卷

docker volume rm – 删除 Docker 卷

docker network create – 创建 Docker 网络

docker network ls – 列出 Docker 网络

docker network inspect – 查看网络配置详细信息

docker ps -a – 显示运行和已停止的容器

docker logs – 显示 Docker 容器日志

docker events – 查看 Docker 容器的所有事件

docker top – 显示 Docker 容器中运行的进程

docker stats – 查看 CPU、内存和网络 I/O 使用情况

docker port – 查看 Docker 容器的公共端口

docker system prune – 删除未使用和已停止的 Docker 镜像

docker system prune -a – 删除悬空的 Docker 镜像

docker image prune – 删除悬空的 Docker 镜像

docker image prune -a – 删除所有未使用的 Docker 镜像

docker container prune – 删除所有未使用的 Docker 容器

docker volume prune – 删除所有未使用的 Docker 卷

docker network prune – 删除所有未使用的 Docker 网络

docker search ubuntu – 搜索 Docker 镜像

docker pull ubuntu – 从 Docker Hub 拉取镜像

docker push fosstechnix/nodejsdocker – 再次推送 Docker 镜像

docker logout – 从 Docker Hub 注销





查看容器的目录映射都有哪些

```bash
 docker inspect -f '{{ .Mounts }}' 容器名 
```
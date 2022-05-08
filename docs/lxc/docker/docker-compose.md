# docker compose

## 安装

https://docs.docker.com/compose/install/

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
```

## volume 映射

### 子级卷映射

docker-compose.yaml所在位置 /root/pinpoint-docker/

如下配置：

```yaml
version: "3.6"

services:
  pinpoint-hbase:
    build:
      context: ./pinpoint-hbase/
      dockerfile: Dockerfile
      args:
        - PINPOINT_VERSION=${PINPOINT_VERSION}

    container_name: "${PINPOINT_HBASE_NAME}"
    image: "pinpointdocker/pinpoint-hbase:${PINPOINT_VERSION}"
    networks:
      - pinpoint

    volumes:
      - ./hase_data:/home/pinpoint/hbase
      - ./zoo_data:/home/pinpoint/zookeeper
```

这段

```yaml
volumes:

   - ./hase_data:/home/pinpoint/hbase
     ./zoo_data:/home/pinpoint/zookeepe
```

- 容器里面/home/pinpoint/hbase映射到当前docker-compose.yaml文件所在的目录下的hase_data目录中
- 容器里面/home/pinpoint/zookeeper映射到当前docker-compose.yaml文件所在的目录下的zoo_data目录中

### 顶级卷

docker-compose.yaml所在位置 /root/pinpoint-docker/

如下配置：

```yaml
version: "3.6"

services:
  pinpoint-mysql:
    build:
      context: ./pinpoint-mysql/
      dockerfile: Dockerfile
      args:
        - PINPOINT_VERSION=${PINPOINT_VERSION}

    container_name: pinpoint-mysql
    restart: always
    image: "pinpointdocker/pinpoint-mysql:${PINPOINT_VERSION}"
    hostname: pinpoint-mysql
    ports:
      - "3306:3306"
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
      - MYSQL_USER=${MYSQL_USER}
      - MYSQL_PASSWORD=${MYSQL_PASSWORD}
      - MYSQL_DATABASE=${MYSQL_DATABASE}

    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - pinpoint
//顶级卷        
volumes:
  data-volume:
  mysql_data:
```

这段：

```yaml
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - pinpoint
//顶级卷        
volumes:
  data-volume:
  mysql_data:
```

这段的意思是：

容器的/var/lib/mysql 的数据挂载到宿主机的mysql_data中，顶级卷在宿主机中有默认位置

通过命令   docker volume ls 可以查看

```
DRIVER    VOLUME NAME
local     pinpoint-docker_data-volume
local     pinpoint-docker_mysql_data
```

可以通过 docker inspect pinpoint-docker_mysql_data 查看具体位置

pinpoint-docker_ 为该docker-compose.yaml部署文件的目录

#### 顶级卷映射

docker-compose.yaml所在位置 /root/pinpoint-docker/

如下配置：

```yaml
version: "3.6"
services:
  pinpoint-mysql:
    build:
      context: ./pinpoint-mysql/
      dockerfile: Dockerfile
      args:
        - PINPOINT_VERSION=${PINPOINT_VERSION}

    container_name: pinpoint-mysql
    restart: always
    image: "pinpointdocker/pinpoint-mysql:${PINPOINT_VERSION}"
    hostname: pinpoint-mysql
    ports:
      - "3306:3306"
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
      - MYSQL_USER=${MYSQL_USER}
      - MYSQL_PASSWORD=${MYSQL_PASSWORD}
      - MYSQL_DATABASE=${MYSQL_DATABASE}

    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - pinpoint

volumes:
  data-volume:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ./data-volume
  mysql_data:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ./mysql_data
```

这段：

```yaml
volumes:
  data-volume:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ./data-volume
  mysql_data:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ./mysql_data
```

通过此方法可以把顶级卷挂载到宿主机指定目录，宿主机目录需要提前创建出来

通过命令   docker volume ls 可以查看

```
DRIVER    VOLUME NAME
local     pinpoint-docker_data-volume
local     pinpoint-docker_mysql_data
```

```
[root@centos7 pinpoint-docker]# docker inspect pinpoint-docker_data-volume
[
    {
        "CreatedAt": "2021-12-16T12:52:27+08:00",
        "Driver": "local",
        "Labels": {
            "com.docker.compose.project": "pinpoint-docker",
            "com.docker.compose.version": "1.29.2",
            "com.docker.compose.volume": "data-volume"
        },
        "Mountpoint": "/var/lib/docker/volumes/pinpoint-docker_data-volume/_data",
        "Name": "pinpoint-docker_data-volume",
        "Options": {
            "device": "/root/pinpoint-docker/data-volume",
            "o": "bind",
            "type": "none"
        },
        "Scope": "local"
    }
]
```

github上 docker-compose 源码中对 卷的介绍，但是不详细：https://github.com/docker/docker.github.io/blob/master/compose/compose-file/compose-file-v3.md#volume-configuration-reference

注意每个docker-compose.yaml 上都有个 version 版本，是告诉docker-compose 这个yaml 是基于哪个版本的语法写的 ，关于docker-compose的语法版本介绍：https://github.com/docker/docker.github.io/blob/master/compose/compose-file/compose-versioning.md

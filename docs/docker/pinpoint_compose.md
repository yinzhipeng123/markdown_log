# pinpoint

项目地址：https://github.com/pinpoint-apm/pinpoint-docker

pinpoint docker-compose 部署文件

https://github.com/pinpoint-apm/pinpoint-docker/blob/master/docker-compose.yml

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
      - /home/pinpoint/hbase
      - /home/pinpoint/zookeeper
    expose:
      # HBase Master API port
      - "60000"
      # HBase Master Web UI
      - "16010"
      # Regionserver API port
      - "60020"
      # HBase Regionserver web UI
      - "16030"
    ports:
      - "60000:60000"
      - "16010:16010"
      - "60020:60020"
      - "16030:16030"
    restart: always
    depends_on:
      - zoo1

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

  pinpoint-web:
    build:
      context: ./pinpoint-web/
      dockerfile: Dockerfile
      args:
        - PINPOINT_VERSION=${PINPOINT_VERSION}

    container_name: "${PINPOINT_WEB_NAME}"
    image: "pinpointdocker/pinpoint-web:${PINPOINT_VERSION}"

    depends_on:
      - pinpoint-hbase
      - pinpoint-mysql
      - zoo1
    restart: always
    expose:
      - "9997"
    ports:
      - "9997:9997"
      - "${SERVER_PORT:-8080}:${SERVER_PORT:-8080}"
    environment:
      - SERVER_PORT=${SERVER_PORT}
      - SPRING_PROFILES_ACTIVE=${SPRING_PROFILES},batch
      - PINPOINT_ZOOKEEPER_ADDRESS=${PINPOINT_ZOOKEEPER_ADDRESS}
      - CLUSTER_ENABLE=${CLUSTER_ENABLE}
      - ADMIN_PASSWORD=${ADMIN_PASSWORD}
      - CONFIG_SENDUSAGE=${CONFIG_SENDUSAGE}
      - LOGGING_LEVEL_ROOT=${WEB_LOGGING_LEVEL_ROOT}
      - CONFIG_SHOW_APPLICATIONSTAT=${CONFIG_SHOW_APPLICATIONSTAT}
      - BATCH_ENABLE=${BATCH_ENABLE}
      - BATCH_SERVER_IP=${BATCH_SERVER_IP}
      - BATCH_FLINK_SERVER=${BATCH_FLINK_SERVER}
      - JDBC_DRIVERCLASSNAME=${JDBC_DRIVERCLASSNAME}
      - JDBC_URL=${JDBC_URL}
      - JDBC_USERNAME=${JDBC_USERNAME}
      - JDBC_PASSWORD=${JDBC_PASSWORD}
      - ALARM_MAIL_SERVER_URL=${ALARM_MAIL_SERVER_URL}
      - ALARM_MAIL_SERVER_PORT=${ALARM_MAIL_SERVER_PORT}
      - ALARM_MAIL_SERVER_USERNAME=${ALARM_MAIL_SERVER_USERNAME}
      - ALARM_MAIL_SERVER_PASSWORD=${ALARM_MAIL_SERVER_PASSWORD}
      - ALARM_MAIL_SENDER_ADDRESS=${ALARM_MAIL_SENDER_ADDRESS}
      - ALARM_MAIL_TRANSPORT_PROTOCOL=${ALARM_MAIL_TRANSPORT_PROTOCOL}
      - ALARM_MAIL_SMTP_PORT=${ALARM_MAIL_SMTP_PORT}
      - ALARM_MAIL_SMTP_AUTH=${ALARM_MAIL_SMTP_AUTH}
      - ALARM_MAIL_SMTP_STARTTLS_ENABLE=${ALARM_MAIL_SMTP_STARTTLS_ENABLE}
      - ALARM_MAIL_SMTP_STARTTLS_REQUIRED=${ALARM_MAIL_SMTP_STARTTLS_REQUIRED}
      - ALARM_MAIL_DEBUG=${ALARM_MAIL_DEBUG}
    links:
      - "pinpoint-mysql:pinpoint-mysql"
    networks:
      - pinpoint

  pinpoint-collector:
    build:
      context: ./pinpoint-collector/
      dockerfile: Dockerfile
      args:
        - PINPOINT_VERSION=${PINPOINT_VERSION}

    container_name: "${PINPOINT_COLLECTOR_NAME}"
    image: "pinpointdocker/pinpoint-collector:${PINPOINT_VERSION}"

    depends_on:
      - pinpoint-hbase
      - zoo1
    restart: always
    expose:
      - "9991"
      - "9992"
      - "9993"
      - "9994"
      - "9995"
      - "9996"
    ports:
      - "${COLLECTOR_RECEIVER_GRPC_AGENT_PORT:-9991}:9991/tcp"
      - "${COLLECTOR_RECEIVER_GRPC_STAT_PORT:-9992}:9992/tcp"
      - "${COLLECTOR_RECEIVER_GRPC_SPAN_PORT:-9993}:9993/tcp"
      - "${COLLECTOR_RECEIVER_BASE_PORT:-9994}:9994"
      - "${COLLECTOR_RECEIVER_STAT_UDP_PORT:-9995}:9995/tcp"
      - "${COLLECTOR_RECEIVER_SPAN_UDP_PORT:-9996}:9996/tcp"
      - "${COLLECTOR_RECEIVER_STAT_UDP_PORT:-9995}:9995/udp"
      - "${COLLECTOR_RECEIVER_SPAN_UDP_PORT:-9996}:9996/udp"

    networks:
      - pinpoint
    environment:
      - SPRING_PROFILES_ACTIVE=${SPRING_PROFILES}
      - PINPOINT_ZOOKEEPER_ADDRESS=${PINPOINT_ZOOKEEPER_ADDRESS}
      - CLUSTER_ENABLE=${CLUSTER_ENABLE}
      - LOGGING_LEVEL_ROOT=${COLLECTOR_LOGGING_LEVEL_ROOT}
      - FLINK_CLUSTER_ENABLE=${FLINK_CLUSTER_ENABLE}
      - FLINK_CLUSTER_ZOOKEEPER_ADDRESS=${FLINK_CLUSTER_ZOOKEEPER_ADDRESS}

  pinpoint-quickstart:
    build:
      context: ./pinpoint-quickstart/
      dockerfile: Dockerfile

    container_name: "pinpoint-quickstart"
    image: "pinpointdocker/pinpoint-quickstart"
    ports:
      - "${APP_PORT:-8080}:8080"
    volumes:
      - data-volume:/pinpoint-agent
    environment:
      JAVA_OPTS: "-javaagent:/pinpoint-agent/pinpoint-bootstrap-${PINPOINT_VERSION}.jar -Dpinpoint.agentId=${AGENT_ID} -Dpinpoint.applicationName=${APP_NAME} -Dpinpoint.profiler.profiles.active=${SPRING_PROFILES}"
    networks:
      - pinpoint
    depends_on:
      - pinpoint-agent

  pinpoint-agent:
    build:
      context: ./pinpoint-agent/
      dockerfile: Dockerfile
      args:
        - PINPOINT_VERSION=${PINPOINT_VERSION}

    container_name: "${PINPOINT_AGENT_NAME}"
    image: "pinpointdocker/pinpoint-agent:${PINPOINT_VERSION}"

    restart: unless-stopped

    networks:
      - pinpoint
    volumes:
      - data-volume:/pinpoint-agent
    environment:
      - SPRING_PROFILES=${SPRING_PROFILES}
      - COLLECTOR_IP=${COLLECTOR_IP}
      - PROFILER_TRANSPORT_AGENT_COLLECTOR_PORT=${PROFILER_TRANSPORT_AGENT_COLLECTOR_PORT}
      - PROFILER_TRANSPORT_METADATA_COLLECTOR_PORT=${PROFILER_TRANSPORT_METADATA_COLLECTOR_PORT}
      - PROFILER_TRANSPORT_STAT_COLLECTOR_PORT=${PROFILER_TRANSPORT_STAT_COLLECTOR_PORT}
      - PROFILER_TRANSPORT_SPAN_COLLECTOR_PORT=${PROFILER_TRANSPORT_SPAN_COLLECTOR_PORT}
      - PROFILER_SAMPLING_RATE=${PROFILER_SAMPLING_RATE}
      - DEBUG_LEVEL=${AGENT_DEBUG_LEVEL}
      - PROFILER_TRANSPORT_MODULE=${PROFILER_TRANSPORT_MODULE}
    depends_on:
      - pinpoint-collector

  #zookeepers
  zoo1:
    image: zookeeper:3.4
    restart: always
    hostname: zoo1
    expose:
      - "2181"
      - "2888"
      - "3888"
    ports:
      - "2181"
    environment:
      ZOO_MY_ID: 1
      ZOO_SERVERS: server.1=0.0.0.0:2888:3888 server.2=zoo2:2888:3888 server.3=zoo3:2888:3888
    networks:
      - pinpoint

  zoo2:
    image: zookeeper:3.4
    restart: always
    hostname: zoo2
    expose:
      - "2181"
      - "2888"
      - "3888"
    ports:
      - "2181"
    environment:
      ZOO_MY_ID: 2
      ZOO_SERVERS: server.1=zoo1:2888:3888 server.2=0.0.0.0:2888:3888 server.3=zoo3:2888:3888
    networks:
      - pinpoint

  zoo3:
    image: zookeeper:3.4
    restart: always
    hostname: zoo3
    expose:
      - "2181"
      - "2888"
      - "3888"
    ports:
      - "2181"
    environment:
      ZOO_MY_ID: 3
      ZOO_SERVERS: server.1=zoo1:2888:3888 server.2=zoo2:2888:3888 server.3=0.0.0.0:2888:3888
    networks:
      - pinpoint

  ##flink
  jobmanager:
    build:
      context: pinpoint-flink
      dockerfile: Dockerfile
      args:
        - PINPOINT_VERSION=${PINPOINT_VERSION}

    container_name: "${PINPOINT_FLINK_NAME}-jobmanager"
    image: "pinpointdocker/pinpoint-flink:${PINPOINT_VERSION}"
    expose:
      - "6123"
    ports:
      - "${FLINK_WEB_PORT:-8081}:8081"
    command: standalone-job -p 1 pinpoint-flink-job.jar -spring.profiles.active release
    environment:
      - JOB_MANAGER_RPC_ADDRESS=jobmanager
      - PINPOINT_ZOOKEEPER_ADDRESS=${PINPOINT_ZOOKEEPER_ADDRESS}
    networks:
      - pinpoint
    depends_on:
      - zoo1

  taskmanager:
    build:
      context: pinpoint-flink
      dockerfile: Dockerfile
      args:
        - PINPOINT_VERSION=${PINPOINT_VERSION}

    container_name: "${PINPOINT_FLINK_NAME}-taskmanager"
    image: "pinpointdocker/pinpoint-flink:${PINPOINT_VERSION}"
    expose:
      - "6121"
      - "6122"
      - "19994"
    ports:
      - "6121:6121"
      - "6122:6122"
      - "19994:19994"
    depends_on:
      - zoo1
      - jobmanager
    command: taskmanager
    links:
      - "jobmanager:jobmanager"
    environment:
      - JOB_MANAGER_RPC_ADDRESS=jobmanager
    networks:
      - pinpoint

volumes:
  data-volume:
  mysql_data:

networks:
  pinpoint:
    driver: bridge
```

docker-compose会默认读取同级目录的.env

```bash
PINPOINT_VERSION=2.3.2
SPRING_PROFILES=release
#zookeeper information required
PINPOINT_ZOOKEEPER_ADDRESS=zoo1

### Pinpoint-Hbase

PINPOINT_HBASE_NAME=pinpoint-hbase
#config for hbase in external docker

### Pinpoint-mysql
MYSQL_ROOT_PASSWORD=root123
MYSQL_USER=admin
MYSQL_PASSWORD=admin
MYSQL_DATABASE=pinpoint

### Pinpoint-Web

PINPOINT_WEB_NAME=pinpoint-web

SERVER_PORT=8079

WEB_LOGGING_LEVEL_ROOT=INFO

CLUSTER_ENABLE=true

ADMIN_PASSWORD=admin

#analytics
CONFIG_SENDUSAGE=true

#flink server information required if used
BATCH_ENABLE=false
BATCH_SERVER_IP=127.0.0.1
BATCH_FLINK_SERVER=pinpoint-flink-jobmanager

CONFIG_SHOW_APPLICATIONSTAT=true

#mysql information required if used
JDBC_DRIVERCLASSNAME=com.mysql.jdbc.Driver
JDBC_URL=jdbc:mysql://pinpoint-mysql:3306/pinpoint?characterEncoding=UTF-8
JDBC_USERNAME=admin
JDBC_PASSWORD=admin

#mail server information required if used
ALARM_MAIL_SERVER_URL=smtp.gmail.com
ALARM_MAIL_SERVER_PORT=587
ALARM_MAIL_SERVER_USERNAME=username
ALARM_MAIL_SERVER_PASSWORD=password
ALARM_MAIL_SENDER_ADDRESS=pinpoint_operator@pinpoint.com
ALARM_MAIL_TRANSPORT_PROTOCOL=smtp
ALARM_MAIL_SMTP_PORT=25
ALARM_MAIL_SMTP_AUTH=false
ALARM_MAIL_SMTP_STARTTLS_ENABLE=false
ALARM_MAIL_SMTP_STARTTLS_REQUIRED=false
ALARM_MAIL_DEBUG=false


### Pinpoint-Collector

PINPOINT_COLLECTOR_NAME=pinpoint-collector

CLUSTER_ENABLE=true

COLLECTOR_LOGGING_LEVEL_ROOT=INFO

#grpc
COLLECTOR_RECEIVER_GRPC_AGENT_PORT=9991
COLLECTOR_RECEIVER_GRPC_STAT_PORT=9992
COLLECTOR_RECEIVER_GRPC_SPAN_PORT=9993

#thrift
COLLECTOR_RECEIVER_BASE_PORT=9994
COLLECTOR_RECEIVER_STAT_UDP_PORT=9995
COLLECTOR_RECEIVER_SPAN_UDP_PORT=9996

FLINK_CLUSTER_ENABLE=true
FLINK_CLUSTER_ZOOKEEPER_ADDRESS=zoo1


### Pinpoint-Agent

PINPOINT_AGENT_NAME=pinpoint-agent

#network module(GRPC,THRIFT)
PROFILER_TRANSPORT_MODULE=GRPC

#collector information required
COLLECTOR_IP=pinpoint-collector
PROFILER_TRANSPORT_AGENT_COLLECTOR_PORT=9991
PROFILER_TRANSPORT_METADATA_COLLECTOR_PORT=9991
PROFILER_TRANSPORT_STAT_COLLECTOR_PORT=9992
PROFILER_TRANSPORT_SPAN_COLLECTOR_PORT=9993
COLLECTOR_TCP_PORT=9994
COLLECTOR_STAT_PORT=9995
COLLECTOR_SPAN_PORT=9996

# Set sampling rate. If you set it to N, 1 out of N transaction will be sampled.
PROFILER_SAMPLING_RATE=1

AGENT_ID=app-in-docker
APP_NAME=quickapp

AGENT_DEBUG_LEVEL=INFO


### Pinpoint-flink

PINPOINT_FLINK_NAME=pinpoint-flink
FLINK_WEB_PORT=8081


### Pinpoint-quickstart

APP_PORT=8000
```



### 工程、服务、容器

- **Docker Compose 将所管理的容器分为三层，分别是工程（project）、服务（service）、容器（container）**
- **Docker Compose 运行目录下的所有文件（docker-compose.yml）组成一个工程,一个工程包含多个服务，每个服务中定义了容器运行的镜像、参数、依赖，一个服务可包括多个容器实例**

## Docker Compose 常用命令与配置

### 常见命令

- **ps**：列出所有运行容器



```undefined
docker-compose ps
```

- **logs**：查看服务日志输出



```undefined
docker-compose logs
```

- **port**：打印绑定的公共端口，下面命令可以输出 eureka 服务 8761 端口所绑定的公共端口



```undefined
docker-compose port eureka 8761
```

- **build**：构建或者重新构建服务



```undefined
docker-compose build
```

- **start**：启动指定服务已存在的容器



```undefined
docker-compose start eureka
```

- **stop**：停止已运行的服务的容器



```undefined
docker-compose stop eureka
```

- **rm**：删除指定服务的容器



```undefined
docker-compose rm eureka
```

- **up**：构建、启动容器



```undefined
docker-compose up
```

- **kill**：通过发送 SIGKILL 信号来停止指定服务的容器



```bash
docker-compose kill eureka
```

- **pull**：下载服务镜像
- **scale**：设置指定服务运气容器的个数，以 service=num 形式指定



```undefined
docker-compose scale user=3 movie=3
```

- **run**：在一个服务上执行一个命令



```undefined
docker-compose run web bash
```

### docker-compose.yml 属性

- **version**：指定 docker-compose.yml 文件的写法格式
- **services**：多个容器集合
- **build**：配置构建时，Compose 会利用它自动构建镜像，该值可以是一个路径，也可以是一个对象，用于指定 Dockerfile 参数



```undefined
build: ./dir
---------------
build:
    context: ./dir
    dockerfile: Dockerfile
    args:
        buildno: 1
```

- **command**：覆盖容器启动后默认执行的命令



```bash
command: bundle exec thin -p 3000
----------------------------------
command: [bundle,exec,thin,-p,3000]
```

- **dns**：配置 dns 服务器，可以是一个值或列表



```css
dns: 8.8.8.8
------------
dns:
    - 8.8.8.8
    - 9.9.9.9
```

- **dns_search**：配置 DNS 搜索域，可以是一个值或列表



```css
dns_search: example.com
------------------------
dns_search:
    - dc1.example.com
    - dc2.example.com
```

- **environment**：环境变量配置，可以用数组或字典两种方式



```bash
environment:
    RACK_ENV: development
    SHOW: 'ture'
-------------------------
environment:
    - RACK_ENV=development
    - SHOW=ture
```

- **env_file**：从文件中获取环境变量，可以指定一个文件路径或路径列表，其优先级低于 environment 指定的环境变量



```undefined
env_file: .env
---------------
env_file:
    - ./common.env
```

- **expose**：暴露端口，只将端口暴露给连接的服务，而不暴露给主机



```bash
expose:
    - "3000"
    - "8000"
```

- **image**：指定服务所使用的镜像



```undefined
image: java
```

- **network_mode**：设置网络模式



```bash
network_mode: "bridge"
network_mode: "host"
network_mode: "none"
network_mode: "service:[service name]"
network_mode: "container:[container name/id]"
```

- **ports**：对外暴露的端口定义，和 expose 对应



```objectivec
ports:   # 暴露端口信息  - "宿主机端口:容器暴露端口"
- "8763:8763"
- "8763:8763"
```

- **links**：将指定容器连接到当前连接，可以设置别名，避免ip方式导致的容器重启动态改变的无法连接情况



```bash
links:    # 指定服务名称:别名 
    - docker-compose-eureka-server:compose-eureka
```

- **volumes**：卷挂载路径



```csharp
volumes:
  - /lib
  - /var
```

- **logs**：日志输出信息



```undefined
--no-color          单色输出，不显示其他颜.
-f, --follow        跟踪日志输出，就是可以实时查看日志
-t, --timestamps    显示时间戳
--tail              从日志的结尾显示，--tail=200
```

## Docker Compose 其它

### 更新容器

- 当服务的配置发生更改时，可使用 docker-compose up 命令更新配置
- 此时，Compose 会删除旧容器并创建新容器，新容器会以不同的 IP 地址加入网络，名称保持不变，任何指向旧容起的连接都会被关闭，重新找到新容器并连接上去

### links

- 服务之间可以使用服务名称相互访问，links 允许定义一个别名，从而使用该别名访问其它服务



```bash
version: '2'
services:
    web:
        build: .
        links:
            - "db:database"
    db:
        image: postgres
```

- 这样 Web 服务就可以使用 db 或 database 作为 hostname 访问 db 服务了

### restart

重启策略

- always – 不管退出状态码是什么始终重启容器。当指定always时，docker daemon将无限次数地重启容器。容器也会在daemon启动时尝试重启，不管容器当时的状态如何。
-  no – 容器退出时不要自动重启。这个是默认值。
-  on-failure[:max-retries] – 只在容器以非0状态码退出时重启。可选的，可以退出docker daemon尝试重启容器的次数。
- unless-stopped - 不管退出状态码是什么始终重启容器，不过当daemon启动时，如果容器之前已经为停止状态，不要尝试启动它。

### depends_on

在使用 Compose 时，最大的好处就是少打启动命令，但是一般项目容器启动的顺序是有要求的，如果直接从上到下启动容器，必然会因为容器依赖问题而启动失败。
 例如在没启动数据库容器的时候启动了应用容器，这时候应用容器会因为找不到数据库而退出，为了避免这种情况我们需要加入一个标签，就是 depends_on，这个标签解决了容器的依赖、启动先后的问题。
 例如下面容器会先启动 redis 和 db 两个服务，最后才启动 web 服务：



```bash
version: '2'
services:
  web:
    build: .
    depends_on:
      - db
      - redis
  redis:
    image: redis
  db:
    image: postgres
```

注意的是，默认情况下使用 docker-compose up web 这样的方式启动 web 服务时，也会启动 redis 和 db 两个服务，因为在配置文件中定义了依赖关系。

https://juejin.cn/post/6844903976534540296





默认情况下，Compose会为我们的应用创建一个网络，服务的每个容器都会加入该网络中。这样，容器就可被该网络中的其他容器访问，不仅如此，该容器还能以服务名称作为hostname被其他容器访问。

默认情况下，应用程序的网络名称基于Compose的工程名称，而项目名称基于docker-compose.yml所在目录的名称。如需修改工程名称，可使用--project-name标识或COMPOSE_PORJECT_NAME环境变量。

举个例子，假如一个应用程序在名为myapp的目录中，并且docker-compose.yml如下所示：

```
version: '2'
services:
  web:
    build: .
    ports:
      - "8000:8000"
  db:
    image: postgres
复制代码
```

当我们运行docker-compose up时，将会执行以下几步：

- 创建一个名为myapp_default的网络；
- 使用web服务的配置创建容器，它以“web”这个名称加入网络myapp_default；
- 使用db服务的配置创建容器，它以“db”这个名称加入网络myapp_default。

容器间可使用服务名称（web或db）作为hostname相互访问。例如，web这个服务可使用`postgres://db:5432` 访问db容器。

### 更新容器

当服务的配置发生更改时，可使用docker-compose up命令更新配置。

此时，Compose会删除旧容器并创建新容器。新容器会以不同的IP地址加入网络，名称保持不变。任何指向旧容器的连接都会被关闭，容器会重新找到新容器并连接上去。

### links

前文讲过，默认情况下，服务之间可使用服务名称相互访问。links允许我们定义一个别名，从而使用该别名访问其他服务。举个例子：

```
version: '2'
services:
  web:
    build: .
    links:
      - "db:database"
  db:
    image: postgres
复制代码
```

这样web服务就可使用db或database作为hostname访问db服务了。

### 指定自定义网络

一些场景下，默认的网络配置满足不了我们的需求，此时我们可使用networks命令自定义网络。networks命令允许我们创建更加复杂的网络拓扑并指定自定义网络驱动和选项。不仅如此，我们还可使用networks将服务连接到不是由Compose管理的、外部创建的网络。

如下，我们在其中定义了两个自定义网络。

```
version: '2'

services:
  proxy:
    build: ./proxy
    networks:
      - front
  app:
    build: ./app
    networks:
      - front
      - back
  db:
    image: postgres
    networks:
      - back

networks:
  front:
    # Use a custom driver
    driver: custom-driver-1
  back:
    # Use a custom driver which takes special options
    driver: custom-driver-2
    driver_opts:
      foo: "1"
      bar: "2"
复制代码
```

其中，proxy服务与db服务隔离，两者分别使用自己的网络；app服务可与两者通信。

由本例不难发现，使用networks命令，即可方便实现服务间的网络隔离与连接。

### 配置默认网络

除自定义网络外，我们也可为默认网络自定义配置。

```
version: '2'

services:
  web:
    build: .
    ports:
      - "8000:8000"
  db:
    image: postgres

networks:
  default:
    # Use a custom driver
    driver: custom-driver-1
复制代码
```

这样，就可为该应用指定自定义的网络驱动。

### 使用已存在的网络

一些场景下，我们并不需要创建新的网络，而只需加入已存在的网络，此时可使用external选项。示例：

```
networks:
  default:
    external:
      name: my-pre-existing-network复制代码
```

### Docker Compose 链接外部容器的几种方式

在Docker中，容器之间的链接是一种很常见的操作：它提供了访问其中的某个容器的网络服务而不需要将所需的端口暴露给Docker Host主机的功能。Docker Compose中对该特性的支持同样是很方便的。然而，如果需要链接的容器没有定义在同一个`docker-compose.yml`中的时候，这个时候就稍微麻烦复杂了点。

在不使用Docker Compose的时候，将两个容器链接起来使用`—link`参数，相对来说比较简单，以`nginx`镜像为例子：

```
docker run --rm --name test1 -d nginx  #开启一个实例test1
docker run --rm --name test2 --link test1 -d nginx #开启一个实例test2并与test1建立链接
复制代码
```

这样，`test2`与`test1`便建立了链接，就可以在`test2`中使用访问`test1`中的服务了。

如果使用Docker Compose，那么这个事情就更简单了，还是以上面的`nginx`镜像为例子，编辑`docker-compose.yml`文件为：

```
version: "3"
services:
  test2:
    image: nginx
    depends_on:
      - test1
    links:
      - test1
  test1:
    image: nginx
复制代码
```



最终效果与使用普通的Docker命令`docker run xxxx`建立的链接并无区别。这只是一种最为理想的情况。

1. 如果容器没有定义在同一个`docker-compose.yml`文件中，应该如何链接它们呢？
2. 又如果定义在`docker-compose.yml`文件中的容器需要与`docker run xxx`启动的容器链接，需要如何处理？

针对这两种典型的情况，下面给出我个人测试可行的办法：

### 方式一：让需要链接的容器同属一个外部网络

我们还是使用nginx镜像来模拟这样的一个情景：假设我们需要将两个使用Docker Compose管理的nignx容器（`test1`和`test2`）链接起来，使得`test2`能够访问`test1`中提供的服务，这里我们以能ping通为准。

首先，我们定义容器`test1`的`docker-compose.yml`文件内容为：

```
version: "3"
services:
  test2:
    image: nginx
    container_name: test1
    networks:
      - default
      - app_net
networks:
  app_net:
    external: true
复制代码
```

容器`test2`内容与`test1`基本一样，只是多了一个`external_links`,需要特别说明的是：**最近发布的Docker版本已经不需要使用external_links来链接容器，容器的DNS服务可以正确的作出判断**，因此如果你你需要兼容较老版本的Docker的话，那么容器`test2`的`docker-compose.yml`文件内容为：

```
version: "3"
services:
  test2:
    image: nginx
    networks:
      - default
      - app_net
    external_links:
      - test1
    container_name: test2
networks:
  app_net:
    external: true复制代码
```



否则的话，`test2`的`docker-compose.yml`和`test1`的定义完全一致，不需要额外多指定一个`external_links`。相关的问题请参见stackoverflow上的相关问题：[docker-compose + external container](https://link.juejin.cn?target=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F39067295%2Fdocker-compose-external-container)

正如你看到的那样，这里两个容器的定义里都使用了同一个外部网络`app_net`,因此，我们需要在启动这两个容器之前通过以下命令再创建外部网络：

```
docker network create app_net复制代码
```



之后，通过`docker-compose up -d`命令启动这两个容器，然后执行`docker exec -it test2 ping test1`,你将会看到如下的输出：



```
docker exec -it test2 ping test1
PING test1 (172.18.0.2): 56 data bytes
64 bytes from 172.18.0.2: icmp_seq=0 ttl=64 time=0.091 ms
64 bytes from 172.18.0.2: icmp_seq=1 ttl=64 time=0.146 ms
64 bytes from 172.18.0.2: icmp_seq=2 ttl=64 time=0.150 ms
64 bytes from 172.18.0.2: icmp_seq=3 ttl=64 time=0.145 ms
64 bytes from 172.18.0.2: icmp_seq=4 ttl=64 time=0.126 ms
64 bytes from 172.18.0.2: icmp_seq=5 ttl=64 time=0.147 ms
复制代码
```

证明这两个容器是成功链接了，反过来在`test1`中ping`test2`也是能够正常ping通的。

如果我们通过`docker run --rm --name test3 -d nginx`这种方式来先启动了一个容器(`test3`)并且没有指定它所属的外部网络，而需要将其与`test1`或者`test2`链接的话，这个时候手动链接外部网络即可：

```
docker network connect app_net test3复制代码
```



这样，三个容器都可以相互访问了。

### 方式二：更改需要链接的容器的网络模式

通过更改你想要相互链接的容器的网络模式为`bridge`,并指定需要链接的外部容器（`external_links`)即可。与同属外部网络的容器可以相互访问的链接方式一不同，这种方式的访问是单向的。

还是以nginx容器镜像为例子，如果容器实例`nginx1`需要访问容器实例`nginx2`，那么`nginx2`的`doker-compose.yml`定义为：

```
version: "3"
services:
  nginx2:
    image: nginx
    container_name: nginx2
    network_mode: bridge
复制代码
```

与其对应的，`nginx1`的`docker-compose.yml`定义为：

```
version: "3"
services:
  nginx1:
    image: nginx
    external_links:
      - nginx2
    container_name: nginx1
    network_mode: bridge
复制代码
```





> 需要特别说明的是，这里的`external_links`是不能省略的，而且`nginx1`的启动必须要在`nginx2`之后，否则可能会报找不到容器`nginx2`的错误。

接着我们使用ping来测试下连通性：







```
$ docker exec -it nginx1 ping nginx2  # nginx1 to nginx2
PING nginx2 (172.17.0.4): 56 data bytes
64 bytes from 172.17.0.4: icmp_seq=0 ttl=64 time=0.141 ms
64 bytes from 172.17.0.4: icmp_seq=1 ttl=64 time=0.139 ms
64 bytes from 172.17.0.4: icmp_seq=2 ttl=64 time=0.145 ms

$ docker exec -it nginx2 ping nginx1 #nginx2 to nginx1
ping: unknown host复制代码
```

以上也能充分证明这种方式是属于单向联通的。

在实际应用中根据自己的需要灵活的选择这两种链接方式，如果想偷懒的话，大可选择第二种。不过我更推荐第一种，不难看出无论是联通性还是灵活性，较为更改网络模式的第二种都更为友好。

附docker-compose.yml文件详解

```
Compose和Docker兼容性：
    Compose 文件格式有3个版本,分别为1, 2.x 和 3.x
    目前主流的为 3.x 其支持 docker 1.13.0 及其以上的版本

常用参数：
    version           # 指定 compose 文件的版本
    services          # 定义所有的 service 信息, services 下面的第一级别的 key 既是一个 service 的名称

        build                 # 指定包含构建上下文的路径, 或作为一个对象，该对象具有 context 和指定的 dockerfile 文件以及 args 参数值
            context               # context: 指定 Dockerfile 文件所在的路径
            dockerfile            # dockerfile: 指定 context 指定的目录下面的 Dockerfile 的名称(默认为 Dockerfile)
            args                  # args: Dockerfile 在 build 过程中需要的参数 (等同于 docker container build --build-arg 的作用)
            cache_from            # v3.2中新增的参数, 指定缓存的镜像列表 (等同于 docker container build --cache_from 的作用)
            labels                # v3.3中新增的参数, 设置镜像的元数据 (等同于 docker container build --labels 的作用)
            shm_size              # v3.5中新增的参数, 设置容器 /dev/shm 分区的大小 (等同于 docker container build --shm-size 的作用)

        command               # 覆盖容器启动后默认执行的命令, 支持 shell 格式和 [] 格式

        configs               # 不知道怎么用

        cgroup_parent         # 不知道怎么用

        container_name        # 指定容器的名称 (等同于 docker run --name 的作用)

        credential_spec       # 不知道怎么用

        deploy                # v3 版本以上, 指定与部署和运行服务相关的配置, deploy 部分是 docker stack 使用的, docker stack 依赖 docker swarm
            endpoint_mode         # v3.3 版本中新增的功能, 指定服务暴露的方式
                vip                   # Docker 为该服务分配了一个虚拟 IP(VIP), 作为客户端的访问服务的地址
                dnsrr                 # DNS轮询, Docker 为该服务设置 DNS 条目, 使得服务名称的 DNS 查询返回一个 IP 地址列表, 客户端直接访问其中的一个地址
            labels                # 指定服务的标签，这些标签仅在服务上设置
            mode                  # 指定 deploy 的模式
                global                # 每个集群节点都只有一个容器
                replicated            # 用户可以指定集群中容器的数量(默认)
            placement             # 不知道怎么用
            replicas              # deploy 的 mode 为 replicated 时, 指定容器副本的数量
            resources             # 资源限制
                limits                # 设置容器的资源限制
                    cpus: "0.5"           # 设置该容器最多只能使用 50% 的 CPU 
                    memory: 50M           # 设置该容器最多只能使用 50M 的内存空间 
                reservations          # 设置为容器预留的系统资源(随时可用)
                    cpus: "0.2"           # 为该容器保留 20% 的 CPU
                    memory: 20M           # 为该容器保留 20M 的内存空间
            restart_policy        # 定义容器重启策略, 用于代替 restart 参数
                condition             # 定义容器重启策略(接受三个参数)
                    none                  # 不尝试重启
                    on-failure            # 只有当容器内部应用程序出现问题才会重启
                    any                   # 无论如何都会尝试重启(默认)
                delay                 # 尝试重启的间隔时间(默认为 0s)
                max_attempts          # 尝试重启次数(默认一直尝试重启)
                window                # 检查重启是否成功之前的等待时间(即如果容器启动了, 隔多少秒之后去检测容器是否正常, 默认 0s)
            update_config         # 用于配置滚动更新配置
                parallelism           # 一次性更新的容器数量
                delay                 # 更新一组容器之间的间隔时间
                failure_action        # 定义更新失败的策略
                    continue              # 继续更新
                    rollback              # 回滚更新
                    pause                 # 暂停更新(默认)
                monitor               # 每次更新后的持续时间以监视更新是否失败(单位: ns|us|ms|s|m|h) (默认为0)
                max_failure_ratio     # 回滚期间容忍的失败率(默认值为0)
                order                 # v3.4 版本中新增的参数, 回滚期间的操作顺序
                    stop-first            #旧任务在启动新任务之前停止(默认)
                    start-first           #首先启动新任务, 并且正在运行的任务暂时重叠
            rollback_config       # v3.7 版本中新增的参数, 用于定义在 update_config 更新失败的回滚策略
                parallelism           # 一次回滚的容器数, 如果设置为0, 则所有容器同时回滚
                delay                 # 每个组回滚之间的时间间隔(默认为0)
                failure_action        # 定义回滚失败的策略
                    continue              # 继续回滚
                    pause                 # 暂停回滚
                monitor               # 每次回滚任务后的持续时间以监视失败(单位: ns|us|ms|s|m|h) (默认为0)
                max_failure_ratio     # 回滚期间容忍的失败率(默认值0)
                order                 # 回滚期间的操作顺序
                    stop-first            # 旧任务在启动新任务之前停止(默认)
                    start-first           # 首先启动新任务, 并且正在运行的任务暂时重叠

            注意：
                支持 docker-compose up 和 docker-compose run 但不支持 docker stack deploy 的子选项
                security_opt  container_name  devices  tmpfs  stop_signal  links    cgroup_parent
                network_mode  external_links  restart  build  userns_mode  sysctls

        devices               # 指定设备映射列表 (等同于 docker run --device 的作用)

        depends_on            # 定义容器启动顺序 (此选项解决了容器之间的依赖关系， 此选项在 v3 版本中 使用 swarm 部署时将忽略该选项)
            示例：
                docker-compose up 以依赖顺序启动服务，下面例子中 redis 和 db 服务在 web 启动前启动
                默认情况下使用 docker-compose up web 这样的方式启动 web 服务时，也会启动 redis 和 db 两个服务，因为在配置文件中定义了依赖关系
                version: '3'
                services:
                    web:
                        build: .
                        depends_on:
                            - db      
                            - redis  
                    redis:
                        image: redis
                    db:
                        image: postgres                             

        dns                   # 设置 DNS 地址(等同于 docker run --dns 的作用)

        dns_search            # 设置 DNS 搜索域(等同于 docker run --dns-search 的作用)

        tmpfs                 # v2 版本以上, 挂载目录到容器中, 作为容器的临时文件系统(等同于 docker run --tmpfs 的作用, 在使用 swarm 部署时将忽略该选项)

        entrypoint            # 覆盖容器的默认 entrypoint 指令 (等同于 docker run --entrypoint 的作用)

        env_file              # 从指定文件中读取变量设置为容器中的环境变量, 可以是单个值或者一个文件列表, 如果多个文件中的变量重名则后面的变量覆盖前面的变量, environment 的值覆盖 env_file 的值
            文件格式：
                RACK_ENV=development 

        environment           # 设置环境变量， environment 的值可以覆盖 env_file 的值 (等同于 docker run --env 的作用)

        expose                # 暴露端口, 但是不能和宿主机建立映射关系, 类似于 Dockerfile 的 EXPOSE 指令

        external_links        # 连接不在 docker-compose.yml 中定义的容器或者不在 compose 管理的容器(docker run 启动的容器, 在 v3 版本中使用 swarm 部署时将忽略该选项)

        extra_hosts           # 添加 host 记录到容器中的 /etc/hosts 中 (等同于 docker run --add-host 的作用)

        healthcheck           # v2.1 以上版本, 定义容器健康状态检查, 类似于 Dockerfile 的 HEALTHCHECK 指令
            test                  # 检查容器检查状态的命令, 该选项必须是一个字符串或者列表, 第一项必须是 NONE, CMD 或 CMD-SHELL, 如果其是一个字符串则相当于 CMD-SHELL 加该字符串
                NONE                  # 禁用容器的健康状态检测
                CMD                   # test: ["CMD", "curl", "-f", "http://localhost"]
                CMD-SHELL             # test: ["CMD-SHELL", "curl -f http://localhost || exit 1"] 或者　test: curl -f https://localhost || exit 1
            interval: 1m30s       # 每次检查之间的间隔时间
            timeout: 10s          # 运行命令的超时时间
            retries: 3            # 重试次数
            start_period: 40s     # v3.4 以上新增的选项, 定义容器启动时间间隔
            disable: true         # true 或 false, 表示是否禁用健康状态检测和　test: NONE 相同

        image                 # 指定 docker 镜像, 可以是远程仓库镜像、本地镜像

        init                  # v3.7 中新增的参数, true 或 false 表示是否在容器中运行一个 init, 它接收信号并传递给进程

        isolation             # 隔离容器技术, 在 Linux 中仅支持 default 值

        labels                # 使用 Docker 标签将元数据添加到容器, 与 Dockerfile 中的 LABELS 类似

        links                 # 链接到其它服务中的容器, 该选项是 docker 历史遗留的选项, 目前已被用户自定义网络名称空间取代, 最终有可能被废弃 (在使用 swarm 部署时将忽略该选项)

        logging               # 设置容器日志服务
            driver                # 指定日志记录驱动程序, 默认 json-file (等同于 docker run --log-driver 的作用)
            options               # 指定日志的相关参数 (等同于 docker run --log-opt 的作用)
                max-size              # 设置单个日志文件的大小, 当到达这个值后会进行日志滚动操作
                max-file              # 日志文件保留的数量

        network_mode          # 指定网络模式 (等同于 docker run --net 的作用, 在使用 swarm 部署时将忽略该选项)         

        networks              # 将容器加入指定网络 (等同于 docker network connect 的作用), networks 可以位于 compose 文件顶级键和 services 键的二级键
            aliases               # 同一网络上的容器可以使用服务名称或别名连接到其中一个服务的容器
            ipv4_address      # IP V4 格式
            ipv6_address      # IP V6 格式

            示例:
                version: '3.7'
                services: 
                    test: 
                        image: nginx:1.14-alpine
                        container_name: mynginx
                        command: ifconfig
                        networks: 
                            app_net:                                # 调用下面 networks 定义的 app_net 网络
                            ipv4_address: 172.16.238.10
                networks:
                    app_net:
                        driver: bridge
                        ipam:
                            driver: default
                            config:
                                - subnet: 172.16.238.0/24

        pid: 'host'           # 共享宿主机的 进程空间(PID)

        ports                 # 建立宿主机和容器之间的端口映射关系, ports 支持两种语法格式
            SHORT 语法格式示例:
                - "3000"                            # 暴露容器的 3000 端口, 宿主机的端口由 docker 随机映射一个没有被占用的端口
                - "3000-3005"                       # 暴露容器的 3000 到 3005 端口, 宿主机的端口由 docker 随机映射没有被占用的端口
                - "8000:8000"                       # 容器的 8000 端口和宿主机的 8000 端口建立映射关系
                - "9090-9091:8080-8081"
                - "127.0.0.1:8001:8001"             # 指定映射宿主机的指定地址的
                - "127.0.0.1:5000-5010:5000-5010"   
                - "6060:6060/udp"                   # 指定协议

            LONG 语法格式示例:(v3.2 新增的语法格式)
                ports:
                    - target: 80                    # 容器端口
                      published: 8080               # 宿主机端口
                      protocol: tcp                 # 协议类型
                      mode: host                    # host 在每个节点上发布主机端口,  ingress 对于群模式端口进行负载均衡

        secrets               # 不知道怎么用

        security_opt          # 为每个容器覆盖默认的标签 (在使用 swarm 部署时将忽略该选项)

        stop_grace_period     # 指定在发送了 SIGTERM 信号之后, 容器等待多少秒之后退出(默认 10s)

        stop_signal           # 指定停止容器发送的信号 (默认为 SIGTERM 相当于 kill PID; SIGKILL 相当于 kill -9 PID; 在使用 swarm 部署时将忽略该选项)

        sysctls               # 设置容器中的内核参数 (在使用 swarm 部署时将忽略该选项)

        ulimits               # 设置容器的 limit

        userns_mode           # 如果Docker守护程序配置了用户名称空间, 则禁用此服务的用户名称空间 (在使用 swarm 部署时将忽略该选项)

        volumes               # 定义容器和宿主机的卷映射关系, 其和 networks 一样可以位于 services 键的二级键和 compose 顶级键, 如果需要跨服务间使用则在顶级键定义, 在 services 中引用
            SHORT 语法格式示例:
                volumes:
                    - /var/lib/mysql                # 映射容器内的 /var/lib/mysql 到宿主机的一个随机目录中
                    - /opt/data:/var/lib/mysql      # 映射容器内的 /var/lib/mysql 到宿主机的 /opt/data
                    - ./cache:/tmp/cache            # 映射容器内的 /var/lib/mysql 到宿主机 compose 文件所在的位置
                    - ~/configs:/etc/configs/:ro    # 映射容器宿主机的目录到容器中去, 权限只读
                    - datavolume:/var/lib/mysql     # datavolume 为 volumes 顶级键定义的目录, 在此处直接调用

            LONG 语法格式示例:(v3.2 新增的语法格式)
                version: "3.2"
                services:
                    web:
                        image: nginx:alpine
                        ports:
                            - "80:80"
                        volumes:
                            - type: volume                  # mount 的类型, 必须是 bind、volume 或 tmpfs
                                source: mydata              # 宿主机目录
                                target: /data               # 容器目录
                                volume:                     # 配置额外的选项, 其 key 必须和 type 的值相同
                                    nocopy: true                # volume 额外的选项, 在创建卷时禁用从容器复制数据
                            - type: bind                    # volume 模式只指定容器路径即可, 宿主机路径随机生成; bind 需要指定容器和数据机的映射路径
                                source: ./static
                                target: /opt/app/static
                                read_only: true             # 设置文件系统为只读文件系统
                volumes:
                    mydata:                                 # 定义在 volume, 可在所有服务中调用

        restart               # 定义容器重启策略(在使用 swarm 部署时将忽略该选项, 在 swarm 使用 restart_policy 代替 restart)
            no                    # 禁止自动重启容器(默认)
            always                # 无论如何容器都会重启
            on-failure            # 当出现 on-failure 报错时, 容器重新启动

        其他选项：
            domainname, hostname, ipc, mac_address, privileged, read_only, shm_size, stdin_open, tty, user, working_dir
            上面这些选项都只接受单个值和 docker run 的对应参数类似

        对于值为时间的可接受的值：
            2.5s
            10s
            1m30s
            2h32m
            5h34m56s
            时间单位: us, ms, s, m， h
        对于值为大小的可接受的值：
            2b
            1024kb
            2048k
            300m
            1gb
            单位: b, k, m, g 或者 kb, mb, gb
    networks          # 定义 networks 信息
        driver                # 指定网络模式, 大多数情况下, 它 bridge 于单个主机和 overlay Swarm 上
            bridge                # Docker 默认使用 bridge 连接单个主机上的网络
            overlay               # overlay 驱动程序创建一个跨多个节点命名的网络
            host                  # 共享主机网络名称空间(等同于 docker run --net=host)
            none                  # 等同于 docker run --net=none
        driver_opts           # v3.2以上版本, 传递给驱动程序的参数, 这些参数取决于驱动程序
        attachable            # driver 为 overlay 时使用, 如果设置为 true 则除了服务之外，独立容器也可以附加到该网络; 如果独立容器连接到该网络，则它可以与其他 Docker 守护进程连接到的该网络的服务和独立容器进行通信
        ipam                  # 自定义 IPAM 配置. 这是一个具有多个属性的对象, 每个属性都是可选的
            driver                # IPAM 驱动程序, bridge 或者 default
            config                # 配置项
                subnet                # CIDR格式的子网，表示该网络的网段
        external              # 外部网络, 如果设置为 true 则 docker-compose up 不会尝试创建它, 如果它不存在则引发错误
        name                  # v3.5 以上版本, 为此网络设置名称
文件格式示例：
    version: "3"
    services:
      redis:
        image: redis:alpine
        ports:
          - "6379"
        networks:
          - frontend
        deploy:
          replicas: 2
          update_config:
            parallelism: 2
            delay: 10s
          restart_policy:
            condition: on-failure
      db:
        image: postgres:9.4
        volumes:
          - db-data:/var/lib/postgresql/data
        networks:
          - backend
        deploy:
          placement:
            constraints: [node.role == manager]复制代码
```


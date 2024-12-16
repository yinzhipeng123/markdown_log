# pipeline示例



Jenkins服务器本地需部署Registry



```yaml
pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "localhost:5000"  // 本地 Docker Registry 地址
        DOCKER_IMAGE_NAME = "hello-container"  // 镜像名称
        GIT_REPO = "https://github.com/yinzhipeng123/kafka_demo.git"  // GitHub 项目地址
        DOCKER_USERNAME = "myuser"  // 本地 Docker Registry 用户名
        DOCKER_PASSWORD = "ganxie123!"  // 本地 Docker Registry 密码
    }
    
    stages {
        stage('Checkout') {
            steps {
                // 拉取 GitHub 项目
                git url: "${GIT_REPO}", branch: 'main'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // 创建 Dockerfile
                    sh '''
                    echo "FROM python:3.9-slim" > Dockerfile
                    echo "COPY hello.py /app/hello.py" >> Dockerfile
                    echo "CMD python -u /app/hello.py" >> Dockerfile
                    '''
                    // 构建 Docker 镜像
                    sh "docker build -t ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:latest ."
                }
            }
        }
        
        stage('Login to Docker Registry') {
            steps {
                script {
                    // 登录到本地 Docker Registry
                    sh "echo ${DOCKER_PASSWORD} | docker login ${DOCKER_REGISTRY} -u ${DOCKER_USERNAME} --password-stdin"
                }
            }
        }
        
        stage('Push to Local Registry') {
            steps {
                script {
                    // 推送 Docker 镜像到本地 Docker Registry
                    sh "docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:latest"
                }
            }
        }
        
        stage('Run Container') {
            steps {
                script {
                    // 启动容器并确保它持续输出 hello.py 的结果
                    sh "docker run -d --rm ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:latest"
                }
            }
        }
    }
}

```



![image-20241216132521303](https://s2.loli.net/2024/12/16/nYPc8ZjC3apNvIE.png)



结果：

```bash
[root@VM-0-16-centos ~]# docker ps
CONTAINER ID   IMAGE                                   COMMAND                  CREATED          STATUS          PORTS                                       NAMES
51b9deccbdf7   localhost:5000/hello-container:latest   "/bin/sh -c 'python …"   58 minutes ago   Up 58 minutes                                               nifty_golick

[root@VM-0-16-centos ~]# docker logs  51b9deccbdf7
2024-12-16 04:26:14 Hello
2024-12-16 04:26:16 Hello
2024-12-16 04:26:18 Hello
2024-12-16 04:26:20 Hello
2024-12-16 04:26:22 Hello
```





也可以把pipeline脚本命名为Jenkinsfile文件，放置到git上，流水线中选择从SCM中获取，填写Github地址，流水线会自动读取Jenkinsfile文件
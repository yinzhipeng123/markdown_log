**Pipeline** 在 Jenkins 中是指一组自动化的构建、测试、部署等任务的流程，通常用于实现持续集成（CI）和持续交付（CD）。它通过将这些任务定义为代码，提供了更灵活、可控、可扩展的 CI/CD 流程。Pipeline 可以视为软件开发生命周期中所有自动化步骤的流水线，确保每次提交代码时都会经历相同的构建、测试、部署过程。

### Pipeline 的基本特点

- [ ] **自动化流程**：Pipeline 是通过自动化脚本来管理构建、测试、部署等过程，确保持续一致地完成工作。
- [ ] **代码化配置**：Pipeline 的配置通常通过一个叫做 **Jenkinsfile** 的文件来定义，这个文件存储在项目的代码仓库中，使得整个流程配置可版本化、可复用。
- [ ] **灵活性**：可以定义各种不同的流程，支持并行化执行、多环境部署等复杂场景。
- [ ] **可追溯性**：每个 Pipeline 的执行都会有日志，可以追溯和查看执行情况，帮助快速定位问题。



Jenkins Pipeline 语法有两种主要风格：**声明式 Pipeline（Declarative Pipeline）** 和 **脚本式 Pipeline（Scripted Pipeline）**。它们的语法结构有所不同，下面将详细介绍两者的语法。

### 1. **声明式 Pipeline（Declarative Pipeline）语法**

声明式 Pipeline 语法提供了一个结构化且易于理解的方式来定义流水线，通常适用于大多数常见的 CI/CD 流程。其语法更加规范和简洁。

#### 基本结构：

```groovy
pipeline {
    agent any  // 指定构建在哪个节点上，可以是 any（任何可用节点）

    environment { 
        // 定义环境变量
    }

    stages {
        // 每个 stage 定义一个阶段，包含多个 steps
        stage('Stage Name') {
            steps {
                // 在此阶段要执行的操作
            }
        }
    }

    post {
        // 后置操作，用于构建后的一些操作
    }
}
```

#### 例子：声明式 Pipeline 示例

```groovy
pipeline {
    agent any  // 在任意可用节点上运行流水线

    environment {
        MY_ENV_VAR = 'value'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-repo/your-project.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker-compose up -d'
            }
        }
    }

    post {
        always {
            cleanWs()  // 清理工作区
        }
        success {
            echo '构建成功!'
        }
        failure {
            echo '构建失败!'
        }
    }
}
```

#### 关键字段：

- [ ] **agent**：指定流水线在哪个节点上运行。`any` 表示在任何可用节点上运行。
- [ ] **stages**：包含多个 `stage`，每个 `stage` 表示一个独立的阶段，例如代码检出、构建、测试、部署等。
- [ ] **steps**：每个 `stage` 中的操作步骤，定义了要执行的具体任务。
- [ ] **post**：用于流水线执行后的操作，可以用于发送通知、清理工作空间等。

------

### 2. **脚本式 Pipeline（Scripted Pipeline）语法**

脚本式 Pipeline 更加灵活，基于 **Groovy** 脚本来编写，适合处理更复杂的 CI/CD 流程。脚本式 Pipeline 允许你编写任意的 Groovy 脚本，以获得更强的控制能力。

#### 基本结构：

```groovy
node {
    // 工作节点
    stage('Stage Name') {
        // 执行步骤
        sh 'command'
    }
}
```

#### 例子：脚本式 Pipeline 示例

```groovy
node {
    stage('Checkout') {
        // 拉取代码
        git 'https://github.com/your-repo/your-project.git'
    }

    stage('Build') {
        // 构建项目
        sh 'mvn clean install'
    }

    stage('Test') {
        // 运行单元测试
        sh 'mvn test'
    }

    stage('Deploy') {
        // 部署应用
        sh 'docker-compose up -d'
    }
}
```

#### 关键字段：

- [ ] **node**：指定流水线在哪个节点上运行，通常是 Jenkins 中的构建代理节点。
- [ ] **stage**：每个阶段的定义，包含具体的操作步骤。
- [ ] **sh**：执行 Shell 命令的步骤，例如 `sh 'mvn clean install'` 用于执行 Maven 构建命令。

### 3. **比较：声明式 Pipeline vs 脚本式 Pipeline**

| 特性           | **声明式 Pipeline**                     | **脚本式 Pipeline**                          |
| -------------- | --------------------------------------- | -------------------------------------------- |
| **语法**       | 简洁且结构化，易于理解和维护            | 更加灵活，可以编写任意的 Groovy 脚本         |
| **适用场景**   | 适用于大多数简单和中等复杂的 CI/CD 流程 | 适用于复杂的工作流和自定义流程               |
| **灵活性**     | 较低，适合标准化流程                    | 高，可以灵活控制流程的每个环节               |
| **易于维护**   | 高，结构化的方式便于维护和扩展          | 较低，代码量大时，复杂度高                   |
| **错误处理**   | 内置错误处理，如 `post` 部分            | 需要手动编写错误处理逻辑                     |
| **代码复用性** | 较低，所有定义都集中在一个地方          | 可以通过自定义函数和共享库提高复用性         |
| **学习曲线**   | 低，容易入门                            | 高，掌握 Groovy 脚本语言需要一定的时间和经验 |

### 4. **声明式 Pipeline 的高级特性**

除了基本语法，声明式 Pipeline 还支持一些高级特性：

- **并行执行（Parallel Execution）**： 在多个 `stage` 中并行执行任务，减少构建时间。

  ```groovy
  pipeline {
      agent any
      stages {
          stage('Parallel Stage') {
              parallel {
                  stage('Task 1') {
                      steps {
                          sh 'echo Task 1'
                      }
                  }
                  stage('Task 2') {
                      steps {
                          sh 'echo Task 2'
                      }
                  }
              }
          }
      }
  }
  ```

- **输入操作（Input Step）**： 在流水线执行过程中暂停并等待用户输入。

  ```groovy
  pipeline {
      agent any
      stages {
          stage('Approval') {
              steps {
                  input message: 'Approve Deployment?', ok: 'Deploy'
              }
          }
          stage('Deploy') {
              steps {
                  sh 'echo Deploying application'
              }
          }
      }
  }
  ```

- **条件执行（Conditional Execution）**： 基于条件决定是否执行某个阶段。

  ```groovy
  pipeline {
      agent any
      stages {
          stage('Build') {
              when {
                  branch 'main'
              }
              steps {
                  sh 'mvn clean install'
              }
          }
      }
  }
  ```

### 5. **共享库（Shared Libraries）**

Jenkins 支持使用共享库来复用代码，尤其适用于多个项目间共享流水线逻辑。可以将公共的 Groovy 脚本或函数提取到单独的 Git 仓库中，然后在多个流水线中引用。

#### 示例：引用共享库

```groovy
@Library('my-shared-library') _
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                mySharedBuildFunction()
            }
        }
    }
}
```

### 总结

- [ ] **声明式 Pipeline** 是用于定义常见 CI/CD 流程的简洁、结构化的方式，适合大多数使用场景。
- [ ] **脚本式 Pipeline** 提供了更大的灵活性，可以自定义复杂的流程，但相对复杂，需要更高的 Groovy 编程技能。
- [ ] Jenkins 通过支持声明式和脚本式两种方式，使得用户可以根据项目的需求选择合适的方式来定义 CI/CD 流程。
Jenkins插件

![image-20241216120257972](https://s2.loli.net/2024/12/16/1c5MXETDdeNKxGn.png)

配置服务器地址，账号密码

![image-20241216120406893](https://s2.loli.net/2024/12/16/trVPukxDGAKBQIi.png)





通过 **Jenkins Pipeline Linter** 服务进行验证，主要检查 **声明式 Pipeline** 配置是否符合 Jenkins 的语法规范，确保 Jenkinsfile 可以被 Jenkins 正确解析和执行。

### 主要功能限制：

- [ ] **仅支持声明式 Pipeline**，不支持脚本式 Pipeline。
- [ ] **语法验证**，不会执行 Jenkinsfile，也不会检查实际的任务执行情况。
- [ ] 如果 Jenkinsfile 中存在语法错误或不符合声明式规范，会直接标出错误位置。

它是一个 **静态验证工具**，适用于开发阶段确保 Jenkinsfile 的正确性，而不会触发实际的流水线运行。
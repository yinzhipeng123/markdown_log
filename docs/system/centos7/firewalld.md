在 CentOS 7 中，防火墙使用 **firewalld** 服务来管理。你可以通过命令行工具 `firewall-cmd` 来配置防火墙规则。以下是详细的配置方法和规则讲解。

---

### **1. firewalld 基础概念**
- **Zone（区域）**：定义了不同的信任级别，网络接口绑定到某个区域后，应用该区域的规则。
- **Service（服务）**：预定义的服务（如 http、https、ssh）规则。
- **Port（端口）**：直接开放或关闭特定端口。
- **Permanent（永久规则）**：需要明确指定 `--permanent` 参数，否则规则仅在当前运行时有效。

---

### **2. firewalld 常用命令**
#### **启动与状态管理**
```bash
# 启动 firewalld 服务
systemctl start firewalld

# 设置开机自启动
systemctl enable firewalld

# 查看 firewalld 服务状态
systemctl status firewalld

# 停止 firewalld 服务（如果需要关闭防火墙）
systemctl stop firewalld
```

#### **基本命令**
```bash
# 查看默认区域
firewall-cmd --get-default-zone

# 查看所有区域
firewall-cmd --get-zones

# 查看当前活动区域及绑定的接口
firewall-cmd --get-active-zones

# 查看区域内的规则
firewall-cmd --zone=public --list-all
```

#### **动态添加规则（临时规则，重启后失效）**
```bash
# 开放端口
firewall-cmd --zone=public --add-port=8080/tcp

# 开放服务（如 http）
firewall-cmd --zone=public --add-service=http

# 删除开放的端口
firewall-cmd --zone=public --remove-port=8080/tcp

# 重载防火墙配置
firewall-cmd --reload
```

#### **永久添加规则**
```bash
# 开放端口（永久规则）
firewall-cmd --zone=public --add-port=8080/tcp --permanent

# 开放服务（永久规则）
firewall-cmd --zone=public --add-service=http --permanent

# 删除永久规则
firewall-cmd --zone=public --remove-port=8080/tcp --permanent

# 重载防火墙配置（永久规则生效必须重载）
firewall-cmd --reload
```

---

### **3. 防火墙规则说明**
#### **区域规则**
- CentOS 7 的 `firewalld` 默认区域是 **public**，适用于大多数场景。
- 可以根据网络安全需求自定义不同的区域，例如：**trusted**（完全信任），**block**（完全拒绝）。

#### **服务规则**
- `firewalld` 内置了一些常见的服务，可以通过以下命令查看支持的服务：
```bash
firewall-cmd --get-services
```
- 添加服务时，firewalld 会根据 `/usr/lib/firewalld/services/` 中的配置文件应用规则。

#### **端口规则**
- **协议**：firewalld 支持 **tcp** 和 **udp** 两种协议。
- **端口范围**：可以直接开放端口范围，例如：
```bash
firewall-cmd --zone=public --add-port=5000-5100/tcp --permanent
```

#### **源地址规则**
- 可指定来源 IP 地址允许访问：
```bash
firewall-cmd --zone=public --add-source=192.168.1.100 --permanent
```

#### **富规则（Rich Rules）**
- 富规则提供了更高的灵活性，例如控制特定 IP 对特定端口的访问：
```bash
firewall-cmd --zone=public --add-rich-rule="rule family=ipv4 source address=192.168.1.100 port port=22 protocol=tcp accept" --permanent
```

---

### **4. 完整配置示例**
#### **场景**：开放 HTTP 服务（80端口）和自定义端口（8080），限制某 IP 访问 SSH（22端口）。
```bash
# 开放 HTTP 服务
firewall-cmd --zone=public --add-service=http --permanent

# 开放自定义端口
firewall-cmd --zone=public --add-port=8080/tcp --permanent

# 禁止特定 IP 访问 SSH
firewall-cmd --zone=public --add-rich-rule="rule family=ipv4 source address=192.168.1.100 port port=22 protocol=tcp drop" --permanent

# 重载规则
firewall-cmd --reload

# 查看规则
firewall-cmd --zone=public --list-all
```

---

### **5. 防火墙规则文件手动修改**
firewalld 的规则保存在 `/etc/firewalld/` 目录中：
- `zones/` 文件夹包含区域规则的 XML 配置文件。
- 修改这些文件后，重启 firewalld 生效：
```bash
systemctl restart firewalld
```


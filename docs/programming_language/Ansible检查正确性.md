在编写 Ansible playbook 或剧本时，可以使用以下命令来检查其正确性：

1. **`ansible-playbook --syntax-check`**
    这是检查 Ansible playbook 语法是否正确的最常用命令。它会检查 playbook 中的 YAML 语法、模块调用和其他语法错误，但不会执行任何任务。

   ```bash
   ansible-playbook your-playbook.yml --syntax-check
   ```

2. **`ansible-lint`**
    `ansible-lint` 是一个专门用于检查 Ansible playbook 编写规范的工具。它会检查代码风格、最佳实践和常见错误。要使用它，你首先需要安装 `ansible-lint`：

   ```bash
   pip install ansible-lint
   ```

   然后使用命令来检查 playbook：

   ```bash
   ansible-lint your-playbook.yml
   ```

3. **`ansible-playbook --check`**
    这是一个“干运行”命令，它会执行 playbook 中的所有任务，但不会对目标主机做出实际更改。这对于确认任务将会执行什么操作很有帮助，而不会对系统产生副作用。

   ```bash
   ansible-playbook your-playbook.yml --check
   ```

4. **`ansible-playbook --diff`**
    如果你想查看 playbook 变更前后文件的差异，可以使用这个选项。这对于检查变更内容是否符合预期非常有用。

   ```bash
   ansible-playbook your-playbook.yml --diff
   ```

这些命令有助于在执行 playbook 之前检查其正确性和潜在问题。如果你是刚开始使用 Ansible，`--syntax-check` 和 `--check` 是最常用的检查手段。
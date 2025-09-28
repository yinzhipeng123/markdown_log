PyTorch 是一个 **开源深度学习框架**，主要用于 **构建和训练神经网络**。它由 Facebook（现在的 Meta）开发和维护，是目前深度学习领域最流行的工具之一。

------

### 1. PyTorch 是干什么的？

PyTorch 可以用来：

- **构建神经网络模型**
   例如卷积神经网络（CNN）、循环神经网络（RNN）、Transformer 等。
- **训练模型**
   通过“前向传播 → 计算损失 → 反向传播 → 更新参数”这个过程，让模型学习数据的规律。
- **做科研和原型开发**
   代码风格像 Python 自然语言，非常适合快速试验新的模型想法。
- **推理和部署**
   训练好的模型可以用于实际应用，例如图像识别、语音识别、推荐系统等。

------

### 2. PyTorch 的特点

1. **动态图机制（Dynamic Computation Graph）**
   - 模型计算图是运行时生成的，非常灵活。
   - 调试方便，像写普通 Python 代码一样直观。
2. **深度集成 GPU 支持**
   - 可以轻松使用 CUDA，在 GPU 上加速训练。
3. **丰富的生态**
   - 有 `torchvision`（图像）、`torchaudio`（音频）、`torchtext`（文本）等扩展库。
   - 有 PyTorch Lightning、KubeFlow、Hugging Face Transformers 等框架和工具的支持。
4. **Python 风格**
   - 学习成本低，科研和工程都适用。
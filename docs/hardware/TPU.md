

## 背景与定义

Tensor Processing Unit（TPU）是一种由谷歌专为神经网络机器学习设计的AI加速器应用专用集成电路（ASIC），与TensorFlow无缝集成，用于高效执行张量运算。TPU通过在硬件层面专门优化矩阵乘法操作，实现了在单个全局指令周期内完成256×256矩阵乘加的高吞吐量能力，内部集成65,536个乘法单元，极大提升了深度学习训练和推理的性能。

## 版本演进

截至2025年，TPU系列产品包括：

- **TPUv1**（2015年）：28 nm工艺，8 GiB DDR3内存，带宽34 GB/s；
- **TPUv2**（2017年）：16 nm工艺，16 GiB HBM内存，带宽600 GB/s；
- **TPUv3**（2018年）：16 nm工艺，32 GiB HBM内存，带宽900 GB/s；
- **TPUv4**（2021年）：7 nm工艺，32 GiB HBM内存，带宽1200 GB/s，单Pod可集成4096颗芯片；
- **TPUv5e/v5p**（2023年）；
- **TPUv6e（Trillium）**（2024年）；
- **TPUv7（Ironwood）**（2025年）。

## 架构与工作原理

TPU采用基于**systolic array**的流水线阵列架构，将大量的乘法累加单元沿阵列排列，通过数据流动（data flow）方式高效完成矩阵运算，极大减少内存访问瓶颈。此外，TPU针对低精度（8–16位）计算进行了专门优化，相比传统高精度硬件能以更低功耗达到更高的算力密度，特别适合深度神经网络的前向和反向传播。

## TPU与GPU的对比

相比GPU，TPU在设计时即针对张量乘法进行了硬件级定制，去除了GPU中的光栅化/纹理映射逻辑，以换取更多的算力资源和更高的功率效率。在AlphaGo与李世石对弈的案例中，TPU提供的吞吐量在严格7ms延迟限制下，比当时主流CPU和GPU高出15–30倍，显著提升了实时推理能力

## 应用场景

TPU广泛应用于大规模模型训练和推理，包括Google内部的Search、Photos、Translate、RankBrain，以及DeepMind的AlphaGo、AlphaZero等项目。在商业领域，Cloud TPU和Edge TPU分别支持云端大规模分布式训练和边缘设备上的低功耗推理，覆盖推荐系统、智能语音、计算机视觉、生成式AI等多种场景。

## 谷歌云TPU与Edge TPU

- **Cloud TPU**：作为Google Cloud的一项托管服务，提供可按需扩展的TPU集群（Pod），支持TensorFlow、PyTorch、JAX等多种深度学习框架，便于开发者在云端进行大规模训练与部署。
- **Edge TPU**：面向嵌入式和边缘设备的低功耗ASIC，仅支持TensorFlow Lite模型的前向推理，典型产品包括Coral开发板和USB加速器，适用于对时延和功耗敏感的场景。


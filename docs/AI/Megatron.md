

```bash
#!/bin/bash                          # 指定脚本使用 bash 解释器执行

set -x                              # 打印执行的每一条命令（调试用）

source /root/.bashrc                # 加载当前用户的环境变量配置

MEGATRON_PATH=${MEGATRON_PATH:-"/workspace/AIAK-Megatron"}   # Megatron代码路径（默认值）
AIAK_TRAINING_PATH=${AIAK_TRAINING_PATH:-"/workspace/AIAK-Training-LLM"}  # 训练框架路径

DATA_PATH=${DATA_PATH:-"/data/dataset/alpaca_data_en_52k.json"}  # 训练数据路径
DATA_CACHE_PATH=${DATA_CACHE_PATH:-"/data/qwen3/dataset/sft_aplaca_en_data_cache"}  # 数据缓存路径
DATASET_CONFIG_PATH=${DATASET_CONFIG_PATH:-"/workspace/AIAK-Training-LLM/configs/sft_dataset_config.json"}  # 数据集配置文件路径

TOKENIZER_PATH=${TOKENIZER_PATH:-"/data/Qwen3-30B-A3B/"}     # tokenizer路径（HF模型目录）
CHECKPOINT_LOAD_PATH=${CHECKPOINT_LOAD_PATH:-"/data/Qwen3_30B_mcore_tp2pp2ep2"}  # 加载模型权重路径
CHECKPOINT_SAVE_PATH=${CHECKPOINT_SAVE_PATH:-"/data/Qwen3_30B_mcore_tp2pp2ep2_save"}  # 保存模型路径
TENSORBOARD_PATH=${TENSORBOARD_PATH:-"/data/tensorboard-log/qwen3-30b.sft.xpu"}  # tensorboard日志路径
mkdir -p ${TENSORBOARD_PATH}      # 创建tensorboard目录（如果不存在）
GPUS_PER_NODE=8                   # 每个节点使用8张卡

export CUDA_VISIBLE_DEVICES="0,1,2,3,4,5,6,7"  # 指定可见GPU
#export DIST_MULTI_STREAM=false   # 是否开启多流（未启用）
export CUDA_DEVICE_MAX_CONNECTIONS=1  # 控制CUDA连接数（优化通信）

######################kunlun##########################
# bf16类型专用(megatron相关变量参考<百舸megatron专用>)
export USE_FAST_BF16_FC=true                    # 使用bf16加速全连接层
export FORCE_DISABLE_INPLACE_BF16_CAST=false    # 是否关闭inplace bf16转换

export BKCL_RDMA_NICS="eth1,eth1,eth2,eth2,eth3,eth3,eth4,eth4" # RDMA网卡绑定（多机通信）
export BKCL_SOCKET_IFNAME=eth0                  # 指定socket网卡
export BKCL_TREE_THRESHOLD=0                    # BKCL树通信阈值
export BKCL_FORCE_L3_RDMA=0                     # 是否强制L3 RDMA
export BKCL_ENABLE_XDR=1                        # 启用XDR优化
export BKCL_ALL_TO_ALL_OPT=1                    # all-to-all优化
export BKCL_RING_HOSTID_USE_RANK=1              # 用rank作为host id
#export BKCL_FORCE_SYNC=1                       # 强制同步（关闭）
#export BKCL_DEBUG=1                            # debug模式（关闭）
export BKCL_RDMA_VERBS=1                        # 启用verbs（多机pp4必须）

export XMLIR_PARALLEL_SAVE_MEMORY=true         # 节省显存（但性能下降）
export XMLIR_BATCH_PARALLEL=false               # batch并行关闭
export SAVE_LOG_FILE_WITH_RANK_ID=false         # 日志是否按rank分文件
export XMLIR_LOG_PATH="log-path"                # 日志路径
export XMLIR_LOG_PREFIX="log-file-prefix"       # 日志前缀
export P800_DEBUG=false                         # debug模式（nan检测）
export P800_DUMP_DIR="ckpt-dump-dir-path"       # dump路径
export XMLIR_DIST_ASYNC_ISEND_IRECV=true        # 异步通信
export XMLIR_CUDNN_ENABLED=1                    # 启用cuDNN

# LINEAR 开关
export XMLIR_ENABLE_LINEAR_FC_FUSION=1          # linear融合开关
export XDNN_FC_GEMM_DTYPE=int32_with_ll         # GEMM计算类型
export XMLIR_MEGATRON_CORE_AIAK_PLUGIN=1        # 启用AIAK插件

XFLAGS --disable megatron_core_aiak             # 禁用某些插件
XFLAGS --disable transformer_engine_1_7         # 禁用TE 1.7
XFLAGS --disable transformer_engine_1_13        # 禁用TE 1.13
######################################################

# Change for multinode config
MASTER_ADDR=${MASTER_ADDR:-"localhost"}       ## master节点地址
MASTER_PORT=${MASTER_PORT:-"6000"}            ## master端口
NNODES=${WORLD_SIZE:-"1"}                     ## 总节点数
NODE_RANK=${RANK:-"0"}                        ## 当前节点编号

DISTRIBUTED_ARGS=(
    --nproc_per_node $GPUS_PER_NODE           # 每个节点进程数（=GPU数）
    --nnodes $NNODES                          # 节点数
    --node_rank $NODE_RANK                    # 当前节点rank
    --master_addr $MASTER_ADDR                # 主节点IP
    --master_port $MASTER_PORT                # 主节点端口
)

MODEL_ARGS=(
    --model-name qwen3-30b-a3b                # 模型名称
    --rotary-base 1000000                     # RoPE基数
    --rotary-seq-len-interpolation-factor 1   # RoPE插值因子
)

DATA_ARGS=(
    --tokenizer-type HFTokenizer              # tokenizer类型
    --hf-tokenizer-path $TOKENIZER_PATH       # tokenizer路径
    --data-path $DATA_PATH                    # 数据路径
    --split 100,0,0                           # 数据划分（全训练）
)

SFT_ARGS=(
    --chat-template alpaca                    # 使用alpaca模板
    --sft-num-preprocess-workers 8            # 数据预处理线程数
    --no-check-for-nan-in-loss-and-grad       # 不检查nan
    --packing-sft-data                        # 启用packing
)

TRAINING_ARGS=(
    --training-phase sft                      # 训练阶段：SFT
    --seq-length 2048                         # 序列长度
    --max-position-embeddings 2048            # 最大位置编码
    --init-method-std 0.006                   # 初始化标准差
    --micro-batch-size 1                      # 单卡batch
    --global-batch-size 128                   # 全局batch
    --lr 1.0e-5                               # 学习率
    --min-lr 1.0e-6                           # 最小学习率
    --clip-grad 1.0                           # 梯度裁剪
    --weight-decay 0.1                        # 权重衰减
    --optimizer adam                          # 优化器
    --adam-beta1 0.9                          # Adam参数
    --adam-beta2 0.95
    --adam-eps 1e-08
    --norm-epsilon 1e-6                       # 层归一化epsilon
    --train-iters 50                          # 训练步数（很小，测试用）
    --lr-decay-iters 5000                     # 学习率衰减步数
    --lr-decay-style cosine                   # cosine衰减
    --lr-warmup-fraction 0.002                # warmup比例
    --initial-loss-scale 65536                # bf16 loss scale
    --bf16                                    # 使用bf16
    --load $CHECKPOINT_LOAD_PATH              # 加载模型
    --save $CHECKPOINT_SAVE_PATH              # 保存模型
    --save-interval 500                       # 保存间隔
    --eval-interval 100                       # 评估间隔
    --eval-iters 10                           # 评估步数
    --no-load-optim                           # 不加载优化器状态
    --no-load-rng                             # 不加载随机状态
)

MOE_ARGS=(
    --moe-router-load-balancing-type aux_loss # MoE负载均衡方式
    --moe-router-topk 8                       # top-k专家
    --moe-aux-loss-coeff 1e-2                 # 辅助loss系数
)

MODEL_PARALLEL_ARGS=(
    --tensor-model-parallel-size 2            # 张量并行
    --pipeline-model-parallel-size 2          # pipeline并行
    --expert-model-parallel-size 2            # expert并行
    --sequence-parallel                       # 序列并行
    --use-distributed-optimizer               # 分布式优化器
    --distributed-backend nccl                # 通信后端
)

LOGGING_ARGS=(
    --log-interval 1                          # 日志间隔
    --tensorboard-dir ${TENSORBOARD_PATH}     # tensorboard路径
    --log-timers-to-tensorboard               # 记录性能指标
)

if [ -n "${WANDB_API_KEY}" ]; then
    LOGGING_ARGS+=(
        --wandb-project ${WANDB_PROJECT}      # wandb项目
        --wandb-exp-name ${WANDB_NAME}        # wandb实验名
    )
fi

PYTHONPATH=$MEGATRON_PATH:$AIAK_TRAINING_PATH:$PYTHONPATH \  # 设置python路径
    torchrun ${DISTRIBUTED_ARGS[@]} \                      # 启动分布式训练
    $AIAK_TRAINING_PATH/aiak_training_llm/train.py \       # 训练脚本
    ${MODEL_ARGS[@]} \                                     # 模型参数
    ${DATA_ARGS[@]} \                                      # 数据参数
    ${TRAINING_ARGS[@]} \                                  # 训练参数
    ${SFT_ARGS[@]} \                                       # SFT参数
    ${MODEL_PARALLEL_ARGS[@]} \                            # 并行参数
    ${LOGGING_ARGS[@]}                                     # 日志参数
```





 **Megatron 是一个“训练超大语言模型的分布式引擎”**。

------

## 一、它到底是什么？

Megatron-LM 是由 NVIDIA 开源的一个框架，用来：

> **在很多GPU/加速卡上，高效训练像 GPT 这种超大模型（几十亿～万亿参数）**

------

## 二、为什么需要它？

你可以这样理解：

- 你本地训练一个小模型 → 一张卡就够
- 但像 Qwen3-30B / GPT-3 这种模型：
  - 参数：300亿+
  - 显存需求：几百GB

一张卡根本装不下
 所以必须“拆开训练”

Megatron 就是专门干这个的：

> **把一个大模型拆成很多份，让多张卡一起算**

------

## 三、它核心做了什么？

Megatron最核心就是三种“并行”👇

### 1️⃣ Tensor Parallel（张量并行）

👉 把一层里的矩阵拆开

比如：

```
一个大矩阵 → 分给 8 张卡分别算
```

------

### 2️⃣ Pipeline Parallel（流水线并行）

👉 把模型按层拆

```
GPU1：前几层
GPU2：中间层
GPU3：后几层
```

像流水线一样一层层传

------

### 3️⃣ Data Parallel（数据并行）

👉 多份模型，同时吃不同数据

```
卡1：训练样本A
卡2：训练样本B
```

------

👉 你脚本里这几行就是它的核心：

```
--tensor-model-parallel-size 2
--pipeline-model-parallel-size 2
--expert-model-parallel-size 2
```

意思是：

👉 **你在用 Megatron 把模型拆成 2×2×2 = 8 份，在 8 张卡上跑**

------

## 四、它和 PyTorch 什么关系？

- PyTorch：基础框架（会写模型）
- Megatron：高级加速器（帮你“分布式训练大模型”）

👉 类比：

| 角色     | 类比              |
| -------- | ----------------- |
| PyTorch  | 发动机            |
| Megatron | 涡轮增压 + 变速箱 |

------

## 五、你现在这个脚本在干嘛（结合你）

你现在不是“写模型”，而是在：

👉 用 Megatron 做：

- Qwen3-30B
- SFT微调
- 8卡训练
- 多并行（TP+PP+EP）

👉 本质就是：

> **用工业级方式训练大模型，而不是玩具级训练**






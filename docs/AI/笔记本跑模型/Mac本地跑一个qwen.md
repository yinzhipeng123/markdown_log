**标准工程链路**：

```
EvalScope（压测）
   ↓
LiteLLM（API网关）
   ↓
Ollama（模型运行）
   ↓
Qwen2（本地模型）
```



笔记本跑模型最佳的就是Ollama

**Ollama对笔记本硬件友好**

- 支持 CPU 推理（无 GPU 也可运行）
- 自动适配内存使用
- 自动适配线程数
- 自动适配上下文长度

### 安装Ollama

```bash
zhipengyin@192 ~ % export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;export ALL_PROXY=socks5://127.0.0.1:1080
zhipengyin@192 ~ % curl -fsSL https://ollama.com/install.sh | sh
zhipengyin@192 ~ % ollama serve 
```

### 启动轻量级模型

另一个终端:

```bash
zhipengyin@192 ~ % OLLAMA_NUM_THREADS=4 ollama run qwen2:0.5b-instruct 
```

### 安装代理程序LiteLLM

LiteLLM 允许你用**一套统一的 OpenAI 格式代码**去调用这些所有的模型

再开一个终端：

```bash
/usr/local/bin/python3.11 -m venv eval-env #创建虚拟环境
source eval-env/bin/activate #进入虚拟环境
python --version
Python 3.11.10
pip install evalscope litellm #安装代理
pip install 'litellm[proxy]' #安装代理
litellm --model ollama/qwen2:0.5b-instruct #启动代理服务
```

### evalscope perf 进行测试

再开一个终端:

```bash
source eval-env/bin/activate #进入虚拟环境
evalscope perf \
  --url http://127.0.0.1:4000/v1/chat/completions \
  --api openai \
  --model ollama/qwen2:0.5b-instruct \
  --parallel 4 \
  --number 50 \
  --prompt "写一段关于人工智能的介绍" \
  --max-tokens 128 \
  --min-tokens 128
```

正常就可以看到结果了:

```bash
Running[perf]: 100%|█████████████████████████████████████████████████████████████████████████████| 1/1 [00:03<00:00,  3.46s/it]
╭──────────────────────────────────────────────────────────────────────────────╮
│ Performance Test Summary Report                                              │
╰──────────────────────────────────────────────────────────────────────────────╯

Basic Information:
┌───────────────────────┬──────────────────────────────────────────────────────┐
│ Model                 │ qwen2:0.5b-instruct                                  │
│ Test Dataset          │ openqa                                               │
│ API Type              │ openai                                               │
│ Total Generated       │ 0 tokens                                             │
│ Total Test Time       │ 0.00 seconds                                         │
│ Avg Output Rate       │ N/A                                                  │
│ Output Path           │ outputs/20260319_194308/qwen2_0.5b-instruct          │
└───────────────────────┴──────────────────────────────────────────────────────┘


                                    Detailed Performance Metrics                                    
┏━━━━━━┳━━━━━━┳━━━━━━━┳━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━┳━━━━━━━━━┳━━━━━━━━┳━━━━━━━━━┳━━━━━━━━┓
┃      ┃      ┃       ┃     Avg ┃     P99 ┃     Avg ┃    P99 ┃     Avg ┃    P99 ┃    Gen. ┃ Success┃
┃Conc. ┃ Rate ┃   RPS ┃ Lat.(s) ┃ Lat.(s) ┃ TTFT(s) ┃ TTFT(… ┃ TPOT(s) ┃ TPOT(… ┃  toks/s ┃    Rate┃
┡━━━━━━╇━━━━━━╇━━━━━━━╇━━━━━━━━━╇━━━━━━━━━╇━━━━━━━━━╇━━━━━━━━╇━━━━━━━━━╇━━━━━━━━╇━━━━━━━━━╇━━━━━━━━┩
│    4 │  INF │ -1.00 │  -1.000 │     nan │  -1.000 │    nan │  -1.000 │    nan │   -1.00 │    0.0%│
└──────┴──────┴───────┴─────────┴─────────┴─────────┴────────┴─────────┴────────┴─────────┴────────┘


               Best Performance Configuration               
 Highest RPS         Concurrency 4 (-1.00 req/sec)          
 Lowest Latency      Concurrency 4 (-1.000 seconds)         

Performance Recommendations:
• The system seems not to have reached its performance bottleneck, try higher concurrency
• Success rate is low at high concurrency, check system resources or reduce concurrency
```


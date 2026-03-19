---
password: mysecret123
---



```bash
zhipengyin@192 ~ % export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;export ALL_PROXY=socks5://127.0.0.1:1080
zhipengyin@192 ~ % curl -fsSL https://ollama.com/install.sh | sh
zhipengyin@192 ~ % ollama serve 
```

另一个终端:

```bash
zhipengyin@192 ~ % OLLAMA_NUM_THREADS=4 ollama run qwen2:0.5b-instruct 
```


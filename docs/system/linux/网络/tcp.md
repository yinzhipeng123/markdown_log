# TCP



经典的三次握手示意图：

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207200301284.png)

经典的四次握手关闭图：

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207200303304.png)



### 1.短连接

```bash
连接->传输数据->关闭连接
```

短连接是指通信双方有数据交互时，就建立一个TCP连接，数据发送完成后，则断开此TCP连接，

### 2.长连接

```bash
连接->传输数据->保持连接->传输数据->....->关闭连接
```

长连接指建立TCP连接后不管是否使用都保持连接，但安全性较差。

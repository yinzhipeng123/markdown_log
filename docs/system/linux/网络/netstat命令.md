netstat - 显 示 网 络 连 接 ， 路 由 表 ， 接 口 状 态 ， 伪 装 连 接 ， 网 络 链 路 信 息 和 组 播 成 员 组 。 
```bash
总览 SYNOPSIS
    netstat  [address_family_options]  [--tcp|-t]  [--udp|-u]  [--raw|-w]  [--listening|-l] [--all|-a] [--numeric|-n] [--numeric-
    hosts][--numeric-ports][--numeric-ports]  [--symbolic|-N]  [--extend|-e[--extend|-e]]  [--timers|-o]  [--program|-p]  [--ver‐
    bose|-v] [--continuous|-c] [delay]
    
    netstat   {--route|-r}   [address_family_options]   [--extend|-e[--extend|-e]]   [--verbose|-v]   [--numeric|-n]  [--numeric-
    hosts][--numeric-ports][--numeric-ports] [--continuous|-c] [delay]
    
    netstat  {--interfaces|-i}  [iface]  [--all|-a]  [--extend|-e[--extend|-e]]  [--verbose|-v]   [--program|-p]   [--numeric|-n]
    [--numeric-hosts][--numeric-ports][--numeric-ports] [--continuous|-c] [delay]
    
    netstat {--groups|-g} [--numeric|-n] [--numeric-hosts][--numeric-ports][--numeric-ports] [--continuous|-c] [delay]
    
    netstat  {--masquerade|-M} [--extend|-e] [--numeric|-n] [--numeric-hosts][--numeric-ports][--numeric-ports] [--continuous|-c]
    [delay]
    
    netstat {--statistics|-s} [--tcp|-t] [--udp|-u] [--raw|-w] [delay]
    
    netstat {--version|-V}
    
    netstat {--help|-h}
    
    address_family_options:
    
    [--protocol={inet,unix,ipx,ax25,netrom,ddp}[,...]]  [--unix|-x] [--inet|--ip] [--ax25] [--ipx] [--netrom] [--ddp]
```

#### 功能：

- (none)

  无 选 项 时 , netstat 显 示 打 开 的 套 接 字 .  如 果 不 指 定 任 何 地 址 族 ， 那 么 打 印 出 所 有 已 配 置 地 址 族 的 有 效 套 接 字 。                               

- --route , -r

  显 示 内 核 路 由 表 。                                                                                                               

- --groups , -g
  显 示 IPv4 和  IPv6的 IGMP组 播 组 成 员 关 系 信 息 。                                                                 

- --interface=iface , -i  

  显 示 所 有 网 络 接 口 列 表 或 者 是 指 定 的  iface 。                                                                  

- --masquerade , -M 

  显 示 一 份 所 有 经 伪 装 的 会 话 列 表 。                                                                                   

- --statistics , -s
显 示 每 种 协 议 的 统 计 信 息 。
#### 选项 

- --verbose , -v 
  详 细 模 式 运 行 。 特 别 是 打 印 一 些 关 于 未 配 置 地 址 族 的 有 用 信 息 。                               

- --numeric , -n 
  显 示 数 字 形 式 地 址 而 不 是 去 解 析 主 机 、 端 口 或 用 户 名 。                                               

- --numeric-hosts 

  显 示 数 字 形 式 的 主 机 但 是 不 影 响 端 口 或 用 户 名 的 解 析 。                                                

- --numeric-ports 
  显 示 数 字 端 口 号 ， 但 是 不 影 响 主 机 或 用 户 名 的 解 析 。                                                   

- --numeric-users 
  显 示 数 字 的 用 户 ID， 但 是 不 影 响 主 机 和 端 口 名 的 解 析 。                                                

- --protocol=family , -A 

  指 定 要 显 示 哪 些 连 接 的 地 址 族 (也 许 在 底 层 协 议 中 可 以 更 好 地 描 述 )。   family  以 逗 号 分 隔 的 地 址 族 列 表 ， 比 如   inet,  unix,  ipx,  ax25,  netrom, 和  ddp。  这 样 和 使 用  --inet, --unix (-x), --ipx, --ax25, --netrom, 和  --ddp 选 项 效 果 相 同 。                                 
  地 址 族  inet 包 括 raw, udp 和 tcp 协 议 套 接 字 。                                                                     

- -c, --continuous
  将 使  netstat 不 断 地 每 秒 输 出 所 选 的 信 息 。

- -e, --extend 
  显 示 附 加 信 息 。 使 用 这 个 选 项 两 次 来 获 得 所 有 细 节 。                                                    

- -o, --timers 
  包 含 与 网 络 定 时 器 有 关 的 信 息 。                                                                                       

- -p, --program 

  显 示 套 接 字 所 属 进 程 的 PID和 名 称 。                                                                                   

- -l, --listening 
  只 显 示 正 在 侦 听 的 套 接 字 (这 是 默 认 的 选 项 )                                                                     

- -a, --all
 显 示 所 有 正 在 或 不 在 侦 听 的 套 接 字 。 加 上  --interfaces 选 项 将 显 示 没 有 标 记 的 接 口 。                                                      
 
- -F

  显 示 FIB中 的 路 由 信 息 。 (这 是 默 认 的 选 项 )                                                                       

- -C 
  显 示 路 由 缓 冲 中 的 路 由 信 息 。                                                                                         

- delay
netstat将 循 环 输 出 统 计 信 息 ， 每 隔  delay 秒 。
#### 输出 

- Proto

  套 接 字 使 用 的 协 议 。                                                                                                        

- Recv-Q 
 Established：连 接 此 套 接 字 的 用 户 程 序 未 拷 贝 的 字 节 数 。Listening：从内核2.6.18开始，此列包含当前的syn backlog。
 
- Send-Q

  Established：远 程 主 机 未 确 认 的 字 节 数 。Listening：从内核2.6.18开始，此列包含syn backlog的最大大小。                                                                                          

- Local Address

  套 接 字 的 本 地 地 址 (本 地 主 机 名 )和 端 口 号 。 除 非 给 定 -n   --numeric     (-n)   选 项 ， 否 则 套 接 字 地 址 按 标 准 主 机 名 (FQDN)进 行 解 析 ， 而 端 口 号 则 转 换 到 相 应 的 服 务 名 。     

- Foreign Address
  套 接 字 的 远 程 地 址 (远 程 主 机 名 )和 端 口 号 。  Analogous to "Local Address."                          

- State 
  套 接 字 的 状 态 。 因 为 在 RAW协 议 中 没 有 状 态 ， 而 且 UDP也 不 用 状 态 信 息 ， 所 以 此 行 留 空 。 通 常 它 为 以 下 几 个 值 之 一
   1. ESTABLISHED    
  
      套 接 字 有 一 个 有 效 连 接 。                                                                                            
  
   2. SYN_SENT
  
    套 接 字 尝 试 建 立 一 个 连 接 。                                                                                           
  
   3. SYN_RECV 
  
    从 网 络 上 收 到 一 个 连 接 请 求 。  
  
   4. FIN_WAIT1 
    套 接 字 已 关 闭 ， 连 接 正 在 断 开 。                                                                                   
  
   5. FIN_WAIT2
    连 接 已 关 闭 ， 套 接 字 等 待 远 程 方 中 止 。                                                                       
  
   6. TIME_WAIT 
  
    在 关 闭 之 后 ， 套 接 字 等 待 处 理 仍 然 在 网 络 中 的 分 组                                                   
  
   7. CLOSED 
  
      套 接 字 未 用 。                                                                                                     
  
     8. CLOSE_WAIT
   
   远 程 方 已 关 闭 ， 等 待 套 接 字 关 闭 。
   
     8. LAST_ACK 
   远 程 方 中 止 ， 套 接 字 已 关 闭 。 等 待 确 认 。                                                                  
   
     10. LISTEN 
  
  套 接 字 监 听 进 来 的 连 接 。 如 果 不 设 置  --listening (-l) 或 者  --all (-a) 选 项 ， 将 不 显 示 出 来 这 些 连 接 。           
  
     11. CLOSING
  
         套 接 字 都 已 关 闭 ， 而 还 未 把 所 有 数 据 发 出 。                                                             
  
     11. UNKNOWN 
  套 接 字 状 态 未 知 。

- User 
       套 接 字 属 主 的 名 称 或 UID。                                                                                             
   
- PID/Program name
   
   以 斜 线 分 隔 的 处 理 套 接 字 程 序 的 PID及 进 程 名 。   --program    使 此 栏 目 被 显 示 。 你 需 要   superuser    权 限 来 查 看 不 是 你 拥 有 的 套 接 字 的 信 息 。 对 IPX套 接 字 还 无 法 获 得 此 信 息 。         
   
- Timer
   
     (this needs to be written) 
   
   活 动 的 UNIX域 套 接 字                                                                   
   
- Proto 
  套 接 字 所 用 的 协 议 (通 常 是 unix)。                                                                                        

- RefCnt 
  使 用 数 量 (也 就 是 通 过 此 套 接 字 连 接 的 进 程 数 )。                                                               

- Flags 
 显 示 的 标 志 为 SO_ACCEPTON(显 示 为   ACC),  SO_WAITDATA  (W)  或   SO_NOSPACE  (N)。  如 果 相 应 的 进 程 等 待 一 个 连 接 请 求 ， 那 么 SO_ACCECP‐TON用 于 未 连 接 的 套 接 字 。 其 它 标 志 通 常 并 不 重 要
 
- Type
  套 接 字 使 用 的 一 些 类 型 ：   

   1. SOCK_DGRAM     

      此 套 接 字 用 于 数 据 报 (无 连 接 )模 式 。                                                                            

   2. SOCK_STREAM 

      流 模 式 (连 接 )套 接 字                                                                                                         

   3. SOCK_RAW
    此 套 接 字 用 于 RAW模 式 。                                                                                               

   4. SOCK_RDM
    一 种 服 务 可 靠 性 传 递 信 息 。                                                                                           

   5. SOCK_SEQPACKET           

      连 续 分 组 套 接 字 。                                                                                                           

   6. SOCK_PACKET

      RAW接 口 使 用 套 接 字 。                                                                                                    

   7. UNKNOWN
    将 来 谁 知 道 它 的 话 将 告 诉 我 们 ， 就 填 在 这 里  :-)

- State
  此 字 段 包 含 以 下 关 键 字 之 一 ：                                                                                            

   1. FREE  

       套 接 字 未 分 配 。                                                                                                   

   2. LISTENING  

    套 接 字 正 在 监 听 一 个 连 接 请 求 。 除 非 设 置  --listening (-l) 或 者  --all (-a) 选 项 ， 否 则 不 显 示 。                                   

   3. CONNECTING

      套 接 字 正 要 建 立 连 接 。                                                                                                   

   4. CONNECTED 

      套 接 字 已 连 接 。                                                                                                             

   5. DISCONNECTING

      套 接 字 已 断 开 。                                                                                                             

   6. (empty) 
    套 接 字 未 连 。                                                                                                               

   7. UNKNOWN 
    ！不 应 当 出 现 这 种 状 态 的 。                                                                                                   

- PID/Program name 
       处 理 此 套 接 字 的 程 序 进 程 名 和 PID。 上 面 关 于 活 动 的 Internet连 接 的 部 分 有 更 详 细 的 信 息 。
   
- Path
  当 相 应 进 程 连 入 套 接 字 时 显 示 路 径 名 。                                                                             

- 活 动 的 IPX套 接 字  

   (this needs to be done by somebody who knows it)                                                                        

- Active NET/ROM sockets  

    (this needs to be done by somebody who knows it)                                                                        

- Active AX.25 sockets 
(this needs to be done by somebody who knows it)
#### 注意
该程序大部分已过时。 netstat 的替代品是 ss。netstat -r 的替代是 ip route。 替代 netstat -i 是 ip -s link。 netstat -g 的替代是 ip maddr。 
#### 文 件                                                                                                                          
/etc/services -- 服 务 解 释 文 件  /proc -- proc文 件 系 统 的 挂 载 点 。 

/proc文 件 系 统 通 过 下 列 文 件 给 出 了 内 核 状 态 信 息 。

/proc/net/dev -- 设 备 信 息 

/proc/net/raw -- RAW套 接 字 信 息

 /proc/net/tcp -- TCP套 接 字 信 息

/proc/net/udp -- UDP套 接 字 信 息 

/proc/net/igmp -- IGMP组 播 信 息

/proc/net/unix -- Unix域 套 接 字 信 息  

/proc/net/ipx -- IPX套 接 字 信 息

/proc/net/ax25 -- AX25套 接 字 信 息 

 /proc/net/appletalk -- DDP(appletalk)套 接 字 信 息

 /proc/net/nr -- NET/ROM套 接 字 信 息 

/proc/net/route -- IP路 由 信 息 

/proc/net/ax25_route -- AX25路 由 信 息

/proc/net/ipx_route -- IPX路 由 信 息 

/proc/net/nr_nodes -- NET/ROM节 点 列 表

/proc/net/nr_neigh -- NET/ROM邻 站

/proc/net/ip_masquerade -- 伪 装 连 接 

/proc/net/snmp -- 统 计

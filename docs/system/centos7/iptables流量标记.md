基于网络包的源 IP 地址，将流量根据来源地（香港或美国）分发到不同的网卡上。`iptables` 负责标记流量，`ip rule` 则根据标记选择不同的路由表，从而决定通过哪个网卡转发流量。

### 1. 配置路由表
首先，我们在 `/etc/iproute2/rt_tables` 文件中为每个网络接口创建独立的路由表。这样你可以为每个网卡指定独立的路由策略。

#### `/etc/iproute2/rt_tables`
这一步是让系统知道有哪些路由表。`rt_tables` 文件存储了路由表的标识符和名称。你添加了两行：

```
100   hk_network
200   us_network
```

这表示：

- [ ] `hk_network` 是路由表编号 100，针对香港网络。
- [ ] `us_network` 是路由表编号 200，针对美国网络。

### 2. 为每个网卡添加路由

每个网卡（香港网卡 `eth0` 和美国网卡 `eth1`）都有一个默认的网关。你需要为每个网卡配置一个路由表，并指定默认网关。

#### `ip route add default via <gateway> dev <interface> table <table>`
这些命令将流量通过指定网卡的网关路由出去，并将其添加到特定的路由表中。

```bash
ip route add default via 192.168.0.254 dev eth0 table hk_network
```

这行命令的意思是：

- [ ] `ip route add default`: 添加默认路由。
- [ ] `via 192.168.0.254`: 默认网关是 `192.168.0.254`，即香港网络的网关。
- [ ] `dev eth0`: 使用 `eth0` 网络接口（香港网卡）。
- [ ] `table hk_network`: 将此路由添加到 `hk_network` 路由表中（编号为 100）。

类似地，对于美国网络：

```bash
ip route add default via 10.0.0.254 dev eth1 table us_network
```

- [ ] `via 10.0.0.254`: 美国网关地址是 `10.0.0.254`。
- [ ] `dev eth1`: 使用 `eth1` 网络接口（美国网卡）。
- [ ] `table us_network`: 将此路由添加到 `us_network` 路由表中（编号为 200）。

### 3. 配置 `iptables` 标记流量

我们使用 `iptables` 来标记不同源 IP 地址的流量，这样可以根据标记来选择路由表。你可以通过 `mangle` 表在数据包进入时进行修改。

#### `iptables -t mangle -A PREROUTING -s <source_ip> -j MARK --set-mark <mark>`
这个命令用于在数据包进入时，根据源 IP 地址给数据包打上标记。

```bash
iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -j MARK --set-mark 1
```

- [ ] `-t mangle`: 选择 `mangle` 表，`mangle` 表用于修改数据包的标记。
- [ ] `-A PREROUTING`: 在数据包到达目标之前进行处理，`PREROUTING` 是指数据包刚进入路由时。
- [ ] `-s 10.0.0.0/8`: 选择源 IP 地址范围为 `10.0.0.0/8`（例如，美国网段的源 IP）。
- [ ] `-j MARK --set-mark 1`: 给符合条件的数据包打上标记 `1`。

类似地，针对香港的 IP 地址范围（假设是 `192.168.0.0/8`）：

```bash
iptables -t mangle -A PREROUTING -s 192.168.0.0/8 -j MARK --set-mark 2
```

- [ ] 这会将源地址为 `192.168.0.0/8` 的数据包标记为 `2`。

### 4. 配置 `ip rule` 来选择路由表

接下来，我们使用 `ip rule` 来根据标记选择不同的路由表。`ip rule` 用于设置路由规则，决定数据包根据某些条件使用哪个路由表。

#### `ip rule add fwmark <mark> lookup <table>`
根据之前用 `iptables` 设置的标记，添加路由规则，指定标记的流量应该使用哪个路由表。

```bash
ip rule add fwmark 1 lookup hk_network
```

这行命令的意思是：

- [ ] `fwmark 1`: 查找标记为 `1` 的流量（即美国网络流量）。
- [ ] `lookup hk_network`: 使用 `hk_network` 路由表（编号为 100）。

类似地，为标记 `2` 的流量（香港流量）设置路由规则：

```bash
ip rule add fwmark 2 lookup us_network
```

- [ ] `fwmark 2`: 查找标记为 `2` 的流量（即香港网络流量）。
- [ ] `lookup us_network`: 使用 `us_network` 路由表（编号为 200）。

### 5. 验证配置

你可以使用以下命令来验证配置是否生效：

#### 查看路由规则
```bash
ip rule show
```
这将显示当前的路由规则，确保根据标记设置的规则已生效。

#### 查看路由表
```bash
ip route show table hk_network
ip route show table us_network
```
这会显示每个路由表中的路由条目，确保每个网卡的路由配置正确。

---

### 总结

这些命令的核心思想是：

1. **路由表配置**：为每个网卡设置不同的路由表和默认网关。
2. **`iptables` 标记**：根据源 IP 地址打上标记，标记不同的流量。
3. **`ip rule` 选择路由表**：根据 `iptables` 的标记，选择不同的路由表来决定流量走哪个网卡。

这样你就能实现根据源 IP 地址将流量分发到不同的网卡上。
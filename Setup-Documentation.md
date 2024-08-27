# Network-Stack

```
           (DHCP)
     WAN --------- OPNsense
                (192.1.1.1/24)
                       |
                       |
         viz ------- switch ----- others
        (..3)       / (..2) \     (DHCP)
                   /    |    \
(..111) mdrain ---/     |     \-- mcold (..133)
                 /     / \     \
             drain    /   \     cold
            (..11)   /     \   (..33)
                   hot    mhot
                 (..22)  (..122)
```

Detailed description:

| Host     | IP-Address  | DNS-Alias | Description                |
|----------|-------------|-----------|----------------------------|
| WAN      |             |           | Upstream network           |
| OPNsense | DHCP (WAN)<br>192.1.1.1 (LAN) | opnsense<br>router<br>gateway<br>dns | Router, DHCP-server, DNS-server, Gateway, running OPNsense |
| switch   | 192.1.1.2   |           | Managed L3-switch          |
| viz      | 192.1.1.3   | viz       | Tower-PC for X-Forwarding* |
| drain    | 192.1.1.11  | drain     | HEAD-node, CPU-only        |
| mdrain   | 192.1.1.111 | mdrain    | Management for drain       |
| hot      | 192.1.1.22  | hot       | Compute-node, 4x H100      |
| mhot     | 192.1.1.122 | mhot      | Management for hot         |
| cold     | 192.1.1.33  | cold      | Compute-node, 4x H100      |
| mcold    | 192.1.1.133 | mcold     | Management for cold        |
| others   | DHCP        |           | Other devices connected to switch, will receive 192.1.1.2-254/24 as DHCP-leases |

MAC-Addresses:

| MAC               | Host            |
|-------------------|-----------------|
| 00:25:90:8a:8e:ea | OPNsense (WAN)* |
| 00:25:90:8a:47:4c | OPNsense (MGT)* |
| 00:25:90:8a:8e:eb | OPNsense (LAN)* |
| 64:9d:99:0e:50:a7 | switch          |
| 90:1b:0e:3d:d3:3d | viz*            |
| 10:ff:e0:06:2e:dc | drain           |
| 10:ff:e0:31:5b:9c | mdrain          |
| 10:ff:e0:06:2e:d0 | hot             |
| 10:ff:e0:31:5b:98 | mhot            |
| 10:ff:e0:06:2f:22 | cold            |
| 10:ff:e0:35:a5:74 | mcold           |

*temporary system, may change

# Users

User: `root` or `faucet`  
Password: (ask)  
Key: `id_faucet` (ask)

# QoL

- Nodes are off by default to save power, use `./poweron.sh` to power them on (also available from OPNsense)
- After working, please consider powering down the nodes, provided nobody else is accessing them at the moment (helper script `./poweroff.sh`)
- A `~/.ssh/config` alongside a universal keyfile (`id_faucet`) is provided for easy access to the cluster
- To install packages on viz (Arch), use `yay <package>` - thanks to the AUR, almost every application is packaged and easily installable

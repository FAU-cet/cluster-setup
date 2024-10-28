# Network-Stack

```
            (DHCP)
      WAN --------- opnsense
                  (10.0.0.1/22)
                        |
                        |
          viz ------- switch ----- others
        (.0.4)       / (.0.5) \     (DHCP)
                    /    |     \
(.1.111) mdrain ---/     |      \-- mcold (.1.133)
                  /     / \      \
              drain    /   \     cold
             (.1.11)  /     \   (.1.33)
                   hot    mhot
                (.1.22)  (.1.122)
```

Detailed description:

| Host     | IP-Address | DNS-Alias | Description                |
|----------|------------|-----------|----------------------------|
| WAN      |                   | Upstream network           |
| opnsense | DHCP (WAN)<br>10.0.0.1/22 (LAN) | router | Firewall, Routing |
| miniprox | 10.0.0.2   |      | Proxmox VE                 |
| adguard  | 10.0.0.3   |      | DNS                        |
| viz      | 10.0.0.4   |      | Netboot.xyz, Grafana       |
| switch   | 10.0.0.5   |      | Managed L3-switch          |
| drain    | 10.0.1.11  | head | HEAD-node, CPU-only        |
| mdrain   | 10.0.1.111 |      | Management for drain       |
| hot      | 10.0.1.22  |      | Compute-node, 4x H100      |
| mhot     | 10.0.1.122 |      | Management for hot         |
| cold     | 10.0.1.33  |      | Compute-node, 4x H100      |
| mcold    | 10.0.1.133 |      | Management for cold        |
| others   | DHCP       |      | Other devices connected to switch, will receive 10.0.3.1-254/24 as DHCP-leases |

MAC-Addresses:

| MAC               | Host           |
|-------------------|----------------|
| 60:be:b4:1c:f1:13 | Proxmox  (MGT) |
| bc:24:11:37:c0:41 | OPNsense (WAN) |
| bc:24:11:28:25:5e | OPNsense (LAN) |
| 64:9d:99:0e:50:a7 | switch         |
| bc:24:11:ce:e5:73 | viz            |
| 10:ff:e0:06:2e:dc | drain          |
| 10:ff:e0:31:5b:9c | mdrain         |
| 10:ff:e0:06:2e:d0 | hot            |
| 10:ff:e0:31:5b:98 | mhot           |
| 10:ff:e0:06:2f:22 | cold           |
| 10:ff:e0:35:a5:74 | mcold          |

# Users

User: `root`, `faucet` (for viz), or your first name (lowercase)  
Password: (ask)  
Key: `id_faucet` (ask)

# QoL

- Nodes are off by default to save power, use `./poweron.sh` to power them on (also available from OPNsense)
- After a work session, please consider powering down the nodes, provided nobody else is accessing them at the moment (helper script `./poweroff.sh`)
- A `~/.ssh/config` alongside a universal keyfile (`id_faucet`) is provided for easy access to the cluster. It should never be necessary to input a password manually
- To install packages on viz (Arch), use `yay <package>` - thanks to the [AUR](https://aur.archlinux.org/), almost every application is packaged and easily installable

# Netboot

Installing without USB sticks is made possible by [netboot.xyz](https://netboot.xyz/).

To reinstall a bare-bones Alma:

1. Press F12 during boot to force iPXE
2. Select `Alma 9` under `Linux Network Installs` with the `text based installer`
3. Kickstart URL should already be set to `http://10.0.0.4/ks.cfg`, enabling automatic installation

# On-Site

At the competition, there are a few things to consider:

- update the `TODO` parts from the `~/.ssh/config`, as the surrounding network environment has changed

# N100 Firewall

For use at the competition, OPNsense, DNS, viz, netboot.xyz and a Grafana dashboard will all be hosted on a Intel N100 based mini-pc acting as a firewall/router. Services are virtualized using Proxmox VE.

Additionally, WatchYourLAN is used to monitor for suspicious devices.
Untrusted devices will not be given a DHCP lease anyway, but this additional layer protects against static IPs and spoofed MACs.
Notifications are done via a Discord Webhook, being received by all team members' phones and laptops.

The firewall blocks all inbound access attempts, only letting through outbound traffic and their responses.
It's still undecided whether to log firewall messages, log settings may change on-site.
On the one hand, having a clear log is good for detecting an attack chain,
though writing every denied access into a log can lead to rather difficult to mitigate DOS attacks.

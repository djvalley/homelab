# Network Topology

Source of truth for network addressing and topology. Update when IPs or services change.
Do not store credentials here — use `.env` files or a secrets manager.

---

## VLANs

| VLAN | Name        | Subnet          | Gateway      | DHCP Range                    | DNS                        | Purpose                     |
|------|-------------|-----------------|--------------|-------------------------------|----------------------------|-----------------------------|
| 10   | Homelab     | 10.0.10.0/24    | 10.0.10.1    | 10.0.10.100 – 10.0.10.254     | 10.0.10.5, 10.0.10.6       | Infrastructure & servers    |
| 20   | Human Pawns | 10.0.20.0/24    | 10.0.20.1    | 10.0.20.10 – 10.0.20.254      | 10.0.10.5, 10.0.10.6       | Personal devices & family   |
| 50   | Orc Horde   | 10.0.50.0/24    | 10.0.50.1    | 10.0.50.100 – 10.0.50.254     | 10.0.10.5, 10.0.10.6       | IoT devices                 |
| —    | Default     | 192.168.1.0/24  | 192.168.1.1  | 192.168.1.6 – 192.168.1.254   | —                          | Legacy / untagged           |

---

## WAN / External DNS

| Interface  | Type | DNS             |
|------------|------|-----------------|
| Internet 1 | DHCP | 1.1.1.1, 1.0.0.3 (Cloudflare) |
| Internet 2 | DHCP | Auto (failover) |

---

## Network Hardware (VLAN 10)

| IP           | Hostname    | Role                            |
|--------------|-------------|----------------------------------|
| 10.0.10.1    | UDR7        | Gateway / UniFi Dream Router 7   |
| 10.0.10.11   | CWD53008    | UniFi switch                     |
| 10.0.10.12   | CWL01020    | UniFi switch                     |
| 10.0.10.14   | CWDA1002    | UniFi device                     |

---

## DNS

| Role      | Hostname  | IP          | Notes                          |
|-----------|-----------|-------------|--------------------------------|
| Primary   | pihole1   | 10.0.10.5   | Pi-hole, serves all VLANs      |
| Secondary | pihole2   | 10.0.10.6   | Pi-hole, failover              |

---

## Proxmox Cluster (VLAN 10)

| IP          | Hostname | Role                     | Notes |
|-------------|----------|--------------------------|-------|
| 10.0.10.10  | pve01    | Proxmox VE node 1        | Primary compute node |
| 10.0.10.13  | pve04    | Proxmox VE node 4        | TODO: clarify role |
| 10.0.10.9   | pbs01    | Proxmox Backup Server    |       |

### LXC Containers / VMs

| IP           | Hostname           | Host Node | Purpose                                  |
|--------------|--------------------|-----------|------------------------------------------|
| 10.0.10.104  | (this container)   | TODO      | Central management / dev (claude-mgmt)   |
| 10.0.10.100  | docker01           | TODO      | Docker host — TODO: document services    |
| 10.0.10.101  | docker02           | TODO      | Docker host — TODO: document services    |
| 10.0.10.102  | docker03           | TODO      | Docker host — TODO: document services    |
| 10.0.10.103  | discord-bots       | TODO      | Discord bot host                         |
| 10.0.10.29   | pterodactyl-panel  | TODO      | Pterodactyl game panel                   |
| 10.0.10.30   | pterodactyl-wings  | TODO      | Pterodactyl wings node 1                 |
| 10.0.10.31   | pterodactyl-wings  | TODO      | Pterodactyl wings node 2                 |
| 10.0.10.5    | pihole1            | TODO      | Pi-hole DNS primary                      |
| 10.0.10.6    | pihole2            | TODO      | Pi-hole DNS secondary                    |

---

## Docker Services

Hosted across docker01–03 via Portainer. See [docs/services/](services/) for per-service details.

| Service        | Host    | Internal Port | LAN URL              | Notes                   |
|----------------|---------|---------------|----------------------|-------------------------|
| Immich         | TODO    | TODO          | TODO                 | Photo management        |
| Paperless-ngx  | TODO    | TODO          | TODO                 | Document management     |
| n8n            | TODO    | TODO          | TODO                 | Automation workflows    |
| Home Assistant | TODO    | TODO          | TODO                 | Home automation         |
| BookStack      | TODO    | TODO          | TODO                 | Documentation / wiki    |
| Ollama         | TODO    | TODO          | TODO                 | Local LLM runtime       |

---

## Remote Access

### Tailscale

> Not yet configured on this container (10.0.10.104). See runbook TODO when ready to set up.

| Node    | Tailscale IP | Notes |
|---------|--------------|-------|
| TODO    |              |       |

### Cloudflare Tunnel

| Public Domain | Internal Target | Notes |
|---------------|-----------------|-------|
| TODO          |                 |       |

---

## Key Devices (Other)

| IP           | Hostname         | VLAN | Notes                  |
|--------------|------------------|------|------------------------|
| 10.0.10.237  | David-PC         | 10   | Primary workstation    |
| 10.0.10.67   | itron            | 10   | Smart meter            |
| 10.0.50.20   | Thermostat       | 50   | IoT — Orc Horde VLAN   |
| 10.0.50.34   | Litter-Robot4    | 50   | IoT — Orc Horde VLAN   |

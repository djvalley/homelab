# Network Topology

Source of truth for network addressing and topology. Update when IPs or services change.
Do not store credentials here — use `.env` files or a secrets manager.

---

## WAN / External

| Detail        | Value                                        |
|---------------|----------------------------------------------|
| Public IP     | 167.237.9.126                                |
| DNS Provider  | Cloudflare (zone: djvalley.com)              |
| Upstream DNS  | 1.1.1.1, 1.0.0.3 (Cloudflare, on WAN1)      |
| WAN2          | DHCP failover (auto DNS)                     |
| Email         | M365 / Exchange Online (MX → outlook.com)    |

### Public DNS Records (djvalley.com)

| Record              | Type  | Target                          | Proxied | Notes                                  |
|---------------------|-------|---------------------------------|---------|----------------------------------------|
| djvalley.com        | A     | 167.237.9.126                   | Yes     | Main domain, Cloudflare proxy → NPM    |
| atm10.djvalley.com  | A     | 167.237.9.126                   | No      | Direct WAN — Minecraft: All The Mods 10 (Pterodactyl) |
| sf.djvalley.com     | A     | 167.237.9.126                   | No      | Direct WAN — Satisfactory dedicated server (Pterodactyl) |
| hass.djvalley.com   | CNAME | *.ui.nabu.casa                  | No      | Home Assistant via Nabu Casa           |

> No Cloudflare Tunnel in use — public traffic flows WAN IP → Cloudflare proxy → NPM → internal services.
> Home Assistant is the exception: external access is via Nabu Casa cloud relay.

---

## VLANs

| VLAN | Name        | Subnet          | Gateway      | DHCP Range                    | DNS                        | Purpose                     |
|------|-------------|-----------------|--------------|-------------------------------|----------------------------|-----------------------------|
| 10   | Homelab     | 10.0.10.0/24    | 10.0.10.1    | 10.0.10.100 – 10.0.10.254     | 10.0.10.5, 10.0.10.6       | Infrastructure & servers    |
| 20   | Human Pawns | 10.0.20.0/24    | 10.0.20.1    | 10.0.20.10 – 10.0.20.254      | 10.0.10.5, 10.0.10.6       | Personal devices & family   |
| 50   | Orc Horde   | 10.0.50.0/24    | 10.0.50.1    | 10.0.50.100 – 10.0.50.254     | 10.0.10.5, 10.0.10.6       | IoT devices                 |
| —    | Default     | 192.168.1.0/24  | 192.168.1.1  | 192.168.1.6 – 192.168.1.254   | —                          | Legacy / untagged           |

---

## Network Hardware

| IP          | Hostname   | Role                          |
|-------------|------------|-------------------------------|
| 10.0.10.1   | UDR7       | Gateway / UniFi Dream Router 7 |
| 10.0.10.11  | pve02      | Proxmox node (UniFi sees as CWD53008) |
| 10.0.10.12  | pve03      | Proxmox node (UniFi sees as CWL01020) |
| 10.0.10.14  | pve05      | Proxmox node (UniFi sees as CWDA1002) |

---

## Internal DNS (Pi-hole)

| Role      | Hostname | IP         | Host Node | CT ID |
|-----------|----------|------------|-----------|-------|
| Primary   | pihole1  | 10.0.10.5  | pve01     | CT100 |
| Secondary | pihole2  | 10.0.10.6  | pve02     | CT102 |

Serves all VLANs. Upstream: Cloudflare (1.1.1.1 / 1.0.0.3).

---

## Proxmox Cluster

| Node  | IP          | CT/VM Count | RAM (used/total)    |
|-------|-------------|-------------|---------------------|
| pve01 | 10.0.10.10  | 2 CT, 2 VM  | ~25GB / 32GB        |
| pve02 | 10.0.10.11  | 1 CT, 2 VM  | ~15GB / 32GB        |
| pve03 | 10.0.10.12  | 2 CT, 0 VM  | ~3GB / 32GB         |
| pve04 | 10.0.10.13  | 0 CT, 1 VM  | ~18GB / 32GB        |
| pve05 | 10.0.10.14  | 1 CT, 0 VM  | ~11GB / 32GB        |
| pbs01 | 10.0.10.9   | —           | Proxmox Backup Server |

### Full Inventory

| ID     | Name                | Type | Node  | IP             | Purpose                          |
|--------|---------------------|------|-------|----------------|----------------------------------|
| CT100  | pihole1             | LXC  | pve01 | 10.0.10.5      | Pi-hole DNS primary              |
| VM101  | docker01            | VM   | pve01 | 10.0.10.100    | Docker host — main services      |
| CT102  | pihole2             | LXC  | pve02 | 10.0.10.6      | Pi-hole DNS secondary            |
| VM103  | docker02            | VM   | pve02 | 10.0.10.101    | Docker host — Immich             |
| CT104  | pterodactyl-panel   | LXC  | pve01 | 10.0.10.29     | Pterodactyl game panel           |
| CT105  | pterodactyl-wings   | LXC  | pve03 | 10.0.10.30     | Pterodactyl wings node 1         |
| VM106  | docker03            | VM   | pve04 | 10.0.10.102    | Docker host — LLM stack          |
| VM107  | hass                | VM   | pve01 | 10.0.10.20     | Home Assistant OS                |
| VM108  | discord-bots        | VM   | pve02 | 10.0.10.103    | Discord bot host                 |
| CT109  | claude-mgmt         | LXC  | pve03 | 10.0.10.104    | This container — mgmt/dev        |
| CT110  | pterodactyl-wings   | LXC  | pve05 | 10.0.10.31     | Pterodactyl wings node 2         |

---

## Docker Services

Managed via Portainer (https://10.0.10.100:9443). Reverse proxy: Nginx Proxy Manager on docker01.
Auth/SSO: Authentik on docker01.

### docker01 — 10.0.10.100 (Main services host)

| Container              | Image                           | Port(s)            | Purpose                        |
|------------------------|---------------------------------|--------------------|--------------------------------|
| npm                    | nginx-proxy-manager:2.13.6      | :80, :443, :81     | Reverse proxy + SSL termination |
| authentik-server       | goauthentik/server:2026.2.1     | —                  | SSO / identity provider        |
| authentik-worker       | goauthentik/server:2026.2.1     | —                  | Authentik background worker    |
| authentik-postgresql   | postgres:16-alpine              | —                  | Authentik database             |
| bookstack              | linuxserver/bookstack:v25.12.8  | —                  | Documentation / wiki           |
| bookstack-db           | mariadb:11.4.8                  | —                  | BookStack database             |
| n8n                    | n8nio/n8n:2.6.4                 | —                  | Automation workflows           |
| n8n-postgres           | postgres:16.6-alpine            | —                  | n8n database                   |
| paperless              | paperless-ngx:2.20.4            | :8000              | Document management            |
| paperless-db           | postgres:16.6                   | —                  | Paperless database             |
| paperless-redis        | redis:7.4.2                     | —                  | Paperless cache                |
| paperless-gotenberg    | gotenberg:8.9.2                 | —                  | Document conversion            |
| paperless-tika         | apache/tika:3.2.3.0-full        | —                  | Document parsing               |
| mealie                 | mealie:v3.9.2                   | —                  | Recipe manager                 |
| homepage               | gethomepage/homepage:latest     | —                  | Dashboard                      |
| uptime-kuma            | louislam/uptime-kuma:2.0.2      | —                  | Uptime monitoring              |
| ntfy                   | binwiederhier/ntfy:v2.16.0      | :2525              | Push notifications             |
| donetick               | donetick/donetick:v0.1.64       | :2021              | Task / chore tracker           |
| changedetector         | changedetection.io:0.54.4       | —                  | Web change monitoring          |
| it-tools               | it-tools:2024.10.22             | —                  | Developer utilities            |
| spoolman               | donkie/spoolman:0.22.1          | —                  | 3D printing filament tracker   |
| diun                   | crazymax/diun:4.28.0            | —                  | Docker image update notifier   |
| portainer              | portainer-ce:2.33.6             | :9000, :9443       | Container management UI        |

### docker02 — 10.0.10.101 (Immich host)

| Container                      | Image                        | Port(s)  | Purpose                     |
|--------------------------------|------------------------------|----------|-----------------------------|
| immich-immich-server-1         | immich-server:v2.5.6         | :2283    | Photo management            |
| immich-immich-machine-learning | immich-machine-learning:v2.5.6 | —      | AI/ML features              |
| immich-database-1              | postgres (vectorchord)        | —        | Immich database             |
| immich-redis-1                 | valkey:9                     | —        | Immich cache                |
| diun                           | crazymax/diun:4.28.0         | —        | Image update notifier       |
| portainer_agent                | portainer/agent:2.33.6       | :9001    | Portainer agent             |

### docker03 — 10.0.10.102 (LLM stack)

| Container      | Image                        | Port(s)              | Purpose                     |
|----------------|------------------------------|----------------------|-----------------------------|
| llm-ollama     | ollama/ollama:0.15.0         | :11434               | Local LLM runtime           |
| llm-openwebui  | open-webui:v0.7.2            | 10.0.10.102:8080     | Ollama web UI               |
| llm-litellm    | berriai/litellm:v1.81.3      | 10.0.10.102:4000     | LLM API proxy/router        |
| diun           | crazymax/diun:4.28.0         | —                    | Image update notifier       |
| portainer_agent | portainer/agent:2.33.6      | :9001                | Portainer agent             |

### Home Assistant — VM107 (10.0.10.20)

Runs Home Assistant OS directly on a VM. External access via Nabu Casa (hass.djvalley.com).
Not behind NPM — standalone HAOS install.

---

## Remote Access

### Tailscale

Not yet configured on any homelab nodes. Planned for future setup.

### Nabu Casa (Home Assistant)

- External URL: https://hass.djvalley.com
- Relay: Nabu Casa cloud (*.ui.nabu.casa)

---

## Reverse Proxy (NPM)

Nginx Proxy Manager on docker01. Admin UI: http://10.0.10.100:81 / public: https://npm.djvalley.com

| Public Domain               | Internal Target               |
|-----------------------------|-------------------------------|
| ai-api.djvalley.com         | http://10.0.10.102:4000       |
| ai.djvalley.com             | http://10.0.10.102:8080       |
| auth.djvalley.com           | http://server:9000 (Authentik)|
| change.djvalley.com         | http://changedetector:5000    |
| docker01.djvalley.com       | http://10.0.10.100:9000       |
| docs.djvalley.com           | http://paperless:8000         |
| hass.djvalley.com           | http://10.0.10.20:8123        |
| home.djvalley.com           | http://homepage:3000          |
| kuma.djvalley.com           | http://uptime-kuma:3001       |
| meals.djvalley.com          | http://mealie:9000            |
| n8n.djvalley.com            | http://n8n:5678               |
| npm.djvalley.com            | http://npm:81                 |
| ntfy.djvalley.com           | http://10.0.10.100:2525       |
| ollama.djvalley.com         | http://10.0.10.102:11434      |
| pbs01.djvalley.com          | https://10.0.10.9:8007        |
| photos.djvalley.com         | http://10.0.10.101:2283       |
| pihole1.djvalley.com        | http://10.0.10.5:80           |
| pihole2.djvalley.com        | http://10.0.10.6:80           |
| pve01–05.djvalley.com       | https://10.0.10.10–14:8006    |
| sparkyft.djvalley.com       | http://sparkyft-frontend:80 (STALE — no container) |
| spool.djvalley.com          | http://spoolman:8000          |
| tasks.djvalley.com          | http://donetick:2021          |
| tools.djvalley.com          | http://it-tools:80            |
| wiki.djvalley.com           | http://bookstack:80           |

---

## Key Workstations / Devices

| IP           | Hostname         | VLAN | Notes                |
|--------------|------------------|------|----------------------|
| 10.0.10.237  | David-PC         | 10   | Primary workstation  |
| 10.0.10.103  | discord-bots     | 10   | VM108 on pve02       |

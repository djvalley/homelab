# Network Topology

Overview of the home network, Proxmox host, and service connectivity. Fill in specifics as they are confirmed — do not assume IPs or hostnames.

---

## Physical / LAN

| Detail         | Value             |
|----------------|-------------------|
| Hardware       | UniFi             |
| LAN subnet     | `TODO`            |
| Gateway        | `TODO`            |
| DNS (internal) | `TODO`            |

### VLANs

> Document any VLANs in use. If not yet segmented, note that here.

| VLAN ID | Name | Subnet | Purpose |
|---------|------|--------|---------|
| TODO    |      |        |         |

---

## Proxmox Host

| Detail       | Value  |
|--------------|--------|
| Hostname     | `TODO` |
| LAN IP       | `TODO` |
| Tailscale IP | `TODO` |

### LXC Containers

| CT ID | Hostname | LAN IP | Purpose |
|-------|----------|--------|---------|
| TODO  | (this container) | `TODO` | Central management / dev |

### VMs

| VM ID | Hostname | LAN IP | Purpose |
|-------|----------|--------|---------|
| TODO  |          |        |         |

---

## Docker Services (on Proxmox host via Portainer)

| Service        | Internal Port | LAN URL / IP | Notes |
|----------------|---------------|--------------|-------|
| Immich         | `TODO`        | `TODO`       | Photo management |
| Paperless-ngx  | `TODO`        | `TODO`       | Document management |
| n8n            | `TODO`        | `TODO`       | Automation workflows |
| Home Assistant | `TODO`        | `TODO`       | Home automation |
| BookStack      | `TODO`        | `TODO`       | Documentation / wiki |
| Ollama         | `TODO`        | `TODO`       | Local LLM runtime |

---

## Remote Access

### Tailscale

- Mesh VPN for secure internal/remote access to all nodes
- Tailscale subnet routes: `TODO` (document any advertised routes)
- MagicDNS in use: `TODO` (yes/no, and base domain if yes)

| Node           | Tailscale IP | Role |
|----------------|--------------|------|
| Proxmox host   | `TODO`       |      |
| This container | `TODO`       |      |

### Cloudflare Tunnel

- Used for public-facing service exposure (no open inbound ports)
- Tunnel name / ID: `TODO`
- Cloudflare account / zone: `TODO`

| Public Domain | Proxied Service | Notes |
|---------------|-----------------|-------|
| `TODO`        |                 |       |

---

## DNS

> Document internal DNS setup — Pi-hole, AdGuard, router DNS, or Cloudflare-only.

| Type     | Provider / Host | Notes |
|----------|-----------------|-------|
| External | Cloudflare      |       |
| Internal | `TODO`          |       |

---

## Notes

- This file is the source of truth for network addressing. Update it when IPs or services change.
- Do not store credentials here — use `.env` files or a secrets manager.
- See [docs/services/](services/) for per-service notes including ports, quirks, and endpoints.

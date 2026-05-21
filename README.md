# Homelab

Central management and development environment for homelab projects, automation, and AI tooling.
Runs from a dedicated Ubuntu LXC container on Proxmox.

## Structure

| Directory  | Purpose |
|------------|---------|
| `projects/` | Self-contained coding projects, each in its own subdirectory |
| `mcp/`      | MCP server configs and any custom MCP servers |
| `scripts/`  | Reusable utility and automation scripts |
| `docs/`     | Infrastructure decisions, runbooks, and notes |
| `configs/`  | Service configuration templates (not live configs) |
| `docker/`   | Docker Compose files for services managed from this container |

## Services (on Proxmox host via Docker/Portainer)

- Immich — photo management
- Paperless-ngx — document management
- n8n — automation workflows
- Home Assistant — home automation
- BookStack — documentation/wiki
- Ollama — local LLM runtime

## Networking

- Tailscale — mesh VPN for internal/remote access
- Cloudflare Tunnel — public-facing service exposure
- UniFi — home network hardware

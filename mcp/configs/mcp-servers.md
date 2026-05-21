# MCP Server Configuration

All MCP servers are configured globally in `~/.claude.json` under `mcpServers`.
Credentials are stored in `/opt/homelab/.env` (gitignored).

## Configured Servers

| Server       | Package                        | Transport | Auth             |
|--------------|--------------------------------|-----------|------------------|
| proxmox      | mcp-proxmox (Python/uvx)       | stdio     | API token        |
| portainer    | portainer-mcp-server (npm)     | stdio     | PAT token        |
| paperless    | @nloui/paperless-mcp (npm)     | stdio     | API token (arg)  |
| n8n          | n8n-mcp (npm)                  | stdio     | API key          |
| bookstack    | bookstack-mcp (npm)            | stdio     | Token ID+Secret  |
| mealie       | mealie-mcp-server-ts (npm)     | stdio     | Bearer token     |
| pihole       | @ranklancer/pihole-mcp (npm)   | stdio     | App password     |
| uptime-kuma  | @davidfuchs/mcp-uptime-kuma    | stdio     | Username+password|
| ntfy         | ntfy-mcp-server (npm)          | stdio     | None (pending)   |

## Pending

- **Home Assistant** — HA MCP Server integration not yet enabled in HA.
  Enable: Settings → Devices & Services → + Add Integration → "MCP Server"
  Once enabled, add to `~/.claude.json`:
  ```json
  "home-assistant": {
    "url": "http://10.0.10.20:8123/api/mcp_server",
    "headers": {
      "Authorization": "Bearer <HASS_TOKEN from .env>"
    }
  }
  ```

- **Immich** — No suitable MCP package found. Will build custom or revisit.

- **ntfy auth** — Token not yet configured. Once created, add to mcpServers:
  `"NTFY_AUTH_TOKEN": "<token>"`

## Runtime Requirements

- Node.js: v24 (`/usr/bin/node`, `/usr/bin/npx`)
- uvx: `/home/straken/.local/bin/uvx` (Python MCP runner)

## Notes

- `npx -y` auto-downloads packages on first run — no global install needed
- Pi-hole MCP uses the v6 app password (not admin password)
- BookStack write operations enabled (`BOOKSTACK_ENABLE_WRITE=true`)
- All `*.djvalley.com` domains resolve internally via Pi-hole split DNS → `10.0.10.100`

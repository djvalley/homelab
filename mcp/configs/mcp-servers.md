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
| home-assistant | HA built-in MCP Server       | HTTP POST | Bearer token     |

## Home Assistant Notes

- Integration: `mcp_server` (title: "Assist"), state: loaded in HA 2026.5.0
- Endpoint: `http://10.0.10.20:8123/api/mcp` — streamable HTTP transport (POST)
- Authentication: Bearer token (long-lived access token, expires 2027)

## Pending / Known Gaps

- **Immich** — No suitable MCP package found. Will build custom or revisit.
- **ntfy auth** — Token not yet configured. Once created, add to mcpServers env:
  `"NTFY_AUTH_TOKEN": "<token>"`

## Runtime Requirements

- Node.js: v24 (`/usr/bin/node`, `/usr/bin/npx`)
- uvx: `/home/straken/.local/bin/uvx` (Python MCP runner)

## Notes

- `npx -y` auto-downloads packages on first run — no global install needed
- Pi-hole MCP uses the v6 app password (not admin password)
- BookStack write operations enabled (`BOOKSTACK_ENABLE_WRITE=true`)
- All `*.djvalley.com` domains resolve internally via Pi-hole split DNS → `10.0.10.100`

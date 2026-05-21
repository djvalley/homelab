# Services Overview

All self-hosted services. Reverse proxy is Nginx Proxy Manager on docker01. All public URLs are `*.djvalley.com` with SSL via NPM. See [network.md](../network.md) for host/IP details.

## Infrastructure

| Service            | Host      | Internal URL                     | Public URL                         |
|--------------------|-----------|----------------------------------|------------------------------------|
| Nginx Proxy Manager | docker01 | http://10.0.10.100:81 (admin)    | https://npm.djvalley.com           |
| Portainer          | docker01  | https://10.0.10.100:9443         | https://docker01.djvalley.com      |
| Authentik (SSO)    | docker01  | http://10.0.10.100 (via Docker)  | https://auth.djvalley.com          |
| Pi-hole (primary)  | pve01     | http://10.0.10.5/admin           | https://pihole1.djvalley.com       |
| Pi-hole (secondary)| pve02     | http://10.0.10.6/admin           | https://pihole2.djvalley.com       |
| Uptime Kuma        | docker01  | http://uptime-kuma:3001 (Docker) | https://kuma.djvalley.com          |
| pve01              | pve01     | https://10.0.10.10:8006          | https://pve01.djvalley.com         |
| pve02              | pve02     | https://10.0.10.11:8006          | https://pve02.djvalley.com         |
| pve03              | pve03     | https://10.0.10.12:8006          | https://pve03.djvalley.com         |
| pve04              | pve04     | https://10.0.10.13:8006          | https://pve04.djvalley.com         |
| pve05              | pve05     | https://10.0.10.14:8006          | https://pve05.djvalley.com         |
| PBS                | pbs01     | https://10.0.10.9:8007           | https://pbs01.djvalley.com         |

## Documents & Knowledge

| Service       | Host     | Internal URL                      | Public URL                      |
|---------------|----------|-----------------------------------|---------------------------------|
| Paperless-ngx | docker01 | http://10.0.10.100:8000           | https://docs.djvalley.com       |
| BookStack     | docker01 | http://bookstack:80 (Docker)      | https://wiki.djvalley.com       |

## Media & Photos

| Service | Host     | Internal URL                  | Public URL                      |
|---------|----------|-------------------------------|---------------------------------|
| Immich  | docker02 | http://10.0.10.101:2283       | https://photos.djvalley.com     |

## Automation & Monitoring

| Service           | Host     | Internal URL                     | Public URL                         |
|-------------------|----------|----------------------------------|------------------------------------|
| n8n               | docker01 | http://n8n:5678 (Docker)         | https://n8n.djvalley.com           |
| Changedetection   | docker01 | http://changedetector:5000       | https://change.djvalley.com        |
| Home Assistant    | VM/pve01 | http://10.0.10.20:8123           | https://hass.djvalley.com (Nabu Casa) |
| ntfy              | docker01 | http://10.0.10.100:2525          | https://ntfy.djvalley.com          |

## AI / LLM

| Service    | Host     | Internal URL                  | Public URL                      |
|------------|----------|-------------------------------|---------------------------------|
| Open WebUI | docker03 | http://10.0.10.102:8080       | https://ai.djvalley.com         |
| LiteLLM    | docker03 | http://10.0.10.102:4000       | https://ai-api.djvalley.com     |
| Ollama     | docker03 | http://10.0.10.102:11434      | https://ollama.djvalley.com     |

## Productivity & Utilities

| Service         | Host     | Internal URL                   | Public URL                      |
|-----------------|----------|--------------------------------|---------------------------------|
| Mealie (recipes)| docker01 | http://mealie:9000 (Docker)    | https://meals.djvalley.com      |
| Donetick (tasks)| docker01 | http://10.0.10.100:2021        | https://tasks.djvalley.com      |
| IT Tools        | docker01 | http://it-tools:80 (Docker)    | https://tools.djvalley.com      |
| Spoolman        | docker01 | http://spoolman:8000 (Docker)  | https://spool.djvalley.com      |
| Homepage        | docker01 | http://homepage:3000 (Docker)  | https://home.djvalley.com       |

## Game Servers

| Service             | Host  | Internal URL        | Public URL                        |
|---------------------|-------|---------------------|-----------------------------------|
| Pterodactyl Panel   | pve01 | http://10.0.10.29   | TODO — port unknown               |
| Pterodactyl Wings 1 | pve03 | http://10.0.10.30   | —                                 |
| Pterodactyl Wings 2 | pve05 | http://10.0.10.31   | —                                 |

## Stale / Inactive

| Service      | Notes                                                          |
|--------------|----------------------------------------------------------------|
| sparkyft     | NPM proxy entry exists (sparkyft.djvalley.com) but no container running on any host |
| ilo-fans-controller | Container exited on docker01                          |
| nebula-sync  | Container exited on docker01                                   |

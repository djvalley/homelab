# Services Overview

All self-hosted services in the homelab. See individual service files for ports, quirks, and endpoints.

| Service           | Host      | Internal URL                        | Public URL                       | Category        |
|-------------------|-----------|-------------------------------------|----------------------------------|-----------------|
| Nginx Proxy Mgr   | docker01  | http://10.0.10.100:81 (admin)       | —                                | Infrastructure  |
| Portainer         | docker01  | https://10.0.10.100:9443            | —                                | Infrastructure  |
| Authentik         | docker01  | TODO (via NPM)                      | TODO                             | Infrastructure  |
| Pi-hole (primary) | pve01     | http://10.0.10.5/admin              | —                                | Infrastructure  |
| Pi-hole (secondary)| pve02    | http://10.0.10.6/admin              | —                                | Infrastructure  |
| Uptime Kuma       | docker01  | TODO (via NPM)                      | TODO                             | Infrastructure  |
| Paperless-ngx     | docker01  | http://10.0.10.100:8000             | TODO                             | Documents       |
| Immich            | docker02  | http://10.0.10.101:2283             | TODO                             | Photos          |
| BookStack         | docker01  | TODO (via NPM)                      | TODO                             | Documentation   |
| n8n               | docker01  | TODO (via NPM)                      | TODO                             | Automation      |
| Home Assistant    | VM/pve01  | http://10.0.10.20:8123              | https://hass.djvalley.com        | Home Automation |
| Mealie            | docker01  | TODO (via NPM)                      | TODO                             | Recipes         |
| Ollama            | docker03  | http://10.0.10.102:11434            | —                                | AI/LLM          |
| Open WebUI        | docker03  | http://10.0.10.102:8080             | TODO                             | AI/LLM          |
| LiteLLM           | docker03  | http://10.0.10.102:4000             | —                                | AI/LLM          |
| ntfy              | docker01  | http://10.0.10.100:2525             | TODO                             | Notifications   |
| Donetick          | docker01  | http://10.0.10.100:2021             | TODO                             | Productivity    |
| Changedetection   | docker01  | TODO (via NPM)                      | —                                | Monitoring      |
| IT Tools          | docker01  | TODO (via NPM)                      | —                                | Utilities       |
| Spoolman          | docker01  | TODO (via NPM)                      | —                                | 3D Printing     |
| Pterodactyl Panel | pve01     | http://10.0.10.29 (TODO port)       | TODO                             | Game Servers    |

> **TODO:** NPM proxy host list needed to fill in internal URLs for proxied services and all public domain mappings.
> NPM admin: http://10.0.10.100:81

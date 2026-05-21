# docker/

Docker Compose files for services managed from this container. Each service or stack gets its own subdirectory.

## Convention

```
docker/
└── my-stack/
    ├── docker-compose.yml
    ├── .env.example       # committed
    └── .env               # NOT committed — add to .gitignore
```

## Note

Most homelab services run on the Proxmox host via Portainer. This directory is for anything deployed or managed directly from this LXC container.

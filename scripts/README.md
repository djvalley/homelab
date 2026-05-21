# scripts/

Reusable utility and automation scripts. Organized by scope or service.

## Convention

- Scripts should be executable (`chmod +x`) and include a shebang line
- Each script should have a brief comment block at the top describing purpose, usage, and any required env vars
- Prefer Bash for system ops, Python for anything needing data manipulation or API calls

## Structure

```
scripts/
├── common/         # Shared helpers/functions sourced by other scripts
├── backup/         # Backup and restore scripts
├── maintenance/    # System maintenance, cleanup, updates
└── <service>/      # Service-specific scripts as needed
```

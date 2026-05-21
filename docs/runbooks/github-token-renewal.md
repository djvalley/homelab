# Runbook: GitHub Token Renewal

Renew the fine-grained PAT used by `gh` CLI on this container for GitHub access.

**Token expiry:** 2026-08-19 (90-day token, created 2026-05-21)
**GitHub account:** djvalley

---

## When to do this

- Token has expired (gh commands fail with 401 / authentication errors)
- Proactively before the expiry date (GitHub sends an email warning ~7 days prior)

---

## Steps

### 1. Generate a new token on GitHub

1. Go to: **GitHub → Settings → Developer settings → Personal access tokens → Fine-grained tokens**
2. Click **Generate new token**
3. Set:
   - **Token name:** `homelab-lxc` (or append the year, e.g. `homelab-lxc-2026`)
   - **Expiration:** 90 days (or your preference)
   - **Resource owner:** djvalley
   - **Repository access:** All repositories

4. Set these permissions (minimum required):

   | Permission | Level |
   |------------|-------|
   | Account > Administration | Read and write |
   | Repository > Contents | Read and write |
   | Repository > Metadata | Read (auto-selected) |

5. Click **Generate token** and copy it immediately — it is only shown once.

### 2. Apply the new token on this container

```bash
gh auth login --with-token <<< "YOUR_NEW_TOKEN_HERE"
```

### 3. Verify

```bash
gh auth status
```

Should show: `✓ Logged in to github.com account djvalley`

### 4. Test a repo operation

```bash
gh repo list --limit 5
```

### 5. Update the expiry date in memory

Update the expiry date in:
- `/home/straken/.claude/projects/-opt-homelab/memory/project_github_repo.md`
- The **Token expiry** line at the top of this file

---

## Troubleshooting

- **401 errors after applying token:** Double-check the token was copied correctly (no trailing whitespace).
- **Permission denied on repo operations:** Confirm the token has `Repository > Contents: Read and write`.
- **Cannot create repos:** Confirm the token has `Account > Administration: Read and write`.
- **Wrong account:** Run `gh auth logout` first, then re-login.

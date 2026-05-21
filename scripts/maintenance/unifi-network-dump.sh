#!/usr/bin/env bash
# Query UniFi API for network topology — VLANs, devices, and connected clients.
# Requires: UNIFI_IP and UNIFI_API_KEY set in environment or .env file.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/../../.env"

if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$ENV_FILE"
fi

: "${UNIFI_IP:?UNIFI_IP not set}"
: "${UNIFI_API_KEY:?UNIFI_API_KEY not set}"

BASE="https://${UNIFI_IP}/proxy/network/api/s/default"

echo "=== Networks / VLANs ==="
curl -sk -H "X-API-KEY: ${UNIFI_API_KEY}" "${BASE}/rest/networkconf" \
  | python3 -c "
import json, sys
data = json.load(sys.stdin)['data']
for n in data:
    purpose = n.get('purpose', '')
    name = n.get('name', '')
    if purpose in ('corporate', 'guest', 'vlan-only'):
        print(f\"  {name} — VLAN:{n.get('vlan','none'):>4}  {n.get('ip_subnet','n/a'):20}  DNS: {n.get('dhcpd_dns_1','')} {n.get('dhcpd_dns_2','')}\")
    elif purpose == 'wan':
        print(f\"  {name} (WAN) — DNS: {n.get('wan_dns1','auto')} {n.get('wan_dns2','')}\")
"

echo ""
echo "=== Connected Clients ==="
curl -sk -H "X-API-KEY: ${UNIFI_API_KEY}" "${BASE}/stat/sta" \
  | python3 -c "
import json, sys
data = json.load(sys.stdin)['data']
data.sort(key=lambda x: [int(p) for p in x.get('ip','0.0.0.0').split('.')] if x.get('ip') else [999])
for d in data:
    name = d.get('hostname') or d.get('name') or 'unknown'
    print(f\"  {d.get('ip','?'):18} {name:35} VLAN:{d.get('vlan','0'):>4}  {d.get('mac','')}\")
"

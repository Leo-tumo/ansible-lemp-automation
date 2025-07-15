#!/bin/bash
set -e

PLAYBOOK="${1:-site.yml}"
INVENTORY="${2:-inventory/production}"
TAGS="${3:-all}"

echo "Starting deployment..."
echo "Playbook: $PLAYBOOK"
echo "Inventory: $INVENTORY"
echo "Tags: $TAGS"

if [ "$TAGS" = "all" ]; then
    ansible-playbook -i "$INVENTORY" "$PLAYBOOK" --vault-password-file .vault_pass
else
    ansible-playbook -i "$INVENTORY" "$PLAYBOOK" --vault-password-file .vault_pass --tags "$TAGS"
fi

echo "Deployment completed successfully!"

echo "Running post-deployment checks..."
ansible -i "$INVENTORY" webservers -m uri -a "url=http://{{ inventory_hostname }} method=GET"

echo "All checks passed!"
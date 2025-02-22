#!/usr/bin/env bash

# Activate python virtualenv
if [[ -d .venv ]]; then
  source .venv/bin/activate
fi

# Re-Use vagrant inventory file
ANSIBLE_INVENTORY=.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory

# Colors
RED='\033[0;31m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Load environment variables from .env file if it exists
if [[ -f .env ]]; then
  export $(cat .env | xargs)
fi

# Check if the ANSIBLE_VAULT_PASSWORD_FILE environment variable is set
if [[ -z "${ANSIBLE_VAULT_PASSWORD_FILE}" ]]
then
  echo "$RED ANSIBLE_VAULT_PASSWORD_FILE is not set $NC"
  exit 1
fi


# Launch ansible playbook
ansible-playbook \
    -i ${ANSIBLE_INVENTORY} \
    --vault-id="default@${ANSIBLE_VAULT_PASSWORD_FILE}" \
    -e @ansible-vars.yml \
    ./ansible/vagrant-playbook.yml

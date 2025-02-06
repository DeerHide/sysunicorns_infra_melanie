#!/usr/bin/env bash

# Activate python virtualenv
if [[ -d .venv ]]; then
  source .venv/bin/activate
fi

ANSIBLE_INVENTORY=ansible/inventories/inventory.ini

# Launch ansible playbook
ansible-playbook \
    -i ${ANSIBLE_INVENTORY} \
    ./ansible/ping-playbook.yml \

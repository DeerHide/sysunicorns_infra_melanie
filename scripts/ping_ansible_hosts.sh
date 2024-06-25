#!/usr/bin/env bash

ANSIBLE_INVENTORY=ansible/inventories/inventory.ini

# Launch ansible playbook
ansible-playbook \
    -i ${ANSIBLE_INVENTORY} \
    ./ansible/ping-playbook.yml \

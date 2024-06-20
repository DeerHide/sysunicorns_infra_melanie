#!/usr/bin/env bash

ANSIBLE_INVENTORY=ansible/inventories/melanie.ini

# Launch ansible playbook
ansible-playbook \
    -i ${ANSIBLE_INVENTORY} \
    ./ansible/melanie-playbook.yml

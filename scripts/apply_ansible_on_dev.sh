#!/usr/bin/env bash

# Re-Use vagrant inventory file
ANSIBLE_INVENTORY=.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory

# Launch ansible playbook
ansible-playbook \
    -vvvv \
    -i ${ANSIBLE_INVENTORY} \
    ./ansible/vagrant-playbook.yml

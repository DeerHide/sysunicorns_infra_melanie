#!/usr/bin/env bash

set -euo pipefail

SSH_IDENTITY_ALGO=ed25519
SSH_IDENTITY_BITS=4096

SSH_IDENTITY_FILE_PATH=~/.ssh/melanie.localunicorns.info
SSH_CONFIG_PATH=~/.ssh/config.d/melanie.localunicorns.info
SSH_USER=deerhide-operator
SSH_HOSTNAME=melanie.localunicorns.info
SSH_PORT=22


function setup_dot_ssh(){
    mkdir -p $HOME/.ssh
    chmod 0700 $HOME/.ssh
}

function generate_identity(){

    local force_arg=${1:-""}

    if [[ -f ${SSH_IDENTITY_FILE_PATH} ]]; then
        echo "${SSH_IDENTITY_FILE_PATH} already exist"
        if [[ ${force_arg} == "force" ]]; then
            echo "${SSH_IDENTITY_FILE_PATH} to be removed"
            rm -f ${SSH_IDENTITY_FILE_PATH}
        else
            echo "Stopped"
            exit -1
        fi
    fi

    # Generate ssh identity
    ssh-keygen \
        -t ${SSH_IDENTITY_ALGO} \
        -b ${SSH_IDENTITY_BITS} \
        -f ${SSH_IDENTITY_FILE_PATH}

}

function deploy_identity(){
    # Deploy the just generate identity to the server
    ssh-copy-id \
        -i ${SSH_IDENTITY_FILE_PATH} \
        -p ${SSH_PORT} \
        ${SSH_USER}@${SSH_HOSTNAME}
}

function setup_ssh_config(){
    # Create if don't exist a config.d file
    mkdir -p ~/.ssh/config.d

    # Ensure ~/.ssh/config contains the following line
    # Include config.d/*
    if [[ ! -f ~/.ssh/config ]]; then
        echo "Include config.d/*" > ~/.ssh/config
    else
        if ! grep -q "Include config.d/*" ~/.ssh/config; then
            echo "Include config.d/*" >> ~/.ssh/config
        fi
    fi

    # Ensure ~/.ssh/config is only readable by the owner
    chmod 0600 ~/.ssh/config

}

function deploy_ssh_config(){
    # Create the value for an ssh_config no client
    # This is to ensure that the client uses the correct identity file
    cat > ${SSH_CONFIG_PATH} <<EOF
        Host ${SSH_HOSTNAME}
            HostName ${SSH_HOSTNAME}
            User ${SSH_USER}
            Port ${SSH_PORT}
            IdentityFile ${SSH_IDENTITY_FILE_PATH}
EOF
    chmod 0600 ${SSH_CONFIG_PATH}

}

function clean_known_hosts(){
    # Remove the entry from known_hosts
    ssh-keygen -R ${SSH_HOSTNAME}
}

function main(){

    # retrive force argument can be empty or force value
    local force_arg=$1

    setup_dot_ssh
    generate_identity ${force_arg}
    deploy_identity
    setup_ssh_config
    deploy_ssh_config
    clean_known_hosts
}


main ${1:-""}

#!/usr/bin/env bash

set -euo pipefail

SSH_IDENTITY_ALGO=ed25519
SSH_IDENTITY_BITS=4096

SSH_IDENTITY_FILE_PATH=~/.ssh/rasp-00.localunicorns.info
SSH_CONFIG_PATH=~/.ssh/config.d/rasp-00.localunicorns.info
SSH_USER=deerhide-operator
SSH_HOSTNAME=rasp-00.localunicorns.info
SSH_PORT=22

SSH_HOSTNAME_RASP_DIGIT=("01" "02")
# "01" "02" "03" "04" "05" "06" "07" "08" "09" "10"


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
    local rasp_hostname=$1
    local rasp_password=$2
    # Deploy the just generate identity to the server
    echo "Trying deploy identity to $rasp_hostname"
    sshpass -v -p $rasp_password ssh-copy-id -o "StrictHostKeyChecking=no" -i ${SSH_IDENTITY_FILE_PATH} -p ${SSH_PORT} -f ${SSH_USER}@${rasp_hostname}
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
    local rasp_hostname=$1
    # Create the value for an ssh_config no client
    # This is to ensure that the client uses the correct identity file
    rasp_config_path=~/.ssh/config.d/${rasp_hostname}

    echo deploy_ssh_config:$rasp_hostname
    cat > ${rasp_config_path} <<EOF
        Host ${rasp_hostname}
            HostName ${rasp_hostname}
            User ${SSH_USER}
            Port ${SSH_PORT}
            IdentityFile ${SSH_IDENTITY_FILE_PATH}
EOF
    chmod 0600 ${rasp_config_path}

}

function clean_known_hosts(){
    local rasp_hostname=$1
    # Remove the entry from known_hosts
    ssh-keygen -R ${rasp_hostname}
}

function main(){

    # retrive force argument can be empty or force value
    local rasp_password=$1
    local force_arg=$2

    # Prepare the .ssh, .ssh/config and .ssh/config.d
    setup_dot_ssh
    setup_ssh_config
    # Generate identities
    generate_identity ${force_arg}
    # Deploy to all rasp
    for rasp_digit in ${SSH_HOSTNAME_RASP_DIGIT[@]};
    do
        rasp_hostname="rasp-${rasp_digit}.localunicorns.info"
        deploy_ssh_config ${rasp_hostname}
        deploy_identity ${rasp_hostname} ${rasp_password}
        clean_known_hosts ${rasp_hostname}
    done
}


main ${1} ${2:-""}

#!/usr/bin/env bash

set -euo pipefail

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
  echo "$ROUGE ANSIBLE_VAULT_PASSWORD_FILE is not set $NC"
  exit 1
fi

# Check if the ansible-vars.yaml.encrypted file exists and remove it
if [[ -f ansible-vars.yml.encrypted ]]
then
  echo "$ORANGE Removing existing ansible-vars.yaml.encrypted $NC"
  rm -f ansible-vars.yml.encrypted
fi

# Encrypt the ansible-vars.yaml file
ansible-vault \
  encrypt \
  --encrypt-vault-id=default \
  --vault-password-file="${ANSIBLE_VAULT_PASSWORD_FILE}" \
  --output=ansible-vars.yml.encrypted \
  ansible-vars.yml

echo "$GREEN ansible-vars.yml has been encrypted to ansible-vars.yaml.encrypted $NC"

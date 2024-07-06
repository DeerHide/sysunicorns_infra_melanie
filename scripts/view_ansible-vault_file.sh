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

keys=$(yq e '. | keys | .[]' ansible-vars.yml)

for key in $keys; do
  echo -e "Key: ${key}"
  ansible -m ansible.builtin.debug -a "var=${key}" -e "@ansible-vars.yml" --vault-password-file ${ANSIBLE_VAULT_PASSWORD_FILE} localhost
done

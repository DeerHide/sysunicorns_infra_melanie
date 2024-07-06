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

variable_name_to_encrypt=${1:-""}

if [[ -z "${variable_name_to_encrypt}" ]]
then
  echo -e "$RED Please provide the variable name to encrypt $NC"
  exit 1
fi

function encrypt_value(){
  local variable_name_to_encrypt=$1
  actual_variable_value=$(yq e ".${variable_name_to_encrypt} | sub(\"\n$\",\"\")" ansible-vars.yml )
  echo -n "${actual_variable_value}" | ansible-vault \
    encrypt_string \
    --encrypt-vault-id=default \
    --vault-password-file ${ANSIBLE_VAULT_PASSWORD_FILE} \
    -n "${variable_name_to_encrypt}"
}

new_value=$(encrypt_value ${variable_name_to_encrypt})
yq e -i ".${variable_name_to_encrypt} = \"${new_value}\"" ansible-vars.yml
sed -i 's/ |-//g' ansible-vars.yml
yq -i e "." ansible-vars.yml

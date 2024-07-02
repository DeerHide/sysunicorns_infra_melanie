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
  echo "$RED ANSIBLE_VAULT_PASSWORD_FILE is not set $NC"
  exit 1
fi

if [[ -f ansible-vars.yml ]]
then
  echo "$ORANGE ansible-vars.yaml exists and will be overwritten $NC"
  echo "$ORANGE Press Enter to continue or Ctrl+C to cancel $NC"
  read
  rm -f ansible-vars.yml
fi

ansible-vault \
  decrypt \
  --vault-id=default \
  --vault-password-file="${ANSIBLE_VAULT_PASSWORD_FILE}" \
  --output=ansible-vars.yml \
  ansible-vars.yml.encrypted

echo "$GREEN ansible-vars.yml has been decrypted from ansible-vars.yaml.encrypted $NC"

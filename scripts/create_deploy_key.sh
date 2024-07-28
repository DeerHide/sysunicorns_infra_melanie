#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

mkdir -p ./tmp

if [[ -f "./tmp/github_deploy_key" ]]; then
  echo -e "${RED}Deploy key already exists${NC}"
  rm ./tmp/github_deploy_key
fi

if [[ -f "./tmp/github_deploy_key.pub" ]]; then
  echo -e "${RED}Public key already exists${NC}"
  rm ./tmp/github_deploy_key.pub
fi

ssh-keygen \
  -t rsa \
  -b 4096 \
  -C "melanie@deerhide.run" \
  -f ./tmp/github_deploy_key \
  -N ""

#!/usr/bin/env bash

if [[ -d .venv ]]; then
    rm -rf .venv
fi

python3 -m venv .venv

pip install ansible
pip install ansible-dev-tools

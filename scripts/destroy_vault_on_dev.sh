#!/usr/bin/env bash

set -euo pipefail

function on_dev() {
  ssh deerhide-operator@192.168.1.35 -C "$@"
}

on_dev docker stop svc_vault
on_dev docker rm svc_vault
on_dev docker volume rm svc_vault_config svc_vault_file svc_vault_logs
on_dev sudo rm -rf /var/docker_volumes/svc_vault_*

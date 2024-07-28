#!/usr/bin/env bash

set -euo pipefail

function on_melanie() {
  ssh melanie.localunicorns.info -C "$@"
}

on_melanie docker stop svc_vault
on_melanie docker rm svc_vault
on_melanie docker volume rm svc_vault_config svc_vault_file svc_vault_logs
on_melanie sudo rm -rf /var/docker_volumes/svc_vault_*

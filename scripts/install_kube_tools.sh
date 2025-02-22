#!/usr/bin/env bash

# Kubectl
sudo curl -Lo /usr/local/bin/kubectl \
  "https://dl.k8s.io/release/$(\
  curl -L -s https://dl.k8s.io/release/stable.txt\
  )/bin/linux/amd64/kubectl"
sudo chmod +x /usr/local/bin/kubectl

# Clusterctl -> Sidero Tool
# https://www.sidero.dev/
sudo curl -Lo /usr/local/bin/clusterctl \
  "https://github.com/kubernetes-sigs/cluster-api/releases/download/v1.5.0/clusterctl-$(uname -s | tr '[:upper:]' '[:lower:]')-amd64"
sudo chmod +x /usr/local/bin/clusterctl

# Talosctl -> Sidero / Talos Tool
# https://www.talos.dev/
sudo curl -Lo /usr/local/bin/talosctl \
 "https://github.com/talos-systems/talos/releases/latest/download/talosctl-$(uname -s | tr '[:upper:]' '[:lower:]')-amd64"
sudo chmod +x /usr/local/bin/talosctl


# sysunicorns_infra_melanie
Configuration and Setup of "melanie" server

# Initial Setup
```bash
# Update the repositories list content
sudo apt-get update

# Upgrade packages from the repositories list
sudo apt-get upgrade -y

# Upgrade Distribution/system(Linux Kernel)
sudo apt-get dist-upgrade -y

# Verify if git is install and check version
git --version

# Setup SSH auth with github
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

# Add SSH key to github
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account

# Setup Commit Signature(GPG) with github
https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key

# Clone of Melanie repo
git clone git@github.com:DeerHide/sysunicorns_infra_melanie.git

```

# Vagrant Install (Ubuntu, Optional: WSL)
```bash
# Download the signed key from web and decrypt the file
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add the package at the list of repositories with the signed key
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update the repositories list content and install vagrant
sudo apt update && sudo apt install vagrant

# (Optional - WSL Only) Follow the link for granted access on windows features
https://developer.hashicorp.com/vagrant/docs/other/wsl

# Validate the Vagrantfile
vagrant validate

# (Optional - WSL Only) Install plugin vagrant for virtualbox and WSL Users
vagrant plugin install virtualbox_WSL2

```

# Ansible install
```bash

# Install ansible
https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

```
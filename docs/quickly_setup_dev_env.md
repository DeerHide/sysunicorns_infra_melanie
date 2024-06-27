
# Scripts

## Specific

### Ubuntu with WSL

```sh
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install vagrant

    vagrant plugin install virtualbox_WSL2
```

### MacOS

```sh
    brew tap hashicorp/tap
    brew install hashicorp/tap/vagrant

```

## Generic

```sh

    # required for ansible
    python3 -m pip install ansible

    # required for pre-commit
    pip3 install pre-commit

    # required for ansible-lint
    pip3 install ansible-dev-tools


```

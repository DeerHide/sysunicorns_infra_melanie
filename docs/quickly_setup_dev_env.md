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

    ./scripts/install_ansible.sh
    ./scripts/install_kube_took.sh # TODO: replace with ansible dev env
    source .venv/bin/activate
    pip install pre-commit
    pre-commit install

```

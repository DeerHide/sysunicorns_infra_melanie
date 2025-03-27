Vagrant.require_version ">= 2.4.1"


Vagrant.configure("2") do |config|

    # Use the "Vagrant" Ubuntu 22.04 box as a base image
    # It's like a VM snapshot
    config.vm.box = "generic/ubuntu2204"

    # We use provider "VirtualBox" v7.0.8 to run the VM on much OS(s) as possible
    config.vm.provider "virtualbox"

    # Due to the usage of a "generic/ubuntu2204" box, the default user is "vagrant"
    # For the box, the username and password are "vagrant"
    config.ssh.username = "vagrant"

    # We use fixed IP address for the VM and set bridge adapter to the host's network adapter
    ## You need to change the IP address and the bridge adapter to match your network configuration
    config.vm.network "public_network", ip: "192.168.1.100", bridge: "Intel(R) Ethernet Controller (3) I225-V", adapter: 2

    # Vagrant VM customization documentation: https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/configuration
    config.vm.provider "virtualbox" do |vb|
        vb.name = "melanie-dev"
        vb.memory = "4096"
        vb.cpus = 4
        # VBox parameters for the customization: https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm
        vb.customize ["modifyvm", :id, "--vrde", "off"]
        vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
        vb.customize ["modifyvm", :id, "--paravirt-provider", "hyperv"]
        vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
        vb.customize ["modifyvm", :id, "--accelerate-3d", "on"]
        vb.customize ["modifyvm", :id, "--chipset", "ich9"]
        vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    end

    config.vm.define "melanie-dev" do |node|
    end

    config.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update
        sudo apt-get install -y python3-pip
    SHELL

    # Run tasks with the vagrant user
    # Set vagrant as the default user for the tasks with the "vagrant_user" tag
    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/vagrant-playbook.yml"
        ansible.compatibility_mode = "2.0"
        ansible.tags = "vagrant_user"
    end

    # Run tasks with the deerhide-operator user
    # Set deerhide-operator as the default user for the tasks with the "deerhide_operator_user" tag
    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/vagrant-playbook.yml"
        ansible.compatibility_mode = "2.0"
        ansible.tags = "deerhide_operator_user"
        ansible.extra_vars = {
            ansible_user: "deerhide-operator",
            ansible_become: true,
            ansible_become_user: "deerhide-operator"
        }
    end
end

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

    config.vm.network "public_network", type: "dhcp", adapter: 2

    # Vagrant VM customization documentation: https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/configuration
    config.vm.provider "virtualbox" do |vb|
        vb.name = "melanie-dev"
        vb.memory = "4096"
        vb.cpus = 4
        vb.check_guest_additions = false
        # VBox parameters for the customization: https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm
        vb.customize ["modifyvm", :id, "--vrde", "off"]
        vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
        vb.customize ["modifyvm", :id, "--paravirt-provider", "hyperv"]
        vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
        vb.customize ["modifyvm", :id, "--accelerate-3d", "on"]
        vb.customize ["modifyvm", :id, "--chipset", "ich9"]
    end

    config.vm.define "melanie-dev" do |node|
    end

    config.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update
        sudo apt-get install -y python3-pip
    SHELL

    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/vagrant-playbook.yml"
        ansible.compatibility_mode = "2.0"
    end
end

Vagrant.require_version ">= 2.4.1"


Vagrant.configure("2") do |config|
    
    # Use "Vagrant" Ubuntu 22.04 box as a base image
    # It's like a vm snapshot
    config.vm.box = "generic/ubuntu2204"
    
    # We use provider "virtualbox" v7.0.8 to run the VM on much OS(s) as possible
    config.vm.provider "virtualbox"
    
    # Due to the usage of "generic/ubuntu2204" box, the default user is "vagrant"
    # from the box, and the password is "vagrant"
    config.ssh.username = "vagrant"


    # Vagrant VM customization documentation: https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/configuration
    config.vm.provider "virtualbox" do |vb|
        # VM name
        vb.name = "melanie-dev"
        # meory capacity
        vb.memory = "4096"
        # CPU count
        vb.cpus = 4
        # VBox parameters for the customization: https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm
        # virtual remote desktop extension (VRDE) is disabled
        vb.customize ["modifyvm", :id, "--vrde", "off"]
        # enable nested virtualization
        vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
        # forced Hyper-V paravirtualization provider
        vb.customize ["modifyvm", :id, "--paravirt-provider", "hyperv"]
        # enable 3D acceleration
        vb.customize ["modifyvm", :id, "--accelerate-3d", "on"]
        # graphics controller forced to vmsvga
        vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    end  
    
    config.vm.define "melanie-dev" do |node|
    end

    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/vagrant-playbook.yml"
        ansible.compatibility_mode = "2.0"
    end
end
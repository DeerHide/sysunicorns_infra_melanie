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


    # https://www.virtualbox.org/manual/ch08.html
    config.vm.provider "virtualbox" do |vb|
        vb.memory = "4096"
        vb.cpus = 4
        vb.name = "melanie-dev"
        vb.customize ["modifyvm", :id, "--vrde", "off"]
        vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
        vb.customize ["modifyvm", :id, "--paravirt-provider", "hyperv"]
        vb.customize ["modifyvm", :id, "--accelerate-3d", "on"]
    end  
    
    config.vm.define "melanie-dev" do |node|
    end

    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/vagrant-playbook.yml"
        ansible.compatibility_mode = "2.0"
    end
end
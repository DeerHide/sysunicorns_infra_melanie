Vagrant.require_version ">= 2.4.1"


Vagrant.configure("2") do |config|
    # ...
    config.vm.box = "generic/ubuntu2204"
    config.vm.provider "virtualbox"
    config.ssh.username = "deerhide-operator"
    config.ssh.password = rand
    config.vm.provider "virtualbox" do |vb|
        vb.memory = "4096"
        vb.cpus = 4
        vb.name = "melanie-dev"
    end  
    config.vm.define "melanie-dev" do |node|
    end
end
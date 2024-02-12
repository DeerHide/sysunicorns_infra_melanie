Vagrant.require_version ">= 2.4.1"


Vagrant.configure("2") do |config|
    # ...
    config.vm.box = "generic/ubuntu2204"
    config.vm.provider "hyperv"
    config.vm.network "public_network"
    config.vm.provider "hyperv" do |h|
        h.enable_virtualization_extensions = true
        h.linked_clone = true
    end
    config.vm.define "melanie-dev" do |node|
    end
end
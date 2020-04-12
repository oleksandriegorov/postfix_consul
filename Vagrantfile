# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.define "postfix" do |postfix|
#    postfix.vm.box = "bento/centos-8"
#    postfix.vm.provider "virtualbox" do |vb|
#      vb.memory = "2048"      
    postfix.vm.network "private_network", ip: "10.16.16.11"
    postfix.vm.hostname = "postfix"
    postfix.vm.provision "shell", inline: <<-SHELL
      /opt/puppetlabs/bin/puppet module install gdhbashton-consul_template
    SHELL
    postfix.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "consul_manifests"
      puppet.manifest_file = "consul_client.pp" 
    end
  end

  config.vm.define "consul",primary: true do |consul|
    consul.vm.network "forwarded_port", guest: 8500, host: 8500
    consul.vm.network "private_network", ip: "10.16.16.10"
    consul.vm.hostname = "consul"
    consul.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "consul_manifests"
      puppet.manifest_file = "consul_server.pp" 
    end
  end 

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "bento/centos-8"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "10.16.16.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    vb.memory = "2048"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
    yum install -y epel-release https://yum.puppetlabs.com/puppet-release-el-8.noarch.rpm
    yum install -y puppet vim bind-utils telnet
    /opt/puppetlabs/bin/puppet module install KyleAnderson-consul
  SHELL
end

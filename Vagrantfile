# Defines our Vagrant environment
#
# -*- mode: ruby -*-
# vi: set ft=ruby :
MGMTCPU="2"
MGMTMEM="1024"
NODECPU="2"
NODEMEM="1024"

Vagrant.configure("2") do |config|

  # create mgmt node
  config.vm.define :mgmt do |mgmt_config|
      mgmt_config.vm.box = "ubuntu/xenial64"
      mgmt_config.vm.hostname = "mgmt.example.com"
      mgmt_config.vm.network :private_network, ip: "10.0.15.10"
      mgmt_config.vm.provider "virtualbox" do |vb|
        vb.memory = MGMTMEM
      end
      mgmt_config.vm.provision :shell, path: "config-dir/bootstrap.sh"
  end

  # create load balancer
  # config.vm.define :lb do |lb_config|
  #     lb_config.vm.box = "ubuntu/trusty64"
  #     lb_config.vm.hostname = "lb"
  #     lb_config.vm.network :private_network, ip: "10.0.15.11"
  #     lb_config.vm.network "forwarded_port", guest: 80, host: 8080
  #     lb_config.vm.provider "virtualbox" do |vb|
  #       vb.memory = "256"
  #     end
  # end

  # create some web servers
  # https://docs.vagrantup.com/v2/vagrantfile/tips.html
  (1..2).each do |i|
    config.vm.define "node#{i}" do |node|
        node.vm.box = "ubuntu/xenial64"
        node.vm.hostname = "node#{i}.example.com"
        node.vm.network :private_network, ip: "10.0.15.2#{i}"
        node.vm.network "forwarded_port", guest: 80, host: "808#{i}"
        node.vm.provider "virtualbox" do |vb|
          vb.memory = NODEMEM
          vb.cpus = NODECPU
        end
      node.vm.provision :shell, path: "config-dir/bootstrap.sh"
    end
  end

end

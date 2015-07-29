# -*- mode: ruby -*-
# vi: set ft=ruby :

# Specify minimum Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

# Require YAML module
require 'yaml'

# Read YAML file with box details
servers = YAML.load_file('servers.yaml')

# Create boxes
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Iterate through entries in YAML file
  servers.each do |servers|
    config.vm.define servers["name"] do |srv|
      srv.vm.hostname = servers["name"]
      srv.vm.box = servers["box"]
      srv.vm.network "private_network", ip: servers["ip"]
      srv.vm.provider :virtualbox do |vb|
        vb.name = servers["name"]
        vb.memory = servers["ram"]
      end
      srv.vm.synced_folder "./chef", "/chef", :mount_options => ["fmode=666"]

      if (servers["name"] == "webserver01")
        srv.vm.network "forwarded_port", guest: 8080, host: 8080
      end

      if (servers["name"] == "chefserver")
        srv.vm.provision "shell", inline: "wget -O /chef/chef-server-core_12.1.2-1_amd64.deb https://web-dl.packagecloud.io/chef/stable/packages/ubuntu/trusty/chef-server-core_12.1.2-1_amd64.deb"
      end
    end
  end
end

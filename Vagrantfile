# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://gitweb.office.tobias.tv/?p=vagrant-boxes.git;a=blob_plain;f=ubuntu64-11.10/ubuntu64.box;hb=HEAD"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 8080
  config.vm.forward_port 5000, 5000
  config.vm.forward_port 3306, 3307

  # allow outside access to the box via a private IP address
  config.vm.network :hostonly, "172.16.1.2"

  # Allow symlink creation in guest OS
  #config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]

  # Mount share through NFS
  config.vm.share_folder("v-root", "/vagrant", ".", :nfs => true)

  # Puppet bootstrap (puppet needs to be installed)
  config.vm.provision :shell, :inline => "apt-get update && apt-get -qq install puppet"

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file  = "standalone.pp"
  end

  # Application provision
  config.vm.provision :shell, :inline => "cd /vagrant && stdbuf -o0 fab build; exit 0"

end

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Install docker compose plugin
  config.vagrant.plugins = "vagrant-docker-compose"
  
  # Define and configure virtual machine
  config.vm.define "debian-dev" do |debdev|
    debdev.vm.box = "debian/buster64"
    debdev.vm.hostname = "debian-dev"
    debdev.vm.box_url = "debian/buster64"
    debdev.vm.network "private_network", ip: "192.168.10.2"
    debdev.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--memory", 2048]
      vb.customize ["modifyvm", :id, "--name", "debian-dev"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end

    # Activate ssh connection for vagrant user
    debdev.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
      service ssh restart
    SHELL

    # Generate ssh key, il will be used by docker to configure ssh connection between Debian VM and docker container
    debdev.vm.provision "shell", inline: <<-SHELL
      su -c "source /vagrant/generate_rsa.sh" vagrant
    SHELL

    # This will install docker and create container named web. 
    debdev.vm.provision "docker" do |d|
      d.build_image "/vagrant/docker",
        args: "-t rabie/nginx"
      d.run "web",
        image: "rabie/nginx:latest",
        args: "-p 8080:80 -p 2222:22"
    end

    # Install docker-compose
    #debdev.vm.provision :docker
    debdev.vm.provision :docker_compose
    
    # Install vim and ansible
    debdev.vm.provision "shell", path: "install_utils.sh"
  end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

RIHANNA_NODES = 1
DEMO_CLIENTS = 1
BASEIP = 5
IP_PRE = "10.42.0."
DOMAIN = "local.lan"
VAGRANTFILE_API_VERSION = "2"

opts = []
hosts = "127.0.0.1	localhost\n"
hosts << "127.0.1.1	`hostname -f` `hostname`\n"
n = 0

(1..RIHANNA_NODES).each do |i|
    n = n + 1
    name = sprintf "rihanna%02d", n
    opts[n] = { :name => name, :hostname => "#{name}.#{DOMAIN}", :ip => "#{IP_PRE}#{BASEIP + n.to_i}" }
    hosts << "#{opts[n][:ip]}       #{opts[n][:hostname]} #{opts[n][:name]}\n"
end

#(RIHANNA_NODES..RIHANNA_NODES + DEMO_CLIENTS).each do |n|
(1..DEMO_CLIENTS).each do |i|
    n = n + 1
    name = sprintf "client%02d", n
    opts[n] = { :name => name, :hostname => "#{name}.#{DOMAIN}", :ip => "#{IP_PRE}#{BASEIP + n.to_i}" }
    hosts << "#{opts[n][:ip]}       #{opts[n][:hostname]} #{opts[n][:name]}\n"
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |vagrant|

  (1..n).each do |n|
    name = opts[n][:name]
    hostname = opts[n][:hostname]
    ip   = opts[n][:ip]

    vagrant.vm.define name do |config|

      config.vm.box = "phusion/ubuntu-14.04-amd64"

      if Vagrant.has_plugin?("vagrant-cachier")
        config.cache.scope = :box
      end

      #config.vm.name = "#{name}"
      config.vm.hostname = "#{hostname}"
      config.vm.network :private_network, ip: "#{ip}"

      config.vm.provider :virtualbox do |vb|
         vb.customize ["modifyvm", :id, "--memory", "2048"]
      end

      config.vm.provision "shell", inline: "echo \"#{hosts}\" > /etc/hosts"
      config.vm.provision "shell", inline: "apt-get install -y ruby-dev git"
      config.vm.provision "shell", inline: "gem install librarian-puppet"
      config.vm.provision "shell", inline: "cd /vagrant/puppet && librarian-puppet install"

      config.vm.provision :puppet do |puppet|
         puppet.manifests_path = "puppet/manifests"
         puppet.manifest_file  = "site.pp"
         puppet.module_path = "puppet/modules"
         puppet.options = [
         '--verbose',
         '--debug',
         '--hiera_config /vagrant/puppet/hiera.yaml']
      end
    end
  end
end

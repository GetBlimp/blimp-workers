# -*- mode: ruby -*-
# vi: set ft=ruby :

# Set up environment from .env file
File.readlines(".env").each do |line|
  values = line.split("=")
  ENV[values[0].strip.gsub(/"/, '')] = values[1].strip.gsub(/"/, '')
end

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

# Provision script URL
PROVISION_URL = "https://raw.github.com/GetBlimp/blimp-workers/master/provisioning/provision.sh"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider :virtualbox do |provider, override|
    override.vm.box = "precise64"
    override.vm.box_url ="http://files.vagrantup.com/precise64.box"
  end

  config.vm.provider :digital_ocean do |provider, override|
    override.vm.box = "digital_ocean"
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

    provider.client_id = ENV["DIGITAL_OCEAN_CLIENT_ID"]
    provider.api_key = ENV["DIGITAL_OCEAN_API_KEY"]
    provider.ssh_key_name = "Vagrant"

    override.ssh.private_key_path = "~/.ssh/do_blimp_rsa"

    provider.image = "Ubuntu 12.10 x64"
    provider.size = "512MB"
    provider.region = "New York 2"
  end

  # Set ssh guest port
  config.ssh.guest_port = ENV['SSH_PORT']

  config.vm.define "staging" do |staging|
    staging.vm.hostname = "blimp-worker-staging"

    # Environment specific provisioning args
    config.vm.provision "shell",
      path: PROVISION_URL,
      args: [
        ENV['MEMCACHE_USERNAME'],
        ENV['MEMCACHE_PASSWORD'],
        ENV['MEMCACHE_SERVER_PORT'],
        ENV['REDIS_SERVER_PASSWORD'],
        ENV['REDIS_SERVER_PORT'],
        ENV['STAGING_DATABASE_URL'],
        'STAGING',
        'blimp-staging',
        ENV['SSH_PORT']
      ]
  end

  config.vm.define "production" do |production|
    production.vm.hostname = "blimp-worker-production"

    # Environment specific provisioning args
    config.vm.provision "shell",
      path: PROVISION_URL,
      args: [
        ENV['MEMCACHE_USERNAME'],
        ENV['MEMCACHE_PASSWORD'],
        ENV['MEMCACHE_SERVER_PORT'],
        ENV['REDIS_SERVER_PASSWORD'],
        ENV['REDIS_SERVER_PORT'],
        ENV['PRODUCTION_DATABASE_URL'],
        'PRODUCTION',
        'blimp',
        ENV['SSH_PORT']
      ]
  end

end

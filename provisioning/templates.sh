#!/usr/bin/env bash

# Exit script immediately on first error.
set -e

# Print commands and their arguments as they are executed.
set -x

cp /vagrant/templates/blimp.env /home/ubuntu/blimp.env

cp /vagrant/templates/heroku.netrc /home/ubuntu/.netrc
cp -R /vagrant/templates/backups /home/ubuntu/

mkdir /home/ubuntu/.ssh
cp -R /vagrant/templates/ssh/authorized_keys /home/ubuntu/.ssh/

chmod 400 /home/ubuntu/.ssh/authorized_keys
chmod 0600 /home/ubuntu/.netrc
chown ubuntu:ubuntu -R /home/ubuntu/

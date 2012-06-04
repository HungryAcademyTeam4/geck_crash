#!/bin/bash

# SCP Deployment Example:
# scp ./geck-go.sh root@fallinggarden.com:/root/geck-go.sh

#This is required for apt-add-repository
apt-get -y install python-software-properties 
apt-add-repository -y ppa:chris-lea/node.js
apt-get update
apt-get -y install emacs curl gcc make
curl -L get.rvm.io | bash -s stable
apt-get -y install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion nodejs npm nodejs-dev redis-server libcurl4-openssl-dev
source /etc/profile.d/rvm.sh

# Install RVM. Requires dumb user input
rvm install 1.9.3
rvm use 1.9.3 --default
gem install bundler rake rails redis --no-ri --no-rdoc

# Create SQL w/ user
echo mysql-server mysql-server/root_password password databucket2 | sudo debconf-set-selections
echo mysql-server mysql-server/root_password_again password databucket2 | sudo debconf-set-selections
apt-get -y install mysql-server

# Create users on system
useradd deployer -d /home/deployer -m -g sudo -s /bin/bash
useradd fallingman -d /home/fallingman -m -g sudo -s /bin/bash
echo deployer:hungry1 | chpasswd
echo fallingman:hungry1 | chpasswd

# Turning on RVM for users when then sign in
echo '[[ -s "/etc/profile.d/rvm.sh" ]] && . "/etc/profile.d/rvm.sh"' >> /home/deployer/.bashrc
echo '[[ -s "/etc/profile.d/rvm.sh" ]] && . "/etc/profile.d/rvm.sh"' >> /home/fallingman/.bashrc
echo '[[ -s "/etc/profile.d/rvm.sh" ]] && . "/etc/profile.d/rvm.sh"' >> /root/.bashrc

# Install Passenger - this also has a couple of dumb enter keys to the user
gem install passenger --no-ri --no-rdoc
passenger-install-nginx-module

echo "scheisskopf" > /etc/hostname
echo "50.116.6.169 scheisskopf scheisskopf.falling.com" > /etc/hosts

echo "Almost done - copy and paste line below to enable RVM."
echo "source /etc/profile.d/rvm.sh"
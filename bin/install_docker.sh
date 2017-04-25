#!/bin/bash

USER=`whoami`
key_url=https://download.docker.com/linux/ubuntu/gpg
repo_url=https://download.docker.com/linux/ubuntu
edition=ce
version=17.03.0~ce-0~ubuntu-xenial
branch=stable # stable | edge

# Remove old stuff
sudo apt autoremove

# Ensure we have these deps
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common

# Remove any old installations
sudo apt-get remove -y docker docker-engine

# add key
curl -fsSL $key_url | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# add repo
sudo add-apt-repository \
   "deb [arch=amd64] $repo_url \
   $(lsb_release -cs) \
   $branch"

sudo apt-get update

# Install/upgrade docker
#sudo apt-get install -y docker-$edition=$version
sudo apt-get install -y docker-$edition

# add user to docker group
sudo usermod -aG docker $USER


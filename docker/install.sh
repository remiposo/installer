#!/bin/sh
#
# install docker
#

set -eu

script_home="$(cd "$(dirname "$0")" && pwd)"
cd "$script_home"

wget https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/containerd.io_1.4.6-1_amd64.deb
wget https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/docker-ce-cli_20.10.7~3-0~ubuntu-xenial_amd64.deb
wget https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/docker-ce_20.10.7~3-0~ubuntu-xenial_amd64.deb

sudo dpkg -i containerd.io_1.4.6-1_amd64.deb docker-ce-cli_20.10.7~3-0~ubuntu-xenial_amd64.deb docker-ce_20.10.7~3-0~ubuntu-xenial_amd64.deb

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

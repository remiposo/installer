#!/bin/bash

#
# docker installer
#

set -eu
script_home="$(cd "$(dirname "$0")" && pwd)"
cd "${script_home}"

if [ ! -e '/etc/lsb-release' ] && [ ! "$(cat /etc/lsb-release | grep -oP '(?<=DISTRIB_ID=).*')" -eq 'Ubuntu']; then
  echo 'Error: This script is only for Ubuntu'
  exit 1
fi

distrib_codename="$(cat /etc/lsb-release | grep -oP '(?<=DISTRIB_CODENAME=).*')"
docker_version='20.10.9'
cli_version='20.10.9'
containerd_version='1.4.9-1'

wget "https://download.docker.com/linux/ubuntu/dists/${distrib_codename}/pool/stable/amd64/docker-ce_${docker_version}~3-0~ubuntu-${distrib_codename}_amd64.deb" -O "docker-ce_${docker_version}.deb"
wget "https://download.docker.com/linux/ubuntu/dists/${distrib_codename}/pool/stable/amd64/docker-ce-cli_${cli_version}~3-0~ubuntu-${distrib_codename}_amd64.deb" -O "docker-ce-cli_${cli_version}.deb"
wget "https://download.docker.com/linux/ubuntu/dists/${distrib_codename}/pool/stable/amd64/containerd.io_${containerd_version}_amd64.deb" -O "containerd.io_${containerd_version}.deb"

dpkg -i "docker-ce_${docker_version}.deb" "docker-ce-cli_${cli_version}.deb" "containerd.io_${containerd_version}.deb"

echo "Type user_name added to docker group:"
read USER_NAME
if [ -z "${USER_NAME}" ];then
  echo "Error: Please type valid user_name"
  exit 1
fi
groupadd -f docker
usermod -aG docker ${USER_NAME}

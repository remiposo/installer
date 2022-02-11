#!/bin/bash

#
# porg installer
#

set -eu

script_home="$(cd "$(dirname "$0")" && pwd)"
cd "${script_home}"

if [ ! -e '/etc/debian_version' ]; then
  echo 'Error: This script is only for Debian'
  exit 1
fi

# build settings
version='0.10'
tarball="porg-${version}.tar.gz"
archivedir="porg-${version}"
prefix='/usr/local'

# initialization
if [ -e "${archivedir}" ]; then
  rm -rf "${archivedir}"
fi

# install build-dep
apt install -y build-essential

if [ ! -f "${tarball}" ];then
    wget "https://sourceforge.net/projects/porg/files/${tarball}/download" -O "${tarball}"
fi
tar zxvf "${tarball}"

cd "${archivedir}"
./configure \
    --prefix="${prefix}" \
    --disable-grop
make
./porg/porg -lD 'make install'

# enable bash_completion
if [ -d /etc/bash_completion.d ]; then
  cp -f /usr/local/etc/bash_completion.d/porg_bash_completion /etc/bash_completion.d/porg_bash_completion
fi

exit 0

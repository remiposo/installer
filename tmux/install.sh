#! /bin/bash

#
# tmux install
#

set -eu

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

version='3.2a'
tarball="${version}.tar.gz"
archivedir="tmux-${version}"

prefix="${HOME}/local"

if [ ! -e "/etc/debian_version" ]; then
  echo "Error: This script is only for Debian"
  exit 1
fi

sudo apt install -y build-essential
sudo apt build-dep -y tmux

if [ ! -f "${tarball}" ]; then
  wget "https://github.com/tmux/tmux/releases/download/${version}/tmux-${version}.tar.gz" -O "${tarball}"
fi

if [ -e "${archivedir}" ]; then
  rm -rf "${archivedir}"
fi

tar zxvf "${tarball}"
cd "${archivedir}"

./configure --prefix=${prefix}
make && make install

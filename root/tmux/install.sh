#! /bin/bash

#
# tmux installer
#
set -eu
script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

if [ ! -e "/etc/debian_version" ]; then
  echo "Error: This script is only for Debian"
  exit 1
fi

# build settings
version='3.2a'
tarball="${version}.tar.gz"
archivedir="tmux-${version}"
prefix="/usr/local"

# initialization
if [ -e "${archivedir}" ]; then
  rm -rf "${archivedir}"
fi

# install build-dep
apt install -y build-essential
apt build-dep -y tmux

if [ ! -f "${tarball}" ]; then
  wget "https://github.com/tmux/tmux/releases/download/${version}/tmux-${version}.tar.gz" -O "${tarball}"
fi
tar zxvf "${tarball}"

cd "${archivedir}"
./configure --prefix="${prefix}"
make

# use porg if available
if which porg >/dev/null 2>&1; then
  porg -lD -E "$(pwd)" 'make install'
else
  make install
fi

exit 0

#! /bin/bash

#
# vim installer
#
set -eu
script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

if [ ! -e "/etc/debian_version" ]; then
  echo "Error: This script is only for Debian"
  exit 1
fi

# build settings
version='8.2.2738'
tarball="v${version}.tar.gz"
archivedir="vim-${version}"
prefix="/usr/local"
feature="huge"

# initialization
if [ -e "${archivedir}" ]; then
  rm -rf "${archivedir}"
fi

# install build-dep
apt install -y build-essential
apt build-dep -y vim

if [ ! -f "${tarball}" ]; then
  wget "https://github.com/vim/vim/archive/refs/tags/${tarball}" -O "${tarball}"
fi
tar zxvf "${tarball}"

cd "${archivedir}"
./configure \
  --prefix="${prefix}" \
  --with-features="${feature}" \
  --enable-multibyte \
  --enable-fail-if-missing
make

# use porg if available
if which porg >/dev/null 2>&1; then
  porg -lD -E "$(pwd)" 'make install'
else
  make install
fi

exit 0

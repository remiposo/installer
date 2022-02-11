#!/bin/bash

#
# git installer
#

set -eu
script_home="$(cd "$(dirname "$0")" && pwd)"
cd "${script_home}"

if [ ! -e "/etc/debian_version" ]; then
  echo "Error: This script is only for Debian"
  exit 1
fi

# build settings
version='2.33.1'
tarball="v${version}.tar.gz"
archivedir="git-${version}"
prefix="/usr/local"

# initialization
if [ -e "${archivedir}" ]; then
  rm -rf "${archivedir}"
fi

# install build-dep
apt install -y build-essential
apt build-dep -y git

if [ ! -f "${tarball}" ]; then
  wget "https://github.com/git/git/archive/refs/tags/${tarball}" -O "${tarball}"
fi
tar zxvf "${tarball}"

cd "${archivedir}"
make configure
./configure --prefix="${prefix}"
make all

# use porg if available
if which porg >/dev/null 2>&1; then
  porg -lD -E "$(pwd)" 'make install'
else
  make install
fi

# enable bash_completion
if [ -d /etc/bash_completion.d ]; then
  cp -f ./contrib/completion/git-completion.bash /etc/bash_completion.d/git_bash_completion
fi

exit 0

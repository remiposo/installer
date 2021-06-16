#!/bin/bash
#
# install git
#

set -eu

script_home="$(cd "$(dirname "$0")" && pwd)"
cd "$script_home"

version=2.32.0
tarball="v${version}.tar.gz"
archivedir="git-${version}"
prefix="/usr/local"

if [ ! -e "/etc/debian_version" ]; then
  echo "Error: This script is only for Debian"
  exit 1
fi

if [ -e "$archivedir" ]; then
  rm -rf "$archivedir"
fi

apt -y install make autoconf build-essential
apt -y install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev asciidoc xmlto docbook2x

if [ ! -f "$tarball" ]; then
  wget "https://github.com/git/git/archive/refs/tags/${tarball}" -O "$tarball"
fi

tar zxvf "$tarball"
cd "$archivedir"

make configure
./configure --prefix="$prefix"
make all doc
make install install-doc install-html

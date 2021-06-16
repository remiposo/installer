#!/bin/sh
#
# install porg
#

set -eu

script_home="$(cd "$(dirname "$0")" && pwd)"
cd "$script_home"

version=0.10
tarball="porg-${version}.tar.gz"
archivedir="porg-${version}"
prefix="/usr/local"

if [ "$(uname -s)" != "Linux" ];then
    echo "Error: porg is only for Linux"
    exit 1
fi

if [ -e "$archivedir" ]; then
  rm -rf "$archivedir"
fi

if [ ! -f "$tarball" ];then
    wget "https://sourceforge.net/projects/porg/files/${tarball}/download" -O "${tarball}"
fi

tar zxvf "$tarball"
cd "$archivedir"

./configure \
    --prefix="${prefix}" \
    --disable-grop
make
./porg/porg -lD make install

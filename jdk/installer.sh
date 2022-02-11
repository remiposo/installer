#!/bin/bash

#
# jdk installer
#
set -eu
script_home="$(cd "$(dirname "$0")" && pwd)"
cd "${script_home}"

tarball='OpenJDK8U-jdk_x64_linux_hotspot_8u292b10.tar.gz'

# initialization
if [ -e ~/.jdk ];then
  rm -rf ~/.jdk
fi

if [ ! -e "${tarball}" ]; then
  wget "https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/${tarball}"
fi

mkdir ~/.jdk
tar -C ~/.jdk -xzf "${tarball}" --strip-components 1

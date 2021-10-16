#!/bin/sh
#
# install docker-compose
#

set -eu

script_home="$(cd "$(dirname "$0")" && pwd)"
cd "$script_home"

version=1.29.2
prefix=/usr/local

wget "https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)" -O "${prefix}/bin/docker-compose"
chmod +x /usr/local/bin/docker-compose

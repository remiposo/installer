#! /bin/bash

#
# bat installer
#

set -euo pipefail
script_root="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
cd "${script_root}"

VERSION='0.19.0'
DEB_FILE="bat_${VERSION}_amd64.deb"

# check archi
if [[ ! "$(uname -m)" == *64 ]]; then
  echo "Error: This script is only for amd64"
  exit 1
fi
if [[ ! -e "/etc/debian_version" ]] &&
   [[ ! -e "/etc/debian_release" ]]; then
  echo "Error: This script is only for debian"
  exit 1
fi

# download deb file
if [[ ! -e "$DEB_FILE" ]]; then
  wget "https://github.com/sharkdp/bat/releases/download/v${VERSION}/${DEB_FILE}"
fi

# install bat
sudo dpkg -i "$DEB_FILE"

exit 0

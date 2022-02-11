#! /bin/bash

#
# bat uninstaller
#

set -euo pipefail

# check archi
if [[ ! -e "/etc/debian_version" ]] &&
   [[ ! -e "/etc/debian_release" ]]; then
  echo "Error: This script is only for debian"
  exit 1
fi

# check installation
if ! which bat >/dev/null 2>&1; then
  echo "Error: bat is not installed"
  exit 0
fi
if ! dpkg -s bat >/dev/null 2>&1; then
  echo "Error: bat is not installed via dpkg"
  exit 1
fi

# uninstall bat
sudo dpkg -P bat

exit 0

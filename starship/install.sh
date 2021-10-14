#!/bin/bash

#
# starship installer
#

set -eu

# use porg if available
if which porg >/dev/null 2>&1; then
  porg -lp 'starship' 'sh -c "$(curl -fsSL https://starship.rs/install.sh)"'
else
  sh -c "$(curl -fsSL https://starship.rs/install.sh)"
fi

exit 0

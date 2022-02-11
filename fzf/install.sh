#!/bin/bash

#
# fzf installer
#

set -euo pipefail

DEFAULT_CLONE_PATH="${HOME}/.fzf"
clone_path="$DEFAULT_CLONE_PATH"

read -p "Where to clone fzf? (default: ${DEFAULT_CLONE_PATH}): "
clone_path="${REPLY:-$clone_path}"

if [[ ! -e "$clone_path" ]]; then
  git clone --depth 1 -- 'https://github.com/junegunn/fzf.git' "$clone_path"
fi

"${clone_path}/install"

exit 0

#!/bin/bash

#
# fzf installer
#

set -euo pipefail

if which fzf >/dev/null 2>&1; then
  fzf_exe="$(which fzf)"
  fzf_root="${fzf_exe%/bin/fzf}"
  "${fzf_root}/uninstall"
else
  echo "fzf not installed"
  exit 1
fi

exit 0

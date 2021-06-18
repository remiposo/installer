#!/bin/bash
#
# install nodenv
#

set -eu

git clone https://github.com/nodenv/nodenv.git ~/.nodenv
mkdir -p ~/.nodenv/plugins
git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build

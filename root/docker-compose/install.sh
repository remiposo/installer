#!/bin/bash

#
# docker-compose installer
#

set -eu
script_home="$(cd "$(dirname "$0")" && pwd)"
cd "${script_home}"

version='1.29.2'
prefix='/usr/local'

compose_url="https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)"
compose_path="${prefix}/bin/docerk-compose"
completion_url="https://raw.githubusercontent.com/docker/compose/${version}/contrib/completion/bash/docker-compose"
completion_path='/etc/bash_completion.d/docker-compose_bash_completion'

installation=$(
cat <<EOS
wget '${compose_url}' -O '${compose_path}'
# enable bash_completion
if [ -d /etc/bash_completion.d ]; then
  wget '${completion_url}' -O '${completion_path}'
fi
chmod 755 '${prefix}/bin/docker-compose'
EOS
)

# use porg if available
if which porg >/dev/null 2>&1; then
  porg -lp "docker-compose-${version}" "${installation}"
else
  eval "${installation}"
fi

exit 0

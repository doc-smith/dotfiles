#!/usr/bin/env bash
# shellcheck source=common.sh
#
# install-linux.sh - blah blah
#

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
source "${SCRIPT_DIR}/common.sh"


require_debian() {
    if [ ! -f /etc/debian_version ]; then
        die "Sorry, your OS is not Debian-like"
    fi
}


main() {
    require_debian

    ask_sudo
    revoke_sudo
}


main "$@"

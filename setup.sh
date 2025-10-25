#!/usr/bin/env bash
# shellcheck source=common.sh

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
source "${SCRIPT_DIR}/common.sh"


main() {
    if [ "$(uname)" == 'Darwin' ]; then
        "${SCRIPT_DIR}/setup-macos.sh"
    elif [ "$(uname)" == 'Linux' ]; then
        "${SCRIPT_DIR}/setup-linux.sh"
    else
        die 'Sorry, your OS is not supported (uname must be Darwin or Linux)'
    fi
}


main "$@"

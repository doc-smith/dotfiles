#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/common.sh"


if ! [ -x "$(command -v port)" ]; then
    die "Download and install MacPorts: https://www.macports.org/install.php"
fi


"${SCRIPT_DIR}/install-bash.sh"
"${SCRIPT_DIR}/install-tools.sh"
"${SCRIPT_DIR}/install-miniconda.sh"

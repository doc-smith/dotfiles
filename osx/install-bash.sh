#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/common.sh"


# Bash completion: https://trac.macports.org/wiki/howto/bash-completion

stderr "Installing Bash from MacPorts..."

CURRENT_SHELL=$(dscl . -read "/Users/${USER}" UserShell | awk -F': ' '{print $2}')
BASH_PATH=/opt/local/bin/bash
if [ "${CURRENT_SHELL}" != "${BASH_PATH}" ]; then
    BASH_PORTS=(
        bash
        bash-completion
    )
    sudo port install "${BASH_PORTS[@]}"
    if ! grep "${BASH_PATH}" /etc/shells; then
        echo "${BASH_PATH}" | sudo tee -a /etc/shells
    fi

    stderr "Setting ${BASH_PATH} as the default shell..."
    chsh -s "${BASH_PATH}"
else
    stderr "The current shell is already ${BASH_PATH}, nothing to install"
fi

MACPORTS_VARIANTS=/opt/local/etc/macports/variants.conf
COMPLETION_OPTION=+bash_completion
stderr "Checking if +bash_completion is in ${MACPORTS_VARIANTS}"
if ! grep -qxF "${COMPLETION_OPTION}" "${MACPORTS_VARIANTS}"; then
    echo "${COMPLETION_OPTION}" | sudo tee -a "${MACPORTS_VARIANTS}"
fi

stderr "Installing Bash from MacPorts: done"

#!/usr/bin/env bash
#
# install-linux.sh - blah blah
#

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
source "${SCRIPT_DIR}/common.sh"


PACKAGES=(
    bat
    fish
    ripgrep
    tldr
    tmux
)


install_tools() {
    quietly sudo apt-get update
    for package in "${PACKAGES[@]}"; do
        if ! dpkg -s "${package}" > /dev/null 2>&1; then
            stderr "installing ${package}..."
            quietly sudo apt-get install -y "${package}"
        fi
    done
}


main() {
    install_tools
    make_fish_login_shell
}


main "$@"

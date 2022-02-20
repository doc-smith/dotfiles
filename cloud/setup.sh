#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

source "${SCRIPT_DIR}/common.sh"

require_sudo() {
    if ! sudo -n true; then
        die "you need sudo to run this script"
    fi
}


require_sudo

stderr "configuring locale..."
sudo "${SCRIPT_DIR}/setup-locale.sh"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
stderr "configuring locale: done"

stderr "installing the must-have packages..."
sudo apt-get update > /dev/null
KERNEL_VERSION="$(uname -r | awk -F . -v OFS='.' '{print $1, $2}')"
PACKAGES=(
    build-essential
    clang
    clang-format
    clang-tidy
    cmake
    gdb
    git
    htop
    libc++-dev
    libc++abi-dev
    linux-perf-${KERNEL_VERSION}
    llvm
    tmux
    unzip
    vim
)
for package in "${PACKAGES[@]}"; do
    stderr "installing ${package}"
    sudo apt-get install -y "${package}" > /dev/null
done
stderr "installing the must-have packages: done"

stderr "settings..."
CONF_DIR="${SCRIPT_DIR}/conf"
ln -sfv "${CONF_DIR}/vimrc" "${HOME}/.vimrc"
ln -sfv "${CONF_DIR}/bashrc" "${HOME}/.bashrc"
ln -sfv "${CONF_DIR}/bash_profile" "${HOME}/.bash_profile"
ln -sfv "${CONF_DIR}/tmux.conf" "${HOME}/.tmux.conf"
stderr "settings: done"
#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


stderr() {
    echo "$@" 1>&2;
}


die() {
    stderr "$@"
    exit 1
}


if [[ "$OSTYPE" != "darwin"* ]]; then
    die "Sorry, your OS ${OSTYPE} is not supported"
fi

MACHINE_CONFIG_DIR="${HOME}/.config"

if [[ ! -d "${MACHINE_CONFIG_DIR}" ]]; then
    mkdir "${MACHINE_CONFIG_DIR}"
fi

stderr "Setting symlinks..."

REPO_CONFIG_DIR="${SCRIPT_DIR}/config"
CONFIGS=(
    git
    tmux
    vim
    zsh
)

for config in "${CONFIGS[@]}"; do
    if [[ -e "${MACHINE_CONFIG_DIR}/${config}" ]]; then
        stderr "${MACHINE_CONFIG_DIR}/${config} already exists"
        stderr "  delete it first and run this script again"
    else
        ln -sv "${REPO_CONFIG_DIR}/${config}" "${MACHINE_CONFIG_DIR}"
    fi
done

# some of the config files are not recognised when in .config
#   however, I prefer to keep everything in .config
ln -sfv "${MACHINE_CONFIG_DIR}/vim/.vimrc" "${HOME}"
ln -sfv "${MACHINE_CONFIG_DIR}/tmux/.tmux.conf" "${HOME}"
ln -sfv "${MACHINE_CONFIG_DIR}/git/.gitconfig" "${HOME}"
ln -sfv "${MACHINE_CONFIG_DIR}/zsh/.zshenv" "${HOME}"

stderr "Setting symlinks: done"


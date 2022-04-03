#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

source "${SCRIPT_DIR}/macos/common.sh"

require_macos

MACHINE_CONFIG_DIR="${HOME}/.config"

if [[ ! -d "${MACHINE_CONFIG_DIR}" ]]; then
    mkdir "${MACHINE_CONFIG_DIR}"
fi

stderr "Setting symlinks: configs"

REPO_CONFIG_DIR="${SCRIPT_DIR}/config"
CONFIGS=(
    git
    tmux
    vim
    zsh
)

for config in "${CONFIGS[@]}"; do
    if [[ -e "${MACHINE_CONFIG_DIR}/${config}" ]]; then
        die "${MACHINE_CONFIG_DIR}/${config} already exists, delete it first and run this script again"
    else
        ln -sv "${REPO_CONFIG_DIR}/${config}" "${MACHINE_CONFIG_DIR}"
    fi
done

# some of the config files are not recognised when in ~/.config
#   I prefer to keep everything in ~/.config anyway
ln -sfv "${MACHINE_CONFIG_DIR}/vim/.vimrc" "${HOME}"
ln -sfv "${MACHINE_CONFIG_DIR}/tmux/.tmux.conf" "${HOME}"
ln -sfv "${MACHINE_CONFIG_DIR}/git/.gitconfig" "${HOME}"
ln -sfv "${MACHINE_CONFIG_DIR}/zsh/.zshenv" "${HOME}"


stderr "Setting symlinks: tools"

MACHINE_TOOLS_DIR="${HOME}/tools"

if [[ ! -d "${MACHINE_TOOLS_DIR}" ]]; then
    mkdir "${MACHINE_TOOLS_DIR}"
fi

REPO_TOOLS_DIR="${SCRIPT_DIR}/tools"
TOOL_SETS=(
    tmux
)

for tset in "${TOOL_SETS[@]}"; do
    if [[ -e "${MACHINE_TOOLS_DIR}/${tset}" ]]; then
        die "${MACHINE_TOOLS_DIR}/${tset} already exists, delete it first and run this script again"
    else
        ln -sv "${REPO_TOOLS_DIR}/${tset}" "${MACHINE_TOOLS_DIR}"
    fi
done

stderr "Setting symlinks: done"

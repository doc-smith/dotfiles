#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
source "${SCRIPT_DIR}/common.sh"


export XDG_CONFIG_HOME="${HOME}/.config"


install_fisher() {
    local fisher_path
    fisher_path="${HOME}/.config/fish/functions/fisher.fish"

    mkdir -p "$(dirname "${fisher_path}")"
    if [ ! -f "${fisher_path}" ]; then
        curl \
            -sLo "${fisher_path}" \
            --create-dirs https://git.io/fisher
    fi
}


symlink_configs() {
    local config_dir
    config_dir="${SCRIPT_DIR}/conf"

    mkdir -p "${XDG_CONFIG_HOME}/fish/themes"
    ln -sfv "${config_dir}/fish/config.fish" "${XDG_CONFIG_HOME}/fish/config.fish"
    ln -sfv "${config_dir}/fish/fish_plugins" "${XDG_CONFIG_HOME}/fish/fish_plugins"
    ln -sfv "${config_dir}/fish/themes/termcolors.theme" "${XDG_CONFIG_HOME}/fish/themes/termcolors.theme"

    ln -sfv "${config_dir}/gitconfig" "${XDG_CONFIG_HOME}/git/config"
    ln -sfv "${config_dir}/tmux.conf" "${HOME}/.tmux.conf"
    ln -sfv "${config_dir}/vimrc" "${HOME}/.vimrc"

    if quietly command -v bat &> /dev/null; then
        local bat_config_path
        bat_config_path=$(bat --config-file)

        mkdir -p "$(dirname "${bat_config_path}")"
        ln -sfv "${config_dir}/bat.conf" "${bat_config_path}"
    fi
}


main() {
    install_fisher
    symlink_configs
}


main "$@"

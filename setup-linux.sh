#!/usr/bin/env bash
#
# install-linux.sh - blah blah
#

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
source "${SCRIPT_DIR}/common.sh"


PACKAGES=(
    fish
    htop
    httpie
    ripgrep
    shellcheck
    tldr
    tmux
)


require_debian() {
    if [ ! -f /etc/debian_version ]; then
        die "Sorry, your OS is not Debian-like"
    fi
}

install_tools() {
    quietly sudo apt-get update
    for package in "${PACKAGES[@]}"; do
        if ! dpkg -s "${package}" > /dev/null 2>&1; then
            stderr "installing ${package}..."
            quietly \
                sudo DEBIAN_FRONTEND=noninteractive \
                apt-get install --assume-yes "${package}"
        fi
    done

    install_fisher

    tldr --update
}

create_symlinks() {
    local config_dir
    config_dir="${SCRIPT_DIR}/conf"

    local xdg_conf_home
    xdg_conf_home="${HOME}/.config"
    mkdir -p "${xdg_conf_home}"

    mkdir -p "${xdg_conf_home}/fish/themes"
    ln -sf "${config_dir}/fish/config.fish" "${xdg_conf_home}/fish/config.fish"
    ln -sf "${config_dir}/fish/fish_plugins" \
           "${xdg_conf_home}/fish/fish_plugins"
    ln -sf "${config_dir}/fish/themes/termcolors.theme" \
            "${xdg_conf_home}/fish/themes/termcolors.theme"

    ln -sf "${config_dir}/gitconfig" "${xdg_conf_home}/.gitconfig"
    ln -sf "${config_dir}/vimrc" "${HOME}/.vimrc"

    ln -sf "${config_dir}/tmux.conf" "${HOME}/.tmux.conf"
}


main() {
    require_debian

    ask_sudo

    install_tools
    make_fish_login_shell
    create_symlinks

    revoke_sudo
}


main "$@"

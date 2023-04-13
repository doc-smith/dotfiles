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
    neovim
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

    make_fish_login_shell
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
    ln -sfv "${config_dir}/fish/config.fish" "${xdg_conf_home}/fish/config.fish"
    ln -sfv "${config_dir}/fish/fish_plugins" "${xdg_conf_home}/fish/fish_plugins"
    ln -sfv "${config_dir}/fish/themes/termcolors.theme" "${xdg_conf_home}/fish/themes/termcolors.theme"

    mkdir -p "${xdg_conf_home}/git"
    ln -sf "${config_dir}/gitconfig" "${xdg_conf_home}/git/config"
    ln -sf "${config_dir}/tmux.conf" "${HOME}/.tmux.conf"
    ln -sf "${config_dir}/vimrc" "${HOME}/.vimrc"
}


main() {
    require_debian

    ask_sudo

    install_tools
    create_symlinks

    revoke_sudo
}


main "$@"
#!/usr/bin/env bash
#
# install-sofware.sh - install my formulae and casks
#
# options:
#   --home-setup        if this is being runned on my home machine
#                       (EXTRA_HOME_CASKS will be also installed)
#
#   --no-brew-update    do not update Homebrew
#

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
source "${SCRIPT_DIR}/common.sh"


FORMULAE=(
    bash
    bat
    cmake
    doctl
    exa
    fish
    gh
    htop
    httpie
    ipython
    llvm
    neovim
    python3
    ripgrep
    shellcheck
    tldr
    tmux
)

CASKS=(
    spotify
    visual-studio-code
    wezterm
    zoom
)

# Applications I don't want to install on a company computer
EXTRA_HOME_CASKS=(
    discord
    docker
    signal
    steam
    telegram
)

create_symlinks() {
    local config_dir
    config_dir="${SCRIPT_DIR}/conf"

    local xdg_conf_home
    xdg_conf_home="${HOME}/.config"

    mkdir -p "${xdg_conf_home}/wezterm"
    ln -sf "${config_dir}/wezterm.lua" "${xdg_conf_home}/wezterm/wezterm.lua"

    mkdir -p "${xdg_conf_home}/fish/themes"
    ln -sfv "${config_dir}/fish/config.fish" "${xdg_conf_home}/fish/config.fish"
    ln -sfv "${config_dir}/fish/fish_plugins" "${xdg_conf_home}/fish/fish_plugins"
    ln -sfv "${config_dir}/fish/themes/termcolors.theme" "${xdg_conf_home}/fish/themes/termcolors.theme"

    if quietly command -v bat &> /dev/null; then
        local bat_config_path
        bat_config_path=$(bat --config-file)
        mkdir -p "$(dirname "${bat_config_path}")"
        ln -sf "${config_dir}/bat.conf" "${bat_config_path}"
    fi

    ln -sf "${config_dir}/gitconfig" "${xdg_conf_home}/git/config"
    ln -sf "${config_dir}/vimrc" "${HOME}/.vimrc"
}


main() {
    ask_sudo
    require_macos
    require_homebrew

    local home_setup=false
    local update_homebrew=true

    while (( $# > 0 )); do
        case $1 in
        --home-setup)
            shift
            home_setup=true
        ;;
        --no-brew-update)
            shift
            update_homebrew=false
        ;;
        *)
            stderr "usage: $(basename "$0") [--home-setup] [--no-brew-update]"
            exit 2
        ;;
        esac
    done


    if [ "${update_homebrew}" == true ]; then
        stderr 'Updating Homebrew...'
        quietly brew update
    fi

    stderr 'Getting your formulae ready...'
    for formula in "${FORMULAE[@]}"; do
        if ! brew ls --versions "${formula}" > /dev/null; then
            stderr "${formula} is not installed, installing..."
            quietly brew install "${formula}"
        fi
    done

    stderr 'Getting your casks ready...'
    local casks_to_install=("${CASKS[@]}")
    if [ "${home_setup}" == true ]; then
        casks_to_install+=("${EXTRA_HOME_CASKS[@]}")
    fi

    for cask in "${casks_to_install[@]}"; do
        if ! brew ls --cask --versions "${cask}" > /dev/null; then
            stderr "${cask} is not installed, installing..."
            quietly brew install --cask "${cask}"
        fi
    done

    quietly brew completions link

    make_fish_login_shell
    install_fisher
    create_symlinks

    revoke_sudo
}


main "$@"

#!/usr/bin/env bash
#
# install-sofware.sh - install my formulae and casks
#
# options:
#   --no-brew-update    do not update Homebrew
#

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
source "${SCRIPT_DIR}/common.sh"


FORMULAE=(
    bash
    cmake
    exa
    fish
    gh
    golang
    httpie
    ipython
    llvm
    node
    npm
    python3
    ripgrep
    shellcheck
    tldr
)

CASKS=(
    visual-studio-code
    zoom
)


require_macos() {
    if [ "$(uname)" != "Darwin" ]; then
        die "Sorry, your OS is not macOS"
    fi
}

require_homebrew() {
    if ! quietly command -v brew; then
        die 'You need to install Homebrew first (https://brew.sh)'
    fi
}

install_tools() {
    stderr 'Getting your formulae ready...'
    for formula in "${FORMULAE[@]}"; do
        if ! brew ls --versions "${formula}" > /dev/null; then
            stderr "${formula} is not installed, installing..."
            quietly brew install "${formula}"
        fi
    done

    for cask in "${CASKS[@]}"; do
        if ! brew ls --cask --versions "${cask}" > /dev/null; then
            stderr "${cask} is not installed, installing..."
            quietly brew install --cask "${cask}"
        fi
    done

    quietly brew completions link

    install_fisher

    tldr --update
}

create_symlinks() {
    local config_dir
    config_dir="${SCRIPT_DIR}/conf"

    local home_cofig_dir
    home_cofig_dir="${HOME}/.config"
    mkdir -p "${home_cofig_dir}"

    ln -sf "${config_dir}/fish/config.fish" "${home_cofig_dir}/fish/config.fish"
    ln -sf "${config_dir}/fish/fish_plugins" \
           "${home_cofig_dir}/fish/fish_plugins"

    mkdir -p "${home_cofig_dir}/fish/themes"
    ln -sf "${config_dir}/fish/themes/termcolors.theme"\
           "${home_cofig_dir}/fish/themes/termcolors.theme"

    ln -sf "${config_dir}/gitconfig" "${HOME}/.gitconfig"
    ln -sf "${config_dir}/vimrc" "${HOME}/.vimrc"
}


main() {
    require_macos
    require_homebrew

    local update_homebrew=true

    while (( $# > 0 )); do
        case $1 in
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

    ask_sudo

    if [ "${update_homebrew}" == true ]; then
        stderr 'Updating Homebrew...'
        quietly brew update
    fi

    install_tools
    make_fish_login_shell
    create_symlinks

    revoke_sudo
}


main "$@"

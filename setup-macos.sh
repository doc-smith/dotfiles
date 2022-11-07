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
    exa
    fish
    gh
    htop
    httpie
    ipython
    llvm
    mosh
    python3
    ripgrep
    tldr
    tmux
)

CASKS=(
    visual-studio-code
    zoom
)

EXTRA_HOME_CASKS=(
    discord
    messenger
    signal
    steam
    telegram
    vlc
)


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
            stderr "usage: $(basename $0) [--home-setup] [--no-brew-update]"
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

    if quietly command -v fish &> /dev/null; then
        stderr 'Setting the login shell to fish...'
        local fish_path
        fish_path=$(which fish)

        if ! quietly grep "${fish_path}" /etc/shells; then
            echo "${fish_path}" | sudo tee -a /etc/shells > /dev/null
        fi

        sudo chsh -s "${fish_path}" "$(whoami)"
    fi

    stderr 'All done'

    revoke_sudo
}


main "$@"

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
    github
    visual-studio-code
    zoom
)

EXTRA_HOME_CASKS=(
    discord
    messenger
    signal
    telegram
    vlc
)


stderr() {
    echo "$@" 1>&2;
}

die() {
    stderr "$@"
    exit 1
}

quietly() {
    "$@" > /dev/null
}

require_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        die "Sorry, your OS ${OSTYPE} is not macOS"
    fi
}

ask_sudo() {
    if ! sudo -v; then
        die 'You need sudo to run this script'
    fi
}

revoke_sudo() {
    sudo -k
}

require_homebrew() {
    if ! quietly command -v brew; then
        die 'You need to install Homebrew first (https://brew.sh)'
    fi
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
        casksto_install+=("${EXTRA_HOME_CASKS[@]}")
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
        local fish_path=$(which fish)

        if ! quietly grep "${fish_path}" /etc/shells; then
            echo "${fish_path}" | sudo tee -a /etc/shells > /dev/null
        fi

        sudo chsh -s "${fish_path}" "$(whoami)"
    fi

    local fisher_path="${HOME}/.config/fish/functions/fisher.fish"
    if [ ! -f "${fisher_path}" ]; then
        quietly curl \
            -sLo "${fisher_path}" \
            --create-dirs https://git.io/fisher
    fi

    stderr 'All done'

    revoke_sudo
}


main "$@"

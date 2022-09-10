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
    bash        # macOS has Zsh now, let's install a newer bash for scripting
    cmake
    gh          # GitHub CLI tools
    htop
    httpie      # better HTTP client
    ipython
    llvm        # clang and friends
    neovim      # better Vim
    python3
    the_silver_searcher # better ack
    tldr                # man tldr
    tmux
)

CASKS=(
    github
    spotify
    visual-studio-code
    zoom
)

EXTRA_HOME_CASKS=(
    discord
    messenger # Facebook messenger
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


require_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        die "Sorry, your OS ${OSTYPE} is not macOS"
    fi
}

quietly() {
    "$@" > /dev/null
}


main() {
    require_macos

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


    if [[ "${update_homebrew}" == true ]]; then
        stderr 'Updating Homebrew...'
        quietly brew update
        stderr 'Updating Homebrew: done'
    fi

    stderr 'Getting your formulae ready...'
    for formula in "${FORMULAE[@]}"; do
        if ! brew ls --versions "${formula}" > /dev/null; then
            stderr "${formula} is not installed, installing..."
            quietly brew install "${formula}"
        fi
    done

    stderr 'Getting your casks ready...'
    local casks=("${CASKS[@]}")
    if [[ "${home_setup}" == true ]]; then
        casks+=("${EXTRA_HOME_CASKS[@]}")
    fi

    for cask in "${casks[@]}"; do
        if ! brew ls --cask --versions "${cask}" > /dev/null; then
            stderr "${cask} is not installed, installing..."
            quietly brew install --cask "${cask}"
        fi
    done

    # https://docs.brew.sh/Shell-Completion
    quietly brew completions link

    stderr "All done"
}


main "$@"

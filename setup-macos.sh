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


BREW=/opt/homebrew/bin/brew

FORMULAE=(
    bash
    fzf
    golang
    node
    python3
    ripgrep
    shellcheck
    tlrc
    zsh-autosuggestions
    zsh-syntax-highlighting
)

CASKS=(
    google-chrome
    localsend
    visual-studio-code
)


require_macos() {
    if [ "$(uname)" != "Darwin" ]; then
        die "Sorry, your OS is not macOS"
    fi
}

require_homebrew() {
    if ! quietly command -v "${BREW}"; then
        die 'You need to install Homebrew first (https://brew.sh)'
    fi
}

install_tools() {
    stderr 'Getting your formulae ready...'
    for formula in "${FORMULAE[@]}"; do
        if ! "${BREW}" ls --versions "${formula}" > /dev/null; then
            stderr "${formula} is not installed, installing..."
            quietly "${BREW}" install --formula "${formula}"
        fi
    done

    for cask in "${CASKS[@]}"; do
        if ! "${BREW}" ls --cask --versions "${cask}" > /dev/null; then
            stderr "${cask} is not installed, installing..."
            quietly "${BREW}" install --cask "${cask}"
        fi
    done

    quietly "${BREW}" completions link

    stderr "Updating tldr page definitions..."
    /opt/homebrew/bin/tldr --update
}

create_symlinks() {
    local config_dir
    config_dir="${SCRIPT_DIR}/conf"

    ln -sf "${config_dir}/zsh/zshrc" "${HOME}/.zshrc"
    ln -sf "${config_dir}/zsh/zshenv" "${HOME}/.zshenv"

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
        quietly "${BREW}" update
    fi

    install_tools
    create_symlinks

    # Bash and Zsh will suppress the welcome banner upon startup if this file
    # exists.
    touch "${HOME}/.hushlogin"

    revoke_sudo
}


main "$@"

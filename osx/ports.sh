#!/usr/bin/env bash

set -euo pipefail


stderr() {
    echo "$@" 1>&2; 
}


die() {
    stderr "$@"
    exit 1
}


if ! [ -x "$(command -v port)" ]; then
    die "Download and install MacPorts: https://www.macports.org/install.php"
    exit 1
fi


CURRENT_SHELL=$(dscl . -read "/Users/${USER}" UserShell | awk -F': ' '{print $2}')
ZSH_PATH=/opt/local/bin/zsh
if [ "${CURRENT_SHELL}" != "${ZSH_PATH}" ]; then
    ZSH_PORTS=(
        zsh
        zsh-completions
    )
    sudo port install "${ZSH_PORTS[@]}"
    if ! grep "${ZSH_PATH}" /etc/shells; then
        echo "${ZSH_PATH}" | sudo tee -a /etc/shells
    fi
    sudo chsh -u ${USER} -s "${ZSH_PATH}"
fi


if [ ! -d "${NVM_DIR}" ]; then
    export NVM_DIR="$HOME/.nvm" && (
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    ) && \. "$NVM_DIR/nvm.sh"
fi


if ! [ -x "$(command -v rvm)" ]; then
    sudo port install gnupg2
    gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable --ruby
fi


NERD_FONTS_INSTALL_PATH="${HOME}/work/src/nerd-fonts"
if [ ! -d "${NERD_FONTS_INSTALL_PATH}" ]; then
    git clone https://github.com/ryanoasis/nerd-fonts "${NERD_FONTS_INSTALL_PATH}"
    "${NERD_FONTS_INSTALL_PATH}/install.sh"
fi

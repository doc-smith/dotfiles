#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/common.sh"


stderr "Installing other tools..."


stderr "Installing nvm..."
if [ ! -d "${NVM_DIR}" ]; then
    export NVM_DIR="$HOME/.nvm" && (
        git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
        cd "$NVM_DIR"
        git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    ) && \. "$NVM_DIR/nvm.sh"
else
    stderr "${NVM_DIR} already defined, nothing to install"
fi
stderr "Installing nvm: done"


stderr "Installing rvm..."
if ! [ -x "$(command -v rvm)" ]; then
    sudo port install gnupg2
    gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable --ruby
else
    stderr "rvm already available, nothing to install"
fi
stderr "Installing rvm: done"


USEFUL_PORTS=(
    unzip
    jq
    tldr-cpp-client
    mit-scheme
)

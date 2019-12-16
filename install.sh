#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/osx/common.sh"

if [[ "$OSTYPE" == "darwin"* ]]; then
    "${SCRIPT_DIR}/osx/install.sh"
    "${SCRIPT_DIR}/osx/tweak-macos.sh"
else
    die "Sorry, your OS ${OSTYPE} is not supported"
fi


stderr "Configuring vim..."
ln -sfv "${SCRIPT_DIR}/vim/.vim" "${HOME}"
ln -sfv "${SCRIPT_DIR}/vim/.vimrc" "${HOME}"
stderr "Configuring vim: done"


stderr "Configuring bash..."
if [ -f "${HOME}/.profile" ]; then
    rm "${HOME}/.profile"
fi
ln -sfv "${SCRIPT_DIR}/shell/commonrc.sh" ~/.commonrc.sh
ln -sfv "${SCRIPT_DIR}/shell/bashrc" ~/.bashrc
ln -sfv "${SCRIPT_DIR}/shell/bash_profile" ~/.bash_profile
ln -sfv "${SCRIPT_DIR}/shell/bash_prompt" ~/.bash_prompt
stderr "Configuring bash: done"


stderr "Configuring git..."
git config --global credential.helper osxkeychain
git config --global user.name "Dmitry Kuznetsov"
git config --global user.email dkuznetsov@yandex.ru
stderr "Configuring git: done"

#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"${SCRIPT_DIR}/osx/ports.sh"

ln -sfv "${SCRIPT_DIR}/vim/.vim" "${HOME}"
ln -sfv "${SCRIPT_DIR}/vim/.vimrc" "${HOME}"


if [ -f "${HOME}/.profile" ]; then
    rm "${HOME}/.profile"
fi

ln -sfv "${SCRIPT_DIR}/shell/commonrc.sh" ~/.commonrc.sh
ln -sfv "${SCRIPT_DIR}/shell/bashrc" ~/.bashrc
ln -sfv "${SCRIPT_DIR}/shell/bash_profile" ~/.bash_profile
ln -sfv "${SCRIPT_DIR}/shell/bash_prompt" ~/.bash_prompt
ln -sfv "${SCRIPT_DIR}/shell/zshrc" ~/.zshrc

ln -sfv "${SCRIPT_DIR}/shell/hyper.js" ~/.hyper.js

"${SCRIPT_DIR}/osx/post-install.sh"

git config --global credential.helper osxkeychain
git config --global user.name "Dmitry Kuznetsov"
git config --global user.email dkuznetsov@yandex.ru

"${SCRIPT_DIR}/osx/tweaks.sh"

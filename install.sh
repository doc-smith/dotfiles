#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Vim
#
ln -sfv "$SCRIPT_DIR/vim/.vim" ~
ln -sfv "$SCRIPT_DIR/vim/.vimrc" ~

# Shell
#
if [ -f "~/.profile" ]; then
    rm "~/.profile"
fi
ln -sfv "$SCRIPT_DIR/shell/bashrc" ~/.bashrc
ln -sfv "$SCRIPT_DIR/shell/bash_profile" ~/.bash_profile
ln -sfv "$SCRIPT_DIR/shell/bash_prompt" ~/.bash_prompt


# OS X
#
if [[ "$OSTYPE" == "darwin"* ]]; then
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${SCRIPT_DIR}/iterm2"
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

    ./osx/ports.sh
    ./osx/tweaks.sh
fi


# git
#
git config --global credential.helper osxkeychain
git config --global user.name "Dmitry Kuznetsov"
git config --global user.email dkuznetsov@yandex.ru

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


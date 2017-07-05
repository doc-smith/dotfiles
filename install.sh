#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Vim
#
ln -sfv "$SCRIPT_DIR/vim/.vim" ~
ln -sfv "$SCRIPT_DIR/vim/.vimrc" ~


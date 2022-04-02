#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

source "${SCRIPT_DIR}/common.sh"


if ! [ -x "$(command -v brew)" ]; then
    die "Install Homebrew first: http://brew.sh"
fi

brew update
brew upgrade

STUFF=(
  gh
  htop
  httpie
  llvm
  tldr
  tmux
  gibo
)

for formula in "${STUFF[@]}"; do
    if ! brew ls --versions "${formula}" > /dev/null; then
        stderr "Installing ${formula}..."
        brew install "${formula}" > /dev/null
    fi
done


stderr "Installing Visual Studio Code..."
brew install --cask visual-studio-code

brew cleanup

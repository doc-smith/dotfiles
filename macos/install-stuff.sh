#!/usr/bin/env bash

set -euo pipefail


stderr() {
    echo "$@" 1>&2;
}


die() {
    stderr "$@"
    exit 1
}


if ! [ -x "$(command -v brew)" ]; then
    die "Install Homebrew first: http://brew.sh"
fi

stderr "Installing useful stuff..."

STUFF=(
  gh
  htop
  httpie
  llvm
  tldr
  tmux
)

brew install "${STUFF[@]}"

stderr "Installing useful stuff: done"


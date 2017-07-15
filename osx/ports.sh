#!/usr/bin/env bash

set -ex


if ! [ -x "$(command -v port)" ]; then
    >&2 echo "Error: MacPorts are not installed."
    exit 1
fi

sudo port install bash +completion
BASH_PATH=`which bash`
if ! grep "$BASH_PATH" /etc/shells; then
    echo "$BASH_PATH" | sudo tee -a /etc/shells
fi

sudo port install python27 +readline
sudo port select --set python python27
sudo port select --set python2 python27

sudo port install py27-pip
sudo port select --set pip pip27

sudo port install py27-virtualenv
sudo port select --set virtualenv virtualenv27

ports=(
    vim
    moreutils
    ffmpeg
    source-highlight
    wget
)

sudo port install "${ports[@]}"


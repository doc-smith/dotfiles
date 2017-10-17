#!/usr/bin/env bash

set -euxo pipefail


if ! [ -x "$(command -v port)" ]; then
    >&2 echo "Error: MacPorts are not installed."
    >&2 echo "Download and install MacPorts: https://www.macports.org/install.php"
    exit 1
fi

MACPORTS_BASH_PATH=/opt/local/bin/bash
CURRENT_DEFAULT_SHELL=$(dscl . -read "/Users/${USER}" UserShell | awk -F': ' '{print $2}')

if [ "${MACPORTS_BASH_PATH}" == "${CURRENT_DEFAULT_SHELL}" ]; then
    >&2 echo "${MACPORTS_BASH_PATH} is already the default shell for ${USER}"
else
    sudo port install bash +completion
    if ! grep "${MACPORTS_BASH_PATH}" /etc/shells; then
        echo "${MACPORTS_BASH_PATH}" | sudo tee -a /etc/shells
    fi
    chsh -s "${MACPORTS_BASH_PATH}"
fi

sudo port install python27 +readline
sudo port select --set python python27
sudo port select --set python2 python27

sudo port install py27-pip
sudo port select --set pip pip27

sudo port install py27-virtualenv
sudo port select --set virtualenv virtualenv27

sudo port install py27-gnureadline

ports=(
    vim
    moreutils
    ffmpeg
    source-highlight
    wget
)

sudo port install "${ports[@]}"


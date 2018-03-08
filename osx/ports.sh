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


PYTHON_PORTS=(
    py27-gnureadline
    py36-gnureadline
    py36-pip
    py36-virtualenv
    py36-virtualenvwrapper
)

sudo port install python27 +readline
sudo port install python36 +readline
sudo port install "${PYTHON_PORTS[@]}"

sudo port select --set python python36
sudo port select --set python3 python36
sudo port select --set python2 python27
sudo port select --set pip pip36
sudo port select --set virtualenv virtualenv36


PORTS=(
    vim
    moreutils
    ffmpeg
    source-highlight
    wget
)

sudo port install "${PORTS[@]}"


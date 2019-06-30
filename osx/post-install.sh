#!/usr/bin/env bash

set -euo pipefail

source "${HOME}/.bashrc"


nvm install --lts
npm install -g spaceship-prompt


rvm use 2.6.3
gem install colorls

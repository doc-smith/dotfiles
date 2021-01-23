#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/common.sh"


stderr "Installing other useful ports..."
USEFUL_PORTS=(
    unzip
    jq
    tldr-cpp-client
    htop
    wget
)
sudo port install "${USEFUL_PORTS[@]}"
stderr "Installing other useful ports: done"

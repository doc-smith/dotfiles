#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


stderr() {
    echo "$@" 1>&2;
}


die() {
    stderr "$@"
    exit 1
}


if [[ "$OSTYPE" != "darwin"* ]]; then
    die "Sorry, your OS ${OSTYPE} is not macOS"
fi

MACHINE_TOOLS_DIR="${HOME}/tools"

if [[ ! -d "${MACHINE_TOOLS_DIR}" ]]; then
    mkdir "${MACHINE_TOOLS_DIR}"
fi

stderr "Setting symlinks..."

REPO_TOOLS_DIR="${SCRIPT_DIR}/tools"
TOOL_SETS=(
    tmux
)

for tset in "${TOOL_SETS[@]}"; do
    if [[ -e "${MACHINE_TOOLS_DIR}/${tset}" ]]; then
        stderr "${MACHINE_TOOLS_DIR}/${tset} already exists"
        stderr "  delete it first and run this script again"
    else
        ln -sv "${REPO_TOOLS_DIR}/${tset}" "${MACHINE_TOOLS_DIR}"
    fi
done

stderr "Setting symlinks: done"

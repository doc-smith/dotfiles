#!/usr/bin/env bash

set -euxo pipefail


stderr() {
    echo "$@" 1>&2;
}


die() {
    stderr "$@"
    exit 1
}


CODEFORCES_PATH="${HOME}/GitHub/contests/codeforces"

if ! [ -d "${CODEFORCES_PATH}" ]; then
    die "${CODEFORCES_PATH} doesnt exist"
fi

if ! [ -x "$(command -v tmux)" ]; then
    die "Install tmux first"
fi

SESSION_NAME=codeforces

if ! tmux has-session -t "${SESSION_NAME}"; then

    cd "${CODEFORCES_PATH}"

    tmux new-session -d -s "${SESSION_NAME}" -n main

    tmux split-window -l 10
    tmux new-window  -n "git"
    tmux select-window -t 0
    tmux select-pane -t 0

fi

tmux attach-session -t "${SESSION_NAME}"


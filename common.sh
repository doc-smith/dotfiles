# shellcheck shell=bash

stderr() {
    echo "$@" 1>&2;
}

die() {
    stderr "$@"
    exit 1
}

quietly() {
    "$@" > /dev/null
}

ask_sudo() {
    if ! sudo -v; then
        die 'You need sudo to run this script'
    fi
}

revoke_sudo() {
    sudo -k
}

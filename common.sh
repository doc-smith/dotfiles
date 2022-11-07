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

require_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        die "Sorry, your OS ${OSTYPE} is not macOS"
    fi
}

require_homebrew() {
    if ! quietly command -v brew; then
        die 'You need to install Homebrew first (https://brew.sh)'
    fi
}

ask_sudo() {
    if ! sudo -v; then
        die 'You need sudo to run this script'
    fi
}

revoke_sudo() {
    sudo -k
}

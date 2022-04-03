stderr() {
    echo "$@" 1>&2;
}

die() {
    stderr "$@"
    exit 1
}

require_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        die "Sorry, your OS ${OSTYPE} is not macOS"
    fi
}


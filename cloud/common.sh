stderr() {
    echo "$@" 1>&2;
}

die() {
    stderr "$@"
    exit 1
}

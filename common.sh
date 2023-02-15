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
    if [ "$(uname)" != "Darwin" ]; then
        die "Sorry, your OS is not macOS"
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

make_fish_login_shell() {
    if ! quietly command -v fish &> /dev/null; then
        die 'Fish is not installed'
    fi

    stderr 'Setting the login shell to fish...'
    local fish_path
    fish_path=$(which fish)

    if ! quietly grep "${fish_path}" /etc/shells; then
        echo "${fish_path}" | sudo tee -a /etc/shells > /dev/null
    fi

    sudo chsh -s "${fish_path}" "$(whoami)"
}

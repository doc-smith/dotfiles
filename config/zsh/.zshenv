export XDG_CONFIG_HOME="${HOME}/.config"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

export HISTFILE="${ZDOTDIR}/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

export EDITOR="vim"
export VISUAL="vim"

export PATH="${HOME}/tools/tmux:${PATH}"
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/:${PATH}"

. "$HOME/.cargo/env"

[ -f "${HOME}/.ghcup/env" ] && source "${HOME}/.ghcup/env"
[ -f "${HOME}/.cargo/env" ] && source "${HOME}/.cargo/env"

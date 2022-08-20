# PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# disable vi mode
bindkey -e

# completion system
autoload -U compinit; compinit
_comp_options+=(globdots)

zstyle ':completion:*' menu select=2


# Google Cloud SDK
if [ -f "${HOME}/tools/google-cloud-sdk/path.zsh.inc" ]; then
    . "${HOME}/tools/google-cloud-sdk/path.zsh.inc"
fi

if [ -f "${HOME}/tools/google-cloud-sdk/completion.zsh.inc" ]; then
    . "${HOME}/tools/google-cloud-sdk/completion.zsh.inc"
fi


# aliases
source "${ZDOTDIR}/aliases"

# history
setopt EXTENDED_HISTORY

hgrep () {
    fc -Dlim "*$@*" 1
}


# directory stack
setopt AUTO_PUSHD
setopt PUSHD_SILENT


# prompt
PROMPT="%F{green}%~ %f%% "
RPROMPT="[%*]"


export PATH="/opt/local/bin:/opt/local/sbin:${PATH}"
export PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="${PATH}:${HOME}/.rvm/bin"
export PATH="${PATH}:${HOME}/miniconda3/bin"

export EDITOR=code

export NVM_DIR="${HOME}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"

[[ -s "${HOME}/.rvm/scripts/rvm" ]] && . "${HOME}/.rvm/scripts/rvm"


xman() {
    man -t "$@" | open -f -a /Applications/Preview.app
}

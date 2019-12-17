MINICONDA_PATH="${HOME}/miniconda"
if [ -e "${MINICONDA_PATH}" ]; then
    export PATH="${PATH}:${MINICONDA_PATH}/bin"
    eval "$(${MINICONDA_PATH}/bin/conda shell.bash hook)"
fi

export PATH="${PATH}:${HOME}/.rvm/bin"
export PATH="/opt/local/bin:/opt/local/sbin:${PATH}"
export PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export EDITOR=code

export NVM_DIR="${HOME}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"

[[ -s "${HOME}/.rvm/scripts/rvm" ]] && . "${HOME}/.rvm/scripts/rvm"


function xman() {
    man -t "$@" | open -f -a /Applications/Preview.app
}


function gi() {
    curl -sL https://www.gitignore.io/api/\$@
}


LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
LANGUAGE=en_US:en
LC_PAPER=en_US.UTF-8
LESSCHARSET=utf-8
MM_CHARSET=utf-8

export LC_ALL LANG LANGUAGE LC_PAPER LESSCHARSET MM_CHARSET

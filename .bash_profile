export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

HISTSIZE=50000
HISTFILESIZE=50000

export WORKON_HOME='~/venvs'
source /usr/local/bin/virtualenvwrapper.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Set git autocompletion and PS1 integration
if [ -f /usr/local/git/contrib/completion/git-prompt.sh ]; then
    . /usr/local/git/contrib/completion/git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

export PS1="$(tput bold setaf 7)\u$(tput sgr0 setaf 7)@$(tput setaf 208)\h:$(tput setaf 80)\w$(tput setaf 120) \t$(tput setaf 208)\$(__git_ps1)$(tput sgr0 setaf 7)\$\n  "

alias l='ls'
alias ll='ls -loha'

export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/kyle/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

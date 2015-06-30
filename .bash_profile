export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
export HISTIGNORE="history *:cd *:df *:exit:e:fg:bg:file:e *:ll:ls:mc:top:"

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

# homebrew puts its completions in a different spot
if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

# export PS1="$(tput bold setaf 7)\u$(tput sgr0 setaf 7)@$(tput setaf 208)\h:$(tput setaf 80)\w$(tput setaf 120) \t$(tput setaf 208)\$(__git_ps1)$(tput sgr0 setaf 7)\$\n  "
PS1='\[${BLD}${USER_COLOR}\]\u\[${BLD}${CYN}\]@\[${HOST_COLOR}\]\h\[${BLD}${CYN}\]:\[${YLW}\]\w\[${RST}\]$(__git_ps1 " \[${BLD}${BCYN}\](%s)\[${RST}\] ") \[${BLK}\]\t\n\[${BLK}\]\$\[${RST}\] '

alias l='ls'
alias ll='ls -loha'

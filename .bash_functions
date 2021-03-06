#!/bin/bash

# cd to the current Finder window
cdf () {
    currFolderPath=$( /usr/bin/osascript <<"    EOT"
        tell application "Finder"
            try
                set currFolder to (folder of the front window as alias)
            on error
                set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
    EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

# 'quit iTunes' to kill the app
quit () {
    for app in $*; do
        osascript -e 'quit app "'$app'"'
    done
}

swap () {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# update the locate db
updatelocate () {
    sudo /usr/libexec/locate.updatedb
}

# Git magic

# Show files that have been added, modified, changed, or renamed in the
# current branch (in a commit)
function bchanged {
    git diff-tree --name-only -r $(git merge-base origin/master HEAD) HEAD | sort | uniq
}

# Filter to only the python files that have been changed in the branch
function bpychanged {
    bchanged | grep "\.py$"
}

# Run pylint on all files that have been modified in the
# working directory
function pychk {
    git status --porcelain | grep "\.py$" | awk '{print $2}' | xargs pylint
}

# Run pylint on all files that have commited modifications in this branch
function bpychk {
    for file in "$(bpychanged)"; do
        echo $file
        [ -e $file ] && pylint $file
    done
}

# disable bash-completion for tildes
_expand()
{
    return 0;
}

__expand_tilde_by_ref()
{
   return 0;
}

# This script searches .py files for the provided string arguments and outputs them all fancy-like
pf () {
    find . -name "*.py" \
        ! -regex "./[^/]*templates/.*" \
        ! -path "./config/locations/city_hoods.py" \
        ! -path "*htdocs*" \
        ! -path "*/.*" \
    | xargs -d '\n' grep -n --exclude="*.svn*" "$@" \
    | awk -f ~/dotfiles/formatfind.awk \
    | grep "$@" --color=auto
}

yf () {
   find . -name "*.yaml" ! -path "./[^/]*templates/.*" ! -path "*htdocs*" | xargs grep -n --exclude="*.svn*" "$@" | awk -f ~/dotfiles/formatfind.awk | grep "$@" --color=auto
}

function branches()
{
   for k in `git branch|sed s/^..//`;do echo -e `git log -1 --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" "$k"`\\t"$k";done|sort
}

# PS1 stuff
if [ $CLICOLOR ]; then
    BLD=$(tput bold)
    BLK=$(tput setaf 0)
    RST=$(tput sgr0)
    RED=$BLD$(tput setaf 1)
    GRN=$BLD$(tput setaf 2)
    YLW=$BLD$(tput setaf 3)
    BLU=$BLD$(tput setaf 4)
    MAG=$(tput setaf 5)
    CYN=$(tput setaf 6)
    WHT=$BLD$(tput setaf 7)
    BRED=$(tput setaf 9) # bright red
    BGRN=$(tput setaf 10) # bright green
    BYLW=$(tput setaf 11) # bright yellow
    BBLU=$(tput setaf 12) # bright blue
    BMAG=$(tput setaf 13) # bright magenta
    BCYN=$(tput setaf 14) # bright cyan
else
    BLD=""
    RST=""
    RED=""
    GRN=""
    YLW=""
    BLU=""
    MAG=""
    CYN=""
    WHT=""
    BRED=""
    BGRN=""
    BYLW=""
    BBLU=""
    BMAG=""
    BCYN=""
fi

declare -a COLOR_ARRAY

# for i in 15 203 9 187 11 120 10 22 14 75 33 21 5 90 55 0; do echo `tput bold` `tput setaf $i` hi; done
COLOR_ARRAY[1]=$(tput setaf 15)
COLOR_ARRAY[2]=$(tput setaf 203)
COLOR_ARRAY[3]=$(tput setaf 9)
COLOR_ARRAY[4]=$(tput setaf 187)
COLOR_ARRAY[5]=$(tput setaf 11)
COLOR_ARRAY[6]=$(tput setaf 120)
COLOR_ARRAY[7]=$(tput setaf 10)
COLOR_ARRAY[8]=$(tput setaf 22)
COLOR_ARRAY[9]=$(tput setaf 14)
COLOR_ARRAY[10]=$(tput setaf 75)
COLOR_ARRAY[11]=$(tput setaf 33)
COLOR_ARRAY[12]=$(tput setaf 21)
COLOR_ARRAY[13]=$(tput setaf 5)
COLOR_ARRAY[14]=$(tput setaf 90)
COLOR_ARRAY[15]=$(tput setaf 55)
COLOR_ARRAY[16]=$(tput setaf 00)

HOST_COLOR=${COLOR_ARRAY[$(hostname -s | shasum | head -c 1 | xargs printf '0x%s' | xargs printf '%d')]}
USER_COLOR=${COLOR_ARRAY[$(echo $USER | shasum | head -c 1 | xargs printf '0x%s' | xargs printf '%d')]}

__git_ps1 () {
    local git="$(git rev-parse --git-dir 2>/dev/null)"
    if [ -n "$git" ]; then
        local r
        local branch
        if [ -d "$git/../.dotest" ]; then
            rev="|AM/REBASE"
            branch="$(git symbolic-ref HEAD 2>/dev/null)"
        elif [ -f "$git/.dotest-merge/interactive" ]; then
            rev="|REBASE-i"
            branch="$(cat $git/.dotest-merge/head-name)"
        elif [ -d "$git/.dotest-merge" ]; then
            rev="|REBASE-m"
            branch="$(cat $git/.dotest-merge/head-name)"
        elif [ -f "$git/MERGE_HEAD" ]; then
            rev="|MERGING"
            branch="$(git symbolic-ref HEAD 2>/dev/null)"
        else
            if [ -f $git/BISECT_LOG ]; then
                rev="|BISECTING"
            fi
            if ! branch="$(git symbolic-ref HEAD 2>/dev/null)"; then
                branch="$(cut -c1-7 $git/HEAD)..."
            fi
        fi

        if [ -n "$1" ]; then
            printf "$1" "${branch##refs/heads/}$rev"
        else
            printf " (%s)" "${branch##refs/heads/}$rev"
        fi
    fi
}
echo ".bash_functions"

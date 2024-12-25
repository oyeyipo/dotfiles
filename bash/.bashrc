#!/bin/bash

# IF not running interactively, don't do anything
[[ $- != *i* ]] && return

# ls alias
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# grep alias
alias grep='grep --color=auto'

#######################################################
# GENERAL
#######################################################

iatest=$(expr index "$-" i)

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-unmodified On"; fi

######################################################
# ALIASES
######################################################

# Repeat the lst command with sudo prefixed
alias please="sudo $(fc -ln -1)"

# Open with default application
alias open="xdg-open"

# Support cls and k
alias k="clear"
alias cls="clear"

# More imformative commands
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"

# Always make full path
alias mkdir="mkdir -p -v"

# Make cd easier
alias cd..="cd .." # cd typo alias

# Git commands
alias g="git status"
alias gu="git status -u"
alias ga="git add"
alias gaa="git add ."
alias gau="git add -u"
alias gcm="git commit -m"
alias gca="git commit -am"
alias gb="git branch"
alias gbd="git branch -d"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gt="git stash"
alias gta="git stash apply"
alias gm="git merge"
alias gr="git rebase"
alias gl="git log --oneline --decorate --graph"
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias glga="git log --graph --oneline --all --decorate"
alias gb="git branch"
alias gs="git show"
alias gd="git diff --color --color-words --abbrev"
alias gdc="git diff --cached"
alias gbl="git blame"
alias gps="git push"
alias gpl="git pull"
alias gpst="git push origin --tags"
alias gc="git commit"
alias gk="gitk --all&"
alias gx="gitx --all"
alias grmc="git rm -r --cached"                    # Untrack Files without deleting them
alias gx="ign = ls-files -o -i --exclude-standard" # show ignored files by git

# Neovim
alias vim="nvim"
alias n="nvim"

# Python Django
alias pdtest="python manage.py test"
alias pdrun="python manage.py runserver"
alias pdftest="python manage.py test functional_tests"

# Remove!!!
alias lua="lua.exe"

#######################################################
# ENV
#######################################################

export LIBVA_DRIVER_NAME=i965

#######################################################
# PATHS
#######################################################

# This is so python/pip commands are available
PATH="$PATH:$HOME/.local/bin"

# This is where you put your hand rolled scripts (remember to chmod them)
PATH="$PATH:$HOME/bin"

######################################################
# FUNCTIONS
######################################################

# Automatically do an ls after each cd
cd() {
    if [ -n "$1" ]; then
        builtin cd "$@" && ls -a
    else
        builtin cd ~ && ls -a
    fi
}

#######################################################
# fnm (Fast Node Manager)
#######################################################

if [[ "$OSTYPE" == "mysys" ]]; then
    eval "$(fnm env --use-on-cd --shell bash)"
fi

#######################################################
# oh-my-posh setup
#######################################################

# the following must be as the last line
eval "$(oh-my-posh init bash --config "$HOME/custom-rubbyrussell.omp.json")"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

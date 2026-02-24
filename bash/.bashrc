#!/bin/bash

export HISTCONTROL=ignoredups:erasedups # no duplicate entries
export EDITOR="nvim"
export VISUAL="nvim"

# IF not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set FZF Defaults
export FZF_DEFAULT_OPTS="--layout=reverse --border=rounded --margin=3% --color=dark"

# Set pager
export PAGER="less"
export MANPAGER="less"

mann() { man "$@" | bat -l man --style=plain; }

# Make less feel vim-native
export LESS="-R --use-color -i"
export LESSHISTFILE=-

# Set VI mode
set -o vi
bind 'set keyseq-timeout 1'

# vi-mode cursor shape (works in many terminals)
function _vi_cursor() {
    # 1 = block, 5 = bar (DECSCUSR)
    printf '\e[%s q' "$1"
}

# Hook into Readline mode changes (Bash 4.4+ typically)
bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string \1\e[5 q\2'
bind 'set vi-cmd-mode-string \1\e[1 q\2'

# SHOPT
shopt -s autocd         # change to named directory
shopt -s cdspell        # autocorrects cd misspellings
shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s dotglob        # make `*` includes dotfile
shopt -s histappend     # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize   # checks term size when bash regains control

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"
bind "set show-all-if-unmodified on"

cdown() {
    N=$1
    while [[ $((--N)) -gt 0 ]]; do
        echo "$N" | figlet -c | lolcat && sleep 1
    done
}

### Function extract for common file formats ###
# Optimized Extract Function
ex() {
    if [ -z "$1" ]; then
        echo "Usage: ex <file>"
        return 1
    fi

    # Save current separator and switch to newline/backspace
    # This stays INSIDE the function so it doesn't affect your whole terminal
    local old_ifs=$IFS
    IFS=$(echo -en "\n\b")

    for n in "$@"; do
        if [ -f "$n" ]; then
            case "${n%,}" in
            *.tar.bz2 | *.tar.gz | *.tar.xz | *.tbz2 | *.tgz | *.txz | *.tar) tar xvf "$n" ;;
            *.bz2) bunzip2 "$n" ;;
            *.rar) unrar x "$n" ;;
            *.gz) gunzip "$n" ;;
            *.zip) unzip "$n" ;;
            *.z) uncompress "$n" ;;
            *.7z | *.iso) 7z x "$n" ;;
            *.xz) unxz "$n" ;;
            *) echo "ex: '$n' - unknown format" ;;
            esac
        else
            echo "'$n' - file does not exist"
        fi
    done

    # Restore original separator immediately
    IFS=$old_ifs
}

# navigation
up() {
    local d=""
    local limit="$1"

    # Default to limit of 1
    if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
        limit=1
    fi

    for ((i = 1; i <= limit; i++)); do
        d="../$d"
    done

    # perform cd. Show error if cd fails
    if ! cd "$d"; then
        echo "Couldn't go up $limit dirs."
    fi
}

### ALIASES ###
# navigation
alias cd='z'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# ls alias
# alias ls='ls --color=auto'
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'

alias l='eza -F --icons --icons --color=always --group-directories-first'       # type indicator
alias ls='eza -al --icons --color=always --group-directories-first'             # my preferred listing
alias la='eza -a --icons --color=always --group-directories-first'              # all files and dirs
alias ll='eza -l --icons --color=always --group-directories-first'              # long format
alias lt='eza -aT --icons --color=always --group-directories-first'             # tree listing
alias l.='eza -al --icons --color=always --group-directories-first ../'         # ls on the PARENT directory
alias l..='eza -al --icons --color=always --group-directories-first ../../'     # ls on directory 2 levels up
alias l...='eza -al --icons --color=always --group-directories-first ../../../' # ls on directory 3 levels up

# grep alias
alias grep='grep --color=auto'

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
alias gs="git show"
alias gd="git diff --color --color-words --abbrev"
alias gdc="git diff --cached"
alias gbl="git blame"
alias gps="git push"
alias gpl="git pull"
alias gpst="git push origin --tags"
alias gc="git commit"
alias grmc="git rm -r --cached" # Untrack Files without deleting them
alias gwl='git worktree list'
alias gwa='git worktree add'
alias gwr='git worktree remove'
alias gi='git ls-files -o -i --exclude-standard'

## Creates git worktree & configures Python environment in one step
wt() {
    local branch="$1"
    [[ -z "$branch" ]] && {
        echo "Usage: wt <branch>"
        return 1
    }

    local repo base dir
    repo=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)") || return 1
    base=$(git rev-parse --show-toplevel)
    dir="$base/../$repo-$branch"

    git worktree add "$dir" -B "$branch" || return 1
    cd "$dir" || return 1

    if [[ ! -d .venv ]]; then
        python -m venv .venv || return 1
    fi

    # shellcheck source=/dev/null
    source .venv/bin/activate || return 1

    [[ -f requirements.txt ]] && pip install -r requirements.txt
}

# Neovim
alias vim="nvim"
alias v="nvim"
alias n="nvim"

# Python Django
alias pdtest="python manage.py test"
alias pdrun="python manage.py runserver"
alias pdftest="python manage.py test functional_tests"

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
# cd() { builtin cd "$@" && ls -a; }

#######################################################
# fnm (Fast Node Manager)
#######################################################

if [[ "$OSTYPE" == "msys" ]]; then
    eval "$(fnm env --use-on-cd --shell bash)"
fi

#######################################################
# Linux desktop environment setting
#######################################################

if [ "$(uname)" = "Linux" ]; then
    # Only set XDG_CURRENT_DESKTOP if it isn't already defined.
    if [ -z "$XDG_CURRENT_DESKTOP" ]; then
        if pgrep -x "plasmashell" >/dev/null 2>&1; then
            # KDE session detected
            export XDG_CURRENT_DESKTOP="KDE"
        elif [ -n "$WAYLAND_DISPLAY" ]; then
            # Running on Wayland but KDE-assume Hyprland
            export XDG_CURRENT_DESKTOP="Hyprland"
        fi
    fi
fi

#######################################################
# Zellij Auto-start integration for bash
#######################################################

if [[ -z "$ZELLIJ" ]]; then
    # Auto-attach to an existing session if the user wants it
    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
        zellij attach -c
    else
        zellij -l welcome
    fi

    # Exit the shell after zellij if user sets ZELLIJ_AUTO_EXIT
    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        exit
    fi
fi

#######################################################
# Enable bash completion
#######################################################

if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# fzf CTRL-R history search
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash

#######################################################
# Starship setup
#######################################################

eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"
eval "$(mise activate bash)" # or zsh, fish, etc.

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
. "$HOME/.cargo/env"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
eval "$(pyenv virtualenv-init -)"

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="$FNM_PATH:$PATH"
    eval "$(fnm env)"
fi

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# improve startup with guard
# command -v starship >/dev/null && eval "$(starship init bash)"
# command -v zoxide  >/dev/null && eval "$(zoxide init bash)"
# command -v mise    >/dev/null && eval "$(mise activate bash)"

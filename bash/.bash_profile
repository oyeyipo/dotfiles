#!/bin/bash

# ~/.bash_profile

# Source .bashrc for interactive settings
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Add any Login-specific environment variables here
export EDITOR="nvim"
export LANG="en_US.UTF-8"

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# bun
if [ -d "$HOME/.bun" ]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

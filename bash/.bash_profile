# ~/.bash_profile

# Source .bashrc for interactive settings
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Add any Login-specific environment variables here
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export LANG="en_US.UTF-8"
. "$HOME/.cargo/env"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

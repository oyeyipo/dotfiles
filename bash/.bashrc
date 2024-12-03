#
# ~/.bashrc
#

# IF not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -al'
alias grep='grep --color=auto'
alias k="clear"

#-------------------------------------------------------------
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
alias grmc="git rm -r --cached"  # Untrack Files without deleting them
alias gx="ign = ls-files -o -i --exclude-standard"   # show ignored files by git

# --------- Python Django ----------------------------------
alias pdtest="python manage.py test"
alias pdrun="python manage.py runserver"
alias pdftest="python manage.py test functional_tests"

# oh-my-posh setup
# the following must be as the last line
eval "$(oh-my-posh init bash --config ~/AppData/Local/Programs/oh-my-posh/themes/robbyrussell.omp.json)" # There is a POSH_THEMES_PATH env that could have been used

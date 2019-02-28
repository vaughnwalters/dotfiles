[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

export PATH="$HOME/.rbenv/shims:$PATH"

export PATH="/usr/local/mysql-5.7.24-macos10.14-x86_64/bin:$PATH"

export PATH=$PATH:$HOME/Library/Python/2.7/bin
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /Users/vaughnwalters/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias l="ls -lha"

# title <string> to name terminal windows
function title {
    echo -ne "\033]0;"$*"\007"
}

#usage lh:8080 to set up a localhost on that port
#http://localhost:8080
alias lh="php -S localhost"

alias sp="spotify play"
alias spp="spotify pause"
alias spa="spotify play artist"
alias sn="spotify next"
alias ss="spotify status"

alias gs="git status"
alias ga="git add"
alias gcm="git commit -m"

alias V="vim ."
alias v="vim"

alias z="cd "

# added by Miniconda3 installer
export PATH="/Users/vaughnwalters/miniconda3/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# POWERLINE 
function _update_ps1() {
  PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# ALIASES
alias l="ls -lha"
alias sp="spotify play"
alias spp="spotify pause"
alias sn="spotify next"
alias ss="spotify status"
alias cornell="spotify play album 5/8/77"
alias reckoning="spotify play album reckoning live"
alias gs="git status"
alias ga="git add"
alias gcm="git commit -m"

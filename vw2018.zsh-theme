local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='${ret_status} %{$fg[green]%}%c%{$reset_color%} $(print_nvm_info) $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[red]%}ᛦ%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

#theme values
OZONO_THEME_NVM_SIMBOL="%{$fg[green]%}⬢"
OZONO_THEME_NVM_PREFIX="%{$fg_bold[blue]%}(%{$reset_color%}"
OZONO_THEME_NVM_SUFFIX="%{$fg_bold[blue]%})%{$reset_color%}"

#show nvm current version only when is necessary
function print_nvm_info {
    if command git >/dev/null 2>/dev/null; then
        return
    fi
    local mainPathPackageJson=$(git rev-parse --show-toplevel 2>/dev/null)"/package.json"
    if [[ -f $mainPathPackageJson ]]; then
        local result=""
        result+=$OZONO_THEME_NVM_SIMBOL" "
        result+=$OZONO_THEME_NVM_PREFIX
        result+=%{$fg[green]%}$(nvm current)
        result+=$OZONO_THEME_NVM_SUFFIX
        echo "$result"
    fi
}

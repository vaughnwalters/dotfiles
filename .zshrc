# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/vaughnwalters/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias l="ls -lha"
alias sp="spotify play"
alias spp="spotify pause"
alias sn="spotify next"
alias ss="spotify status"
alias cornell="spotify play album 5/8/77"
alias reckoning="spotify play album reckoning live"
alias mmm="spotify play album metal machine music"
alias gs="git status"
alias ga="git add"
alias gcm="git commit -m"
alias ce="cd ~/workspace/gerrit/mediawiki/extensions/CampaignEvents/"
alias wf="cd ~/workspace/gerrit/wikifunctions/mediawiki/extensions/WikiLambda/"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcdu="docker compose down && docker compose up -d"
alias dshell="docker compose exec mediawiki bash"
alias postinstall="campaigns && nvm use 18 && npm ci && git remote remove origin && git remote add origin ssh://vwalters@gerrit.wikimedia.org:29418/mediawiki/extensions/CampaignEvents && git remote -v"
alias please="sudo"
alias mru="(cd ~ && mr u)"

# nvm config stuff
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
 [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

NVM_DIR=~/.nvm source ~/.nvm/nvm.sh

# add ssh access for gerrit
ssh-add --apple-use-keychain  ~/.ssh/gerrit_rsa

# add ssh access for gitlab
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi
ssh-add ~/.ssh/gitlab_rsa 2>/dev/null

# Target MediaWiki-Docker
export MW_SERVER=http://localhost:8080
export MW_SCRIPT_PATH=/w
export MEDIAWIKI_USER=Admin
export MEDIAWIKI_PASSWORD=dockerpass

# for fresh
export PATH=$PATH:~/.local/bin

# --- DIR_CONTENTS ---

# Prints dir contents as a single string with file path heading above each file's contents
# Recurses down into subdirectories
# Excludes node_modules folders, package-lock.json and binary files

# Call with no exclusions
#   dir_contents

# Exclude SVG files
#   dir_contents -exclude "*.svg"

# Exclude SVG and JSON files
#   dir_contents -exclude "*.svg" -exclude "*.json"

# Exclude a specific folder (e.g., "build")
#   dir_contents -exclude "build/"

# Exclude multiple folders and file types
#   dir_contents -exclude "build/" -exclude "dist/" -exclude "*.log" -exclude "*.tmp"

# You can redirect the output of dir_contents to a file
#   dir_contents -exclude "*.svg" > ~/Desktop/my_project.txt

# Note: on macOS you can directly pipe the output of dir_contents to the paste buffer
#   dir_contents -exclude "*.svg" | pbcopy
# Then you can just paste the string wherever needed

# Use "--dry" to do a dry run printing only the file names instead of contents
function dir_contents() {
  local find_args=( . -type f ! -path "*/.git/*" ! -path "*/node_modules/*" ! -name "package-lock.json" )
  local exclude_patterns=()
  local dry_run=false

  # Parse arguments
  while [[ $# -gt 0 ]]; do
    case $1 in
      -exclude)
        if [[ $2 == *"/" ]]; then
          exclude_patterns+=("*/$2*")
        else
          exclude_patterns+=("$2")
        fi
        shift 2
        ;;
      --dry)
        dry_run=true
        shift
        ;;
      *)
        echo "Unknown option: $1" >&2
        return 1
        ;;
    esac
  done

  # Add exclusions
  for pattern in "${exclude_patterns[@]}"; do
    find_args+=( ! -path "$pattern" )
  done

  find "${find_args[@]}" -print0 |
    while IFS= read -r -d '' file; do
      if file "$file" | grep -qE 'text|JSON'; then
        if $dry_run; then
          echo "$file"
        else
          echo -e "\n\n\n\n============= File: $file =============\n"
          cat "$file"
        fi
      fi
    done
}

                                                                                      zsh  utf-8[unix]  0% ㏑:1/224☰℅.:1

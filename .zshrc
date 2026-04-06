export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
export ZSH="/Users/vaughnwalters/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh
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
alias postinstall="campaigns && nvm use 22 && npm ci && git remote remove origin && git remote add origin ssh://vwalters@gerrit.wikimedia.org:29418/mediawiki/extensions/CampaignEvents && git remote -v"
alias please="sudo"
alias mru="(cd ~ && mr u)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# add ssh keys
ssh-add --apple-use-keychain ~/.ssh/gerrit_rsa > /dev/null 2>&1
ssh-add --apple-use-keychain ~/.ssh/gitlab_rsa > /dev/null 2>&1
ssh-add --apple-use-keychain ~/.ssh/github_rsa > /dev/null 2>&1
ssh-add --apple-use-keychain ~/.ssh/id_ed25519 > /dev/null 2>&1

# Target MediaWiki-Docker
export MW_SERVER=http://localhost:8080
export MW_SCRIPT_PATH=/w
export MEDIAWIKI_USER=Admin
export MEDIAWIKI_PASSWORD=dockerpass

# for fresh
export PATH=$PATH:~/.local/bin

# Claude Code
export CLAUDE_CODE_EFFORT_LEVEL=max
alias claude="claude --chrome"

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


# Added by Antigravity
export PATH="/Users/vaughnwalters/.antigravity/antigravity/bin:$PATH"

# quibble-local tab completion
_quibble_component() {
  local script_dir="${words[1]:A:h}"
  if [[ -z "$_quibble_gated" ]] && [[ -x "$script_dir/gated" ]]; then
    _quibble_gated="$("$script_dir"/gated 2>/dev/null)"
  fi
  local -a components=("${(@f)_quibble_gated}")
  [[ -n "${components[1]}" ]] && compadd -- "${components[@]}"
}
for _cmd in install run_selenium_tests run_php_unit_tests run_selenium_tests_all \
  run_selenium_tests_required dependencies dependencies_combinations \
  dependencies_optional dependencies_required dependencies_minimal \
  dependencies_minimal_bottom_up dependencies_minimal_thorough selenium_tests_exist
do compdef _quibble_component "./$_cmd"; done
unset _cmd

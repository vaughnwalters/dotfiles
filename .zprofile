eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH=$PATH:$HOME/gitshorts

# add ssh keys
ssh-add --apple-use-keychain ~/.ssh/gerrit_rsa > /dev/null 2>&1
ssh-add --apple-use-keychain ~/.ssh/gitlab_rsa > /dev/null 2>&1
ssh-add --apple-use-keychain ~/.ssh/github_rsa > /dev/null 2>&1
ssh-add --apple-use-keychain ~/.ssh/id_ed25519 > /dev/null 2>&1

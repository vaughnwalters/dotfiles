#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"

backup_if_real() {
  local target="$1"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "${target}.bak.$(date +%s)"
  fi
}

link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  backup_if_real "$dest"
  ln -sfn "$src" "$dest"
}

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "Installing Brewfile packages..."
brew bundle --file="$DOTFILES/Brewfile"

echo "Linking dotfiles..."
for f in .bash_profile .bashrc .gitconfig .gitignore_global .ideavimrc .mrconfig .muttrc .tmux.conf .vimrc .zprofile .zshrc; do
  link "$DOTFILES/$f" "$HOME/$f"
done

link "$DOTFILES/.config/git/ignore" "$HOME/.config/git/ignore"
link "$DOTFILES/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

echo
echo "Bootstrap complete."
echo
echo "Manual follow-up:"
echo "  - Copy ~/.ssh/ from old Mac (or generate new keys and register with GitHub/GitLab/gerrit)"
echo "  - Copy credential dirs as needed: ~/.aws/ ~/.gcloud/ ~/.kube/ ~/.docker/ ~/.npmrc"
echo "  - Install ~/.claude config (settings.json, skills, memory)"
echo "  - Sign into seat-limited apps (Sourcetree, 1Password, Adobe, JetBrains)"
echo "  - Install Mac App Store apps"
echo "  - Install Antigravity if still used (path is referenced in .zshrc)"

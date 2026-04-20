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

echo "Machine flavor:"
echo "  1) work"
echo "  2) personal"
read -p "Enter 1 or 2: " flavor_choice

case "$flavor_choice" in
  1) FLAVOR=work ;;
  2) FLAVOR=personal ;;
  *) echo "Invalid choice: $flavor_choice"; exit 1 ;;
esac

read -p "Git email for this machine: " GIT_EMAIL
if [ -z "$GIT_EMAIL" ]; then
  echo "Email cannot be empty"; exit 1
fi

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
DOTFILE_NAMES=(.bash_profile .bashrc .gitconfig .gitignore_global .ideavimrc .muttrc .tmux.conf .vimrc .zprofile .zshrc)
if [ "$FLAVOR" = work ]; then
  DOTFILE_NAMES+=(.mrconfig)
fi

for f in "${DOTFILE_NAMES[@]}"; do
  link "$DOTFILES/$f" "$HOME/$f"
done

link "$DOTFILES/.config/git/ignore" "$HOME/.config/git/ignore"
link "$DOTFILES/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

echo "Applying macOS defaults..."
"$DOTFILES/macos.sh"

echo "Writing ~/.gitconfig.local with $FLAVOR email ($GIT_EMAIL)..."
cat > "$HOME/.gitconfig.local" <<EOF
[user]
	email = $GIT_EMAIL
EOF

echo
echo "Bootstrap complete ($FLAVOR)."
echo
echo "Manual follow-up:"
echo "  - Copy ~/.ssh/ from old Mac (or generate new keys and register with GitHub/GitLab/gerrit)"
echo "  - Copy any credential dirs from old Mac as needed"
echo "  - Rsync ~/.claude/ from old Mac (excluding cache/ sessions/ shell-snapshots/ file-history/ paste-cache/ session-env/ telemetry/ usage-data/ history.jsonl)"
echo "  - Sign into seat-limited apps (Sourcetree, 1Password, Adobe, JetBrains)"
echo "  - Install Mac App Store apps"
echo "  - Copy ~/Pictures/ from old Mac, then re-pick wallpaper + screen saver in System Settings"

#!/usr/bin/env bash
set -euo pipefail

# Keyboard: fast repeat, short initial delay
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Finder: column view
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Dock: autohide, slightly larger tiles
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 64

# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true

echo "macOS defaults applied."

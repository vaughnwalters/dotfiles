#!/usr/bin/env bash
set -euo pipefail

# Keyboard: fast repeat, short initial delay
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Trackpad + mouse: max tracking speed
defaults write -g com.apple.trackpad.scaling -float 3
defaults write -g com.apple.mouse.scaling -float 3

# Remap CapsLock → Control (applied now + persisted via LaunchAgent for reboots)
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}' >/dev/null
mkdir -p "$HOME/Library/LaunchAgents"
PLIST="$HOME/Library/LaunchAgents/com.local.capslock-to-control.plist"
cat > "$PLIST" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.local.capslock-to-control</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/hidutil</string>
        <string>property</string>
        <string>--set</string>
        <string>{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF
launchctl bootout "gui/$(id -u)/com.local.capslock-to-control" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$PLIST"

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

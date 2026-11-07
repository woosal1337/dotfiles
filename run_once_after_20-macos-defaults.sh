#!/bin/sh
# macOS settings the rice needs. Runs once per machine.

# Always hide the menu bar; SketchyBar sits in its place
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write com.apple.controlcenter AutoHideMenuBarOption -int 0

# Free ⌃← / ⌃→ for Rift: turn off Mission Control's "Move left/right a space".
# shortcut: Set fails if macOS never wrote these keys; untick them in Keyboard Shortcuts then.
P="$HOME/Library/Preferences/com.apple.symbolichotkeys.plist"
for k in 79 80 81 82; do
  /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:${k}:enabled false" "$P" 2>/dev/null
done
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

# Xcode: Vesper as the dark theme
defaults write com.apple.dt.Xcode XCFontAndColorCurrentDarkTheme -string Vesper.xccolortheme

killall ControlCenter SystemUIServer 2>/dev/null || true

#!/usr/bin/env bash

# Finder
#

# show path bar
defaults write com.apple.finder ShowPathbar -bool true

# show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# don't show removable media, disks and mounted servers on the Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# always use "View -> as List"
defaults write com.apple.Finder FXPreferredViewStyle Nlsv


# Safari
#

# set Safari's home page to 'about:blank'
defaults write com.apple.Safari HomePage -string "about:blank"


#!/bin/sh

# Packages live in the Brewfile (installed by 02-homebrew.sh). This script holds the non-brew steps.

# AI
curl -fsSL https://claude.ai/install.sh | sh
# brew install claude-code -- the release cycle is slow, so we install the latest version directly from the Claude team

# Touch ID for sudo. /etc/pam.d/sudo_local survives macOS updates (unlike editing /etc/pam.d/sudo).
# pam_reattach lets Touch ID work inside tmux. Requires sudo, so run this script yourself.
if [ ! -f /etc/pam.d/sudo_local ]; then
  printf '%s\n' \
    'auth       optional       /opt/homebrew/lib/pam/pam_reattach.so ignore_ssh' \
    'auth       sufficient     pam_tid.so' \
    | sudo tee /etc/pam.d/sudo_local >/dev/null
fi

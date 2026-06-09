#!/bin/sh

echo "====================="
echo " Post install notes! "
echo "====================="

echo " Disable 'Shake mouse pointer to locate':"
echo "------------------------------------------"
echo " System Preferences -> Accessibility -> Display -> Cursor"
echo ""

echo " Configure sync in iCloud/Documents/Tools:"
echo "-------------------------------------------"
echo " - Alfred"
echo " - Dash"
echo ""

echo " Generate machine-local shell completions:"
echo "-------------------------------------------"
echo " mkdir -p ~/.local/share/zsh/completions"
echo " register-python-argcomplete az > ~/.local/share/zsh/completions/az.zsh"
echo " npm completion > ~/.local/share/zsh/completions/npm.zsh"
echo " uv generate-shell-completion zsh > ~/.local/share/zsh/site-functions/_uv"
echo " rm -f ~/.zcompdump && exec zsh"
echo "(rerun after major upgrades of az, npm, or uv)"
echo ""
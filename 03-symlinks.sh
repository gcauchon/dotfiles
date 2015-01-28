#!/bin/sh 

# zsh
ln -s $(pwd)/zsh/.zsh ../.zsh
ln -s $(pwd)/zsh/.zshrc ../.zshrc

chsh -s /usr/local/bin/zsh

# slate
ln -s $(pwd)/slate/.slate.js ../.slate.js

# ruby
ln -s $(pwd)/ruby/.gemrc ../.gemrc
ln -s $(pwd)/ruby/.pryrc ../.pryrc

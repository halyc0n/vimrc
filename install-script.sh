#!/bin/bash

# Download the .vimrc
wget -O ~/.vimrc https://raw.githubusercontent.com/halyc0n/vimrc/master/.vimrc

# Install the bundler
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# Install all bundles
vim -c "NeoBundleInstall" -c "q"

# Go home
cd ~

#!/bin/bash

# Download the .vimrc
curl https://raw.githubusercontent.com/halyc0n/vimrc/master/.vimrc > ~/.vimrc

# Install the bundler
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# Install all bundles
vim -c "NeoBundleInstall" -c "q"

# Update PHP syntax highlight
cd ~/.vim/bundle/php.vim/scripts/
php update-vim-syntax.php > ~/.vim/bundle/php.vim/syntax/php.vim

# Install PHP Code Sniffer
composer global require "squizlabs/php_codesniffer"

# Finish installation by installing `tern_for_vim`
cd ~/.vim/bundle/tern_for_vim/
npm install

# Go home
cd ~

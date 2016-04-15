halyc0n's vim config
===

Features
---

- Syntax highlighting for common things in webdev
  * [PHP](https://github.com/StanAngeloff/php-vim)
  * [JavaScript](https://github.com/pangloss/vim-javascript)
  * [JSON](https://github.com/elzr/vim-json)
  * [Markdown](https://github.com/tpope/vim-markdown)
- [Unite.vim](https://github.com/Shougo/unite.vim) with awesome fuzzy search features
  * `<C-n>` to open a file in the current directory
  * `<leader><C-n>` to open a file in some subdirectory recursively using an
    external program for speed. (uses `find` by default, install `ag` for
    speed, will be used if available).
  * `<leader>d` to change the current directory
  * [`:VimShell`](https://github.com/Shougo/vimshell.vim) to open a shell written in vimscript.
  * `<leader>p` to paste a segment from yank history
  * `<leader>g` to open a list of Fugitive menu items (editable in vimrc)
  * `<leader>j` to open a list of other menu items (editable in vimrc)
- [Surround.vim](https://github.com/tpope/vim-surround) - to surround text with
  tags, brackets, parentheses or quotes
- [Emmet](https://github.com/mattn/emmet-vim) - plugin which provides support
  for expanding abbreviations
- [Fugitive.vim](https://github.com/tpope/vim-fugitive) - git wrapper
- [vim-gitgutter](https://github.com/airblade/vim-gitgutter) - plugin which shows
  git diff in the gutter
- [Tern.js](http://ternjs.net/) - plugin like IntelliSense for JavaScript
- [Syntastic](https://github.com/scrooloose/synastic) - syntax checking hacks
- [NERDCommenter](https://github.com/scrooloose/nerdcommenter) - speed
  commenting
- [NERDTree](https://github.com/scrooloose/nerdtree) - a tree explorer plugin

Weird visual things you might want to change

- [vim-airline](https://github.com/bling/vim-airline) - status bar
- [Tomorrow Night Theme](https://github.com/Slava/vim-tomorrow-js) -
  specifically, a fork extended for JS

Weird bindings you might want to change

- `<leader>` is mapped to comma `,`
- `<C-hjkl>` mapped to movement between splits
- `<leader>/` to kill current search
- `<leader>l` to highlight non-printing characters
- `<leader>w` saves the file (maps to `:w<enter>`)
- `<leader>g` to open a list of Fugitive menu items
- `<leader>j` to open a list of other menu items
- `<leader>b` to start insert buffer
- `<leader>m` toggle between two previous buffers
- `<C-space>` to start insert files

- quick `jk` in insert mode is mapped to `ESC` to avoid pressing `ESC`
- `<C-y>` :NERDTreeToggle
- `\s` search and replace word under cursor
- `\g` search word under cursor in files
- `\a` using ag with arguments (:Ag -i word my/dir)
- `\f` format the entire file

Dependencies
---

- Vim built with `+python` for `ternjs`
- Vim built with `+lua` for `neocomplete.vim`
- npm and node.js for `ternjs`
- C compiler for `unite.vim`
- `make` for `vimproc`
- `git` to fetch dependencies (this sucks, I know)
- `ag` (optional) for the speedy subdirectory search (see [the repo](https://github.com/ggreer/the_silver_searcher))

Installation
---

First of all be sure to have a compatible version of Vim. Check installation by
typing `vim --version | grep lua` in shell or `:echo has("lua")` in vim.

Install prerequisite libraries:

    $ sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
        libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
        libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
        ruby-dev mercurial

Remove original Vim:

    $ sudo apt-get remove vim vim-runtime gvim

Install Lua:

    $ sudo apt-get install liblua5.2-dev lua5.2

Compile Vim74 from source:

    $ wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
    $ tar xvf vim-7.4.tar.bz2
    $ cd vim74
    $ ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr

set Vim RUNTIMEDIR:

    $ make VIMRUNTIMEDIR=/usr/share/vim/vim74

Finish install:

    $ sudo make install

After you can run the bash script from this repo which will take care of
everything but will do something terrible if you already have any of `.vim` or
`.vimrc`. But it works great on a clean set up:

    $ wget -O ~/install-script.sh https://raw.github.com/halyc0n/vimrc/master/install-script.sh
    $ bash ~/install-script.sh

Manual installation
---

Download `.vimrc` file.

    $ wget -O ~/.vimrc https://raw.github.com/halyc0n/vimrc/master/.vimrc

Install `neobundle`

    $ mkdir -p ~/.vim/bundle
    $ git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

Open `vim`, install all the packages, quit vim:

    $ vim -c "NeoBundleInstall" -c "q"

Update PHP syntax highlight

    $ cd ~/.vim/bundle/php.vim/scripts
    $ php update-vim-syntax.php > ~/.vim/bundle/php.vim/syntax/php.vim

Install PHP Code Sniffer

    $ composer global require "squizlabs/php_codesniffer"

Finish installation by installing `tern_for_vim`:

    $ cd ~/.vim/bundle/tern_for_vim/
    $ npm install

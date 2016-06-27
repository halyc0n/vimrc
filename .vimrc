if has("vim_starting")
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand("~/.vim/bundle/"))

NeoBundleFetch "Shougo/neobundle.vim"

NeoBundle "Shougo/vimproc", {
      \ "build" : {
      \     "windows" : "make -f make_mingw32.mak",
      \     "cygwin" : "make -f make_cygwin.mak",
      \     "mac" : "make -f make_mac.mak",
      \     "unix" : "make -f make_unix.mak",
      \    },
      \ }

" Ultimate UI system for running fuzzy-search on different things {{{
NeoBundle "Shougo/unite.vim"
NeoBundle "Shougo/neoyank.vim"
NeoBundle "Slava/vim-unite-files-ag"
  " Always start insert mode
  let g:unite_enable_start_insert = 1
  " let g:unite_source_history_yank_enable = 1
  let g:unite_split_rule = "botright"

" `ag` is a faster and better replacement for the standard `find`, let Unite use
" it if it exists and configure to properly use `.gitignore` or `.hgignore`
" files if those exist.
" To install `ag`: brew install ag
" or: https://github.com/ggreer/the_silver_searcher
if executable("ag")
  let g:unite_source_grep_command = "ag"
  let g:unite_source_grep_default_opts = "--nogroup --nocolor --column"
  let g:unite_source_grep_recursive_opt = ""
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Search settings {{{
if exists("*unite")
  call unite#filters#matcher_default#use(["matcher_fuzzy"])
  call unite#filters#sorter_default#use(["sorter_rank"])
  call unite#set_profile("files", "smartcase", 1)
endif
"}}}

" Auto-completion plugin integrated with Unite and vimshell {{{
NeoBundle "Shougo/neocomplete.vim"
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#min_keyword_length = 3

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    "return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
  " Close popup by <Space>.
  inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

  " AutoComplPop like behavior.
  let g:neocomplete#enable_auto_select = 1

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType php setlocal omnifunc=phpcomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.go = '[^.[:digit:] *\t]\.'
"}}}

" Expand/shrink the visual selection by text-object blocks with `+` and `_` in
" the visual mode
NeoBundle "terryma/vim-expand-region"

NeoBundle "tpope/vim-fugitive"
NeoBundle "airblade/vim-gitgutter"

" Different stuff in the menu (depends on Unite.vim) {{{

if !exists("g:unite_source_menu_menus")
  let g:unite_source_menu_menus = {}
endif

" Fugitive menu in Unite (depends on both Fugitive and Unite.vim) {{{
let g:unite_source_menu_menus.git = {}
let g:unite_source_menu_menus.git.description = "git (Fugitive)"
let g:unite_source_menu_menus.git.command_candidates = [
    \['▷ git status       (Fugitive)',
        \'Gstatus'],
    \['▷ git diff         (Fugitive)',
        \'Gdiff'],
    \['▷ git commit       (Fugitive)',
        \'Gcommit'],
    \['▷ git log          (Fugitive)',
        \'exe "silent Glog | Unite quickfix"'],
    \['▷ git blame        (Fugitive)',
        \'Gblame'],
    \['▷ git stage        (Fugitive)',
        \'Gwrite'],
    \['▷ git checkout     (Fugitive)',
        \'Gread'],
    \['▷ git rm           (Fugitive)',
        \'Gremove'],
    \['▷ git mv           (Fugitive)',
        \'exe "Gmove " input("destino: ")'],
    \['▷ git push         (Fugitive, output buffer)',
        \'Git! push'],
    \['▷ git pull         (Fugitive, output buffer)',
        \'Git! pull'],
    \['▷ git prompt       (Fugitive, output buffer)',
        \'exe "Git! " input("comando git: ")'],
    \['▷ git cd           (Fugitive)',
        \'Gcd'],
    \]
"}}}

" Different stuff in the menu (depends on Unite.vim) {{{
let g:unite_source_menu_menus.all = {}
let g:unite_source_menu_menus.all.description = "All things"
let g:unite_source_menu_menus.all.command_candidates = [
    \['▷ save file', 'write'],
    \['▷ save all opened files', 'wall'],
    \['▷ make the current window the only one on the screen', 'only'],
    \['▷ open file (Unite)', 'Unite -start-insert file'],
    \['▷ open file recursively (Unite)', 'Unite -start-insert files_ag'],
    \['▷ open buffer (Unite)', 'Unite -start-insert buffer'],
    \['▷ open directory (Unite)', 'Unite -start-insert directory -profile-name=files'],
    \['▷ toggle the background color', 'ToggleBG'],
    \['▷ open the shell (VimShell)', 'VimShell'],
    \['▷ open a new shell (VimShell)', 'VimShellCreate'],
    \['▷ open a node interpreter (VimShell)', 'VimShellInteractive node'],
    \['▷ install bundles (NeoBundleInstall)', 'NeoBundleInstall'],
    \['▷ clean bundles (NeoBundleClean)', 'NeoBundleClean'],
    \['▷ update bundles (NeoBundleUpdate)', 'NeoBundleUpdate'],
    \]
"}}}

" Surrond plugin! Surrond text with a pair of anything (s in normal) {{{
NeoBundle "tpope/vim-surround"
"}}}

" Vim JS autocompletion with type hints {{{
NeoBundle "ternjs/tern_for_vim"
  let g:tern_show_argument_hints = "on_move"
"}}}

NeoBundle "mattn/emmet-vim"
NeoBundle "elzr/vim-json"
NeoBundle "tpope/vim-markdown"
NeoBundle "pangloss/vim-javascript"

"NeoBundle "mxw/vim-jsx"

NeoBundle "StanAngeloff/php.vim"
NeoBundle "shawncplus/phpcomplete.vim"

" Go {{{
NeoBundle "fatih/vim-go"
  " By default syntax-highlighting for Functions, Methods and Structs is
  " disabled.
  " Let's enable them!
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
"}}}

NeoBundle "scrooloose/syntastic"
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_php_checkers=["phpcs", "php"]
  let g:syntastic_php_phpcs_exec="~/.composer/vendor/bin/phpcs"
  let g:syntastic_php_phpcs_args="--standard=PSR2 -n"

  let g:syntastic_javascript_checkers=["eslint"]

NeoBundle "scrooloose/nerdcommenter"

" Shell in my VIM {{{
NeoBundle "Shougo/vimshell"
  let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
  let g:vimshell_prompt =  "$ "
"}}}

NeoBundle "vim-airline/vim-airline"
NeoBundle "vim-airline/vim-airline-themes"
  let g:airline_theme="tomorrow"
  set laststatus=2
  set encoding=utf-8
  if has("gui_running")
    let g:airline_powerline_fonts=1
    " Even special font for this crap
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
  endif

  function! AirlineOverride(...)
    let g:airline_section_a = airline#section#create(["mode"])
    let g:airline_section_b = airline#section#create_left(["branch"])
    let g:airline_section_c = airline#section#create_left(["%f"])
    let g:airline_section_y = airline#section#create([])

    "let g:airline_section_a = airline#section#create(['mode',' ','branch'])
    "let g:airline_section_b = airline#section#create_left(['ffenc','hunks','%f'])
    "let g:airline_section_c = airline#section#create(['filetype'])
    "let g:airline_section_x = airline#section#create(['%P'])
    "let g:airline_section_y = airline#section#create(['%B'])
    "let g:airline_section_z = airline#section#create_right(['%l','%c'])
  endfunction
  autocmd VimEnter * call AirlineOverride()

" Colorscheme {{{
NeoBundle "Slava/vim-colors-tomorrow"
set t_Co=256
let g:tomorrow_termcolors = 256
let g:tomorrow_termtrans = 0 " set to 1 if using transparant background
let g:tomorrow_diffmode = "high"
"}}}

NeoBundle "scrooloose/nerdtree"
  let g:NERDTreeDirArrowExpandable = "+"
  let g:NERDTreeDirArrowCollapsible = "~"
  autocmd StdinReadPre * let s:std_in = 1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  "nmap <C-t> :NERDTreeToggle<CR>

" Insert/Delete brackets in pairs
NeoBundle "jiangmiao/auto-pairs"

NeoBundle "Valloric/MatchTagAlways"
  let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'xhtml' : 1,
      \ 'xml' : 1,
      \ 'jinja' : 1,
      \ 'php' : 1,
      \}

NeoBundle "Yggdroot/indentLine"
  let g:indentLine_enabled = 1
  autocmd VimEnter * IndentLinesToggle

call neobundle#end()

syntax enable

set colorcolumn=120

" Numbers, can you imagine?
set number

" Extra info on the bottom
set ruler

" Highlight current line
set cursorline

" Leader key is comma
let mapleader = ","

" Search tweaks {{{
set hlsearch
set incsearch
" Kill current search
nnoremap <silent> <Leader>/ :nohlsearch<CR>
set ignorecase
set smartcase
"}}}

" Prefer spaces to tabs and set size to 2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" dumb indent
set autoindent

set visualbell
set lazyredraw

set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions-=r "remove right-hand scroll bar
set guioptions-=L "remove left-hand scroll bar

" AutoCmd essentials {{{
if has("autocmd")
  " Enable file type detection
  filetype on
  filetype plugin indent on
  autocmd FileType php setlocal ts=4 sts=4 sw=4
  autocmd FileType python setlocal ts=4 sts=4 sw=4
  autocmd FileType cs setlocal ts=4 sts=4 sw=4
  autocmd FileType go setlocal ts=4 sts=4 sw=4
endif
"}}}

" Tweak the behavior of <Tab> in command mode
set wildmenu
set wildmode=longest:full,full

" Indentation tweaks:
" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Buffers tweaks
" Allow to switch from changed buffer
set hidden

" Splits tweaks {{{
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set nowrap

" Save undo history persistently on disk, takes extra space {{{
if has("persistent_undo")         " persistend undo history
  " create the directory if it doesn't exist
  silent !mkdir ~/.vim/undo > /dev/null 2>&1
  set undofile                  " Save undo's after file closes
  set undodir=~/.vim/undo/      " where to save undo histories
  set undolevels=100            " How many undos
  set undoreload=3000           " number of lines to save for undo
endif
"}}}

" Automatically removing all trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

nmap <leader>l :set list!<CR>
set listchars=eol:¬

" Tweak ESC to be 'jk' typed fast
imap jk <ESC>

" Save file quickly
nnoremap <leader>w :w<CR>
" Quickly cd to directory
nnoremap <leader>d :Unite -start-insert directory -profile-name=files<CR>
" Paste from the yank history
nnoremap <leader>p :Unite -start-insert history/yank<CR>
" Trigger the git menu
nnoremap <leader>g :Unite -silent -start-insert menu:git<CR>
" Open all menus with useful stuff
nnoremap <leader>j :Unite -silent -start-insert menu:all menu:git<CR>
" Select across all buffers
nnoremap <leader>b :Unite -start-insert buffer<CR>
"}}}

" Other mappings {{{
" Quickly open files or buffers
nnoremap <C-n> :Unite -start-insert file -profile-name=files<CR>
nnoremap <C-@> :Unite -start-insert files_ag<CR>

" Toggle between two previous buffers
nmap <leader>m <leader>b<CR>

nmap <leader>o :NERDTreeToggle<cr>
"}}}

inoremap <leader>, <C-x><C-o>

" Search and replace word under cursor
nnoremap \s :%s/\<<c-r>=expand("<cword>")<cr>\>/

" Search word under cursor in files
nnoremap \g :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Using ag arguments
" :Ag -i word my/dir
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \a :Ag<SPACE>

" Format the entire file
nnoremap \f mngg=G`n`

" Automatically reload vimrc when it's saved {{{
augroup VimrcSo
  au!
  autocmd BufWritePost $MYVIMRC so $MYVIMRC
augroup END
"}}}

" Set shell to bash (because vim would conflict with the default system shell)
set shell=/bin/bash

" For the VimR search rules
set wildignore=*.so,*.a,*.pyc,.build.*,.git"

function! ToggleFullScreen()
  if &go =~ "e"
    exec("silent !wmctrl -r :ACTIVE: -b add,fullscreen")
    exec("set go-=e")
  else
    exec("silent !wmctrl -r :ACTIVE: -b remove,fullscreen")
    exec("set go+=e")
  endif
endfunction

nnoremap <F11> :call ToggleFullScreen()<CR>
inoremap <F11> :call ToggleFullScreen()<CR>

try
  colorscheme tomorrow
  set background=dark
catch
  " we don't have this theme or it throws
endtry

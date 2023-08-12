"Switch between vertical windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

syntax enable
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

syntax enable 		"enable syntax processing
set tabstop=4		"number of colums a TAB counts for
set softtabstop=4	"number of spaces in tab when editing
set shiftwidth=0 "if zero then takes current tabstop value
set expandtab		"tabs are spaces
set backspace=indent,eol,start "bs behaves like many other programs
set number		"show line numbers
set showcmd		"show command in bottom bar
set cursorline cursorcolumn		"highlight current line
filetype indent on 	"load fuletype-specific indent files
set wildmenu		"visual autocomplete for command menu
set lazyredraw		"redraw only when we need to
set showmatch 		"highlight matching [{()}]
"set background=dark
"Searching
set incsearch 		"search as characters are entered
set hlsearch 		"highlight matches
"Folding
set foldenable 		    "enable folding
set foldlevelstart=10	"open most folds by default
set foldnestmax=10	    "10 nested fold max
set foldmethod=indent	"fold based on indent level
set colorcolumn=80
let mapleader=","

"Try a different plugin manager rather than manually
"mantaining plugins via git submodules
"https://github.com/junegunn/vim-plug (requires git)
"To install just do :PlugInstall
"

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'http://github.com/tpope/vim-fugitive' " Fugitive (Delete if slowing down execution)
Plug 'https://github.com/preservim/nerdtree' " NerdTred
Plug 'https://github.com/jistr/vim-nerdtree-tabs' "Deprecated but I still use it
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
"Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/christoomey/vim-tmux-navigator' "Tmux keybindings
Plug 'https://github.com/Yggdroot/indentLine' "See indentation
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'} "C/C++ completion Delete if there are problems
Plug 'https://github.com/jiangmiao/auto-pairs' "C/C++ parenthesis and brackets
Plug 'https://github.com/franciscomunoz/cscope-maps' " Add cscope for source navigation

Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  } "Fuzzy finder like Ctrl-P
Plug 'junegunn/fzf.vim'
Plug 'cdelledonne/vim-cmake' "CMakePlugin


call plug#end()

"Tmux pane integration
"http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction
let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te
  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

"NerdTree
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeWinSize = 45
nnoremap <F2> :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-t> :NERDTreeToggle<CR>
"
"NerdTree tabs
let g:nerdtree_tabs_open_on_console_startup=1
"Tagbar
nnoremap <F3> :TagbarToggle<CR>
"Force to save changes in buffer
cmap w!! w !sudo tee % > /dev/null
"Remove trailing whitespaces
nnoremap <silent> <F4> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
"nnoremap <F4> :echo 'Current time is '<CR>
nnoremap <silent> <F5> : set invpaste paste?<CR>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

"See https://github.com/rafi/awesome-vim-colorschemes for more schemes
:colorscheme wombat256mod

"Indent Line
nnoremap <F6> :IndentLinesToggle<CR>

"Turn off this feature (bash plugin) that clashes with tmux
let g:BASH_Ctrl_j = 'off'
let g:BASH_Ctrl_d = 'off'

"coc
"For coc autocompleter requires nodejs > 14 and you can get it from
"https://www.stewright.me/2021/03/install-nodejs-14-on-ubuntu-20-04/
"Use a PPA to install nodejs > 14
"sudo apt install npm
"Then install yarn sudo npm install --global yarn
"Go to the plugin folder and run yarn install
"Open vim and do :CocInstall coc-clangd
"Vim will prompt you to install the following :CocCommand clangd.install will install 15.0.6
"Install build-esentials to improve completions
" use <tab> to trigger completion and navigate to the next complete item
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#completion-sources
" add the coc-json, coc-bash(in case it works)
" Edit your .vim/coc-settings.json and override to suggest.noselect: true.
" THis helps select the first entry in the menu
"
" COC-python
" Install pip3 before running the commands below
"CoCInstall coc-python, coc-jedi
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()


"autopairs C/C++ {},[], etc
"This one has interesting features. Read it later
"https://github.com/jiangmiao/auto-pairs

"fzf
"Map Ctrl-P for nostalgic reasons
nnoremap <C-P> :Files<cr>

"vim-Cmake
"https://github.com/cdelledonne/vim-cmake
"THis line creates a json that coc process
let g:cmake_link_compile_commands = 1
nmap <leader>cg :CMakeGenerate<cr>
nmap <leader>cb :CMakeGenerate<cr>



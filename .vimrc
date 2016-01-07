"The new powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'

set t_Co=256
"vertical line
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%80v.\+', -1)
endif
"Switch between vertical windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

filetype plugin indent on
syntax enable
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

syntax enable 		"enable syntax processing
set tabstop=4		"number of colums a TAB counts for
set softtabstop=4	"number of spaces in tab when editing
set expandtab		"tabs are spaces
set backspace=indent,eol,start "bs behaves like many other programs
set number		"show line numbers
set showcmd		"show command in bottom bar
set cursorline cursorcolumn		"highlight current line
filetype indent on 	"load fuletype-specific indent files
set wildmenu		"visual autocomplete for command menu
set lazyredraw		"redraw only when we need to
set showmatch 		"highlight matching [{()}]
set background=dark
colorscheme wombat256mod

"Searching
set incsearch 		"search as characters are entered
set hlsearch 		"highlight matches
"turn off search highlight
nnoremap <leader><space> : nohlsearch<CR>

"Folding
set foldenable 		    "enable folding
set foldlevelstart=10	"open most folds by default
set foldnestmax=10	    "10 nested fold max
"space open/close folds
nnoremap <space> za
set foldmethod=indent	"fold based on indent level

"Leader shortcuts
let mapleader=","	    "leader is comma
inoremap jk <esc>	    "jk is scape
nnoremap <leader>u :GundoToggle<CR>     "toggle undo
nnoremap <leader>s :mksession<CR>       "save session

"CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

execute pathogen#infect()

"NerdTree
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeWinSize = 45
map <F2> :NERDTreeToggle<CR>
"NerdTree tabs
let g:nerdtree_tabs_open_on_console_startup=1

"Tagbar
nmap <F4> :TagbarToggle<CR>

"Force to save changes in buffer
cmap w!! w !sudo tee % > /dev/null
"Remove trailing whitespaces
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <silent> <F6> : set invpaste paste?<CR>


"cscope
"No need to add something here as you edited the .vim file. See "Francisco
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

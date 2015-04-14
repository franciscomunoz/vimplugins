let g:Powerline_symbols = "fancy"
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
"set expandtab		"tabs are spaces


set number		"show line numbers
set showcmd		"show command in bottom bar
"set cursorline		"highlight current line
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


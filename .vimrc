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
set background=dark
colorscheme wombat256mod

"Searching
set incsearch 		"search as characters are entered
set hlsearch 		"highlight matches
"Folding
set foldenable 		    "enable folding
set foldlevelstart=10	"open most folds by default
set foldnestmax=10	    "10 nested fold max
"space open/close folds
nnoremap <space> za
set foldmethod=indent	"fold based on indent level

"Leader shortcuts
let mapleader="\<Space>"	    "leader is comma
inoremap jk <esc>	    "jk is scape
nnoremap <leader>u :GundoToggle<CR>     "toggle undo
nnoremap <leader>s :mksession<CR>       "save session

"Air line
"Inmediatey detected by vim
"Enabling enhanced features slows my computer
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1            "Enhanced tabline
let g:airline_theme='powerlineish'                           "Theme
"let g:airline#extensions#tabline#buffer_idx_mode = 1 "Allows to select buffer
"nmap <leader>1 <Plug>AirlineSelectTab1
"nmap <leader>2 <Plug>AirlineSelectTab2
"nmap <leader>3 <Plug>AirlineSelectTab3
"nmap <leader>4 <Plug>AirlineSelectTab4
"nmap <leader>5 <Plug>AirlineSelectTab5
"nmap <leader>6 <Plug>AirlineSelectTab6
"nmap <leader>7 <Plug>AirlineSelectTab7
"nmap <leader>8 <Plug>AirlineSelectTab8
"nmap <leader>9 <Plug>AirlineSelectTab9
"nmap <leader>- <Plug>AirlineSelectPrevTab
"nmap <leader>+ <Plug>AirlineSelectNextTab

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
nnoremap <F2> :NERDTreeToggle<CR>
"NerdTree tabs
let g:nerdtree_tabs_open_on_console_startup=1
"Tagbar
nnoremap <F3> :TagbarToggle<CR>
"Force to save changes in buffer
cmap w!! w !sudo tee % > /dev/null
"Remove trailing whitespaces
nnoremap <silent> <F4> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <silent> <F5> : set invpaste paste?<CR>

"indent line
"There is another plugin named
"git://github.com/nathanaelkane/vim-indent-guides.git
nnoremap <F6> :IndentLinesToggle<CR>
"super tab
"Complete options (disable preview scratch window)
set completeopt=longest,menuone,menu
"Enable context aware completion
let g:SuperTabDefaultCompletionType = "context"

"
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

"clang competlete for C++ Linux/Mac configurations
let os = substitute(system('uname'), "\n", "", "")
if os == "Linux"
"let g:clang_library_path='/usr/lib/x86_64-linux-gnu'
let g:clang_library_path='/usr/lib/llvm-3.8/lib/libclang.so.1'
elseif os == "Darwin"
" " Do  OSX specific stuff
    let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
endif

set conceallevel=2
set concealcursor=vin   "conceal in insert (i), normal (n) and visual (v) modes
let g:clang_snippets=1  "snippets magic on code placeholders like
                        "function argument, template parameters, etc.
let g:clang_complete_auto = 0 "Disable auto popup, use <TAB> to autocomplete
let g:clang_complete_copen = 1 "Show clang error in quick fix window
let g:clang_periodic_quickfix = 1 "Open quick fix window
let g:clang_close_preview = 1 "preview window close auto after completion
let g:clang_user_options = '-std=c++11'

filetype plugin indent on

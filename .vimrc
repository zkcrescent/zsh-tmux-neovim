" normal settings
set history=500 " max vim history remeber
" Fast saving
let mapleader = ","
nmap <leader>w :w!<cr>
set clipboard+=unnamedplus
set pastetoggle=<F3>
" Height of the command bar
set cmdheight=2
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

set fdm=syntax
set nofoldenable
set foldnestmax=1
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=120

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>
map <leader>i<leader> ysiw"
" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext
" deopelete tab-complete
" inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}


" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" map ctrl+j/k/h/l to switch panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map Y <C-d>
map T <C-u>

" map jk to esc
imap jk <Esc>

" map - to split, _ to split vertical
map <leader>- :split<cr>
map <leader>= :vsplit<cr>
map <leader>c :close<cr>

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim_tmp/undodir
    set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Set font according to system
if has("mac") || has("macunix")
    set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=IBM\ Plex\ Mono:h10,:Hack\ 10,Source\ Code\ Pro\ 10,Bitstream\ Vera\ Sans\ Mono\ 10
elseif has("linux")
    set gfn=IBM\ Plex\ Mono:h10,:Hack\ 10,Source\ Code\ Pro\ 10,Bitstream\ Vera\ Sans\ Mono\ 10
elseif has("unix")
    set gfn=Monospace\ 11
endif

set gfn=IBM\ Plex\ Mono:h10,:Hack\ 10,Source\ Code\ Pro\ 10,Bitstream\ Vera\ Sans\ Mono\ 10
" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" set status bar always show
se  laststatus=2
" Format the status line
set number
set numberwidth=3
set cpoptions+=n
set cursorline
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'NLKNguyen/papercolor-theme' " color scheme
Plugin 'Shougo/deoplete.nvim' " auto complete
Plugin 'zchee/deoplete-go'
" Plugin 'roxma/vim-hug-neovim-rpc' " deoplete dependencies
" Plugin 'roxma/nvim-yarp' " deoplete dependencies
"
" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
Plugin 'tpope/vim-fugitive' " git plugin


Plugin 'jlanzarotta/bufexplorer' " buf explorer

Plugin 'scrooloose/nerdtree'  " nerd tree
Plugin 'Xuyuanp/nerdtree-git-plugin' " nerd tree git plugin

Plugin 'fatih/vim-go' " golang plugin
" Plugin 'Valloric/YouCompleteMe' " auto complete
Plugin 'mdempsky/gocode', {'rtp': 'vim/'}

Plugin 'terryma/vim-multiple-cursors' " muti cursor

Plugin 'vim-airline/vim-airline' " top & button bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'majutsushi/tagbar' " tag bar
Plugin 'jiangmiao/auto-pairs' " auto complete brackets
Plugin 'kien/ctrlp.vim'  " file open
Plugin 'tpope/vim-surround' " change all surroundings: parentheses, brackets ,quotes, XML tags etcs.
Plugin 'easymotion/vim-easymotion' " hightlight searched words
Plugin 'airblade/vim-gitgutter' " git diff
call vundle#end()            " required
filetype plugin indent on  
" To ignore plugin indent changes, instead use:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" able airline head tab
let g:airline#extensions#tabline#enabled = 1
" set airline theme to monaka
let g:airline_theme='base16_monokai'
let g:airline#extensions#tabline#fnnamemod = ':t'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fzf 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => easy motion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap s <Plug>(easymotion-s2)

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_smartcase = 1

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nerd tree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set nerd tree auto start when no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" set F1 to toggle nerd tree
map <F1> :NERDTreeToggle<CR>
" close vim when only nerd tree open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" set F2 to toggle tag bar
nmap <F2> :TagbarToggle<CR>
""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = '<c-f>'
map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'
" ctrlp show hiden file
let g:ctrlp_show_hidden = 1

let NERDTreeIgnore = ['\.pyc$', '__pycache__']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:multi_cursor_use_default_mapping=0

" Default mapping
" let g:multi_cursor_start_word_key      = '<C-s>'
" let g:multi_cursor_select_all_word_key = '<A-s>'
" let g:multi_cursor_start_key           = 'g<C-s>'
" let g:multi_cursor_select_all_key      = 'g<A-s>'
" let g:multi_cursor_next_key            = '<C-s>'
" let g:multi_cursor_prev_key            = '<C-p>'
" let g:multi_cursor_skip_key            = '<C-x>'
" let g:multi_cursor_quit_key            = '<Esc>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => deoplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python3_host_prog="/root/.pyenv/shims/python3.6"
let g:python_host_prog="/root/.pyenv/shims/python2.7"
let g:deoplete#enable_at_startup = 1 
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode' 
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-go
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
let g:go_fmt_command = "goimports" 
let g:go_highlight_types = 1 
let g:go_highlight_function_calls = 1

let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
set autowrite
map <F4> :GoBuild <cr>
map <F6> :GoRename 
map <F7> :GoImplements <CR>
autocmd BufWritePost *go silent exec "!echo $(GO111MODULE=off go build -i 2>&1) >/dev/null"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

OOT
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" color scheme
set background=dark
colorscheme PaperColor
let g:airline#extensions#tabline#tab_nr_type= 2


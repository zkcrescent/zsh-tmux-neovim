"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""''
" plugin 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
Plugin 'tpope/vim-sensible'
" color schemes
Plugin 'NLKNguyen/papercolor-theme' 
Plugin 'vim-airline/vim-airline' " top & button bar
Plugin 'vim-airline/vim-airline-themes'

" fuzzy finder
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" work space
Plugin 'scrooloose/nerdtree'  " directory tree
Plugin 'Xuyuanp/nerdtree-git-plugin' " nerd tree git plugin
Plugin 'christoomey/vim-tmux-navigator' " Tmux intergration
Plugin 'majutsushi/tagbar' " tag bar

Plugin 'tpope/vim-fugitive' " git plugin
Plugin 'jiangmiao/auto-pairs' " auto complete brackets
Plugin 'tpope/vim-surround' " change all surroundings: parentheses, brackets ,quotes, XML tags etcs.
Plugin 'scrooloose/nerdcommenter'       " Code comment
Plugin 'terryma/vim-multiple-cursors' " muti cursor
Plugin 'junegunn/vim-easy-align' " align codes
Plugin 'honza/vim-snippets'             " common snippets 
Plugin 'iberianpig/tig-explorer.vim' " tig in vim
" Plugin 'godlygeek/tabular'
" Plugin 'Shougo/deoplete.nvim' " auto complete
" Plugin 'zchee/deoplete-go'
" Plugin 'roxma/vim-hug-neovim-rpc' " deoplete dependencies
" Plugin 'roxma/nvim-yarp' " deoplete dependencies

" completion
Plugin 'neoclide/coc.nvim',  {'do': 'yarn install --frozen-lockfile'}

" syntax 
Plugin 'benekastah/neomake'            
Plugin 'ambv/black'                     " Python formatter 
Plugin 'elzr/vim-json'                  " Better JSON syntax 
Plugin 'plasticboy/vim-markdown'        " Markdown support 
Plugin 'cespare/vim-toml'

" golang plugin
Plugin 'fatih/vim-go' 

Plugin 'easymotion/vim-easymotion' " hightlight searched words
call vundle#end()            " required
filetype plugin indent on 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""''
" display 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set bg=dark
colorscheme PaperColor
let g:airline#extensions#tabline#tab_nr_type= 2
set colorcolumn=80
set number
set showcmd
set showmatch
set numberwidth=3
set scrolloff=7  "  keep line visible when moving cursor
set ttyfast
" Don't redraw while executing macros (good performance config)
set lazyredraw
set synmaxcol=256
set guicursor=i:ver25
set cursorline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""''
" wild menu 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
        set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
        set wildignore+=.git\*,.hg\*,.svn\*
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""''
" search 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" cancel hightlight when done searching
map <silent><F10> :nohlsearch<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""''
" Key map 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
nmap <leader>w :w!<cr>
noremap <up> <nop>
noremap <left> <nop>
noremap <down> <nop>
noremap <right> <nop>
map :q :q! <CR>

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT
" Close all the buffers
map <leader>ba :bufdo bd<cr>
map <leader>i<leader> ysiw"
" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>tp :tabprevious<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""''
" coc config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" :"\<C-h>"

function! s:check_back_space() abort 
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" use `k` to search dock
nnoremap <silent> K :call <SID>show_documentation()<CR>
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

 " Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <leader>f :Format<CR>
 " Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

 let g:coc_global_extensions = [
 \ 'coc-json', 'coc-yaml',
 \ 'coc-pyls',
 \ 'coc-tsserver', 'coc-html', 'coc-css',
 \ 'coc-highlight', 'coc-snippets'
 \ ]

vmap <leader>f  <Plug>(coc-format-selected)
" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Let 'tl' toggle between this and the last accessed tab
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

imap jk <Esc>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Remap VIM 0 to first non-blank character
nnoremap j gj
nnoremap k gk
set whichwrap+=<,>,h,l


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
if mapcheck("<C-j>", ":TmuxNavigateDown") == ""
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l
endif
map Y <C-d>
map T <C-u>

" map jk to esc

" map - to split, _ to split vertical
map <leader>- :split<cr>
map <leader>= :vsplit<cr>
map <leader>c :close<cr>
function! GetBufferList()
    redir => buflist
    silent! ls!
    redir END
    return buflist
endfunction
function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec('botright '.a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>L :call ToggleList("Location", 'l')<CR>
set diffopt=vertical

set pastetoggle=<F3>
" Height of the command bar
set cmdheight=10
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => copy paste
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <C-c> "*yy
nmap <C-v> "*p
imap <C-v> <Esc><C-v>a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add newline
nnoremap <CR> o<ESC>
vnoremap > >gv
vnoremap < <gv
"normal settings
set history=500 " max vim history remeber
set maxmempattern=2000000
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
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  tmux navagator
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tmux_navitgator_no_mappings = 1
let g:tmux_navitgator_save_on_switch = 1
if has('nvim') 
    nmap <bs>: <c-u> TmuxNavigateLeft<CR>
endif
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
nnoremap <leader>a :Ag<CR>
nnoremap <C-p> :GFiles<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tig 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>T :TigOpenProjectRootDir<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => easy motion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" nerd tree auto start when no file specified
"autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" set F1 to toggle nerd tree
map <F1> :NERDTreeToggle<CR>
" close vim when only nerd tree open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDSpaceDelims = 1
map <leader>n <Plug>NERDCommenterToggle
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tag bar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set F2 to toggle tag bar
nmap <F2> :TagbarToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_exit_from_insert_mode = 0
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
" => vim-markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-go
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
let g:go_fmt_command = "goimports" 
let g:go_highlight_types = 1 
let g:go_highlight_function_calls = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_fmt_fail_silently = 1
map <F4> :GoBuild <cr>
map <F6> :GoRename 
map <F7> :GoImplements <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't close window, when deleting a buffer


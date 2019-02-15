" Settings

set nocompatible
filetype off
let mapleader=" "

" Tabs/Spaces
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set smarttab
set ai
set si
set autoindent
set copyindent

" Misc
set backspace=indent,eol,start
set number
set shiftround
set wrap
set showmatch
set ignorecase
set smartcase
set hlsearch
set incsearch

" Disable preview window from showing
set completeopt-=preview

" change split window styling
highlight VertSplit cterm=NONE

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo

set undolevels=1000
set undoreload=10000

" Update Time for git gutters to appear
set updatetime=100

" Go to root of project to search
cnoreabbrev ag Gcd <bar> Ack!

" not forced so save when switching buffers
set hidden

" Colors
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set background=dark

 " ctags optimization
 set autochdir
 set tags=tags

"folding
set foldmethod=syntax

" all folds open as default when opening new file
set nofoldenable

" Vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'

Plugin 'Raimondi/delimitMate'

Plugin 'marijnh/tern_for_vim'

Plugin 'mattn/emmet-vim'

Plugin 'scrooloose/nerdTree'

Plugin 'editorconfig/editorconfig-vim'

Bundle 'geoffharcourt/vim-matchit'

Plugin 'w0rp/ale'

Plugin 'pangloss/vim-javascript'

Plugin 'mxw/vim-jsx'

Plugin 'vim-airline/vim-airline'

Plugin 'mileszs/ack.vim'

Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'tpope/vim-fugitive'

Bundle 'matze/vim-move'

Plugin 'airblade/vim-gitgutter'

call vundle#end()
filetype plugin indent on

" YouCompleteMe settings
set omnifunc=syntaxcomplete#Complete
let g:ycm_confirm_extra_conf = 0

" ale config
let g:ale_sign_error = '->' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" matchit/ctags
runtime macros/matchit.vim
set tags=./tags,tags;$HOME

" have vim-jsx run on jsx and js files
let g:jsx_ext_required = 0

" make matchit work on C-like filetypes
" " c and cpp are already handled by their ftplugin
au Filetype css,javascript
      \ let b:match_words = &matchpairs

" Use C-n to open/close Nerdtree
map <silent> <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 40
 
" ctrl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'node_modules\|static'

" double semi to insert semi-colon at end of line
nnoremap ;; m`A;<Esc>``

" double comma to insert comma at end of line
nnoremap ,, mnA,<Esc>`n

" double quotes around word
nnoremap "" mnbi"<Esc>ea"<Esc>`n`]]

" single quotes around word
nnoremap '' mnbi'<Esc>ea'<Esc>`n`]]

" space-c for console.log
nnoremap <Leader>c oconsole.log()<Esc>i''<Esc>i

" space-c-color for colored logging in terminal
" red
nnoremap <Leader>cr oconsole.log('\x1b[31m','','\x1b[0m');<Esc>4F'a
" blue
nnoremap <Leader>cb oconsole.log('\x1b[34m','','\x1b[0m');<Esc>4F'a
" green
nnoremap <Leader>cg oconsole.log('\x1b[42m','','\x1b[0m');<Esc>4F'a

" indent entire page
nnoremap <Leader>i gg=G<C-o><C-o><C-d>

" create blank line in normal mode
nnoremap <silent> zk o<Esc>k
nnoremap <silent> zj O<Esc>j

" \\ to clear word search highlighting
nnoremap \\ :noh<return><esc>

" ff to close buffer
nnoremap ff :bd!<return><esc>

" double // to comment lines in visual block
vnoremap // :normal mnI// <Esc>`n

" eslint whole file
map <Leader>e :!eslint % --fix<CR>

" space-/ to uncomment lines in visual
vnoremap <Leader>/ :normal mn^xxx`n<CR>

" register re-mappings
nnoremap <Leader>p "+p
vnoremap <Leader>y "+y

" Remap normal mode to fj
inoremap fj <ESC>
inoremap <ESC> <NOP>
vnoremap fj <ESC>
vnoremap <ESC> <NOP>

" ack settings - dont auto open first result
cnoreabbrev ack Ack!

" skip one letter to the right in insert mode
inoremap jj <Esc>

" search through project with word currently under cursor
map <F4> :execute "Ack! '" . expand("<cword>") . "'"<CR>

" use ag with ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Airline config
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

" show hidden files in NERDTree
let NERDTreeShowHidden=1

" move lines up and down using ctrl j or ctrl k
let g:move_key_modifier = 'C' 

syntax enable

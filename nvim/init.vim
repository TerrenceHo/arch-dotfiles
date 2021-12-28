set nocompatible
let mapleader = ";"

let g:python3_host_prog = '/usr/bin/python'  

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ----- Plugins -----
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-easy-align' "Easy alignment of text
Plug 'tpope/vim-repeat' 
Plug 'tpope/vim-surround' " Surround text
Plug 'tpope/vim-commentary' "Comment code easily

" Visual
Plug 'romgrk/doom-one.vim' "doom theme
Plug 'vim-airline/vim-airline' "airline
Plug 'bling/vim-bufferline' "Shows buffers on airline
Plug 'vim-airline/vim-airline-themes' "Themes for airline

Plug 'junegunn/fzf.vim' "Fuzzy Search

" Writing
Plug 'junegunn/goyo.vim' "Distraction free writing
Plug 'junegunn/limelight.vim' "Highlights current line

" Tmux Integration
Plug 'christoomey/vim-tmux-navigator' "navigate tmux/vim splits easily

call plug#end()

" ----- Tabs/Spacing -----
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
set autoindent 
set textwidth=80
set fileformat=unix
set backspace=indent,eol,start

" ----- UI -----
filetype plugin indent on
syntax on
set lazyredraw
set hidden
set updatetime=500
set relativenumber
set number
set showcmd
" set cursorline
set showmatch
set wildmenu
set cmdheight=2

" Make vim resize when host is resized
:autocmd VimResized * wincmd =

" ----- Splits -----
set splitbelow
set splitright
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ----- Copying -----
set clipboard=unnamed
set pastetoggle=<F2>

" ----- Searching -----
set ignorecase
set incsearch
set hlsearch

" ----- Folding -----
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" ----- Brackets -----
inoremap {<cr> {<cr>}<c-o>O
inoremap [<cr> [<cr>]<c-o>O<tab>
inoremap (<cr> (<cr>)<c-o>O

" ----- Keybindings -----
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffer<CR>
nnoremap <leader>d :bd<CR>

nnoremap <leader>s :w<CR>
nnoremap <leader>l :nohlsearch<CR>
nnoremap <C-C> <C-A>

" ----- Last Position -----
function! PositionCursonFromViminfo()
    if !(bufname("%") =~ '\(COMMIT_EDITMSG\)') && line("'\"") > 1 && line("'\"") <= line("$") 
        exe "normal! g`\"" 
    endif
endfunction
au BufReadPost * call PositionCursonFromViminfo()

" ----- Colors -----
syntax on
syntax enable
let g:doom_one_terminal_colors = v:true
highlight VertSplit cterm=None

" ----- File Types -----
" Git Commits
au FileType gitcommit set tw=72

" Makefiles
autocmd BufEnter ?makefile* set include^s\=include
autocmd BufLeave ?makefile* set include&

" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" ----- Airline -----
set laststatus=2
set ttimeoutlen=50
let g:airline#extensions#branch#enabled=1

" ----- fzf -----
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'down': '40%' }

" ----- Easy Align -----
xmap ga <Plug>(EasyAlign)

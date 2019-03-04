" My vim/neovim setup based on rstacruz/vim-from-scratch repo
" Keybindings, aliases, plugin configurations and further options defined in 
" .vim/after/plugin directory files
" Carlos Oliveira - carlosado@brainbox

" ---- On an basic Arch system use Arch defaults ----
runtime! archlinux.vim

" ---- tentative leader maping ----
"let g:mapleader = "\<Space>"

" ------------- Ok. Let's Plug it -------------
" ---- Use Plug-vim for plugins population ----
call plug#begin('~/.vim/vendor')

" ---- Initial setup copied from rstacruz ----
if !has('nvim') && !exists('g:gui_oni') | Plug 'tpope/vim-sensible' | endif
Plug 'rstacruz/vim-opinion'             "rstcruz vim options edited

" ---- Language related plugins ----
Plug 'scrooloose/nerdcommenter'         "Control your code comments
Plug 'sheerun/vim-polyglot'             "All language packs you'll need
"Plug 'vim-ruby/vim-ruby'
"Plug 'rust-lang/rust.vim'

" ---- Completion related plugins ----
Plug 'valloric/youcompleteme', { 'do': './install.py --all' }  "Code completion
Plug 'mattn/emmet-vim'                  "Expand abreviations on HTML/CSS code

" ---- Code display related plugins ----
Plug 'tpope/vim-surround'               "Quoting and parenthesizing made simple
Plug 'nathanaelkane/vim-indent-guides'  "Visual display indenting levels
Plug 'morhetz/gruvbox'                  "Colorscheme
"Plug 'chriskempson/base16-vim'          "Colorscheme
"Plug 'tomasr/molokai'                   "Colorscheme

" ---- Integration related plugins ----
Plug 'w0rp/ale'                         "Asynchronous linting/fixing
Plug 'tpope/vim-fugitive'               "A Git wrapper for vim
Plug 'tpope/vim-sleuth'                 "An autoindent engine

" ---- Interface related plugins ----
Plug 'itchyny/lightline.vim'            "A light configurable statusline
Plug 'airblade/vim-gitgutter'           "Shows a git diff sign in the gutter
Plug 'junegunn/goyo.vim'                "Distraction free writing in vim
Plug 'junegunn/limelight.vim'           "Paragraph focus when in goyo
Plug 'reedes/vim-pencil'                "A tool for normal writing

" ---- Command plugins ----
Plug 'shougo/neomru.vim'                "Plugin of MRU plugin
Plug 'vim-scripts/mru.vim'              "Manage Most Recent Used files
Plug 'scrooloose/nerdtree'              "The filesystem explorer
Plug 'junegunn/fzf.vim'                 "Filesystem fuzzy searching

call plug#end()
